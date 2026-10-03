Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA87CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 10:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CDEC10E932;
	Sat,  3 Oct 2026 10:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="duPdxZeq";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874C910E932
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791023460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x3OlQPuKLle/RWQyCvYbmxpN1t4vBLUkyyPtEqihZM4=;
 b=duPdxZeq0hnng+uo1sr3PAOvrSfwdVmhl3WbvYVQAAeZyXYN5P3Az2BTzLG4R7rEGRT2SO
 7dQLBeKRDIT2Pq9Obs5C2Xlwr1Bu74ukYuEk1nALUMbfa6/WCLmnMKObAeaIWXkNrNYcjT
 AP8HDH4XB6Nl5BjEIIcrw9wHnBiU5fY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-sXfRDDVaMoucZ8SUiaBLZA-1; Sat, 03 Oct 2026 06:30:57 -0400
X-MC-Unique: sXfRDDVaMoucZ8SUiaBLZA-1
X-Mimecast-MFC-AGG-ID: sXfRDDVaMoucZ8SUiaBLZA_1791023456
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a0023f2b60so3766665e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 03:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791023456; x=1791628256;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x3OlQPuKLle/RWQyCvYbmxpN1t4vBLUkyyPtEqihZM4=;
 b=Ce2+5dOrO5Rq2JJJ38qGVZdcF13nF2HSe3bMZzPhqXB7cTZSpGjgpIY0OEZYdKWiNL
 oSpwVUcGAz4t5+NOmsfOjl0HZhabyQAT06+NAsfR79e/GZxtvXmiOwLxeg+HzmsMZnNJ
 GCfWQMxrmJwR9dYFqrh/EQh1ey/PfRkY0F7SsijpkbJQBUmuX+XpO3rbfG6fJr9cahOu
 z4TP25bUzN/kkROLpj8PGtN2UyZUm6SL1Uk/CfZ6rfCKOXfe2cwYGDyFGUlBWS3v3HGL
 e+D59sS3JSU+K/TRiHkgSLE7nnUmRQ191yw5qffvC560yBgqPoOJ+NLalQEoW0OSBVUM
 ZkUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqFWbyHLOrDBCtO78EIl5Kxp0ZW9rdJu8jYa6ehJBAoBXv8cP25dTE4HXgPUef69HALzN6U+qIgMY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++niOoc881U5okjAVj6V0uHJt3qfrqG55BeWiNGvzybScgumOVPh
 zNwkXIzQJ45wK18RvtMREyo1rSzP0sYGU0fL7TSHteEhvTvZcW06Nw3ho8kzmqsso6eMmRZawI9
 Lubu+DL5hE1TMKyqEjvfgDGrpEk2aRZSQIm2vk1bgXzpVlHtKCgtOAlcCANVzScLclFhwhQ==
X-Gm-Gg: AYBFou04T4jw/BdsDwdIrfar3tqACs772ux5DLGB1nkL1k5MhzBS1i+TzCGjb79XzNZ
 SP4czbTEiETMaqyT0Md8TWLgnrw/2YgEpPjejA4+taTu1YfDxqYSzBdFjo1Z6m/0MU3/0+TwE2J
 LKYB+Fu/aMPCyWWlfM0CqD1VjmJgky+cwnaqZ+e+u0s+V7+v3IFV4VRK+Ns0IGQrI+OuM5N8sz8
 DE3wPbiQgrwv/VsHgnsNYAJCY63s57s7CniI0rP6S+L2ayM77Qtcpy/PjkGsGyr/V40bIsLJrDb
 3JXLUnhzsRlEE4RIrPji5OJ6yIpJUg1Gs5SQ1NTK1YbdtNUFZs61IOZRXsSs1Eha3haIpxJYvZh
 oabuqP8DwlzL9ubnctvsk+wwyjOTIcSJak7jOUyH29K+Z6yVDASaCugqCxAr81bbhGA==
X-Received: by 2002:a05:600c:3115:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-4a168105ddfmr30256035e9.31.1791023456062; 
 Sat, 03 Oct 2026 03:30:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-4a168105ddfmr30255685e9.31.1791023455648; 
 Sat, 03 Oct 2026 03:30:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff20831sm97747375e9.4.2026.10.03.03.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 03:30:55 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v9 21/21] drm/solomon: add SSD130x connector luminance
 support
In-Reply-To: <20261002190030.211356-22-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-22-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 12:30:53 +0200
Message-ID: <xlv1zewv5b4y.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bPQwXQ4S2zYrTmCtqTIEdoMxKQOIEEZi4VtFbpCR_jU_1791023456
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

Mario Limonciello <mario.limonciello@amd.com> writes:

Hello Mario,

> Expose SSD130x contrast through the connector LUMINANCE property when
> DRM_LUMINANCE is enabled. Program contrast directly and retain the
> backlight class interface otherwise.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

[...]

>  struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>  {
>  	struct ssd130x_device *ssd130x;
> +#ifndef CONFIG_DRM_LUMINANCE
>  	struct backlight_device *bl;
> +#endif

[...]

> +#ifndef CONFIG_DRM_LUMINANCE
>  	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
>  					    &ssd130xfb_bl_ops[ssd130x->device_info->family_id],
>  					    NULL);
> @@ -2258,6 +2298,7 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>  	bl->props.brightness = ssd130x->contrast;
>  	bl->props.max_brightness = MAX_CONTRAST;
>  	ssd130x->bl_dev = bl;
> +#endif

I think that IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE) makes more sense?

Other than that, the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

