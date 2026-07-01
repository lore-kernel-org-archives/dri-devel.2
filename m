Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D764CC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1832310EEFE;
	Wed,  1 Jul 2026 11:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n+4d7HPF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F5010EEFE
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:31:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8611E6001D;
 Wed,  1 Jul 2026 11:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9701F000E9;
 Wed,  1 Jul 2026 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782905514;
 bh=z4ZsHV6JL2xplhU5OZaG/GzhwTWj6Fs33E3j11GhB18=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n+4d7HPF80OgksC20sZ6cXKQwilNrKjWZpMfprYkMZ5dEeAG4LLKuHjUB66RdYr0T
 Y6ov4P4lEusAzIAjZ4Y98e4GpQSBN2G1HHlR+YZLchijTUVvBhIP1s2HFBrfh2guhV
 kT27xdcCfWNEExUuvxi4Rd4h4h6tjuXBolQ9xmCv82yiLpSOCL9DrJqYwxx0FWlyf5
 uwBC9fXZ9cu8QAfyyP7j4NMa0UWEgcQaV5jIoIthzF5XGNmuB16krRVvEFclWJc0ZU
 M1yg6HX8Ttq29gi9nGPK8t5/JjN4Btgb1hHSSqf5Ib+WXKBRR22AZK66Cl3Dd7Varl
 CGOkWANPFFG8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: tdfxfb: fix PCI enable cleanup with
 pcim_enable_device()
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701112147.55048-1-mhun512@gmail.com>
References: <20260701112147.55048-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:31:52 +0000
Message-Id: <20260701113153.AC9701F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Calling `fb_destroy_modelist()` on a zero-initialized list head ca=
uses a kernel NULL pointer dereference during probe error cleanup.
--

commit e7b75661a1b19e182f38b86092ac7adc397e31df
Author: Myeonghun Pak <mhun512@gmail.com>

fbdev: tdfxfb: fix PCI enable cleanup with pcim_enable_device()

tdfxfb_probe() enables the PCI device with pci_enable_device(), but
several failure paths after that point return without disabling it.
This patch uses pcim_enable_device() so the PCI device is disabled
automatically on probe failure and driver detach.

> diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
> index cc6a074f3165b..9a06cef756994 100644
> --- a/drivers/video/fbdev/tdfxfb.c
> +++ b/drivers/video/fbdev/tdfxfb.c
> @@ -1385,7 +1385,7 @@ static int tdfxfb_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>  	if (err)
>  		return err;
> =20
> -	err =3D pci_enable_device(pdev);
> +	err =3D pcim_enable_device(pdev);
>  	if (err) {
>  		printk(KERN_ERR "tdfxfb: Can't enable pdev: %d\n", err);
>  		return err;

[Severity: High]
This is a pre-existing issue, but does the out_err_iobase error path cause =
a=20
NULL pointer dereference during device probe?

If CONFIG_FB_3DFX_I2C is enabled but the monitor's EDID does not provide a
mode database (specs->modedb =3D=3D NULL), fb_videomode_to_modelist() is sk=
ipped.
This leaves the info->modelist list head zero-initialized (with next and pr=
ev
pointers set to NULL) as originally allocated by framebuffer_alloc().

If a subsequent operation fails (e.g., info->var.yres_virtual < info->var.y=
res
or fb_alloc_cmap() returning -ENOMEM), the driver jumps to out_err_iobase:

drivers/video/fbdev/tdfxfb.c:tdfxfb_probe() {
    ...
out_err_iobase:
#ifdef CONFIG_FB_3DFX_I2C
    fb_destroy_modelist(&info->modelist);
...
}

This unconditionally calls fb_destroy_modelist(), which uses
list_for_each_safe():

drivers/video/fbdev/core/modedb.c:fb_destroy_modelist() {
    struct list_head *pos, *n;

    list_for_each_safe(pos, n, head) {
    ...
}

Because head->next is NULL, pos evaluates to NULL when the macro evaluates
n =3D pos->next, resulting in an immediate NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701112147.5504=
8-1-mhun512@gmail.com?part=3D1
