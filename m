Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB97CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 751A510F1AB;
	Thu,  7 May 2026 15:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IuFWWKuq";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1E310F1AB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:35:29 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso11619505e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168128; x=1778772928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Yei7lOebU/Uz3u8Jf+bfKKJkQIzcyOOAKefSxTqCzB8=;
 b=IuFWWKuq8dwwYqPFNQZMh7ywptNvA+bOHPeIoqM0NcGK3jNRdW9Km7+rMP5ZNF6XiY
 gRBZNzkYiq29ZMgM+OTPWw8UEvWa3+iG6hfDy1DqGIhRwf72JxiO1sRng3YWRog4/MuI
 oko48I6RVp0yNAjmpXZpNCxLGMnniaBDOr2qp0HtKWoRdDuGlU7FlsPlszLO85Y9F5Mk
 ciQE8GNcSOsKmr4C0bSql3hkSIkseEZzvYMoawmu733vBvquJV6R4IOiqACqC6tZTC93
 UXxomA33QLSX1nl/p19kq+GcSzcwH/eCpGTCWNQ5OnZB1BG9dD1kBLUKg7lshW2tKESU
 OfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168128; x=1778772928;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yei7lOebU/Uz3u8Jf+bfKKJkQIzcyOOAKefSxTqCzB8=;
 b=g3wSudxUbw1KScg75xXcYxohflRN+D36tTWA08vOT9E4Ijs7qQPIxK+b3LuyCDP35V
 YnW/eH1Mvl8KZX69qZGhMCNABHtdpugaciQSUMaXWNTHStOIskAGk4TjleepP7gu+3sb
 aJ7tqCeMlaqdOfxZF8AdXuzhAnyMFuCBDzlAKBxzARIblnInpHJltzIt+dWUK3zSFdKk
 LJmAwIfKQqPgqrnOApZp0bOoZ4lOgLdtccW1p52D/4bFCZKJRg4VYfx6QoEa0eiV4Nmg
 +S8cKNStzQQBgMulLMLdJKryTNcwtMw3KotxiGXcHPRhkh2ZkN8UaoSzdotjHGxGXoeq
 Q1lQ==
X-Gm-Message-State: AOJu0Yym945BrpN4O9hWdk5UMEy+HBC1E5aSNpKY7mbZ9PjzwNHKPJQ0
 5k8VVOn29azgJCeLGqwF983VcSRNpxZyuH4C+vaK5PvH2AiRunOu8MfeOfWRHdMbnP8=
X-Gm-Gg: AeBDieupoyatVKhsrA88UqHm2SyvukLSDzkWNhTd87abfcXhanSW0tn/ou3uIpx3vOH
 XorhICV42jcjkOMIsQ+JJ+22sjMGtV0BzFUWLpdfGraS28dxBYOa1Iqej97FRbpA11MT0Ux4Oug
 3yStSYAUQNxCcJMp1U0HNFUfwen9+pN3TmxgEVvRZeLrij1V/NDZnZlu21xgLvO0skaz0HywuQO
 Ge0NDEavYmmFL6wA1r5GQ5r3dZ8EP49o9wsMIvfp7YFXWFZskqxiAEdJyZS2dHqCx8uDQlK9hEW
 EyJjhiaqpXjMmdrdM5HWup9cmKnx5VQtSdOIrYzFk09DhvXs3zCSz1nwgrQXVHT6er9Jsq4zty6
 oTQX9vIkIY4eBw9zrUHmks7+etgupvxjCsXMBVt7+qidWT7nhlNNMkJ7afbwnmWVAFD8F6R2sJM
 ycNwe52zWURmXs5s2+BVUdPRBdGITLKcfPyXxE27D9/PpZwIoTlo0Xsw4Yt4BkZoziSCRYQOzHx
 9avgPD5GfgyCZvK2faGrzMcKauQ
X-Received: by 2002:a05:600c:811a:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48e51f35d0emr140931315e9.20.1778168127868; 
 Thu, 07 May 2026 08:35:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53108c4csm63010005e9.6.2026.05.07.08.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:35:27 -0700 (PDT)
Message-ID: <1c01b79d-e716-47bf-87a1-fb9f630a993c@linaro.org>
Date: Thu, 7 May 2026 17:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 03/10] drm/panel/novatek-nt37700f: Use refcounted
 allocation in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-3-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-3-51f448c7c291@redhat.com>
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

On 5/7/26 13:53, Albert Esteve wrote:
> Move to using the new API devm_drm_panel_alloc() to allocate the
> panel. In the call to the new API, avoid using explicit type and use
> __typeof() for more type safety.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt37700f.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
> index 74f46a268c0f6..c221dd498fed4 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
> @@ -225,9 +225,12 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
>   	struct nt37700f_tianma *ctx;
>   	int ret;
>   
> -	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> -	if (!ctx)
> -		return -ENOMEM;
> +	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
> +				  &nt37700f_tianma_panel_funcs,
> +				  DRM_MODE_CONNECTOR_DSI);
> +
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
>   
>   	ctx->supply = devm_regulator_get(dev, "power");
>   	if (IS_ERR(ctx->supply))
> @@ -247,8 +250,6 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
>   			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
>   
> -	drm_panel_init(&ctx->panel, dev, &nt37700f_tianma_panel_funcs,
> -		       DRM_MODE_CONNECTOR_DSI);
>   	ctx->panel.prepare_prev_first = true;
>   
>   	ctx->panel.backlight = nt37700f_tianma_create_backlight(dsi);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
