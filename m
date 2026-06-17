Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9383CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 188E110E9E3;
	Wed, 17 Jun 2026 11:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="J8uOxm2c";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9BD10E9E3
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781696658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HW7N5ERr5Ko13FP1e+xp+U+3cKGn0k0mN8ikI4Rsw8s=;
 b=J8uOxm2cNuNUZLuxh2V4y54yleGRkhPulJv0tgD9KddOR6GYmCEiU9JRh10GmpJ54gCS+9
 22yD9Xnx8Vb2L9gEimZq6W+1VYmY/4PXEbke0BwkuVi9S7QGU40RK8+V9lBvQR00ELw503
 rz0IXLzlr1MMqsMIQlLxJCy1oyWmdDo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ONTFub_wPs24y0_yUKDTzQ-1; Wed, 17 Jun 2026 07:44:16 -0400
X-MC-Unique: ONTFub_wPs24y0_yUKDTzQ-1
X-Mimecast-MFC-AGG-ID: ONTFub_wPs24y0_yUKDTzQ_1781696655
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-460153ce644so4144594f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 04:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781696655; x=1782301455;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HW7N5ERr5Ko13FP1e+xp+U+3cKGn0k0mN8ikI4Rsw8s=;
 b=mdJIqFP3TNDuNo2G1inu2TBiM2qh7H0/cphUK7+MWWI1aZj7MEHOCk/1elxNaQ8wAw
 MZ1zxkwwJqvosZrIlNFBXyNI3zXKJYWDSO5GrYx5L5RSpovrvnjbUJaVSdYTFepSj4kN
 kkMG6sHYKM76SpgyFKdRTLSu+imGfRVzZBfnUnnw1+oaRBbmc9ZZuiejk2UrYSXceOGD
 G7JXU4D7jfyzrvfTOxLx/EoMnw4gENTJczWPVDohD0jytRRCumxDgIMs3ByinlW0XNyk
 2VwFnLlU1N7cirBK8DrblWJ+WbmDn5KR9KFmXkmNYlr7gc48UoywjpIzeoVNTUAJTUqh
 BFrg==
X-Gm-Message-State: AOJu0YyR8zAiax8O5I0VR+t9uxaJdfRPUFwoXCq2MLUN2QBI6XvQ0uKB
 f7eWRqPYJSmzhwIUUB18e+Tk2xPCuH3KtObBXeYD3jWwxQ6Dgz31rSFUHat5Ipie8n13Qw3392P
 2Vic9hb3EtNZlsed3bgDO3IN+NshtA5j3A1KrxGklfGIRnwLKDKIx0j7wDTPqkT43b0pFYw==
X-Gm-Gg: AfdE7clJyMTdjYuDCsTVNr7f8JkovWwtwLXoVphoe448ambo5nY8keq4jgJyIgjj2H1
 bI5LOSptK2zjfhwQeXJruK81JSpnfQz/aXRwStpsoWbP7rCL6KZXF5clqFb100ban31E5vgYBFv
 RSR1hlbxmt9MoxRBUems6FTlILdrNkaTq/+xTguc+6lU6/L9xfjEmb/o5Jexb46Z98Di72KOvei
 4ZzAdjASJbC70NkrH7gYDfqe0A3+GF3D+fZv7nupKj5TeCOApGDGGBYWm4Rm3hulc/9QLtx8uWb
 eBfVhbn6UYQW7sc4ZaT7iRSIYYPPG1abe42NNGa9GO46biseKh4VfYIC5ue5bdmEIUkFvUSeoT0
 rhnfMa/XHonBNRta1vG/jCkgnPPDm8sbTfIdNdtLMC1ZHC4s1WUN8AZmIEoO3vl7LAg2AxQ==
X-Received: by 2002:a05:6000:4b13:b0:462:e086:35f with SMTP id
 ffacd0b85a97d-462e08603dfmr3383254f8f.21.1781696655444; 
 Wed, 17 Jun 2026 04:44:15 -0700 (PDT)
X-Received: by 2002:a05:6000:4b13:b0:462:e086:35f with SMTP id
 ffacd0b85a97d-462e08603dfmr3383197f8f.21.1781696655005; 
 Wed, 17 Jun 2026 04:44:15 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm47931839f8f.25.2026.06.17.04.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 04:44:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/sysfb: Do not page-align visible size of the
 framebuffer
In-Reply-To: <20260617112932.511657-2-tzimmermann@suse.de>
References: <20260617112932.511657-1-tzimmermann@suse.de>
 <20260617112932.511657-2-tzimmermann@suse.de>
Date: Wed, 17 Jun 2026 13:44:13 +0200
Message-ID: <874ij1z90y.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FVP3FHVvYot5n8yJgPdF4BKhb1IjdIwu0Ep7AdIaeNk_1781696655
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Only return the actually visible size of the system framebuffer in
> drm_sysfb_get_visible_size_si(). Drivers use this size value for
> reserving access to framebuffer memory. Increasing the value can
> make later attempts to do so fail.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> index 749290196c6a..361b7233600c 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> @@ -67,7 +67,7 @@ EXPORT_SYMBOL(drm_sysfb_get_stride_si);
>  u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
>  				  unsigned int height, unsigned int stride, u64 size)
>  {
> -	u64 vsize = PAGE_ALIGN(height * stride);

Do you know why the original efidrm_get_visible_size_si() (from where
you took this code to make it generic) did the page align ?

The change makes sense to me though from your explanation:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

