Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F85EEBFD1F
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203F610E36A;
	Mon, 13 Apr 2026 08:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BY6iOuMC";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF2810E361
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:03:01 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so2145450f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776067379; x=1776672179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=0EL1EQvZHdWARRYaFUCW4ZvmaW6seLP6nVFLhCjfX20=;
 b=BY6iOuMCSoG0Tx1JiqUzPEAwc7uT6I7w4I0p7ZQHntahe4XC5LkZoPGwga5+mqn90U
 pXgDsZp1AOmEGyawpJVf0gXqYngQ9bQMDnp4q03z4jC3dkEvT+nYXDd0ibd7lQq2GvxI
 +QoH4eBpNWAeY+ClN2zDswfVw2vtiD8fnjyI6REg0W2+Vnzkua+JWUqkLVOpQ5gB81TD
 pTduNMTsmcCoMgHPLzii3y9p3H7Xh8afyHUKTHC5OpyB/9HnhCKqYmGTn+MwrlddtHTh
 hkQspsLKSJdo4dm5tdmt/oKM2b5DrZSFtldEqh4XqdhugENnv9sQF2CdiknT1ravD5LA
 47zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776067379; x=1776672179;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EL1EQvZHdWARRYaFUCW4ZvmaW6seLP6nVFLhCjfX20=;
 b=PTpvdtrhukvSFeiRraLnkJMnx6i7CKsj7E3/f20MUBBIa1/ikb8qU58oNizYDlDbVo
 7pft3SL0tHQ8Tfm5yflytxxg6/I/w8ci/yvcEk50hBQpWCgSlVOyS827dHWGlBiLhSXC
 iEOMRNXWOyzl57vYLYAAx6UlGbbO4f866rlGt3d0EpnPTs0i1PLMyUHtwnduWkZTcN0y
 sfz6AroKFRMy6HrvNRv15eYij8Jt5HVlhL38i4Ud9+wZZ+3Zs0A7fdplZayIIor09bvr
 DRLs06iOh1VV9n+0rzNy/YrM6G6oi/Dyd9bxRHuDo3KGw2R11Qa0ogpickYmC0cGe9xv
 Vong==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sNpPWoghUw4DS0utfHqRk48KjO0yU3UGPLAqbiUAF07+Bho8I/X3gNG0yvPpwe3WW49yVoG05g0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywmr47UEzU3E1PNKUEAdumIokB2eUr34J4khlDhgk5VFRTZn2tW
 DZ3HNG2qcix0ti5hpFLiykCEUxKedwP2fK7FZB4XB4Gck3yeWV1dLhCzMMpXnpbFb/8=
X-Gm-Gg: AeBDievS3Tff/HesgqyKpvJ3S4aC2vplW8xwNRMas76Ug5gIi8D7AiPQacxGwKS4Uq9
 nb3O/c0XneHr6d56iMoWEhHs2yk1fq3AacGgnjH6M+/O9h1P5LYl4ur/1LC+NuWCRGg+S7m2X2s
 xeYEROhpD9S6E+xDdTjVU+Y6hW/eX2e6PX3htIysulu4XTmbcLZydc4xKH87Jz5w7B+irjrFWUV
 jSuexdOSUdtfBtrVzpm0SQvDpcp1/hiC6JadYqBqz3T1nKadZznS/Hbts2LNl/kpawJ4RTnZZYR
 EYCclMtBYa3Ab5DLLFWXEjQBVI0pMj4RWQ1Pq6QQf6zbdBPBAQ5iVSSGp4CpYvAwyx3m1TKQMYU
 7dIklf8guEDaWdH3beCqtvDQVG17XTxNwFASTJySr7Vx5fFfIp6VQn8xekIAGqjVajbmeQfrKfI
 PoqXF1anwcDIb20rtPjj3vFfM+bbPRrSljSVfBtQo/m3YleaaC7VsQ78BnZDtDvGPz4Ouea2+rX
 AKK7zW8
X-Received: by 2002:adf:cc8b:0:b0:43d:677c:afb0 with SMTP id
 ffacd0b85a97d-43d677cb0demr11008109f8f.2.1776067378098; 
 Mon, 13 Apr 2026 01:02:58 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25?
 ([2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7bd2f237sm3141182f8f.23.2026.04.13.01.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:02:57 -0700 (PDT)
Message-ID: <97afc59f-0552-4faa-913f-592c09c31141@linaro.org>
Date: Mon, 13 Apr 2026 10:02:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER
To: Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pengyu Luo <mitltlatltl@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, David Heidelberg <david@ixit.cz>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260413071043.3829868-1-arnd@kernel.org>
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
In-Reply-To: <20260413071043.3829868-1-arnd@kernel.org>
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

On 4/13/26 09:10, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Like a number of other panel drivers, this newly merged driver
> needs DRM_DISPLAY_DSC_HELPER to be enabled:
> 
> arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-himax-hx83121a.o: in function `himax_prepare':
> panel-himax-hx83121a.c:(.text+0x1024): undefined reference to `drm_dsc_pps_payload_pack'
> 
> Fixes: a7c61963b727 ("drm/panel: Add Himax HX83121A panel driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/panel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index cc8c8a066bb9..ce6098c0343a 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -208,6 +208,7 @@ config DRM_PANEL_HIMAX_HX83121A
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
>   	select DRM_KMS_HELPER
>   	help
>   	  Say Y here if you want to enable support for Himax HX83121A-based

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
