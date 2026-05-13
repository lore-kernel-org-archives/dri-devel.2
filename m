Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC33DCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A74010E945;
	Wed, 13 May 2026 17:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Nb+SAPpT";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44AB10E33E
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:51:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 41CE210C60C; Wed, 13 May 2026 19:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778694688;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8MGutkJzH3tL1e7FoYMZxWfgfLXwJS9p0dK0UEKDi/8=;
 b=Nb+SAPpTCOZW6xpv3sumBScy+e9HNZiAou5XQ9QzWLpx9ZxwGWU5dEFEVMehg0CHDD/AhI
 U7YrADNnTHivEwoCN863aQEOhIeAA+VNk7IuWT2LhLN0eIJv+/hksE2rXQTguomln6yyAG
 9gAwgpUY3bOS+ogfdao0DSKra8c2oFqaioZ8UfHRzSK0zouWZyu9DCcnsnIwRa5QIwVRUV
 Mm3xNMZ/bl1mlBdKzNLzS+E0FBtUXKd/OA77i8q+p9ncuLB3CLKNdPjZ+3aNbHwN9g9fbL
 6dmiRWTgDmHBk8oVGHD4wL70eQHlFIiP/wvvvUMhTFqdH7RaLSf1rwcxKKCUFw==
Message-ID: <8bf05bf2-66a3-49e0-972e-4ab7ad9f0ff0@nabladev.com>
Date: Wed, 13 May 2026 15:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/bridge: lt9211: Add drive-strength-microamp DT
 property
To: Boerge Struempfel <bstruempfel@data-modul.com>,
 Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260513133127.376458-1-bstruempfel@data-modul.com>
 <20260513133127.376458-3-bstruempfel@data-modul.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260513133127.376458-3-bstruempfel@data-modul.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/13/26 3:31 PM, Boerge Struempfel wrote:

[...]

> @@ -666,6 +675,26 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
>   
>   	ctx->panel_bridge = panel_bridge;
>   
> +	ctx->lvds_hsdrv_isel = 8; /* default: 25 uA */
> +	ret = of_property_read_u32(dev->of_node, "drive-strength-microamp",
> +				   &microamp);

if (ret && ret != -EINVAL) {
   ... error handling ...
   return ret;
}

Then you won't need the if (!ret) conditional and can reduce indent.

I also wonder whether it wouldn't be better to simply bail with 
dev_err_probe() if the property is invalid, let the user know they 
should fix their DTs before it is too late.

> +	if (!ret) {
> +		for (i = 0; i < ARRAY_SIZE(lt9211_hsdrv_microamp); i++) {
> +			if (lt9211_hsdrv_microamp[i] == microamp) {
> +				ctx->lvds_hsdrv_isel = i;
> +				break;
> +			}
> +		}
> +		if (i == ARRAY_SIZE(lt9211_hsdrv_microamp)) {
> +			dev_err(dev, "Invalid drive-strength-microamp value %u\n",
> +				microamp);
> +			return -EINVAL;
> +		}

[...]

> +
>   	return 0;
>   }
