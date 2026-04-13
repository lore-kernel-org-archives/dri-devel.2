Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F270F34C64
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F92D10E4CB;
	Mon, 13 Apr 2026 16:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xEz+sPue";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A253610E4CC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 16:07:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6ABD01A31EA;
 Mon, 13 Apr 2026 16:07:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 353CB5FFB9;
 Mon, 13 Apr 2026 16:07:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 962D010450093; 
 Mon, 13 Apr 2026 18:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776096474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=asF0HsGt6RiO9yJ1UjElEHlRXE65Jp9uDD1NhjSotBQ=;
 b=xEz+sPue9JfPASrlINjN6Vr2FuCOoJ4drkDjQUVkWM4UGLZJ4t04mMr1FqI4DQJpLQ7V2K
 w2H3nJx11sTROYwbl0RIHa3yS/nSXAtdbqCDyJ+Qc/wXHY8LC5HvUPgHlFXcq1mggXBfYh
 NWbNQ2Q8vCyNf3lsUs/FMDj+DazLtD83hLkoQgvXaAlRSZ3CpvjfoBQSqIgVCk7GQFsJnx
 d4PJzRN1joJyAyOkBvNJB9vrX49Uh3v9cFGnvsEwAhI8lxYdbaPvpN0PvVCHt90ZeGBEpn
 tTGhli/qd0TFjPFx5kO23T5kFP1jJ8yiWTk+z/P5757N8IyE+jGudyoZ1p+rWg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 18:07:46 +0200
Message-Id: <DHS5NGSKY3ZE.2NWYPEL21N27Z@bootlin.com>
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <alim.akhtar@samsung.com>,
 <dmitry.baryshkov@oss.qualcomm.com>, <nicolas.frattaroli@collabora.com>,
 <dianders@chromium.org>, <m.szyprowski@samsung.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
To: "Damon Ding" <damon.ding@rock-chips.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <inki.dae@samsung.com>, <sw0312.kim@samsung.com>,
 <kyungmin.park@samsung.com>, <krzk@kernel.org>, <jingoohan1@gmail.com>,
 <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v14 3/8] drm/bridge: analogix_dp: Add new API
 analogix_dp_finish_probe()
X-Mailer: aerc 0.20.1
References: <20260413132551.1049307-1-damon.ding@rock-chips.com>
 <20260413132551.1049307-4-damon.ding@rock-chips.com>
In-Reply-To: <20260413132551.1049307-4-damon.ding@rock-chips.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Damon,

On Mon Apr 13, 2026 at 3:25 PM CEST, Damon Ding wrote:
> Since the panel/bridge should logically be positioned behind the
> Analogix bridge in the display pipeline, it makes sense to handle
> the panel/bridge parsing on the Analogix side. Therefore, we add
> a new API analogix_dp_finish_probe(), which combines the panel/bridge
> parsing with component addition, to do it.
>
> In order to process component binding right after the probe completes,
> the &analogix_dp_plat_data.ops is newly added to pass &component_ops,
> for which the &dp_aux_ep_device_with_data.done_probing() of DP AUX bus
> only supports passing &drm_dp_aux.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de> # rk3588
>
> ---
>
> Changes in v4:
> - Rename the &analogix_dp_plat_data.bridge to
>   &analogix_dp_plat_data.next_bridge.
> - Remame API analogix_dp_find_panel_or_bridge() to
>   analogix_dp_finish_probe().
>
> Changes in v5:
> - Select DRM_DISPLAY_DP_AUX_BUS for DRM_ANALOGIX_DP.
>
> Changes in v9:
> - Add Tested-by tag.
>
> Changes in v10:
> - Fix to use dev_err_probe() in analogix_dp_finish_probe().
> - Expand the commit message.
>
> Changes in v13:
> - Modify '(on rk3588)' to '# rk3588' for Tested-by tag.
> ---
>  drivers/gpu/drm/bridge/analogix/Kconfig       |  1 +
>  .../drm/bridge/analogix/analogix_dp_core.c    | 46 +++++++++++++++++++
>  include/drm/bridge/analogix_dp.h              |  2 +
>  3 files changed, 49 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/br=
idge/analogix/Kconfig
> index 03dc7ffe824a..8a6136cd675f 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -29,6 +29,7 @@ config DRM_ANALOGIX_ANX78XX
>  config DRM_ANALOGIX_DP
>  	tristate
>  	depends on DRM
> +	select DRM_DISPLAY_DP_AUX_BUS

While applying, sparse noticed an issue here: DRM_DISPLAY_DP_AUX_BUS
depends on OF, so you need to propagate the 'depends on OF' to
DRM_ANALOGIX_DP and its reverse dependencies.

I fixed it while applying the patch.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
