Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ABECC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF53310EB95;
	Thu, 15 Oct 2026 08:29:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509C210EB95
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792052956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6fmAA4pRjLkz/PBqarAT5jgfTfqNf/gcx018ODCtjo4=;
 b=AtSS4y/SgMTHKA/tWwdagOPDmdI4Ppm5MGLKu6vW+pusQ4OHW6WskhjLgytRiDgsv9QpfN
 pliQTZw+ESOKPNvsnkRJr3TMkswcAXTHm7aRibGAZHwHHssv0Ard5W068LZL7PoU4iJQqL
 NbQpIkS0G/SWElZ/yFCjUfjIlygZOcU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-jAmgFebHN6uDre7Xp_6ZYg-1; Thu, 15 Oct 2026 08:29:13 +0000
X-MC-Unique: jAmgFebHN6uDre7Xp_6ZYg-1
X-Mimecast-MFC-AGG-ID: jAmgFebHN6uDre7Xp_6ZYg_1792052952
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b01a74792so3287002f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792052952; x=1792657752;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6fmAA4pRjLkz/PBqarAT5jgfTfqNf/gcx018ODCtjo4=;
 b=DVc3AOx85tW7bMdcdDAm6NASNAgQyHiv3XS1pn17hg7RRu0rIui2rCa3xEyenMKfKy
 /6VKiVnMYkjkEBAQ+XqBCUm2oWLhkFnY/NgrF0iye0jFFROZ7prBBzK3nQfBkuMqpyhS
 IPJ2wddnv+xi9YvsMEcsTnx1pKBc3Gm5ya+H9dzF6EP7pMpYLvGBOCxeMNW/gk8wurhZ
 s3oEUziS9w1NNiEb3/VU0cCidJ+EoyZrhqdX+2IWbnjAaR4Cb1rJJF8ingDUoEW3ynIj
 IIms0Y7HqW5kwh41KDI3Tg/MKJU0g2WxW6feI0P6JpnZSFMWMLAIo3MoPkOjBocpZcRk
 ivBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5zTgAWaovKPvx5BHe0dR5BHRJ6IsVkYuMnJCKHH/MK5MskgpOVGWuYFi/KjdmHWs6+xxJxR72F4g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPoH73P92zXV+Lj6l5ccELNgc0xQ0Aso7UwoQNTwybjCVtusHt
 8GnK4wMDKiLdYK8ZQpGwcqDiNkcuOgh7quNhP/xekWA3avPqGGmNmUZG1zXpFIp8yEXN/U31YBz
 JmWqxvZcG9XOv4JW8fVYmPQDRMl9Td4wLn9+wPa74Vn5o6AD5hiThkGtAnwizsn0GbGRqEA==
X-Gm-Gg: AYBFou00/hvjSJG1nHHY8CaNp2FWRVLJDUS2pY191tLmSlFV4VbcH95z7dEztURkbK1
 eFvWR9vvAIhx9HPbVMxWykzIyKv0/wCrYVyU++A7IOjMqn13tmOBMbGBn57rCAfDvL+pPZizYPi
 1Dof8bPxRVOqDkNSKAXzkeIjYZbDrwi2l1cUSKGiBk28GyvvO+/YwTS6YmqDM8GA7UBPJdF10jD
 0dA/LowJPaWNsisDhCVWs74gyu/KIIqL1Nzz49RbgAtSgyL5mZMn2YmK2OJ2eZTZyvLWdOjy6kp
 M+y0OE5Xi10XS58PxMELcgYcY8CcmCA0hd7y0oRf1IKfsGk1aioaEKMOuytYHrHEJiDRfdxV78Y
 5ZGrSZfDsUDsaLy9esQ/+LjvKLl/XAl0dMig=
X-Received: by 2002:a05:6000:2085:b0:488:7496:15b5 with SMTP id
 ffacd0b85a97d-48dbacf126amr34728402f8f.47.1792052952411; 
 Thu, 15 Oct 2026 01:29:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2085:b0:488:7496:15b5 with SMTP id
 ffacd0b85a97d-48dbacf126amr34728336f8f.47.1792052951831; 
 Thu, 15 Oct 2026 01:29:11 -0700 (PDT)
Received: from localhost ([62.151.111.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df758258fsm1459412f8f.17.2026.10.15.01.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:29:11 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Phong LE <ple@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Julien
 Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: fix silent probe regression
 due to reset timing
In-Reply-To: <20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com>
References: <20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com>
Date: Thu, 15 Oct 2026 10:28:59 +0200
Message-ID: <xlv14iengyes.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g_JgA5gTEq6vrJjWSMkfxJBAzTQ4Fl0lq_YRNrgUjz0_1792052952
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Luca Ceresoli <luca.ceresoli@bootlin.com> writes:

Hello Luca,

> Commit e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
> rightfully added code to make the reset pin really work instead of being a
> no-op, but that change introduced a regression making probe fail most of
> the times, at least on some hardware.
>
> On a BeagleBone Black rev.D the IT66122 silently fails probing >90% of the
> times. This is because:
>
>  1. the regmap_read() calls just after it66121_hw_reset() to read the ID
>     registers fail
>  2. there is no error checking for these regmap_read(), execution
>     continues silently
>  3. this results in not matching any of the IDs from it66xx_chip_info
>  4. and this results in silently returning -ENODEV
>
> Empirical tests showed a small delay after de-asserting reset fixes
> probing. Likely the device needs some ramp-up time after reset. No such
> requirement is mentioned in the docs I could find, so the amount of delay
> was chosen by testing: 10 ms worked in 100% of 25 test runs, so setting a
> 20 ms delay should provide a safe margin.
>
> Fixes: e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> FYI For items 2 and 4 above, I'm sending separate patches to make those
> errors not silent. Those aren't fixes, so they would be for drm-misc-next,
> while this patch is for drm-misc-fixes.
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 51fc68ffdf8f..692a85e1e2e8 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -356,6 +356,7 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
>  	gpiod_set_value(ctx->gpio_reset, 1);
>  	msleep(20);
>  	gpiod_set_value(ctx->gpio_reset, 0);
> +	msleep(20);

Maybe adding a comment here mentioning that this value was found by
testing and is not mentioned in the IT66122 documentation ?

In any case, the patch makes sense to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

