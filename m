Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F927F327B9
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11E410E81B;
	Tue, 21 Apr 2026 08:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YkZf9Ouc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B175D10E81B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776758419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ped+TAQ2k6iTSo5cGWOslKeDSxxrCsmzTHKZa82e/M=;
 b=YkZf9Ouc7LOb/ZKpLK9pDPmQuQS2ajLYR1XZE/3quMGGYYbQFlzO9NZkiSGiWFW/Hutwh9
 WILtHOiVFJsK9C8upChDbZ/nFdVgBz/fcyLE/VUmE7ScoWgGPF7Wfa5LJE69aOK72ReQvg
 HKytY2qmcswKe7ivU/WheXZRTEpBFg8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-0-gfP4WKOL-jrbM6bEwmoQ-1; Tue, 21 Apr 2026 04:00:17 -0400
X-MC-Unique: 0-gfP4WKOL-jrbM6bEwmoQ-1
X-Mimecast-MFC-AGG-ID: 0-gfP4WKOL-jrbM6bEwmoQ_1776758416
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48378df3469so24841135e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758416; x=1777363216;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ped+TAQ2k6iTSo5cGWOslKeDSxxrCsmzTHKZa82e/M=;
 b=KHdP5Y79qIOGi7j9PuoukbC3HH2uGfG4Ba6YSbDXRGPidIN0uVq928ewCRd1/vQn0i
 56iEUf3IjfE8KvFXsUyL+AViqFoTmeSgyk5G9L01/4+Eh51vhFr6EXER5nFOipFLKQwc
 oEUVKP0czKRnwgZjo4eVbmMmLUA/q+Up5M6ofglClddziXJXC+IpgS2BuYcKKacuKrYj
 6CeWwNkQkYDeD7/p0d2oFB3yrEbGMjBTL+yMZKjxnxSqwfL5hecMLv8Xdzhjsjh+qjKK
 UwyDbbJw/FXQuDgx0/fP8l4j3QjUxqXZiIUVdesAO7hpegvQorq00hyMe8G0S7YQ7uaV
 SX3A==
X-Gm-Message-State: AOJu0Yy70e63dLgoTwTV1A74MyGckpP4pJ+usHPGL3riAkK7iiryO65e
 6wV0gJtF0M+H1KTjWmnOVOfpUP7lJG5mcI6rzXNqC1nwtrHa3ijkvOnHGJKdkJYaOj+16Re09UW
 wRLwxB9VEvU2nr9Qad9rku4M6SCH0q6lyn0LD83fngq9II5P+ZsVBBVSqLgN+obyxrK4BIQ==
X-Gm-Gg: AeBDievmh58YvgaS1UUkNYuf4D5S+kM7edzWQXpCstprPNkRMdPYODFpvA7oO6nHzlK
 3C9pUhANfPRaEDFDl4o9r4cA3Y203QSCs88tMC4fB4Zl1f//W3QnG6NyCR80Hyh8R9i+Pv/P9SD
 3GY2K3dcWt5aYqZLADDotR2P4wJDj8uFRwRqDf86XKTmMCmDvp+Yi11NzByiOnw6Y8HYOPJBVx1
 n5iA//WdsffvUfjg4+sFZt6nO340XNHwFG9r3yZk2ggPLRiJLAtmgTHmXsrmi609sSWzVKg5Dew
 r5XqUKWR9sPXEXpMnsLzt5tiBMDdkMwqF6wD7OQIPfS9BorLQZSnFAf98EjKPN4fnHPzkzJT+w2
 i0glcKBIXT7dDDjzWywnWtf2DiFTYH1NN/44vnBgFUl1Hvm3Uurui5s54DhtmqcMymEQyOLXf/y
 SFR2vvS4dA/z49RLw=
X-Received: by 2002:a05:600c:2ed3:b0:487:1ed:6bf4 with SMTP id
 5b1f17b1804b1-488fb881ef2mr153900715e9.3.1776758415077; 
 Tue, 21 Apr 2026 01:00:15 -0700 (PDT)
X-Received: by 2002:a05:600c:2ed3:b0:487:1ed:6bf4 with SMTP id
 5b1f17b1804b1-488fb881ef2mr153899795e9.3.1776758413958; 
 Tue, 21 Apr 2026 01:00:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm36996963f8f.7.2026.04.21.01.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 01:00:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] drm/color-mgmt: Typo s/R332/RGB332/
In-Reply-To: <c413e45c8f752a532a4ff377f7a8b9eaab4a082a.1776757681.git.geert+renesas@glider.be>
References: <c413e45c8f752a532a4ff377f7a8b9eaab4a082a.1776757681.git.geert+renesas@glider.be>
Date: Tue, 21 Apr 2026 10:00:12 +0200
Message-ID: <87pl3sivzn.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L-LCx-IWUAhhH01QYYi62qPE-WW_rnmN_pOR6dlg2z8_1776758416
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

Geert Uytterhoeven <geert+renesas@glider.be> writes:

Hello Geert,

> Fix a typo of "RGB332" in kerneldoc for the drm_crtc_fill_palette_332()
> helper.
>
> Fixes: 7ff61177b7116825 ("drm/color-mgmt: Prepare for RGB332 palettes")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpu/drm/drm_color_mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
> index c598b99673fc1515..e7db4e4ea700fe11 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -831,7 +831,7 @@ static void fill_palette_332(struct drm_crtc *crtc, u16 r, u16 g, u16 b,
>  }
>  
>  /**
> - * drm_crtc_fill_palette_332 - Programs a default palette for R332-like formats
> + * drm_crtc_fill_palette_332 - Programs a default palette for RGB332-like formats
>   * @crtc: The displaying CRTC
>   * @set_palette: Callback for programming the hardware gamma LUT
>   *

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

