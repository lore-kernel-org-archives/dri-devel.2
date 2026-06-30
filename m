Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E36C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A6B10EBB6;
	Tue, 30 Jun 2026 09:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BjFtZ6lY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8E910EBB6
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:18:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 598ED43EFF;
 Tue, 30 Jun 2026 09:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD6D1F00A3E;
 Tue, 30 Jun 2026 09:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782811122;
 bh=EH5/L2M1XpJnyfHNsfPqgccrseXM6UKjnYvjmKgJ5Jc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BjFtZ6lYWu6gymDB6S0FINyVl8dWvlLSYBgSnNC4plnBdpg9Bf8IbCuB4qEfCdd3R
 fiNK8D8w9m1rpA7c4hWxGwx5kQr1qF09kJfxTHufYclbQuvybA7gA4gQornzq8HTEX
 atB9RL9bYSPmkJ22BjiLBwpK56fQ5YyqSNG5LpVDLlnTdRYRbQj6XiE+VnjLRY3BRL
 heOu8U7xlr9si9xHfeyXSx4w/jUxL6u7tJXbHbZUXdMru/IAJvK27mCCeEQ68j5UOe
 ddaNFJfVVW4SaeiobgLW81UpGdicHlRTkO8Ki5FdK8Kq50j09HSw3wXn40aZzsHvB0
 IlvdoEFzOHISQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/19] usb: musb: use
 platform_device_set_of_node_from_dev()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260629-pdev-fwnode-ref-v2-17-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-17-8abe2513f96e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:18:41 +0000
Message-Id: <20260630091841.CFD6D1F00A3E@smtp.kernel.org>
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
- [High] Incomplete migration to `platform_device_set_of_node_from_dev()` l=
eading to OF node reference leaks.
--

commit fb8a9bf1bacccb38cbdade8a447f9b482f1bd4a3
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

[Severity: High]
Are there other MUSB drivers that need to be updated to prevent OF node
reference leaks?

When the dynamically allocated MUSB platform device is destroyed (e.g.,
during driver unbind or probe error), the reworked platform device reference
counting will drop references using fwnode_handle_put(pdev->dev.fwnode) rat=
her
than of_node_put(pdev->dev.of_node). Because device_set_of_node_from_dev()
doesn't set pdev->dev.fwnode, this leaves the fwnode pointer NULL and leaks
the OF node reference.

It looks like several other MUSB drivers still use
device_set_of_node_from_dev() for dynamically allocated platform devices:

- drivers/usb/musb/mpfs.c:mpfs_probe()
- drivers/usb/musb/musb_dsps.c:dsps_create_musb_pdev()
- drivers/usb/musb/omap2430.c:omap2430_probe()
- drivers/usb/musb/ux500.c:ux500_probe()

Will these also be updated to use platform_device_set_of_node_from_dev()?

> =20
>  	glue->pdev			=3D musb;
>  	glue->clk			=3D clk;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-pdev-fwnod=
e-ref-v2-0-8abe2513f96e@oss.qualcomm.com?part=3D17
