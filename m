Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA51606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+HwHgf/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E51810E500;
	Sat, 14 Nov 2026 03:01:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9409810E500
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:01:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 773824358D
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5904C1F000C5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794625299;
 bh=B7vrw37aqxymd8hCSR1Ob9elrXuC1vF/HQ3HcMQ1Z7M=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=m+HwHgf/jkvp7Z2fczIJ0jVoaq28sOtISzCK0k8HvGHhmQAnCFXEBJX7s9MhCT+tp
 dsWLjIIUhRdARiwetHdRiXkDXoJ75dxcVzNAm5YDBUmDe3ZggthRjciYFNvrlJg8n/
 T7pb7zpIQ++rxTXvFgRSZKmF3Po7zDXSZPp8iCqky3FG/LdV7heAMN9c5OnX/Qxhlo
 1x5tVcIdyp6xLeRLmjUFut9rMwjy75j/nqxlMlb9B3yUQTtDX6PrRzPoQx0gXOkX8i
 mFTvSRTLyMLEB/m8+EmsuMBsEo0t//5VMTWj8kEYf+46IZAh967kfTtVdeSvNO8dBE
 i8lpQVfFMK+pw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 513CFC41616; Sat, 14 Nov 2026 03:01:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222265] amdgpu: RX 7600 defaults to limited RGB range
 (washed-out blacks) over HDMI since kernel 7.3.4
Date: Sat, 14 Nov 2026 03:01:39 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222265-2300-3x1WJSAzce@https.bugzilla.kernel.org/>
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

--- Comment #2 from Barto (mister.freeman@laposte.net) ---
### Additional technical findings for bisecting / root cause:
- Simply clearing the `YCbCr 4:4:4` and `YCbCr 4:2:2` capability bits inside
the CTA-861 extension block (while keeping the CTA-861 block intact) does
**not** fix the issue at boot; `amdgpu` still defaults to limited RGB range
(16-235).
- Completely stripping the CTA-861 extension block (reducing the EDID to a
128-byte Base EDID 1.3 block so the driver treats the HDMI output as a DVI-=
D PC
monitor) immediately restores Full RGB range (0-255) from early KMS boot.
- This points directly to a regression in `amdgpu`'s default HDMI / CTA-861
color format or RGB quantization range selection logic introduced in kernel
7.3.x.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
