Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2D5C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3226D10EFED;
	Wed,  5 Aug 2026 21:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QG604EGK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5545410EFED
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:20:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3EEA843915
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 217AEC19425
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785964841;
 bh=Pk2hZUksDyFrhN6oEJEkudP14bFcT8jmDxRs1dtce68=;
 h=From:To:Subject:Date:From;
 b=QG604EGKSpIZ/NLoE4RLSTM10z1Z53hh+jUA97obCd2SJsVKc6k1e4vjAkurKvDJa
 J3HjJUQTO+hgCphnM98BUOSUe8sc8qX3LCiJsVosNszP5agqSj8wUskXyjzF0UUoEa
 fZq35t8gzL7NuL4qX4fM8j1pSEvajbxW+QAd6mD+X+pi12KU4W/yeGI3uWOJsvyfY1
 vp+qOrx/oSzh5oRchqGd/u9l66g356lwVpLU8CDOPRC7P9h8BrV4iI6H5RgCAVQogl
 n5/3vjYYXClyvhfukGLz142HnFEQqI83kSa5PigFIKtCVB87t9y7Joh4VpnwbycVIU
 3lliAufv4wnGw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 05793C41612; Wed,  5 Aug 2026 21:20:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221838] New: [Regression] Black screen / no backlight on resume
 from suspend in kernel 7.0.0-28-generic (Dell Precision M4800,
 Optimus Intel + Quadro K1100M on nouveau)
Date: Wed, 05 Aug 2026 21:20:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ekonom1@atlas.sk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221838-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D221838

            Bug ID: 221838
           Summary: [Regression] Black screen / no backlight on resume
                    from suspend in kernel 7.0.0-28-generic (Dell
                    Precision M4800, Optimus Intel + Quadro K1100M on
                    nouveau)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: ekonom1@atlas.sk
        Regression: No

Created attachment 310579
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310579&action=3Dedit
Full system diagnostics including current dmesg, acpidump, lspci, lsusb, and
kernel logs

More info about bug on link
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2161214

Hi, I am experiencing a regression in the latest Ubuntu kernel package.

**Hardware & GPU details:**
- Laptop: Dell Precision M4800
- iGPU: Intel Corporation 4th Gen Core Processor Integrated Graphics Contro=
ller
- dGPU: NVIDIA Corporation GK107GLM [Quadro K1100M] (rev a1)
- Driver in use: 'nouveau' (open-source kernel driver)
- OS: Kubuntu 26.04 (Wayland)

**Symptoms:**
When waking up the laptop from suspend, the screen remains pitch black (no
backlight turns on). The system is actually responsive in the background: w=
hen
I press my FIDO2 security key, it blinks, I can authenticate and the system
unlocks, but the display output/backlight remains completely dead.

**Regression confirmation:**
- Kernel 7.0.0-28-generic: BROKEN (reproducible every time on resume, black
screen)
- Kernel 7.0.0-27-generic: OK (works perfectly, screen wakes up immediately=
 on
resume)
Since only the kernel version was changed and Mesa/KWin remained the same, =
this
is a clear kernel regression in the DRM/nouveau/i915 subsystem.

ProblemType: Bug
DistroRelease: Ubuntu 26.04
Package: linux-image-7.0.0-28-generic 7.0.0-28.28
ProcVersionSignature: Ubuntu 7.0.0-28.28-generic 7.0.12
Uname: Linux 7.0.0-28-generic x86_64
ApportVersion: 2.34.0-0ubuntu2
Architecture: amd64
CasperMD5CheckResult: unknown
CurrentDesktop: KDE
Date: Sat Jul 18 22:38:20 2026
InstallationDate: Installed on 2026-04-28 (81 days ago)
InstallationMedia: Kubuntu 26.04 "Resolute Raccoon" - Release amd64 (202604=
23)
IwDevWlp3s0Link: Not connected.
MachineType: Dell Inc. Precision M4800
ProcFB: 0 i915drmfb
ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-7.0.0-28-generic
root=3DUUID=3D0865911a-d995-4fff-b0d8-34f3e26f1603 ro quiet splash
PulseList: Error: command ['pacmd', 'list'] failed with exit code 1: No
PulseAudio daemon running, or not running as session daemon.
SourcePackage: linux
UpgradeStatus: No upgrade log present (probably fresh install)
WifiSyslog:

dmi.bios.date: 10/08/2018
dmi.bios.release: 65.25
dmi.bios.vendor: Dell Inc.
dmi.bios.version: A25
dmi.board.name: 0V5GVY
dmi.board.vendor: Dell Inc.
dmi.board.version: A00
dmi.chassis.type: 9
dmi.chassis.vendor: Dell Inc.
dmi.modalias:
dmi:bvnDellInc.:bvrA25:bd10/08/2018:br65.25:svnDellInc.:pnPrecisionM4800:pv=
r00:rvnDellInc.:rn0V5GVY:rvrA00:cvnDellInc.:ct9:cvr:sku05CC:pfa:
dmi.product.name: Precision M4800
dmi.product.sku: 05CC
dmi.product.version: 00
dmi.sys.vendor: Dell Inc.
***************
INTRODUCTION AND FOCUS OF THE BUG REPORT (BUG REPORT, LINUX KERNEL, KUBUNTU)
First, a quick note for the AI to ensure this transcription is correct: thi=
s is
a bug report regarding the Linux kernel on Kubuntu. Now, I will proceed to =
the
report itself.

Dear developers, I would be very grateful if you could fix this bug. I real=
ize
that my computer is very, very old. That is one thing, but on the other han=
d,
Linux distributions are generally designed to support older hardware as wel=
l.
Therefore, I hope you will be willing to resolve this issue.

NON-STANDARD SYSTEM SETTINGS AND SECURITY (FSCRYPT, SYSTEMD-HOMED, FINGERPR=
INT)
It is true that I have a slightly non-standard setup on Kubuntu. I have an
encrypted home directory using fscrypt, and I also use systemd-homed with
fingerprint authentication to unlock the computer and the login screen. It =
is
actually fortunate that I use this option=E2=80=94these fingerprints=E2=80=
=94because it made it
much easier to identify the bug and pinpoint where the error stems from. I =
can
assure you with absolute certainty, indeed with 100% confidence, that this =
is
related to the Linux kernel, specifically something in the graphics departm=
ent,
most likely the graphics drivers.

BUG BEHAVIOR AND SYMPTOMS (BRIGHTNESS REGULATION, BLACK SCREEN, SLEEP MODE,
FIDO2)
It is important to supplement this bug report with additional information:
whenever the very latest version of the Linux kernel is installed, it is
accompanied by other symptoms. Specifically, I am unable to regulate the sc=
reen
brightness; it is permanently stuck, I believe, at the absolute lowest
brightness level. Furthermore, as soon as I suspend the computer and wake it
back up, the screen is 100% black, as if the computer were completely turned
off and fails to turn on at all. We can reliably identify this as a
graphics-related issue because, by looking at the flashing of the FIDO2
security key, it is possible to deduce and conclude that I have successfully
logged in. There are LEDs on it that clearly signal when a successful login=
 has
occurred. Thus, everything was working completely fine, except for the sing=
le
fact that the screen remained black the entire time.

THANKS TO THE DEVELOPERS AND CONCLUSION (BUG FIX, SUPPORT, THANKS)
So, dear developers, I wish you success in fixing this. May it cost you as
little work as possible, bring a great benefit, and may you manage to fix i=
t as
quickly as possible with minimal effort. That is my wish for you. I wish you
the best of luck and thank you, developers, for your hard work.

Additionally, as a piece of supplementary information, I personally believe
that slightly non-standard configurations, such as home directory encryption
via systemd-homed, should not play a large or significant role in this issu=
e.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
