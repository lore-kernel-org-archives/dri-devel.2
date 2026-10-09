Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE97ECA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E02710EB1C;
	Fri,  9 Oct 2026 20:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VFi1lDYU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C5610EB1C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7003660120
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 238BBC2BCFB
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791577725;
 bh=ceytfm4t61QTLgHW7TBguGRMcNzQphTIiUaiyrIQHiQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VFi1lDYUsOmPwQ2V22gUFxYQHLr/lCk1nesdxonkUUryoC3qXu8+TYY9SuS3J0kiF
 saw/Y+kd+t7I4ImGfxJ3lmd52nDS05gpRkY9t/MfYdEKa07HsS7hbp31a9O2zESWYZ
 XepK1yixdzGRtNtWf7rqDJLuJBTmBobFUsU90TD8nRCsl+9ehbYHgb2hbm2h5GxNJA
 HwZtnNjZTmehQkrLOy9uH6rYYZbFR0lo+DjHwaLBaLC5PL000ImHPL6ZdF+HHVp8CM
 Bs6/A5N4idxJLtMQ2BIk5fCLVoVgqhcmCZTcK25/aBDuJdoAbXbpSivsWTuW6ukFrX
 6GgLvXSVV5anA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 16068C4160E; Fri,  9 Oct 2026 20:28:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222109] [amdgpu Picasso 1002:15d8] gfxhub UTCL2 SQC permission
 fault -> ring gfx timeout when DPM forced high (repro on LTS 6.18 too)
Date: Fri, 09 Oct 2026 20:28:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aleksey16.11.2000@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-222109-2300-JUpT9ghsdW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222109-2300@https.bugzilla.kernel.org/>
References: <bug-222109-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222109

--- Comment #6 from Alex (aleksey16.11.2000@gmail.com) ---
Created attachment 311051
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311051&action=3Dedit
uname/cmdline/BIOS/RAM/pp_dpm/tlp-stat-g-p (auto stable vs high faulty)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
