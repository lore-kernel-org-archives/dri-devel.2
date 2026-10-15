Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA625CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3EA10E0C6;
	Thu, 15 Oct 2026 12:05:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC33E10E0C6
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792065917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1OUeBBOBtMAwfX1IUkR14M+uBjul6NAIBoL8NzgLm+A=;
 b=DhyrwDwA9BZSt13gsiArOWH2nZXw2RiD4NHKHJXGke2vM7lk84Wn6GMNH6hAx2cyWim7Qc
 WlnRl9sfkUOgHzOXMcpyjqyGBJ5Wu1E+wNXCe1m8BfQ7eBRkzKW7x+JMgUXbvhoFqJRZno
 Y6K5vD+WcYkLLUC5cPAjlL95vRkGV1w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-qOhUibcyMy6J2TDHPjIITg-1; Thu, 15 Oct 2026 12:05:15 +0000
X-MC-Unique: qOhUibcyMy6J2TDHPjIITg-1
X-Mimecast-MFC-AGG-ID: qOhUibcyMy6J2TDHPjIITg_1792065915
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48dea677afcso1327578f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 05:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792065914; x=1792670714;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1OUeBBOBtMAwfX1IUkR14M+uBjul6NAIBoL8NzgLm+A=;
 b=SJ0rOXucOuqSrB3SUWhzOIa1U+V5E7ytQlxNx+VQg/sR4cKDDFlPRgtNK1gdVlfnC9
 14uaXvTqUkUswYy70xMJZv0wR+EKIYRaGbqZmVcut0x31wtSC1BYNOoQwHd1Ucb36kJh
 dPQZ5qt6dlywLPk8xTpzazFGqloiBnTHmgbkrnvwib6RGKKjSvCjf4kl3JFTZb6DtfXO
 s5XpPP1JuwoYpJaT8stmuFYjM/Xz82MoEHaCg9spxywgqwU4sd2xjKpzmrwFusNuYJPE
 30aFXo9IIlQLAaMz/XgCQbwzlqbijLDbFGG0G6ArqWFBkcra5VrSeWGIFVSPl9X7yUmz
 pPuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzo6wu6uw4W85eqgkKRX0AIJxjTt+fqP9A1e5sgyrjoXwIlPX2w1ei1ycG82ApN/p7lbUQROcfchmA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJomUsKhrBMU8a+LptkmqDCXKK953kA6gGl2GMcrJdQ466Ry8gg
 f9diEaXsqlX+3R2lcJIRuUbQDgx0DWKcdLwYVj5NWJfELIZNEPPizXNEIzD0f7p9CDXsuWTBqtn
 TSW0LfORqhTvbVZVcbecGYvyuNteu/jrNo5AJoNvxpF2dEw6E9PC7jnpKVpZTZ8akf3IyBA==
X-Gm-Gg: AYBFou0Jj2XvTvCdQOIrWxQtBDDqHbRIHPotdnsJ6vKq3u4meRJy48Nqh7ZtUimeUmv
 1pyndHcCJZrqX69pYQHtqBpZ0bd08DTSFiRhpVIkCHT9Nda3zjfLKgpAPcIyZ1P6kUE9ZZ1saRY
 TFcBNdWF38dLn8YtjoTX1sLHwO8lpgjxJgCgixiIgX7BPN/Ah/KBVSZ9hWiliBSQ4JdfhK5mKfV
 cfUA2txF2OXsaydCfSOR4piuqWhoj1FAV3Mo+QTLCMeGjWYI0+JylYrObpRY7qyhcXaWvBd4UPb
 b17EYQSElCSD5dAWtgMLQUdq+gi/nYxvZvwuj7ZLn8JcorjX14z/CoZLd1PcJPM1RN4yVzIqNEg
 f+prc9KS7pCoSCvcNf+oUxRM2OI3Ak/8uo6SrqFlXn3ORclO8kRGVMobSXKd/nMNrrQ==
X-Received: by 2002:a05:6000:288e:b0:48c:6756:dab3 with SMTP id
 ffacd0b85a97d-48dbf3d833dmr36030580f8f.3.1792065914389; 
 Thu, 15 Oct 2026 05:05:14 -0700 (PDT)
X-Received: by 2002:a05:6000:288e:b0:48c:6756:dab3 with SMTP id
 ffacd0b85a97d-48dbf3d833dmr36030533f8f.3.1792065913872; 
 Thu, 15 Oct 2026 05:05:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5c3b89csm2881901f8f.23.2026.10.15.05.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 05:05:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Phong LE <ple@baylibre.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Julien
 Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/bridge: ite-it66121: improve reading IDs and
 log on errors
In-Reply-To: <DM5DTVXB3ONJ.1HC2E6FMC5TX5@bootlin.com>
References: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
 <20261015-drm-ite-it66121-log-probe-errors-v1-1-7fd6994e0be0@bootlin.com>
 <xlv1y0bzfdf3.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <DM5DTVXB3ONJ.1HC2E6FMC5TX5@bootlin.com>
Date: Thu, 15 Oct 2026 14:05:11 +0200
Message-ID: <xlv1mrsff9u0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sv6-JpLjr6A_9RPxDrfirmOkXEzeCw6oKFqrdLZj0p8_1792065915
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

"Luca Ceresoli" <luca.ceresoli@bootlin.com> writes:

> Hello Javier,
>
> On Thu Oct 15, 2026 at 12:47 PM CEST, Javier Martinez Canillas wrote:

[...]

>>>
>>> -	regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
>>> -	regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
>>> -	regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
>>> -	regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
>>
>> You should probably drop these defines if will no longer be used. Instead,
>> maybe you could define a IT66121_CHIP_ID_REGS_START or something like that?
>>
>> Although maybe is good to keep them as documentation? Not sure about this.
>
> I'd rather keep them for documentation if you don't mind.
>

Sure, I'm Ok with that.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

