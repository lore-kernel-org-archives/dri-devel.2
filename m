Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862EBC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E677A10F120;
	Thu, 20 Aug 2026 17:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CtOaj/Nc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098F410F120
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787245521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
 b=CtOaj/NcDVWSH7If+Ccbr6S1I3fxFBSd2N0SNO7+VmtNtXoSfFXMOMnGoXIUl+Dmti0qba
 SBwBC6W+nh2ZeiIhz+212DbIlO3vDW2gt1jckPQYvCFJyz2qXao7d6WwWx5PAc2yAngNPl
 bbMt/x8zTGduG7vGd3KVX4WqMoAySjU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-26yAo4uMOHS97-9z5Vidpw-1; Thu, 20 Aug 2026 13:05:07 -0400
X-MC-Unique: 26yAo4uMOHS97-9z5Vidpw-1
X-Mimecast-MFC-AGG-ID: 26yAo4uMOHS97-9z5Vidpw_1787245499
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-499a8039ff5so331325e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787245499; x=1787850299;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
 b=d7UOaTEdkCg1XWOwdr/Qu9ugwAtZvGlaCA9jGQG9zCwVsv9ockmQUmqj7kjOIGeUCZ
 +dQtxNCrpL755xfZCb21T/ms9TDF3Oym9P6YamlHoK58lX+OJ7J83uclto1qgRy7BSRZ
 qCcYJxhM8eDqMV986Q2oiROIBkTjt9fSKYJVBbIORHsSCsUsrhjMRPWinf3/ueCRibqy
 +5m0REaz5TgKVPOGvuHtkdr8DnSquEq100b6Il7V721If5c9U2+MB+RuO1wkG/5vFnJv
 eZdxIZDKN74M9px1gMpeRq5hcGo22T6z7ylEV9dnRMqONfGm7lpnsdfhfsweVrbc0xji
 Jhiw==
X-Gm-Message-State: AOJu0YytzYgKElfzOSgPf1xDHuyqZJBI8pgubOmtj7X/rwT8t4vH9RcG
 c4uFy4FdoR4vTs8UXjsryLSIb88Iqcl9rI054Qd3JKpHdwQoUdCY5I2lhq79r4hxUyPPGLteIc/
 yaNxwd6ZgQd207RyCmWECiBEAjIRS5J0/O4/2cMYSNA5zgViy4acu1WIH0TScwJJTnkJcwA==
X-Gm-Gg: AR+sD13ST7epbnHILKU8mHNd0ECK8wJK+8bHe5YQYkjPx61h42+tS+kDuwD/SZdqzoU
 prLX8O88fEt67nBbjOCBahrJFkssQ+Wm+CFpZdiobxibzUZuav2zF8TzlXrsaMDJZAGzKFxc7fN
 3zBV97tZOQG3DdtjjtKJPltiwQxz/EMSBtnTNXzM/F6HUvX4jDsqQtmfmktkkHqmTr6RuhOA8Vq
 1iXoXnrtkGo5FYEgv7kM7E9sNxFSikh1hqNkiuqPXJAQH8EWmFjS7EIpjCcAszH8GRnFUmBBJaj
 nPAd6W/EUb1FTiXNS3JebOhj1XCJNAofLJ545dfaxU+NULtqsSz7MGfyihbGFMYO1urhdmdEp80
 uSy/bucbAIKfntN3OKcNS9xNsTARrA68LvBuQrOd7D0tUeg==
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr5016845e9.10.1787245499074; 
 Thu, 20 Aug 2026 10:04:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr5015695e9.10.1787245498659; 
 Thu, 20 Aug 2026 10:04:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb?
 ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33b3sm13157002f8f.27.2026.08.20.10.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 10:04:58 -0700 (PDT)
Message-ID: <cb784cf6-f3d8-41aa-9f71-c197a5eba7f2@redhat.com>
Date: Thu, 20 Aug 2026 19:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] drm/panic: Return -EINVAL if font is not available
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
 <20260818125012.468092-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HwcSLPI-5cZIcn11fKFcytIhXAzDSPpbOdgn6HSmlrM_1787245499
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
> Font lookup does not allocate memory. Hence reporting ENOMEM on
> failed lookups is misleading. Report EINVAL instead.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 705b72bf0d83..96d238bfceee 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -757,8 +757,10 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>   	int qr_width, qr_canvas_width, qr_pitch, v_margin;
>   	u8 *qr_image;
>   
> -	if (!font || !stream.workspace)
> +	if (!stream.workspace)
>   		return -ENOMEM;
> +	if (!font)
> +		return -EINVAL;
>   
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   

