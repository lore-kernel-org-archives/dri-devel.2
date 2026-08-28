Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A786C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6536A10F2B7;
	Fri, 28 Aug 2026 07:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fWiQi7Uw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B4410F2B7
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:49:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 75F7440302
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57516C19425
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787903388;
 bh=K0vqm3CmWIbkmE0Nu6m8CDiPQyotEyORblg4izM1Vpw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=fWiQi7UwhtInQJJAHVOnsmUCmLKd7vBihSzA0l1afjAwzA4EwUv3BIxJH6yjXQGn4
 V2VuImRHcYjbimN8EbTncvJXh16rw+u+nRLKibLsWNGepiI7GuDesnWw5C7FHFXuS9
 uhBEESlsGwt3BHDYCo40UUJE07+s7zkXY4R9Ip7okYN3H2rRfuwJLqO2lEGa7pk9q4
 Bbr8oTOiQRD5XmBrRsZ4o8PiiGZE90EIwgy/cUo1Uhx9v4JEHqWJiSpFhC15WuaEcv
 +yAKObaHiGGZ7aRmnPgGUXKhrhipc78m2nzL1SXtQs8vk2mxgCmXV+Xn4w0of9oqnv
 Rcncx6HljBuuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 37114C4160E; Fri, 28 Aug 2026 07:49:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221929] amdgpu flip_done timed out stills at ASUS ROG Strix G17
 2022 laptop(G713RM)
Date: Fri, 28 Aug 2026 07:49:48 +0000
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
Message-ID: <bug-221929-2300-EMQ2vmWZbW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221929-2300@https.bugzilla.kernel.org/>
References: <bug-221929-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221929

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
-> https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
