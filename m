Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E700606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ob0X2G2w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7EF10EE66;
	Sat, 14 Nov 2026 05:35:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E64B10EE66
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:35:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6242440141;
 Sat, 14 Nov 2026 05:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC61F000C4;
 Sat, 14 Nov 2026 05:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794634511;
 bh=p6NbTdvOfzySm6kJdMeRe8au78jL3SvlAsiNxTZt/Bk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ob0X2G2we2MCyJwr0EHAk4LboiZ/234NI25Dwi2ZiJSoaxy6bhN/XM6QEvtB29wTw
 ocqsg5tdOp7gGLLqfeGAK/8eLD+bgtJO0XpU1Qrt79Sr3/0BYYpAzXO0Mn8pNT+nOq
 SuzIbv8vxVfo5h38JisrqEsTU+GGQ88bD6+p35HE97WxVCCz+mmKFPspcIoBzrYlJk
 Yc6aVQwzRaQ+qorXN2jHbYaFfX8/Mk8VcRLjGosQi2k9HvnmTS16J2TqgZgX/3Zwsc
 oYSg1V4KGfwO3nJSwdkRQE7wnGGtyJSOGV9qiRHTsyGFk3TKvbPo4q57B28V/jcqUA
 JCkPUfDyJVV0w==
Message-ID: <sashiko-outbox-214184@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/23] drm/bridge: synopsys: dw-dp: Fix incorrect
 resource lifetimes in bind callback
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-2-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
 <20261114-synopsys-dw-dp-improvements-v12-2-d42d3dc5bdd4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:35:10 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/rockchip: dw_dp: bridge not detached on unbind in
  dw_dp_rockchip_unbind()
- [Medium] drm/bridge: dw-dp: disable_irq() in dw_dp_bridge_detach()
  starves AUX transfers
- [Low] drm/bridge: dw-dp: missing struct platform_device forward
  declaration
--

commit a9596a762ddd1d48c8d46fe4311e13805a449537
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callb=
ack

This commit moves the DesignWare DP controller's devm-managed resource
allocation and bridge registration from dw_dp_bind() into a new
dw_dp_probe() helper, leaving only drm_bridge_attach() in dw_dp_bind() and
enabling the interrupt only while the bridge is attached.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 0a34d6a6ace46..ac16d290d49be 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1827,16 +1827,22 @@ static int dw_dp_bridge_attach(struct drm_bridge =
*bridge,
>  	dp->aux.transfer =3D dw_dp_aux_transfer;
> =20
>  	ret =3D drm_dp_aux_register(&dp->aux);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "Aux register failed: %d\n", ret);
> +		return ret;
> +	}
> =20
> -	return ret;
> +	enable_irq(dp->irq);
> +
> +	return 0;
>  }
> =20
>  static void dw_dp_bridge_detach(struct drm_bridge *bridge)
>  {
>  	struct dw_dp *dp =3D bridge_to_dp(bridge);
> =20
> +	disable_irq(dp->irq);
> +	cancel_work_sync(&dp->hpd_work);
>  	drm_dp_aux_unregister(&dp->aux);
>  }

[Severity: Medium]
Does calling disable_irq(dp->irq) before cancel_work_sync(&dp->hpd_work)
and drm_dp_aux_unregister(&dp->aux) starve in-flight AUX transfers?

Both HPD_EVENT and AUX_REPLY_EVENT share dp->irq, and dw_dp_aux_transfer()
waits on dp->complete, which is signaled from dw_dp_irq().  If
dw_dp_hpd_work() or a /dev/drm_dp_aux* transaction is running when
dw_dp_bridge_detach() disables dp->irq, AUX_REPLY_EVENT is never delivered
and every DPCD retry in drm_dp_dpcd_access() stalls until
wait_for_completion_timeout() expires.

[ ... ]

> @@ -1982,6 +1988,18 @@ static const struct regmap_config dw_dp_regmap_con=
fig =3D {
>  	.rd_table =3D &dw_dp_readable_table,
>  };
> =20
> +int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
> +{
> +	return drm_bridge_attach(encoder, &dp->bridge, NULL, DRM_BRIDGE_ATTACH_=
NO_CONNECTOR);
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_bind);
> +
> +void dw_dp_unbind(struct dw_dp *dp)
> +{
> +	/* nothing to do as bridge is detached automatically */
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_unbind);

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index b23efb153c9e6..38e8fe75718e4 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c

[ ... ]

> @@ -73,37 +73,28 @@ static const struct drm_encoder_helper_funcs dw_dp_en=
coder_helper_funcs =3D {
> =20
>  static int dw_dp_rockchip_bind(struct device *dev, struct device *master=
, void *data)
>  {
> -	struct platform_device *pdev =3D to_platform_device(dev);
> -	const struct dw_dp_plat_data *plat_data;
> +	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
>  	struct drm_device *drm_dev =3D data;
> -	struct rockchip_dw_dp *dp;
>  	struct drm_encoder *encoder;
>  	struct drm_connector *connector;
>  	int ret;
> =20
> -	dp =3D drmm_kzalloc(drm_dev, sizeof(*dp), GFP_KERNEL);
> -	if (!dp)
> +	dp->encoder =3D drmm_kzalloc(drm_dev, sizeof(*dp->encoder), GFP_KERNEL);
> +	if (!dp->encoder)
>  		return -ENOMEM;
> =20
> -	dp->dev =3D dev;
> -	platform_set_drvdata(pdev, dp);
> -
> -	plat_data =3D of_device_get_match_data(dev);
> -	if (!plat_data)
> -		return -ENODEV;
> -
> -	encoder =3D &dp->encoder.encoder;
> +	encoder =3D &dp->encoder->encoder;
>  	encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm_dev, dev->of=
_node);
> -	rockchip_drm_encoder_set_crtc_endpoint_id(&dp->encoder, dev->of_node, 0=
, 0);
> +	rockchip_drm_encoder_set_crtc_endpoint_id(dp->encoder, dev->of_node, 0,=
 0);
> =20
>  	ret =3D drmm_encoder_init(drm_dev, encoder, NULL, DRM_MODE_ENCODER_TMDS=
, NULL);
>  	if (ret)
>  		return ret;
>  	drm_encoder_helper_add(encoder, &dw_dp_encoder_helper_funcs);
> =20
> -	dp->base =3D dw_dp_bind(dev, encoder, plat_data);
> -	if (IS_ERR(dp->base))
> -		return PTR_ERR(dp->base);
> +	ret =3D dw_dp_bind(dp->base, encoder);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to bind DW-DP bridge\n");
> =20
>  	connector =3D drm_bridge_connector_init(drm_dev, encoder);
>  	if (IS_ERR(connector)) {

[Severity: High]
Does keeping drmm_encoder_init() while making dw_dp_unbind() a no-op leave
dp->bridge attached across component unbind?

drmm_encoder_init() defers drm_encoder_cleanup() -> drm_bridge_detach() ->
dw_dp_bridge_detach() until the final drm_device reference drops in
drm_managed_release().  If the component is unbound while userspace holds
an open file descriptor to /dev/dri/card*, drm_dev_put() in
rockchip_drm_unbind() does not release drm_dev:

- If the dw-dp platform device is then removed, devres_release_all() frees
  dp->irq, dp->regmap, MMIO, clocks and dp->phy while dw_dp_bridge_detach()
  has not run, leaving dp->hpd_work and dp->aux active against freed
  resources (use-after-free) and later calling disable_irq() on a freed IRQ
  when the DRM fd closes.
- If the component is rebound while the old DRM fd is still open,
  dp->bridge.dev is still non-NULL and drm_bridge_attach() in dw_dp_bind()
  fails with -EBUSY.
- If drm_bridge_connector_init() or a later component's bind fails, the
  error path calls the no-op dw_dp_unbind(), leaving dp->irq enabled and
  dp->aux registered while earlier components are unbound.

Initializing the encoder with drm_encoder_init() and calling
drm_encoder_cleanup() in dw_dp_rockchip_unbind() and on the
drm_bridge_connector_init() error path (as analogix_dp-rockchip.c and
cdn-dp-core.c do) would detach the bridge synchronously at unbind time.

[ ... ]

> diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
> index 22105c3e8e4d6..a82412a9e7695 100644
> --- a/include/drm/bridge/dw_dp.h
> +++ b/include/drm/bridge/dw_dp.h
> @@ -22,7 +22,8 @@ struct dw_dp_plat_data {
>  	u8 pixel_mode;
>  };
> =20
> -struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
> -			 const struct dw_dp_plat_data *plat_data);
> +int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder);
>  void dw_dp_unbind(struct dw_dp *dp);
> +
> +struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_=
dp_plat_data *plat_data);
>  #endif /* __DW_DP__ */

[Severity: Low]
Does include/drm/bridge/dw_dp.h need a forward declaration for struct
platform_device?

This header only includes <linux/device.h> and forward-declares struct
drm_encoder and struct dw_dp, so compiling it standalone (e.g. with
CONFIG_DRM_HEADER_TEST=3Dy) or before <linux/platform_device.h> triggers a
-Wvisibility warning on dw_dp_probe().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-synopsys-d=
w-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com?part=3D2
