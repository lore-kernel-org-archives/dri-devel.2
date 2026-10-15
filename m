Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80953CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DEA1112231;
	Thu, 15 Oct 2026 09:00:06 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE05911221B
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 136D41A1230;
 Thu, 15 Oct 2026 08:59:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D0A1360360;
 Thu, 15 Oct 2026 08:59:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ACEA710328B02; 
 Thu, 15 Oct 2026 10:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792054796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=R3D3zrodfnAja/dl0ygdUFT7h9waEojVMa7L3/zFbmM=;
 b=uWMhpcGTN5JowFQjWpLSbGpJDvx4A8udLV/wKsPvs2PsSiI6B1LbXD04lX9ILI5jAm9aIt
 pLZPFoHl89d9EYiavK9vd2TSaABhsW8mNjCT9S5w0zii85fzj0qgUTF79h+ReV4Bw4onaf
 Z2//KxBhS+KcZCnWogpg81yzJjIlV+mLQ2vQS6hL8POJZ23liasp8hnwC4n5ormYfS6Zm+
 F0OOtNBq4A9xs4rBv2wcpUbgZMg04usYwAbA1Mqhgf3jI7sWDNZTcO2KZnFH7Kp8XTQtK6
 pVGQNi6uNLs/8+fG6NOmD2XbpRBu+QDVpOJVtUWTXhVzzxCBtsP/U7gQMKF+Zw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 10:59:47 +0200
Message-Id: <DM5AEKBARGER.2N6UFBKLU5AIH@bootlin.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: fix silent probe regression
 due to reset timing
Cc: "Paul Cercueil" <paul.cercueil@bootlin.com>, "Nishanth Menon"
 <nm@ti.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Phong LE" <ple@baylibre.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Julien
 Chauveau" <chauveau.julien@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com>
 <xlv14iengyes.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
In-Reply-To: <xlv14iengyes.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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

Hello Javier,

On Thu Oct 15, 2026 at 10:28 AM CEST, Javier Martinez Canillas wrote:
> Luca Ceresoli <luca.ceresoli@bootlin.com> writes:
>
> Hello Luca,
>
>> Commit e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
>> rightfully added code to make the reset pin really work instead of being=
 a
>> no-op, but that change introduced a regression making probe fail most of
>> the times, at least on some hardware.
>>
>> On a BeagleBone Black rev.D the IT66122 silently fails probing >90% of t=
he
>> times. This is because:
>>
>>  1. the regmap_read() calls just after it66121_hw_reset() to read the ID
>>     registers fail
>>  2. there is no error checking for these regmap_read(), execution
>>     continues silently
>>  3. this results in not matching any of the IDs from it66xx_chip_info
>>  4. and this results in silently returning -ENODEV
>>
>> Empirical tests showed a small delay after de-asserting reset fixes
>> probing. Likely the device needs some ramp-up time after reset. No such
>> requirement is mentioned in the docs I could find, so the amount of dela=
y
>> was chosen by testing: 10 ms worked in 100% of 25 test runs, so setting =
a
>> 20 ms delay should provide a safe margin.
>>
>> Fixes: e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>> FYI For items 2 and 4 above, I'm sending separate patches to make those
>> errors not silent. Those aren't fixes, so they would be for drm-misc-nex=
t,
>> while this patch is for drm-misc-fixes.
>> ---
>>  drivers/gpu/drm/bridge/ite-it66121.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/brid=
ge/ite-it66121.c
>> index 51fc68ffdf8f..692a85e1e2e8 100644
>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> @@ -356,6 +356,7 @@ static void it66121_hw_reset(struct it66121_ctx *ctx=
)
>>  	gpiod_set_value(ctx->gpio_reset, 1);
>>  	msleep(20);
>>  	gpiod_set_value(ctx->gpio_reset, 0);
>> +	msleep(20);
>
> Maybe adding a comment here mentioning that this value was found by
> testing and is not mentioned in the IT66122 documentation ?

Sure, I'll add in v2:

  /* Post-reset delay not specified, value found by testing */

> In any case, the patch makes sense to me:
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for reviewing!

I assume I can keep your R-by with the above comment, let me know if that's
not the case.

Kind regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
