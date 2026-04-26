Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C745AFF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 23:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD0010E064;
	Sun, 26 Apr 2026 23:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FhwWfqj6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B8E10E064
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:25:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A0D0B41B5B
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FEE2C2BCAF
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777245909;
 bh=QifPQf8+5NxABBgQgM8wtBwRPNP/WA950jJpTMJ0Jp0=;
 h=From:To:Subject:Date:From;
 b=FhwWfqj6G+DqOATzJZRHDxtBk+17XCBjJpwETHeTvVCxTHRH2GDnyOD7c0E6N1zjX
 I6CQ9JCf8A7OzbaHjiIztWP145x3VhCqF4T+dBHqU27/79AjV2gOYkgeS8aEDrsiio
 c7fD3WdOn2RqKPFVmNPDRDUyW8iXtrK+6JHxx1btoeagTH11H/ktieaYwJctvwpoDv
 Q5nik+fgMYxpOM5sj9ElGQygvMHKUOGXCMhj6fUswWK5Izvh493a5YGKzxFhrRNnG+
 AQI9k0upbpn1FQX4qW2MOC2nf7HE2mhDm/IjBEQF6vwpLBlmYYAuYuZpkk14hzqGNN
 3KZF76YfGq+AQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 713EFC3279F; Sun, 26 Apr 2026 23:25:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221421] New: amdgpu fails to display anything after resume from
 S3 suspend
Date: Sun, 26 Apr 2026 23:25:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 0456523@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221421-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221421

            Bug ID: 221421
           Summary: amdgpu fails to display anything after resume from S3
                    suspend
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: 0456523@gmail.com
        Regression: No

Hardware:
    Machine: Dell Inspiron 15 3525
    CPU:     AMD Ryzen 7 5825U
    GPU:     AMD Barcelo [Integrated]
    RAM:     16GB (2x8GB) of RAM, 32GB of swap
    Distro:  Arch Linux
Current kernel version: 6.19.14

This laptop originally did not advertise S3 sleep support in the DSDT. S0ix=
 was
chewing up my battery so I followed a guide like this
(https://dev.to/epassaro/fix-suspend-issues-on-dell-7405-2-in-1-3l1b) to pa=
tch
S3 sleep back in. I still have the files from back when I did that if they =
are
needed. Another issue is that the touchpad also will immediately wake the
laptop back up with no interaction (which I fixed with a udev rule that mat=
ches
the touchpad by name and sets ATTR{power/wakeup}=3D"disabled"), but that's a
separate issue.

Steps to reproduce and what happens:
    1. Start up
    2. Log in to TTY
    3. Run systemctl suspend
    4. Display goes black and backlight turns off, and the system goes to s=
leep
    5. Wake the system up by hitting a key
    6. System wakes up
    7. Backlight turns on
    8. Display remains black

This only happens when resuming from S3 sleep and does not happen when resu=
ming
from S0ix or hibernation.

There are a few things that worked or used to work to restore the image on =
the
display:
Connecting an external display will produce an image on the external display
just fine, and changing the resolution of the main display worked in restor=
ing
the image to it last time I tried, but having to grab my spare monitor out =
of
the closet and hook it up is a massive pain.
Doing sudo cat /sys/kernel/debug/dri/128/amdgpu_gpu_recover used to work
sometimes, but it seems to now have no effect other than toggling the backl=
ight
off then back on.

I have also tried passing in acpi.prefer_microsoft_guid=3D1 and
amdgpu.dcdebugmask=3D0x10 during boot but neither had any effect at all (go=
od or
bad). I checked the kernel logs and there does not seem to be any obvious
errors (amdgpu-related or not) when suspending and resuming.

This is a massive pain since S0ix or hibernation are the only 2 ways to avo=
id a
black screen on resume, but S0ix is unusably power-draining, and hibernatio=
n is
still considerably slower than it is on Windows.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
