Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BE9FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2463D10F2D0;
	Thu, 30 Apr 2026 09:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d83Ts9zW";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E9610F2CB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:46:09 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso188043f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777542367; x=1778147167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sz6Ai6P4Nx2rPtIOkXtAQOJrKasr5iAAQ5nvgpjOt+M=;
 b=d83Ts9zWmliaye9rwu2Kf8sZEZnkT2D5pNcllj4DOFijQpN9EjfS0L3IXVtqiyLRpq
 OZ/g8dtOE3JV35K0YmjpHJsta6IAQtA0TUi/glwj5JRuuob9RikPewyVO4r+lDVnu4Or
 G3/08KcDDqX+JCEU3fKq36dK+/vcsigm0JzJUdAKlkkZ6HYhtxCeP2xBoA8iKrYc+eOk
 DBqnIVUJ6tYEf7QGw+p77Bvd4E+3gOW/0ybg2E5sCACo3BR0aHguY3dX1K/v7Xi+QqW2
 xnqMJXoAhsSG1BhL+xhqZfCWC2KWngqw8Wd/8HLVoRU4dwL8C5twB5c0nUATiF6Ce1gK
 6CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542367; x=1778147167;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sz6Ai6P4Nx2rPtIOkXtAQOJrKasr5iAAQ5nvgpjOt+M=;
 b=bjgzVclse+ZK+V+c/vq0yH2GlvpW/jzaBGK46F9xwckSj38+Imewqwr/wrzmK4NXFr
 51/1zPmZ4QBu1RfW8TQ8IUfZMA8ppZHQ6mAQNfUqa1vDSIXdq1EdrmrlTPmxNG1lw9fY
 p3b+F9B/WhIw5xAjbu6MnZMwZaz4HG28TLDnlZk33rPc3UMw28i3CbXpOdWg5Vovo2Ru
 sYm7GirfXjPbUEe4jWaLnzjQn4945fy6d/8jiSAn2BTFnsHjv+PhQXi38guCPKsFqmPK
 98Q72naZoTr1gP7TVAFCOjWIPhJzBfoEeMCRER44vstqBA+sX1hVz/QCyxNSQZXwAm9m
 M/EQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l2BBnK6ePArl9MrltFyTxY2DslPaJ5t6up95ad7pBBNd9ESMgplMN6CiudmKYx1TT1drCYeHwpvY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxduYwmr7MU0wjq6WZ5joyOBN/XEiig7yjw0fdTOQXRsmho6RN3
 beQoZXpjzL0vT/BFUMWEc2HYRFPA5Zj5ERkcHjdcj+O0uhbQ55NUBslvqZ+X7upjAhQ=
X-Gm-Gg: AeBDieuTj3poZGLwVS/CsJlcmp29IFu6VKRefQzCxnXPAE9xciO8hMeUdKFokJM/xT6
 +C3mXU7wJQWDQSU9qBRAgMinLTW/7ZIPe1+xmmyk5tv/EV1xlNUEhizP6wJvDZe5OcaSi1HvFSj
 hNbEXXHGeJCIsIDOqh8sDjAjlDv6BhyVThvlcSHFt3mTKKXoH+7YJ/kHzBPuCZIx7M4JDMrKAez
 OHT2JlAxtP9OCxvms3ToUrnuKw4eW+5XPYwNLAEMIUw3h6aqkdeepSxebFp30eMN2y1CFh/9N+j
 EEgF+Z1doE5oP0Df1maRiH+J6Cl4K/smMnZNKaHneYrx4Fuz9yRKGxw6djh5ZutpNfJcWF/1jcS
 HcOuSd8pfOY2PVNyFu3Sw+tFtVoFWvjX5R9HeBKFwQH8LdAGqyIMBsNyT8wTHhFGBdJknNVsrTI
 HuXwxf/ac9aiPPD3DbgxecItYWfAJDs5vJpm1/UXzgmx3DEqnhqwaiZifbAnqHIvGh2BsyiIoWo
 cpPGwKGPwmHW8GSSQ==
X-Received: by 2002:a05:6000:2088:b0:43d:75ec:26e7 with SMTP id
 ffacd0b85a97d-4493fed67admr3286239f8f.33.1777542367393; 
 Thu, 30 Apr 2026 02:46:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6dcc:3980:fe87:c6ae?
 ([2a01:e0a:106d:1080:6dcc:3980:fe87:c6ae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b4216ecasm12188829f8f.14.2026.04.30.02.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 02:46:06 -0700 (PDT)
Message-ID: <f3beffd5-ff8b-414a-bddf-fb2d85bbe444@linaro.org>
Date: Thu, 30 Apr 2026 11:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: jadard-jd9365da-h3: Fix signedness bug
To: Ethan Tidmore <ethantidmore06@gmail.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Walleij <linusw@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429024954.697411-1-ethantidmore06@gmail.com>
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
In-Reply-To: <20260429024954.697411-1-ethantidmore06@gmail.com>
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

On 4/29/26 04:49, Ethan Tidmore wrote:
> The function drm_of_get_data_lanes_count_remote() returns negative error
> codes and dsi->lanes is an unsigned integer, so the check (dsi->lanes <
> 0) is always impossible.
> 
> Detected by Smatch:
> drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c:2959 jadard_dsi_probe()
> warn: unsigned 'dsi->lanes' is never less than zero.
> 
> Fixes: eb019688f2a97 ("drm/panel: jadard-jd9365da-h3: support variable DSI configuration")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 7157b1299bfd..f6b04de1182e 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -2955,9 +2955,11 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   	dsi->format = desc->format;
>   	dsi->lanes = desc->lanes;
>   	if (!dsi->lanes) {
> -		dsi->lanes = drm_of_get_data_lanes_count_remote(dsi->dev.of_node, 0, -1, 2, 4);
> -		if (dsi->lanes < 0)
> -			return dsi->lanes;
> +		ret = drm_of_get_data_lanes_count_remote(dsi->dev.of_node, 0, -1, 2, 4);
> +		if (ret < 0)
> +			return ret;
> +		dsi->lanes = ret;
> +
>   		if (dsi->lanes == 4) {
>   			if (!desc->mode_4ln) {
>   				dev_err(&dsi->dev, "4-lane config is not supported\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
