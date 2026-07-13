Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F182C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8521410E5D3;
	Mon, 13 Jul 2026 12:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WZaz1DOu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D2810E5D3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09FF34350A;
 Mon, 13 Jul 2026 12:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15F41F00A3A;
 Mon, 13 Jul 2026 12:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783947498;
 bh=oQXIeuFDt2x1IooAp/jXPp3spYtiZ2O4nwmXV034HN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WZaz1DOucckr8P9Tr2rkhkTyX2pidajW//N2joj1+wy0XTjyHO/3ukN0fKp2U+wO1
 KehvuUisTl0zDN1pZYfWLjh7wWhpt04E0Ipo/UfJw6sdJaLPzoYLAXRb19mYdj2+VV
 yhGnZiIqNfqZ5cpjfGqPQgvyasNAvA7uuqMZ92cyBq57QBWy2x8tXMMB1GH4w/XXVh
 pN3VH/fRnNSBtzMpmvAJUq4Hh+tuiE+/w/RIF9ukbOSbsLBRQqjd5d8deRjrhufMWK
 1hJ+KeU5vTubTPK0PG0iJUys+43n4mNjLHvpFlBrE7gKwHrVI8VCHyp+P+v5szn92E
 xvR3c3Vst1PQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/19] media: meson: canvas: Fix Use-After-Free by
 linking canvas provider device
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713120840.17427-18-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-18-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:58:18 +0000
Message-Id: <20260713125818.A15F41F00A3A@smtp.kernel.org>
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
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition exists betw=
een retrieving the supplier's driver data and establishing the device link,=
 which allows the supplier to unbind and free the data before the link can =
protect it.

Pre-existing issues:
- [High] The device link fails to prevent the Use-After-Free in the `vdec` =
driver because V4L2 file descriptors outlive the consumer's driver unbind s=
equence.
--

--- Patch [17]: [PATCH v7 17/19] media: meson: canvas: Fix Use-After-Free b=
y linking canvas provider device ---
commit bf6a22d368b30413921052e4cb659c5a279efaea
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: canvas: Fix Use-After-Free by linking canvas provider device

This commit attempts to fix a Use-After-Free by establishing a device link
between the vdec consumer and the canvas provider. The link aims to
automatically unbind the consumer driver when the provider unbinds.

Closes: https://lore.kernel.org/all/20260530111022.9C6D71F00893@smtp.kernel=
.org

> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/mes=
on-canvas.c
> index 79681afea8c61..5102a491bf778 100644
> --- a/drivers/soc/amlogic/meson-canvas.c
> +++ b/drivers/soc/amlogic/meson-canvas.c

[ ... ]

> @@ -70,9 +71,18 @@ struct meson_canvas *meson_canvas_get(struct device *d=
ev)
>  	 * current state, this driver probe cannot return -EPROBE_DEFER
>  	 */
>  	canvas =3D dev_get_drvdata(&canvas_pdev->dev);

[Severity: High]
Is there a race condition between retrieving the driver data and creating
the device link?

If the canvas provider unbinds immediately after dev_get_drvdata() but
before device_link_add(), devres_release_all() will free the canvas data.

Because the driver core allows links to unbound suppliers, device_link_add()
would still succeed and create a dormant link, and then meson_canvas_get()
would return a freed pointer to the caller.

> -	put_device(&canvas_pdev->dev);
> -	if (!canvas)
> +	if (!canvas) {
> +		put_device(&canvas_pdev->dev);
>  		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* Establish device link to prevent Use-After-Free */
> +	link =3D device_link_add(dev, &canvas_pdev->dev,
> +			       DL_FLAG_AUTOREMOVE_CONSUMER);

[Severity: High]
This is a pre-existing issue, but does this device link fully resolve the
use-after-free for the vdec driver?

Because vdec is a V4L2 driver, userspace file descriptors can outlive the
consumer driver's unbind sequence. If a user holds the video device open:

1. The canvas provider unbinds.
2. The device link forces the vdec driver to unbind.
3. devres_release_all() frees the devm-managed canvas and vdec core context=
s.
4. Userspace later closes the file descriptor.

When the file descriptor is closed, vdec_close() calls vdec_free_canvas(),
which attempts to dereference the already freed sess->core->canvas pointer.

> +	put_device(&canvas_pdev->dev);
> +	if (!link)
> +		return ERR_PTR(dev_err_probe(dev, -EINVAL,
> +				     "Failed to create device link canvas\n"));
> =20
>  	return canvas;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D17
