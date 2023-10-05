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
URL:        https://github.com/nephros/gallery-extension-advancedcam
Source0:    %{name}-%{version}.tar.gz
Source100:  gallery-extension-advancedcam.yaml
Source101:  gallery-extension-advancedcam-rpmlintrc
Requires:   sailfish-components-gallery-qt5
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(sailfishapp)
BuildRequires:  qt5-qmake
BuildRequires:  qt5-qttools-linguist
BuildRequires:  qml-rpm-macros

%description
%{summary}.

%if "%{?vendor}" == "chum"
Title: Gallery Extension for Piggz-o-vision
Type: desktop-application
DeveloperName: Peter G.
DeveloperLogin: nephros
Categories:
 - Media
Custom:
  Repo: %{url}
PackageIcon: %{url}/master/icons/%{name}.svg
Screenshots:
 - %{url}/raw/metadata/screenshots/screenshot1.png
 - %{url}/raw/metadata/screenshots/screenshot2.png
 - %{url}/raw/metadata/screenshots/screenshot3.png
Links:
  Homepage: %{url}
  Help: %{url}/discussions
  Bugtracker: %{url}/issues
  Donation: https://openrepos.net/donate
%endif


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qmake5 

make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

%files
%defattr(-,root,root,-)
%license LICENSE
%{_datadir}/jolla-gallery/mediasources/%{name}
# >> files
# << files
