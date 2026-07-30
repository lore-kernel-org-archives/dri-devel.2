Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E00CC5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A491410F034;
	Thu, 30 Jul 2026 18:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KrPlfU/6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E948310F043
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:33:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9928741295;
 Thu, 30 Jul 2026 18:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4101F000E9;
 Thu, 30 Jul 2026 18:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785436430;
 bh=7DlWEaaLu76NYm7jzCGQ84LRHsFSSxx2csrmVyg7XfE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KrPlfU/6BoSkdGSiiw2H73b4YB6ktkoaOws7kHWIKeH5K30Fmv1SeHtfdOz913dno
 /lTZ5wVzN881J/t/I2g6jd29YDbrRabzxKtx85CIk0QU46L0OQQlbfUx9XQfN43n50
 AhozriB7yPE9K70QSmQoVuPw/Z/IQp5TtvV4Jp/Zd+yXATRNm6gJCI+ZCqg74pnKoH
 nb5UMnWhv8jCkTxqDxV57vsh2dIxSiuNzIaVvRsrxEulnyOuWFisSiDi9XJHDlM5ya
 Jc/IDZTm3575EZ2gYQb1cOJhUp+v/gWrOgtus5ndspDvrImBiAC4Y7AT6W+m/myQx4
 Lh5Y0PlEjIHaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] fbdev: tdfxfb: Program the initial video mode
To: "Daniel Palmer" <daniel@0x0f.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730182640.2808572-6-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
 <20260730182640.2808572-6-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:33:49 +0000
Message-Id: <20260730183350.5B4101F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware programming and framebuffer clearing occur after the devi=
ce is registered, causing data races with user-space and destroying fbcon c=
onsole output.
--

--- Patch [5]: [PATCH 5/5] fbdev: tdfxfb: Program the initial video mode ---
commit 90ecec6554588f0e84d39be7f57c41d5df7e26d5
Author: Daniel Palmer <daniel@0x0f.com>

fbdev: tdfxfb: Program the initial video mode

If the card does not get bound to by fbcon, the initial video mode is
not setup and the display detects no signal. This commit programs the
video mode and clears the framebuffer memory so random garbage isn't
displayed.

> diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
> --- a/drivers/video/fbdev/tdfxfb.c
> +++ b/drivers/video/fbdev/tdfxfb.c
> @@ -1692,6 +1692,13 @@ static int tdfxfb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  	 * Our driver data
>  	 */
>  	pci_set_drvdata(pdev, info);
> +
> +	/* Program a video mode so the display detects a signal */
> +	tdfxfb_set_par(info);
> +
> +	/* Don't scare the user with random garbage on their display */
> +	memset_io(info->screen_base, 0, info->fix.smem_len);

[Severity: High]
Does calling tdfxfb_set_par() and memset_io() after register_framebuffer()
cause issues with fbcon initialization?

When register_framebuffer() is called just prior to this, it synchronously
notifies the console subsystem. If fbcon binds to the new framebuffer, it
configures the display and draws the console text and boot logo.

By unconditionally clearing the VRAM and setting the parameters after
register_framebuffer() returns, doesn't this wipe out the console output
that fbcon just initialized?

Additionally, since register_framebuffer() exposes the device to user-space
via /dev/fb0, could this create a data race against concurrent user-space
ioctls accessing hardware registers or VRAM without holding info->lock?

> +
>  	return 0;
> =20
>  out_err_iobase:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730182640.2808=
572-1-daniel@0x0f.com?part=3D5
