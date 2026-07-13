Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02F2C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DB010EA0B;
	Mon, 13 Jul 2026 14:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ei0dlKKU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B92910EA0B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:43:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD3F340B35;
 Mon, 13 Jul 2026 14:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736B11F000E9;
 Mon, 13 Jul 2026 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783953820;
 bh=t/uW7Ax2+UyvYsNj4DEF0DxvIrvF+3VrzqbEwGASQPE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ei0dlKKU+xOS52awl31Vj44IZjocKd6JB3r15dNVcc772Z71aTKXdQMFO50gJBqWb
 5jfDSpto1Bz9tKIWK171rcBgsqL/dcn9CNxccbDlsulN0W7/6PuKRgk6lpIAEjar3I
 VTPHDMjHXsSFdOlOqAQdbHLeJ/UY/gl+VEnRwdWfMiOzfZKYgRFCinw7j/HEsD/FMu
 k38tyJKnrHOcEMZLfUHmObl1D9gi4HLMlKo91n6jEp6nXmhMHQ/jzsZ9BT5kgW/6Ks
 HCG3YAFlWSSuhrFTf1tFAzblkT2tG2LcZOnpcmjAdVYyf+pJowktJPOEMhDgLEmxno
 R6bqXVxDQQqXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260713142746.40259-5-angelogioacchino.delregno@collabora.com>
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:43:40 +0000
Message-Id: <20260713144340.736B11F000E9@smtp.kernel.org>
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
- [High] Missing cleanup of DRM encoder when device_reset_optional() fails =
in mtk_dsi_bind().
- [High] Read-modify-write data race on `dsi->irq_data` between process con=
text and hardirq context.
--

--- Patch [4]: [PATCH v4 04/10] drm/mediatek: mtk_dsi: Enable interrupt at =
component bind time ---
commit 0607d3868a389c4103df3225d2bc7a47d44df3b0
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Enable interrupt at component bind time

This patch requests the DSI interrupt with IRQF_NO_AUTOEN and enables it on=
ly
when binding the DSI to its display controller component master. This preve=
nts
interrupt storms and delays caused by timeouts during probe.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 8ab5c3431dbbc..e24e7b91a3618 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -1090,7 +1091,13 @@ static int mtk_dsi_bind(struct device *dev, struct=
 device *master, void *data)
>  	if (ret)
>  		return ret;
> =20
> -	return device_reset_optional(dev);
> +	ret =3D device_reset_optional(dev);
> +	if (ret)
> +		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak
the DRM encoder?

If device_reset_optional(dev) fails, it returns without calling
drm_encoder_cleanup(&dsi->encoder). Because the component bind operation
fails, the component framework will not invoke mtk_dsi_unbind(), meaning
the encoder is never cleaned up.

If the DSI driver is subsequently unbound or removed, its locally managed
memory is freed while the encoder is still linked in the DRM core's list,
which could lead to a use-after-free or kernel panic when the list is
traversed.

> +
> +	enable_irq(dsi->irq);
> +
> +	return 0;
>  }
[ ... ]
> @@ -1375,17 +1383,15 @@ static int mtk_dsi_probe(struct platform_device *=
pdev)
> =20
>  	platform_set_drvdata(pdev, dsi);
> =20
> +	ret =3D devm_request_irq(&pdev->dev, dsi->irq, mtk_dsi_irq,
> +			       IRQF_NO_AUTOEN, dev_name(&pdev->dev), dsi);

[Severity: High]
This is a pre-existing issue, but is there a read-modify-write data race on
dsi->irq_data between process context and hardirq context?

mtk_dsi_irq_data_clear() modifies dsi->irq_data using &=3D in process conte=
xt
(from mtk_dsi_host_transfer()) without disabling interrupts or using atomic
bitwise operations. Concurrently, the hardirq handler mtk_dsi_irq() modifies
the same variable using |=3D.

If a DSI interrupt fires during the process-context read-modify-write
sequence, won't the flag set by the interrupt handler be silently
overwritten and lost when the process context stores its computed value?

This could lead to hardware interrupt events being lost, causing timeouts
in mtk_dsi_wait_for_irq_done() and potentially breaking display
initialization or frame updates.

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713142746.4025=
9-1-angelogioacchino.delregno@collabora.com?part=3D4
