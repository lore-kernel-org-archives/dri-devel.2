Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95A7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A71C10E1A7;
	Wed,  1 Jul 2026 13:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eZnYE8sT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A8E10E1A7
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 13:34:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B49C44200C;
 Wed,  1 Jul 2026 13:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD141F00A3D;
 Wed,  1 Jul 2026 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782912888;
 bh=7To4ya9/g9neZVkq+m0HqlDhXDRtWb5y20bO5sjaOGM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eZnYE8sT8icwLOXyHkThYcRgdVfVrE0oJX1rQpZ3ZJFUFLiDk9YgWpYR84XXeiZli
 yHLx+u9Vkw08T8XARHyUzFQFpwxYF3pmbULt7eC14GLn/fsuXemPEbxvc/+5xcIpzQ
 2CU4YurG6/wikkwpbK3zi5yFoY3UewVOK/b7N0tAgpUHCn4oDxnG2VJGy/5WM28554
 sA/7n2jDKN5w+Fy4mcS+bzUgB3I1JGZ4yuZBGHWSADwF+xBMsFs/UQqyW8tlz0IzoG
 fPNz0jMkSgiKH7tYtf+B9/AaBpiy0ntzT26Gn/rshj0m7BDVtJ4ErtBuoudxHpb+Iy
 jqgNEbovg/Kkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] drm/mediatek: mtk_dp: Move max link rate to SoC
 specific data
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260701122024.19557-9-angelogioacchino.delregno@collabora.com>
References: <20260701122024.19557-1-angelogioacchino.delregno@collabora.com>
 <20260701122024.19557-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:34:47 +0000
Message-Id: <20260701133448.5FD141F00A3D@smtp.kernel.org>
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
- [High] mode_valid and atomic_get_input_bus_fmts validate display modes ag=
ainst an unbounded, stale, or uninitialized link rate, bypassing Device Tre=
e limits and DPCD capabilities.
--

commit 4683d3daece6ab3ba3c7c82ebff7364e878794fb
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date:   Wed Jul 1 12:20:21 2026 +0000

drm/mediatek: mtk_dp: Move max link rate to SoC specific data

This patch moves the maximum link rate to the SoC specific data structure
instead of statically assigning it to DP_LINK_BW_5_4 during initialization.
This prepares the driver for the MT8196 SoC which supports higher link rate=
s.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index bf3a4b15f3ec0..5272e717bfda0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[ ... ]
> @@ -1481,7 +1482,7 @@ static void mtk_dp_initialize_priv_data(struct mtk_=
dp *mtk_dp)
>  {
>  	bool plugged_in =3D (mtk_dp->bridge.type =3D=3D DRM_MODE_CONNECTOR_eDP);
> =20
> -	mtk_dp->train_info.link_rate =3D DP_LINK_BW_5_4;
> +	mtk_dp->train_info.link_rate =3D mtk_dp->data->hw_max_link_rate;

[Severity: High]
This isn't a bug introduced by this patch, but does setting the link rate
here cause mode validation to falsely accept unsupported high-bandwidth mod=
es?

Looking at mtk_dp_bridge_mode_valid() in drivers/gpu/drm/mediatek/mtk_dp.c,
it calculates available bandwidth using the unnegotiated train_info.link_ra=
te:

	u32 rate =3D drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate) *
		   lane_count_min;

A similar calculation occurs in mtk_dp_bridge_atomic_get_input_bus_fmts().

Since train_info.link_rate is initialized here to the SoC's absolute maximum
(and previously statically to DP_LINK_BW_5_4), it bypasses the board-specif=
ic
Device Tree constraint mtk_dp->max_linkrate and the sink capabilities in rx=
_cap.

When the mode is actually committed, mtk_dp_training() properly limits the
link rate to mtk_dp->max_linkrate and trains at a lower bandwidth. Won't th=
is
leave the hardware unable to sustain the falsely validated high-bandwidth
display mode, resulting in a blank screen or corrupted output due to bandwi=
dth
exhaustion?

Because this patch will introduce even higher initial values for future SoCs
like MT8196, will this cause a wider range of unsupported modes to be false=
ly
validated?

>  	mtk_dp->train_info.lane_count =3D mtk_dp->max_lanes;
>  	mtk_dp->train_info.cable_plugged_in =3D plugged_in;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122024.1955=
7-1-angelogioacchino.delregno@collabora.com?part=3D8
