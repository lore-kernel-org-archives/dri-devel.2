Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72801CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D2F10E28C;
	Thu,  7 May 2026 13:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vCCRWOyA";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB5310E28C
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:15:44 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1400A9CE;
 Thu,  7 May 2026 15:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778159738;
 bh=+uSz2CvqI6QodBN7KGNT3VsASm33XInFFTQY4uOydhA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vCCRWOyAtDNbSBzKIWXupOvdI4SwYVP5TIGXS30lwmLvsYJUbRRQKE/QMh9BZmg4g
 Z9yf3Bk1PRfWBKX8iLnQ2Fet+AGWWE60e4NugtrW/bcA1RiU0ZMRmvaIpaCZuvjwfL
 UITqqqRL/eWuBDG+4EeBnSTHgnwl4QGE3iVexuqI=
Message-ID: <e7762253-fbc3-455a-b197-fe040a3cf443@ideasonboard.com>
Date: Thu, 7 May 2026 16:15:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add entry for Toshiba TC358768/TC358778 DRM
 bridge
To: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507131407.77711-1-francesco@dolcini.it>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260507131407.77711-1-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 07/05/2026 16:14, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add a MAINTAINERS entry for the Toshiba TC358768/TC358778
> parallel RGB to MIPI-DSI bridge DRM driver and associated DT
> bindings.
> 
> The driver has active users and ongoing maintenance activity.
> I have been working on the driver for some time and have access
> to the Toshiba hardware documentation as well as hardware using
> the bridge in different display configurations, including setups
> using LT8912B and TI DSI bridge devices.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c61ef65d71ef..73a6b240ff78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8465,6 +8465,12 @@ R:	Douglas Anderson <dianders@chromium.org>
>   F:	Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
>   F:	drivers/gpu/drm/bridge/ti-sn65dsi86.c
>   
> +DRM DRIVER FOR TOSHIBA TC358768/TC358778 PARALLEL RGB TO MIPI-DSI BRIDGE
> +M:	Francesco Dolcini <francesco@dolcini.it>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> +F:	drivers/gpu/drm/bridge/tc358768.c
> +
>   DRM DRIVER FOR TPO TPG110 PANELS
>   M:	Linus Walleij <linusw@kernel.org>
>   S:	Maintained

Acked-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi


