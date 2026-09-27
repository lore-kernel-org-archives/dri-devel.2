Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39FBC9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 22:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E20A10E055;
	Sun, 27 Sep 2026 22:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jyUH0t3E";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323FC10E055
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 22:52:17 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so1521925f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790549535; x=1791154335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TArekN18j9E29AsGV4AT/276CAexcJWhfmYRYuZpdI4=;
 b=jyUH0t3E2vGcX6VUDfA1HNm4GLdKmKGT1zgGLHY0/kpESXk+L7RmozlLDDq9S6gXvv
 rxy+W6kBHHILCOOzgmBzY6gAwMUP8AvlUMLofzoZxHWDnKv5PokbUrvfsVyONGQeV3ht
 MDQzOVHcljhnirP5DzV0VSjVMywKyIgXuMBw2qNhOHTJfER2tPRhBhsza62yozPF8oYT
 XRJt/B+mfwdiksH3/e5zpaGv9+5Vlh7+w7twOvuAozziy+d9dU567dChKPI+619Whb9V
 k/gZdXaqAh3hrl0/750pNrWjvnzaQgytyCr1Escp9nxuQmxCJmeoWtnzJTZRlLCrCfBv
 wYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790549535; x=1791154335;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TArekN18j9E29AsGV4AT/276CAexcJWhfmYRYuZpdI4=;
 b=aetIIZW63NP+QosfepFI1IGTU3I2n7EwJ/ROZCJhkn83HZNOwDmLUwBsR/RLTDL8Xb
 iomU40q4SAdNBDyuPKGHQyUmsr1Ewt07FOPoNUYpL33GK9JzoGeK/MYmAkw22Bk2ufuQ
 fLoBD4no8EerpR5K6yzVEOGgrhU5qlw8qmpcJoVoFWdOlc2AUUy3feYDBcouI7KubuPA
 3ELyjqXaDM11yhd4oM/c1XvwNAtk2s6YQlJQT+W39QKd6MC+2iyxkduVU6BXVOnlSXVi
 UMxrC8tibm078T8o8wQoQclGgqH+QBAPXFPS0osp0B0EsVLWKXDYnuDP5idraF4+ILdo
 WMdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoKLShLPiZ07BdyUjDUh1+pkMP70uDX6gTJZFkmYrK/8ChdaUfAiKf9gbjHq9/Xpyauxb1oUWonSM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLqGS7Z61U8e5MzgOfh/9WiwSwZf8C9L8VnJSfEHRuf3WWNKFaT
 DqAmewWtE8KHt1dKShamVWQ7HrbC7qdHas6tGAWnChisHLYGPrthvzkh9GlqSqJdqvQ=
X-Gm-Gg: AYBFou2z73ApCDn6cWFM0FaTdYEAL0WxDJEIHIhK6RM4lwJM/rfXqmhd2kOtUvZrgQD
 +QyRZh4rdyvLKYE5pOnuDVyH+YQEei8JO6H8WgK751DUra8Hj54LpKoYB+DFsfY6aUCyQmWg0o5
 xmP/W8KqHz/FnoNVUFuAfrDM3J5qTtafrkG/zmT6IfbWNJTvEvRocBeel/67UapUeoxBh43p14n
 NQZBe+vXU6XpbCoqbrxCItTOaVIfUvGC/ubWC4ebO7aPQk1kbgHeyS05rW4mMk5UXrlNBhKMVnL
 3UGFn3aHoS9hv9rX9ZJKjdOUiaKdZVDE95qpV+fMuDYGsNg0I6D57fgom0b8t9iLgHaJWqPg493
 ZuW1fh6iGQslCcnW42BPGF1B7Oj+fPuPgCZS07gkhAykciP+MIqv0BA/U5kZ7FA2yL2ZFLoh19A
 DNoB1PL3JNi66mJThwAE/iCAN2+hZlBifoHt4qkqPZstedKhz92EOPXet6eydejG9B0xaBXvAmj
 MWv9APVqG0tBADwiQ==
X-Received: by 2002:a05:6000:26d1:b0:487:8ec:1fc with SMTP id
 ffacd0b85a97d-4887d9fa635mr13779101f8f.12.1790549535472; 
 Sun, 27 Sep 2026 15:52:15 -0700 (PDT)
Received: from [172.20.10.3] ([37.168.29.21]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm23314402f8f.12.2026.09.27.15.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 15:52:15 -0700 (PDT)
Message-ID: <fc3da38f-0816-4639-b26b-bcf3a2dda0e6@linaro.org>
Date: Mon, 28 Sep 2026 00:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: fix novatek-nt36536 dependencies
To: Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pengyu Luo <mitltlatltl@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 David Heidelberg <david@ixit.cz>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Julian Braha <julianbraha@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Teguh Sobirin <teguh@sobir.in>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260925130125.3897046-1-arnd@kernel.org>
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
In-Reply-To: <20260925130125.3897046-1-arnd@kernel.org>
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

On 9/25/26 15:01, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The recently added driver requires access to DSC helper code
> and fails to link without that:
> 
> ld.lld: error: undefined symbol: drm_dsc_pps_payload_pack
>>>> referenced by panel-novatek-nt36536.c:109 (/home/arnd/arm-soc/drivers/gpu/drm/panel/panel-novatek-nt36536.c:109)
>>>>                drivers/gpu/drm/panel/panel-novatek-nt36536.o:(novatek_prepare) in archive vmlinux.a
> 
> Add the usual Kconfig dependency.
> 
> Fixes: 75a5dbd1f4f7 ("drm/panel: Add Novatek NT36536 panel driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/panel/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 6874752a1901..8bf7911d2a0e 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -694,6 +694,8 @@ config DRM_PANEL_NOVATEK_NT36536
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
> +	select DRM_DISPLAY_HELPER
>   	select DRM_KMS_HELPER
>   	help
>   	  Say Y here if you want to enable support for Novatek NT36536-based

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
