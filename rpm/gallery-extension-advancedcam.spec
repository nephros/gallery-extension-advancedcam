# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.32
# 

Name:       gallery-extension-advancedcam

# >> macros
# << macros

Summary:    Gallery plugin for Advanced Camera
Version:    0.9.0
Release:    0
Group:      Qt/Qt
License:    GPLv2
URL:        https://to-be-defined.local/
Source0:    %{name}-%{version}.tar.gz
Source100:  gallery-extension-advancedcam.yaml
Requires:   sailfish-components-gallery-qt5
BuildRequires:  libsailfishapp-devel
BuildRequires:  qt5-qmake
BuildRequires:  qml-rpm-macros

%description
%{summary}.

%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%configure --disable-static
make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%make_install

# >> install post
# << install post

%files
%defattr(-,root,root,-)
# >> files
# << files
