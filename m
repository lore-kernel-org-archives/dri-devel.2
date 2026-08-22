Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CD3C5DF8C
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 05:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FEB10E2A3;
	Sat, 22 Aug 2026 05:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="izRcedBu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A25F110E2A3
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 05:22:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 90B4F600E2
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 05:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 420D8C2BCB8
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 05:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787376157;
 bh=OpwsQuMixJAMksBRyR8u2R2jOBEXWWEhvK6E2q7FHcQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=izRcedBuQJ/bXf5NiDLyhZBjH8slkLj7lxjb2nJ5jun1IKWCs4OpV7OjHo6WL0VUp
 6CLrLa1NfZ3qXat6X/cVDYDja74wE9j5yV1BxtavYW8i/QHGrQpl7ga23sgElD+b5i
 iPCaxTyLzJhN6ECyXuZ/QqDQMnp7Iee0aHaWyxdJ4Y9BPj0n4y81tD7krdp0e0PITY
 0Zxnfcpa+GC8mwDM/U6ZXrcnDmSA6oIp2Tb2W5r+QAAPWWPNL37t0eV7jvUDlsksFC
 Kcaj2c6SZJMuN7+zR+WocdYKTWXvNzTlGzXJeXRCwatm+djH3EelVsZrl7kRMh5/Pc
 bvL5cHFqGCpqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 278F1C4160E; Sat, 22 Aug 2026 05:22:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221838] [Regression] Black screen / no backlight on resume from
 suspend in kernel 7.0.0-28-generic (Dell Precision M4800,
 Optimus Intel + Quadro K1100M on nouveau)
Date: Sat, 22 Aug 2026 05:22:36 +0000
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
Message-ID: <bug-221838-2300-k25nIK5MaZ@https.bugzilla.kernel.org/>
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

--- Comment #3 from Slavomir (ekonom1@atlas.sk) ---
Update information about this bug
My PC use
Graphics: Hybrid / Dual GPU (Intel HD Graphics + NVIDIA Quadro K1100M on
nouveau)

Real source of bug is from Intel graphical driver, not NVIDIA driver

More information about bug
https://bugs.launchpad.net/bugs/2161309

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df30fddb4402313aa5301a74d721638d343395269

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
