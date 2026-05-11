Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0792FCD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 14:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A93F10E7CC;
	Mon, 11 May 2026 14:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="qLb8dG5b";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881B810E7CC
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 14:47:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 139AB1A350A;
 Mon, 11 May 2026 14:47:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DBF5D60646;
 Mon, 11 May 2026 14:47:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DB40E11AF9E77; 
 Mon, 11 May 2026 16:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778510822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Py1bbHnCRadD3/j1O0zgWYKvT4J/oosNqxZ/MfLBykk=;
 b=qLb8dG5bX7MC+8tJuCpPj5Orkq9qBsuwsEBxYrDiQK2gpOWmYdkS6j1IWiyx8+Bycy0wOI
 lFh64hLcRYwf4lNe7XS5bzOSE1yl2FUe2lQdOIb59uIyh9Pw1Nhhpb87g6S4y5SE8XUeYj
 TAXbGr7rkgf7d1mU4D7Qf1Obhex9a7YEQ5asD6mfM6zhNtmCd4TzePmAD+OmaPDwQStCFP
 TJzOUMXF/lgyfudQW4NpTiYv+qj3yJkWfId2uirftca3jkaemH0nSLvIYeF1arR6ICIV9n
 VD4dF0XNqIF60VNGYtLp0Sxvkm1fDTEWPs1lo3POqvGD5E4MYefm371J5T6xRA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in dsi probe
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: luca.ceresoli@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260430194944.78119-2-osama.abdelkader@gmail.com>
References: <20260430194944.78119-1-osama.abdelkader@gmail.com>
 <20260430194944.78119-2-osama.abdelkader@gmail.com>
Date: Mon, 11 May 2026 16:46:43 +0200
Message-Id: <177851080327.59556.3186935759314114657.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Thu, 30 Apr 2026 21:49:43 +0200, Osama Abdelkader <osama.abdelkader@gmail.com> wrote:
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> index 553a1df4688d..b12cd2690474 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -767,10 +765,7 @@ static int chipone_i2c_probe(struct i2c_client *client)
>  
>  static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
>  {
> -	struct chipone *icn = mipi_dsi_get_drvdata(dsi);
> -
>  	mipi_dsi_detach(dsi);
> -	drm_bridge_remove(&icn->bridge);
>  }

A further improvement would be using devm_mipi_dsi_attach() so the entire
remove function can be dropped. If you want to to that, please do it as a
separate series, after this has been applied.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

