Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05941094462
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 09:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D153A10E217;
	Sat, 21 Mar 2026 09:38:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="povw2A4Q";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8CC10E273
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 09:38:02 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-486507134e4so32269995e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774085881; x=1774690681; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CFpg1mbZW3Ctniu50/V4S1EGhLRWMwZR4yXu0pZ0YM0=;
 b=povw2A4QHorqNSr4ASZCTVAhpQ4K/aBtz+nPvPzh9tTl1oJzh0vQAqlBZSNv/sKxnu
 FvS7bn/z5cvk/g5WRxxWHHYbUKUnaU+immRI++rNNaIZcNqOFsgOnV6j6kC42cxp6aRI
 kc4YWt0xD3Ju24lbMunY0cYYo/GXR3wrYitO5nQ3GIp0YN4X268jvEsYhe3u21bVuNL5
 WJeOWxVNAYN6fWN7hP0Uv2Q8nWv2VD5xtAgOBNBWDckPhJVwi3I6McZc2GBW7hoOetKF
 DCU/6nBvrLAQtak4b1BtDXa5OAZwLWiwzyCpMFoIhrlF0sS+aSaZk1d4ttOr5SNF/j4i
 QdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774085881; x=1774690681;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CFpg1mbZW3Ctniu50/V4S1EGhLRWMwZR4yXu0pZ0YM0=;
 b=aUfyhiy6/Oa+ATUpXsPdl0o+5+20zeeBIL1eLtMVo4hOLeYTs5qE1mQ0LCdK21q5qM
 we2xdsz9GM7ntfw6E+mfidH2nuBBSDNnnqCyDsX0CHZ8RjrPw3SFxZPZQGsNDoDXeR8e
 VVlK5tR/imIhEniQB82ZtjnYLr5zPXRFr8BKANDwAEZgywNkZU4xjJ2GF/ehV7++KMgq
 49eZ56V4iTYVVRJDdQlMP7PPL3ZdA81vJzntnGUlOlwMbB4hP5pescV2QhGVTzT6HGxs
 hJw5bePM7FQ07yXo6jm+nqg/VefBZRP6IlXMlr4/bisZncI0mNZs4LKu/Stw0EKUWU/i
 Jf0g==
X-Gm-Message-State: AOJu0YxJAdL6YE4+56+erS3nqXDy1mLrwX0gqI9lYdqeseAduDh01oU9
 /QDz4mKpwSGZORlQ3lXmH59GWICp4V9r613QOHYYmi8t2KGaMKFFIttstVagmvYX1/Q=
X-Gm-Gg: ATEYQzxismuzbTjsNF8/NPRSNcxpSR5PYLSOKBFPmGjlpP3pJY4nktBWwJHRK6Q5dwX
 UDMtv8itB0/SSikbuB6YyQMmDkDs3kebTuK9llI9PFUAytC76kEz+62tRZ4qZ+dZ9yrn2YGm0f+
 irZa9R4DxKwGwZ4Z/ptG6gr8UHw9oehPJ3WvjH3UMA2oxvDF7eCfKriD3211V4ku86iyotteGMW
 8QFQVTV1h1qEGyaO/lElXtL/oohtADKqqLis/jzinBfTB5vRagYSY8mGxCFC0pxVyY2qpZoXL1N
 YJnlwU6CERZx8Yho7l434jsKDzLG5BTI3p/Rs3vwEwT1jSWa8K3hYcIcAlT3MJ4r1aV1B5gvyRT
 zDX4398/vmMmXBbOIqnqFLoqSaE2Y93se/+HMIdNyU89b139aP7HaGXNAUXNyxqNc6A4IO+I0TA
 9GSj7VaQAQ6OniiQWUfRyKYkEBCn2mQVzGZRYwkzn+AXA6b10AuoQrPLJmcavgvtNKU31eEG1gE
 8q+BKUZ43xEIKzS2HFYfJ8=
X-Received: by 2002:a05:6000:4021:b0:439:b1c3:84c8 with SMTP id
 ffacd0b85a97d-43b6423bc21mr10398940f8f.21.1774085880444; 
 Sat, 21 Mar 2026 02:38:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:81c2:60b3:ff00:9a5e?
 ([2a01:e0a:106d:1080:81c2:60b3:ff00:9a5e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm13770100f8f.35.2026.03.21.02.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 02:37:59 -0700 (PDT)
Message-ID: <8462ee30-7e58-46ae-97f4-bc208dd40f27@linaro.org>
Date: Sat, 21 Mar 2026 10:37:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drm/meson: handle RGB101010 in format switches
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
References: <20260321-dsi-rgb101010-support-v4-0-eb28ecebbfe8@pm.me>
 <20260321-dsi-rgb101010-support-v4-2-eb28ecebbfe8@pm.me>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260321-dsi-rgb101010-support-v4-2-eb28ecebbfe8@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Le 21/03/2026 à 08:52, Alexander Koskovich a écrit :
> Add RGB101010 to the unsupported format cases to fix -Wswitch warnings
> introduced by the addition of the new pixel format.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> index 66c73c512b0e..59fc0083d318 100644
> --- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> @@ -119,6 +119,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>   		dpi_data_format = DPI_COLOR_18BIT_CFG_2;
>   		venc_data_width = VENC_IN_COLOR_18B;
>   		break;
> +	case MIPI_DSI_FMT_RGB101010:
>   	case MIPI_DSI_FMT_RGB666_PACKED:
>   	case MIPI_DSI_FMT_RGB565:
>   		return -EINVAL;
> @@ -232,6 +233,7 @@ static int meson_dw_mipi_dsi_host_attach(void *priv_data,
>   		break;
>   	case MIPI_DSI_FMT_RGB666:
>   		break;
> +	case MIPI_DSI_FMT_RGB101010:
>   	case MIPI_DSI_FMT_RGB666_PACKED:
>   	case MIPI_DSI_FMT_RGB565:
>   		dev_err(mipi_dsi->dev, "invalid pixel format %d\n", device->format);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
