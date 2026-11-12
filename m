Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66860A6F7C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRUrXOBj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FF110E51C;
	Thu, 12 Nov 2026 06:50:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87B310E51C
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 06:50:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85E0742E21;
 Thu, 12 Nov 2026 06:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBDB1F00A05;
 Thu, 12 Nov 2026 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794466223;
 bh=+oJoV6mCBS25pJDjNj8gGzb2M1lx59JUUmORDtkuQmI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JRUrXOBjkVbKEsD5AyCcBF0AcUFel9IaKjiITAg1vlqDtbkSqlArJB8MVyHPZDIoB
 q6LvXt44P8IGfMxMl2pCEghqin/e5a9b6BUsylVLx/LNaHpR5D0lYPVRpC46hOOOYs
 j1vXeJIXjempzTRvHW1OwXy7F2g40kwWdmVoUI1pHhYKfy0XLvIiabfftwL96QRWV4
 iuwLu16vR14/X4dpDrHsTaFSRpdLJkTOV+sDWXRDCiuWvtl5Aw0nbwSsqwcJcrFCeu
 dniS1eZbY0n7yniVNtkOor3Bb3UpXuF5nAhnVZIEr0V3cLJ8bmCM7UKAYqTK85EOXA
 QBF81i90Y0+Bg==
Message-ID: <sashiko-outbox-210536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: cirrusfb: Fix overflow in the video memory check
To: "Weidong Wang" <weidongw@illinois.edu>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-c4-n053-v1-1-1e45ef75304c@illinois.edu>
References: <20261112-c4-n053-v1-1-1e45ef75304c@illinois.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:50:22 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] fbdev: cirrusfb: inaccurate Fixes trailer in
  cirrusfb_check_var() commit
--

commit fe8f501c4d16cf488da84bae27d1a683a157b106
Author: Weidong Wang <weidongw@illinois.edu>

> fbdev: cirrusfb: Fix overflow in the video memory check
>
> cirrusfb_check_var() raises xres_virtual to xres and then checks
> xres_virtual * yres_virtual against the video memory in 32-bit
> arithmetic. fb_set_var() checks the product for overflow, but only for
> the values passed in, before the driver raises xres_virtual. A mode with
> xres 65536, xres_virtual 640 and yres_virtual 65536 passes that check,
> becomes 65536 x 65536 in cirrusfb_check_var(), and the product wraps to
> 0, so the mode is accepted on a 4 MiB card with a line length of
> 65536 bytes. The framebuffer console then draws at offsets far past the
> end of the video memory mapping.
>
> Do the multiplication in 64 bits.
>
> Found by an AI code review agent (an LLM-based bug-finding tool
> developed by Zijie Zhao and the submitter) and confirmed on an
> unmodified kernel, without error injection, on x86_64 under QEMU with
> -vga cirrus (GD5446, 4 MiB) and KASAN. FBIOPUT_VSCREENINFO with
> xres 65536, yres 128, xres_virtual 640, yres_virtual 65536 at 8 bpp is
> accepted as 65536x128, virtual 65536x65536. Booted with
> video=3Dcirrusfb:noaccel, fbcon's redraw then faults:
>
>   BUG: unable to handle page fault for address: ffffc90000b00000
>   RIP: 0010:cfb_imageblit+0xbc6/0x1970
>    soft_cursor+0x5eb/0xcd0
>    bit_cursor+0xb41/0x1910
>    hide_cursor+0x6e/0x1d0
>
> With acceleration enabled, text on the GD5446 is drawn with the blitter,
> which QEMU bounds, so the mode is accepted but nothing faults; drawing
> goes through the CPU with noaccel and on the Laguna chips, which always
> run without acceleration. Asked for without the wrap, as 65536x128 with
> a 65536x128 virtual resolution (8 MiB), the mode is rejected, as it
> should be.
>
> With this patch the mode is rejected with "virtual resolution too high
> to fit into video memory", and 1024x768x8 is still accepted.
>
> The reproducer, fix and changelog were drafted with AI assistance
> (Claude), then reviewed and tested by the submitter.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Cc: Zijie Zhao <zijie4@illinois.edu>
> Signed-off-by: Weidong Wang <weidongw@illinois.edu>

[Severity: Low]
Raising var->xres_virtual to var->xres and checking var->xres_virtual *
var->yres_virtual > pixels in cirrusfb_check_var() was introduced by
09a2910e5464 ("cirrusfb: check_par fixes").  Should the Fixes tag be:

  Fixes: 09a2910e5464 ("cirrusfb: check_par fixes")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-c4-n053-v1=
-1-1e45ef75304c@illinois.edu?part=3D1
