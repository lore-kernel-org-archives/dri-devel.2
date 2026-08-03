Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F2AC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EED10E6C8;
	Mon,  3 Aug 2026 13:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VhuWzj02";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A68D10E6C8
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:13:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 43562417C4
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25BBDC2BCF4
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785762819;
 bh=O6MrxVuUudjDpVlYLUtQChgLJl36YS7nR+zqDQPsORA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VhuWzj02zTHGgvEwV1fsigWKSaFsA3Z1wMwU2H5L7ae659ZMsaR+9iqpOZuvCP+0F
 0pR/McDC+bYrGRCZiL5DXv2ju0fpwjtvyGcPgCdmnhAyA2QeJs12+NEGtGrqgHXPJb
 Lb/ogf9B7+41xMc7a1dXH0bClFjKt9OC6S5xrAILdrLUXMP5J62AR+8ZFNdQl+W6FU
 kqjvOylGrvS7L1xXFRy+lhn7khGIVf8byIhjTozBJLDuIjkvrbLkbLLwE0ZmC1MQSH
 5MKy2BM3Cr8uR01bPZKqyz4k+FxvxsZbM+PS+n+ZPw3WcuXQK004TV+nX6W/HjwgPu
 yU6RnQ49tXCxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 16256C53BBF; Mon,  3 Aug 2026 13:13:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] Backlight regression with 7.1.6
Date: Mon, 03 Aug 2026 13:13:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjgolo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_kernel_version cf_regression
Message-ID: <bug-221827-2300-o3NBmsbKI2@https.bugzilla.kernel.org/>
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

Raymond Jay Golo (rjgolo@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |1191285ecb4233e5bf907da7e93
                   |                            |94d7999055566
     Kernel Version|                            |6.1.7
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
