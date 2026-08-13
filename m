Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA3C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A54010E320;
	Thu, 13 Aug 2026 13:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t6Gs+TdG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B3910E320
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:00:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C9C804120E
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC2DAC2BCF4
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786626050;
 bh=hJc5FvyWgGR9ginJljhBMaNpHQAA1O60KGsD2JwQrOM=;
 h=From:To:Subject:Date:From;
 b=t6Gs+TdGT1iwiz7tdEY1K//V4vkyk1u0dgZT1BwMTID9NEMeHLmMFGqX9h6d8Tkxi
 FSOk+iJKkCeH7Z+s2nF/rd+IFN0yMEQeFU9reoC0xeOmv9aGNllgM4bK1Ogzwi+3Zm
 ct/q+i3BLe53gNjbAWW5kvCymCX6Xu7Jn2Y83V3L+cONrS+yyTLu40HkgxkkfEthHm
 hU8Zij4MXoLn838C05szNqZOcwuT+HXYfTCYxaO6BzAqRs2G/zk6zIBus6Yxk5w8hU
 HJI2JpSy8TdlC6ECaUfDmTR61iwyl2C86XnG1lQn4I9ZbT/qNGJZXoTq7KtPa7YkEA
 blpgYVUOQC1Dw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8CC10C41612; Thu, 13 Aug 2026 13:00:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221879] New: Max brightness broken since 6.18.42 / 7.1.6
Date: Thu, 13 Aug 2026 13:00:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: augustin@trancart.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221879-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221879

            Bug ID: 221879
           Summary: Max brightness broken since 6.18.42 / 7.1.6
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: augustin@trancart.eu
        Regression: No

# Description

When setting my brightness to 100%, the display becomes very dim. It goes b=
ack
to bright when going back to 95%.

According to some users [1], this affects framework 16=C2=A0laptops (at lea=
st AMD
5900HX NVIDIA RTX 3070 Max-Q and FW16 AMD 7840HS without dGPU). One user al=
so
reported this with another non-framework laptop.

Seemingly all linux distros are affected (at least Fedora Silverblue, NixOS
26.05, EndeavourOS Linux 7.1.6) and various DEs.

I've identified 490ceacd2162de919a142bcb4eff363bb493b1de as a potential cul=
prit
(in the 6.18.43 branch) because I don't reproduce any more if I build my ke=
rnel
with this commit reverted (The commit is
1191285ecb4233e5bf907da7e9394d7999055566 for the 7.1.6 branch).

[1]:
https://community.frame.work/t/screen-goes-very-dim-when-reaching-100-brigh=
tness/84042

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
