Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE726CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 534F010FFD9;
	Fri,  9 Oct 2026 09:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D0dK+17s";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F390F10FFD9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 09:30:34 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so33049075e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791538233; x=1792143033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ySxG2l0k4bpp/Tb+8P52vg4ThV1MvpjerUMZY+o89W4=;
 b=D0dK+17sYcrtvhtWrJyle1aQNgrrMLwXvPb1BXOAdC7xI/TlhZqiVMIaAYvHNut/1/
 Uly0Cltjc48JthzpacR3qp0flv0w5HLH+ziVWJKRIM5bKGrXOrL/wuHWtZJW+YoGa68b
 VyAPFNDVNYYp4ZdMBejgBCEUFb9tN/5grWUr2cRcxAU6WF/3TvBHukXcK50eoH9DlGFy
 fxFr/m+0C7l5DcZHWSu7r3q4P5zBVb6qLBWhHUa0AO3qxVtb/XQjp9fSHegspbJvwduu
 Y71rn0pCPv8weVIFCLfuj1wVxwRbjFHgnoJh3giEFGp58tsIBp8HG4881cvG9oV5QLZb
 k/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791538233; x=1792143033;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ySxG2l0k4bpp/Tb+8P52vg4ThV1MvpjerUMZY+o89W4=;
 b=W9dXIcFzhMuJkH1sbO6tIhY8wO+cty2bgIIRWtKNWqgPr0ZRW2UiGhRY8i0mdr7Vbt
 wSuPR3EqX/0zdMkzQsoOefkE73rMwFENIGsqcev7ZvWnHOUPQNlRNRsZvSzfNrQVoYYX
 lMGk4bn3aTf+IbQ97N+5j9K1bs6DD7cg+6Cvng1hzlwpzwleK6xMbV2ZgznWDIcLRLtM
 aF0MfHCl3kkz18kus+pzgVszqt2hyMIdNX5+XLxUoPTwF4GYZbmc0hC+n4qPrzpCAxOA
 OlTOcVQe9gQrjnfTIYlyW7RF1BfuZ9gkeD2JWHM8fNxjCkpazq3F+mTukzc1BbuQDGs/
 zgVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7LKcvw/N8Hsj6QiopRx//vJrMKmQy6kk9dREkmWmYp3M8rY2whn4nkp1swm1+RJcy8lZEJIhhUgQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mr9ljWcodvunPE7Z8s+7G9chxDWhR/m7P/GmZBxlhP8Rl+RyLa
 P2GqtJHCFKiLOUlw2zpeWmHK6x2PHoV8MRxMIJRp5CREj+3N/L3QMW0KmnHzwVvmERw=
X-Gm-Gg: AYBFou2HO2zyIXMnqIUjs9T8vFXxSyzpFgcSjqvpS5mRncRrys+Ap0xFSXZMy91zZCL
 VjuthnXl8oZH3S6k1VMRoKGMGSfrjPaoTGpcOQ6Lo0IjN3HNR/yBHc8VcgjLP8mdF4IOQ58Mmyq
 Ie13vYRn5/k7N/yUIOfaOne0tQtxXlCvkKAkDECesaYNlvVs1ff7N1ku7yPzBJzo2PjF6bs7IK6
 FGJrKsZc9Lippxb8xNvuY2xN0XY3zVMA19YPW49tBJhThXinAckxq+yHW7j5EZ9cAJNIsAtIKJ2
 KUciK7t1XN5RW/0CZShnBn3WFGHvai4iq70VikGQ57iSz2b1dwFGcCGaCsyknRjSz8xk/bdtVbb
 a5TlRXQEVmW+sl8+lL96prXc6BG9fatdzJJRUpj9zBU6wkK/qZ4X/FYHmfmyjkD/eetQDJ/MoqS
 zkxTvjL0QPpoQaflGdbtHbyJZroXIpBL+0GZ02q/AcAsYr//nP9meFtjMOXEL0yX93RavYwGSJ3
 ZstZaxno3f1aOCvalCoo84jhwtxsQo=
X-Received: by 2002:a05:600c:46cf:b0:4a1:7e1f:21bc with SMTP id
 5b1f17b1804b1-4a18e4d6636mr23240285e9.29.1791538233076; 
 Fri, 09 Oct 2026 02:30:33 -0700 (PDT)
Received: from [192.168.151.76] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf35930sm43922135e9.13.2026.10.09.02.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 02:30:32 -0700 (PDT)
Message-ID: <6b9cdfd7-9f01-4ed9-a4d7-6b2949452b6c@linaro.org>
Date: Fri, 9 Oct 2026 11:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/4] drm/bridge: simple: add Chrontel CH7218A
To: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
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
In-Reply-To: <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
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

On 10/9/26 09:55, Xilin Wu wrote:
> The Chrontel CH7218A automatically boots its embedded firmware and
> operates without host-side configuration.
> 
> Add the CH7218A to the simple bridge driver and expose its output as an
> HDMI Type-A connector.
> 
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>   drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 3fba7002322e..fab793fb12b5 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -275,6 +275,11 @@ static const struct of_device_id simple_bridge_match[] = {
>   		.data = &(const struct simple_bridge_info) {
>   			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
>   		},
> +	}, {
> +		.compatible = "chrontel,ch7218a",
> +		.data = &(const struct simple_bridge_info) {
> +			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
> +		},
>   	}, {
>   		.compatible = "mstar,tsumu88adt3-lf-1",
>   		.data = &(const struct simple_bridge_info) {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
