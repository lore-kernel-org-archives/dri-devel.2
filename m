Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569BACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA1571122BD;
	Thu, 15 Oct 2026 10:47:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DD61122C4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5s0adaAlZjmhtDx9aVR2qtB46fnKw4HK1vTEiIYxT7o=;
 b=VrvfS3K5VGYtnhkAVMX5aX9mAdbirBKdaV79phnvMqlFyW63sJETDG60RKnqgejLuh224c
 pNgOZp/vcis0lpTDgO3WQ6qSj5zQd+/WiHTnwuTZyo8iZ1PooanVqKjSmRWbfT4c7uI7rO
 3JgLiXocbMqWlxfsfuVCCaiZUGunb/0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ON0hmC9AOF-MmLN0wyWuPw-1; Thu, 15 Oct 2026 10:47:48 +0000
X-MC-Unique: ON0hmC9AOF-MmLN0wyWuPw-1
X-Mimecast-MFC-AGG-ID: ON0hmC9AOF-MmLN0wyWuPw_1792061267
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b02e93a1eso4282634f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061267; x=1792666067;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5s0adaAlZjmhtDx9aVR2qtB46fnKw4HK1vTEiIYxT7o=;
 b=SluMfVxkXTHP80Y9q86AUnLQcdobayOx0O0X8IAnuQfvqcfi3ItOZp3HdgO8qt2y8i
 Y5xPMO8Vj10TNSqmEHbI4baByruOIMfh1mWjMpIuRT0WCeKSewmAq/h6O47H+vzJtEO8
 vwh02jn3tSJcKxZEFv6xqod4KmhqCFf9JzjgvlSFVSYKN2E2Hxhf62KsQXMsUnARXf4Y
 ITwSHN6BNSquff+J2vKGsB6U7WA0uVO/f3w8PZiPm7kSRZIdOZekGO6yQx18YES/gbPZ
 inepQRMQmlaY+zSEbKhhDVNvFw2OZXuBGLmjTRlAFFiF/tDPuuBvS50qUIbcK5c1Gjuf
 /Dog==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQLPghriuPUCCXWk34n6NMw+wrcIync4CXb/rlIZS/vWf0EXiX9Gy8O6V3X4unr26uoUCTy7uMrf8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKrmKRwKXbov5z+bNe5nxAQEUFzkEmOyGGRj1xsekOy2g8LeJZr
 XRbmUAg7K5Q4Ecm4/jGR2SNW+J4CMbMKHvYxgivq5yrw+uaSvmQNLJcdq4BVlLnYzjuD96s/BDH
 0nFV9pl7OL3srTtsyT2j33WrXesu+aAl1Kmk10vVEeD7/kCAsf269LjcLEUvYTtwxPmSwLg==
X-Gm-Gg: AYBFou1R3GihxsVc6jP5dSsOsQ9NfVx6LAvuWZYXoh4+J8n2dYbtd/k8HVRArt5lJs/
 NNfRqWcRsXDN9CB3BjJ+evYr/CkWPzJ1wMdlFH5Mna+C1lJpVLxg+YKIKYRglTku3x/04mkTKVK
 vixzN+zFf06FhqYhTMbk0kwGqb4ZEbNI/fO18uKKl+6uNll60xypkVg+dwaMEZQNlCQl12YTpsW
 xdcjzok8yWH7B+ILs1AySqYnuDa6KBjz5uLQScZIstM/E1l8kuBHxjWE/CJ0d8sgLwo9ysjjBhz
 Un/JBwfBxvO3kvcRw4Vwn3Zczlfd6sNW09iEJrIE+PX2WfwnmGrIo8cACLMiLXxY2PxyyceK09u
 vRiEMbS9QCwvLE/GmLKIp4DkcVKIvrOajXaCos9lCO8J4YBxh3lv3Yp4BpZ/GkwbQJg==
X-Received: by 2002:a05:600c:8718:b0:4a1:7259:349e with SMTP id
 5b1f17b1804b1-4a18e4e0a33mr367294965e9.27.1792061267375; 
 Thu, 15 Oct 2026 03:47:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8718:b0:4a1:7259:349e with SMTP id
 5b1f17b1804b1-4a18e4e0a33mr367294625e9.27.1792061266913; 
 Thu, 15 Oct 2026 03:47:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd68585csm39353835e9.4.2026.10.15.03.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:47:46 -0700 (PDT)
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 1/3] drm/bridge: ite-it66121: improve reading IDs and
 log on errors
In-Reply-To: <20261015-drm-ite-it66121-log-probe-errors-v1-1-7fd6994e0be0@bootlin.com>
References: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
 <20261015-drm-ite-it66121-log-probe-errors-v1-1-7fd6994e0be0@bootlin.com>
Date: Thu, 15 Oct 2026 12:47:44 +0200
Message-ID: <xlv1y0bzfdf3.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AckGFMV4Yl4uLGqO-DQ3TiKCrwhGPYVtUIgi_zRFDMI_1792061267
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

> it66121_probe() calls regmap_read() four times to read the vendor and
> device ID registers, without error checking. This leads to silently
> continuing using invalid ID values when any of the reads fail (which has
> happened and is being fixed [0]).
>
> Adding error checking on all 4 regmap_read()s would be annoying, so switch
> to regmap_bulk_read().
>
> In turn a bulk read requires a differen data structure, so take that as an
> opportunity to make the vendor/device ID computation more explicit.
>
> [0] https://lore.kernel.org/r/20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 692a85e1e2e8..9b43456c67a1 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1580,7 +1580,16 @@ static const struct it66121_chip_info it66xx_chip_info[] = {
>  
>  static int it66121_probe(struct i2c_client *client)
>  {
> -	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
> +	union {
> +		__u8 byte[4];
> +		struct {
> +			__u16 vendor;
> +			__u16 device;
> +		};
> +	} chip_id_regs;
> +	BUILD_BUG_ON(sizeof(chip_id_regs) != 4);

I think that would be simpler and easier to read if you just use a
u8 chip_id_regs[4] variable, instead of the union.

> +	u16 vendor_id, device_id;
> +	u32 revision_id;
>  	struct device_node *ep;
>  	int ret, i;
>  	struct it66121_ctx *ctx;
> @@ -1644,19 +1653,22 @@ static int it66121_probe(struct i2c_client *client)
>  	if (IS_ERR(ctx->regmap))
>  		return PTR_ERR(ctx->regmap);
>  
> -	regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
> -	regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
> -	regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
> -	regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);

You should probably drop these defines if will no longer be used. Instead,
maybe you could define a IT66121_CHIP_ID_REGS_START or something like that?

Although maybe is good to keep them as documentation? Not sure about this.

> +	ret = regmap_bulk_read(ctx->regmap, IT66121_VENDOR_ID0_REG,
> +			       &chip_id_regs, sizeof(chip_id_regs));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error reading device IDs\n");
>  
>  	/* Revision is shared with DEVICE_ID1 */
> -	revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
> -	device_ids[1] &= IT66121_DEVICE_ID1_MASK;
> +	revision_id = FIELD_GET(IT66121_REVISION_MASK, chip_id_regs.byte[3]);
> +	chip_id_regs.byte[3] &= IT66121_DEVICE_ID1_MASK;
> +
> +	vendor_id = le16_to_cpu(chip_id_regs.vendor);
> +	device_id = le16_to_cpu(chip_id_regs.device);
>

And here you could use get_unaligned_le16() instead, to not have to cast
when using just a u8 array.

>  	for (i = 0; i < ARRAY_SIZE(it66xx_chip_info); i++) {
>  		chip_info = &it66xx_chip_info[i];
> -		if ((vendor_ids[1] << 8 | vendor_ids[0]) == chip_info->vid &&
> -		    (device_ids[1] << 8 | device_ids[0]) == chip_info->pid) {
> +		if (vendor_id == chip_info->vid &&
> +		    device_id == chip_info->pid) {

I wonder if this could be done in a separate patch.

That is, keep the << 8 | for this patch and just do the regmap_read() to
regmap_bulk_read() conversion. Then as a separate patch you could replace
it by converting with le16_to_cpu() or get_unaligned_le16().

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

