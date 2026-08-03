Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8DFC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BF410E6C7;
	Mon,  3 Aug 2026 13:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b4O6+nAp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2FF10E6C7
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:12:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BF53F4364B
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A094EC2BCF4
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785762767;
 bh=vybAne3dfkm0ohjH43jwFXreZkIeGQPaAEaE83SsklU=;
 h=From:To:Subject:Date:From;
 b=b4O6+nApAxCkDWhFon+HrMAsUI2Va/NnqgXb6cNheJ9DKZMKTamA9qOW3FakUzch7
 ur11vgerjXSqiWIzGB+Erc+uJ8VQ4HUzIlwuOap9RNAvMSYF/Rw8DDskxHbt8x+2nx
 /Mk+6a+gS+zdGX2kij1hbmc1S6GQkU+CKbpdUhF7LY/ahoQvgZDaf3omGjW4K8zydk
 OfyUo/oT7AFSuiJSfGp5QBM44VrSJ9/q2g+luno+OcLP8CTFWv1sYFCu+7eHPEDy6l
 PVnw1jN841+be88x4mIx7tPd9POgYxHrQ5nHMw6UgPM7+HR/dqLNCYiky1Q5DogGhU
 9ZQi2k+RdrILg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 85295C53BBF; Mon,  3 Aug 2026 13:12:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] New: Backlight regression with 7.1.6
Date: Mon, 03 Aug 2026 13:12:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjgolo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221827-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221827

            Bug ID: 221827
           Summary: Backlight regression with 7.1.6
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: rjgolo@gmail.com
        Regression: No

Upon upgrading to 7.1.6, backlight at 100% is set to dimmest level.

cat /sys/class/backlight/amdgpu_bl2/*brightness

actual_brightness
brightness
max_brightness

100% or setting brightness same to max or less 1 than max - 7.1.6
0
65535
65535

98% - 7.1.6 - brightness restored
65290
64224
65535

100% - reverted 1191285ecb4233e5bf907da7e9394d7999055566 - ok
63576
62451
62451

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
