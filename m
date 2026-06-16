Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4659CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF6010EA8F;
	Tue, 16 Jun 2026 11:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gkmvHGiQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F67510EA8E
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:59:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EDBE44411
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45370C2BCB8
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781611197;
 bh=g8RfzJZFuxfQ2Gd+1u21dE+dGl44ozhtCBvzx4gZhp8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=gkmvHGiQE+lNFdNeRNmLERy/AK0YJQRZK4VPXjuHOmNKyRPnn5PjBhmT4egwz+ez3
 S2RI1D0afWHXr89CKm7+KzTTvfIs2B6K5PcHHcQ0UB2OWRYw0rGflYaMm74UMpNaCk
 qUmUZ95QYreVYzx2WjUBWYTZl+tS64EqCdmB/XZJOlqnp35PJXmOaj0DKpCIn5GEVq
 JCOD0GBLxDZJhr4EADyGJHlmC2s/Nk1v/u3GIi7td2kiwScnoF+CkjI7MjABrgIOXO
 zjzeJGDZaAPDjZBjbbv2QixaUDFpZqAfB6jkyny1yinxtZrvq7R1PdZ40q3Fb5CcJb
 2+2zgZZVAX05A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 3C966C53BC5; Tue, 16 Jun 2026 11:59:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 60533] CVE-2013-7445: Remote web page triggerable DOS in Linux
 DRM graphics.
Date: Tue, 16 Jun 2026 11:59:56 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: eero.t.tamminen@intel.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: dri-devel@lists.freedesktop.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60533-2300-tlP1QoZFtZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60533-2300@https.bugzilla.kernel.org/>
References: <bug-60533-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D60533

Eero Tamminen (eero.t.tamminen@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |eero.t.tamminen@intel.com

--- Comment #43 from Eero Tamminen (eero.t.tamminen@intel.com) ---
There's now DMEM cgroup for limiting device (e.g. GPU) memory:
https://docs.kernel.org/admin-guide/cgroup-v2.html#dmem

But I guess this bug is only about iGPUs i.e. when GPU memory is shared with
the CPU?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
