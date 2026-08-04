Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C83C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F1410E143;
	Tue,  4 Aug 2026 11:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gbGucMhq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B1710E143
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 11:23:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E8C7401BE
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 11:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E873C2BCF4
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785842633;
 bh=79ZM1ljMQiVP9bZtc6Dq7n8DZtIcqmM6pCBuoT0FWx0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=gbGucMhqMgo+8CZx3hRryQS+TDvh6h7xf5+jPaiXx/4lQKp5io7BhjFhSdMKlEgys
 4brjO1jA6f7EwnwPvNAj/b+vYBfdFHGOFmI/IYGmnywr+hJ7q5/xjQ0UpSGgEoGmya
 5vAg+oWEQhPDww4c2fq3MDmdDnWpaOJhl96gdNm16pImC7fDWW4K0Ju2x+IZGRHjB8
 cVqLhWDmRkGwgy6jSRAG42afPFBkz9anM2LhYRlS/WAq8gbWbNQzLS4fZBjKixjnHH
 PlQ9EdM9gaoduDEdsWlvv9DenMZMVG40Tz9rd2Nl95XFgGR3GDFDHEHRXymDQ5p70p
 Bb1OVDlNDLTCQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 19F42C41612; Tue,  4 Aug 2026 11:23:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] Backlight regression with 7.1.6
Date: Tue, 04 Aug 2026 11:23:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221827-2300-a83E2zbWsZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221827-2300@https.bugzilla.kernel.org/>
References: <bug-221827-2300@https.bugzilla.kernel.org/>
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

--- Comment #2 from Raymond Jay Golo (rjgolo@gmail.com) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #1)
> (In reply to Raymond Jay Golo from comment #0)
> > Upon upgrading to 7.1.6, backlight at 100% is set to dimmest level.
>=20
> @Mario, this is apparently caused by the following change of yours that w=
as
> backported to 7.1.y: f1b5d8f9cc54ae ("drm/amd/display: Fix backlight
> max_brightness to match exported range") [v7.2-rc4, v7.1.6 (1191285ecb423=
3),
> v6.18.42]
>=20
> @Raymond: This might be a general problem or something specific to the
> backport. Testing 7.2-rc6 or later is thus advised. You might also want to
> attach dmesg files separately from a working and a broken kernel, as they
> most likely will be helpful for debugging.

I'll try compiling next weekend as I currently use this laptop for work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
