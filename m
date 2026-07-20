Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5398C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1594A10E8FE;
	Mon, 20 Jul 2026 12:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iTc2SbYZ";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D4010E8EA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:42:29 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so42677125e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551348; x=1785156148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ooN4hbOmEpkDX9Z1ak2r9GWUVz4HFV5LKddUy5dwh9w=;
 b=iTc2SbYZXaCCXBQKwIA2TnfJBef7mL1Omssx7z1VKcr+SfCqfbiK2/NbBiDl1Prg4K
 x8dR1RmPjc/MfbBzcDW3g9lrgQ2/oo0hOcH8Fte45GYmML0h9H8LopDV4SKIwM9VOt5N
 jjqCIvMcp9eFLqSF1vmH4Vo1r8zMk/U1S7XSuV+VYY+2kqY6l1zzBFYV4J3sTzmfCLNk
 AhkFbbvyVjOLXvvnivLE5mM2TuZZx+yoNvKOTSYzhT9Q8F/V3HRj70a9k6qxPGRauH2l
 gpgXk+Cc4ixOb86ne4TanfWiAoHgRr6GMgH8Kx5dKV2fjpRZilzOaaWKEn50GHMoCp9s
 oDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551348; x=1785156148;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ooN4hbOmEpkDX9Z1ak2r9GWUVz4HFV5LKddUy5dwh9w=;
 b=DmhuClDJfiLGftWW9WzimPpdYAaquHpGtBbNAfHXDJWxBiDpWC+/iVTSClLzwizdKc
 3IoFxqMyc7SLu3dVsx6xHdJBODD3sufVJYNEYsyh1OKOO7RjPf7tczZYnOwnu9doZTbD
 1FAeFT1xAymnQYxneqz9YXMXiA7mloYxz7cGO6BeQSXlmG58pz5iUbmGrWL0HwHbN5mh
 ZtUuTEPneft4wHlb3TlrzE7ecsyjAOYe7WokOYlCDmf6hRtFsI5PslktsPpDiyfZyZLf
 sktXUUoW16SPgzLKtBhibC/F3hDUErXDEKYEZO21SqPccBMKT2kKI9jLA7t0VNrOCbA+
 YGrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAnUXc+mGwXHQJF21hYXBmnVzZHPrM4PoeLhbyB6iXem42fwJyAzD4QhcfBqExpbkzF29qjjhpjYk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXPzxBZh0DiMlRdVMONjYtvp9RNQ3qUcSOsxREkLOu4Gcc1VWq
 2NJcK6znf7VOnHhU1sJh+ZALAYtSGhIYm9knv2xAiZnM96SSZ4IzhYz3+LX6zkSC7Ko=
X-Gm-Gg: AfdE7cnf8bLyPZrZhNqxnN53EpE2ofO+4KFm/Q/B1crzbPf0d68mVU2WDZlIblGNXbo
 tqfyjLhPwYHHf3buk5eEUAx1HLlqc6eM0pgJdQNZe/px+ZZVNht+LEdkFzCZGhw0HULyjHtjp0y
 ZS4Rey/35Dg23MbLgYWEPaAOTSPbM/p45rO6wI9vFv/+0U45/Dol29BTs0XL6rcT7rwyX+20gT0
 yWkdkDT4A0M8fE0j78nnKORCnziB5odZ7RZzXKSYg/FlQq3UxYSln1CsnlDmXcqxSW06k+0kiqr
 FuKoZNEcZheqpBWLck9oY6b+zWRGcOQpMHBsaC4Ax1uY7DFifoonpwCgJ9xvq3vjD4YtxRKQdKM
 bL6cpKbvZQ0NT0Wgw1KzFbG3o5Zp8hNT+Ml/ln7fWd/t3+RDX9N3KJKo/Z2zQSCxBbg2FcIZ/Ju
 m8mJFrltONaL84FVo0HKk5WFWHVIB5B6HN49/EcOSrDok2alpdhWguAb3txg==
X-Received: by 2002:a05:600c:3b19:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-4954a3db76amr159529215e9.11.1784551347699; 
 Mon, 20 Jul 2026 05:42:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2edbe4sm301758205e9.12.2026.07.20.05.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:42:27 -0700 (PDT)
Message-ID: <5693c8c6-cbff-44be-b5fd-0c7ed0b622ad@linaro.org>
Date: Mon, 20 Jul 2026 14:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: ilitek-ili9881c: do not fail probe if iovcc is
 absent
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linusw@kernel.org, dmitry.baryshkov@oss.qualcomm.com
Cc: jesszhan0024@gmail.com, upstream+drm@sigma-star.at,
 Julian.FRIEDRICH@frequentis.com
References: <20260713082213.75759-1-david.oberhollenzer@sigma-star.at>
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
In-Reply-To: <20260713082213.75759-1-david.oberhollenzer@sigma-star.at>
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

On 7/13/26 10:22, David Oberhollenzer wrote:
> Commit 4c95b2b7d49e ("drm/panel: ilitek-ili9881c: support Waveshare
> 7.0" DSI panel") adds an additional iovcc regulator that other
> Ilitek ili9881c based panels apparently do not have or need.
> 
> The commit goes out of its way to make usage of this new regulator
> optional, dutifully testing if the field in `struct ili9881c` is NULL
> before touching the new regulator. However, in the probe function,
> it unconditionally fails if devm_regulator_get_optional returns an
> error.
> 
> devm_regulator_get_optional() returns -ENODEV if the regulator is
> missing, causing probe to fail for other panels that do not have
> an iovcc-supply set in the device tree.
> 
> Fixes: 4c95b2b7d49e ("drm/panel: ilitek-ili9881c: support Waveshare 7.0" DSI panel")
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index 0652cdb57d11..6c8d02712566 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2562,9 +2562,12 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
>   				     "Couldn't get our power regulator\n");
>   
>   	ctx->iovcc = devm_regulator_get_optional(&dsi->dev, "iovcc");
> -	if (IS_ERR(ctx->iovcc))
> -		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
> +	if (IS_ERR(ctx->iovcc)) {
> +		if (PTR_ERR(ctx->iovcc) != -ENODEV)
> +			return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
>   				     "Couldn't get our iovcc regulator\n");
> +		ctx->iovcc = NULL;
> +	}
>   
>   	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
>   	if (IS_ERR(ctx->reset))

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
