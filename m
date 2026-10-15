Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6F4CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A8310EA0F;
	Thu, 15 Oct 2026 09:57:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79EDD10EA0F
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792058241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/QMHA+JTRfz+5hNc6KeHMze6xpzQ1+15CGj5JBUuffw=;
 b=VsTzGSRHqvsMfrriWMeiHbi7zvo3HeF6GZy/9YXpMr829XWjYH09AZzEq2Y31xb3AvV48A
 qj4m2aHv9O7re9oNWtD1p81gwpQ26i64XKuL8MlYFMmqCveQFTzJL/5p7Jw4BdDyHfkNtY
 d1yfzc2kLpjC59Q5OjJMWLh8QnKbNhI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-mBDRxqDmNiiT-888Djc8_Q-1; Thu, 15 Oct 2026 09:57:20 +0000
X-MC-Unique: mBDRxqDmNiiT-888Djc8_Q-1
X-Mimecast-MFC-AGG-ID: mBDRxqDmNiiT-888Djc8_Q_1792058239
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4887e5afd67so3904273f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058239; x=1792663039;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/QMHA+JTRfz+5hNc6KeHMze6xpzQ1+15CGj5JBUuffw=;
 b=E3riSfrZkwvmR5101+ueErdZTWggx8KwW+BhSPPFXPNprwGBhI+NuEZtc0G6uT7yas
 piGtQ8q75FNXvfEX+cNYEQ50Z4H4t/g5ArkLr77mlTYLP81b0HydbQnu/Cygh7c30NDw
 cbovT8o5kqW4Cc1HwWi8qMRZl23X35WRH8SZTSEgsGRC43Dt407Lex7UPrmg9kn4dCwN
 W4A0oNhHEU0xW7XXFvna76hT33v4li9R2pTp4Eh3yDjGh+36nl0tvQVVeAyrKBMQmbqZ
 PWt0zIG3CX7WiA1CBty7u2h4/BWTBnYQWIM6Rt/VCfeP2VLsp2ZrByIE0vJPUW1d5xcZ
 UaGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqoSrJDBt1qNpO+lPHmGY1EqgeL7tmUX772zWL7zVpC4+SDeq7Vi9VBoCLC6sLPyvOSeLB9dwmEtc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKzgADLou7ZnEupaeOpiRXd118EvNNEDnfG9W2Twhf06vDs+7Fk
 pgo8tFgpUP6AR9uP08E9OUQpb6/rfUedtvgoS+YrOX9d+mxjFx27KnXTmpq5kcV6d9OBbKA7Eur
 4M4nWwj/t4YmN6fzTkWx0keUKyVpyyv2Mngjd2y540nC/ezdayXTfUQostJfobnFHyUZ2tQ==
X-Gm-Gg: AYBFou2Kvjfk8PU0Xig6AP0q+OkKpDy/HG2+TZmKaELWzxtytCrbpSZf2iiPDgple8z
 zNJok3SviRLyAu+R6nlBg49yuMe0x/IS16G/n0VFoi83eYdAFgzLJxrF2mKLT1+Q1wMYtbXSNYw
 TGCq+LJC4e+TtkW7qJg9sQhNU3eTjJuSJYrREpa5uy4J4/PFPVjg4w7A5+YbLrOeFwdvlZ3GyEm
 /WCid4KFVnPl3gookCDj1vtBTys+096ACZrnA2B+KFPPdTGo0S5jGg0JitXTnX0EhlPLOqjA72D
 fNn5WEw7KL+UkIAELBC4ZLr3h5uddQRTVcyWJUg6lBBVNai86FalZc1OIftTkv46bkqpuH61log
 f2eF2EdgzanLOLXQVNIePeEnnzDTHSfDdMtgrsCV1orVqYIZmblap9gP8Dqylre8CNw==
X-Received: by 2002:a05:6000:288a:b0:488:8568:bb02 with SMTP id
 ffacd0b85a97d-48dba9e6727mr35188916f8f.23.1792058238723; 
 Thu, 15 Oct 2026 02:57:18 -0700 (PDT)
X-Received: by 2002:a05:6000:288a:b0:488:8568:bb02 with SMTP id
 ffacd0b85a97d-48dba9e6727mr35188855f8f.23.1792058238165; 
 Thu, 15 Oct 2026 02:57:18 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc6b82sm18236816f8f.51.2026.10.15.02.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:57:17 -0700 (PDT)
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ite-it66121: fix silent probe regression
 due to reset timing
In-Reply-To: <DM5AEKBARGER.2N6UFBKLU5AIH@bootlin.com>
References: <20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com>
 <xlv14iengyes.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <DM5AEKBARGER.2N6UFBKLU5AIH@bootlin.com>
Date: Thu, 15 Oct 2026 11:57:15 +0200
Message-ID: <xlv11p9rgubo.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7zc6_VYREh7PRmGyG3Wt9mxTBh_egyBE1McVssqrTO4_1792058239
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
> On Thu Oct 15, 2026 at 10:28 AM CEST, Javier Martinez Canillas wrote:
>> Luca Ceresoli <luca.ceresoli@bootlin.com> writes:
>>
>> Hello Luca,
>>
>>> Commit e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
>>> rightfully added code to make the reset pin really work instead of being a
>>> no-op, but that change introduced a regression making probe fail most of
>>> the times, at least on some hardware.
>>>
>>> On a BeagleBone Black rev.D the IT66122 silently fails probing >90% of the
>>> times. This is because:
>>>
>>>  1. the regmap_read() calls just after it66121_hw_reset() to read the ID
>>>     registers fail
>>>  2. there is no error checking for these regmap_read(), execution
>>>     continues silently
>>>  3. this results in not matching any of the IDs from it66xx_chip_info
>>>  4. and this results in silently returning -ENODEV
>>>
>>> Empirical tests showed a small delay after de-asserting reset fixes
>>> probing. Likely the device needs some ramp-up time after reset. No such
>>> requirement is mentioned in the docs I could find, so the amount of delay
>>> was chosen by testing: 10 ms worked in 100% of 25 test runs, so setting a
>>> 20 ms delay should provide a safe margin.
>>>
>>> Fixes: e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>> ---
>>> FYI For items 2 and 4 above, I'm sending separate patches to make those
>>> errors not silent. Those aren't fixes, so they would be for drm-misc-next,
>>> while this patch is for drm-misc-fixes.
>>> ---
>>>  drivers/gpu/drm/bridge/ite-it66121.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>>> index 51fc68ffdf8f..692a85e1e2e8 100644
>>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>>> @@ -356,6 +356,7 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
>>>  	gpiod_set_value(ctx->gpio_reset, 1);
>>>  	msleep(20);
>>>  	gpiod_set_value(ctx->gpio_reset, 0);
>>> +	msleep(20);
>>
>> Maybe adding a comment here mentioning that this value was found by
>> testing and is not mentioned in the IT66122 documentation ?
>
> Sure, I'll add in v2:
>
>   /* Post-reset delay not specified, value found by testing */
>
>> In any case, the patch makes sense to me:
>>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Thanks for reviewing!
>

You are welcome.

> I assume I can keep your R-by with the above comment, let me know if that's
> not the case.
>

That's correct, yes.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

