Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B03F8809B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B9B10E19D;
	Thu, 16 Apr 2026 07:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="f8dOBCRZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4F910E19D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776324665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHAIuyOUVLGp0pH4VVZ3r+5IOx29PhLI6g1Oop+fUG4=;
 b=f8dOBCRZOwPtSK16+h7Kdwz1srJeMZY29IcuJfFe5W7GNEk1liyTC0t0JEHMiYGcaaLYNf
 elbJiw1YpV43JY1aU9zNLgwsi9LXAyX/ZW+We0Rb1CpfCpY6w062S39WWPap0mOIJS9BHu
 vAVbk4jrY5t7PXbXo9mjGXgt216q37s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Eitq3vq9P0OrGkdiSLjTcQ-1; Thu, 16 Apr 2026 03:31:03 -0400
X-MC-Unique: Eitq3vq9P0OrGkdiSLjTcQ-1
X-Mimecast-MFC-AGG-ID: Eitq3vq9P0OrGkdiSLjTcQ_1776324662
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488d6ebe9cfso51761335e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324662; x=1776929462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZHAIuyOUVLGp0pH4VVZ3r+5IOx29PhLI6g1Oop+fUG4=;
 b=XY+rxkCxHMHjrwPAulQUeL+51WsaTcK+Y7AwBqeGIxTuOZc4nI1bnw8HUpCUSkzU2r
 LYwJlwDlkLIoPkvOYxCC+KPYnx0oSf/HDLDAQBsxYeSwmbA2cPN68nSrVywIqGT6wOAx
 IZfAdVtivQx358XVdkwYpvFB7pAEIW1SCF6Vi4Ry6NRJwnATGEi0Re15y3Sg0lzxm5tE
 DwK/fAgm+/ZuYZsc127JZM3EIOs1iZRoxoxNsB8PHAuX9u8UnucGjqR799IWNrqa+qs1
 vuwWNVAv/LoHfjT5dZ53sUMI4TplmPfOnwvEXqvDPpLpZNCkq5BeEJ8JEQJLCSLhYhtL
 QESw==
X-Gm-Message-State: AOJu0Yw+2Q5s51NdTSecMiopHDoXkrPjtwcUFK4JbwZScCvfoAdRbxeW
 BUAsaQ4cuNxpyUypq1lPLGNfckNk090LDn8Y98hm1WoBYGgqMfbVgEwAvY2m6GOjn6GkBQ8uBRQ
 A69IW9YfvvvgpNkg4jEnOWcMevRTq5TdZMfum3ShkEi+cnwOoWFVC5/ir4zfMIr7qNG+TWg==
X-Gm-Gg: AeBDiesJ/Y1cL5fuTm+8gI9B+1ZM8It5+4tJGklLDQ+Ex2SIo/LATqSAFyOJTLwQ7ub
 LwWqOrSI5yrsNWIiRE8LMC+xI++6MEzc17PwANPZJJ0Zk5DbtzmIbi/yb8175XjYV1RSw1kvs5d
 7BbL3VuUIekVY5lEPd7n9XY+lhceuEp8/3I71Xf6mXUqm9MZZptn7FLvBuMuAumdZKNLPGoYqKL
 7JYyrDo0PRsEdh/8R/y/hJRtcm0qX06smc0jGOUwSNYJZtYX8BkUA2VmJoakFgXnkbv6MvxZqTb
 MdljLIlaA5h3lblmacyEoTQqn6W7VfVdR1p/fthX/qPswnemtCwlIuTQcAfuOgzOlM8RdAnkbOJ
 bebFPCe/05f18HARHJxTXSsR999CnuyIqU+CM2tL1Isimc1JwCBNFRr2HO5H7Xg==
X-Received: by 2002:a05:600c:c0da:b0:488:b187:d898 with SMTP id
 5b1f17b1804b1-488d685b6e8mr297099265e9.14.1776324662454; 
 Thu, 16 Apr 2026 00:31:02 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:488:b187:d898 with SMTP id
 5b1f17b1804b1-488d685b6e8mr297098875e9.14.1776324661940; 
 Thu, 16 Apr 2026 00:31:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0943698sm39949465e9.4.2026.04.16.00.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:31:01 -0700 (PDT)
Message-ID: <19db7374-69e5-4097-a93d-4b796b13f9aa@redhat.com>
Date: Thu, 16 Apr 2026 09:30:58 +0200
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
X-Mimecast-MFC-PROC-ID: r_7TSMDcO_2lEbD7I-hwQnGtSYtIscIwwepKv-B0TvY_1776324662
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
> 

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

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

