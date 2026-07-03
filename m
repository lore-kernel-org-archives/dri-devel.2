Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E95C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11AD10E32E;
	Fri,  3 Jul 2026 08:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HEtRfmY6";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62FE510E32E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:26:15 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so1648935e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783067174; x=1783671974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ozhT+T+6mPThDET/tB9Bap8ag26J+JkCJ+PqMgxJIbg=;
 b=HEtRfmY67bQja1GtUYV/Deycr5T7wcwp1IbKwK0SiWnMxI97Qx+TSIiCkGOl/EFZhh
 fZNGUzfnBgBBtzgsXyG1RnTXoPQAOp8HI1vWhhnXm5G+dd15DGOVVt/mZkzPjVafim4y
 bpfplt1Y098MNUJRZmjaoPkMpt4uF4l+f5G2nfA7AixqeBBB9XdaIIKH3FQJ9v7tzqUo
 UwFBYFUKCn8IGzVhrAyZgebLt2ugd3c8fM1BbKJl1YrC6Dkn6DEClEhCD5UYVHk2jF26
 EcnSVb2BFK/5YpDm/Diw9VjqebW3m0NzTlBu0Z0JfF3vrPkV2QMtqMBiD+7HY0uYPzg5
 gTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783067174; x=1783671974;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozhT+T+6mPThDET/tB9Bap8ag26J+JkCJ+PqMgxJIbg=;
 b=bUB4CMpcCHtiFq6I78kLgqTVRHQEi0zN+WynWSawBdDQy2S3UNEpap1GeUDyl7eaSu
 85tnA/KKeqvqLtIrgPoU9OnPvTIQFgwxp7VGYR/slXF9TkkBk3g/MMTTh41o4c+H0yQV
 3dWw/OE39GfezTXSZD9stfUmv8VIM535wPIAZlTrBYHo8+Lp2Xgsq3Pxmq2YbhrAuSNG
 o0nGfNypgIF06sLB8+Fum3saklaprg0uys88esllctMlG4mGEqCMHXu0SVgvoXkKg5jk
 stNUCCuhzrr9nphXheuI/MPJLEGmUcuPE2k7KlAYfB88Aj06fhxmcwp2A5IoSLSNXJEi
 BMbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WbVXgGeqqLHU207j62+u63O3v0TulIUH7VJTLSsosTWLJ12xbP8VH6j8uTgYyCnbXAlkktYZSzOM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykI+yUazMNItnJfukneL0VOJdel+mPButb0hphWQLCsGJrLIjS
 /gMEfHuxYYQgtSvl+Kh/M5vyri8JSKGjT/sA3d6FKPDm759i75G4PRiMNhzr3LCnsZM=
X-Gm-Gg: AfdE7cnbCOnPOQa5AJEa2oxY1OTIw5fdyO0yNz9A6cR5HGxB/WT38PrWQgDPDe/+3Z+
 QE2erwsfFjFa2JR89OwklajKmfi82CwaV3La784Vzt11V72wvPhg7BjcPDugyD2QPS+H7vZhvA8
 znTLxDah+vsd35BMvsGDp8jqgGkNUQ+VO17p2FLhBYNe9AKyvMmIylA7ms03MIpccC9KoLN+eW6
 HoUkXj2qoyr2iYUJNsTEW2Lg+rU6xlOPk/WBlwvStdjhFtqVpd8/tx4a3v1Ark7JkGb55czbtvk
 mXd+SnMJpdrxUposLbksZIILAaINonfokUOXO9MPTnV81sAQQ32L7JYMPEeTiYxrBz9h+d7kAts
 huIy7HWkQBn/Dc/L6Jkvrv36SPOlLBXJUtrd5ynkrBtkWf2EfLROAPDLm0RPvw8PDz/4o7IyDMS
 yMVgcD8I2sprDMaT83vIdkL09BCEXNsREW54GallbEZgMFiQdHVxQ+KiMnY/SDddk5kMFO
X-Received: by 2002:a05:600d:640e:10b0:493:c98f:12e3 with SMTP id
 5b1f17b1804b1-493c98f1311mr37881305e9.20.1783067173384; 
 Fri, 03 Jul 2026 01:26:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e9e1:7bf9:472f:c4d8?
 ([2a01:e0a:106d:1080:e9e1:7bf9:472f:c4d8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbc75sm16877978f8f.5.2026.07.03.01.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 01:26:12 -0700 (PDT)
Message-ID: <e6c7a531-f6be-4ec9-91fe-59391cc34762@linaro.org>
Date: Fri, 3 Jul 2026 10:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: samsung-s6d16d0: Power off on prepare failure
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: inus Walleij <linusw@kernel.org>, dri-devel@lists.freedesktop.org,
 inux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <CAMyXUJmSvWv0WoBqvBScEXHnz70Nn_WUcu371s64j6HrB-6c9A@mail.gmail.com>
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
In-Reply-To: <CAMyXUJmSvWv0WoBqvBScEXHnz70Nn_WUcu371s64j6HrB-6c9A@mail.gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 7/2/26 18:47, Laxman Acharya Padhya wrote:
> If enabling tearing mode or exiting sleep mode fails after the
> regulator is enabled, s6d16d0_prepare() returns without asserting
> reset or disabling the supply. Since the DRM panel core leaves the
> panel unprepared, a later unprepare call skips the driver callback
> and the supply remains enabled.
> 
> Assert reset and disable the supply before returning the DSI command error.
> 
> Fixes: ac1d6d74884e ("drm/panel: Add driver for Samsung S6D16D0 panel")
> Assisted-by: Codex:gpt-5
> Signed-off-by:acharyalaxman8848@gmail.com <mailto:Signed-off-by%3Aacharyalaxman8848@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> index ba1a02000..04e19b5f2 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> @@ -89,16 +89,22 @@ static int s6d16d0_prepare(struct drm_panel *panel)
>          MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>    if (ret) {
>    dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
> - return ret;
> + goto err_power_off;
>    }
>    /* Exit sleep mode and power on */
>    ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>    if (ret) {
>    dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
> - return ret;
> + goto err_power_off;
>    }
> 
>    return 0;
> +
> +err_power_off:
> + gpiod_set_value_cansleep(s6->reset_gpio, 1);
> + regulator_disable(s6->supply);
> +
> + return ret;
>   }
> 
>   static int s6d16d0_enable(struct drm_panel *panel)
> -- 
> 2.51.2
> 

Please send the patch in plain text only.

use proper tools like git-send-email or b4 to send the patch

Thanks,
Neil
