ips = {
    'farnarkle1' => '136.186.1.99',
    'farnarkle2' => '136.186.1.100',
    'tooarrana1' => '136.186.1.203',
    'tooarrana2' => '136.186.1.204',
    'data-mover01' => '136.186.1.158',
    'data-mover02' => '136.186.1.159',
    'data-mover03' => '136.186.1.102',
    'data-mover04' => '136.186.1.196'
}

ozstar_ips = [ips['farnarkle1'], ips['farnarkle2']]
nt_ips = [ips['tooarrana1'], ips['tooarrana2']]

control 'dns-resolution' do
    impact 1.0
    title 'Check DNS resolution for individual hosts'

    ips.each do |host, ip|
        describe command("nslookup #{host}.hpc.swin.edu.au") do
            its('stdout') { should match /Name:\s#{host}.hpc.swin.edu.au\nAddress: #{ip}/ }
        end
    end
end

control 'dns-round-robin-ozstar' do
    impact 1.0
    title 'Check round-robin DNS for OzStar IPs'

    ozstar_ips.each do |ip|
        describe command("nslookup ozstar.swin.edu.au") do
            its('stdout') { should match /Address: #{ip}/ }
        end
    end
end

control 'dns-round-robin-nt' do
    impact 1.0
    title 'Check round-robin DNS for NT IPs'

    nt_ips.each do |ip|
        describe command("nslookup nt.swin.edu.au") do
            its('stdout') { should match /Address: #{ip}/ }
        end
    end
end