Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDBCC5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E39710F13C;
	Thu, 20 Aug 2026 17:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MB95tA0k";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F07B10F137
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787245964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
 b=MB95tA0kSm/DzqgLDbcjacsn/i2D4iPtbg3PFM2VLK9WSAP4Ajxo+Cy8MYgkAsfJwZEJ52
 MX5QK0J/SjdCgQShzWcaO6IbVSuxndH1P2ZV/eEEUVEqHqkTDMq+R8IoZvPsdavpjWpR3y
 kETTKZ4McQrkv+W35O6eGcdga+wZ2rg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-4ykcTWyROOegWh6kAgwIeg-1; Thu, 20 Aug 2026 13:12:42 -0400
X-MC-Unique: 4ykcTWyROOegWh6kAgwIeg-1
X-Mimecast-MFC-AGG-ID: 4ykcTWyROOegWh6kAgwIeg_1787245962
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499a7993a9bso381475e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787245961; x=1787850761;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
 b=ZPXZC+3YYFtWG1HLuQ9rZYTyO7/Lc1YE3EWFEX6RNNjqGOWmnhZ2ZNQZ0LNHo8auCf
 JtrLB6i5ThiVtMKSKEkpEDHs4AQWTAAOGK8ViqyJxunQLey8UWsfNxCH7sy1xVFQq63D
 M44KezhrNHIKkTulCD1jdBPE7iAFbLSRNmfBmJwkOJkitu14yQx/y1Auy+1QUzHlX1c8
 CroxK88PPkpy7gy/nWYvDfscJBlPqzI28wq4RdKy2XGYVZINkBOhobabzDDekSSZIh28
 WxZB+/k5sEwfVUPxmJMZ0V9P7+l8lUH4WBxW6leFa0Sp9yKXO04WA1aVzlo+p8jkDs4J
 7dow==
X-Gm-Message-State: AOJu0Yz1qb0nDrj0/cw7s1ef161I7blG/R6O1779W6E/ASS3az27ppiW
 0GW2Pd0J5qPW0MnMs40SNQymNNf9NJ4kVz5LHnXbWaQarlAq6WVUnVBU/yNGYOPUiQawFqIMEiH
 he9MFKmGzONZH3cpCYKxFGJE+i6TThnnaOSoF4kvEFByDXNKUecAPsolG9Ima17FCkt3qSA==
X-Gm-Gg: AR+sD12KLVnA/Fly97aDcQdNiKJq8+OuVHf54moEWZe35AGBvX1ZTdFNhILWn3HVlrg
 2GpAZlLdWQojWbMipnWRAK4KrpfTrigizIZRkSH+Dx/ptJD6AK3TqPIuHG6p2afMYjQTb6i9/zu
 FdA0lojxkxiVsnjiFnNZGXlOqrn+xp77AKaXrLvHMrOiw0kF//XMleUPS8c8XebaKLtUUi2MCEk
 T2zXUhkgs0PsgT8lifR+EPfG9z1+O5tP2s6QbIMzQXb9DBQh8293+jVOS5ffGceU+i4Fh5SOUR8
 2/jTSrNAqGEDs3qpWqZXlE22QvUecUl80pSvHB/4Com/53f9/V6IomwnmCvJzYMs8Imh9Sz3OLO
 xwbIBk3//85z9S8A9aT2fScrfcZdl1HdUbBltnjCiAyVoEw==
X-Received: by 2002:a05:600c:8819:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-499b8301c54mr7853105e9.14.1787245961727; 
 Thu, 20 Aug 2026 10:12:41 -0700 (PDT)
X-Received: by 2002:a05:600c:8819:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-499b8301c54mr7852145e9.14.1787245961316; 
 Thu, 20 Aug 2026 10:12:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb?
 ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17fc80sm168153685e9.14.2026.08.20.10.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 10:12:40 -0700 (PDT)
Message-ID: <b332e4f1-30a8-40b1-bdd5-f0c3f816c229@redhat.com>
Date: Thu, 20 Aug 2026 19:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/panic: Retry in dispatch function if panic
 output fails
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-8-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-8-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kQQC0lM29Jz9lAE1WH8qOc7pV3uAZ5iG4D9aVa0t8RI_1787245962
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

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
> 
> Also pass module parameter drm_panic_type as a parameter to
> drm_panic_dispatch(). This simpifies the implementation. It will later
> allow for moving the function into a helper library.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 12c39217cbcb..0960750bfce2 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -746,9 +746,9 @@ static int drm_panic_get_qr_code(u8 **qr_image, unsigned int qr_version)
>   /*
>    * Draw the panic message at the center of the screen, with a QR Code
>    */
> -static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				      u32 fg_color, u32 bg_color,
> -				      unsigned int qr_version)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> +				     u32 fg_color, u32 bg_color,
> +				     unsigned int qr_version)
>   {
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
> @@ -816,15 +816,6 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
>   	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
>   	return 0;
>   }
> -
> -static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				     u32 fg_color, u32 bg_color,
> -				     unsigned int qr_version)
> -{
> -	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
> -		draw_panic_screen_user(sb, fg_color, bg_color);
> -	return 0;
> -}
>   #else
>   static void drm_panic_qr_init(void) {};
>   static void drm_panic_qr_exit(void) {};
> @@ -899,13 +890,22 @@ static int draw_panic_dispatch(struct drm_scanout_buffer *sb, enum drm_panic_typ
>   {
>   	int ret;
>   
> +retry:
>   	switch (panic_type) {
>   	case DRM_PANIC_TYPE_KMSG:
>   		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
> +		if (ret) {
> +			panic_type = DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}
>   		break;
>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   	case DRM_PANIC_TYPE_QR:
>   		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version);
> +		if (ret) {
> +			panic_type = DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}
>   		break;
>   #endif
>   	case DRM_PANIC_TYPE_USER:

