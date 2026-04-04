Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879D8E63FF9
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 20:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBEC10E045;
	Sat,  4 Apr 2026 20:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iup8uOAd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F66F10E045
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:39:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BDE8960008
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C245C19421
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775335148;
 bh=Od4DGeuMSGyeL2enjrUAwyrz2lFAjys1Xo4m70+WW1E=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=iup8uOAdPSLYuAZizGQRKB/cnzODFcwqiDHj1NRyWpXwhyeU6T/b7meaM+d4L0ott
 uEWhPBzNWj0WP2BF40G4x1YorSBPe3+lIhQbPr8wQBAsEgMT21NQ8yEj1N+HzvM133
 s+/JxOKIhVLyOG7kOaIR3jX57V8wyba/jalmORc78GPa/0Kj5hwR5zgdqM1ZW5NB3L
 3Ziei+gcMeJmik1CIxBUVXVuhuYbxerQgxXiQ+sZpo9DbdDUSKyfGBTJXl6IEj4UV0
 Wa+9WDkM5mmihZZO4aW+auA4zKYyxTg9P7ti4sbe/zXGN502YCS4qFCX58ZbHmEiuQ
 zy1m9bCcgyNPg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 61C01C3279F; Sat,  4 Apr 2026 20:39:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221320] ring gfx_0.1.0 timeout, signaled seq=5855035, emitted
 seq=5855037
Date: Sat, 04 Apr 2026 20:39:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: witold.baryluk+kernel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221320-2300-oQnDZQamuN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221320-2300@https.bugzilla.kernel.org/>
References: <bug-221320-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221320

--- Comment #2 from Witold Baryluk (witold.baryluk+kernel@gmail.com) ---
The issue also happens with MATE desktop (X11), and no other programms runn=
ing
(i.e. no Firefox)

LM studio log:

```
$ tail -f 2026-04-04.1.log=20
slot update_slots: id  3 | task 0 | prompt processing progress, n_tokens =3D
35328, batch.n_tokens =3D 512, progress =3D 0.797292
[2026-04-04 20:36:50][DEBUG] slot update_slots: id  3 | task 0 | n_tokens =
=3D
35328, memory_seq_rm [35328, end)
[2026-04-04 20:36:50][DEBUG] slot update_slots: id  3 | task 0 | prompt
processing progress, n_tokens =3D 35840, batch.n_tokens =3D 512, progress =
=3D
0.808847
[2026-04-04 20:36:54][DEBUG] slot update_slots: id  3 | task 0 | n_tokens =
=3D
35840, memory_seq_rm [35840, end)
slot update_slots: id  3 | task 0 | prompt processing progress, n_tokens =3D
36352, batch.n_tokens =3D 512, progress =3D 0.820402
[2026-04-04 20:36:57][DEBUG] slot update_slots: id  3 | task 0 | n_tokens =
=3D
36352, memory_seq_rm [36352, end)
slot update_slots: id  3 | task 0 | prompt processing progress, n_tokens =3D
36864, batch.n_tokens =3D 512, progress =3D 0.831957
[2026-04-04 20:37:01][DEBUG] slot update_slots: id  3 | task 0 | n_tokens =
=3D
36864, memory_seq_rm [36864, end)
[2026-04-04 20:37:01][DEBUG] slot update_slots: id  3 | task 0 | prompt
processing progress, n_tokens =3D 37376, batch.n_tokens =3D 512, progress =
=3D
0.843512
[2026-04-04 20:37:08][DEBUG] radv/amdgpu: The CS has been cancelled because=
 the
context is lost. This context is innocent.
```

I did verify it is using system vulkan libraries (vulkan loader, and the ra=
deon
mesa driver too).


The issue is reproducible, by loading same model, and replying the same
conversation to the same point.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
