Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8F6106F301
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 355C210E29E;
	Thu, 26 Mar 2026 08:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CuMX6tf7";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783F610E29E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:33:50 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso6857665e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774514029; x=1775118829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=LlFbzvdK/QjehwI/ahd2UAunEZQRZ3Ftqd+hlVRhyxA=;
 b=CuMX6tf7+Adi8Bfqakp/EC//8rZzk/oFL6y6bM8j0RfG/ZsOHcTyUWER6efARrlh9J
 j+Nvmz78RuMw/hAyh9uHSTnElaunrTKvbirPUZWEe+s+dZGlrvwfrxKHo5kJZ/xKF6M7
 yG7bfua79qCwYsgn1INSLFQuDsrsguHSSjpUkBRpvqlbDlfiJaorsehiEAW0ETWwvxnS
 yRRioY09EncZIw2d9NlDgvLRM5z3PEuBfvqPBO5yc44CYFi7ZKp08TyMpCTO2V6FZM2v
 A9axRJJLUxrgK6T0fQ//w4Yr5ZC7TkCkVbozrYwlhXFQbEF0e14RxZzSzjQcIhnfzplO
 tu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774514029; x=1775118829;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlFbzvdK/QjehwI/ahd2UAunEZQRZ3Ftqd+hlVRhyxA=;
 b=nSfk/zQqIsowIyv5qGj7mgeOlq7BWBcStr96V0qIg+13YYD9Mvi7k2iV8of6PHUxwv
 XrBH4F07MvGWMl1YSdfPy5RWECTNB5TKDSChIuNgJDqqScxoIxtOjt9JdMHvr9+saLd/
 uOfYNc3KiZYiCdc+WYrJ+NKqMOULYQpb7U5AYZopXGKTRyZK0bjYbGhwyIQ3O6v0Flqs
 L2MoctiisP+PEcGgyHQ8Jo37Fm9YT6rBStdoYKt/UtqymaRnD0rUx4If6UHXpnKHgmg/
 RnnAThEqNaILaFjNwaZgnSIDjGMVkWyfI3E5V5X6GwPvfF6e3agRCmNHiDQM5S0iyxby
 fT4Q==
X-Gm-Message-State: AOJu0Yws4EXkNp9rOrciP43lQTd2ADZbkFOvCmTnf1bW7XLc+qG75kYV
 pSonkoMNHCNPGV7fG5CPQQKXuTy9gmkmcGXPB09k4L02ELwHMBXZAjXmmLnjx51yJZM=
X-Gm-Gg: ATEYQzzuhfZjexOszI/Jl0TSZSHGgUMCXTl/9G8B/9mJ/u6u63VhjPMr76eX2eW4z2U
 s95GrReqHcqbZr/bkuEfBVvb0944MmBBxzRkEMWwLCDoy/MixMN5JT8zNoufFCPJwQIYgaeP3WL
 LT57GojwnlcepjsMppk5YvUhTaK7ZvplrFdKkNeQbz4na10Bktg9fyEf9+TszYZdYXYHetI0EeF
 UsM+qZQ4dtvzNu/Z0gQbWTB3jsdzNwvZmUo9Fc254ZtT5sN30cfjltt2OUcr8L3fC/m7v4BWUep
 Xzk/p/ydrobbpiChVft3sYVw5RPBNQWgdDSSZpiXhIfudVfC+45buioUx60ihruFg+7dotYKjUO
 Ig2TMHzHsdW49WzMBs93tvuhN2kX+IeaI3/KJMZV2dvdipWP7z5XDXETHHUkEEC/53wVDC8IiR4
 65IACRIKcFz6ccXgCE6S+IZdLjNe08GfiuXVrQxdH5P3Vs+QANUraL5MUF8xOPsuudJliLjWKxd
 bXYlE8gyvLAsMiJ3g==
X-Received: by 2002:a05:600c:4ed0:b0:487:288:1199 with SMTP id
 5b1f17b1804b1-487160934dcmr99014245e9.28.1774514028792; 
 Thu, 26 Mar 2026 01:33:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d?
 ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722be608bsm20860305e9.0.2026.03.26.01.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 01:33:48 -0700 (PDT)
Message-ID: <3827b0ab-69c7-4e46-b1fb-a9fa99399299@linaro.org>
Date: Thu, 26 Mar 2026 09:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add Tianma TM050RDH03 panel
To: Liu Ying <victor.liu@nxp.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227-tianma-tm050rdh03-v1-0-cab78a0d765d@nxp.com>
 <20260227-tianma-tm050rdh03-v1-2-cab78a0d765d@nxp.com>
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
In-Reply-To: <20260227-tianma-tm050rdh03-v1-2-cab78a0d765d@nxp.com>
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

On 2/27/26 10:31, Liu Ying wrote:
> Add the Tianma Micro-electronics TM050RDH03 5.0" WVGA TFT LCD panel.
> 
> Reuse panel ontat,kd50g21-40nt-a1's panel description as they are
> identical.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index e5fc9b072404..af84a90015fe 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -5519,6 +5519,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "tianma,p0700wxf1mbaa",
>   		.data = &tianma_p0700wxf1mbaa,
> +	}, {
> +		.compatible = "tianma,tm050rdh03",
> +		.data = &ontat_kd50g21_40nt_a1,
>   	}, {
>   		.compatible = "tianma,tm070jdhg30",
>   		.data = &tianma_tm070jdhg30,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
