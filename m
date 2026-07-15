Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F6FC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5F110F0B6;
	Wed, 15 Jul 2026 13:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VPdLxTH5";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB22410F0B6
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:52:26 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so38253645e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784123545; x=1784728345; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cFc6BYKbaluOQu4ZnvTHH8qWRxDnvzT3hjS9iA2O0vE=;
 b=VPdLxTH5t6tP49LGeFbWdJKXd+uP3gn/oLjdHZLdfzCqinjXLLe2cn7/k5w0DSWrm/
 NfOEDcN+qGbVqKJBmkpEjHNlB4XmspLJ3FGQ1GS2+5Btt1EB8ri2s/Tg1pdAHfZxhRO/
 G0CImAfanQe6INC9Llexwo+szm0fpCIpmmR/gmAnIRiePHS61v7vvXOk3+yRgtxjc/t2
 OCKNigaNPqZVnrExCNSv1MtYJJOFALuW5qOfFZxVi1EAcJ848DuAM7cloCiRWnZgevc1
 ag7BWczUOQFx5mxj5cxjjciW0dUhY4E2F+PYDT/n7OZ+QYRPrBlnyzgpVNNHLyXYjoUj
 a1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784123545; x=1784728345;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cFc6BYKbaluOQu4ZnvTHH8qWRxDnvzT3hjS9iA2O0vE=;
 b=WGYTz+YidGGIx+2z+CoT7OppSqhY9rGSOCPhSmMnDKNpxM5TnxZtsK24R7ahJPTdsZ
 Ak+kiFsFKkL94dh7xENeO7jW19IjsCj/SYCUHQmG1NzTNXDBrJpTYgExNm/6CNm1gVt8
 AvloaMBpjMSvfoa5qxNV+A9NvxjFu8t4t+1MHcfaPWZ71vwO0/OI+MaZaAGzAPcYiHEd
 vtRWy7ikZN8or0A+Dbn47zLpgmp+w/fC+VdoTzlETV7ZJrepbWFx1aJtWD0iyvBGXj1f
 obbksSqbxi5iwMu6jpBJDhH6Z+ctNqaDVn5e7kcs33i+S07fotZsSylEhVhZeeE5P3c3
 OP3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz+l0O+gUZBF7Di3UowLLWQfvhFaCfBIS3wXCGwbCO0R9bWPbcN70SB3sBv+H01XGvaKRX+1+HBP8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS0JwYoVOGErkscuz4EJSrgQKphVVKf+6DyMwsIaBKAvRz6tKl
 Fd9m+fLtMWXTwsL/eKYEifsbi229taLEnEcj3eCPC67TPuJHqfIQ9ND8
X-Gm-Gg: AfdE7clLfe10JYXaweZ6SuWLtlybCEAhgVwcyLP3ZdTsXETdBWSPbgeazlpXzZEqY2X
 +wF3Ab/UY4nPLdvSFc/PdzphP+7hA21E6VrDQKWHJRGI96rDZWBjqDMMMaUAhOP8tSXYZf+tYkX
 WL9CLoW8AtBLmbZYQj9IyY0WxAUzKFMizfHwn+Ju6IL31wK4knhkdOhVZ2zVuLuWbzfiYYJbaOB
 rJ/ZKmAyHpcoYxc3oG+mh5gIp74fx9DXiHyUezeRXUCKUlmHKbRoq29m6bN6s3V+yEUq2XEMaIj
 C8TVKcA0li/S6OGLBShpp097tAyGBdhrNvJTvvmPUdkBhu+ME1TqXqpHsce7gYWjnJuzi7dtrtI
 84D2hIF+OQ3agpOThiu8dXSQmvMxWR1mFamZMj/j5jjtFFsVtGz15284UlU6D6KwXk8JQK4zIEs
 YE6zElqouD
X-Received: by 2002:a05:600c:58ca:b0:493:bd71:6084 with SMTP id
 5b1f17b1804b1-4953c28b124mr27811355e9.31.1784123544549; 
 Wed, 15 Jul 2026 06:52:24 -0700 (PDT)
Received: from owl5 ([2001:861:3201:3d10:e682:163f:4878:db7e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c6fe0c6sm52050755e9.1.2026.07.15.06.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:52:24 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:52:22 +0200
From: Gary Bisson <bisson.gary@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Esben Haabendal <esben@geanix.com>, frieder.schrempf@kontron.de
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with premature
 PLL locking
Message-ID: <aleQlpx73a5R8QgR@owl5>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com>
 <178410553814.253594.6153852459811911516.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178410553814.253594.6153852459811911516.b4-review@b4>
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

Hi Esben and Luca,

On Wed, Jul 15, 2026 at 10:52:18AM +0200, Luca Ceresoli wrote:
> On Sat, 11 Jul 2026 13:51:15 +0200, Esben Haabendal <esben@geanix.com> wrote:
> 
> Hi Esben,
> 
> +Cc Gary
> 
> > [...]
> > 
> > This is the same issue as addressed in the patch by Gary Bisson [1],
> > but changing the ti-sn65dsi83 driver instead, so we don't have to change
> > all other drivers that could potentially be used with this chip.
> > 
> > [1] https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com/
> 
> AFAICU your patch would replace Gary's one. Also Gary's patch has been
> reported to introduce regressions but it hasn't been reverted yet. Can you
> reply to that thread mentioning your patch, so everybody in the discussion
> is aware of your alternative proposal?

Thanks for including me. I just tested this change and reverted my other
one (mtk_dsi) and confirm that it works on my Tungsten510 + SN65DSI83 +
tm070jdhg30 panel.

Tested-by: Gary Bisson <bisson.gary@gmail.com>

Note that the sn65dsi83 driver wasn't changed as I thought the PLL lock
in pre-enable was on purpose. It was introduced by Frieder with this
commit. Adding him to the thread to weigh in.
dd9e329af723 drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec

Regards,
Gary
