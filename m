Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E96E63FF6
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 20:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64ABF10E0E1;
	Sat,  4 Apr 2026 20:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bSpFqdet";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEC310E0E1
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:12:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D11BC60008
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 800CAC19425
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775333567;
 bh=9//RIEXwoIClot3RW/mDXWEfvZQxdH1ehnIG5DcW8vg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=bSpFqdetfpq0qbiCibS5Q8kk350dR3mIz0YwR/Qe1BGA1DI8S/5aEFIK778jJ3vPy
 VS3+sYEHoycKk1bzQN20Sq61rI/RljQkyWBcWStK68VDXvjO8vkztM3YajDU/6pWUe
 NP2xZsVKhKQ3uUy5QKxrPJLN8K8+ZcIumZbfbWccbgL905xZ1GLYj+M/lw6lp1mpem
 pAbdgHYh1YdG+sWs+p5pPvbnfrmpglDImoA3YchKtlveVWyTKue9ad/o1qLcH7dNFW
 nsD1OAeb1HVJIIpjfG5Ok9+zUdBMajUmFvtC2UTscD6VjIQJJ2B+FqxvpF1Y9VnRPM
 TbHYr9tBm3n/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 73A4FC3279F; Sat,  4 Apr 2026 20:12:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221320] ring gfx_0.1.0 timeout, signaled seq=5855035, emitted
 seq=5855037
Date: Sat, 04 Apr 2026 20:12:47 +0000
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
X-Bugzilla-Changed-Fields: attachments.filename attachments.description
Message-ID: <bug-221320-2300-7Vrf8MO6MU@https.bugzilla.kernel.org/>
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

Witold Baryluk (witold.baryluk+kernel@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #309820|amdgpu-coredump.issue-22132 |amdgpu-devcoredump.issue-22
           filename|0.data.zst                  |1320.data.zst
 Attachment #309820|devcoredump                 |amdgpu-devcoredump.issue-22
        description|                            |1320.data.zst

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
