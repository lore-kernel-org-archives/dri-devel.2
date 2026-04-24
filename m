Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64880FE51F0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8D710E5CF;
	Fri, 24 Apr 2026 09:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iAxfGfx8";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D0210E5CF
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:30:26 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso104109255e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777023025; x=1777627825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=lWHt/moMI+9wgpJfyIFBg8YgKa+M5uQgee/sMh+PXg0=;
 b=iAxfGfx89KAej8pwlEnLqfTPG3pToPuuIkp4ZulllJVst3KMkPYQqtgzZcTveLmWKx
 0BnBpqDF2FqaoaQREfc+svAWmARaOW/Ygg+pH8KXPJt/88Aw9RybYX0yhBEmxRXzt/O6
 GagpU/IYceK/OEPKYWk6xz0NOOYNPD4VGTVt/SOLMjvMtfqmbenqVgEvRmY1N8KaqsL9
 aNXY6GbiucftBZDMf+KQkhmv+9sNGWmXeSR9guTEmmFWKLHD2Sih16ECtyD/3KG5LxFW
 stIJba5NCpPe7msIAkYOdQDjVGBGNs1Vu3ieY7d/nLOwOL24XxctTJkzT7B1IQ0UtIdo
 DJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023025; x=1777627825;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWHt/moMI+9wgpJfyIFBg8YgKa+M5uQgee/sMh+PXg0=;
 b=ZFm/+kqLQnJU5JUkJWG8Gw8MBVeLT8ZeUXB1Zq7iz746suWWxNzyY+zHW+nQGGFO36
 dvT/bsc+L4OrLDySzhIDBPVr1IXnCmIS7BuanqVH9NwOYyu4Gw5BHzZtFPetVECXoWZV
 y3GfcRAO17+dG6q4S7Paq441bvY5F6TdlZCeAZZjysnCqTv/vB/ZfjHhRrJ6JPMSw4Y5
 vfmw02MmyuE3qS2phTH6t0Ry/sGDZ7wBuKdw/JWFyo+SaIXuT6I2AO2WVAga6e7ovoWl
 JCHvm4OTnqUmrMViK2u8DzigUtq1owEQ60VhpP1wlJTgDYOthMrx5z33iTSFyCabw2rM
 61CA==
X-Gm-Message-State: AOJu0YzWABPeXs4TDfzNUqHiSgJIXFblaptHlQNaxJ0QYibnxLsEb6XJ
 q6EwxlXw1VwUY99jjyRhnItgqTYbSu6dsQi9MESZeWayfq5Nb/eoCKg6Kev0RIROMyqcTOmj5l/
 FgqnllBo=
X-Gm-Gg: AeBDiev9R7YPYVLs8Gygs0fmhrB9H7GCthGfcVTcZ8FQWnFBUnNa8Hv9K2W1RPAKjr7
 k4H5KDVVSBUnkUYHPe13b0Lyx6MHpIZ9+0DMIvf/OTUuzSVQuywegSoZTy8GMuBBr9LZ5lOg9Hk
 pOF+GMV7aAS7ubvtXXm8RWo5Yzjk6BF9MSWWIr3gVhvgqPSS9TrUN3eQP1XAXCF9c8Vq+13aoun
 rknjw8mTFxyuXiney38CyHzOwJraQusGHSRgJ+3zKiy/3qxylQGX6TXMjIN/U6S+hw3I0rqKHtw
 VS0jy45Asgw3ZIdEyiEXy2WhLErddpWVA6BFUwEBphMGl9/3qM7dGEkYiiNe/cmZNsunMictI1O
 IbWRLrUYAuKq2Wfash69ik97ZvJHCwjZIXewSh9IpTei4AdSpLPNd36QW5oOYNEHlH/83Ug9pfr
 7nxJgBh9XUa3/AGn807XRkaPTvKgjyzKjOzzNhCiE311rj8wR8+BFHwtIxbzeNKEwiH8weBj/1u
 Qkxi0BNlJVb2UtWNg==
X-Received: by 2002:a05:600c:620c:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-488fb7786c2mr455899345e9.14.1777023025253; 
 Fri, 24 Apr 2026 02:30:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c?
 ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc100162sm598271405e9.5.2026.04.24.02.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 02:30:24 -0700 (PDT)
Message-ID: <0cc98ad2-bce8-476a-8f27-2c201eed9828@linaro.org>
Date: Fri, 24 Apr 2026 11:30:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel/boe-tv101wum-nl6: set MIPI_DSI_MODE_LPM after
 sending panel disable cmds
To: Brady Norander <brady.norander@mainlining.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260421153147.4378-2-brady.norander@mainlining.org>
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
In-Reply-To: <20260421153147.4378-2-brady.norander@mainlining.org>
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

On 4/21/26 17:31, Brady Norander wrote:
> A recent change to Mediatek drm driver enabled HS mode support. With that
> change, my MT8183-based krane sku176 chromebook display's colors would look darker
> and desaturated after turning the display off and back on. Looking at other panel
> drivers, it seems common to enable HS mode to send the disable commands and to
> disable HS mode afterwards. However, the boe-tv101wum-nl6 driver would never
> disable HS mode, leading to this issue. Update the behavior of boe_panel_disable
> to match those other panel drivers. As a side note, I did also test removing the
> line which enables HS mode during panel_disable. This worked fine for my device,
> but just in case that doesn't work for other devices, I chose to keep that and
> instead disable HS mode after sending the panel disable commands.
> 
> Signed-off-by: Brady Norander <brady.norander@mainlining.org>
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index d5fe105bdbdd..f69b5bd776c0 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1326,6 +1326,8 @@ static int boe_panel_disable(struct drm_panel *panel)
>   
>   	mipi_dsi_msleep(&ctx, 150);
>   
> +	boe->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
>   	return ctx.accum_err;
>   }
>   

Could you add a Fixes tag ?

Neil
