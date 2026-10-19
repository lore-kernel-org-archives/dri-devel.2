Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD90CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8F410E8EA;
	Mon, 19 Oct 2026 09:28:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BA310E925
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:28:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B46E8601FB;
 Mon, 19 Oct 2026 09:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114421F000C4;
 Mon, 19 Oct 2026 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792402125;
 bh=NzdPriWzb+PpbEYkskFC7C89IytwDvaipdXCbKfL/IQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EwmRQMMocmHkEPChHkb1uUmOc+j0ZXLweK24sncr1hDEZleuQ66shSnkj34k6xled
 YOqPXiQetrRFajrgZhe58gfO0yr0MogJ83VPsoq38YjBKeE7j8lD/ib6ViYvtWuc4e
 RS2Ynk7my8Xe1OsO8LVTDoFtM9Ue8LH2RdNExpAj7Ky7L3e2WGW6E1gcTErwEzh34O
 S1jYZgluvM17x2doNEVVyPDDsw0m5WRX077mYQ+B+/op14OjZlAOWEDLHeQWRK4sV0
 NVSE823Yj8iRlBmew7xsF1/lfLHWJh1ENAvhJEtPmcLWt0v7ARbjYk+ckooekGQVpz
 R5V7wfrVXVQgQ==
Message-ID: <sashiko-outbox-176903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] drm/panel: add Novatek NT36850 panel driver
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019-sdm845-hdk-v5-2-4aa7e22cd0ed@oss.qualcomm.com>
References: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
 <20261019-sdm845-hdk-v5-2-4aa7e22cd0ed@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:28:44 +0000
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
- [Low] drm/panel: missing select DRM_KMS_HELPER in DRM_PANEL_NOVATEK_NT368=
50
--

commit 6d69498564f980cf8c931a0b5bc25de370ede1e6
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/panel: add Novatek NT36850 panel driver

This commit adds a DRM panel driver for the Truly WQHD dual-DSI command mode
panel built around the Novatek NT36850 display controller.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index cbdf7b8f7f7af..2cb49e6595d64 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -697,6 +697,16 @@ config DRM_PANEL_NOVATEK_NT36672E
>  	  LCD panel module. The panel has a resolution of 1080x2408 and uses 24=
 bit
>  	  RGB per pixel.
> =20
> +config DRM_PANEL_NOVATEK_NT36850
> +	tristate "Novatek NT36850 panel driver"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for the panels built
> +	  around the Novatek NT36850 display controller, such as some
> +	  Truly panels used in Qualcomm development kits.
> +

[Severity: Low]
Should DRM_PANEL_NOVATEK_NT36850 select DRM_KMS_HELPER here?

In drivers/gpu/drm/panel/panel-novatek-nt36850.c, nt36850_get_modes() calls
drm_connector_helper_get_modes_fixed(), which is built as part of
drm_kms_helper.o under CONFIG_DRM_KMS_HELPER:

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36850.c b/drivers/gpu/=
drm/panel/panel-novatek-nt36850.c
> new file mode 100644
> index 0000000000000..0d1eeba539dbd
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36850.c

[ ... ]

> +static int nt36850_get_modes(struct drm_panel *panel,
> +			       struct drm_connector *connector)
> +{
> +	struct panel_info *pinfo =3D to_panel_info(panel);
> +
> +	connector->display_info.bpc =3D pinfo->desc->bpc;
> +
> +	return drm_connector_helper_get_modes_fixed(connector, pinfo->desc->mod=
e);
> +}

[ ... ]

When CONFIG_DRM_PANEL_NOVATEK_NT36850=3Dy and CONFIG_DRM_KMS_HELPER=3Dm (or=
 n),
could linking vmlinux fail with an undefined reference to
drm_connector_helper_get_modes_fixed?

[ ... ]

> +module_mipi_dsi_driver(nt36850_driver);
> +
> +MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>");
> +MODULE_DESCRIPTION("DRM driver for Novatek NT36850 based MIPI DSI panels=
");
> +MODULE_LICENSE("GPL");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-sdm845-hdk=
-v5-0-4aa7e22cd0ed@oss.qualcomm.com?part=3D2
