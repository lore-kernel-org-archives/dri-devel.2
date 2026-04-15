Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8EEF4198D
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DECA310E16F;
	Wed, 15 Apr 2026 17:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UMJr1meX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76F210E16F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:27:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D8A5D600AD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 683EAC19424
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776274046;
 bh=sFmp8HpmagSparr3wifvKhiCV4vygGhckqUFty+Mm3Q=;
 h=From:To:Subject:Date:From;
 b=UMJr1meXE4lnL9UK99O1Pq0MPoeEwla02q43TbKdxF+rY4jQRc+NlwoZmhaNeiAmi
 nuQeVUUZXhnLBpqESZD5ihWKRjjUzA4WiTmmFIcHwlSAAzj5zMezrn+DtEYXhkPaZk
 BOIS2Ibx4yUBDsUkFqA7yC5YLFdMKPqaMfgIC7QZy/Ax6+iHQqCdvNH5AAfmcOj1Qe
 f6+2GV3rTrqsWWfgBfIhNdVSrNeIHJ9estn+h7RYuoso2n66Ik5Y1CSC8WkMl20p07
 aCXlW7Hz2jv5l94ZiglupzeJzcFYxKp+qN05KshWf44e9PxiFO8xKPVe1OJ6GErfgb
 tzUhi4B3PJEcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 5D59FC4160E; Wed, 15 Apr 2026 17:27:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221369] New: AMDGPU VM_L2_PROTECTION_FAULT causes GPU hang and
 full system freeze (Firefox/WebRender)
Date: Wed, 15 Apr 2026 17:27:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: webmaster@ltspiceusers.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221369-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221369

            Bug ID: 221369
           Summary: AMDGPU VM_L2_PROTECTION_FAULT causes GPU hang and full
                    system freeze (Firefox/WebRender)
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: webmaster@ltspiceusers.ch
        Regression: No

Created attachment 309873
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309873&action=3Dedit
Full dmesg log captured immediately after the AMDGPU VM_L2_PROTECTION_FAULT
freeze.

The system freezes completely when Firefox (WebRender) triggers repeated AM=
DGPU
VM_L2_PROTECTION_FAULT loops.=20
The GPU enters a retry page fault loop and never recovers. The entire system
becomes unresponsive and requires a hard reset.

Hardware:
VGA: Advanced Micro Devices, Inc. [AMD/ATI] Picasso/Raven 2 [Radeon Vega Se=
ries
/ Vega Mobile] [1002:15d8] (rev c8)

Kernel:
6.8.0-110-generic

Distribution:
Linux Mint 22.3 (Ubuntu 24.04 base)

Reproduction steps:
1. Start Firefox
2. Open multiple tabs with video or WebGL content
3. Scroll or switch tabs
4. System freezes within 1=E2=80=935 minutes (intermittent)

Relevant dmesg excerpt:
amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:4 pasid:32775, pro=
cess
firefox-bin)
VM_L2_PROTECTION_FAULT_STATUS:0x00441051
Faulty UTCL2 client ID: TCP (0x8)
PERMISSION_FAULTS: 0x5
RW: 0x1
This sequence repeats in a tight loop until the system freezes.

Full dmesg log can be attached if needed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
