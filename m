Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A36C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CB410E129;
	Tue,  4 Aug 2026 08:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BoVsYl+Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB31D10E129
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:48:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C11E260A75
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71C6AC2BCF5
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785833287;
 bh=F1oCHQ2mTVVJFzX3Qut2ycI7vonafQ5B39+vbHw51Dc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=BoVsYl+ZgIPeXtiNXLHCWhsLe+PDmLEDMgoDSfAF+CHu659yi0Mho3D2AyojDORkY
 7+AR7j8G+U4RhGKyjPqdDXB0ZpbiwSXM0avGSYihbEOjifxpC/McTO3+cj4b7QIZge
 Xl+fh2jZcZ1ri78gAmaw9rhx97c+W6zWhA2ZFTnZFfkw5OiNpl0FrAxLryvZAIHyET
 SeQB6a94WGPKmOC3MPbILJzwm3CP6YsXnc7u+5ZKC9wPzU6AzUVw54buwyoCYo9lcZ
 pwSSwMMplL8RnxV9172l4YvFeelaeTicBDAtlqp/fydXyxeQXpcML6HjZmbSnG87yL
 T1a8h6rLsswfA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 538AAC41612; Tue,  4 Aug 2026 08:48:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] Backlight regression with 7.1.6
Date: Tue, 04 Aug 2026 08:48:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221827-2300-y7ENeI0DRn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221827-2300@https.bugzilla.kernel.org/>
References: <bug-221827-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221827

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com,
                   |                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Raymond Jay Golo from comment #0)
> Upon upgrading to 7.1.6, backlight at 100% is set to dimmest level.

@Mario, this is apparently caused by the following change of yours that was
backported to 7.1.y: f1b5d8f9cc54ae ("drm/amd/display: Fix backlight
max_brightness to match exported range") [v7.2-rc4, v7.1.6 (1191285ecb4233),
v6.18.42]

@Raymond: This might be a general problem or something specific to the
backport. Testing 7.2-rc6 or later is thus advised. You might also want to
attach dmesg files separately from a working and a broken kernel, as they m=
ost
likely will be helpful for debugging.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
