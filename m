Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4ECC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC7D10F320;
	Thu, 16 Jul 2026 13:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZOEdYDeY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E9010F31F
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:36:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8BFD4321E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925D51F00A3A;
 Thu, 16 Jul 2026 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784209008;
 bh=tGGSvvaMqW9e+cEOQxJ4hveeEkmwGzfCLdVSku61ZGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZOEdYDeYGGV2DyqVfuM/wyLDuqxKeVRNzAey/WcaYsD3VqyxBMIJdqM8R19lEkV+q
 1/AXH/tXFfNIQbWCe8JS+wjnUJWcXKYkbV0Na15mqZRiFTM6fruLdX2SX0fpC+fKey
 yRefm9aYI65t6mZahWcnP5SdqTGdxYwrRqVDnPBXf9QEn7kOGx+6U4ipxrqtMQP58P
 4mQcd+iix98k7GnhQe12cym60QpnP3LB+9tN+D5Kw1IKnz/MWviUjQV63rsk2nxRRZ
 voYxgzRWxJzY/+HpjD829LuzfZP+rxyreBfeYNElaHe1pIbRlESdNpQcCYxLbWw3Sr
 qnj2qmCbcPp/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi_common: take i2c adapter module
 reference
To: "Johan Hovold" <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716132103.1564995-1-johan@kernel.org>
References: <20260716132103.1564995-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:36:48 +0000
Message-Id: <20260716133648.925D51F00A3A@smtp.kernel.org>
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
- [High] Double-free of I2C adapter device and module references during dri=
ver unbind due to conflicting manual and devm cleanups.
--

--- Patch [1]: [PATCH] drm/mediatek: mtk_hdmi_common: take i2c adapter modu=
le reference ---
commit cbad79e276722919c8f55731b14f0b51837c5548
Author: Johan Hovold <johan@kernel.org>

drm/mediatek: mtk_hdmi_common: take i2c adapter module reference

The patch switches to of_get_i2c_adapter_by_node() which grabs a
module reference, allowing graceful module unload failures instead
of uninterruptible blocking. It updates the devm action to call
mtk_hdmi_put_adapter which wraps i2c_put_adapter.

> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm=
/mediatek/mtk_hdmi_common.c
> index a049489daa2d7..042b98e5a5199 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
[ ... ]
> @@ -328,12 +335,12 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi =
*hdmi, struct platform_device
>  	if (!i2c_np)
>  		return dev_err_probe(dev, -EINVAL, "No ddc-i2c-bus in connector\n");
> =20
> -	hdmi->ddc_adpt =3D of_find_i2c_adapter_by_node(i2c_np);
> +	hdmi->ddc_adpt =3D of_get_i2c_adapter_by_node(i2c_np);
>  	of_node_put(i2c_np);
>  	if (!hdmi->ddc_adpt)
>  		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to get ddc i2c adapte=
r by node\n");
> =20
> -	ret =3D devm_add_action_or_reset(dev, mtk_hdmi_put_device, &hdmi->ddc_a=
dpt->dev);
> +	ret =3D devm_add_action_or_reset(dev, mtk_hdmi_put_adapter, hdmi->ddc_a=
dpt);

[Severity: High]
This is a pre-existing issue, but does this devm cleanup conflict with a
manual cleanup during driver unbind?

Looking at mtk_hdmi_v2_remove() in drivers/gpu/drm/mediatek/mtk_hdmi_v2.c,
there is a manual call to i2c_put_adapter(hdmi->ddc_adpt).

When the driver unbinds, mtk_hdmi_v2_remove() will run and release the
adapter. After the remove callback returns, the device core will execute
the devres action registered here. This will invoke mtk_hdmi_put_adapter()
and call i2c_put_adapter() a second time on the same pointer.

Will this result in a double-free of the I2C adapter device and a double
module_put()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132103.1564=
995-1-johan@kernel.org?part=3D1
