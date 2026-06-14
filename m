Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2281CD8CA8
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 23:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9FC10E03D;
	Sun, 14 Jun 2026 23:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qm+JvOmQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE0B10E03D
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:07:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 40F5A6008A
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E36F5C2BCB0
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781478426;
 bh=D4xA/QsYyzWByZJjN38h7qYFjctaRuuShFnVJ1jO/Uw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Qm+JvOmQeBN+63pWrbJ1CDaE/uOz6Fz/OM05PmNMYN0kepCI5iYqMmXSb8EmvG1sv
 f2fMy1Zi21w3K/0xMzl4ryXLvmKFtA3kcFz4llvHW0cD2EfTrkNH3LLMmwFH1iB9t0
 rBk0zxjsDqIYx6XA2nLhxG7Io4v75AvqedS3dvYaWiwcj3QeImh1DvspZPSlqYAD9s
 myi3P+CWqzgZL7E9lkXzucP/IB70Kdu6GF+0VQZeSXY9PAFny0BxI8hXXV4U1qFYjo
 Xlk0EEs+hYmq6jbJ7iGsI4wCWmTd6pglYhOld9/FkMTkBVN4EmMS6FYFyqJ+x6qQ1Y
 qU08eZYKomLzA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D7272C41613; Sun, 14 Jun 2026 23:07:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221649] amdgpu regression on RX 5700 (Navi10): 6.17.9 works,
 6.18.x causes GPU hangs
Date: Sun, 14 Jun 2026 23:07:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: JamesDoucet@protonmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221649-2300-D3AthZWWUd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221649-2300@https.bugzilla.kernel.org/>
References: <bug-221649-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221649

--- Comment #4 from JamesDoucet@protonmail.com ---
(In reply to Artem S. Tashkinov from comment #3)
> Please refile here:
>=20
> https://gitlab.freedesktop.org/drm/amd/-/issues
>=20
> Would be great if you bisected first:
>=20
> https://docs.kernel.org/admin-guide/bug-bisect.html

Sure thing, thanks for letting me know; I wasn't sure if it was appropriate=
 to
post here or there so I did both

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
