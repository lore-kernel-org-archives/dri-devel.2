Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538AC606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eeQe08Mx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EF210EDFA;
	Mon,  2 Nov 2026 13:01:27 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5603110EDFA
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:01:21 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso1788945f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793624480; x=1794229280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FdyGkNb9XEU5OiT4BY8dIJsA7dO+2bFe6m//LRgHEZM=;
 b=eeQe08MxGj1ePGdEqQmSPSt354Dv8tEUe5BXDonlfBFXzH76ayGdUT8a0sYcElJWb5
 b8gT+AFS5GiaYscotrIH7auV67naBQLgGg1Zngs9sFe3b9Q636dfOzzyu8i6Ejr+uD+c
 13pCgzN82qiUtLmTFtKxwgZFdaidmaCR83lIwV7SLRCeuC+F0wWY11836z2aY1D3AV9L
 379pENOa9n5sab7rTrCy5LGLXMYLBkiEhBH2tTstU+xSfwstBJ/vfA4xfDGcb+lW/htz
 GlaMmmyzeADzu6OC+2sEm+3skXuYGZ/jVcHj/SGEg8iFbFZ4ocESGCl5SCzpnB/ccD8i
 YpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624480; x=1794229280;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FdyGkNb9XEU5OiT4BY8dIJsA7dO+2bFe6m//LRgHEZM=;
 b=HqtJNmdds6Tv5AV0vnrVMq80MWYRWaTWRzL/w3qGW/WBzBZ+gQGXUEbWrRA+ONDhwK
 Q3xWbwjGYR2WAch+uzUqrmxJUTZjEB+Kgh3C7LlCSRLOTLTltBWGSp3o4UqyP9i37M40
 v8ohc1cpEKfqbpq5u6DCew28CSftI/UO3+0dx31vbDCgZXKKIbgVp3/xiVLXfUgRMfUv
 sn572Gri6nZqeyNTkX66p/MIvNoYXJfdioTWXuOWdqNKBu3YgbBOycDuJP4d5yRWKhEs
 m5v6thBMbaNPhXDRq8stab4KdCFgIDXIDcMssxyKYltlVGTrMhMYtgiKn6iKCIQA0hOF
 q6Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJX9brhE6EFSgh0Wc7cOPp3/2H1F1q/YSFTyMtRAbYuBk0FIqBfQY9FxpanPp0S98KUv+0eozhTcE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKP74dyAuRzPOv4DD53cJFaY8mEo2OBCYesyLFm/pDFOMLY6mAY
 gjCYaWspiAwcmnAhp41bNjeMMkzEw9bYmV3NOGpxSET3/zROTxqmo1SXvbU6z3Ny2CI=
X-Gm-Gg: AYBFou0nDebEuTRrfMCJxcJ2GsdEIaOEVdBVhgE+veiec1uGFgbAfdr+SCJLu0FwY+s
 GHFr41c96nCSkV0sfry/bVRlobtMn1xr7wgJoX/dB/O39CBtR9oiY2AH4SrWmi7+OUM3ohNuKeN
 vL3EQ7tOMEGmoE2gYqEsyiraHl4tSuiT5Y6AMtcxJO1oMqqtVn8UNNvKXQCzSxwWz/omNUq1kzR
 2E7kDycgV1b3DKf6qGUJjpx+x2fn5CTztBW1L+trmr8zC5tEFB2pm2/AO3OH3ZvtEewOO93aPl0
 VZ1D36AmVGmCGCUx7SF1ZTrOYsSMtcf+rBvQbh8ZRS+DWraZ4QWtC/wejUOFRVvjaWbkTdSIxrw
 K4ErP3PQ28sEi5Vy1pjHzl7wngeGPlaCEroZatzKv1U7TB5eZ8cmKq2+vUwNmd6FSiYtYFtM5yE
 TxdDtgTHV0JYXFH0ji2aS7sE76jghDWI0ebPohuJKJpg4VgfszceP8wB+rfR/9vMHUvr6zIUSlT
 8+IDrG8Ds4+/Rx00hoL0cYS3EOlk3PCFdqTMP5AIQTY1UVr9pCjvTiphnlh/Ci76rSSn7WYXiJJ
 NV6APKfa3CHjR92T61PGa5EQTEWIypjhUGSyTdB7BqxD5VC4a8r5ytkakLm6WUbLam7x2VNUYpe
 EATSL
X-Received: by 2002:a05:600c:638f:b0:4a3:59c2:b41e with SMTP id
 5b1f17b1804b1-4ac150b304cmr228118685e9.4.1793624478166; 
 Mon, 02 Nov 2026 05:01:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm316856835e9.12.2026.11.02.05.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:01:17 -0800 (PST)
Message-ID: <fe1eb69f-329a-4463-8993-619f598dbca0@linaro.org>
Date: Mon, 2 Nov 2026 14:01:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/5] drm/panel: raydium-rm68200: Fix prepare error
 cleanup
To: Hsieh Hung-En <hungen3108@gmail.com>, dianders@chromium.org,
 jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Sashiko <sashiko-bot@kernel.org>
References: <20261102043215.990351-1-hungen3108@gmail.com>
 <20261102043215.990351-3-hungen3108@gmail.com>
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
In-Reply-To: <20261102043215.990351-3-hungen3108@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 05:32, Hsieh Hung-En wrote:
> rm68200_prepare() returns without disabling the supply regulator if
> EXIT_SLEEP_MODE or SET_DISPLAY_ON fails. Since drm_panel_prepare() does
> not mark the panel as prepared on failure, drm_panel_unprepare() does
> not call the driver's unprepare() callback, leaving the regulator
> enable count elevated even after subsequent successful
> prepare/unprepare cycles.
> 
> On failure, restore the reset GPIO to its unprepared state, following
> the existing reset sequence in unprepare(), and disable the supply
> regulator before returning the original error.
> 
> Fixes: 2b7ed18bed1a ("drm/panel: Add support for Raydium RM68200 panel driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-171393@kernel.org
> Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
> ---
> 
> Notes:
>      In this patch, rm68200_init_sequence() still returns void and only
>      logs DCS write failures. These failures do not cause prepare() to
>      return early. A later patch in this series will propagate
>      initialization errors through prepare(), where this cleanup path
>      will also handle them.
>      
>      The error path does not send SET_DISPLAY_OFF or ENTER_SLEEP_MODE,
>      as DCS communication may already have failed. Instead, it follows
>      the existing reset and regulator shutdown sequence in unprepare().
> 
>   drivers/gpu/drm/panel/panel-raydium-rm68200.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> index c535dc931903..3a59eb00274d 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> @@ -277,17 +277,26 @@ static int rm68200_prepare(struct drm_panel *panel)
>   
>   	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>   	if (ret)
> -		return ret;
> +		goto assert_reset;
>   
>   	msleep(125);
>   
>   	ret = mipi_dsi_dcs_set_display_on(dsi);
>   	if (ret)
> -		return ret;
> +		goto assert_reset;
>   
>   	msleep(20);
>   
>   	return 0;
> +
> +assert_reset:
> +	if (ctx->reset_gpio) {
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		msleep(20);
> +	}
> +	/* Balance the regulator enable count on prepare failure. */
> +	regulator_disable(ctx->supply);
> +	return ret;
>   }
>   
>   static int rm68200_get_modes(struct drm_panel *panel,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
