Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D4BC88E41
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6AF10F1FC;
	Fri, 11 Sep 2026 00:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XAg9ZRP+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416C210F1FC
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 00:18:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF0E3405B1;
 Fri, 11 Sep 2026 00:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D081F000FF;
 Fri, 11 Sep 2026 00:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789085911;
 bh=9o0OhHrmdpyclbH1Qchk3VDx4iPah8TnGqc2vutaFIE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XAg9ZRP+48PRMP+KcFKyr4d3WCevtmordUn7e/SLblzP6WCRqVh+nHDC46In6L9DS
 nYQFch1j6UN18w/kBiXgFYSgQL0H81X0wrtYajMm9Nqumlg4ijH71OfO7979rbm6JR
 7euL5Gn4KuA4BTERkzoAH1zoaL9SESXLedoehN8oQe/IHAk0j6Y+fM1zpZud/nAlyX
 C7rPQuMAdETOniYt/IdJbeG5iMA2y6h04yTer3PaXSeilQojgabLhIaqojH3QOZwt2
 Fw1h/LG4B2R2SZGRu2a5IgtnJHvcPcsmxAfJNF0kR0V2GYLHSFhIfRsa9RrTXQgsnd
 fB9Zezqa00btg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: sstfb: use managed PCI device enable
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911000835.88909-1-mhun512@gmail.com>
References: <20260911000835.88909-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 00:18:31 +0000
Message-Id: <20260911001831.98D081F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unregistering the framebuffer after tearing down hardware mappings=
 creates an exploitable use-after-free/unmap race condition.
- [High] Hardware is left in an active, initialized state on probe error pa=
ths because `sst_shutdown()` is missing.
- [High] `__sst_wait_idle()` contains an unbounded busy loop that will sile=
ntly hang the CPU if the device becomes unresponsive.
--

commit 9516997f46dea14ef20c216ac89acefd0aaf2e36
Author: Myeonghun Pak <mhun512@gmail.com>

fbdev: sstfb: use managed PCI device enable

This commit updates sstfb_probe() to use pcim_enable_device() instead of
pci_enable_device(). This ensures that the PCI device is automatically
disabled by the PCI core after a probe failure or driver removal. The driver
still explicitly releases its other resources.

> diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
> index 2745557822f76..039279feb5bf4 100644
> --- a/drivers/video/fbdev/sstfb.c
> +++ b/drivers/video/fbdev/sstfb.c
> @@ -1332,7 +1332,8 @@ static int sstfb_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>  		return err;
> =20
>  	/* Enable device in PCI config. */
> -	if ((err=3Dpci_enable_device(pdev))) {
> +	err =3D pcim_enable_device(pdev);
> +	if (err) {
>  		printk(KERN_ERR "cannot enable device\n");
>  		return err;
>  	}

[Severity: High]
This is a pre-existing issue, but hardware is left in an active, initialized
state on probe error paths because sst_shutdown() is missing.

During sstfb_probe(), sst_init() is called to configure the hardware. If a
subsequent initialization step fails, the error path unwinds memory but omi=
ts
calling sst_shutdown():

drivers/video/fbdev/sstfb.c:sstfb_probe() {
    ...
    if (!sst_init(info, par)) {
        printk(KERN_ERR "sstfb: Init failed\n");
        goto fail;
    }
    ...
fail:
    iounmap(info->screen_base);
    ...
}

Would this leave the PCI device fully active and configured, potentially
breaking system functionality like leaving VGA pass-through disabled?

[Severity: High]
This is a pre-existing issue, but unregistering the framebuffer after teari=
ng
down hardware mappings creates an exploitable use-after-free/unmap race
condition.

If a user opens the framebuffer device, and then the driver is unbound,
sstfb_remove() unmaps the memory before unregistering the framebuffer:

drivers/video/fbdev/sstfb.c:sstfb_remove() {
    ...
    iounmap(info->screen_base);
    iounmap(par->mmio_vbase);
    ...
    unregister_framebuffer(info);
    ...
}

Could a user then issue an ioctl (like SSTFB_SET_VGAPASS), which calls
sstfb_ioctl() and accesses the now-unmapped memory?

[Severity: High]
This is a pre-existing issue, but __sst_wait_idle() contains an unbounded
busy loop that could silently hang the CPU if the device becomes unresponsi=
ve.

__sst_wait_idle() is called repeatedly during device operation and waits for
the busy status to clear:

drivers/video/fbdev/sstfb.c:__sst_wait_idle() {
    ...
    while(1) {
        if (__sst_read(vbase, STATUS) & STATUS_FBI_BUSY) {
    ...
}

If the PCI device is removed (e.g., via surprise unplug) or fails, the MMIO
read will return ~0. Since STATUS_FBI_BUSY is BIT(7), the condition would
remain true indefinitely. Should there be a timeout or fallback here to
prevent a permanent kernel hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911000835.8890=
9-1-mhun512@gmail.com?part=3D1
