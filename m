Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CE0C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B0910EA03;
	Tue,  4 Aug 2026 12:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EIUa5gt9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4017310EA03
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:22:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 639E760A73
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B09CC2BCF7
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785846156;
 bh=fc3NK3Z5gTfQuQV8OPlKWQEn321KPyuhoySiXMW0wzk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=EIUa5gt9+5J+VPQZmlG9jcYTx41pb6mPKUpUEAJy/I1+4ZL+DFDlCM9w9fVJeJasi
 ADSoz9s9hmf2eB0lL4AtRI5YVfUrSlmmuiJj6B+MYNk+Da6/ooRPWKUfeJNwAM9fBy
 XuK109zraHN+JiWQhru7nKOspT/pIeKewhi4cr+rsAITB3Elseb9vC8wV46pSPHrId
 jjv/F+m09A4i+BpZs0KAyKFzA9FCh6fHlO0tQi8by8RoOtsZk7wHospvaZY0tp4peB
 Cr2CBWg4Tqf53roiHLVkauxgmppn5WTxovqT6beu9p5a8yayVlT8hJcgPkQU+zVoby
 xEh+JC2HHZmDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 0B118C53BBF; Tue,  4 Aug 2026 12:22:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] Backlight regression with 7.1.6
Date: Tue, 04 Aug 2026 12:22:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-221827-2300-pnAef7emUo@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|6.1.7                       |7.1.6

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
