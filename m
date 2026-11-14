Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1977606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yw0tppc5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C7810E44E;
	Sat, 14 Nov 2026 03:01:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4B810E500
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:01:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD20941A49
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A10C81F000C5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794625273;
 bh=zxYw5KY1+uasZJo29fiQbRc0ntN8qYA8QPiC346ayxs=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=Yw0tppc5Rq5oI5vpP+ztKffvo728+fF60u1f1L801RqV3WKHyqlYpwWCDZAHlCZyE
 8svOcn7D6/ZC7s06/DSeTsLjQ09uMNDOkuQP2Nplro6qEN4LQqt+4cxbXJFNpvcdII
 2Ap//nJa+IJDJbxVdXAecI45/a//K+qttm4FX+JOfOeTwl1M3LZp2FTLtb9NmnZqOF
 y8UWQ2gyJhYa4TeR2Rr/WltIX7r8hztMCW+MSTTh2O8XL3aiy+TlWz4+8vCFYvwt2j
 h2EiucOzum7sg5UUuqS9ASov/AMiZVGwbqBQmSYH099zbW8hWjQRp1cTWW/m94CPTN
 hTHnWaXSQrbYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 96620C41616; Sat, 14 Nov 2026 03:01:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222265] amdgpu: RX 7600 defaults to limited RGB range
 (washed-out blacks) over HDMI since kernel 7.3.4
Date: Sat, 14 Nov 2026 03:01:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mister.freeman@laposte.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-222265-2300-r7uQQ80qgW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222265-2300@https.bugzilla.kernel.org/>
References: <bug-222265-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugzilla.kernel.org/show_bug.cgi?id=3D222265

--- Comment #1 from Barto (mister.freeman@laposte.net) ---
Created attachment 311465
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311465&action=3Dedit
a clean boot `dmesg` log (`dmesg_7.3.4_default.txt`) captured without any E=
DID
override.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
