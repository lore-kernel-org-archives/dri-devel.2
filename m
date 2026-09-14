Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8064CC88E66
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B8410EE15;
	Mon, 14 Sep 2026 12:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="APFa41OP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A332D10EE15
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:16:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6D9160142;
 Mon, 14 Sep 2026 12:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528941F000FF;
 Mon, 14 Sep 2026 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789388165;
 bh=G9j8P16ohM1dtXdGttVWFduSxmI/IRnk9KK7+T7DMvM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=APFa41OPauSGU1+OyFwp4i9Ti0M3TdOiJ2Owl69DwPA2TEXR3SC00KJs1lkL4yAiP
 yppwx8iyM7bqIe5LNcsm/x2R7wwLMUKruEmwOx5JsemcJOHwMEvvDZDT/nftjkEX+1
 RE3jQ0zBYWqA+USn3vdiKT+qfXXKNqz7xCwChQ3V2uZP2k72tTUg1eXetey03OIChY
 M1G5e1BEmVxez6fY6kDH8cB0438mGo2BXaapMEbUbPbfvSUw9JSEqrD6GuBlt7rNSh
 mXt39isQhkCAYwZ0x9hPVvmMhRH1o9gx6gQ1Lt/y5+baqrotgBNcbtSNRVK7RXVsgG
 jYTNW5Boy99Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/13] drm/mediatek: mtk_dsi: Move max link rate
 parameter to platform data
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260914115812.22751-8-angelogioacchino.delregno@collabora.com>
References: <20260914115812.22751-1-angelogioacchino.delregno@collabora.com>
 <20260914115812.22751-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:16:04 +0000
Message-Id: <20260914121605.528941F000FF@smtp.kernel.org>
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
- [High] mtk_dsi_bridge_atomic_pre_enable ignores mtk_dsi_poweron failure a=
nd accesses registers without clocks.
--

commit 5b6418994a183b2b2cc5727632b7cacb276f50a5
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Move max link rate parameter to platform data

This commit moves the max link rate configuration to SoC-specific platform
data to support newer MediaTek IPs capable of up to 2.5Gbps. It also updates
the data rate calculation to prevent integer overflows at higher clocks.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index fa0f404bc7add..6e92e4e1586f7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -921,7 +923,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  	}
>  	bit_per_pixel =3D ret;
> =20
> -	dsi->data_rate =3D DIV_ROUND_UP_ULL(dsi->vm.pixelclock * bit_per_pixel,
> +	dsi->data_rate =3D DIV_ROUND_UP_ULL((u64)dsi->vm.pixelclock * bit_per_p=
ixel,
>  					  dsi->lanes);
> =20
>  	ret =3D clk_set_rate(dsi->hs_clk, dsi->data_rate);

[Severity: High]
This is a pre-existing issue, but does mtk_dsi_bridge_atomic_pre_enable()
safely handle failures from mtk_dsi_poweron()?

If mtk_dsi_poweron() fails (for example, if clk_set_rate() fails here, or if
phy_power_on() fails later), it rolls back the clock state and returns a
negative error.

However, the caller in drivers/gpu/drm/mediatek/mtk_dsi.c:

mtk_dsi_bridge_atomic_pre_enable() {
    ...
    ret =3D mtk_dsi_poweron(dsi);
    if (ret < 0)
        drm_err(drm, "failed to power on dsi\n");

    mtk_dsi_lane_ready(dsi);
    ...
}

logs the error but continues execution instead of returning early. It then
immediately calls mtk_dsi_lane_ready(), which attempts to access DSI hardwa=
re
registers (such as DSI_TXRX_CTRL) while the DSI clocks are disabled.

Could this trigger an AXI bus timeout and cause a hard system hang when the
unclocked register access occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914115812.2275=
1-1-angelogioacchino.delregno@collabora.com?part=3D7
