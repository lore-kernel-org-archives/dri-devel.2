Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2B4C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA0710E17F;
	Mon, 24 Aug 2026 17:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rlPFpp7k";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FDE10E17F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:45:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D5BC43ACD
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EC58C19425
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787593546;
 bh=XbeVySO7kwmV4kHZlI+nUtYlj94GGmkZzdTa8IoftSM=;
 h=From:To:Subject:Date:From;
 b=rlPFpp7kImlghcoA7ha1UjtoZCMwYwM5dO6aCBNg5+WGHCaBvgCf1xLQJd/pdLrGs
 GDMV+r+PYL9JIbe1ohamc4xm1vOpKRAvfqrHaGRMIC7vEkLjHu3cYUM0dUj3lmISpI
 ZcrmvgwcnJHD01qCrYjlVTOyRug3hZ/Ctv/8nesf+qLxdaJ7Y+dHzhJ8G7LJFwQ5mt
 C6YJdMA44N5Ha2366Lrx8l1/0sgytVxZW+MJQ9Z7tJJJVJKX5JWT2TQJiIHwUTWw5D
 dGRfuA62W/ePPMTx1udliuW1mOBauqH+FE2rhRGb+Qa2tryT0JnRIm2J2LhQWkwTvc
 PRgii/cASAW5g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id E7724C3279F; Mon, 24 Aug 2026 17:45:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221918] New: amdgpu - Cannot find any crtc or sizes on AMD card
 with no crtc by design :-)
Date: Mon, 24 Aug 2026 17:45:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kallisti5@unixzen.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221918-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221918

            Bug ID: 221918
           Summary: amdgpu - Cannot find any crtc or sizes on AMD card
                    with no crtc by design :-)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: kallisti5@unixzen.com
        Regression: No

Getting a loop of "[drm] Cannot find any crtc or sizes" on an AMD Card with=
 no
CRTC's by design (AMD Radeon Pro V620)

Since this is a compute-only GPU, the looping "[drm] Cannot find any crtc or
sizes" really isn't helpful and keeps the card in an incomplete state.

Kernel: 7.1.6-1-cachyos
Architecture: x86_64

```
[ 7306.784725] amdgpu 0000:05:00.0: PSP is resuming...
[ 7306.818820] amdgpu 0000:05:00.0: reserve 0xa00000 from 0x877d000000 for =
PSP
TMR
[ 7306.977926] amdgpu 0000:05:00.0: GECC is enabled
[ 7307.012979] amdgpu 0000:05:00.0: SECUREDISPLAY: optional securedisplay ta
ucode is not available
[ 7307.012986] amdgpu 0000:05:00.0: SMU is resuming...
[ 7307.036361] amdgpu 0000:05:00.0: SMU is resumed successfully!
[ 7307.037024] amdgpu 0000:05:00.0: kiq ring mec 2 pipe 1 q 0
[ 7307.052799] amdgpu 0000:05:00.0: [drm] DMUB hardware initialized:
version=3D0x02020022
[ 7307.055461] amdgpu 0000:05:00.0: [drm] Cannot find any crtc or sizes
[ 7307.055475] amdgpu 0000:05:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub=
 0
[ 7307.055477] amdgpu 0000:05:00.0: ring gfx_0.1.0 uses VM inv eng 1 on hub=
 0
[ 7307.055478] amdgpu 0000:05:00.0: ring comp_1.0.0 uses VM inv eng 4 on hu=
b 0
[ 7307.055478] amdgpu 0000:05:00.0: ring comp_1.1.0 uses VM inv eng 5 on hu=
b 0
[ 7307.055479] amdgpu 0000:05:00.0: ring comp_1.2.0 uses VM inv eng 6 on hu=
b 0
[ 7307.055479] amdgpu 0000:05:00.0: ring comp_1.3.0 uses VM inv eng 7 on hu=
b 0
[ 7307.055480] amdgpu 0000:05:00.0: ring comp_1.0.1 uses VM inv eng 8 on hu=
b 0
[ 7307.055480] amdgpu 0000:05:00.0: ring comp_1.1.1 uses VM inv eng 9 on hu=
b 0
[ 7307.055481] amdgpu 0000:05:00.0: ring comp_1.2.1 uses VM inv eng 10 on h=
ub 0
[ 7307.055481] amdgpu 0000:05:00.0: ring comp_1.3.1 uses VM inv eng 11 on h=
ub 0
[ 7307.055482] amdgpu 0000:05:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 on =
hub
0
[ 7307.055482] amdgpu 0000:05:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[ 7307.055483] amdgpu 0000:05:00.0: ring sdma1 uses VM inv eng 14 on hub 0
[ 7307.055484] amdgpu 0000:05:00.0: ring sdma2 uses VM inv eng 15 on hub 0
[ 7307.055484] amdgpu 0000:05:00.0: ring sdma3 uses VM inv eng 16 on hub 0
[ 7307.055485] amdgpu 0000:05:00.0: ring vcn_dec_0 uses VM inv eng 0 on hub=
 8
[ 7307.055485] amdgpu 0000:05:00.0: ring vcn_enc_0.0 uses VM inv eng 1 on h=
ub 8
[ 7307.055486] amdgpu 0000:05:00.0: ring vcn_enc_0.1 uses VM inv eng 4 on h=
ub 8
[ 7307.055487] amdgpu 0000:05:00.0: ring vcn_dec_1 uses VM inv eng 5 on hub=
 8
[ 7307.055487] amdgpu 0000:05:00.0: ring vcn_enc_1.0 uses VM inv eng 6 on h=
ub 8
[ 7307.055488] amdgpu 0000:05:00.0: ring vcn_enc_1.1 uses VM inv eng 7 on h=
ub 8
[ 7307.055488] amdgpu 0000:05:00.0: ring jpeg_dec uses VM inv eng 8 on hub 8
[ 7307.064172] amdgpu 0000:05:00.0: [drm] Cannot find any crtc or sizes
[ 7313.912653] amdgpu 0000:05:00.0: [drm] PCIE GART of 512M enabled (table =
at
0x000000877EC00000).
[ 7313.912699] amdgpu 0000:05:00.0: PSP is resuming...
[ 7313.945796] amdgpu 0000:05:00.0: reserve 0xa00000 from 0x877d000000 for =
PSP
TMR
[ 7314.106389] amdgpu 0000:05:00.0: GECC is enabled
[ 7314.141635] amdgpu 0000:05:00.0: SECUREDISPLAY: optional securedisplay ta
ucode is not available
[ 7314.141640] amdgpu 0000:05:00.0: SMU is resuming...
[ 7314.164987] amdgpu 0000:05:00.0: SMU is resumed successfully!
[ 7314.165648] amdgpu 0000:05:00.0: kiq ring mec 2 pipe 1 q 0
[ 7314.180852] amdgpu 0000:05:00.0: [drm] DMUB hardware initialized:
version=3D0x02020022
[ 7314.183474] amdgpu 0000:05:00.0: [drm] Cannot find any crtc or sizes
[ 7314.183491] amdgpu 0000:05:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub=
 0
[ 7314.183492] amdgpu 0000:05:00.0: ring gfx_0.1.0 uses VM inv eng 1 on hub=
 0
[ 7314.183493] amdgpu 0000:05:00.0: ring comp_1.0.0 uses VM inv eng 4 on hu=
b 0
[ 7314.183494] amdgpu 0000:05:00.0: ring comp_1.1.0 uses VM inv eng 5 on hu=
b 0
[ 7314.183495] amdgpu 0000:05:00.0: ring comp_1.2.0 uses VM inv eng 6 on hu=
b 0
[ 7314.183495] amdgpu 0000:05:00.0: ring comp_1.3.0 uses VM inv eng 7 on hu=
b 0
[ 7314.183496] amdgpu 0000:05:00.0: ring comp_1.0.1 uses VM inv eng 8 on hu=
b 0
[ 7314.183497] amdgpu 0000:05:00.0: ring comp_1.1.1 uses VM inv eng 9 on hu=
b 0
[ 7314.183497] amdgpu 0000:05:00.0: ring comp_1.2.1 uses VM inv eng 10 on h=
ub 0
[ 7314.183498] amdgpu 0000:05:00.0: ring comp_1.3.1 uses VM inv eng 11 on h=
ub 0
[ 7314.183498] amdgpu 0000:05:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 on =
hub
0
[ 7314.183499] amdgpu 0000:05:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[ 7314.183500] amdgpu 0000:05:00.0: ring sdma1 uses VM inv eng 14 on hub 0
[ 7314.183500] amdgpu 0000:05:00.0: ring sdma2 uses VM inv eng 15 on hub 0
[ 7314.183501] amdgpu 0000:05:00.0: ring sdma3 uses VM inv eng 16 on hub 0
[ 7314.183501] amdgpu 0000:05:00.0: ring vcn_dec_0 uses VM inv eng 0 on hub=
 8
[ 7314.183502] amdgpu 0000:05:00.0: ring vcn_enc_0.0 uses VM inv eng 1 on h=
ub 8
[ 7314.183502] amdgpu 0000:05:00.0: ring vcn_enc_0.1 uses VM inv eng 4 on h=
ub 8
[ 7314.183503] amdgpu 0000:05:00.0: ring vcn_dec_1 uses VM inv eng 5 on hub=
 8
[ 7314.183503] amdgpu 0000:05:00.0: ring vcn_enc_1.0 uses VM inv eng 6 on h=
ub 8
[ 7314.183504] amdgpu 0000:05:00.0: ring vcn_enc_1.1 uses VM inv eng 7 on h=
ub 8
[ 7314.183504] amdgpu 0000:05:00.0: ring jpeg_dec uses VM inv eng 8 on hub 8
[ 7314.191346] amdgpu 0000:05:00.0: [drm] Cannot find any crtc or sizes
[ 7320.089634] amdgpu 0000:05:00.0: [drm] PCIE GART of 512M enabled (table =
at
0x000000877EC00000).
[ 7320.089679] amdgpu 0000:05:00.0: PSP is resuming...
[ 7320.123854] amdgpu 0000:05:00.0: reserve 0xa00000 from 0x877d000000 for =
PSP
TMR
[ 7320.282870] amdgpu 0000:05:00.0: GECC is enabled
[ 7320.317802] amdgpu 0000:05:00.0: SECUREDISPLAY: optional securedisplay ta
ucode is not available
[ 7320.317808] amdgpu 0000:05:00.0: SMU is resuming...
[ 7320.341340] amdgpu 0000:05:00.0: SMU is resumed successfully!
[ 7320.342009] amdgpu 0000:05:00.0: kiq ring mec 2 pipe 1 q 0
[ 7320.357804] amdgpu 0000:05:00.0: [drm] DMUB hardware initialized:
version=3D0x02020022
[ 7320.360473] amdgpu 0000:05:00.0: [drm] Cannot find any crtc or sizes
[ 7320.360497] amdgpu 0000:05:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub=
 0
[ 7320.360499] amdgpu 0000:05:00.0: ring gfx_0.1.0 uses VM inv eng 1 on hub=
 0
[ 7320.360500] amdgpu 0000:05:00.0: ring comp_1.0.0 uses VM inv eng 4 on hu=
b 0
[ 7320.360501] amdgpu 0000:05:00.0: ring comp_1.1.0 uses VM inv eng 5 on hu=
b 0
[ 7320.360503] amdgpu 0000:05:00.0: ring comp_1.2.0 uses VM inv eng 6 on hu=
b 0
[ 7320.360503] amdgpu 0000:05:00.0: ring comp_1.3.0 uses VM inv eng 7 on hu=
b 0
[ 7320.360504] amdgpu 0000:05:00.0: ring comp_1.0.1 uses VM inv eng 8 on hu=
b 0
[ 7320.360505] amdgpu 0000:05:00.0: ring comp_1.1.1 uses VM inv eng 9 on hu=
b 0
[ 7320.360506] amdgpu 0000:05:00.0: ring comp_1.2.1 uses VM inv eng 10 on h=
ub 0
[ 7320.360507] amdgpu 0000:05:00.0: ring comp_1.3.1 uses VM inv eng 11 on h=
ub 0
[ 7320.360507] amdgpu 0000:05:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 on =
hub
0
[ 7320.360508] amdgpu 0000:05:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[ 7320.360509] amdgpu 0000:05:00.0: ring sdma1 uses VM inv eng 14 on hub 0
[ 7320.360510] amdgpu 0000:05:00.0: ring sdma2 uses VM inv eng 15 on hub 0
[ 7320.360511] amdgpu 0000:05:00.0: ring sdma3 uses VM inv eng 16 on hub 0
[ 7320.360512] amdgpu 0000:05:00.0: ring vcn_dec_0 uses VM inv eng 0 on hub=
 8
[ 7320.360513] amdgpu 0000:05:00.0: ring vcn_enc_0.0 uses VM inv eng 1 on h=
ub 8
[ 7320.360513] amdgpu 0000:05:00.0: ring vcn_enc_0.1 uses VM inv eng 4 on h=
ub 8
[ 7320.360514] amdgpu 0000:05:00.0: ring vcn_dec_1 uses VM inv eng 5 on hub=
 8
[ 7320.360515] amdgpu 0000:05:00.0: ring vcn_enc_1.0 uses VM inv eng 6 on h=
ub 8
[ 7320.360516] amdgpu 0000:05:00.0: ring vcn_enc_1.1 uses VM inv eng 7 on h=
ub 8
[ 7320.360516] amdgpu 0000:05:00.0: ring jpeg_dec uses VM inv eng 8 on hub 8
[ 7320.369098] amdgpu 0000:05:00.0: [drm] Cannot find any crtc or sizes
[ 7328.025462] amdgpu 0000:05:00.0: [drm] PCIE GART of 512M enabled (table =
at
0x000000877EC00000).
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
