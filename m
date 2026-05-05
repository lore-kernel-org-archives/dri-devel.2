Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819FFFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E5410EAFA;
	Tue,  5 May 2026 14:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cQTXldwU";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7FD10EAFE
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:05:38 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so35832695e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777989937; x=1778594737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TCALrW+jkDBTQCfL5/6VyhLVaULT1T9fxashhw+xhlg=;
 b=cQTXldwUZ3LLne4Z2bv69qJZ9TtnPtUzpaYqi3PATrGhLua/mhHEtOH+um8mEKX2ek
 WIG+eWat4Odf86xhGmdIPcSXYY92/KCbOboirWDYhdG4jLmqOPVCu6OjkqPY9N1ZA5vK
 ZFqksC3mSMDvoeH3WJQM9+ZOW0lHFXpdvHONiCss0Kf2QNEpKFh9cQlPDbInEbMuPd1C
 5nF9+9y8s9bW/vWlfk8pwujTXD7u5rYpUSd7EDo7Yt1CijOrAdqFy+Fi15vhMji3NU9g
 8HG+fRxVwvfCU89n/fZVqB823khv3Z/kw9+KQoQwBuL6fqsU5/de0CVyJMzf5XBzRvyg
 Eqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989937; x=1778594737;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCALrW+jkDBTQCfL5/6VyhLVaULT1T9fxashhw+xhlg=;
 b=QdZwSS8eScrFNx00D/oyn15tvId3kJeHtY5s8E1Q3lUnF0il5dDtMME8px956LGMJP
 eRjItWgX78hwX3Sgrp76hnEGKjk3qnh48QRVvI5tTXkIcZJqRcF5zltsLlMga9rjutzT
 66rG6RSGkrurWDCvKO5Y1nDyfwppPmajHHSoghyQ+jcTjRNw6k9gLbSi8WujGj9UrkAC
 towIR9ZaFiENdS+GunDe94kxy8DeIqM+4iAcVOwjnTo91mQEF6YWLCrjyu76IalwCoFI
 56GGiLs8DC3U5RxxAw5lxOTPUzah/sDCtekOQ4s8B40QDpzKK6Kzf3stspu+0Ji+Rljx
 MecQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KbIiM7N4w+YGmVdoXWkFi+suY4rKiTsNTOjCVcd7KLDc+kCHXggBeQDgSDjjulFWSO2uiyBaoiKY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOFOiLQrltSpV/fU8Dd0T6/daUcnwOfdzKYF2AXr2zGXeQxzpt
 5677+3XOYvi7GWQLCUrpiSlPzWzDVSqkD66Wh22tWTrPGspx61wWp9ntivBCmixgBfI=
X-Gm-Gg: AeBDiesNDBgVFQcts3FUlrAVwcQEVKfeoLIpaL+loQhSrIwWhNxIdzM1BKYPBpfM4/C
 i/cNaXdYRqk57Dcnt+GNXZf/ZQe5rw+Bgq22KCM3dvXTnVf8kj0XSALhtnjBBaEcWZTC0sRiRzo
 IPaBs5/hMbBrqMFwurdPQBpHITi2OgOHlBAV3FgaEahKj3ghSuINVnx3oZvOXljQaaSpgOb7MpR
 FI1yl0MTMtlZDvFF1AEyrD4l7VO5dzFNfELy2f17o+tF1dBteRdIfPL0DereSMX28oP7aP59px9
 sVQ77DvX/Xu/IvY1dO72ka7Rre5IQv/zqK25gHVvPMULnMKafMiAM9onFk8nthb1gOjemvD/qH3
 J8BOz06Tkt8emoyszcR9AxB6jprkI5IuOM5T87EuvSNuuwjshNMIfjRqWeiW6JZ7LCFNj0rgi4T
 LMwCOAcYx34oRfFxKmGStuJPYl9PWCO8LIsDFcI+X8lUEtvGr2PbjMGzMNm4Zc8xViTfeKDWuiw
 GW+SVq2O671nbH8Yw==
X-Received: by 2002:a05:600c:c096:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48d142331dcmr44454925e9.4.1777989935571; 
 Tue, 05 May 2026 07:05:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:19a4:dd04:854d:9f82?
 ([2a01:e0a:106d:1080:19a4:dd04:854d:9f82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055e2d3d0sm4638311f8f.34.2026.05.05.07.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 07:05:34 -0700 (PDT)
Message-ID: <9cd1fec7-347a-4961-89b2-f1af4ad46958@linaro.org>
Date: Tue, 5 May 2026 16:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for LT8912B DRM HDMI bridge
To: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Adrien Grassein <adrien.grassein@gmail.com>
References: <20260430085344.34271-1-francesco@dolcini.it>
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
In-Reply-To: <20260430085344.34271-1-francesco@dolcini.it>
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

On 4/30/26 10:53, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Update the maintainer from Adrien to Francesco.  Adrien is not
> interested in maintaining this driver anymore, Francesco has access to
> various hardware devices using this component and the vendor
> documentation.
> 
> Cc: Adrien Grassein <adrien.grassein@gmail.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..bcfb13b612bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15019,7 +15019,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
>   F:	drivers/hid/hid-lg-g15.c
>   
>   LONTIUM LT8912B MIPI TO HDMI BRIDGE
> -M:	Adrien Grassein <adrien.grassein@gmail.com>
> +M:	Francesco Dolcini <francesco@dolcini.it>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
>   F:	drivers/gpu/drm/bridge/lontium-lt8912b.c

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
