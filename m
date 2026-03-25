Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A50FEA82E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C0510E811;
	Wed, 25 Mar 2026 08:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ehmWJIYu";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB24110E813
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:08:43 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso3247112f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774426122; x=1775030922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aGtfZugx6qGzB9L9OH7bygfJL7iwyyf8p4sO411xjfg=;
 b=ehmWJIYupNOn7JkjX1FqYDobD3c6b7wb8h4mxtJKFXBsAuw4Nh9xT4EFaDKhXAf/OU
 letH3IByXcUWUVlGVxS0XR4Gu3kXPPdL6FVglwKeAIVhwohMq6yUVz+qP3gOmCdizuRd
 be0OXlKcnMhOAPxZQrW+v16iiBj6x4XqJeLd8Mq/zN7bCP5TOW5zMLAwnueUa+iQme2z
 jDT4YIRsNYhRJnZDktvGaQ1P520GJ4Y6jsQ7DaDA+ytD4EpmLg3IDTz4sywBHOnaH2Jj
 rnWO4SJZYf3MhZEofApPqL3i8EWCNRNIBasWmdjmNt+XdY1/lyY4g04udZHtNTRo+Gkq
 hKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774426122; x=1775030922;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGtfZugx6qGzB9L9OH7bygfJL7iwyyf8p4sO411xjfg=;
 b=EYoAud7ALhXl+h3zvfNqALCkGcywpkEsm4jBuC7s7rPoXV3U4d1XM+vrMFBTq04dHn
 7WfKVeetaVXIWqkKmDMB7V1oRnJhRvY9QOw6XGOGCZN7jzAAus6sB7K6lzR0wPGO5mCd
 i7M/7VxdOUx5qmX956LyDX3fYXedSQ82zz110qLJJ276KEI2Rn+Wo9tplm2wUtNhizX3
 RagGPMQaSH2A5fij9mokf5rg2EFYw1ZC6EdNbxkPVQt21qNnFCb7TBFRjyJRJHE31hZr
 YDlGDC+RzM8cJaB/bcUEvua6CWoPU0gnFQzIQwMf9hGunuBdRXFIX1tqutM2gx1MQcVS
 Q2BQ==
X-Gm-Message-State: AOJu0YwXMvh8aifp5Z6VPjkKvohpmVv6pQEW0gcA+nKh43c8nR9O2ljs
 FPvw+JKG9xrxBFHJFZziohcFsmqgfBSO4ebfte8RXt3/X1WvHb5HNnAU7hTaORwVfEg=
X-Gm-Gg: ATEYQzyIrcLuhJ2lhpY5bqBV60zyU38xL0ZQCQihhozhZDj8k+qQBsaLS/B2QoPRdxI
 KpZIw8BGP36Ylz/rDDpYZgMqKHzoyg75IOPX/JQwDHB1298N1NGjE/zU22JF+0XvtwL7hvjfd3B
 qtBy1ociGc781o/4GbxWQTLtSrRs8SEzQbBVsaOmdbaLshL3O1E84lO6Rc+u2wWlHue/wQ2gidM
 B22XbgyEQcar4OXAgC1aIipK4Ari1KschsGJiDVtGl3o3f8kPJWTM+Fxh3EuYiEwzEx/13pHm6K
 2gDooSPb145Ch8kdEr9MWD8wPYXJzjvYgxi6bcVAwYOMQxOAqTR+VBCIqvlE16hUcjkMPj2ApDI
 aNWtD5JkUHnslpf49Q1gqdbJE4FUPs3RuO1PvHz626HgFkZQzBjAVqalr0dYr3nqQ+xFcnwDeMl
 U+qXTO2St5EMJJKRc+lCj4D0cYc8Jw3tymX0j4+tKp/v+uW8NXpx7KvQTbpnNr/RHgnWCdXF59I
 x1eXac=
X-Received: by 2002:a05:6000:3112:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-43b88a2171emr3257849f8f.28.1774426122254; 
 Wed, 25 Mar 2026 01:08:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c160:8cc2:c60a:b843?
 ([2a01:e0a:106d:1080:c160:8cc2:c60a:b843])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6cdfdfa9sm36075748f8f.9.2026.03.25.01.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 01:08:40 -0700 (PDT)
Message-ID: <15674376-21c4-4403-8e0f-bcb80985743b@linaro.org>
Date: Wed, 25 Mar 2026 09:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 2/5] drm/meson: use default case for unsupported DSI
 pixel formats
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260324-dsi-rgb101010-support-v5-0-ff6afc904115@pm.me>
 <20260324-dsi-rgb101010-support-v5-2-ff6afc904115@pm.me>
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
In-Reply-To: <20260324-dsi-rgb101010-support-v5-2-ff6afc904115@pm.me>
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

On 3/24/26 12:48, Alexander Koskovich wrote:
> Use default instead of listing unsupported formats explicitly, so the
> switch statements don't need updating each time a new pixel format is
> added.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> index 66c73c512b0e..4412bd678108 100644
> --- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> @@ -119,8 +119,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>   		dpi_data_format = DPI_COLOR_18BIT_CFG_2;
>   		venc_data_width = VENC_IN_COLOR_18B;
>   		break;
> -	case MIPI_DSI_FMT_RGB666_PACKED:
> -	case MIPI_DSI_FMT_RGB565:
> +	default:
>   		return -EINVAL;
>   	}
>   
> @@ -232,8 +231,7 @@ static int meson_dw_mipi_dsi_host_attach(void *priv_data,
>   		break;
>   	case MIPI_DSI_FMT_RGB666:
>   		break;
> -	case MIPI_DSI_FMT_RGB666_PACKED:
> -	case MIPI_DSI_FMT_RGB565:
> +	default:
>   		dev_err(mipi_dsi->dev, "invalid pixel format %d\n", device->format);
>   		return -EINVAL;
>   	}
> 

Feel free to merge it in msm-next or other drm branch:
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
