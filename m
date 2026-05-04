Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B411CD3423
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 06:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599F110E257;
	Mon,  4 May 2026 06:48:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZRrL9t8q";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642D410E257
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 06:48:36 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso39301185e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 23:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777877315; x=1778482115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jaxFtQoSnlscJEi3V1l4or44PmWhxE+7z0WfULPFAyM=;
 b=ZRrL9t8q07BtvjzzcoHrOKTzou81Uub+aJdes5mGQwCTMai653fu5tnzHSvw/HBfKi
 AUQEPXS9dL03AJnOiGRCWmdLoxSeWJkOH249yknimeqkIx4+eHiF/QHZicRU74TSwP7T
 B+PX2YRVwecfa57fNF+sgjIyN55q1KboX/hieYHMgjcCrqL/Wr/dyvNcVUsVSPXG5RdY
 aODZxFjccc+fbQ0HG1U6MJU4MPDqDVnxuKvZDTGwIrRKY1DAb5fuonVvM2GdpGOjuzfM
 tGa7vFRgbMww9fm0mWKFH+Xju1oFlufKPfohz2nGheQGpNVibx77OlSeYmJiBEWmktNi
 Kdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777877315; x=1778482115;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaxFtQoSnlscJEi3V1l4or44PmWhxE+7z0WfULPFAyM=;
 b=K01tPliJKxCNio1JAGsgga5rJGxnlehIfm5SR37AH5YLxI9rm1X1Ajss/JGPYlovbY
 6ERthgDC2nTFrvG9Sgu9e7iWAxb2C/bmMuwJuDjvSdxlm0evrba59pBRuzrxpfGc/bDL
 md4VziGGDaiBU849mvYIMxsDhmOz48tDdUtmP2629McFDgktqTHQdLMh69t8o4usE9go
 3vpAlNn2fZu13NJj3uemZwkD3cLdm+JO4v2Jin6+V81VftigEJ6+euJd+jPzrHMdVDP/
 jp29qaV/VUmbVMxh7QPNJM4S7NXo6GM9f37I6CoKU8oTgslbGyqLYPXyTswwBx6rwXxW
 iPCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ857SLPbTZTO4YB5GJ1V0QDNcMvYEzy5Q20j02YBL5HAXbRuFz79j4V46t0WStnWyqZB/2OUjcAHXw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznAgNcyF/kWqsvwK8bIXO1nAyZbUefn9xfSddN+Bs6te8uXUVS
 628S6s+3dBBX668DGUyMoNlNwCiC+rVctnI53SCEvixdXzcjAuEpambo6DhojIAj76E=
X-Gm-Gg: AeBDievJdT07eyvx2gS1kq1IxE4QlcjwZAIy/t8ThHvMGIaW8Bj2ebw17Zyf2Kgl0Yk
 aETTr/pGr/oIbkibYNQ2GoLJJCElqB1sub+czuoCAjM5/gTvWxolzn6bE0DbqmG06a1UDvVZAWt
 ckTzLajghxG3TnSh9lVwGzaBsj1udWMttZYD0KqrC+LcESPSzF8sTNAQX06y9Q8EonIMD9TwplU
 A02CnL+6V3/6hMjaQLUNerDzQcrX4aSiin+ItBri2AZxeqjDsygk/yYyBG2yM3JHeMTnRUZMaiX
 BKsC9fTKyHXIIFxi4PFk9ameOuMtPNedB/7svTSNDT3GZDNPmfzbJUjvJ9bxihFIR/7CNbpx3rF
 IRAm6sDtKB1+ED833be1cbLheC1XLPCi6207TShapuElL9VH8y/gmf2IKAaffaDD2Tkh2E8uugd
 D0soNkUkvMXinSBZ/4rU12iLjIt2SjC6oNVJ2Od/AjSxenvYK6s7+DJ1xL2vBoEXwwqdpK2zqoD
 JOWCWOG5Bv2q/vQVsl40LR6IwmW
X-Received: by 2002:a05:600c:45d5:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48a98638a3dmr131035275e9.11.1777877314308; 
 Sun, 03 May 2026 23:48:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:4245:af61:1735:3752?
 ([2a01:e0a:106d:1080:4245:af61:1735:3752])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82301b7bsm363878875e9.11.2026.05.03.23.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2026 23:48:33 -0700 (PDT)
Message-ID: <882682c6-2207-408c-ab35-96140ab462ab@linaro.org>
Date: Mon, 4 May 2026 08:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after
 sending disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jitao Shi <jitao.shi@mediatek.com>, Douglas Anderson
 <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
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

On 5/3/26 11:17, Icenowy Zheng wrote:
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> 
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
> 
> This fixes error messages shown in kernel log when unblanking on
> mt8183-kukui-kodama-sku32 device.
> 
> Cc: stable@vger.kernel.org
> Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index d5fe105bdbdde..658ce64c71eb2 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1324,6 +1324,8 @@ static int boe_panel_disable(struct drm_panel *panel)
>   	mipi_dsi_dcs_set_display_off_multi(&ctx);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
>   
> +	boe->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
>   	mipi_dsi_msleep(&ctx, 150);
>   
>   	return ctx.accum_err;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
