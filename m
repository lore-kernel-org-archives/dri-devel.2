Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E400FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B4E10F56C;
	Thu,  9 Jul 2026 11:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QB+2oykV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F55F10F56B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:53:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9CA5F600C3;
 Thu,  9 Jul 2026 11:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024BE1F00A3D;
 Thu,  9 Jul 2026 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598008;
 bh=jGsQI0+o9gXc0IEdU270aPtgUVaILoqtrwT5UP1xmd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QB+2oykVPGiYN5sfBX2hZZHjyU6yIS/xXDzvNMM03HYXDNp6i7+dQgdN4PPlZtLs9
 qejLGEzICsxBwjDFMIeCScl4+vz+NLKwFhmZfrrfa4h884/wUT1YrTG78pkQmEEYlC
 BG+DM52MhhX6fCFnNn846ou1fkz+bBVi4Q63XsuzZifIbFYmJV9TMshdLQ0SEHdhVc
 gnXAMje1GM+lCjrA2iCVLuPpwkVA4Mc/p4gZ7H3Vn74W47AAdre+RG5gvMBL/cE23e
 YPleKLrlsC2TuI4jCM4e4FJhdQ16vIJW0voe67GwJ0X8hOQt+6YJBv/P6tg7OAj9mW
 DFjczvSSPDPjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/12] drm/mediatek: mtk_dp: Move max link rate to
 SoC specific data
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260709113148.49090-10-angelogioacchino.delregno@collabora.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:53:27 +0000
Message-Id: <20260709115328.024BE1F00A3D@smtp.kernel.org>
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
- [High] For eDP, mode validation and bus format negotiation incorrectly us=
e the SoC's hardware maximum link rate rather than considering the board's =
device tree limit and the sink's DPCD capabilities.
--

--- Patch [9]: [PATCH v4 09/12] drm/mediatek: mtk_dp: Move max link rate to=
 SoC specific data ---
commit 77698e671819e17e65d99b3fb9908f2be60bc613
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
drm/mediatek: mtk_dp: Move max link rate to SoC specific data

This commit moves the hardware maximum link rate from static initialization
to SoC-specific data to prepare for supporting MT8196 eDP IP which has a
higher maximum link rate.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index e2a6001fc0ccc..ea970a9bfe936 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[ ... ]
> @@ -1469,7 +1470,7 @@ static void mtk_dp_initialize_priv_data(struct mtk_=
dp *mtk_dp)
>  {
>  	bool plugged_in =3D (mtk_dp->bridge.type =3D=3D DRM_MODE_CONNECTOR_eDP);
> =20
> -	mtk_dp->train_info.link_rate =3D DP_LINK_BW_5_4;
> +	mtk_dp->train_info.link_rate =3D mtk_dp->data->hw_max_link_rate;

[Severity: High]
This isn't a bug introduced by this patch, but does this blind initializati=
on
cause mode validation to falsely accept unsupported high-bandwidth modes?

Because mtk_dp_bridge_mode_valid() and=20
mtk_dp_bridge_atomic_get_input_bus_fmts() are called before atomic_enable()=
=20
during mode enumeration, they evaluate available bandwidth using this=20
un-negotiated train_info.link_rate:

mtk_dp_bridge_mode_valid() {
        ...
        u32 rate =3D drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_ra=
te) *
                   lane_count_min;
        ...
}

For eDP connections, actual link training is deferred until=20
mtk_dp_bridge_atomic_enable(). Using the un-negotiated rate here ignores th=
e=20
board's device tree limit (max-linkrate-mhz) and the sink's DPCD capabiliti=
es.

Can this result in configuring a display mode that exceeds the actual link
bandwidth, leading to link training failures or black screens, and failing
to fall back to bandwidth-saving formats like YUV422?

>  	mtk_dp->train_info.lane_count =3D mtk_dp->max_lanes;
>  	mtk_dp->train_info.cable_plugged_in =3D plugged_in;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709113148.4909=
0-1-angelogioacchino.delregno@collabora.com?part=3D9
