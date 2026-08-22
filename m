Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D65C5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 12:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B5C10E3E8;
	Sat, 22 Aug 2026 12:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dnCVqWz4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3847E10E3E8
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 12:45:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B8E76404DE
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 12:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F35BC2BCB3
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787402711;
 bh=Vq7Is+6BFWoS4S3tUSPO2Qxv7p6wOIhYLAv0Iolak7s=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=dnCVqWz4GqLteO06xWBkAsuh5/o1o4Ccpodd5Cshnj8cH+Bpq/8svSy7r99+vSvmI
 rVhoTqmWwJ5BxHp3A7ZNycfatt8eXUPyvQiFdTDXDtGfdcl2YJ89SbeMBE+2S/moT2
 gxNBy3MGqT20BylGQZn716smnm9fvYlBY21B33j9tywdRTACTIjSD71793jWRZJm1B
 53icVmns7k5m2v4fmQ5qWjPkNsOj/pofgirKXfD6Vu+1Ea7guHEBs7dzmm+IBIzbzD
 SWtcturK/FXaruIl30hz6tOSbeVd15RBxf7DkWGM81H1zhB0WPCBu1Kxelr5r3sCu2
 86jwqY77Q9WSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6D762C4160E; Sat, 22 Aug 2026 12:45:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] Backlight regression with 7.1.6
Date: Sat, 22 Aug 2026 12:45:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abdullahz.universe@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221827-2300-yJvBHVCCR1@https.bugzilla.kernel.org/>
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

--- Comment #7 from Muhammad Abdullah (abdullahz.universe@gmail.com) ---
Hellowwwww AWESOME people=20

Just happy to report that I just got 7.1.9 update on Fedora 44 and my Issue=
 is
fixed=20

THANK YYOOUUUU all the Free & OpenSource Linux Community=20

=E2=9D=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F=E2=
=9D=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F=E2=9D=
=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F=E2=9D=A4=EF=B8=8F

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
