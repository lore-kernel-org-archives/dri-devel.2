Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF977C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3591810E901;
	Mon, 20 Jul 2026 12:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yD1e00u2";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4995810E901
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:43:10 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso5514685e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551389; x=1785156189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ESjH1GCvtY8coYnGwrJ73HTXY1BtDBt4KW38hZli5UM=;
 b=yD1e00u2kosmjSAVU4zGoi3Trjcyg2Swcn7JIVmDRQOhBvt6RUTC+LD2fr+rlYyI9U
 RsGUdKZnvmRin60FEY2sCDgA79WXgX0aUqt54Gac70Qn4tdE1AklIXV67NavFECGcQQy
 71RhAHLYru2D79tF3aCQh4nXEi79TTgEHZKfL8TEi2Cm5xnuZZA8ow3nmhh2mHwnKXgi
 2AS05LTX6ku2PaiGofwT8w+mlk6B19hKWv6I24W2IsHXKyphPk9UMJQ5M6PvKxnWNQLg
 0/LkVeuDrWw0Wg/Z2p5i1pv/G5bLFlWAYu2P/ZLo9bdFQ7qoCvu2uRaKnL9JE058oOgt
 iErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551389; x=1785156189;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ESjH1GCvtY8coYnGwrJ73HTXY1BtDBt4KW38hZli5UM=;
 b=Mjkb1nU9URR/LZvSaKNsYywEEXE6RLtu/mZq08T1fa5t2kxmrKBSyYKXPurs4zzzI4
 h3qbxovkURPTA+AreUfxRy3edejLB4c7+Pi4rI+s8FtvOtpcfOp2U2STn98V9pZ9XCjz
 j6xxNiM8/q10Mz8qW1K3q/kmV5oseE1/tzT2xQvemsixbyRodPznh9mBTBV0A2oi3o20
 YwOwl3Hs6KpJqwb7DMHpdSWAtzmTpBhlar2tn3zmEotNnqSZY8CYOP0McgeKFsBqfNjv
 Vc9RoR3sioqn8KuJfnB4oY7cBvqfZkOk+xV0kmCrQvPDT0rvuc8whaaQLf0vy7OELDh5
 p0xQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK21eNHJVWAyvWFzl6HFXo15qofPJh8s/OJSmceOvRud28akOLOSNTB2A9Z8+dW3uEaFKnJ3yzGEA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybZMT9b6B9pnw9+KY+0ETppHZZUDKoEkY/9Kk+WLe6SxHKpCS+
 ozbjX7H3BP3C9m3J7s8tOuw1ECWRR5n+QtqTycdzpaDPVwMaECy1dB9QxChvI0da+yg=
X-Gm-Gg: AfdE7cnROioroXN21mZwXi7s5Dk6bxW5EIgpJ8nTNXt4jXc9Q/6lFle+1nAmIetduZ3
 xY+maGwnoLkf3yRkDcSCGvMvZOCsn9TLe4ui/l7OlBghF7cDtJgZS60oz6KBLMGg84OyN/yberh
 7FZCJxV+sTT4M330+mNWxf/MuFXUiD+1uTwbqpO+LSSzf/eTvME8ZDSZ5IXIY++iwqwKvcQMrE2
 3kciJLhrcSsBDTDqYLgxIRLJPcltMd8s9OnSyleV8SZM5qoOzI5HSyuo9Qbkd1VndHG/LzX/PLO
 4VpgoxE7/AQ/CietjnFVXu6oOIjLzdjCjvViSHtc0mRAYeFNOcTMmMofWDZ6zMCgV1MpUOX9GGM
 36yWOfVkM+7wMy2kHtG5VrxysmjCxMbHcPqG7RW7q+SK+HRrj3zxrahzViT60mBwy7nZK6cV1w6
 HnF5mV37QfAU3+jCFcvTkHiVoidp8oBDEdSj6tpz39Q6R2TWJUIaB9htJc9A==
X-Received: by 2002:a05:600c:8284:b0:495:5d6d:d4f7 with SMTP id
 5b1f17b1804b1-4955d6dd523mr58681785e9.24.1784551388283; 
 Mon, 20 Jul 2026 05:43:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49548e0fcdbsm237666905e9.2.2026.07.20.05.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:43:08 -0700 (PDT)
Message-ID: <ee209ead-2226-4909-8f27-b42d2d205b51@linaro.org>
Date: Mon, 20 Jul 2026 14:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: fix unmet dependency bug for
 DRM_PANEL_HIMAX_HX83121A
To: Julian Braha <julianbraha@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: david@ixit.cz, arnd@arndb.de, jesszhan0024@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260711234230.2236041-1-julianbraha@gmail.com>
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
In-Reply-To: <20260711234230.2236041-1-julianbraha@gmail.com>
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

On 7/12/26 01:42, Julian Braha wrote:
> Currently, DRM_PANEL_HIMAX_HX83121A selects DRM_DISPLAY_DSC_HELPER
> without also ensuring DRM_DISPLAY_HELPER is enabled, causing an unmet
> dependency:
> 
> WARNING: unmet direct dependencies detected for DRM_DISPLAY_DSC_HELPER
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && DRM_DISPLAY_HELPER [=n]
>    Selected by [m]:
>    - DRM_PANEL_HIMAX_HX83121A [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_PANEL [=y] && OF [=y] && DRM_MIPI_DSI [=y] && BACKLIGHT_CLASS_DEVICE [=m]
>    - DRM_PANEL_ILITEK_ILI9882T [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_PANEL [=y] && OF [=y] && DRM_MIPI_DSI [=y] && BACKLIGHT_CLASS_DEVICE [=m]
> 
> Many other DRM_PANEL_* options select DRM_DISPLAY_HELPER when selecting
> DRM_DISPLAY_DSC_HELPER, let's do the same here.
> 
> This unmet dependency bug was found by kconfirm, a static analysis tool
> for Kconfig.
> 
> Fixes: defab7b01e08 ("drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>   drivers/gpu/drm/panel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index cfbfb371bc67..06bfcef35a72 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -253,6 +253,7 @@ config DRM_PANEL_HIMAX_HX83121A
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_HELPER
>   	select DRM_DISPLAY_DSC_HELPER
>   	select DRM_KMS_HELPER
>   	help

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
