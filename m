Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B1AC88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D1610E044;
	Sun, 13 Sep 2026 09:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F27rxL/L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7962110E044
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 09:31:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3270240465;
 Sun, 13 Sep 2026 09:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83751F000FF;
 Sun, 13 Sep 2026 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789291881;
 bh=0jdsxkV7oLgLaZm8q6X7xgiRT58XrJHylLTGyvhBxTw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F27rxL/Lc1S9CHLiOk60MAiY4DQwWzPPLYSHXCFulqV3YUW9k7U0X9sOvUIXIae9X
 U63nz+En22WrrSXv8XanQtQCa4+lUnVOPX5Jv1yRGJOi+RvcYCheXSTpq/IPlDtBLw
 8+BGmdvf5muSMWQJGbsqCo4n5yUDtjoNihSQZ80r14rYoSRCWRc7VV29OR2vETfXST
 aStX/tb+VhG//EPY9ewqJ4McZqY+ljAq72AoQ7M67yfvRzbAOs+NFZ36i4Ch8q8k8F
 VlCcHoTKbf8ZZIdNOIDldaKKq8e9UDSkJoAGeguPLJYbM9zq4mBcKK/LpQuK29aWq8
 fVenRDB3NohqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/omap: dmm_tiler: fix invalid cleanup on probe failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913091644.1510151-1-lgs201920130244@gmail.com>
References: <20260913091644.1510151-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 09:31:20 +0000
Message-Id: <20260913093120.E83751F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message describes an approach to fixing the IRQ bug t=
hat does not match the actual code, leaving a dead write.

Pre-existing issues:
- [High] The global `containers` array retains dangling pointers to freed T=
CM structures after `omap_dmm_remove()` is called.
- [High] Array out-of-bounds access and potential NULL/garbage pointer dere=
ference if DMM hardware registers return 0.
- [High] `omap_dmm_remove()` does not wait for pending DMM engines to finis=
h before freeing the DMA refill buffer.
- [High] The global `omap_dmm` pointer is exposed to the rest of the system=
 before the device is fully initialized.
--

commit 466b29166253ee657c1c421252c56612ce024b71
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/omap: dmm_tiler: fix invalid cleanup on probe failure

This commit fixes probe cleanup paths in the OMAP DMM tiler driver to
avoid unmapping uninitialized MMIO bases or freeing unrequested IRQs.
It replaces a single omap_dmm_remove() call on error with granular
teardown labels.

Link: stable@vger.kernel.org

> Initialize the stored IRQ to -1 and keep the IRQ number local until
> request_irq() succeeds.

[Severity: Medium]
The commit message describes keeping the IRQ number local until
request_irq() succeeds, but the patch actually stores the result of
platform_get_irq() directly into omap_dmm->irq.=20

Could the commit message be updated to match the implemented approach?

> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/o=
mapdrm/omap_dmm_tiler.c
> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
[ ... ]
> @@ -769,14 +769,14 @@ static void omap_dmm_remove(struct platform_device =
*dev)
> =20
>  static int omap_dmm_probe(struct platform_device *dev)
>  {
[ ... ]
>  	struct resource *mem;
> =20
>  	omap_dmm =3D kzalloc_obj(*omap_dmm);
>  	if (!omap_dmm)
> -		goto fail;
> +		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does this expose the global omap_dmm
pointer before any of its fields are configured?=20

If a concurrent GEM ioctl or async probe checks dmm_is_available() (which
only verifies omap_dmm is non-NULL), could it immediately invoke
tiler_reserve_2d() and attempt to use the uninitialized global containers
array, leading to a NULL pointer dereference?

[ ... ]
> @@ -958,7 +962,7 @@ static int omap_dmm_probe(struct platform_device *dev)
>  		dev_err(&dev->dev, "couldn't register IRQ %d, error %d\n",
>  			omap_dmm->irq, ret);
>  		omap_dmm->irq =3D -1;
> -		goto fail;
> +		goto err_free_tcm;

[Severity: Medium]
Because err_free_tcm eventually frees the omap_dmm structure, is this
assignment to -1 now a dead store?

[ ... ]
> -fail:
> -	omap_dmm_remove(dev);

[Severity: High]
This is a pre-existing issue, but when omap_dmm_remove() is called (for
example, during sysfs unbind), it frees the omap_dmm->tcm structures but
doesn't clear the global containers array.

Could this leave dangling pointers in the global containers array?=20

Since priv->has_dmm is cached during DRM initialization, could a subsequent
GEM ioctl like DRM_IOCTL_OMAP_GEM_NEW bypass dmm_is_available(), call
tiler_reserve_2d(), and dereference the freed pointers?

[Severity: High]
This is also a pre-existing issue, but does omap_dmm_remove() safely handle
active hardware engines?

In omap_dmm_remove(), the DMA buffer is freed directly:

	if (omap_dmm->refill_va)
		dma_free_wc(omap_dmm->dev,
			    REFILL_BUFFER_SIZE * omap_dmm->num_engines,
			    omap_dmm->refill_va, omap_dmm->refill_pa);

If a hardware engine is actively processing a transaction during driver
unbind, could it continue performing DMA into the freed memory and cause
corruption or IOMMU faults?

[Severity: High]
This is another pre-existing issue in omap_dmm_probe() that isn't directly
in this diff, but can an out-of-bounds access happen if the DMM hardware is
inaccessible and registers return 0?

If DMM_PAT_HWINFO and DMM_PAT_GEOMETRY read as 0, omap_dmm->num_lut and
omap_dmm->lut_height will be 0.=20

Since omap_dmm->lut_height (0) !=3D omap_dmm->container_height (128), num_l=
ut
increments to 1, causing the omap_dmm->tcm array to be allocated with a size
of 1.

Later in omap_dmm_probe():

	containers[TILFMT_PAGE] =3D omap_dmm->tcm[1];
	omap_dmm->tcm[1]->y_offset =3D OMAP5_LUT_OFFSET;

Would this code overflow the omap_dmm->tcm array when accessing tcm[1] and
cause memory corruption or a kernel panic?

> +err_free_tcm:
> +	for (i =3D 0; i < ARRAY_SIZE(containers); i++)
> +		containers[i] =3D NULL;
> +
> +	for (i =3D 0; i < omap_dmm->num_lut; i++)
> +		if (omap_dmm->tcm[i])
> +			omap_dmm->tcm[i]->deinit(omap_dmm->tcm[i]);
> +	kfree(omap_dmm->tcm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913091644.1510=
151-1-lgs201920130244@gmail.com?part=3D1
