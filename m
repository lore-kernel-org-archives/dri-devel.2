Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE424C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCFE210ED0C;
	Tue,  7 Jul 2026 13:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UUaABH7/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 405C110ECF6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B85B760018;
 Tue,  7 Jul 2026 13:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AB61F000E9;
 Tue,  7 Jul 2026 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430707;
 bh=YJsVM5qVcHrFc2Jbum/XGwZMZgdj9uhNyg+CjpvCzqQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UUaABH7/p6d7l9sAcUn3ZgHXot68DUnMPdD6D5DlDMR2fcURLwVeYSDqjCOEEPghk
 9aAUL7iDs5Yg2n5F7mrL+donQzHvwuN3f2Pvaw1mCVfI8xPY/8CU7ZtydTpzDb7Tsy
 fX4zErgGG/f3e05tSLVCFTomR0T5LzoZ5zCJVl65SFzQkT028WjCc4gSvaqFLpHtoi
 JWw7jHLI4y7Jw7706JNJ0EZ+zEzTQ+oKMyiiZzChxYjupYmMFuuy9S4dkarILeCUMr
 1O8UOUM2LPEOzLpqmNq/cVY/DPnaFd1cxMtEfRR6EbqnhvKpD0wJimV1uJRXt5Yhk8
 wyF6jwqazI2Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/20] usb: musb: use
 platform_device_set_of_node_from_dev()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: lee@kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org,
 robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org,
 conor+dt@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260706-pdev-fwnode-ref-v3-18-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-18-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:25:06 +0000
Message-Id: <20260707132506.E6AB61F000E9@smtp.kernel.org>
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
- [Medium] The patch missed replacing `device_set_of_node_from_dev()` with =
the new `platform_device_set_of_node_from_dev()` wrapper for four dynamical=
ly allocated platform devices in the `musb` subsystem. Because the final pa=
tch in this series modifies `platform_device_release()` to only drop the `f=
wnode` reference instead of the `of_node` reference, these four un-migrated=
 drivers will never have their `fwnode` field populated and will leak their=
 `of_node` reference upon device destruction.
--

commit 38644321565357d4bf1b4cbb11a9e179abf72efc
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

usb: musb: use platform_device_set_of_node_from_dev()

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index df56c972986f7..c770ba576f05b 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -273,7 +273,7 @@ static int jz4740_probe(struct platform_device *pdev)
>  	musb->dev.parent		=3D dev;
>  	musb->dev.dma_mask		=3D &musb->dev.coherent_dma_mask;
>  	musb->dev.coherent_dma_mask	=3D DMA_BIT_MASK(32);
> -	device_set_of_node_from_dev(&musb->dev, dev);
> +	platform_device_set_of_node_from_dev(musb, dev);

[Severity: Medium]
Will this miss other dynamically allocated platform devices in the musb
subsystem?

Because the final patch in this series modifies platform_device_release() to
only drop the fwnode reference instead of the of_node reference, wouldn't
these remaining un-migrated drivers never have their fwnode field populated?

This could cause an of_node reference leak upon device destruction (e.g., v=
ia
platform_device_put() on probe failure or driver unbinding). If these devic=
es
are instantiated via dynamic Device Tree overlays, the leaked reference will
prevent the overlay from being safely unloaded.

The following files appear to have missed the migration:

drivers/usb/musb/mpfs.c:mpfs_probe()
	device_set_of_node_from_dev(&musb_pdev->dev, dev);

drivers/usb/musb/musb_dsps.c:dsps_create_musb_pdev()
	device_set_of_node_from_dev(&musb->dev, &parent->dev);

drivers/usb/musb/omap2430.c:omap2430_probe()
	device_set_of_node_from_dev(&musb->dev, &pdev->dev);

drivers/usb/musb/ux500.c:ux500_probe()
	device_set_of_node_from_dev(&musb->dev, &pdev->dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D18
