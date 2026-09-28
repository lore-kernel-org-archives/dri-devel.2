Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE15CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02F410E165;
	Mon, 28 Sep 2026 22:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LOpdup5i";
	dkim-atps=neutral
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com
 [74.125.229.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB8E10E165
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 22:28:42 +0000 (UTC)
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b8d6489419so2938051e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790634521; x=1791239321;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JArXmWr/mVGoLLKcByjQ5+EXzcvGruMpOpTO8U+lXSI=;
 b=LOpdup5icX460garvm9iskaRu90ETKjvytSGpeGb0HU+TS4GHYKdBYQQAvDEhylw+w
 Nhgbd9iLzh0miVv0HI/v9M4iVLwLzPmxLGSq4r+RRamKox0nu+2u++qAns9lgpvRC5ph
 lRsHYpvCseB2rRjpD4iUV05mSUiDb7gTQcVFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634521; x=1791239321;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JArXmWr/mVGoLLKcByjQ5+EXzcvGruMpOpTO8U+lXSI=;
 b=0pXVflKvt/W6cjJEPJRC6gaDestRXz9SZ7D9ESY+GrropHNdWKnB5AytdgJe5xuYxz
 xhlFIOcT2/kN0O6SAI5465rFELfhcIFJcK9tQ/1zHsp5prVR25dWIFjxQAB+EOhW7kAJ
 VwGzcFdz7AZqsDUA0EbZjQugW4YxNCrww1m6hGo0YuuVGzeCgsmst7RqJreTdLKC7XSb
 JjFdt9swn+yuRBzHJDVeKEYutZ6uLjLy8h0eLO/cBfdFKZMeCubNJk0IUO0KCYGbtr+Z
 saVVxnDNpqbi1/7PiIsIGfgO5YZHQsJggtmUPCx8vxvznvUB+n9a0QB/7OXBTfR2fE81
 wfUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZjZbIR4gEzShBdtN/m5MfTXGV5suDk4j33QNQ+TYm5eidBo4fhek+Vg9pwkF2eR0vAp2dO1C6QgQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKCvD0FS+hQHZxwS+Ix42i0gbdQodSxhd4mfn0tjbmysDWMBu+G
 Nmn7vB8gY7XIVt/W2yVCJbhmqf9Xh3hAGHNHSTnE+7LxE0or6rRyQX0gCqQh3TObQwscAM47HOk
 MH0GBHw==
X-Gm-Gg: AYBFou1RJmo32CpA+VpuKqBg6zThXWebilzaZN9rCdk/cI/aW8rN+swdnNK+p8+VZK5
 bWAz2GsG3Z28SikyEc/rjisLGLOPeDkpBtn9oGJBNV8ogBAYihVNWO4OYNMAQNJOZ7pM9eqM/YT
 h/DibIhoMvr0NeeaSSAtn2+UbKZlM0hbUo/eXKYf4JrUZ5ny5qK8Bz1oDy9ReE70cQ7xULEZiZl
 pfx2hQu4cwU11YXQthOJwdtxNi6u+vG4hZM4Eo+vRRBoQgCfdUzRxt+QKzOovsTtOvKS2Gfj/5r
 qSMjw/t69ph70oDkkKxmG7fs0cttf0yqZQXn5c70a3voKMXqJC0xVdz1UZ0am4/Cc79wqk7XfZp
 7ruZz1Rtngfcr1Ayd0mNZLSQHAD5WqCBzxm+OSn327wT1x8H2WPgTzmdDm6WSHDblwjEmQwSL5H
 bcdt+wEmoRBTmXxUZEVIrQQzta9tMCoMjjDr7o7voP9w1BAsXSIOzAiYBPyrhJUrP1kSbNHgOYx
 8jP+RYaPoSEfngdgJ9jHdnPZpHtcqFZpupPTbg=
X-Received: by 2002:a05:6512:2383:b0:5b0:c95:cdb9 with SMTP id
 2adb3069b0e04-5b8df05a857mr5432488e87.23.1790634520787; 
 Mon, 28 Sep 2026 15:28:40 -0700 (PDT)
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com.
 [74.125.229.205]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9debbd2besm864944e87.58.2026.09.28.15.28.40
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 15:28:40 -0700 (PDT)
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b8cbb7b9cfso2840353e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 15:28:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzMCBtEnIwx5QyihF74YZwUDuSKl49Y9k5dq2Fv3n0N1htpWdjFAPdrHGapktQ0vQCcOxXZPT8rq4k=@lists.freedesktop.org
X-Received: by 2002:a05:600c:6986:b0:49c:fa21:e73c with SMTP id
 5b1f17b1804b1-49fe66f147bmr235241965e9.18.1790634033791; Mon, 28 Sep 2026
 15:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260928161605.2271412-1-arnd@kernel.org>
In-Reply-To: <20260928161605.2271412-1-arnd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Sep 2026 15:20:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzWmSjWZ96sBYvRLr=EbYqqBZ71o2BqotUsxRf5zqjTg@mail.gmail.com>
X-Gm-Features: AclHuK-sVszmxzKslRXTzUjiQ3wDqpSD15BZhQhdtvRJFSFfPWjQSieqaRkgVN0
Message-ID: <CAD=FV=UzWmSjWZ96sBYvRLr=EbYqqBZ71o2BqotUsxRf5zqjTg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: add missing drm/drm_panel.h inclusions
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Dharma Balasubiramani <dharma.b@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Liu Ying <victor.liu@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, dri-devel@lists.freedesktop.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 28, 2026 at 9:16=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The devm_drm_of_get_bridge() declaration moved to drm_panel.h, but
> not all callers include this, which leads to build failures in
> some configurations:
>
> drivers/gpu/drm/imx/lcdc/imx-lcdc.c: In function 'imx_lcdc_probe':
> drivers/gpu/drm/imx/lcdc/imx-lcdc.c:404:18: error: implicit declaration o=
f function 'devm_drm_of_get_bridge' [-Wimplicit-function-declaration]
>   404 |         bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 0, 0=
);
>       |                  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/verisilicon/vs_bridge.c: In function 'vs_bridge_init':
> drivers/gpu/drm/verisilicon/vs_bridge.c:306:16: error: implicit declarati=
on of function 'devm_drm_of_get_bridge' [-Wimplicit-function-declaration]
>   306 |         next =3D devm_drm_of_get_bridge(drm_dev->dev, drm_dev->de=
v->of_node,
>       |                ^~~~~~~~~~~~~~~~~~~~~~
>
> Include the new header in all files that need it.
>
> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[ ... ]

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index e7f9e6d58927..e50737432071 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -36,6 +36,7 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>
>  #include "drm_crtc_internal.h"

The above one might not be necessary. drm_bridge.c only references
devm_drm_of_get_bridge() in comments.

Other than that, this looks OK to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll assume Luca will apply the fix since he landed aa8a8c7e4641.

-Doug
