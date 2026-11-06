Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB10606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9pt5+7J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D153C10E3C7;
	Fri,  6 Nov 2026 14:53:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AB710EA60
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:53:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0807423D6;
 Fri,  6 Nov 2026 14:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A41F0089F;
 Fri,  6 Nov 2026 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793976780;
 bh=EsolZNfyD+bHiet81+Z3iBmlJDTRfQoAjTzfsBSlFiI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U9pt5+7JZbuD1jlH9TmK0E30wyI6bOHT3EDfEbhJ/v5C0KCfPFdZHbBebbiXiLEIJ
 /4WNH5kgWDKaL1eLf+RmHdFMj4a/iJVwR2fNNRZb+OlKtMrpR40aloS4DP7EX0niMF
 jSxV4aoeTGN2YJ/YbGd//S+A/Cd+m83GPMeZdQgpHaJN73IWx4pUW3/ubMSFm+jPLx
 LJWVeYLG9hZnyVCCXSY+Vm+15tD+K0F7dzFlfbe9dnS9OA/72mElCm6q6ivFFsCCCu
 SZ+8n3/FGgtXgEEGzMTB4TF3mIKR8DsYuUSulAkFMHlae0RqMPn+5pxfE0PTUoxf93
 jwpcWY6gb6AWw==
Message-ID: <sashiko-outbox-201623@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/19] drm/bridge: inno-hdmi: Split probe out of bind
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106-jh7110-clean-send-v7-8-68f7ea9913db@samsung.com>
References: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
 <CGME20261106135904eucas1p14897dcc411c444d202a38190fdffffe7@eucas1p1.samsung.com>
 <20261106-jh7110-clean-send-v7-8-68f7ea9913db@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:52:59 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/bridge: inno-hdmi: race on bridge.dev in inno_hdmi_irq()
  after probe split
--

commit b0209990726be89f8d7446a146a593a4fe328e8b
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Split probe out of bind

This commit splits hardware and bridge setup out of inno_hdmi_bind() into
an exported inno_hdmi_probe() helper so standalone platform drivers can
register the bridge without immediately attaching it to an encoder.

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index 5bfe59f18823a..aa64ffdbd3072 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -1063,11 +1063,24 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(=
struct inno_hdmi *hdmi)
>  	return adap;
>  }
> =20
> -struct inno_hdmi *inno_hdmi_bind(struct device *dev,
> -				 struct drm_encoder *encoder,
> -				 const struct inno_hdmi_plat_data *plat_data)
> +/**
> + * inno_hdmi_probe - Internal helper to perform common setup
> + * @pdev: platform device
> + * @plat_data: SoC-specific platform data
> + *
> + * This function handles all the common hardware setup: allocating the m=
ain
> + * struct, mapping registers, getting clocks, initializing the hardware,
> + * setting up the IRQ, and initializing the DDC adapter and bridge struc=
t.
> + *
> + * It registers the bridge but does not attach it, for glue drivers that=
 probe
> + * as their own platform device rather than through a component bind.
> + *
> + * Return: the inno_hdmi instance on success, or an ERR_PTR() on failure.
> + */
> +struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
> +				  const struct inno_hdmi_plat_data *plat_data)
>  {
> -	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct device *dev =3D &pdev->dev;
>  	struct inno_hdmi *hdmi;
>  	int irq;
>  	int ret;
> @@ -1131,7 +1144,23 @@ struct inno_hdmi *inno_hdmi_bind(struct device *de=
v,
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
> -	ret =3D drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTA=
CH_NO_CONNECTOR);
> +	return hdmi;
> +}
> +EXPORT_SYMBOL_GPL(inno_hdmi_probe);

[Severity: Medium]
Can inno_hdmi_irq() race with drm_bridge_detach() on hdmi->bridge.dev when
a standalone bridge driver uses inno_hdmi_probe()?

Previously, inno_hdmi_bind() was called from component bind, so
component_unbind_all() released the devm_request_threaded_irq() handler
before drm_dev_put() detached the bridge and freed the drm_device.  When a
standalone platform driver calls inno_hdmi_probe(), the threaded IRQ stays
active for the lifetime of the bridge platform_device while the display
driver attaches and detaches the bridge.

drivers/gpu/drm/bridge/inno-hdmi.c:inno_hdmi_irq() {
	/* bridge.dev is NULL until drm_bridge_attach() */
	if (hdmi->bridge.dev)
		drm_helper_hpd_irq_event(hdmi->bridge.dev);
}

If an HPD interrupt fires while the display driver is tearing down its
drm_device, inno_hdmi_irq() reads hdmi->bridge.dev without synchronization
against drm_bridge_detach() and drm_dev_put():

CPU0                                  CPU1 (irq/inno_hdmi_irq)
drm_dev_put(drm)
  ...
    drm_encoder_cleanup(encoder)
      drm_bridge_detach(&hdmi->bridge)
                                      if (hdmi->bridge.dev)
        bridge->dev =3D NULL;
  kfree(drm)
                                        drm_helper_hpd_irq_event(...)
                                          <-- use-after-free or NULL deref

Depending on timing, this causes either a use-after-free of the drm_device
or a NULL pointer dereference in drm_helper_hpd_irq_event() if the compiler
reloads hdmi->bridge.dev.  Calling drm_bridge_hpd_notify(&hdmi->bridge,
status) instead of drm_helper_hpd_irq_event() would serialize against HPD
disable through bridge->hpd_mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-jh7110-cle=
an-send-v7-0-68f7ea9913db@samsung.com?part=3D8
