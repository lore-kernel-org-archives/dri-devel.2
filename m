Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10F6F44852
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D96810E953;
	Fri, 10 Apr 2026 12:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YQWHOqLo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4544110E953
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:45:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EDE06132B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27DCCC19425
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775825118;
 bh=DmqIi9A++h2Rl2JvPQ87PuhPHEk+aY1dPLKPZ7lXFBY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=YQWHOqLoCCOQ64xqchI2eKsA+5Y95zvTCB64Yzmf2ikoc9HNmnDpndy6BWy/oM1MJ
 cIaVLZpcxy4vJw2NufysZWTzdxtommhei2ICOdjLn4789garw0TtZqGSG/N/qCmd9P
 UL5LXSCJOzQSVHwxp7RGMRVZB7mccwvQyt518Fivh1tPPnOQ2vTb+06r87YQJfA0/P
 OzeT8KnF4jKRZP2bZQ8jBJvMiVbbTzZQURI74tsOgSeaSm3FcrplM7kzm7vP5bHo5M
 FU4AJqQEhgt5IlSJO96hGVHtEAFPoy7VpzzAfw56WneER+u1o9dsssJJ4QqCdEC43o
 E/59PyAUaNBXQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 1DB81C41613; Fri, 10 Apr 2026 12:45:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221338] AMDGPU: RDNA2 (RX 6600) Vulkan workload causes gfx ring
 timeout, MODE1 reset, and VRAM loss (SMU driver/firmware mismatch)
Date: Fri, 10 Apr 2026 12:45:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tona_kosmicznego_smiecia@interia.pl
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221338-2300-JRuuuX9jHi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221338-2300@https.bugzilla.kernel.org/>
References: <bug-221338-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221338

--- Comment #2 from tona_kosmicznego_smiecia@interia.pl ---
Will do, thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
