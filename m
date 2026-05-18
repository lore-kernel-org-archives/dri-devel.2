Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFF4CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512F110E359;
	Mon, 18 May 2026 14:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iAEUgKbx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697EC10E359
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:34:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 119E743F4A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6071C2BCB8
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779114883;
 bh=zNAnoeJmnrMaM4fMwARzNXdTUEg7QpYK9EQc3zZTlLY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=iAEUgKbx62NE+64GDzSHIu9kJbX8ZqOA2AJlv+4OdeK77gfq9TlzyRB2bUtrf5Gsp
 vn/0+RfcFgu51sanGe4QvGZnSrzdrJHyZ2I0EI+YBpEvJeaRLPqHKMuM2M0AS9ZFSH
 3baAcX7/DiT6/T7rLT73qStTJJ3ucC73iyHenR/2/A6M3TbUVmKzt1OdupqpHeQqz0
 wKP3H6Y9hRpqxDn9PbWE6xXUZwE5iJMLT5tL5y7cAp4HZ+I4cybt0heDebFraKwU8N
 ve6GRf7B2YTIV+2ulko+ukkf/s1NcUeRD9wsJiNfpGtSbJF372Vmlh7duK2Zar7DYT
 8zjPPBSb040Ag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id DD4C0C3279F; Mon, 18 May 2026 14:34:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221543] [nouveau] RTX 5080 (GB203): Xid:13 WIDTH CT Violation
 on kernels 6.16.7+ causing system hang
Date: Mon, 18 May 2026 14:34:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221543-2300-jO5bDp8sTC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221543-2300@https.bugzilla.kernel.org/>
References: <bug-221543-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221543

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Report here:

https://gitlab.freedesktop.org/drm/nouveau/-/issues/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
