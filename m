Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9A0F8809B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2258410E82B;
	Thu, 16 Apr 2026 07:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="as5YSg8n";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E2F10E82D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776325055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwJSMllG2bRlqEvM/POUkRt5nZeTjqOTjtGX180RgPc=;
 b=as5YSg8n/kr1YHa88PUqqmEa50DFoUpPPyKA3srlLaY13Ebh8lQAE0VDHkRbblQVPJICk3
 55kKyIVqQAfunblrcRx2gAdNSURZMgde8GmE8O53L7jZaceYx9qX7VD6zkNwjakXR+FMCh
 CQ9kPhVosQxkGSxWAZs8B4RHb1Xn6Y0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-ThvyVF3FOJ6lcFk6zBE1Iw-1; Thu, 16 Apr 2026 03:37:34 -0400
X-MC-Unique: ThvyVF3FOJ6lcFk6zBE1Iw-1
X-Mimecast-MFC-AGG-ID: ThvyVF3FOJ6lcFk6zBE1Iw_1776325053
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488dcff87b7so33834425e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776325053; x=1776929853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hwJSMllG2bRlqEvM/POUkRt5nZeTjqOTjtGX180RgPc=;
 b=m7qwkQT0jIkgbszgdQwDCgPmwJFjhH4iqMZ1CHW2vxptAgkhxvsgAF8QHwweD/ba2D
 4zRV7ih6m97DnAjmsYe5mMSyk4ZAIKBe+u5bq/niDOCcTdqnZTPpSuDERJou6WBsyZoj
 cBC3ThMCFhT0urF6d4c4cV19EwprCRCl1CM0g8piNeIFQZuWqFJk32BeHUyokk1YC+OO
 gZjVCqDlcicVfvzWphXj/Yd6jFm5tKCKlf3NF3XI6tkH66Q5/qhWSGXT/1FrK64M1UIo
 wGTmxWJU2aSvq/gKv5dCi+rDYiZUiVXXaz8/HS6i1bv7y+KzyIy15gNohbIT5LQYuhAV
 TiYg==
X-Gm-Message-State: AOJu0YwArTVgqHQrrZNKj8pH0BSUb+oGUjmmaEegK6KEr0X34xFa6Qij
 ckxlTyp+hZ8OF7ySKXcoBtIZiW8JmIhwExeCSjcJnqYtj1AhzWCR9bcBU6hFolrOCSWvYaIOk8P
 HIzdy1lCUFJ602CzQtCFyHQc+hs12FH4O337AqauDPc0C23GsfhRRf9U/4oiV8XZAwgmqNg==
X-Gm-Gg: AeBDievdFJnHNztTJFpUK/PIrYo47iyiSd7hRR4t5LsBmYSK5qGtYaUjwoM9YXC7JBy
 hvWjm1keYKleu5goUQJSm5YjwfL7QKe0FBZPZUwW0KzBzo1XUjTh7prgplsCYOZldyDLRGnZ05W
 Nxs71xi2hCfaV3Zeaf170oo5FVWUCSvnNZ3fMZryKP8qNiVw8QcQSoixJKq/MXcsPrXjB0S4FvM
 fx/Bg0epb0q60Y1OkE1H0cAE2sWb2c/79bDldrL+vQtp0TGn2hxXon/wwIrs4/iNUvG+B3Z0+LJ
 yqqrYKQg9kB7OmxxphrB8C8b7D/xKHsF7lbkm0+bCH2QiQZt0lKSAoEI2z/KBdRvYcc4EL2lthY
 wFwdGk/nxacL5E0rQR46orvgs1LdheTfWzR5HFVdNrA4ACw3Xu5ybj2yuH96cRQ==
X-Received: by 2002:a05:600c:34cc:b0:488:869c:edaf with SMTP id
 5b1f17b1804b1-488d67d882cmr352774725e9.8.1776325052675; 
 Thu, 16 Apr 2026 00:37:32 -0700 (PDT)
X-Received: by 2002:a05:600c:34cc:b0:488:869c:edaf with SMTP id
 5b1f17b1804b1-488d67d882cmr352774405e9.8.1776325052247; 
 Thu, 16 Apr 2026 00:37:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0948731sm39809925e9.5.2026.04.16.00.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:37:30 -0700 (PDT)
Message-ID: <ffc16d1e-99c0-4d81-bcb4-2153bf5d3458@redhat.com>
Date: Thu, 16 Apr 2026 09:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/mgag200: Enable DRM_FORMAT_C8 on the primary plane
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260415152625.101710-1-tzimmermann@suse.de>
 <20260415152625.101710-6-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260415152625.101710-6-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kLdExyqrQPrVMEmrPfGUjZEfvfupK5DMav3z0c9m7Ks_1776325053
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 15/04/2026 17:23, Thomas Zimmermann wrote:
> The driver already contains all format setting for DRM_FORMAT_C8. Set
> the gamma-correction helpers and add the format to the array of plane
> formats.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/mgag200/mgag200_mode.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index 57c9f731a4bf..7fe1d492083e 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -56,6 +56,9 @@ void mgag200_crtc_fill_gamma(struct mga_device *mdev,
>   	struct drm_crtc *crtc = &mdev->crtc;
>   
>   	switch (format->format) {
> +	case DRM_FORMAT_C8:
> +		drm_crtc_fill_palette_8(crtc, mgag200_set_gamma_lut);
> +		break;
>   	case DRM_FORMAT_RGB565:
>   		drm_crtc_fill_gamma_565(crtc, mgag200_set_gamma_lut);
>   		break;
> @@ -77,6 +80,9 @@ void mgag200_crtc_load_gamma(struct mga_device *mdev,
>   	struct drm_crtc *crtc = &mdev->crtc;
>   
>   	switch (format->format) {
> +	case DRM_FORMAT_C8:
> +		drm_crtc_load_palette_8(crtc, lut, mgag200_set_gamma_lut);
> +		break;
>   	case DRM_FORMAT_RGB565:
>   		drm_crtc_load_gamma_565_from_888(crtc, lut, mgag200_set_gamma_lut);
>   		break;
> @@ -438,6 +444,7 @@ const uint32_t mgag200_primary_plane_formats[] = {
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_RGB565,
>   	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_C8,
>   };
>   
>   const size_t mgag200_primary_plane_formats_size = ARRAY_SIZE(mgag200_primary_plane_formats);

