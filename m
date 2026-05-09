Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FA0CD343F
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 06:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D090210E183;
	Sat,  9 May 2026 06:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oAJCiOj+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345E710E183
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 06:27:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DC6FD43A78
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 06:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD65DC2BCB2
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 06:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778308022;
 bh=k4kjPg1sOOHMA+CC/Jkvv1mflHdeGPyin3vJJEfIaS0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=oAJCiOj+PPn7QFDOgu6zUba5RhBrLea613RYDyy2G3KI59IHOEVUHX0kPRzB+X53V
 MfdvDAvVGZHVr79kYuVES5Wga8GWjZEmiw0XuJnML4xjZDKYOmxxu0DkaueH6NhN2t
 7f/r12UVwwfXDBVCzXmhtWHDnlMPLp9QhshiDnR1/FabDznbGr7zbavUPFHscP5vHw
 79NLO+L9+W4qv7W/psoVG6KQwxXmLotwhTHx+UAysi+4q6G7JH2p4i3opt4hFD99lB
 yO3aY4lDNid8uswSELE56jh/mWQK5cLTOVDoM8uXMoLiGFwSF20wXS22ivFVmExNhT
 0xO+sIV9hnshw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id B0D93C41613; Sat,  9 May 2026 06:27:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221480] drm/nouveau: timeout and WARN in tu102_vmm_flush while
 using mpv
Date: Sat, 09 May 2026 06:27:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: info@maketopsite.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221480-2300-B4uaRaYvbl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221480-2300@https.bugzilla.kernel.org/>
References: <bug-221480-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221480

--- Comment #2 from info@maketopsite.com ---
done: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/486

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
