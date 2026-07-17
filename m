Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC976C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C98910F60E;
	Fri, 17 Jul 2026 20:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="z6oinNha";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED2810F60E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4243B1A107C;
 Fri, 17 Jul 2026 20:49:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 15CF360361;
 Fri, 17 Jul 2026 20:49:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 49FDA11BD2971; 
 Fri, 17 Jul 2026 22:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784321372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=o7g2fJc3HMuRMT/iCHkvyuJm2ZERTu4LDRDeSdiJrbM=;
 b=z6oinNhatF1j3Re6mPnKXa03lU/U4qDL7zHSb6k6ODd/d9flw3DHU3Ht5g4/ggiqj8/5wg
 VZHFUyXkuQyvctuQozRu2r3q2gZq1tZicK5AdvxD/r/L2/Ejv2FX4BXiCW++Ic9CMgZgX4
 NItu2GwM+LEvKSKkf9gZGyqrGc7u2GEXiIiNxmmt9xhmdAoWqwRyKgrZFnDZcxhpMSj4gn
 Su8fT/Q8L2JpZPGPGCr2GV41w9YsxAlCVfuHD+PJhh394eklvTl1RTMMMs/FzUH859l/Yp
 BAn9HYPY51UupxnpC12hWZpjjRZ9VJk+IQW4A/entLl3XJxBue28se0t+sftyQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/3] drm/bridge: ti-sn65dsi83: Add reversed lvds
 lanes support
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Wojciech Dubowik <wojciech.dubowik@mt.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20260717115002.308035-4-wojciech.dubowik@mt.com>
References: <20260717115002.308035-1-wojciech.dubowik@mt.com>
 <20260717115002.308035-4-wojciech.dubowik@mt.com>
Date: Fri, 17 Jul 2026 22:49:19 +0200
Message-Id: <178432135989.269908.12890193389587995172.b4-review@b4>
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

On Fri, 17 Jul 2026 13:50:01 +0200, Wojciech Dubowik <wojciech.dubowik@mt.com> wrote:

Hello,

>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index f8a786953526..df44df2e872a 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -845,6 +863,19 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
>  	else
>  		return -EINVAL;
>  
> +	ret_data = of_property_read_u32_array(endpoint, "data-lanes", data_lanes,
> +			ARRAY_SIZE(data_lanes));
> +	if (!ret_data) {
> +		if (memcmp(data_lanes,
> +				supported_data_lane_mapping[LANE_MAPPING_REVERSE],
> +				ARRAY_SIZE(data_lanes)) == 0)

Did you have a look at this sashiko report? It seems valid:
 | sashiko-bot@kernel.org <sashiko-bot@kernel.org>:
 |
 | [Severity: Medium]
 | Does this code compare the entire array? memcmp() expects the length in
 | bytes, but ARRAY_SIZE(data_lanes) evaluates to 4 (the number of elements).
 |
 | Because data_lanes is an array of u32, checking only 4 bytes means only
 | the first element is compared. Should this be using sizeof(data_lanes)
 | instead?
 |
 | via: https://patch.msgid.link/20260717115630.C58A61F000E9@smtp.kernel.org

> +			ctx->lvds_reverse_lanes_conf[channel] = true;
> +		else if (memcmp(data_lanes,
> +			   supported_data_lane_mapping[LANE_MAPPING_NORMAL],
> +			   ARRAY_SIZE(data_lanes)) != 0)

Same here.

Otherwise looks good.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

