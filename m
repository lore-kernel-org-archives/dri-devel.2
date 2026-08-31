Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58EAC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A5A10E2E6;
	Mon, 31 Aug 2026 15:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lQoP0mpv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2052210E2E6
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:22:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFA8343E7A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0C31F00A3D;
 Mon, 31 Aug 2026 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788189729;
 bh=7s0MmjjtxnUsyD0rzcrp8TJjOjpF8QTuVEuVqsquE+A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lQoP0mpv8qfM1hOgZMLTE5DFfNFEPMd2jc5fM2eoiPU4Q+craYNrKkRkvQx2h+1Dy
 aRa19frDjqXj5AfXeG7CFF9o4afsyUGXXzgjRIytEMX7HgT0WqlXznMF5AvO9kF1pl
 /6l8EQZqwdc3Bq9opHGGxe/2VZh1Xq0q6KLxCNrzctUk8lC8Uqz3rvtet5eald3zNV
 I/XT2bFoAqLcnQX82o7txpJ9jMpvLHp8m0tnI0Zejbe10D4DM4orAnXySBWEZY/dY8
 LnZ45r4OiJLF7sHy/u+smgNzAsiGVhT8chKgSIpqCAhscxATIzQE1a6Orl8QhNYOuF
 C7564WJ31QrjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] drm/mediatek: dsi: Add compatible for
 mt8167-dsi
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-262-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-262-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:22:09 +0000
Message-Id: <20260831152209.9D0C31F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] Uninitialized wait queue usage leads to NULL pointer dereference.
- [High] Missing drvdata initialization before component bind leads to NULL=
 pointer dereference.
--

commit 1c9b9cfe82b003fd952c66b9a2f9e8fa689477ee
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

drm/mediatek: dsi: Add compatible for mt8167-dsi

This commit adds the mediatek,mt8167-dsi compatible string to the MediaTek
DSI controller driver. It allows the driver to probe on MT8167 hardware usi=
ng
the existing MT2701 driver data.

Link: https://patchwork.kernel.org/project/dri-devel/patch/20260505214541.3=
33657-3-l.scorcia@gmail.com/

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 0e2bcd5f67b76..b04936d4511b4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1307,6 +1307,7 @@ static const struct mtk_dsi_driver_data mt8188_dsi_=
driver_data =3D {
> =20
>  static const struct of_device_id mtk_dsi_of_match[] =3D {
>  	{ .compatible =3D "mediatek,mt2701-dsi", .data =3D &mt2701_dsi_driver_d=
ata },
> +	{ .compatible =3D "mediatek,mt8167-dsi", .data =3D &mt2701_dsi_driver_d=
ata },

[Severity: High]
This is a pre-existing issue, but enabling this driver on new hardware might
expose an uninitialized wait queue usage in drivers/gpu/drm/mediatek/mtk_ds=
i.c
that leads to a NULL pointer dereference.

In mtk_dsi_probe(), mipi_dsi_host_register() and devm_request_irq() are cal=
led
before the wait queue is initialized:

	ret =3D devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq, ...);
	if (ret) {
	    ...
	}

	init_waitqueue_head(&dsi->irq_wait_queue);

If a child panel driver probes synchronously when mipi_dsi_host_register() =
is
called and sends a DSI command (for instance, to read the panel ID), it
triggers mtk_dsi_host_transfer(). This calls mtk_dsi_wait_for_irq_done(),
which uses wait_event_interruptible_timeout() on the zero-initialized wait
queue. This dereferences the NULL next pointer of the wait queue head, caus=
ing
a crash.

Alternatively, if an interrupt fires early, mtk_dsi_irq() calls
wake_up_interruptible() on the same uninitialized wait queue.

Could the initialization of dsi->irq_wait_queue be moved before
mipi_dsi_host_register() and devm_request_irq() to prevent this?

[Severity: High]
This isn't a bug introduced by this patch, but missing drvdata initializati=
on
before the component bind can also lead to a NULL pointer dereference.

In mtk_dsi_probe(), the DSI host is registered before drvdata is set:

	ret =3D mipi_dsi_host_register(&dsi->host);
	...
	platform_set_drvdata(pdev, dsi);

Registering the DSI host causes child devices to be probed synchronously. T=
he
child's probe function calls mipi_dsi_attach(), which invokes
mtk_dsi_host_attach(). This function calls component_add(). If mtk_dsi is t=
he
last component to register, it triggers the DRM master to bind all componen=
ts,
invoking mtk_dsi_bind().

However, mtk_dsi_bind() tries to use drvdata:

	struct mtk_dsi *dsi =3D dev_get_drvdata(dev);

	ret =3D mtk_dsi_encoder_init(drm, dsi);

Because platform_set_drvdata() hasn't been called yet, dev_get_drvdata()
returns NULL, leading to a crash in mtk_dsi_encoder_init().

Would it be possible to call platform_set_drvdata() before
mipi_dsi_host_register() to avoid this race?

>  	{ .compatible =3D "mediatek,mt8173-dsi", .data =3D &mt8173_dsi_driver_d=
ata },
>  	{ .compatible =3D "mediatek,mt8183-dsi", .data =3D &mt8183_dsi_driver_d=
ata },
>  	{ .compatible =3D "mediatek,mt8186-dsi", .data =3D &mt8186_dsi_driver_d=
ata },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-262-sashal@kernel.org?part=3D1
