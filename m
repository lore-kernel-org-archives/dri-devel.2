Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA22FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C3210E5DE;
	Mon, 27 Apr 2026 07:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K31PsHQC";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A6010E5DE
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:46:04 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso9485475f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777275963; x=1777880763; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+u3/elMDWz/LKtOmsePu2UI5vStego255LeN+cFbL/c=;
 b=K31PsHQC0dk2PN3k9EmpQHdUPznMSwxgWMqiZnLVDvHKcUSHm2gzp1/qpxIPZQW2dD
 1GvH2gEPaMAxVW1hoglcOJFJ43I6/F+43YS4rql10tMgNlM4p6cVrODfPyu3f8Qcbqv5
 193bXW2mpH0QY+Ml4yhJTA9Dxp0WuMApypCU42F7x/gKdpeqsZ8nkj8w0Od/89smF3bC
 yZaMAi3asI8nKYcsfa7q3tebVrUo0kvGtQyr2EpNbnufzXawn2Oq4Y6UQx9lQUTtmSK/
 EF2jphkgSULb67+FxgjMvuDHdIT2oT9vey2StzH1ArBAXO4+UCyMRUC69ol5qDNastFt
 syUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777275963; x=1777880763;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+u3/elMDWz/LKtOmsePu2UI5vStego255LeN+cFbL/c=;
 b=J/yZYMvKDPYjJc2gtQ2TQikgY/FjiU5lF2wvQ3XX43GWYsGfbiJhi6I4W8dRK0q0+1
 BYGWKQifTpL/wVTIhaSsLUIHbo1c25+ZP8zQ1TWqkpP46BTs87OQtZ463p2Ci2d47cDO
 BswfQhaCM3OqBHAE9Zj/9vJRX0xJaAflLuYabi/WwfCQYhxwtFlPspugWTSbyUwe8P5V
 EDa1O2kSU5mEHO4uyOPvCtlWf6vuCPJs/t3/OVs0SPUNxqM3rOrcD1MgcjNI9tq5jG7M
 tgTdy+RuWK36vz70TnBCFyN0TnuUe39LhCBZUcfwU81e/HzzbkpS/FUDO+qlbuERY7TI
 x5WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9swdmOhpqVdwMQHC2IKmujHRAf608kRK4Qy5iMSfofvUMk4R9B0ZXIbtr7b6CQyZd5x9NfbZIulDc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYvn2ys+UeOcyPCiuNfLBT9GlU9VD4LWAcB0y4pqHJp+xFNMz2
 tKvxSzX2f9oo6Z5Q3V01CJAoenmzbAttrCa0NbqurrOctM828Ar6TdycHmoffAM84Mg=
X-Gm-Gg: AeBDieugqtAzdWaP98viqBcwxwPsRakAspEJo+oOLIL0RwUJrcLLX/rDXYKYArnp4lz
 8YZJjkI36TA3VJITbg3NWBFWRXjblK1KBEP8J2TydVfDpbg3AXY2dcFJvjLvSrnDleXktA3K8Eg
 4PphvhdnsMfThnPrz5hXUt7cIRbo95b1SlJj3THXE6dlaCeTIxYJAOoIbjuabXYHoEP7a5UlvvD
 qYj69D1J5Gp451NeUCreTQ6bbnvNW2LXpBnPPgLL8JtlZYRnI0JuUaDv+hGpPQPFfhYWw+AnWDr
 jf+Bj+j+8s8obs3RZNwqpkxafsyEUpZEt82sBKPamdKwzbmsYGY7jRkOkvUAphsUA1PRDc9hFT+
 mGlCrlqb/88OMGgmWgtFUMkfPBRDfl2cbpMGsJ395wp/c5HCzfuhgWsL/uN90tmd51F7prWASQQ
 lSvynhd0S4EBj4DCxh5T5zRvYFzc4XqDChRTCkBDwpaXwqK3phNvYwZnPSC5mALKF+QxIH6iNqY
 R8Sgw8QiK9biwDLIw==
X-Received: by 2002:a05:6000:24c6:b0:442:d9c0:799c with SMTP id
 ffacd0b85a97d-442d9c07aabmr10780863f8f.0.1777275963001; 
 Mon, 27 Apr 2026 00:46:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ad59:75f7:6c30:2440?
 ([2a01:e0a:106d:1080:ad59:75f7:6c30:2440])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm90235565f8f.20.2026.04.27.00.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 00:46:02 -0700 (PDT)
Message-ID: <20884589-8868-4596-b39a-f5bb55ce6b46@linaro.org>
Date: Mon, 27 Apr 2026 09:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
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

On 4/25/26 18:57, Icenowy Zheng wrote:
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> 
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
> 
> This fixes screen unblanking (after blanking once) on
> mt8188-geralt-ciri-sku1 device.
> 
> Cc: stable@vger.kernel.org # 6.11+
> Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate driver")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> index 8b2a68ee851e3..a5e5c9ea7a73f 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -937,6 +937,8 @@ static int hx83102_disable(struct drm_panel *panel)
>   	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
>   	mipi_dsi_msleep(&dsi_ctx, 150);
>   
>   	return dsi_ctx.accum_err;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
