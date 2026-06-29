Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCD7C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE9610E6E0;
	Mon, 29 Jun 2026 10:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="D/drcOTe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4687310E6E0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782728009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xm3lnF8OGUYYjPMf1XDMCVfIs1+U/YDcq+T0Pc20cjo=;
 b=D/drcOTeMth0uxGeaihuQGZll0SbVNu1KnCSULdUvTTXQsOTWRwmd5jy4pze52WFojNaxt
 Pj1NhNsxLvrktmTumR+743cBkwIR9k8WTDAvY4S3tQsuZIm8OjugToUnH/41CsOv7WzE2B
 ClfntYZcTybKiZWqJQXkJngRp60KFm8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Afdn357gMV2b9xMMQ050UA-1; Mon, 29 Jun 2026 06:13:28 -0400
X-MC-Unique: Afdn357gMV2b9xMMQ050UA-1
X-Mimecast-MFC-AGG-ID: Afdn357gMV2b9xMMQ050UA_1782728007
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47345535410so774638f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782728007; x=1783332807;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xm3lnF8OGUYYjPMf1XDMCVfIs1+U/YDcq+T0Pc20cjo=;
 b=cK5Vl583IiCyCAdXJ1laP6muE39mYL/r7uFeefYOAKFhQGl+e22qBVgmrsD5FTxgZJ
 /Ynlux3Qh2T7MWIOmDeTNO3R37QdLUDMZWY0fthBLkRNY1QpT7b5G+n4BUn4CzujBD8G
 s+OB/lyyF9cen4DxsRiCocb4XqEWtK8STd7P9zEsTzgBxWwP9cwJZG3qaG94bsVlIYF2
 Fv+R/8K/TQoLi2Ek5vugaNJMJ/oFl4x2VISPWX34ofAuNbH3MY5aXEq6MHFwKfq4xrhu
 oJoyohnt2lG/T1PrBjK6sSGPGdwzD7HRzLMLpJr7h0N7r8DbJRhypYsEny/3yqmTnG5L
 PSuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dJ5UeZrBE90cLoWeKsZKtOLcpA72aHGI3AvpLk+aBFlvYkUPu7rd9KYqICE6khUNdqc3HA2X+CHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPLnpsc3YqGps8FSJoZAwFLxEAraArdnOehBM1deNMKX9kIDrG
 QpTU9O39KQoDpx1w+lZRSAr+/I/Zp6aPO92uu/VJJ4ilXCINNVbFaPeodteZ85/hgUq1qRlw7/n
 QqAqyJ/NGXywP/WOQ6TfZmfJhyGmeZk9DSekKiWYoJWnkU6uM4coBFSd591xmQzIWY4YSGw==
X-Gm-Gg: AfdE7ckRD6XG50+usFGC+lI+roWqq0OZqPhu5sQR9BxB2xid7Y2f8d0fb8KdQbpZMF5
 JHaEqEdwE+14L6ZXrZCoPbQ6OoYIWHwM2PTG61gJ/DBzClKXGA8fRZgQlLZoqPIZb3ivIFbOx4P
 aNReeBjqhoNNKZGLjaYnb09OIxsM5blvOMlmjO/JZXKHa8LyfyiQyJ65ZBzCpuNuImaeJ46o7r9
 RC14HJGgoaR4zBKhLTIoZQI8qyEHV1A1eeZ7O5gBSMKnnFyVtEDiUc/RpcFZyzCkt4YGhCVyU8l
 rbGDSGYWEjoIL3sSzbjy+6bEC032AewJSFzut9sFAgVqWN6HCRq3D3PGDd+oihXbNB2KSmikXni
 FiW6lzkRI7IBYWW2cSAi9BuVntOh9fyOdXOkXnBPX1GhnbLRAngK4bXIIdZO2CU1o0ZlURg==
X-Received: by 2002:a05:600c:6218:b0:492:700b:deea with SMTP id
 5b1f17b1804b1-493b71a21c5mr1717695e9.13.1782728006526; 
 Mon, 29 Jun 2026 03:13:26 -0700 (PDT)
X-Received: by 2002:a05:600c:6218:b0:492:700b:deea with SMTP id
 5b1f17b1804b1-493b71a21c5mr1717385e9.13.1782728006067; 
 Mon, 29 Jun 2026 03:13:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4734df60acesm11346521f8f.25.2026.06.29.03.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 03:13:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 gregkh@linuxfoundation.org, deller@gmx.de
Cc: azuddinadam@gmail.com, chintanlike@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v2 2/4] drm/ssd130x: Add RGB565 support to SSD133X family
In-Reply-To: <20260622152506.78627-3-amit.barzilai22@gmail.com>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-3-amit.barzilai22@gmail.com>
Date: Mon, 29 Jun 2026 12:13:24 +0200
Message-ID: <87jyrhd58b.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -mvM2Xhj7EoGsjL-0f8y8OCIC8p9XVokXyktvxmbm6s_1782728007
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

Thanks for doing a re-spin and adding the SSD1351 support to the
ssd130x driver. This is much closer to what I had in mind than v1.

[...]

>  
>  const struct ssd130x_deviceinfo ssd130x_variants[] = {
> @@ -206,6 +212,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
>  	[SSD1331_ID] = {
>  		.default_width = 96,
>  		.default_height = 64,
> +		.format_rgb565 = 1,
>  		.family_id = SSD133X_FAMILY,
>  	}

[...]

>  
>  	iosys_map_set_vaddr(&dst, data_array);
> -	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
> +	if (ssd130x->device_info->format_rgb565)
> +		drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
> +	else
> +		drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
>

Since you are changing the SSD1331_ID to use .format_rgb565, what's the
value of keeping the RGB323 support ? It's not used by any other Solomon
family supported by the driver.

Ideally, we would like the driver to expose native formats besides the
virtualized XRGB8888. Geert posted some patches for SSD1301 some time ago:

https://lists.freedesktop.org/archives/dri-devel/2023-August/419937.html

but that never landed.

If that was the case, then SSD130X could expose DRM_FORMAT_XRGB8888 and
DRM_FORMAT_R1; SSD132X would expose DRM_FORMAT_XRGB8888 and DRM_FORMAT_R4 and
SSD133X expose DRM_FORMAT_XRGB8888, DRM_FORMAT_RGB332 and DRM_FORMAT_RGB565.

Given that we don't have that, I suppose that we could just get rid of the
DRM_FORMAT_RGB332 support for SSD133X and just default to DRM_FORMAT_RGB565.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

