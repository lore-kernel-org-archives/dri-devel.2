Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C12BFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DAD10F2C9;
	Thu, 30 Apr 2026 09:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="msJTht1d";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9CF10F2C9
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:45:50 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so5308885e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777542349; x=1778147149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Mo0Grl4aoT+5/V3Ft+Ldjxi2m+m93Q57dgvCRhtSBWo=;
 b=msJTht1di/LjDwi7IJYdr8JxX8+vekR/p7qTE3e2/pRSYsugoBcU/EnlXE4TgULKz/
 SwCayfVLcOhkOIdr7YaS3DGvw/iKx/7gGnVPnR+HVuDnIFuVKlfZBH74C5leMsl1ZByH
 CDFOuzUdng4OyrcS+Y4xZtXJErKQsDP5+mCc5yC2brJHciyDEolqM1SeCMUXom57UNP5
 vlqaG7IEL5zRQeruToAp5ZSoJURBKSYchtOoSnEhuJI+A73opL2isRmSNpjAnkdRc340
 jE9KK7ZnNYA9cUToy9s2hSNVygod4th+2XH28MwqQYHfc1nNjASaDTOvOIgwWGxfQiVr
 4XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542349; x=1778147149;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mo0Grl4aoT+5/V3Ft+Ldjxi2m+m93Q57dgvCRhtSBWo=;
 b=PDqNCxdP1eXC4Dhfx2wd8WFPyrnBhmz5leaLIYKe3MfvfXhEZ8Wq7mQDfztZd2lGuG
 q9gA5xyP2hkrKPbGym0ve3tvcnKPNLN9BLjYuL/NdPh4jc2Qxg3ZlsSV47jZbVlaRb5R
 BMI7zzZMGxsYUz/zJ0NfP3DaM44q7ZPubjWZrgNJAhyEJ8A08z+zeam3pg9c8IjajeTO
 NZMGEVfrG7Z/XJPyXddxa7kAHeD5aNbi7kp12BpuV/7inAy/bMJznzpCfXmR3Wu5Gs4U
 cWHQkZb5YfYcHEnQZo0A2CWulYzq+3ApLD5TrAWHz3FdDUQkgjAkA7hhj2As2MfLN0YP
 fIQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gqGGjUB4ojcBDX8rIRZWVZBxMmEKolmtcFb9YDzlhfeGP26iDcDYk4MBa2kbs1z39M9/Aq0VXNuQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMbZa6V1Zzk6EQ3uPRBsyVMVf4RpiTXvJ/c/0EeYHRvS+RUiym
 9bR6PYn2F8TOVQBPnLmgKGc4EDZ7I6UE8fdr/omtfz6gr7jUWlKVb7xtK+da+7q/SVc=
X-Gm-Gg: AeBDiesfmr+P7+lulQD/IaJ7a6oLCidXxaQBVthJPsmjP1akO5MzBythi1KNWMnl6LP
 CGWIx2P39sXZcaEDPTz2CCwB60k3KaSOpXhEDEHMGmFQpz6/EEE2mUFV1wzKgbIrtIzodcn1egv
 uY071QnVjQx0xM7/exSDfDmr1tFnlfqwGGe2CjRSY9CcotomTlLSsjeKYNr87dgC3plBE4LT7aR
 gugNr3qVJQnXfiVv7XwER4iiHJciDKnWprjb99bNPCavhsJowRVVde5k5qKaMT7JJP8R1NiAGKv
 aR0p13Vv2mNsDF4wWwjLTo4RAMZCrHwJe3L6Vv+cnqMrTjFiQ6SRbaUjTNDhoeg6g5H03fIutTc
 GnqM0gsjrKwK+eT22XkNnbbUP84aSoYG0g4pA7vzs25UeuLxgE42YrjXzTyi578Cp6L/6lbY9Bh
 r1opfNajmxBjOboO0WcvYWGRKUQBjPu9hnce4B6nBa4e6SjUdUxhEYAfxx7Mn7/Tw1F5IlznniJ
 Lp9KKNfpDcueM+xwA==
X-Received: by 2002:a05:600c:1d18:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48a84459207mr36316295e9.22.1777542348760; 
 Thu, 30 Apr 2026 02:45:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6dcc:3980:fe87:c6ae?
 ([2a01:e0a:106d:1080:6dcc:3980:fe87:c6ae])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a824f9f0dsm50386565e9.15.2026.04.30.02.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 02:45:48 -0700 (PDT)
Message-ID: <641cafb2-21cd-4918-8489-713f307c3d0a@linaro.org>
Date: Thu, 30 Apr 2026 11:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: focaltech-ota7290b: Fix error check for
 devm_drm_panel_alloc()
To: Chen Ni <nichen@iscas.ac.cn>, jesszhan0024@gmail.com
Cc: dmitry.baryshkov@oss.qualcomm.com, linusw@kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260429080527.1456732-1-nichen@iscas.ac.cn>
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
In-Reply-To: <20260429080527.1456732-1-nichen@iscas.ac.cn>
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

On 4/29/26 10:05, Chen Ni wrote:
> The devm_drm_panel_alloc() function returns an error pointer on failure,
> not NULL. Fix the check to use IS_ERR() and return PTR_ERR() to
> correctly handle allocation failures.
> 
> Fixes: 07853e954248 ("drm/panel: add driver for Waveshare 8.8" DSI TOUCH-A panel")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-focaltech-ota7290b.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
> index dd420bb19440..ed02a8daf96f 100644
> --- a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
> +++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
> @@ -156,8 +156,8 @@ static int ota7290b_probe(struct mipi_dsi_device *dsi)
>   	ctx = devm_drm_panel_alloc(&dsi->dev, struct ota7290b, panel,
>   				   &ota7290b_funcs,
>   				   DRM_MODE_CONNECTOR_DSI);
> -	if (!ctx)
> -		return -ENOMEM;
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
>   	mipi_dsi_set_drvdata(dsi, ctx);
>   	ctx->dsi = dsi;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
