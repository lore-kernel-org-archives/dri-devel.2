Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA56C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AC310E8FF;
	Mon, 20 Jul 2026 12:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DSOCD90X";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93A510E8FF
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:43:00 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f73b1ee02so158349f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551379; x=1785156179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N3kX3OEge1gQoBB0YkXusbtO0wNpHnuHmhGnIKL5BX0=;
 b=DSOCD90XTD4HSVycxJaxPH7vZIm1Lq/HrpnAKshvolNYPSSBFx+wjpF82S+ATvPz1U
 sWXCvyxcqdkhlJ3ckV8n3Ajg1YC7Ce6l+PmBa4/qcL0208Boi9vSPSj/SrylDONavLDG
 x/lmBGznWtxLcHUFKuTSI5F7NpSuAG9CvQOqEexrM5i/+vxCARNwI7cP7Qub05YHhKNI
 GV9oMufOEUGbVD2c/7OAJw/Jop4cw9NU/u4u0ulr0PfU0XyIVpZzrtCyfg46xz4a/7mO
 drikLX9o/XRImVxtv5lVOqqoOd0F8YmM1b8BHPzvll4XqvJt/3ksERy3IJx1gnrJpxlc
 WWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551379; x=1785156179;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N3kX3OEge1gQoBB0YkXusbtO0wNpHnuHmhGnIKL5BX0=;
 b=GMhpS6n5z5hHD38hazsedC/14PCTtSjuHvB5bf2DbukrQKVnLuhHvQ/3Rq0qGscgSe
 coGOPKyvzFsmJ3Cgahcs0gugaoVokUFNxrQ2mQt6SsscBj/MVRtK5IN7brjMMhSUaCMg
 YRhBlKieaYjlc3eN+vw8kUlXykUvEyVWW0vE/OMXloSNNWn5w+KyUlYkooJnnq78BhwW
 RxJOaFn+3CHmVWju+bDrfbxMeXgDS6ShiHvWG6plr6jg4BFEG49wwUzjylJgRgHq+xuv
 Ehr8Fyq6hSpqnAbJ6lTtG9EUYxSTipwxiaAJIwAnjB1e9NN/DifJ4RwUltbnQXAQ24YK
 v/EA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMKC4Iy9fFj+wvFwpuIVILY6FZ0eWxjedXTsE2do+VSSYlwpTczn7P6NzIUkrSxF1+mKQIOJRhigE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWFwYBIWfgrI8V4a2aXQ8JfdjvW++LoXrH/FxGP41WIExKTtGk
 ZJlemunHeBQ/sVO7JkvvMiXXvhAiHuHaIgCAt0MF+FxBtyNCYjsy4XMgC5tkVAgzTkE=
X-Gm-Gg: AfdE7clFNlyb9Mn8ox/MeLqxBf0c0710hU5Q6wuDYXiw27L9D8hwNTgPD3DTCuHiJRC
 vQ8Ac/9ICTkGKY7JDzMfVHu6tehNvUa3kt4fOeu4MMghrQ4JUTgZEkImzQiOIdAgCyQ82vH0s2s
 80dKkGFP67zeKqz2/NF4Q7vsQn1XCZDdShw390eHZD+m8iUD+zKwCD1KcKG0DaTVMZHK+ZOQvcK
 +h8LhcmTBt0ViekIn87EgiRYonFE+RMCsICmQ1KAWi5d/QQDlm48r6by1jaV6UV+bm9FChxDk2W
 I2WYL5SL4c+5hpJ89IqBYJ8oTZakiaYEpUciuXwgo2+PhB2+pfeGBuegS8alaHO60H/AsT3c6Vi
 R1mlI9lQPovZCoe8Fw4aCKVEaU6+MZc1kwJnDBn3tXS80Y4hd85h8XwsRCSHxdug4XzyjhMnkhJ
 spAb6EH+S/BZ0NHT61JJsmgtEtHtyJMDyjfSjY4fvC1+Ru60aAX+37sep9tc+YMof85ove
X-Received: by 2002:a05:600c:5246:b0:495:6482:9d8c with SMTP id
 5b1f17b1804b1-49564829df7mr1293565e9.37.1784551379197; 
 Mon, 20 Jul 2026 05:42:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a47e64sm293554665e9.8.2026.07.20.05.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:42:58 -0700 (PDT)
Message-ID: <c68fe103-8a7b-4568-a29c-0a222a30fc48@linaro.org>
Date: Mon, 20 Jul 2026 14:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: s6e3ha8: fix unmet dependency on
 DRM_DISPLAY_HELPER
To: Julian Braha <julianbraha@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: jesszhan0024@gmail.com, arnd@arndb.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260712001514.2318597-1-julianbraha@gmail.com>
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
In-Reply-To: <20260712001514.2318597-1-julianbraha@gmail.com>
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

On 7/12/26 02:15, Julian Braha wrote:
> Currently, DRM_PANEL_SAMSUNG_S6E3HA8 selects DRM_DISPLAY_DSC_HELPER
> without ensuring its dependency, DRM_DISPLAY_HELPER, is enabled,
> causing an unmet dependency.
> 
> Let's select DRM_DISPLAY_HELPER as other similar options do.
> 
> This unmet dependency bug was found by kconfirm, a static analysis tool
> for Kconfig.
> 
> Fixes: fd3b2c5f40a1 ("drm/panel: s6e3ha8: select CONFIG_DRM_DISPLAY_DSC_HELPER")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>   drivers/gpu/drm/panel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 103f1d09a989..ecff57ceeef1 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1010,6 +1010,7 @@ config DRM_PANEL_SAMSUNG_S6E3HA8
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_HELPER
>   	select DRM_DISPLAY_DSC_HELPER
>   	help
>   	  Say Y or M here if you want to enable support for the

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
