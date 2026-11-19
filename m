Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768B606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=noqIS31b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FFE10E21D;
	Thu, 19 Nov 2026 09:42:39 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE6610E21D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:42:32 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C8E2CB1A;
 Thu, 19 Nov 2026 10:40:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795081202;
 bh=Z4P10Q9dDwFCnU5G7tymoEJ4B+zaoqvvG/N6ObBBhpA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=noqIS31bPuaP5hXgjwHj0EOCWfWdWnejv9t+T1pu5mUHu6QQHVyldkxYKovyS+Uro
 rvL6nzRXKLcDw8yZTzRV8KSk9WWszvq7sDm+GbdHOShO3IQoLYUKvqqIQ8XolsRe33
 zbF8zoKaYFsjO4Rhn7qvi+HdwENv7D8d090YIqhg=
Date: Thu, 19 Nov 2026 11:42:29 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>,
 Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] drm/bridge: analogix_dp: Hold runtime PM reference in
 bridge detect
Message-ID: <20261119094229.GQ1923307@killaraus.ideasonboard.com>
References: <CGME20261119092907eucas1p2d8c811bd49cf4369d5fc66d052abfcde@eucas1p2.samsung.com>
 <20261119092857.1158971-1-m.szyprowski@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119092857.1158971-1-m.szyprowski@samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 10:28:55AM +0100, Marek Szyprowski wrote:
> analogix_dp_bridge_detect() calls analogix_dp_detect_hpd() without
> holding a runtime PM reference on the DP device. If there is no HPD
> GPIO, analogix_dp_get_plug_in_status() reads ANALOGIX_DP_SYS_CTL_3 and,
> with "force-hpd", analogix_dp_force_hpd() also writes to it. When the
> display is disabled the controller is runtime suspended, so these are
> accesses to possibly unpowered IP block.
> 
> The connector created by drm_bridge_connector is polled because the
> bridge provides DRM_BRIDGE_OP_DETECT without DRM_BRIDGE_OP_HPD, and
> userspace may also query the connector state at any time, so this path
> is regularly executed with the device suspended. It affects only setups
> without a next bridge or panel (e.g. a DP connector), as otherwise
> detect returns early.
> 
> Take a runtime PM reference around the HPD check, the same way as
> analogix_dpaux_transfer() and analogix_dpaux_wait_hpd_asserted() do,
> and report the connector status as unknown if the device cannot be
> resumed.
> 
> Fixes: 2b77a2918c5d ("drm: bridge: analogix/dp: move hpd detect to connector detect function")
> Closes: https://sashiko.dev/#/bug/linux-ea09d64b-12cd-4301-bd54-12c515b01bde
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 84951413012b..9b7d770d1fa1 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -905,9 +905,15 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
>  	if (dp->plat_data->next_bridge)
>  		return connector_status_connected;
>  
> +	if (pm_runtime_resume_and_get(dp->dev) < 0)
> +		return connector_status_unknown;
> +
>  	if (!analogix_dp_detect_hpd(dp))
>  		status = connector_status_connected;
>  
> +	pm_runtime_mark_last_busy(dp->dev);
> +	pm_runtime_put_autosuspend(dp->dev);

pm_runtime_put_autosuspend() now includes the
pm_runtime_mark_last_busy(), see commit b3db492e8335 ("PM: runtime: Mark
last busy stamp in pm_runtime_put_autosuspend()")

> +
>  	return status;
>  }
>  

-- 
Regards,

Laurent Pinchart
