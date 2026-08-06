Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C5BC56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959AC10E1D0;
	Thu,  6 Aug 2026 15:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IODblPda";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AC810E1D0
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 15:28:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 92B8760AB0
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 15:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49A8EC2BCB9
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786030101;
 bh=+1DLaeL1TzC3tPZtjARwyDz4yhy3QxCkCPxqXr0b8mI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=IODblPdawqxxfKRFN1lUPz39LyXDNzaT9MIMpuk1jw2hKAgHYB50Msa04vXke4aVr
 +X5LX7jf0E5VBN2rhwwE9D2ztfWV1UnDicK6qdTDFxifPZbF07SzFJsAGc09u8EYFp
 9VMqiAy2BJDfRhbcOlll/1EPxXtXNm1PzwTioguC7FVGI9flI3wD+spdZKflmICilZ
 T2rSqTgF8uvm4nln4KLSR3YP9QQ5ScvzkABEDOWWvthOJNqRryigVJHahVBH0yWf7j
 jKcbqoFHD34T6tnVJzUOjN9VU2IEjWlfBcD/9QLNqf9PhMnoUbr86xXmvPxcI7vuXJ
 LsFEekeylUizQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 366CDC3279F; Thu,  6 Aug 2026 15:28:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221838] [Regression] Black screen / no backlight on resume from
 suspend in kernel 7.0.0-28-generic (Dell Precision M4800,
 Optimus Intel + Quadro K1100M on nouveau)
Date: Thu, 06 Aug 2026 15:28:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ekonom1@atlas.sk
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221838-2300-V4oFdt6naQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221838-2300@https.bugzilla.kernel.org/>
References: <bug-221838-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221838

--- Comment #2 from Slavomir (ekonom1@atlas.sk) ---
Thank you very much Artem for your answer and advice. I have also filed a b=
ug
report at the website address you provided.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
