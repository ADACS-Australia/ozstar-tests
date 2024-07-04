websites = [
    'https://supercomputing.swin.edu.au',
    'https://supercomputing.swin.edu.au/docs/',
    'https://supercomputing.swin.edu.au/rcdocs/',
    'https://supercomputing.swin.edu.au/account-management/',
    'https://supercomputing.swin.edu.au/monitor/',
]

websites.each do |url|
    control "#{url}-accessibility" do
        impact 1.0
        title "Check if the #{url} website is accessible"

        describe http(url) do
            its('status') { should cmp 200 }
        end
    end
end
