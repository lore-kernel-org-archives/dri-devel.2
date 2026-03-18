Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E313FF6E9A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 00:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CF610E41D;
	Wed, 18 Mar 2026 00:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EM9JhP6Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AAC10E307
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:15:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DF34360054
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9162FC19425
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773792933;
 bh=I+9+GjtNP2pJsmTVMuI3s4gVnwAM9Q9ZUPIVD0eGEyM=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=EM9JhP6ZWGvBfjYhN6s+oMkENSeyTV/fnmybxG8nM04216bKjHnzEpIYDH/PBelSk
 JP2RdYp4L7Z020DzQ+ekhUctkh5xI8Z/o3EduDX7stFCW8zEy+XLbq7qimOS5N57EK
 OBwbM9dSJ9tz1AgCyTbmgpE91E+g6sEurr7fYSqa9Rg+piyuKnsb8Dh0MlooeKM++r
 FiTQ8cljVEJ4MiiaadBozcEfYDBVzRj7zIrAvYRavSL2FW4TGoGoDnZvvdxnyS0bqN
 RmdQUeCSDGlrygDHfWY6BxccyvqwkWitOOA1ov3gBmGezuLM001sUStqUcv8fO6ra1
 wht5573PLFNOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 7CCD7C41612; Wed, 18 Mar 2026 00:15:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221245] Regression: Black screen on boot with AMD FirePro M4000
 on kernel 6.19.7
Date: Wed, 18 Mar 2026 00:15:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: denizomer10@icloud.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221245-2300-qC3WqSJJVi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221245-2300@https.bugzilla.kernel.org/>
References: <bug-221245-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221245

--- Comment #2 from denizomer10@icloud.com ---
(In reply to Artem S. Tashkinov from comment #1)
> Perform bisection, report to
>=20
> https://gitlab.freedesktop.org/drm/amd/-/issues

reported to https://gitlab.freedesktop.org/drm/amd/-/issues thank you

https://gitlab.freedesktop.org/drm/amd/-/issues?show=3DeyJpaWQiOiI1MDg4Iiwi=
ZnVsbF9wYXRoIjoiZHJtL2FtZCIsImlkIjoxNDg2Mzh9

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
