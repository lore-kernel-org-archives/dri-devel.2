Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FB2C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A792210E775;
	Mon, 10 Aug 2026 09:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AO2o3Fjd";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA3710E033
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:47:41 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f92e3c14bso1472745f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 02:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786355260; x=1786960060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7w13xP3LHLGowpJR2oLZQ9ZrIgfjH4D3SSrR2hJhZ2U=;
 b=AO2o3Fjdt99iP3+KUGiLLuzlw0//9R4f8Eyqj6fBDNgT4VCpa8ZPzCMMSVBOtQXQlV
 ACZ4/6J1J8ss8PxHyIBtXeyzfRL7dgqCa49gtHh8o1gkft5cgMp1e7TPK4m/4A70ddV+
 CurmIThfvBhLWHeRka1iAxtCiiCMEzfiI6v1AkwgCBPyjbWlpxeFW/bATVcrDax1MxPU
 l7xGdwLn1xkiLadJNGfBv7BYPaxbRlYiuxaw+eums62hM7PF1dRRKuVBBzbDAFqS4V0M
 EcFhPTNEjRgHj93jZz8yKa/70zOgABK88Lf3AZuQWpxKLqE4to7oaOBLqBGRo8X6EgD3
 03ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786355260; x=1786960060;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7w13xP3LHLGowpJR2oLZQ9ZrIgfjH4D3SSrR2hJhZ2U=;
 b=EdKYqjUiYg7cfG2+E1sX1CllADk1gbbRuJp6yeDx/+yl6H2CB7J3lka7ZhiHnmhNtT
 9mpNAgRTAvGLG2tb4QsX56wbBKsHKw7PKTjGdDluRS2VC2rhuhQ+W9A68MZcCEmwce3z
 plgx2trdrR7K8TuYxm7rSwi81nxTZ+afd2nkUyGtp4jwu4PdPxtbejDrsKBxd2iNz5cD
 OsuRVh+xIyGY2pwaPs/XfRiXToomYaqG/bHuyYHGbJw+3cbB5Zpd4Ju031zawTtf7krw
 ol+nG3SJ/H4XMmM27a6eflGCoXyepZ3ierz35A6ZjElbBJ9Nn9eV2gD+Nmy5XndiIAsj
 JSaw==
X-Gm-Message-State: AOJu0YwR4Q2l0xbiuB+FoDHtOkK5y3GAvq0N4jn6CDQzEuZ9OQfPjB3x
 13AloYH4HJV7NIbuOGZrUe1UaY6B2XDtJ4tfQk5xP5RVGc9hmt1d7AgmYRsIQyzlCXI=
X-Gm-Gg: AR+sD12h3tHNOpqG8A0DIoclc1MI4n6+8ZgoipIcGOqAmo8ybqFkdEuHmR3he3BHJ23
 e/Kr6B0zpUo1IDyfDf7zJgAP3hNjWMyYhjsip1NWXJR3VotdB16yLUuqw61CdlshxH9r/5p80aO
 f0EoesLYvbmS7rUbKH6NW+WT6/xtxhK24MnvkGDOreX5Ot/Ojzg0nStIAx81+IZKEVFN2XlbHp+
 4PF7DBCefluobMqhSFUCnny3tDRk4pM8puZ7ADxZbTgaIrosH/QP6Ihs3y8ti8b3/PIPJxnho4M
 a4FWtqBF90JNDtQJaKz6CL8wAqZMDfXtp7yWKKVDgcNuxCFFaKkqkYX3pjV7+fHHoSMY06W3NEt
 mH6RsQGYjIwJi28DzJGNfwnf0dcbRA4CR/eMcR0zIaj0FAGmiQM2XomrV1ruaA8xmtd8gDMwOGr
 on4adEemTu7rxcGjFYZIjPLHOZCzyU0fAqIhHIZLnmlN6HyhDlcwPWjfbIBnrDomzxnoVmrRuUk
 qcDjWDvzj0KUgru1rX+lqX7uQqLKnAQShNDn4B/GBw=
X-Received: by 2002:a5d:5391:0:b0:47f:6efd:8421 with SMTP id
 ffacd0b85a97d-48130eb2dbfmr20125555f8f.13.1786355259953; 
 Mon, 10 Aug 2026 02:47:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32?
 ([2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800214557esm31221551f8f.2.2026.08.10.02.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 02:47:39 -0700 (PDT)
Message-ID: <71ce47be-8077-4829-805c-953a65f1dc54@linaro.org>
Date: Mon, 10 Aug 2026 11:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: lg-sw43408: use the full DCS brightness
 range
To: david@ixit.cz, Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260809-fix-blueline-panel-v1-0-e7f3a6beb1fa@ixit.cz>
 <20260809-fix-blueline-panel-v1-2-e7f3a6beb1fa@ixit.cz>
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
In-Reply-To: <20260809-fix-blueline-panel-v1-2-e7f3a6beb1fa@ixit.cz>
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

On 8/9/26 02:04, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> The vendor firmware panel configuration (XBL DisplayDxe panel XML)
> declares DCSMaxBrightness 0x332 with a two-byte brightness command,
> and the driver already sends two bytes via
> mipi_dsi_dcs_set_display_brightness_large().
> 
> Capping max_brightness at 255 therefore limits the panel to ~31% of
> its real brightness range. Use the firmware maximum.
> 
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 0bf8e08f10b9c..332b15b6a4c94 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -202,18 +202,18 @@ static const struct backlight_ops sw43408_backlight_ops = {
>   	.update_status = sw43408_backlight_update_status,
>   };
>   
>   static int sw43408_backlight_init(struct sw43408_panel *ctx)
>   {
>   	struct device *dev = &ctx->link->dev;
>   	const struct backlight_properties props = {
>   		.type = BACKLIGHT_PLATFORM,
> -		.brightness = 255,
> -		.max_brightness = 255,
> +		.brightness = 256,
> +		.max_brightness = 818,
>   	};
>   
>   	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
>   							     ctx->link,
>   							     &sw43408_backlight_ops,
>   							     &props);
>   
>   	if (IS_ERR(ctx->base.backlight))
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
