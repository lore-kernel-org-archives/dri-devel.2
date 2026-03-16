Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8510FF53D78
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8CB10E2FC;
	Mon, 16 Mar 2026 17:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nm/irQla";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BE910E2FC
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:09:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D8738435D3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8AFCC2BC9E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773680972;
 bh=QexbhSGEv/0a8kQr+fQmdtsTSskVzE/iAWkEKDrZ6Dk=;
 h=From:To:Subject:Date:From;
 b=nm/irQlaT+xPmrSsq2yl32b8+l5mK6wGbRdZ9zpBwMQlsKom+pWimi8XvHHB9o3d8
 C6fZ5WJWqCwZcnHJQI7t+KR9pLV4UDJ0zusgKSxB3oR7l1K7ssWFv7bmq3eMUXjesY
 KTsNKowlRqSLM3pCVQvvTi1GumDoctC+Jtf1mL5//xZcyZrII/6L4uyAF+SPCNqmJ+
 aAhf2WlkRftuWT34IRllr3IArhXNNc3aprWJO1dhvEEPBd9ML9vmfiJq1ijG9h/lI7
 /tnpARoGmpZV0lYCFc9hHkZ1HInLFG0e1j3FzE1nTBcgypyA/mAmhaWvSu8c3lUf7s
 UOHtlT2kXS6Qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8A9B2C41614; Mon, 16 Mar 2026 17:09:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221245] New: Regression: Black screen on boot with AMD FirePro
 M4000 on kernel 6.19.7
Date: Mon, 16 Mar 2026 17:09:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: denizomer10@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221245-2300@https.bugzilla.kernel.org/>
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

            Bug ID: 221245
           Summary: Regression: Black screen on boot with AMD FirePro
                    M4000 on kernel 6.19.7
           Product: Drivers
           Version: 2.5
          Hardware: i386
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: denizomer10@icloud.com
        Regression: No

Regression observed between kernel 6.18 and 6.19.7.

Hardware:
Laptop: HP EliteBook 8570w
CPU: Intel Core i7-3740QM
GPU: AMD FirePro M4000 (GCN 1.0 / Southern Islands)

Working kernel:
6.18.x

Broken kernel:
6.19.7

Problem:
System boots to a black screen and the display never initializes.

Distribution tested:
Fedora

Regression confirmed because kernel 6.18 boots normally on the same system.

Possible subsystem:
DRM / AMDGPU or Radeon driver initialization.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
