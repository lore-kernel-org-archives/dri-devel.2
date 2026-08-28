Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC3C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 04:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F08710E44A;
	Fri, 28 Aug 2026 04:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rmcs7c9+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADBD10E44A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 04:35:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BCC4341672
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 04:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B8ECC19425
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 04:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787891710;
 bh=KTkOqxD/MNz+cwv7mWDDZLIJgrxdhT4REbOsFlNTSyA=;
 h=From:To:Subject:Date:From;
 b=rmcs7c9+DdK/mkQjnSh58GiydVKQzjkPhpEUQYOM+BbG5sC3EsiZIrDllxg9GJg4Q
 VCNncIvyLnc+uJdo9G+U4mLzBnSBUi71sv6x5gneA26sJ4Mv49D2VWYkoLN1d0lRp3
 EIlCt4mC5t23R+LsoFsxnc2o3skqlqATRHkC7HRawrdfutVca9XlJ93rfYKrwF7SPT
 IGDvCKKXL6WFQvNBx17otjQeSJM0jYLetl22T13KZ5DemSd5s6ClAthQ/wHdcTiufL
 8u4VxWOhyuv56UGlUjaClvM/c/mwMBEwavzJAaNRin9mvwbiZ8rOauzgzEFW6rvXbZ
 J5/bjpUllChcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 7E3EDC3279F; Fri, 28 Aug 2026 04:35:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221929] New: amdgpu flip_done timed out stills at ASUS ROG
 Strix 2022 laptop(G713RM)
Date: Fri, 28 Aug 2026 04:35:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: twyoda@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221929-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221929

            Bug ID: 221929
           Summary: amdgpu flip_done timed out stills at ASUS ROG Strix
                    2022 laptop(G713RM)
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: twyoda@gmail.com
        Regression: No

Created attachment 310745
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310745&action=3Dedit
kernel config for version 7.0.12

The amdgpu flip_done timed out cause GUI hang starts from 7.1.x .

The last version I tried are 7.2 and 7.1.10 , the flip_done timed out happe=
ned
randomly.

I had 7.0.12 kernel which didn't cause "flip_done timed out" issue ever.

Until yesterday, I check the possible cause with Gemini. The Gemini suggest=
 an
option setting is lower the screen fresh rate.

My laptop (ASUS G713RM) equipped with LCD screen which refresh rate up to
360Hz.

Normally I use the default refresh rate setting, that is at 360Hz refresh r=
ate.
This high refresh rate did not cause any trouble, until I upgrade kernel to
7.1.x.

I tried almost every version of 7.1.x including 7.1.10, and the "flip_done
timed out" issue happened at random time while I was using after each boot.

Finally, I followed the suggestion of Gemini, I changed the screen refresh =
rate
from 360Hz to 60Hz. Using kernel 7.1.10, and it work flawlessly now.

I filed this as a bug is "Why does 7.0.12 work at 360Hz, but 7.1.x(including
7.2) doesn't".

BTW, the boot parameter for 7.0.12 is "amdgpu.dpm=3D1 amd_pmc.debug=3D1
pcie_aspm=3Doff nvme_core.default_ps_max_latency_us=3D0 tpm_tis.interrupts=
=3D0
nmi_watchdog=3D1 mem_sleep_default=3Ddeep".
the same boot parameter set for 7.1.x always caused "flip_done timed out" i=
ssue
randomly. That including 7.1.10.

Yesterday, after I set refresh rate to 60Hz, I boot 7.1.10 with parameter
"amd_pmc.debug=3D1 nmi_watchdog=3D1" and it works perfect now. It seems the=
 lower
refresh rate is the key.
Therefore, I think it is a regression of amdgpu related driver.

The attachment is my kernel config of version 7.0.12.
The kernel config I used for 7.1.10 is just a copy of version 7.0.12.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
