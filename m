Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F5ACD343F
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 06:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E30610E36C;
	Sat,  9 May 2026 06:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gguTAuAJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0823010E36C
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 06:39:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B96A2409B0
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 06:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AB20C2BCB2
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 06:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778308792;
 bh=vENe44hZ7W673DGFwM0R7CynwMdz+tD3pJS2BSm7UDA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=gguTAuAJWmcJUFYJGYWavQuMDRYHX/UMMb8xzInYESDgm1s2n8VB4DYlRz2qaWC9T
 d2c4EMHdBkdA0ITgIS7lRjxdeRCijmUd6NzWyyRv1iir8c3wuC/OXUlE5/JaYR5yhH
 rqp0PS3VUQW2GE/sTyvHW6preI3RECv8elvjYfReUmyBRUSBEuir9EVxneHhEzaMfv
 Xo2xP4FMTHRfogYzwNvXLowWXSi5Uf4hwEs0aF22n+rmM58nSRyAf+bID87a4o766n
 Xsq3E7LgJMYCiPZ+7OrvUvcOHyzXpdMdyRZXDqcpU4KHJHVDhU1WJsUh3DzG2ZHUGk
 K22qGagXdV1WQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8FFDCC41613; Sat,  9 May 2026 06:39:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221487] Nouveau GSP timeout (r535_gsp_msgq_wait) on ASUS TUF
 Gaming A16 with NVIDIA RTX 4060 Max-Q / Mobile and kernel 6.12.86
Date: Sat, 09 May 2026 06:39:52 +0000
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
Message-ID: <bug-221487-2300-EnnkAGFkWt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221487-2300@https.bugzilla.kernel.org/>
References: <bug-221487-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221487

--- Comment #2 from info@maketopsite.com ---
Thank you for information.

Reported here: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/487

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
