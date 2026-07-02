Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6B7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3D910E50A;
	Thu,  2 Jul 2026 21:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RxT5fF5O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D039410E50A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 21:02:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 49FBC43726
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 21:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2352EC19425
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 21:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783026142;
 bh=ZnHC+evi7eWWC8wZsnIpF1pPaOv0E92RsZf0FNHKT8k=;
 h=From:To:Subject:Date:From;
 b=RxT5fF5OzBFhRvMtMJAfxMOnb9tEirdsWVwBrrda/rplDdP0ETX+PwXPAzSTp8VoK
 M0PfpuhWWhwSktm4fMOUT0j4tS8762ehD8hWy/0HlSUoF4n47MVHISUFbuXseZRp8Q
 3Y7VWpyRwCWQjlZX4oWeFJy72lQilxfjOTuxcD1wpZNb3p2qhD0VoCiIIbe/bUb39Y
 Sun4d+tJxvSf5zTmqf7iwTgDzazJttfFWjP9TjKcJPThBBRmGHQ8bVvdJEu3eFw8qs
 EoEi7XG66km6orYma+SRtyV410I1qVV3qKeYAGXnN5MZj3S/0WHrrq5Jii1IXTuwe+
 rdERsf7hKy1aQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 03F63C41613; Thu,  2 Jul 2026 21:02:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221714] New: AMDGPU: Firmware issue on Teros TE-2476G monitor
 causes black screen/instability with FreeSync and invalid EDID.
Date: Thu, 02 Jul 2026 21:02:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: MANCHOIG@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221714-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221714

            Bug ID: 221714
           Summary: AMDGPU: Firmware issue on Teros TE-2476G monitor
                    causes black screen/instability with FreeSync and
                    invalid EDID.
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: MANCHOIG@gmail.com
        Regression: No

Description:
The Teros TE-2476G monitor (23.8" 144Hz) fails to properly initialize on the
amdgpu driver. The monitor firmware appears to report a null serial number
(00000000) and fails to negotiate high refresh rates (144Hz) when FreeSync =
is
active. This results in intermittent black screens or a fallback to 60Hz.

System Info:

    GPU: AMD Radeon RX 580

    Driver: amdgpu

    Kernel:  7.1.2-3-cachyos

    Distribution: Arch Linux / CachyOS

Steps to reproduce:

    Connect Teros TE-2476G via DisplayPort.

    Enable default FreeSync/VRR settings.

    System fails to consistently maintain 144Hz link or causes display sign=
al
loss.

Workaround:
The issue is mitigated by disabling FreeSync via kernel parameter
(amdgpu.freesync_video=3D0) and forcing the monitor mode using
video=3DDP-1:1920x1080@144 in the bootloader command line.

Expected behavior:
The amdgpu driver should handle the monitor's invalid EDID gracefully or
provide a "quirk" to ignore the missing serial number and allow stable 144Hz
operation without requiring manual cmdline overrides.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
