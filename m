Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93211E63FEA
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 20:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB1FB10E0E4;
	Sat,  4 Apr 2026 20:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qitXPkEE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C5510E0E4
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:12:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 99A2B43E14
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77D6AC19421
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775333541;
 bh=+VovMeHy/diXa2Lcq5f7MJgXM6TA/6h52Ut62F8SYX8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=qitXPkEE53uH1XzaOS5I+l/W+s21Fttk2K+prc8fsjSm7Y0apmTPiZVC02Rjd4nkR
 b7tFuBC67/79pJLbm0FGDZqF9mN03cr5roidnJOCTUIpP50j3/bAxRVQkpwnedVXqg
 gvj/B2NET30N/iT32XLx5S64W5XfCzqSxZoiq/+KMkVjdKd94JrttCLEVWp5/MYuJ+
 XfmuuRu427RR97H4pQK3lI05EaURy06un3EdsUHGxOKNf+BSQrYWIXjtbopT9b2Z01
 gwIEz8JeYQ9AnLgxFCtRYcdd1IKKLm9jq7yC8lwIDCjbYX66u/8HoRGBiDqiBvdhWn
 5ms96OIkMBAHw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6EA9EC41614; Sat,  4 Apr 2026 20:12:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221320] ring gfx_0.1.0 timeout, signaled seq=5855035, emitted
 seq=5855037
Date: Sat, 04 Apr 2026 20:12:21 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221320-2300-K4hEmM98wg@https.bugzilla.kernel.org/>
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

--- Comment #1 from Witold Baryluk (witold.baryluk+kernel@gmail.com) ---
Created attachment 309820
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309820&action=3Dedit
devcoredump

devcoredump attached

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
