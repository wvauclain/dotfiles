if [ "$HOSTNAME" = "novastorm" ]; then
    AddPackage aws-cli # Universal Command Line Interface for Amazon Web Services
    AddPackage dash # POSIX compliant shell that aims to be as small as possible
    AddPackage docker # Pack, ship and run any application as a lightweight container
    AddPackage git-crypt # Transparent file encryption in Git
    AddPackage iotop # View I/O usage of processes
    AddPackage jq # Command-line JSON processor
    AddPackage postgresql # Sophisticated object-relational DBMS
    AddPackage python-black # Uncompromising Python code formatter
    AddPackage python-pre-commit # A framework for managing and maintaining multi-language pre-commit hooks
    AddPackage qtkeychain # Provides support for secure credentials storage

    IgnorePath '/etc/docker/*'
    IgnorePath '/opt/containerd/*'
    CreateLink /etc/systemd/system/multi-user.target.wants/docker.service /usr/lib/systemd/system/docker.service
    CopyFile /usr/bin/nomad 755
    CopyFile /usr/bin/terraform 755
fi
