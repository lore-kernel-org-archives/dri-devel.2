Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A55F8809D
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0434210E825;
	Thu, 16 Apr 2026 07:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GH1r1PvX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51EE510E825
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776324546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PE3dB4or4OSxlNCgBkKfN99r3XhfJbGH/qhPuYXFM0M=;
 b=GH1r1PvXh74c6QSVq7yNharjCbKJ+gBhL/V7WDlVt00ryvSPf3eudtDuSOL1RV0JRzkI7f
 xzMDecWZliT9ktY9aSlvEedLFwRzsmMYmRIx+DpMLE+/KJ8G6IZB2k/6niM8sxm8ZOUy0j
 fCScZcCRUQzxP7qzUQW/dzJjO1xIjhI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-eIotIPY0PXuOSbTv8Nv0tw-1; Thu, 16 Apr 2026 03:29:03 -0400
X-MC-Unique: eIotIPY0PXuOSbTv8Nv0tw-1
X-Mimecast-MFC-AGG-ID: eIotIPY0PXuOSbTv8Nv0tw_1776324543
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43cff5ef652so4794393f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324543; x=1776929343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PE3dB4or4OSxlNCgBkKfN99r3XhfJbGH/qhPuYXFM0M=;
 b=nZexkmro4Z7k5dp+fvhLs5Q3PSyts/beuXHmoXFtyqIPaz4WpDoZABQq8Ux+9BY3dQ
 fqJtQCZ7MV4gxqVe4rUhCFuTuSt4Wm3zLxFo1EuBRGaSyLIabssXg/aUcd7l/O5RVo6i
 sk3hj/ZFfKPOxfx2kwjQnX7nICn44QzzUHjc34giFxWLyITNmvlBtUHIie3CrSioku2Z
 y3+LXTMoZT6SIiajm4mSKGk3uVxf81YTo6hJ7mPYvRvEqLVKO4KDnAVnyI2qYgJxec6z
 OG/t/BFS5EH5aIAfSOyM91mVWTyZNbKP8x1bv5eNnngmyBTpXWIPcKsxZL9B+672MwbP
 1m2Q==
X-Gm-Message-State: AOJu0Yx6pryFIlgUvf1a2PVG3jxX9DMQIQh92YN1FgD2vmHf2bMYyZE2
 NMynHBwOC6Gv5eeSXI/eN/VMEuSL/mlzD0VIqecov/wWD9NB1rJMxRNTX02xhEADoCJEbpU+yW2
 pxIYZGtcPV7nYBgjcMyCY34vbzW48uoB5hrc+rAiE9gxUFWZyfTmynoiUTQ/uX8e5sLAxcQ==
X-Gm-Gg: AeBDieuuWmoVc7i8oZIL7/geSU276Be80TtYwbMitRe/nfW7HeldN89ALtm9l8bnji3
 Sp3oNbsA7X2SXWgmJ5iZi8rgSacIdvLRCBdd1pu+sN8uEerUTj5zSX79ZeY4dC6Mm1UcGoIqFx4
 HodJglmg0TRDcWAMrkiSUGxs4mCLc/4mL4GXupQaAwHPLRiJn7VV6x1xbayRaRCXctmXh8Fzebl
 bbddF2PD3nbA6JJQ6zghHJNJk4sOmoVUpUkFBnbZQMmwgI/AweLo+J9sG75ofwO0AAxY2spTll0
 iZarfTBVU2bfcnb2QBslaT3VoUsRCkjkLq7frr16jjGEKG6uXixkqJlQ5d8clxxQvsyTyUUgMmO
 juQmBq7qdeDV+OSVQWa7OD/4htjOV/VGfClE/2CLAB4SRX/P3ZQIbYpxLSUwrpg==
X-Received: by 2002:a05:600c:3f0a:b0:488:afb5:6a21 with SMTP id
 5b1f17b1804b1-488d68764b0mr338383575e9.15.1776324542676; 
 Thu, 16 Apr 2026 00:29:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0a:b0:488:afb5:6a21 with SMTP id
 5b1f17b1804b1-488d68764b0mr338383385e9.15.1776324542239; 
 Thu, 16 Apr 2026 00:29:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead401ca0sm9879721f8f.36.2026.04.16.00.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:29:01 -0700 (PDT)
Message-ID: <c1dc240a-59b3-41fa-80a3-2deee3a14460@redhat.com>
Date: Thu, 16 Apr 2026 09:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/mgag200: Set xmulctrl from DRM format
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260415152625.101710-1-tzimmermann@suse.de>
 <20260415152625.101710-2-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260415152625.101710-2-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ixUbspb6PIocarfzKQ7kActABqzEYf0XvStyvafxvPc_1776324543
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
> Replace the deprecated cpp value from struct drm_format_info with the
> format's 4CC code when setting the depth value in the XMULCTRL register.
> Split the 16-bit case into XRGB1555 and RGB565. The default branch cannot
> be taken, so remove it.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/mgag200/mgag200_mode.c | 26 +++++++++++---------------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index 8894a063b1a1..316413d814ae 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -343,9 +343,9 @@ static void mgag200_set_offset(struct mga_device *mdev,
>   
>   void mgag200_set_format_regs(struct mga_device *mdev, const struct drm_format_info *format)
>   {
> -	struct drm_device *dev = &mdev->base;
>   	unsigned int bpp, bppshift, scale;
> -	u8 crtcext3, xmulctrl;
> +	u8 xmulctrl = 0;
> +	u8 crtcext3;
>   
>   	bpp = format->cpp[0] * 8;
>   
> @@ -361,26 +361,22 @@ void mgag200_set_format_regs(struct mga_device *mdev, const struct drm_format_in
>   
>   	RREG_ECRT(3, crtcext3);
>   
> -	switch (bpp) {
> -	case 8:
> +	switch (format->format) {
> +	case DRM_FORMAT_C8:
>   		xmulctrl = MGA1064_MUL_CTL_8bits;
>   		break;
> -	case 16:
> -		if (format->depth == 15)
> -			xmulctrl = MGA1064_MUL_CTL_15bits;
> -		else
> -			xmulctrl = MGA1064_MUL_CTL_16bits;
> +	case DRM_FORMAT_XRGB1555:
> +		xmulctrl = MGA1064_MUL_CTL_15bits;
>   		break;
> -	case 24:
> +	case DRM_FORMAT_RGB565:
> +		xmulctrl = MGA1064_MUL_CTL_16bits;
> +		break;
> +	case DRM_FORMAT_RGB888:
>   		xmulctrl = MGA1064_MUL_CTL_24bits;
>   		break;
> -	case 32:
> +	case DRM_FORMAT_XRGB8888:
>   		xmulctrl = MGA1064_MUL_CTL_32_24bits;
>   		break;
> -	default:
> -		/* BUG: We should have caught this problem already. */
> -		drm_WARN_ON(dev, "invalid format depth\n");
> -		return;
>   	}
>   
>   	crtcext3 &= ~GENMASK(2, 0);

