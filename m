Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3A8C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 19:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBA510E074;
	Mon,  3 Aug 2026 19:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V42jbEtP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3D110E074
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 19:11:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C440E60AB5;
 Mon,  3 Aug 2026 19:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6881F000E9;
 Mon,  3 Aug 2026 19:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785784285;
 bh=CEkB3xaDs0YfnDvaLlwCGFAPS42mAHu8+bIMDJw6FWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V42jbEtPHEasv/YwWqUtEjJVvPNxlVam/kdBKspeE4qeAcR1hhRX6R/z6TW+68hNJ
 gjc4o9QjhAsBcyWnXaruuJgm8M+9+TOceRJYmxqpxK59nbjt1FJvp+uyMbKPNvB/T0
 1SrQF7JjkU6I5eh1gaoHpgLQ1dNPFQ081ZLd30rku2pOSTi11KG11vzpgnW346rpdM
 8FIrRlJQa0InjOCbz9LwL1rFnTuR/+vwoWleIaOoSMPVdOzI9uEPeMeeKKdbzcajaL
 7DOMIKODr1tOXahWrZNuL63DMYpqTtqAbWaQqRud05iZIsj8yzj5621ZZ24nh1zy+f
 e88NnxMfWCwvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 22/22] drm/bridge: synopsys: dw-dp: Add audio support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-22-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260803-synopsys-dw-dp-improvements-v9-22-2e6e46135312@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 19:11:24 +0000
Message-Id: <20260803191124.DB6881F000E9@smtp.kernel.org>
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
- [Medium] The result of regmap_read() is used without checking its return =
value, potentially leading to the use of uninitialized stack memory.
--

--- Patch [22]: [PATCH v9 22/22] drm/bridge: synopsys: dw-dp: Add audio sup=
port ---
commit f36ed9436eafc188ce4405c443eb47147a26dbd1
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
drm/bridge: synopsys: dw-dp: Add audio support

This commit implements audio support for the Synopsys DesignWare DisplayPort
controller.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1690,6 +1721,254 @@ static int dw_dp_link_enable(struct dw_dp *dp)

[ ... ]

> +static int dw_dp_audio_prepare(struct drm_bridge *bridge,
> +			       struct drm_connector *connector,
> +			       struct hdmi_codec_daifmt *daifmt,
> +			       struct hdmi_codec_params *params)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +	u8 supported_audio_interfaces;
> +	enum dw_dp_audio_interface audio_interface;
> +	u32 cfg1;
> +	int ret;

[ ... ]

> +	switch (daifmt->fmt) {
> +	case HDMI_SPDIF:
> +		audio_interface =3D DW_DP_AUDIO_SPDIF;
> +		break;
> +	case HDMI_I2S:
> +		/*
> +		 * It is recommended to use SPDIF instead of I2S, since I2S mode requi=
res
> +		 * manually inserting PCUV control bits from userspace and this is done
> +		 * automatically in hardware for SPDIF mode.
> +		 */
> +		audio_interface =3D DW_DP_AUDIO_I2S;
> +		break;
> +	default:
> +		dev_err(dp->dev, "invalid DAI format %d\n", daifmt->fmt);
> +		return -EINVAL;
> +	}
> +
> +	regmap_read(dp->regmap, DW_DP_CONFIG_REG1, &cfg1);
> +	supported_audio_interfaces =3D FIELD_GET(AUDIO_SELECT, cfg1);

[Severity: Medium]
Is it possible for regmap_read() to fail here? If the read operation fails,
cfg1 would remain uninitialized, causing FIELD_GET() to operate on
uninitialized stack memory.=20

Should the return value of regmap_read() be checked before accessing cfg1?

> +
> +	if (supported_audio_interfaces !=3D DW_DP_AUDIO_I2S_AND_SPDIF &&
> +	    supported_audio_interfaces !=3D audio_interface) {
> +		dev_err(dp->dev, "unsupported DAI %d\n", daifmt->fmt);
> +		return -EINVAL;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-synopsys-d=
w-dp-improvements-v9-0-2e6e46135312@collabora.com?part=3D22
