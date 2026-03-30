Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBCBFC981D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DAD10E47F;
	Mon, 30 Mar 2026 08:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JP5ZWOls";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E5210E47F
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 08:51:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 277FF43C8D
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 08:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0891FC2BCB2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774860718;
 bh=HMzWJWb1cz3GZgkuKIMlVdGMlEM1BjSp6sennuuxG8k=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=JP5ZWOlssCmPkCOQBIYt+lWmnCCgalrAXKTm4kmSgQpC34jnwz5PKquElNHQdQkss
 7LT6B+qouUhbCb9UAuBLCiwWnX5BfKKywqmbojQzKpyZnXxatuN2YmP2NhykYP7AgZ
 IyW3GF6T86VsLswF9KADJ3YbQVW7U31/g2Vt1+Grt0gIZFPjl1mdtI+6I3prOTZQbG
 Jp9BY82Fya+g2WnjMYqKSneTeSOwYEaZBid5+EgODKMbTEc0xszF1DR1kwnDlwmVo1
 +BAPBH/hi15GdSDSf/dVb0xHXjUhr3sHC5rlkysoLgS9hGuD0V5h2WSYYWQRwf8wx4
 ue0V+wgXVQNMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id EE5D3C41613; Mon, 30 Mar 2026 08:51:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221297] AMDGPU SMU driver interface version mismatch on R9700 -
 fan control broken under load
Date: Mon, 30 Mar 2026 08:51:57 +0000
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
Message-ID: <bug-221297-2300-GUWrjzGpam@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221297-2300@https.bugzilla.kernel.org/>
References: <bug-221297-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221297

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Report here after installing the latest firmware and testing kernels 6.18.2=
0 or
6.19.10:

https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
