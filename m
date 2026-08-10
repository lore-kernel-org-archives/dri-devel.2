Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9013CC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F088310E8B6;
	Mon, 10 Aug 2026 14:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FlFoIUdn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56CC10E8B6
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:28:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 38E6160204
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4B4CC19425
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786372130;
 bh=5LunR7GSk7QqYvmN9hrhB4JfHzc+sjbjMf9LMPXEq20=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=FlFoIUdnogL2eX2Fub1t1bfFYLWlS223BLGTxZee8MVJR+CFubzbXVhOudPbxU++O
 3paj4CI5gdC0YbzNqmsYY4tbUDlBA63KvERVY9wlKFXNIjPNuBBuN1kg1+PNGae7lL
 ph9YmwUSek5UtAbp1hjZustL7AQ4kw1dqrExzD+z15tqSqHjPrKyBXoZUDi0IMnuiy
 AShOY9wJlpeRbl8GLA6WqRN3DmiWBYpVtmbRcR+VcOm+lxSfBn2obLzPIGAPoUXNFA
 33WHQnjdvFcAoGzrhp9MHBRg03DSejcfaI5wwekxGIMw0JwZQ9bAPUq96omCaYcRdh
 jcld1ILaVgCvg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D2648C53BC5; Mon, 10 Aug 2026 14:28:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221865] amdgpu: brightness 100% blacks out screen
Date: Mon, 10 Aug 2026 14:28:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: me@metantesan.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-221865-2300-3W74xNkaKL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221865-2300@https.bugzilla.kernel.org/>
References: <bug-221865-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221865

me@metantesan.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
