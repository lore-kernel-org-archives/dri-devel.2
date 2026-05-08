Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA9ECD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 08:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5BA10F3CF;
	Fri,  8 May 2026 08:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cIV8k8/k";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3838A10F3CF
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:03:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E2A8744078
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C56E0C2BCF4
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778227414;
 bh=579+NnFAqRtF75ymIppd4CCj3bDwAvatpI3/Cse6Yvg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=cIV8k8/kwPa1kQ86iEa4D/ahZQWUsJs4xGlHpLdHS45+PcFneet+FD/VORDvo3VoA
 sLfl8ySFJuJXdkK69HfE6FMdZ5scCvvCMYNpioF7YsYw1MKJ4ecTQJa7JBQlqSAh/8
 jz5Di8ujl8VIeKKUZBn+Lzwn7t2IBrhz4YV8cDvhLD0s4+OtxmoEJRHdOnqm5HtHIe
 ceTacYG7hUHkR1WxkH9O3aAUciAsW0oQr/ME5/v7+rfN5It0Q8+iBiKJ9VPXhBqfkj
 Wa1fvyOpqee/kdKSFw0K0VTodZ+nvVyh+mRo9RPLdktWAifQF6u0iiWhKI0DzjL4kd
 +92WP41zeaz9g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id B4549C53BBF; Fri,  8 May 2026 08:03:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221487] Nouveau GSP timeout (r535_gsp_msgq_wait) on ASUS TUF
 Gaming A16 with NVIDIA RTX 4060 Max-Q / Mobile and kernel 6.12.86
Date: Fri, 08 May 2026 08:03:34 +0000
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
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221487-2300-3h3JU27t3S@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please report here https://gitlab.freedesktop.org/drm/nouveau/-/issues/

The chance of getting this bug fixed for this old kernel is next to zero.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
