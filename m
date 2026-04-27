Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A245FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A287110E074;
	Mon, 27 Apr 2026 07:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qz9jnTd2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9F810E074
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:50:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 23C8140539
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03B36C2BCB4
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777276229;
 bh=rrII8iU1kUlOQlnrjqCK76uDtXkTSjR7ajN1XJEhao8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=qz9jnTd2HVeW+ZxJzqeZ6itoVU2TX9jGzqntMvDgd2BFxCt+zBEwvlL92ny8SKfvX
 ELN96v5PuG27Xc48V4CKZKsOAdQYPero8JpHcI27jz3uR+IS7R7Db9I4HyBvk71BXj
 rLmb36EGN6PHeK3ELO6ZN/0lc0itNINRvjyzb0mK3mrEgsHO3SNC8rBqZq8D3ckwBD
 kEqxccKpbG1NNaeBxnhHFMoQGWZPN3A8Ge5Lz1BxjGjrTnrM58xKDBIFcpMeSoXjwT
 9pSVUWXSBOhcQZ1bDcbsIdsKBYbstB1vWjmEX2Cafoew9YkzPQ6Q5+EiPAi2e/v884
 r8DGywXw7x6cA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id E912AC41612; Mon, 27 Apr 2026 07:50:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221421] amdgpu fails to display anything after resume from S3
 suspend
Date: Mon, 27 Apr 2026 07:50:28 +0000
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
Message-ID: <bug-221421-2300-RnNSWHVZBo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221421-2300@https.bugzilla.kernel.org/>
References: <bug-221421-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221421

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Refile here using the given template:

https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
