Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFEDC982D8
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0217810E18D;
	Sat, 19 Sep 2026 14:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.b="Gz2QS7On";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EF210E18D
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 14:25:38 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so10364575e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tuxon.dev; s=google; t=1789827937; x=1790432737; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7shCbBzL3NxDtg4fCdmbNM7nlS/zl4e99x1q/nsZ2so=;
 b=Gz2QS7OntKXwgPNaCPu+IbCzoyoELg17m9C0xCUQf/2dRlrUt/bAaKgJszzr4+zrIz
 rHnQ3OsW0QCqNOwCMhFO+X2JX8GpcNXyPL8L0rRraAre9bE3AX1p8Rg0HKFmYinh5jo2
 x5V7AxTjxNKjPFObvCU70jKnz/Rh4rX0IXdz6+RIPzMs+mTD7vASXx+wmS+CyTGiCUFC
 +63ZtOni9rnRwNB0T4sY4SjG8hmKxIKes9wSMPs3sz031dAyj0SVJLc7oXW8DyDsB3/c
 VvSBUI4OMGQOEnawPdY12gipEnF3QIH5q1QnOrzextRw2lI2vPwz6rfGC1Lrcz00d1oE
 ruhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789827937; x=1790432737;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7shCbBzL3NxDtg4fCdmbNM7nlS/zl4e99x1q/nsZ2so=;
 b=ZowNij+H+RbMYfptlmyoqnRLqNAF5ZLsofqqySieM0HvzBgUrBhcPUxt+v70tO6cA5
 LSE6TT5vayyIE6DJn3o4eLEM+rKrC3i4yJ9lEw/cqN+YbswpDmNf4QjA/pqYY94eYByu
 E86VtNItO5ssJQzW3cTzn5pz+NUvESSa607FGmmwFvbk2XlxfNJBKlJeJmh0sA4spmY6
 14RU48kcSgbPy7cmjcIExvXsZ3Dwj9fy+wOtDwlnMmBe5dfeFV7JPVBcA/+90Fd0+IzR
 8se1nKdKDvMQmtz76IWRTVl4iUCnKKrqNhOz+KbWeo0ImGE9XNEOP6F//75jevKSHolE
 Odrg==
X-Gm-Message-State: AFuF++km0YQ/RPjDsyq+MNbJpcoAXKTCEXpmsH0Nu6MyJIwdoZxFh5m7
 5608Rwml5rrR9q/Ir7XviA89no/6XD8uzl59YAwvlUnhqsdULYiWHXVYv30PONFl62E=
X-Gm-Gg: AYBFou2Hkv9WOCYwX4qPXR4BuJY1zd1ZrNDQh9K9b9pgLGmMqjPsMKVHZK4gln2G8Ug
 DxqoP5QOcLXhORnS7aaagTLzf/LO2ARWBkYPxmjqG6DXrEYiPt8IBH3/XmpON8/KeCcdkSq+dMg
 i0DoTbLlEhj6Sx5pS8fiFpcRgQnT89kFIeOlCXVLA2PJKTx8kvAiEn7Ae3fc5fQfML9efOigZHj
 xWj4pjnGMO/3iYBHMeabw/ZQ9894wJbhPQKkzMDSHlZ5UZd6wigj53SF/ddtY9qFJ0LWUiMF7ZN
 flz/Ib8RkUwAAHS4pHwUAJpU3+qJMKqjdb2Ok8725CED7X2a9nIXT11KUJU+N/MnJzCs65755mJ
 e0qLj6XVlonDwpIT3a3+raZzr9hdkylpvjH7rAkMDTVmaCnsi6ymJNol8EsqfDekZB0s2le8C9o
 IVbYY4n97CcFohCHfaoF08nGbkLxRHNGJ3GhCGpYFrTgoo6hGlavlnvRsVfw+ixhFIzowcDeNOE
 fx7fakQKIohVp4GijLT9iBthcHX0KSwXj0OplWsGfZQYVs9NJjoIvxt+0J1G46zjg==
X-Received: by 2002:a05:600c:8b35:b0:49f:bd3c:bc18 with SMTP id
 5b1f17b1804b1-49fc572f15dmr69026285e9.19.1789827937433; 
 Sat, 19 Sep 2026 07:25:37 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77?
 ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd8bc15esm53940005e9.1.2026.09.19.07.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 07:25:36 -0700 (PDT)
Message-ID: <c173168c-f3a1-4712-b093-b49b5f798e13@tuxon.dev>
Date: Sat, 19 Sep 2026 17:25:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] ARM: configs: at91_dt_defconfig: enable GFX2D
 driver
To: Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Russell King <linux@armlinux.org.uk>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260828-cpitchen-mainline_gfx2d-v8-0-378374559738@microchip.com>
 <20260828-cpitchen-mainline_gfx2d-v8-5-378374559738@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260828-cpitchen-mainline_gfx2d-v8-5-378374559738@microchip.com>
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



On 8/28/26 18:52, Cyrille Pitchen wrote:
> The GFX2D GPU is embedded in both SAM9X60 and SAM9X75; enable the
> driver to use it.
> 
> Acked-by: Nicolas Ferre<nicolas.ferre@microchip.com>
> Signed-off-by: Cyrille Pitchen<cyrille.pitchen@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
