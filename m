Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910E5C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD44610F26F;
	Thu, 13 Aug 2026 09:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="CsFqwGVi";
	dkim-atps=neutral
X-Greylist: delayed 53025 seconds by postgrey-1.36 at gabe;
 Wed, 12 Aug 2026 20:05:40 UTC
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689FB10E076
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786565136; x=1786824336;
 bh=x5OEyYc0In7xqxAI/atX6wyDHKDcVDmPSMTIy6wnqKc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CsFqwGVikvTRySpnAMiEtKmXdsRgVnQMIJ1EcBGuzXka6qdEJ9K0uvHfv3sbUhGW1
 m/3NtsKwdhPFrF77kC3wQT43cLE0YspCJAzF5qEGrI3v6yHFxU5SlLsCfM7iswSI58
 mC5uwWx3adMqWEVvpEiPwsJlGXaHA0ZVOLOlmEIdCz5EdprPpzxkJ4Yhy/XCuR/hZG
 6XCuwppBVqXM+XUjLAxT+HDeSDbjp0hcTFJ1iE+nZr1n1/yrqCgHJfblNP/rZakrnH
 s3snm0rMkR6aTKUTgsKTX8VWAT/9urFyvteBy9FE98nk+Z5fYWgeKKH6nMqMfre5Gt
 yvG2viqc/jswA==
Date: Wed, 12 Aug 2026 20:05:30 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Novatek NT37703 based panels
Message-ID: <d74f4f83-b7a3-413b-8c12-e52d90914ada@proton.me>
In-Reply-To: <7757da0a-ef3a-44b0-99c2-af9af3e21a0b@linaro.org>
References: <20260811-nt37703-bup-v1-0-34ad42b064a3@proton.me>
 <20260811-nt37703-bup-v1-2-34ad42b064a3@proton.me>
 <7757da0a-ef3a-44b0-99c2-af9af3e21a0b@linaro.org>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: fbcc33b88767e0c67c075d124abede96708e5937
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 8/12/26 7:55 AM, Neil Armstrong wrote:
>> +static int nt37703_get_modes(struct drm_panel *panel, struct drm_connec=
tor *connector)
>> +{
>> +=09struct panel_info *pinfo =3D to_panel_info(panel);
>> +=09int i;
>> +
>> +=09for (i =3D 0; i < pinfo->desc->num_modes; i++) {
>> +=09=09const struct drm_display_mode *m =3D &pinfo->desc->modes[i];
>> +=09=09struct drm_display_mode *mode;
>> +
>> +=09=09mode =3D drm_mode_duplicate(connector->dev, m);
>> +=09=09if (!mode) {
>> +=09=09=09dev_err(panel->dev, "Failed to add mode %ux%u@%u\n", m->hdispl=
ay,
>> +=09=09=09=09m->vdisplay, drm_mode_vrefresh(m));
>> +=09=09=09return -ENOMEM;
>> +=09=09}
>> +
>> +=09=09mode->type =3D DRM_MODE_TYPE_DRIVER;
>> +=09=09if (i =3D=3D 0)
>> +=09=09=09mode->type |=3D DRM_MODE_TYPE_PREFERRED;
>> +
>> +=09=09drm_mode_set_name(mode);
>> +=09=09drm_mode_probed_add(connector, mode);
>> +=09}
>> +
>> +=09connector->display_info.width_mm =3D pinfo->desc->width_mm;
>> +=09connector->display_info.height_mm =3D pinfo->desc->height_mm;
>> +
>> +=09return pinfo->desc->num_modes;
>=20
> The only supported panel only supports a single mode, just support
> a single mode for now and drop this open coded support for multiple modes=
.
>=20
> You can add it later if somehow you need multiple modes.


The idea is that for each new panel, instead of modifying the driver,
only these structures are added:
- (panel)_modes[]
- (panel)_init_sequence()
- struct drm_dsc_config (panel)_dsc
- (panel)_desc
And modifying the of_device_id table afterwards.

So dropping only the modes would mean getting rid of all these
altogether, otherwise the only supported mode would be hardcoded which
renders these structures useless.

[...]

>> +static int nt37703_probe(struct mipi_dsi_device *dsi)
>> +{
>> +=09struct device *dev =3D &dsi->dev;
>> +=09struct panel_info *pinfo;
>> +=09int ret;
>> +
>> +=09pinfo =3D devm_drm_panel_alloc(dev, struct panel_info, panel, &nt377=
03_panel_funcs,
>> +=09=09=09=09     DRM_MODE_CONNECTOR_DSI);
>> +=09if (IS_ERR(pinfo))
>> +=09=09return PTR_ERR(pinfo);
>> +
>> +=09pinfo->desc =3D of_device_get_match_data(dev);
>> +=09if (IS_ERR(pinfo->desc))
>> +=09=09return PTR_ERR(pinfo->desc);
>> +
>> +=09ret =3D devm_regulator_bulk_get_const(dev, ARRAY_SIZE(nt37703_suppli=
es), nt37703_supplies,
>> +=09=09=09=09=09    &pinfo->supplies);
>> +=09if (ret < 0)
>> +=09=09return dev_err_probe(dev, ret, "Failed to get regulators\n");
>> +
>> +=09pinfo->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>> +=09if (IS_ERR(pinfo->reset_gpio))
>> +=09=09return dev_err_probe(dev, PTR_ERR(pinfo->reset_gpio),
>> +=09=09=09=09     "Failed to get reset-gpios\n");
>> +
>> +=09pinfo->dsi =3D dsi;
>> +=09mipi_dsi_set_drvdata(dsi, pinfo);
>> +
>> +=09dsi->lanes =3D pinfo->desc->lanes;
>> +=09dsi->format =3D pinfo->desc->format;
>> +=09dsi->mode_flags =3D pinfo->desc->mode_flags;
>> +
>> +=09pinfo->panel.prepare_prev_first =3D true;
>> +
>> +=09pinfo->panel.backlight =3D nt37703_create_backlight(dsi);
>> +=09if (IS_ERR(pinfo->panel.backlight))
>> +=09=09return dev_err_probe(dev, PTR_ERR(pinfo->panel.backlight),
>> +=09=09=09=09     "Failed to create backlight\n");
>> +
>> +=09drm_panel_add(&pinfo->panel);
>=20
> Use devm_ variant


Ack

>> +
>> +=09/* This panel only supports DSC; unconditionally enable it */
>> +=09pinfo->dsc =3D *(pinfo->desc->dsc);
>> +=09dsi->dsc =3D &pinfo->dsc;
>> +
>> +=09ret =3D mipi_dsi_attach(dsi);
>=20
> Use devm_ variant

Ack


>> +=09if (ret < 0) {
>> +=09=09drm_panel_remove(&pinfo->panel);
>> +=09=09return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
>> +=09}
>> +
>> +=09return 0;
>> +}
>> +
>> +static void nt37703_remove(struct mipi_dsi_device *dsi)
>> +{
>> +=09struct panel_info *pinfo =3D mipi_dsi_get_drvdata(dsi);
>> +=09int ret;
>> +
>> +=09ret =3D mipi_dsi_detach(dsi);
>> +=09if (ret < 0)
>> +=09=09dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
>> +
>> +=09drm_panel_remove(&pinfo->panel);
>> +}
>=20
> And drop the remove()


Ack

Thanks for reviewing.
Regards,
Esteban

