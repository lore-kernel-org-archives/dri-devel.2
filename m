Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A068C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04A910E221;
	Fri, 31 Jul 2026 12:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TKLX9RxR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C86210E221
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:28:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95EA8600AD;
 Fri, 31 Jul 2026 12:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283891F000E9;
 Fri, 31 Jul 2026 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785500912;
 bh=24wKzOamhIber3fpW8sfhnZ8u3YdfYwK9WArXRfOfc0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TKLX9RxRa2BCKGcSPrRWlOATMP2NRQIq3P9pJm8YWAQCbZE/lpkz16/8ByZlStvnS
 6aPbdX6SxO5AJVPQJup4vT7ZVfngtrDqoCsHsmhGvoE7HHtInYQqAXdbLghMSaOMTK
 Q9Z8sKFnvctwUSwLLdBihJW0TjOoWFUA30CworVKH9KY8AuEM3vErpVTWp7diBjk2a
 EwFOTgzHqLyO/+T/9LYbPriBaD57hP91T14+gBEUw8wlGpwdcA6lonD8yxMfIHQaft
 2q2OiFPu5j2ddXgK+r7JbcevYo8H7ALY+6fCpPIjXebTkPxzCmfsYT9pOEun9fjRlh
 kIaL1IccG31Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] fbdev: tdfxfb: Program the initial video mode
To: "Daniel Palmer" <daniel@0x0f.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731121915.3362232-6-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
 <20260731121915.3362232-6-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 12:28:31 +0000
Message-Id: <20260731122832.283891F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Unbounded memset_io() leads to out-of-bounds physical memory w=
rite

Pre-existing issues:
- [High] Infinite loop in banshee_wait_idle() causes kernel hang on probe
--

--- Patch [5]: [PATCH v2 5/5] fbdev: tdfxfb: Program the initial video mode=
 ---
commit 99f06e3d4bb98c9560cb7c49215cddea173febfd
Author: Daniel Palmer <daniel@0x0f.com>

fbdev: tdfxfb: Program the initial video mode

If the card does not get bound to by fbcon set_par() never happens and the
initial video mode is not setup and the display detects no signal. This
commit programs the video mode and also clears the framebuffer memory so
random garbage isn't displayed.

> diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
> index f2b658a47135d..cb1c2e9f37dbc 100644
> --- a/drivers/video/fbdev/tdfxfb.c
> +++ b/drivers/video/fbdev/tdfxfb.c
> @@ -1686,6 +1686,14 @@ static int tdfxfb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  		goto out_err_iobase;
>  	}
> =20
> +	/*
> +	 * Program a video mode and clear the framebuffer now, this
> +	 * ensures the display comes up even if fbcon doesn't bind
> +	 * when the framebuffer is registered.
> +	 */
> +	tdfxfb_set_par(info);

[Severity: High]
This is a pre-existing issue, but can this lead to an infinite loop and
kernel hang during device probe?

When tdfxfb_set_par() is called, it invokes the code path leading to
banshee_wait_idle(), which contains a tight loop waiting for hardware
register status to clear:

drivers/video/fbdev/tdfxfb.c:banshee_wait_idle() {
    ...
	do {
		if ((tdfx_inl(par, STATUS) & STATUS_BUSY) =3D=3D 0)
			i++;
	} while (i < 3);
    ...
}

If a malfunctioning or malicious PCI device returns a constant busy status,
would the driver loop indefinitely here since the loop is unbounded?

> +	memset_io(info->screen_base, 0, info->fix.smem_len);

[Severity: Critical]
Could this regression result in an out-of-bounds physical memory write?

The length info->fix.smem_len is derived from untrusted hardware registers
read during do_lfb_size(), rather than the validated PCI BAR length:

drivers/video/fbdev/tdfxfb.c:do_lfb_size() {
    ...
	return num_chips * chip_size * 1024l * 1024;
    ...
}

If a device exposes large values for these registers, can
info->fix.smem_len exceed the actual size remapped at info->screen_base,
causing memset_io() to overwrite adjacent memory?

> +
>  	if (register_framebuffer(info) < 0) {
>  		printk(KERN_ERR "tdfxfb: can't register framebuffer\n");
>  		fb_dealloc_cmap(&info->cmap);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731121915.3362=
232-1-daniel@0x0f.com?part=3D5
