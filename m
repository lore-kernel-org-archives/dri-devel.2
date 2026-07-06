Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4603C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8D010E39E;
	Mon,  6 Jul 2026 12:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATD5P8+n";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACB410E39E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:59:21 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so16576485e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783342760; x=1783947560; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z98nvf77VmSsopBykFntdijBwu2o8RPbMfIs/vHx0Vs=;
 b=ATD5P8+n3fb8kEiNXQ+OkAp2k/8xKMaBT6RHqTxDTL/irPFs4Gp0geAcJN7lYWB6xC
 coKyUr5h4ZWznCV8JJ+PghQWF2YuwXptNP+VrojjoUG9R3kssdkhQlNmqEhJlCmGlKlr
 Nu1IGje5D/Gkgfg67EhDZie8hm2fr5xxB8E1sG5LD2UxNHlz3Etek5Ddwitgy1/jWrqL
 t8z7moilyJTDgkr6j9ZFR9laxnW3XBW+33S5WYoDlbr9Wa0dIK6G7EnCVdRm+v0F3Ccj
 dePT4y5gMUhZNvCJKYIQDbF4ExnybA9SI0HUhHzVrA5l0Db/qE+jfhHDwOxIjCEib9yA
 E5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783342760; x=1783947560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z98nvf77VmSsopBykFntdijBwu2o8RPbMfIs/vHx0Vs=;
 b=eJkPhBehlVNOPTUUtLBOCkitzzdz7wSQb65HFZvbPKj3yAEfBHw7FaWVwFh5GoIA+i
 VHWTNJEoc3RrPTUO0Bga9RaRBgJIfH3XszPpmqgnW3ah+l99lN4ROJjx1TFRGhejcUMc
 Uh+qe+AjhqHJlT3114Hlt/0kn5MjnM5BDBsujWmb8HVVdip/d2Bpn5tCA61SwW5yZnl8
 CGWhFKiPRQwuGyT8FMRcu3nWvOFEXMo6/2ZPzuC7tsGCuKlbJephi9tVIvDw8UI+rgM3
 LX3ZhXl22jMsQImELdQ/9tjAej6lOqZCgiIs49S4dcAUotdfmVJBhcTJAC04B176343n
 7tOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLBoHjUAmRKvYLgbiZFGV/E59Zfsdh2LDcOLxumOhG9/4WKABgx/vBZRYuSkwhx9Y55NkQIPskhiI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLyAU4OUEd1SOj059bDZUjI8UdLnc9mBHlpmFSXe2E27nnAclz
 Au+287lMR+22oQfQig0fruOEiPcKXNkEKQ1bUaDvoMxWseG9DWuW0tiv
X-Gm-Gg: AfdE7cmmjSt5I04IVYoDlLAhKKuKLWGyTxjxpyqkuT92rremcji+w87pimjWXe/8q+m
 RmXHN/Ua/56STs5IcBARTt2pHoSIqbv8dEM/JF3ZaobxptSGNtDoPBXrUu9Ap1fv8qv1KuNY/+p
 zfmGp2ZT30DTVBg4OwvFoiMRZoEDMwOblyT+lxOD92jxSJzXF3d5BeDUtdJtOhj5DlxODRtZEPC
 k3LlW87034GTHyMrS0cIQqpyc3XjoM8VQzIpdFHf4HCnupG2sWrOlnDVzC73uGc3xje4C74uEUp
 wnZy+PQiwl+8d8nGmDdC360FIPUM1eD3dbWPveT9eOoV5RYi36y3lYj9dgVp2aU0w1Sw8Kzh91D
 pLRwvPmjI1LC5QoN+QwtUZ/Lsuklyowhc7ny3HxnPIGoWvd/Su5P7Fn4hlSPfhr2zfIRVcJRUG1
 PflZfqv6dtho42M6/pODCiRApaHaMl9aVgpmWMlQyPZLTVgA==
X-Received: by 2002:a05:600c:3e85:b0:493:b771:ddf9 with SMTP id
 5b1f17b1804b1-493df0413d1mr5456605e9.1.1783342759840; 
 Mon, 06 Jul 2026 05:59:19 -0700 (PDT)
Received: from osama ([2a02:908:1b8:2060:bfda:c630:e88a:7a7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccd9d620sm295986765e9.1.2026.07.06.05.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:59:19 -0700 (PDT)
Date: Mon, 6 Jul 2026 14:59:17 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: tc358762: use devm for bridge
 registration and DSI attach
Message-ID: <akumpZf2lTIbOZj4@osama>
References: <20260521215228.188615-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521215228.188615-1-osama.abdelkader@gmail.com>
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

On Thu, May 21, 2026 at 11:52:26PM +0200, Osama Abdelkader wrote:
> Replace manual drm_bridge_remove()/mipi_dsi_detach() in remove with
> devm_drm_bridge_add() and devm_mipi_dsi_attach() in probe. Also check
> the return value from bridge registration.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/bridge/tc358762.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 3d75d9cfa45e..3a021ca895f1 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -293,25 +293,17 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
>  	ctx->bridge.of_node = dev->of_node;
>  	ctx->bridge.pre_enable_prev_first = true;
>  
> -	drm_bridge_add(&ctx->bridge);
> +	ret = devm_drm_bridge_add(dev, &ctx->bridge);
> +	if (ret < 0)
> +		return ret;
>  
> -	ret = mipi_dsi_attach(dsi);
> -	if (ret < 0) {
> -		drm_bridge_remove(&ctx->bridge);
> +	ret = devm_mipi_dsi_attach(dev, dsi);
> +	if (ret < 0)
>  		dev_err(dev, "failed to attach dsi\n");
> -	}
>  
>  	return ret;
>  }
>  
> -static void tc358762_remove(struct mipi_dsi_device *dsi)
> -{
> -	struct tc358762 *ctx = mipi_dsi_get_drvdata(dsi);
> -
> -	mipi_dsi_detach(dsi);
> -	drm_bridge_remove(&ctx->bridge);
> -}
> -
>  static const struct of_device_id tc358762_of_match[] = {
>  	{ .compatible = "toshiba,tc358762" },
>  	{ }
> @@ -320,7 +312,6 @@ MODULE_DEVICE_TABLE(of, tc358762_of_match);
>  
>  static struct mipi_dsi_driver tc358762_driver = {
>  	.probe = tc358762_probe,
> -	.remove = tc358762_remove,
>  	.driver = {
>  		.name = "tc358762",
>  		.of_match_table = tc358762_of_match,
> -- 
> 2.43.0
> 

ping.
