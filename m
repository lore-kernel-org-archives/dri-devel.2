Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA72606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JU9sCO/O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF0D10E4C5;
	Sat, 14 Nov 2026 07:31:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639E010E4C5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 07:31:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F353F41351
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 07:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D74E81F000C6
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 07:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794641490;
 bh=7DiNA2Nnn8TYt2yyhaY5+eF3lYu2soN+ee3D+Gq7jqY=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=JU9sCO/OBFLBEbyzo05p22x1f6wE96eoQE8To4NabnpNhZonNTbS/ZF/zldyRE+4T
 1xGFhxlxQPZaI15SGUOXi2YVokADYy8AGhoIOHW31poOw3XULNvM3mPVgGbBipcpS3
 tgKslRXk7LNQ7LRkYyxEj4M7KtWtiDGSMvTixd509w74GZ0uKgeFHdlCCvZt6EhrK1
 Ys1TPG2AWrcu3dt0p5KU3qzHWRy5giI5gbnHqrsvfkyt3PAZgk4ZSkFH731nWriHSC
 N1UTyNj3w0UoKmCTtW1Ma0cXFx9DochaYBxHNqhsBy8ucmMVyJ0Bcv1aVA37Tsbq10
 Scbp2jiiYSYnA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C9188C41613; Sat, 14 Nov 2026 07:31:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222265] amdgpu: RX 7600 defaults to limited RGB range
 (washed-out blacks) over HDMI since kernel 7.3.4
Date: Sat, 14 Nov 2026 07:31:30 +0000
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
Message-ID: <bug-222265-2300-qALCCJUEW7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222265-2300@https.bugzilla.kernel.org/>
References: <bug-222265-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugzilla.kernel.org/show_bug.cgi?id=3D222265

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Report here instead: https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
