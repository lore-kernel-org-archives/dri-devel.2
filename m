Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33473F3ED63
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 04:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7072910E106;
	Sun, 12 Apr 2026 04:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l0yd9jiy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B20F10E106
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 04:11:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F3AD544214
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 04:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D47B2C2BCB0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 04:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775967104;
 bh=8mOk3RPu45pxCfwgIIcz960nb9Me5Ab8BwsMuo3/LfQ=;
 h=From:To:Subject:Date:From;
 b=l0yd9jiyH+prFzSLq0g+TxPwck028/8xapfmglZlNie90cpKbQxdcc5pFQDv0ecHy
 L+SmTwv6wUCO/t2UKeKA1Q/E31JgfVOkmAC5ZCGz4shzl3UvjqwIJ7L8OW9GQS8ceh
 Y9hyCNevkr2oIfz5pQILmZIACAJhDkprq1HHt8FzZDeVu5mOWI/uE8r2Fg5yJLsrTX
 9avWLKTLuJ96oXL5a/aunK5rt/gnfCU+JAJLQn2GQ/PAdx53HOZos0hIeI7T7q1d3a
 AKi6Vi0xLpsGMuU6EmSOiUykbVauBG/MvoqhApQA5cyFDDt2pjAOZqS0UxVl3ctc3a
 aAoNJhCptac2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id CF0C4C41616; Sun, 12 Apr 2026 04:11:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221351] New: amdgpu: kernel panic on boot with AMD Radeon RX
 Vega (Lucienne) integrated graphics, regression since ~April 5th 2026,
 nomodeset workaround required
Date: Sun, 12 Apr 2026 04:11:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: srinikkeshsen@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221351-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221351

            Bug ID: 221351
           Summary: amdgpu: kernel panic on boot with AMD Radeon RX Vega
                    (Lucienne) integrated graphics, regression since
                    ~April 5th 2026, nomodeset workaround required
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: srinikkeshsen@gmail.com
        Regression: No

Hardware:
- Laptop: HP 14-fq1035cl
- CPU: AMD Ryzen 7 5000 series
- GPU: AMD Radeon RX Vega (Lucienne) integrated graphics
- RAM: 16GB

Problem:
System fails to boot with amdgpu loaded. During boot the system=20
hangs and the caps lock LED starts blinking, indicating a kernel=20
panic during amdgpu initialization. This started happening around=20
April 5th 2026 following a kernel update. Before this the system=20
booted fine on both Fedora and openSUSE Tumbleweed.

Relevant kernel output:
amdgpu: Virtual CRAT table created for CPU
amdgpu: Topology: Add CPU node
amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -22 (EINVAL)

Interestingly Windows 11 on the same machine is also affected,=20
which suggests the issue may involve UEFI or firmware level=20
interaction with amdgpu initialization rather than being purely=20
a kernel software regression.

Workaround:
Booting with nomodeset allows the system to boot successfully=20
but disables GPU acceleration.

Kernel version: 6.19.11-1
Distros affected: Fedora, openSUSE Tumbleweed

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
