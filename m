Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C7C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E9E10E667;
	Mon, 31 Aug 2026 07:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q8dYKh1+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7100A10E174
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:07:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 267EB4012C
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 094D3C2BCF4
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788160021;
 bh=I/KUiJUlh/CXyrY2k44Q/8MqUjKbHw8h8KS+ReIh1Dk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=q8dYKh1+kSeBC5oWiK3wc1hrfhpAQZSe+sqRM+7iFe+kFiWecspR5kpJoFcw0hIdr
 O39MFvdHgbqh8oNAzsLqZ6hg5LvgH9VClkq9K2TY2pQS4vzAt/jJXqg1po5TphjPbZ
 Jdkl/lB3arvh6Ak8lUumX+vyVNWE+r+8S3OYo6qK07Wb6ZvW1trLzQ67TJuPlqeybm
 RuEeRv0Wm7WidvdAkBKlHJr3U+NcukpX6wGQ71ovfsXIHWjUbU9nxQeSggePvrKyO2
 MUhx7qnebKXtltnDg4b2zqKpgSMosurH7scUlN6i4LjpZdd6LJmPJuVltApyoMNaum
 W30unMiCeU80A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id E3DDFC433E1; Mon, 31 Aug 2026 07:07:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221933] Screen brightness dimmer since kernel 7.2 (amdgpu)
Date: Mon, 31 Aug 2026 07:07:00 +0000
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
Message-ID: <bug-221933-2300-UH5hvHW6Ps@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221933-2300@https.bugzilla.kernel.org/>
References: <bug-221933-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221933

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Report here:

https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
