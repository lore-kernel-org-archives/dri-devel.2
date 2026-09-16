Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C6EC982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0371710EB6E;
	Wed, 16 Sep 2026 14:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="imxkUhaY";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9275D10EBB7
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:54:30 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E52A558;
 Wed, 16 Sep 2026 16:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1789570367;
 bh=hGC+EVI4Y0/YtilopqcCFxb7GcD2lK3DAQ+eE7bTOd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=imxkUhaYqBRwTsCLCU/fusfDyOLm0nkX1ecwfWqRGYk7yTmtrEiLFx5eYXQLurwKq
 r3b1Irx2RFqxAMPzlXgeTp9mHD22fwp+pk4qUYSoVKLDqaCQkhKM3bZDGVeUVjUMTU
 XHdjLRA5lbdXGn8Lr13Jmgczs3HOL3wPWzw835rU=
Date: Wed, 16 Sep 2026 17:54:27 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, andrzej.hajda@intel.com, architt@codeaurora.org,
 bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 eric@anholt.net, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de, stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: cdns-dsi: Fix runtime PM leak in
 cdns_dsi_bridge_atomic_pre_enable()
Message-ID: <20260916145427.GA40507@killaraus.ideasonboard.com>
References: <20260916100405.2012604-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916100405.2012604-1-vulab@iscas.ac.cn>
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

On Wed, Sep 16, 2026 at 10:04:05AM +0000, Wentao Liang wrote:
> cdns_dsi_bridge_atomic_pre_enable() resumes the DSI controller with
> pm_runtime_get_sync() and returns early with a WARN_ON() when the
> resume fails.  pm_runtime_get_sync() increments the runtime PM usage
> count even when it fails, so returning without dropping the reference
> leaks it and prevents the device from ever suspending again once the
> error has been hit.
> 
> Drop the runtime PM reference with pm_runtime_put_noidle() on the
> resume failure path before returning.
> 
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 0dd85e26248c..fca4528edfa6 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -733,8 +733,10 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  	 * enable their streams.
>  	 */
>  
> -	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
> +	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0)) {
> +		pm_runtime_put_noidle(dsi->base.dev);
>  		return;
> +	}

Anything wrong with pm_runtime_resume_and_get() ?

>  
>  	new_bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
>  	if (WARN_ON(!new_bridge_state))

-- 
Regards,

Laurent Pinchart
