Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C190C5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F9810E395;
	Tue, 18 Aug 2026 08:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W0aj1v+m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9F710E395
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:54:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EFF243685
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7132CC2BCF4
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787043255;
 bh=7RRBxpnJqYU+3vDkU1hfL0ri9bG4ewZdTwRYNe/FNsE=;
 h=From:To:Subject:Date:From;
 b=W0aj1v+meTRb1ZIGNuS/IrBeiGPaTAPje0rE1yVFiBE/xBrm7VLPXusBVnBlP/tOv
 IhZjPDkW78oOnMjOhfRtsd67aB4Q46MyNHA/24DTuq6Wj0L8MenMr7Vh9mnQTdL/Cm
 vX2XtyHiNTDpBD+8f6jhZQF0zHjfA3tAKuwzblUOr+qnzQZA959B40lGE8ze1YWHVO
 Wp+PQmK16Px5LEkwMsYbFwWPpADSwjZYFuMdGcI9dVgh71WPVyvAH4w4KClI2fKIY4
 Yi67/aGqQvXeo32jE2UQO7ttIrVO0S98kmLCjlukKBxSDgseJFg6hqfHwGPdMkbMsW
 bhT7z0ahC8JLA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 52EC9C53BBF; Tue, 18 Aug 2026 08:54:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221897] New: [Regression] Half screen renders black with active
 cursor after upgrading to linux-firmware
 20240318.git3b128b60-0ubuntu2.29
Date: Tue, 18 Aug 2026 08:54:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: sylvain.mfalt@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression cf_bisect_commit
 attachments.created
Message-ID: <bug-221897-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221897

            Bug ID: 221897
           Summary: [Regression] Half screen renders black with active
                    cursor after upgrading to linux-firmware
                    20240318.git3b128b60-0ubuntu2.29
           Product: Drivers
           Version: 2.5
    Kernel Version: 7.0.0-29-generic
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: sylvain.mfalt@gmail.com
        Regression: Yes
           Bisected 20240318.git3b128b60-0ubuntu2.27 ->
         commit-id: 20240318.git3b128b60-0ubuntu2.29

Created attachment 310684
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310684&action=3Dedit
half screen is black

Hi I used AI to cleanup my mess of a report here's what it gave me, the AI
added info I'm not familliar with but if that helps you I let it inside (the
plane thingy).

[Problem Description]
After updating linux-firmware to version 20240318.git3b128b60-0ubuntu2.29, =
the
right half of the primary monitor turns completely black (it was vertical l=
ines
blue, green and black at some point too) upon booting into GNOME (Wayland).=
=20
- Hardware failure ruled out: Live USB, BIOS, and software screenshots all
render normally.
- Software composition issue: The mouse cursor remains visible and moves fr=
eely
over the blacked-out region, indicating the hardware overlay plane receives
signal, but the desktop framebuffer fails to render on that panel region.

[Steps to Reproduce]
1. Boot Ubuntu 24.04 with linux-firmware version
20240318.git3b128b60-0ubuntu2.29.
2. Log into GNOME desktop session.
3. Observe half of the display panel dropping output to black.

[Bypass / Confirmed Fix]
Downgrading linux-firmware back to version 20240318.git3b128b60-0ubuntu2.27
immediately resolves the issue:
0. wget
https://snapshot.ubuntu.com/ubuntu/20260801T000000Z/pool/main/l/linux-firmw=
are/linux-firmware_20240318.git3b128b60-0ubuntu2.27_amd64.deb
1. Installed linux-firmware_20240318.git3b128b60-0ubuntu2.27_amd64.deb.
2. Ran `sudo update-initramfs -u` and rebooted.
3. Full screen rendering restored instantly.

[hostnamectl]
Operating System: Ubuntu 24.04.4 LTS=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
          Kernel: Linux 7.0.0-29-generic
    Architecture: x86-64
 Hardware Vendor: Gigabyte Technology Co., Ltd.
  Hardware Model: Z790 AORUS ELITE AX
Firmware Version: FC
   Firmware Date: Tue 2023-03-07
    Firmware Age: 3y 5month 1w 5d

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
