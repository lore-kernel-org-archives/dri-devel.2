Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DA9F43841
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4523010E82C;
	Thu, 16 Apr 2026 07:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PScGlPUk";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5841110E82B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776325006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPMrTm4H8fDxjSoEZyRxfpnrf0F4yH31d3iIteE5eHY=;
 b=PScGlPUk2xQKzt10lfRPXHKCAEWTavREOZsdvl2xvonCK+IWIQbgu5guFgdOJ2D/agELIF
 ZJxLTEEMwMHJTLb1v2CAIDl+9QDB6H44xYkFt06nLXyzdQOzd/KaIdngBWitDfBleJg7tM
 s5/jUAGd0XsZzp9E6/eIYnG6XAwbaU8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-W6o8spJgNaSOph_IKQAtPA-1; Thu, 16 Apr 2026 03:36:43 -0400
X-MC-Unique: W6o8spJgNaSOph_IKQAtPA-1
X-Mimecast-MFC-AGG-ID: W6o8spJgNaSOph_IKQAtPA_1776325002
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d3eec9bcso39167675e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776325002; x=1776929802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mPMrTm4H8fDxjSoEZyRxfpnrf0F4yH31d3iIteE5eHY=;
 b=YORT/DTUC3KDJ1rD6FOIrGaDuo3dxaTjkYTYU9dInuK/Iz4PxdYRaXDXzkwbg8hLVN
 BCHrGSZIcRKAPJ7sEe8ylh5A9qPyYRvLNpDEDzcArgGhX6sPUVn5isFX8sFMRfb0lOsG
 PbloHn3URbecfst9RbD4+J7thjwugmo5rjA8wP0Ijh5tA5Dqlqlu4yWco2lbPTJ2DCjn
 okNm+DT0CTEvElTQUrkAXLqJY0G6KBDamdjd8GEqgTr6Rqc/E5wjRpfK9gZiSJkPcrr7
 9ue+BdM86WvO93MDZxMK4lah4G71FWjI21d6lbqcjnjgKA06pdffrGAg89PduPYyfcU5
 6geQ==
X-Gm-Message-State: AOJu0Yz6KSh0eAc7i/T1ykyxI8+iYPCYRCmo9wBxa/XzSbdv3bFf6t2h
 jTt6HfSGETWQdeHtFCRT2dmFmb8othBEPUR70uHt6mjWj9Sj5DvRnNGMaE2WmYTva8S6op7qorU
 /6c4vppZs9GCcb2HmAArprfxAE3Xv8gD62olWggcq0fzlOPRlN3eYbABkMDs135QeIRfM2Q==
X-Gm-Gg: AeBDieuQvRpgLCb16YiLbg1gfgk67xH2zrUHnyp1fzsczt7x8gXzVcBojfkhbEtXDYQ
 2hJMNt/qA39mb/UAQJk0IHwNtfQpE8/sdvsyhUTurpXnasEHTCR4Du0QHfXNXFy84GtGYJkvWAD
 B51YGyYEyROYWetbjVG050peET7mAtoCryLZt5KvZOHQ6igOZMyEgWHJBFYkTjRgSghcs3jm9TN
 Xa0mqGrHaadLDir+kc/gDz3VnWmgo62ZKd8SW2jRI7ARMGY80TgmH2mVlVcmArN1ZTivKvgMl3r
 4nYYQVLqQyTUMo0plpGy0e+DezoxD9naYQk5M3D1iS+sp4erlr7ciDyJVdYOtzraCEsEh8CyJOx
 CM96MCXgAmDPtztCExywjmZM5j3qnzgt8biEtv0pPQz5uNz+PiaCvH9vmT+ckCQ==
X-Received: by 2002:a05:600c:c0da:b0:487:1fc:14f9 with SMTP id
 5b1f17b1804b1-488d685b7c9mr291569895e9.15.1776325001802; 
 Thu, 16 Apr 2026 00:36:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:487:1fc:14f9 with SMTP id
 5b1f17b1804b1-488d685b7c9mr291569565e9.15.1776325001369; 
 Thu, 16 Apr 2026 00:36:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3e89ddsm10929137f8f.30.2026.04.16.00.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:36:40 -0700 (PDT)
Message-ID: <c7fec90f-79f2-4929-9a95-3598bf9a1fc3@redhat.com>
Date: Thu, 16 Apr 2026 09:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/mgag200: g200se: Set hiprilvl from DRM format
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260415152625.101710-1-tzimmermann@suse.de>
 <20260415152625.101710-5-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260415152625.101710-5-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: APW6PjiVYNLdwqJqrnevZSGT59q5uyr39zXNG0iKWes_1776325002
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
> Replace the deprecated cpp field from struct drm_format_info with the
> format's 4CC code when setting the hiprilvl field in CRTCEXT6.
> 
> Using a bpp of 32 for RGB888 is a bit dubious, but we keep it for now
> to avoid changing behavior. Otherwise, bpp could also be retrieved by
> calling drm_format_info_bpp().

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/mgag200/mgag200_g200se.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> index a0ac19ee0353..746ce11b75fb 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> @@ -76,12 +76,18 @@ static void mgag200_g200se_set_hiprilvl(struct mga_device *mdev,
>   		unsigned int bpp;
>   		unsigned long mb;
>   
> -		if (format->cpp[0] * 8 > 16)
> +		switch (format->format) {
> +		case DRM_FORMAT_XRGB8888:
> +		case DRM_FORMAT_RGB888:
>   			bpp = 32;
> -		else if (format->cpp[0] * 8 > 8)
> +			break;
> +		case DRM_FORMAT_RGB565:
>   			bpp = 16;
> -		else
> +			break;
> +		case DRM_FORMAT_C8:
>   			bpp = 8;
> +			break;
> +		}
>   
>   		mb = (mode->clock * bpp) / 1000;
>   		if (mb > 3100)

