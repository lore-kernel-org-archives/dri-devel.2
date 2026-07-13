Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D337C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C9210E345;
	Mon, 13 Jul 2026 11:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EtXIWSzH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AC710E345
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 11:43:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5B58412BC;
 Mon, 13 Jul 2026 11:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8DA1F000E9;
 Mon, 13 Jul 2026 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783943034;
 bh=FA5sgqjvQjZRyts8vzjbpcKLs5iIbjcY8Nd4IZFvOLs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EtXIWSzHxllU34WHRkfr0cxuTQef5Zn5NB2EYqwReexhRNWWSx+YBgRVYY85TFEy9
 BbxDWIkQNiFzm3U4kWv8DJ7ZZCGu0ySg1H2rpU+uaxVg8T8vpHs2BrPXDAfowD5g7U
 KGZwOGZ2O+r2ZkOO7sDY/89wwe3Z8uvSG+0Hn/1pX5vYwk4uf70xK85C1OdAcmYb1K
 TUeDaY6xPHfV0qcMTImiWtbUBPJgJObhtGkzcnUAO5n8C8MyJrU6aain6KkwKMPMyN
 2DeoPEnioCoiwHjIH6aUbBv72jJWNCV/H5Xp6+cppW2pPTM/osEl9Q2y6RAtb0Lzn4
 xx84tm7NdKWnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/mediatek: mtk_hdmi: Fix DDC adapter double put
 in v2
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713112957.884640-1-lgs201920130244@gmail.com>
References: <20260713112957.884640-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 11:43:53 +0000
Message-Id: <20260713114354.5F8DA1F000E9@smtp.kernel.org>
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
- [High] Clocks acquired via `of_clk_get_by_name()` are never released, cau=
sing a permanent memory and module reference leak.
- [High] The bridge reference acquired via `of_drm_find_and_get_bridge()` i=
s leaked on error paths and during driver unbind.
- [High] The driver uses `of_find_i2c_adapter_by_node()` instead of `of_get=
_i2c_adapter_by_node()`, failing to pin the I2C adapter module.
--

--- Patch [1]: [PATCH v3] drm/mediatek: mtk_hdmi: Fix DDC adapter double pu=
t in v2 ---
commit 0f15e03f2f19d66ee64acb93c6d5a19fae97377f
Author: Guangshuo Li <lgs201920130244@gmail.com>
Subject: drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2

This commit fixes a double-put issue with the DDC I2C adapter in the HDMI v2
driver. The probe function registers a devm action to release the adapter,
but the remove callback also manually dropped the reference. This removes
the manual drop and the empty remove callback.

> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi_v2.c
> index d9316d30fd5f7..f0277fcf3345b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> @@ -1499,13 +1499,6 @@ static int mtk_hdmi_v2_probe(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -static void mtk_hdmi_v2_remove(struct platform_device *pdev)
> -{
> -	struct mtk_hdmi *hdmi =3D platform_get_drvdata(pdev);
> -
> -	i2c_put_adapter(hdmi->ddc_adpt);
> -}
> -

[Severity: High]
This isn't a bug introduced by this patch, but while you are cleaning up the
I2C adapter references here, the underlying use of of_find_i2c_adapter_by_n=
ode()
in mtk_hdmi_dt_parse_pdata() might be incorrect:

drivers/gpu/drm/mediatek/mtk_hdmi_common.c:mtk_hdmi_dt_parse_pdata() {
    ...
    hdmi->ddc_adpt =3D of_find_i2c_adapter_by_node(i2c_np);
    ...
}

It appears of_find_i2c_adapter_by_node() only increments the device referen=
ce
count, but does not pin the I2C adapter driver module.

Could this allow the adapter module to be unexpectedly unloaded while the H=
DMI
driver is still bound? If drm_edid_read_ddc() later attempts to read the ED=
ID
via i2c_transfer(), it might cause a crash by accessing the unloaded module.

Would it be safer to use of_get_i2c_adapter_by_node() to properly pin the
module?

[Severity: High]
This is a pre-existing issue, but I noticed there might be a memory and mod=
ule
reference leak during clock initialization.

drivers/gpu/drm/mediatek/mtk_hdmi_common.c:mtk_hdmi_get_all_clk() {
    ...
    hdmi->clk[i] =3D of_clk_get_by_name(np, clock_names[i]);
    ...
}

The of_clk_get_by_name() function allocates a new struct clk and increments
the provider's module reference count, but these clocks don't seem to ever =
be
released with clk_put().

If the probe is later deferred (e.g., returning -EPROBE_DEFER when waiting =
for
the remote bridge or DDC I2C adapter), will all successfully acquired clocks
be permanently leaked?

[Severity: High]
This is also a pre-existing issue, but there appears to be a leaked bridge
module reference on error paths:

drivers/gpu/drm/mediatek/mtk_hdmi_common.c:mtk_hdmi_dt_parse_pdata() {
    ...
    hdmi->bridge.next_bridge =3D of_drm_find_and_get_bridge(remote);
    ...
}

This successfully bumps the module reference count of the bridge driver.

However, if the subsequent call to of_find_i2c_adapter_by_node() fails and
returns -EPROBE_DEFER, the driver bails out of probe without dropping the b=
ridge
reference via drm_bridge_put().

Could this permanently leak the bridge module reference count, preventing t=
he
external bridge module from being unloaded?

>  static const struct of_device_id mtk_drm_hdmi_v2_of_ids[] =3D {
>  	{ .compatible =3D "mediatek,mt8188-hdmi-tx", .data =3D &mtk_hdmi_conf_m=
t8188 },
>  	{ .compatible =3D "mediatek,mt8195-hdmi-tx", .data =3D &mtk_hdmi_conf_m=
t8195 },
> @@ -1515,7 +1508,6 @@ MODULE_DEVICE_TABLE(of, mtk_drm_hdmi_v2_of_ids);
> =20
>  static struct platform_driver mtk_hdmi_v2_driver =3D {
>  	.probe =3D mtk_hdmi_v2_probe,
> -	.remove =3D mtk_hdmi_v2_remove,
>  	.driver =3D {
>  		.name =3D "mediatek-drm-hdmi-v2",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713112957.8846=
40-1-lgs201920130244@gmail.com?part=3D1
