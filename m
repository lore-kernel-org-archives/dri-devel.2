Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832DDCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8FC10E746;
	Mon, 18 May 2026 09:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iw3rZo4E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A33410E746
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:29:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CDD064454F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3846C2BCF6
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779096566;
 bh=0fX79frWM6xyFCaAu4yOxCdFDjamBWouzWz+MBWrE0E=;
 h=From:To:Subject:Date:From;
 b=iw3rZo4EcSoR87O2K4hGl96eTZ0ftYs/WVRlkaakj/Q1aVxEhaXuKnIiUkFyGI9TQ
 MMCiKwvMAF545LiulNaua+YfB7FpgLZTOiFsvzPAmH2ocu/S4iJFb1oXZlv5kDnylw
 sEMtVLcm3GCO965Z9IDXy+K+kjdNWMCFE7r+DrbqJd76Uw/p+3keKUJG/yucpVMyim
 W06Ua79KcIjMxB1CdOFerPsXXTdHRbAg2OnZ3rQYMSTCn98sbjyAAjRYR+m9gIMRH8
 bsJDO1Is7r4XuzbiDNlRgWxp++klbe8phBE8JQBoB7prGOPLnSu6tWMZd7DtfN/7K0
 c8+IZ64kB4MPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9FF15C41613; Mon, 18 May 2026 09:29:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221543] New: [nouveau] RTX 5080 (GB203): Xid:13 WIDTH CT
 Violation on kernels 6.16.7+ causing system hang
Date: Mon, 18 May 2026 09:29:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: wojciech.bielawski@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221543-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221543

            Bug ID: 221543
           Summary: [nouveau] RTX 5080 (GB203): Xid:13 WIDTH CT Violation
                    on kernels 6.16.7+ causing system hang
           Product: Drivers
           Version: 2.5
          Hardware: Other
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: wojciech.bielawski@gmail.com
        Regression: No

Hardware: Lenovo ThinkStation P8 (30HJS53F00)
  CPU: AMD Threadripper PRO 7975WX (32C/64T)
  GPU: NVIDIA GeForce RTX 5080 (GB203, rev a1) [PCI 81:00.0]
  RAM: 128GB
  OS: Fedora 43 (Workstation)
  Affected kernels: 6.16.7 through 7.0.8 (latest tested)
  Working kernel: 6.13.6-200.fc41

  Problem:
  On kernels 6.16.7 and later, the nouveau driver triggers repeated Xid:13
  (WIDTH CT Violation) errors on all 7 GPCs of the RTX 5080. The errors are
  triggered by Chrome GPU acceleration but occur even with hardware
  acceleration disabled in Chrome.

  The error cascade is:
  1. Chrome triggers Xid:13 on nouveau
  2. Chrome GPU channel is killed
  3. Xid:13 repeats every ~20 minutes
  4. Xwayland encounters an MMU fault
  5. System hangs completely (B0E1/S202 diagnostic codes on chassis)

  Reproducer:
  - Boot any kernel >=3D 6.16.7 with nouveau on RTX 5080
  - Open Chrome (or Chromium)
  - Xid:13 errors appear within seconds in dmesg
  - System hangs within hours (sometimes minutes)

  What does NOT help:
  - Switching to X11 (hangs before reaching graphical mode)
  - Disabling Chrome hardware acceleration
  - Disabling C-States in BIOS
  - glxgears/GPU stress tests do NOT reproduce (only Chrome triggers it)

  Workaround:
  Downgrade to kernel 6.13.6-200.fc41. On that kernel, nouveau reports
  "unknown chipset" for RTX 5080 (expected, as GB203 support was added
  later), so the proprietary NVIDIA driver is required.

  This suggests a regression was introduced between 6.13.6 and 6.16.7 in
  nouveau's GB203/RTX 5080 support path.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
