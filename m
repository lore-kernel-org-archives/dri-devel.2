Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6587ACA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7678B10EB48;
	Fri,  9 Oct 2026 20:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gLHxGoYV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7857C10EB48
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EF17D60267
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A28D0C2BCF4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791577715;
 bh=MSeuHak2TkNPdOYUIzUae+YniTWa2Cgy/RgeCMfHBOg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=gLHxGoYVoahSQHvtOy6Vsx030iN3FxRmEcizxVEXtvDY7hWEyVSNXZ+oEkQ6Xp/tU
 yHX+EahN0n9KEldrTISVqe6feX22MOqvaypyNUWNa9YXQR/bQZPn0MEXMzgS2E8cBp
 yCSV3K8mLlpaSGmUctuZ+NlMKFozk0TMHUFrmkN71NvER9eNsThl3snZjB0Tyn/WHW
 iaruk7a4vxZL4hLWFZWIWurORhApNoXU69DngWF/q73E35apBg8WKp3UlxGM9VE9Tk
 09M8/kJZ3jaH1zOZq3Or+4z5YqcYYoVhN7lxo9b19WtELxHQ9EussRS1lkf+wqV7Mw
 W0RFtrjZ8ZDQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 92FB6C4160E; Fri,  9 Oct 2026 20:28:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222109] [amdgpu Picasso 1002:15d8] gfxhub UTCL2 SQC permission
 fault -> ring gfx timeout when DPM forced high (repro on LTS 6.18 too)
Date: Fri, 09 Oct 2026 20:28:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aleksey16.11.2000@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-222109-2300-XpgETzBkyw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222109-2300@https.bugzilla.kernel.org/>
References: <bug-222109-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222109

--- Comment #5 from Alex (aleksey16.11.2000@gmail.com) ---
Created attachment 311050
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311050&action=3Dedit
tlp-stat -c effective config + tlp-stat-g/p (force_level high vs auto)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
