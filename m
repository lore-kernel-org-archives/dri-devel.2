Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6F8CD98C5
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 18:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D14D10E282;
	Sat, 13 Jun 2026 18:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="seKu/2Rt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A4F10E282
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 18:37:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 51554403A3
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 18:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30581C2BCB9
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781375877;
 bh=eKtiGGgAMzG3YzK9gm8g8zqho2kt8aOqWuTuyV8SYv4=;
 h=From:To:Subject:Date:From;
 b=seKu/2Rty70akX9rBrzJDl8S2N9Q9/HeyNAlpVDryMCfMU9SvUHxlRiYwripmJWso
 qPK2OUhh1B1T/Nj+mjEjfFX+iaYPAwBz9APmXCXIHLBmk3RaCFSSPzg42JFsCV9gM6
 BT5FAfQt/WZwTJ2Lvda0okZMsqd9UiTlaCdyeXfMDcQ1PkxAh8IQ8YGeUegcVYq46m
 690oOtkrHKx9lN1Ezbr0KSvz88BYMgX+CM0k4FdLt7EAadYA0Xgj8XcL+tPkLDrjo5
 /Y1CwzIun4bYjSKTim7BrelQ4eqhPvXTojAJHPvT6jIajiypW6+ySRDjT+bReVhx/q
 Z9Pu5QpUSGQAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 15144C3279F; Sat, 13 Jun 2026 18:37:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221649] New: amdgpu regression on RX 5700 (Navi10): 6.17.9
 works, 6.18.x causes GPU hangs
Date: Sat, 13 Jun 2026 18:37:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: JamesDoucet@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221649-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221649

            Bug ID: 221649
           Summary: amdgpu regression on RX 5700 (Navi10): 6.17.9 works,
                    6.18.x causes GPU hangs
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: JamesDoucet@protonmail.com
        Regression: No

Created attachment 310318
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310318&action=3Dedit
GPU Coredump on 6.18.1 this morning.

GPU: RX 5700 (Navi10)
Distro: Arch Linux=20

Hello,

I've been getting ring gfx timeouts, ring comp timeouts, GPU resets, and the
like (see my attached coredump) on any kernel after 6.17.9 during certain
gaming workloads. In order to rule out userspace graphics regressions, I did
test several Mesa and Proton versions.

I tested kernels:
1. 7.0.1-zen (bad)
2. 6.18.34-lts (bad)
3. 6.18.1-arch (bad)

but rollbacks to 6.12.75-lts and 6.17.9 did not reproduce any of my issues,
hence my suspicion that it is a regression of some sort between 6.17.9 and
6.18.1.

During my testing, I did find a faulty RAM DIMM and removed it from my syst=
em,
as well as reinstalling all of my packages and running a fsck to ensure no
corruption was the cause, but I did not alleviate the issues.

My GPU Coredump is attached in a compressed .tar.gz format due to file size.
Let me know if anything else is needed, and I'll update as it is.

Thanks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
