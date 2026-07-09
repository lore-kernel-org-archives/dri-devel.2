Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C151C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B95F10ECD3;
	Thu,  9 Jul 2026 10:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R/jW8wrv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982B310EB69
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:47:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB63C6001A;
 Thu,  9 Jul 2026 10:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5487A1F000E9;
 Thu,  9 Jul 2026 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783594062;
 bh=4gdq3iURDqADJ4o8X5+XR8dL0ApUrHFEcU005U5spLs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R/jW8wrvbcHxepcTKDfgBf71Ly3r6TA7FwXslwahauBebguCw27YR4JKqekCtg3kN
 C7tJQqTm9AF7I0UE4LwFJchDWYX22TVOJ7a9lJkY2w+9FCfBLq0IboqsQp7g0P82+A
 WfxoWyhOsL8eY92upSR5Wn4MkYh1K9YS1WKLXyZgR5y8EbHy163QJDUEyU4MK2VaVW
 zZiyleoOkpZpPX2JPu6aMR+DiGsRFCFVbMbu9rqOqxPnPIYRTZoOC0VmsVkz+mnJIX
 hlLK3cYNBslhzkS1czyh50asSFxCoSpJakVORZwxXgezTCjdzaUxqYlVj2p6RfL1FT
 Q+/XjvvtJY9Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/11] drm/mediatek: mtk_dp: Move max link rate to
 SoC specific data
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260709103431.46616-9-angelogioacchino.delregno@collabora.com>
References: <20260709103431.46616-1-angelogioacchino.delregno@collabora.com>
 <20260709103431.46616-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:47:41 +0000
Message-Id: <20260709104742.5487A1F000E9@smtp.kernel.org>
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
- [High] mtk_dp_bridge_mode_valid() uses the SoC's absolute maximum link ra=
te for mode validation instead of the negotiated limit, leading to unsuppor=
table display modes being accepted.
--

--- Patch [8]: [PATCH v3 08/11] drm/mediatek: mtk_dp: Move max link rate to=
 SoC specific data ---
commit 47b5711a6d2bc56c41f2725702c27dbf19ea9ba4
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
drm/mediatek: mtk_dp: Move max link rate to SoC specific data

This patch moves the maximum link rate to SoC specific data instead of
statically assigning it. This is in preparation for adding support for the
MT8196 eDP IP which supports a higher maximum link rate.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index cabfc833c0a80..ea90462b26f5e 100644
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
This is a pre-existing issue, but does setting mtk_dp->train_info.link_rate
to the SoC's absolute maximum bypass the board-level and sink limits during
mode validation?

In mtk_dp_bridge_mode_valid(), the available bandwidth is calculated using
the unbounded mtk_dp->train_info.link_rate:

	u32 rate =3D drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate) *
		   lane_count_min;

Since mtk_dp_parse_capabilities() parses the sink's DPCD capabilities into
rx_cap but doesn't update train_info.link_rate, this bandwidth calculation
appears to ignore both the board-level limit (mtk_dp->max_linkrate) and the
sink's negotiated limit (rx_cap).

Because the actual link training will cap the rate to the limits, could this
cause mtk_dp_bridge_mode_valid() to erroneously accept unsupportable
high-bandwidth modes, resulting in display corruption or black screens when
those modes are sent over a lower-bandwidth trained link?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709103431.4661=
6-1-angelogioacchino.delregno@collabora.com?part=3D8
