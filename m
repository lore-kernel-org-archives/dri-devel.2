Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F45F4644F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB8B10E3E6;
	Mon, 16 Mar 2026 11:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="FPZG0d9U";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042F110E3E6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773659687; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UIej3PgOTkE/n0d+iLhvO9KUEiB24mLjI5T3L8rccNLAyjrayVNy8Aw0GeSTmgMPA68EXjupr5mrY8JaIsmw27IaWeATHFfYPAFqIrCh+nM3maDlIYuf8fIQ06Y/Vkp9l8E5WIfTUs3OU16oTagb2sSEhfrcm/esDoQertxM7Io=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773659687;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XlhrKy1qO5Y7JTYOOoPiFnrf+Gaw2TCJw74PIWbx0L8=; 
 b=GHJL5UhzMhaI4sJ/M2v+eF4cfdijD4SFjKwqah2FRjP9h/z1zw2QMf9fj98FRyyGfo3LH8PCo1xWQF8j2EeKQ0LopTyqkGzgSvdHumi+9YnmRzB5LQeaczuGyYgmdJY/3gCNT68jyY6In18UbnM7WRUY7rUMGkP+ZShY2bE1rgU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773659687; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=XlhrKy1qO5Y7JTYOOoPiFnrf+Gaw2TCJw74PIWbx0L8=;
 b=FPZG0d9UCoj7VXzxtKmvxxFQxaF9k8mtZY+xQj9wmcNo5ZR3YeOZ0v/MSQDEG4e/
 uo+DFdjh4U8fl2V0BoI81dK5Xu0NTrMpgb8RMITuxhj8KJz8j88FHgNWCMwF0qOxFfQ
 9yuJEN5GQKJ2HcVlyUA0Yk+HsIxrGRCSHTTnxhhU=
Received: by mx.zohomail.com with SMTPS id 177365968484917.368603781984916;
 Mon, 16 Mar 2026 04:14:44 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, alchark@gmail.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 kever.yang@rock-chips.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v1 3/4] drm/bridge: analogix_dp: Add support for RK3576
Date: Mon, 16 Mar 2026 12:14:37 +0100
Message-ID: <2032185.PYKUYFuaPT@workhorse>
In-Reply-To: <20260310105307.309765-4-damon.ding@rock-chips.com>
References: <20260310105307.309765-1-damon.ding@rock-chips.com>
 <20260310105307.309765-4-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, 10 March 2026 11:53:06 Central European Standard Time Damon Ding wrote:
> Expand enum analogix_dp_devtype with RK3576_EDP, and add max_link_rate
> and max_lane_count configs for it.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
>  include/drm/bridge/analogix_dp.h                   | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index fe7158d9edde..c4e49e8186ab 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1248,6 +1248,7 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
>  		video_info->max_link_rate = 0x0A;
>  		video_info->max_lane_count = 0x04;
>  		break;
> +	case RK3576_EDP:
>  	case RK3588_EDP:
>  		video_info->max_link_rate = 0x14;
>  		video_info->max_lane_count = 0x04;
> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
> index 854af692229b..d1a6e6d44a2b 100644
> --- a/include/drm/bridge/analogix_dp.h
> +++ b/include/drm/bridge/analogix_dp.h
> @@ -16,12 +16,13 @@ enum analogix_dp_devtype {
>  	EXYNOS_DP,
>  	RK3288_DP,
>  	RK3399_EDP,
> +	RK3576_EDP,
>  	RK3588_EDP,
>  };
>  
>  static inline bool is_rockchip(enum analogix_dp_devtype type)
>  {
> -	return type == RK3288_DP || type == RK3399_EDP || type == RK3588_EDP;
> +	return type == RK3288_DP || type == RK3399_EDP || type == RK3576_EDP || type == RK3588_EDP;

I think we can make this easier to read with a switch statement. In
a separate patch, we may also want to rename `is_rockchip` to
`analogix_dp_is_rockchip`, as e.g. rockchip_drm_vop.c and exynos_dp.c
both include his header file as well.

Switch statement would make the function look something like:

static inline bool is_rockchip(enum analogix_dp_devtype type)
{
	switch (type) {
	case RK3288_DP:
	case RK3399_EDP:
	case RK3576_EDP:
	case RK3588_EDP:
		return true;
	default:
		return false;
	}
}

Kind regards,
Nicolas Frattaroli

>  }
>  
>  struct analogix_dp_plat_data {
> 




