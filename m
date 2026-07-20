Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4696C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F72B10E8EA;
	Mon, 20 Jul 2026 12:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rhtRAT2F";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8523710E8EA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:42:51 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so19006085e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551370; x=1785156170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dUJrbWnJ/YH4nNp6x4h2d5WcOCHjt0+QMYeRHAuv280=;
 b=rhtRAT2FGmCtDVMliPGjaolYJ50knekTpV+nQXJtUxRmL/eqYcxcYhSHGcBxXYecBJ
 2/N4fOdJ0M/z1oJ1Q80hJ7y3u6SkWoTAcUljfOTbVnakYNawTcmmwZpWvZxf5bxrep86
 3N+Nu/5wRd3OAX+SU77p7lsE/xrR1Oej9vIsnDHhU67YuX1NeLepvCRA+WEd4ckXRxVM
 jM0P92iL0JUdN519Tz5/2LkXBYjbzTqhhtzVWtW1AZwPupNC9UYRmWYPYWVb1Tzn8tZk
 2rNBaB2qxyq37glueZD5GU3X1gxUeIwm6HlAlKMJ8GclO1KXIGlNThCOHsrgDmRt7cbY
 EjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551370; x=1785156170;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dUJrbWnJ/YH4nNp6x4h2d5WcOCHjt0+QMYeRHAuv280=;
 b=HI2ajchPDQqLE4ujUIoA9NwiHNsl6LZamEJ94qImQuL0j7yRUsugEhga7uTJr3SbfW
 rEcIOQ0sxi9uunvzDxbraBl6KZbDWd80oA/MKnDzpWskk96i25TIhCXmZbq0a48av7Lu
 8sKry3zturr9tZpkP/8m0kywNzr/0iiDObzMmeVErZu0gBlnmLir4w8Ux6cUwckucWN7
 V1d47XAFqhglx6hv+JR5xQCtEQtlSP0WqxR/bAQRD6fmbAy9Pjn5ucVrbxWqxznSdKJM
 oC/d7tEFd4d8LZjHrUyofhpUvNY8JT7BvEWE9UgxM2ZEmZMyPIXFlETzwZKAzftfzCSK
 RzMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnpbHsRN7++46EnqllhxpYMEyi39dykQmvwJ4F8CJ6n1NxmYIhx1hytsNCwvD+sQd7jh4E4eXAtxw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywp7XbeQfPl1+mvCnpQW7PxllZec1k2bse/3mTmQ6zloytGiIou
 /MO191bkUAjopR1QfdasxgiO1Vi8MgBMj+8vnPEL6tmHukdBKsXx1DrEn1g7E77Ky/E=
X-Gm-Gg: AfdE7ckbMRRB59WaFmKZ8TmFsjg1WnvDm96HUwVGl64cruZxJBawcXiD79HGMPWPtZg
 cArI9VKb2dwVrmX3OAAxSLky5cCTp0udQLFzD9x84jnwjg66OTAInBkEf3tpJm5LDTwHYirANBu
 JCnU8vHW8Luco85/AQXP2mzpo2VsW9bTj++fG+6FLEWWpJKjh+c3ebF0EqlRf+BMW+LhBJtDtOe
 H28v/JnNTziwGUf8s4qB44fAcA497KtElcC8dPsI1cr+QPMlr3cnrSZ0YCjidaCWbCcx9vJ4CbG
 LC0M4CngnY6K4lIVE93YK5T75GewU/3J2HmN3OfB/yCwxKUhMtO9r7MRpM2NOVWiqrb3fiJb5hW
 Fk4e3xqFA0gJxiWmZGgjEbPve1WaucQfTEFzxvJYX1P9dE2WGfpSAMJRNWWdJDzXCaXJkKwJ1lC
 7p0A2wBqJUfQP0ESMs9Ik33J4kv102984/9UvtRMDygdfV8OWa++KFPBhN5Q==
X-Received: by 2002:a05:600c:1382:b0:495:3f48:5df2 with SMTP id
 5b1f17b1804b1-4954a40bcf6mr144955205e9.29.1784551369766; 
 Mon, 20 Jul 2026 05:42:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955fc42db7sm59736375e9.3.2026.07.20.05.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:42:49 -0700 (PDT)
Message-ID: <39985a2f-55b6-4caf-a24b-cf2d5e5e19e4@linaro.org>
Date: Mon, 20 Jul 2026 14:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/panel: ilitek-ili9882t: fix unmet dependency for
 DRM_PANEL_ILITEK_ILI9882T
To: Julian Braha <julianbraha@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: jesszhan0024@gmail.com, mcanal@igalia.com, arnd@arndb.de,
 nicolas.frattaroli@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260712002632.2323484-1-julianbraha@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260712002632.2323484-1-julianbraha@gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 7/12/26 02:26, Julian Braha wrote:
> Currently, DRM_PANEL_ILITEK_ILI9882T selects DRM_DISPLAY_DSC_HELPER
> without ensuring DRM_DISPLAY_HELPER is also enabled, causing an unmet
> dependency and build failure.
> 
> Other similar options select DRM_DISPLAY_HELPER, let's do the same here.
> 
> This unmet dependency bug was found by kconfirm, a static analysis tool
> for Kconfig.
> 
> Fixes: 68e28facbc8a ("drm/panel: ilitek-ili9882t: Select DRM_DISPLAY_DSC_HELPER")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> Changes since v1: fixed commit blame and commit title
> Link: https://lore.kernel.org/all/20260712001541.3AAC01F000E9@smtp.kernel.org/
> ---
>   drivers/gpu/drm/panel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 06bfcef35a72..103f1d09a989 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -375,6 +375,7 @@ config DRM_PANEL_ILITEK_ILI9882T
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_HELPER
>   	select DRM_DISPLAY_DSC_HELPER
>   	help
>   	  Say Y if you want to enable support for panels based on the

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
