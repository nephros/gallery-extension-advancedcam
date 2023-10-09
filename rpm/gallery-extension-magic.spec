# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.32
# 

Name:       gallery-extension-magic

# >> macros
# << macros

Summary:    Gallery plugin for automagic paths
Version:    0.9.4
Release:    0
Group:      Qt/Qt
License:    GPLv2
BuildArch:  noarch
URL:        https://github.com/nephros/gallery-extension-advancedcam
Source0:    %{name}-%{version}.tar.gz
Source100:  gallery-extension-magic.yaml
Source101:  gallery-extension-magic-rpmlintrc
Requires:   sailfish-components-gallery-qt5 >= 1.1.9
BuildRequires:  qt5-qmake
BuildRequires:  qt5-qttools-linguist
BuildRequires:  sailfish-svg2png
BuildRequires:  qml-rpm-macros

%description
%{summary}.

%if "%{?vendor}" == "chum"
Title: Magic Gallery Extension
Type: desktop-application
DeveloperName: Peter G.
DeveloperLogin: nephros
Categories:
 - Media
Custom:
  Repo: %{url}
Screenshots:
 - %{url}/raw/screenshots/Screenshot001.png
 - %{url}/raw/screenshots/Screenshot002.png
 - %{url}/raw/screenshots/Screenshot003.png
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
pushd icons
%qmake5
%qmake5_install
popd
# << install post

%files
%defattr(-,root,root,-)
%license LICENSE
%{_datadir}/jolla-gallery/mediasources/*.qml
%{_datadir}/translations/*.qm
%{_datadir}/themes/*/*/*/*/*.png
%{_libdir}/qt5/qml/com/jolla/gallery/magic
# >> files
# << files
