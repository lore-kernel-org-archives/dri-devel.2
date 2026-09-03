Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276F6C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDDA10E0B9;
	Thu,  3 Sep 2026 09:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mOf77b5p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A2510E0B9
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:11:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EDE82600C8
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EEEBC2BCB8
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788426677;
 bh=+6C7GSRMrCU8bb6KtZB05ZtRalRY90OMr1hkbFlLqOM=;
 h=From:To:Subject:Date:From;
 b=mOf77b5pgouk3F+ixQMQBS0/m0lhR/g+YzEgJUxLsaHcKek4AcYdmx9BcGmglRFoL
 rMl+WHjZB+G6X94Xt9oIbAd2myIxjYq6I6Q+fM+W22CS9X8+n5cN7fNEZZ9iSsRYJb
 848WM7D+1cyeMzxXJ1mycw2fQ9ZucX4CU15XuTqpb1ZSnhvyQ/A24NxLv/PhZFqzow
 mPerXpaardS75GAgapM1bniNKFJ/o0MEzwYIprr8p03fVfXLC9nzmeb1RHjfnqb5zi
 tZhezuizHe1s6k0Pgc2EZu1LrM2YM6gBfKkS/zIN5Vr256UVlongPFrjLAam6sfbcl
 F/muQIWyxBZUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 87185C41613; Thu,  3 Sep 2026 09:11:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221959] New: ttm_lru_bulk_move_tail cause CPU stuck
Date: Thu, 03 Sep 2026 09:11:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: twyoda@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221959-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221959

            Bug ID: 221959
           Summary: ttm_lru_bulk_move_tail cause CPU stuck
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: twyoda@gmail.com
        Regression: No

Created attachment 310777
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310777&action=3Dedit
ttm_lru_bulk_move_tail failed  dmesg

This issue seems happened only after hibernation resume and randomly hang a=
fter
some times of using.
The attachment starts at 2026-09-03 16:37:10, "BUG: unable to handle page f=
ault
for address: 0000000000002008" then following with "soft lock - CPU#? stuck=
 for
??s".
The GUI screen totally freeze, "caps lock" key works, but Ctrl+Alt+F3 doesn=
't.
The dmesg records until I long press Power Button.
I had already turn of "Transparent Hugepage support".

My hardware:
Asus ROG Strix G17 2022, G713RM
DRAM: 64G
SSD: 1G+4G
CPU: AMD Ryzen 9 6900HX with Radeon Graphics
Discrete GPU: Nvidia Geforce RTX 3060M with 6G VRAM
OS: Gentoo Linux

What else information should I provide to deal with this issue ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
