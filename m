Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9E3CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F27810FEC3;
	Wed, 14 Oct 2026 16:32:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB7110FEBD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:32:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 54F7760229;
 Wed, 14 Oct 2026 16:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07051F000C4;
 Wed, 14 Oct 2026 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791995556;
 bh=WugKqNWDagJkCYw+gyR9YtW0vgdFoHCnPeWVVs+DThc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d7rbNsmt0QRNMrSW07NFzav91k33a4AeKdIW/lso/Kz9nHKcUJQEDEnBMjFVdte3A
 6N64q78dr0VXmZEtbwIzoxE63I54PrV0lzPjCiOo9wZ9grShrzGlvDIDVk7uwWshIy
 /zcdE9Of0u7QTNA/kZsyu8hOp8DoJhJXz6KSWf9m5CP2bzxTPgyhG9cdF5ChYJPtpL
 AQrOis453K88sHv3a9H08Clbi9037is9wIf5EsjXtrf+9fEza3py4pHWxbjh5houQA
 d8rXJvSCtGDVlD2a4J5HlqyuOkvkTkMFHVEHWhBsEw7skh5dPEo2t29n9eOTUo4Rxq
 gdQiMDGwCaeKg==
Message-ID: <sashiko-outbox-171534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm/panel: add Novatek NT36850 panel driver
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014-sdm845-hdk-v2-2-6d0b4b42f267@oss.qualcomm.com>
References: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
 <20261014-sdm845-hdk-v2-2-6d0b4b42f267@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:32:35 +0000
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
- [Medium] drm/panel: uninitialized dsi_info causes empty secondary DSI dev=
ice name
--

commit d78556555a8b667c80856e68aa43c5f0f311c5d4
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/panel: add Novatek NT36850 panel driver

This commit adds support for the Truly WQHD dual-DSI command mode panel
using the Novatek NT36850 controller. It configures power sequences,
initialization commands, and secondary host registration.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36850.c b/drivers/gpu/=
drm/panel/panel-novatek-nt36850.c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36850.c
> [ ... ]
> +static const struct panel_desc truly_wqhd_desc =3D {
> +	.mode =3D &truly_wqhd_mode,
> +	.bpc =3D 8,
> +	.lanes =3D 4,
> +	.format =3D MIPI_DSI_FMT_RGB888,
> +	.mode_flags =3D MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
> +	.init_sequence =3D truly_wqhd_init_sequence,
> +	.is_dual_dsi =3D true,
> +};

[Severity: Medium]
Because the dsi_info struct field is completely omitted here, it is
zero-initialized by the compiler.

> [ ... ]
> +static int nt36850_probe(struct mipi_dsi_device *dsi)
> +{
> [ ... ]
> +	/* If the panel is dual dsi, register DSI1 */
> +	if (pinfo->desc->is_dual_dsi) {
> +		info =3D &pinfo->desc->dsi_info;
> [ ... ]
> +		dsi1_host =3D of_find_mipi_dsi_host_by_node(dsi1);
> +		of_node_put(dsi1);
> +		if (!dsi1_host)
> +			return dev_err_probe(dev, -EPROBE_DEFER, "cannot get secondary DSI ho=
st\n");
> +
> +		pinfo->dsi[1] =3D devm_mipi_dsi_device_register_full(dev, dsi1_host, i=
nfo);

[Severity: Medium]
Does passing this zero-initialized info struct to
devm_mipi_dsi_device_register_full() cause a malformed sysfs representation?

The MIPI DSI core copies info->type into dsi->name. Since info->type is
empty, it results in an empty string as the device name, creating a broken
uevent modalias of MODALIAS=3Dmipi: with no actual name.

Should truly_wqhd_desc be updated to include a valid string in .dsi_info
so the secondary device is properly represented?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-sdm845-hdk=
-v2-0-6d0b4b42f267@oss.qualcomm.com?part=3D2
