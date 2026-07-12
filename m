Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C14C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 00:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59CD10E3DE;
	Sun, 12 Jul 2026 00:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qog412ep";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3440F10E3DE
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 00:29:08 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso20341395e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783816146; x=1784420946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x8SW4fHLISIwyKLeAAxiNrDAkSJdNe2V+SZbFHWNkQQ=;
 b=qog412epjch6JL6SKJsV/cal8lT/svvTNgHXxpU42+sWfpSrxXW3+YmQlaHIGhsjda
 qq0CB8EAhYQAstIcM4qK1zB21LDymNaykc6Kg+T19Cr7Ntkz6dScbpEqm8TQXPJy6TPJ
 H5rhIEEfy04HUKjf2QiP5iDIjvPSEFg7kRNA76RXVdJ/mfyq2aJ2qB+gcp2d48TdJoAR
 BCZ8aocKxI/NCXxX6U8eKNbV4xb8urqc6St1SoeNf3dXBTBWNK0nvj889r0dswbg9Tx6
 1pZKdXEdOUtudssXikPGFIvWhrAuiKGS60Kp3/J9RmllNXSoJQRnjhDXP1XnEuDtavFn
 cu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783816146; x=1784420946;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x8SW4fHLISIwyKLeAAxiNrDAkSJdNe2V+SZbFHWNkQQ=;
 b=ZGJucIK9mCAa2RzQI37YwXCrUP/VGwenFwcPBlvf6HZ5/lRgGcrluTyPUDqhEI6l6I
 TRbTq82V8FP9uTzkvzsgBusS3lOLMufCFnkWPX5oQB1WUdlwrmLGQiq4eAr52dDLEpIS
 ddofdvLIUnCtWkhS5e4oPXiBlMzxCwi405cOgfBEzkZKKxFeVTtFBAqVS9KqH7Xa7jJc
 nMAAOv7z987EWdyQlZLQC3G95bO/LaGzuSpjveeD2Q/GMgc6nulgFAWq75LWe27CL7PO
 l+3hWqfx6I/HAcky2fpY0RVhVXq+H7F7kWe4zZIBmF0eQv1KRHceQUBTXwm7HTvmupH4
 OrjA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rreucgu/SdyHL9p13KBaXJ0wDE+yYT2V+Dy+JhXJ0U+C4BS+wm591KaET3tXNzjWuizrYOvfnpS8vk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZ941XISkwDt7QozfVmsklufeUpyMsMVGe4EeobErvkDYV/8GP
 +GCAlBBDGgyDtYMPYjUgrqe4VLvw6SlXsqlJxcZVI1yNJj6cHvv0UaCKCAIqr8YI2pY=
X-Gm-Gg: AfdE7cm+5pPEUnmEEooZWaBEfcIVDL8ksVSJKHz7O7rCMVclxj4ttX6zoV80v0JNhWf
 9O0ONg9FcvBIIZexaYOB6j2ovA5MPKTO/4Zrq17hK5cP5E4HwEr6IMvsYVqSCd+373p9ukO3JN+
 dKIXzSHZsnWrjl/RmX52WOW3ByMdRI/qYdvLc/ipS4vMBWJWeCPyMN1Y3x11OmV4NJWrV1m6X5C
 pRvvntfDEaezLJ4BMuu3VCPsgXtjFuLuaGbnHSh5rDRAANcdv3a6Bz1XM92iCZLGIydevmBKFBe
 plBPxCKhmRXW8eTpsTTGacuGxn598HhEuJAlJKST81wtbuCn9+8eIPc1uJzcIMkl6s6PEBn011W
 mVPjC0cGnT/UFrtVXCTBCHMPO9d8JQUd6qCElJcbmGOgx8Np22hPTZ9KRM3FU7vDCM711W+W0hN
 wnveo22ov7B9QSCZ0xcZErLzEc36g6fG4ZWqIgSiTi6k5VQxhh23QkRF/zKCuFSx3jLUm1rtwTn
 v1WtGQl
X-Received: by 2002:a05:600c:4f4c:b0:493:f868:d882 with SMTP id
 5b1f17b1804b1-493f87e4a92mr38501015e9.14.1783816146489; 
 Sat, 11 Jul 2026 17:29:06 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccaf1sm439037215e9.2.2026.07.11.17.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2026 17:29:06 -0700 (PDT)
Message-ID: <51a13491-e20a-482e-9c63-6a3f034963f8@gmail.com>
Date: Sun, 12 Jul 2026 01:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: hx83121a: fix unmet dependency for
 DRM_PANEL_ILITEK_ILI9882T
To: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: jesszhan0024@gmail.com, arnd@arndb.de, david@ixit.cz,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260712000823.2315810-1-julianbraha@gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260712000823.2315810-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 7/12/26 01:08, Julian Braha wrote:
> Currently, DRM_PANEL_ILITEK_ILI9882T selects DRM_DISPLAY_DSC_HELPER
> without ensuring DRM_DISPLAY_HELPER is also enabled, causing an unmet
> dependency and build failure.
> 
> Other similar options select DRM_DISPLAY_HELPER, let's do the same here.
> 
> This unmet dependency bug was found by kconfirm, a static analysis tool
> for Kconfig.
> 
> Fixes: defab7b01e08 ("drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/gpu/drm/panel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 06bfcef35a72..103f1d09a989 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -375,6 +375,7 @@ config DRM_PANEL_ILITEK_ILI9882T
>  	depends on OF
>  	depends on DRM_MIPI_DSI
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_HELPER
>  	select DRM_DISPLAY_DSC_HELPER
>  	help
>  	  Say Y if you want to enable support for panels based on the

Sorry all, made a silly mistake here and blamed the wrong commit (same
mistake in commit title).

Sent v2:
https://lore.kernel.org/all/20260712002632.2323484-1-julianbraha@gmail.com/

- Julian Braha
