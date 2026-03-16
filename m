Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C601F53D6E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A9F10E292;
	Mon, 16 Mar 2026 16:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bTDXH024";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D1910E292
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 16:33:57 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 53054BD2;
 Mon, 16 Mar 2026 17:32:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773678764;
 bh=ilztXb4L4lL5NjMNyaSUms4WUvTR31TNZ12rgzjdspE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bTDXH024qh/2g4362810lLVTQHlYxS4V47UR5/grd9GNmHVk+p4FLWsi9fQM/oCX2
 0PHlhrn87vpDT2Sz0D4FWhNqlqBa3/SM31dC7eU4vyW5yQm2aLwyGrls7Dgg2JCDr4
 r3vkl2/SsugkJQY0hbnThRaBNfEEpAXKu94bfZBo=
Date: Mon, 16 Mar 2026 18:33:54 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] drm/drv: Call drm_mode_config_create_state() by
 default
Message-ID: <20260316163354.GN31604@killaraus.ideasonboard.com>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-9-de7397c8e1cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-drm-mode-config-init-v1-9-de7397c8e1cf@kernel.org>
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

On Tue, Mar 10, 2026 at 05:07:01PM +0100, Maxime Ripard wrote:
> Almost all drivers, and our documented skeleton, call
> drm_mode_config_reset() prior to calling drm_dev_register() to
> initialize its DRM object states.
> 
> Now that we have drm_mode_config_create_state() to create that initial
> state if it doesn't exist, we can call it directly in
> drm_dev_register(). That way, we know that the initial atomic state will
> always be allocated without any boilerplate.

Should most drivers now stop calling drm_mode_config_reset() at probe
time ?

> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_drv.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 2915118436ce8a6640cfb0c59936031990727ed1..820106d56ab399a39cac56d98662b5ddbcae8ded 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -1097,10 +1097,14 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>  
>  	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
>  		ret = drm_modeset_register_all(dev);
>  		if (ret)
>  			goto err_unload;
> +
> +		ret = drm_mode_config_create_state(dev);
> +		if (ret)
> +			goto err_unload;
>  	}
>  	drm_panic_register(dev);
>  	drm_client_sysrq_register(dev);
>  
>  	DRM_INFO("Initialized %s %d.%d.%d for %s on minor %d\n",

-- 
Regards,

Laurent Pinchart
