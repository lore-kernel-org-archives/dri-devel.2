Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3834C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAF710F917;
	Fri, 25 Sep 2026 08:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u0RqFRTu";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9113C10F917
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:47:06 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351832so333399f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790326025; x=1790930825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ybGJMieDnUAKotpO3xSLkaT24MxuG36dkIyHYhn06KA=;
 b=u0RqFRTuBuvvA+b6ZLbpEDkEjnro1+LncDljv8ukEHK72EwYr5c1AaxU5Bi0tK4VDn
 LGAVKRIby+5yeDuuIovbz4NDPbE2XEOcpbKCVaENmE0xGwEwSg42aoSe20FYWeTaoMo6
 +aJMe0FrhePiQNIaa3ZdGF7t7CAxT5AiCmkPaiiviKMegXBa1dbkwHjGJqdHWN+DHiKf
 moTYExjfORIsIoXGSymMaS4BXEdQFuAT59mcJa6Bl1BPbSaj0Uf9cONkKvIYS8MXUzlE
 Rf+6yn25MXnwseN/xmcz9bjUURzgxzWtzJOYQ5ucE17Cg+H6Ir9Z7V9NcY2Wg2nElzzg
 4rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790326025; x=1790930825;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ybGJMieDnUAKotpO3xSLkaT24MxuG36dkIyHYhn06KA=;
 b=jYrJ0/A0bwLjBatoUVgwcoE3EW7iZ/2gWtgZp6Lqhe9tVgiT4w7MEDd5RCPeFRXR2n
 Ym4hwcNyy0wsfaMonLC7/PNa+ycZoigNzQxjG05/AR/TeGY+cY3GnclPGFC28AMb9/+t
 JNJ6Gb9EUG+vnpFV8Pxk6wBzLLP2QKacMTfutApq6sVrZJa8gjsnNB658v//VZ2jH3BE
 tg665/B5oRwVg8d7t6l/Uhi28eH0JADqIcFvjSNVTYg/FXajMp4mtzppRKYxNPsp9ojp
 oM+98KptVUrQAlzryo0w4ab8iHT0jRrKKerbyT7GhCr1NGSi/FejoZTMIkPZJpj5gsqr
 xBXw==
X-Gm-Message-State: AFuF++l89HMgXfJz1Gb3mH2IoEK0gOlVAbg3RvsrZKQscRgJlPtU3HlI
 qPgqtw/uzSkRf8CiGV2QQJYdqCJFILX4DcZBrhCCg1KNIDXA6kllQxQs6WavA6Ij4Js=
X-Gm-Gg: AYBFou2HxVRUt34CEIjRk6k+YBIlaz8rc///WqR8EKFAnpnNgJzdmoS/irmdPFvEMHr
 ctCxWvAhF4oB7YpI/wU4S1eDbaxbi93CZuBIYu1qPr73lVBNXecXw3wPb4jnFbSOhq8a8AJ8u4V
 +7JNEtmkDH18S9WdtuK+sY1WSag3JsDIVRmhW70S7HS1TuclaHmofr4DRlMNSh2Nko86K0y0c9z
 Qn+UhhO1TQ5s/c+Uwnq3sQ5FaUKLTbh2enQvplX9kACMyGMOZGoYcZq6KBIw54vWla8iIokqXan
 4fp2uH0C+RyTP4xOyKkvqwTsR3MbL1qT3Qm9Yj58B9oepPB1IPFPyVbuOGKXlBmrtHs016/b3Hn
 gohJrWY/LwQaa047fWSJ+Km6R/B9vudVDuFH84BSfLsqPX9jAFPD3udNaOiBSlKtoN+82tJPR1M
 Vt5dXm2A62lswCsDZph+DjRGTHydnCRKkU/6QOwycsce8XMYSNP9uksgfBRT/hMc9iirt+AYgW2
 w4zpP09Bd4U6ZrpB4kI8hKnVouhX+pjJplEZ6R5cBO12bSDEBnhU/k=
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id
 5b1f17b1804b1-49fe66841f8mr87493745e9.0.1790326024865; 
 Fri, 25 Sep 2026 01:47:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3151:fc9b:d41c:770b?
 ([2a01:e0a:106d:1080:3151:fc9b:d41c:770b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff04440e2sm41053585e9.0.2026.09.25.01.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 01:47:04 -0700 (PDT)
Message-ID: <6399bb18-f463-4d6c-80e1-0efca5e7768d@linaro.org>
Date: Fri, 25 Sep 2026 10:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 3/3] MAINTAINERS: Add myself and Ryan Brue as
 maintainers of NT51021 panel driver
To: Nickolay Goppen <setotau@mainlining.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260924-qcom-novatek-nt51021-panels-v5-0-f5eaf5685c9c@mainlining.org>
 <20260924-qcom-novatek-nt51021-panels-v5-3-f5eaf5685c9c@mainlining.org>
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
In-Reply-To: <20260924-qcom-novatek-nt51021-panels-v5-3-f5eaf5685c9c@mainlining.org>
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

On 9/24/26 17:08, Nickolay Goppen wrote:
> Add a maintainer entry for the new NT51021 panel driver
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7291238bc09f..743c785b4558 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8354,6 +8354,13 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
>   F:	drivers/gpu/drm/panel/panel-novatek-nt37801.c
>   
> +DRM DRIVER FOR NOVATEK NT51021 PANELS
> +M:	Ryan Brue <ryanbrue.dev@gmail.com>
> +M:	Nickolay Goppen <setotau@mainlining.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
> +F:	drivers/gpu/drm/panel/panel-novatek-nt51021.c
> +
>   DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
>   M:	Lyude Paul <lyude@redhat.com>
>   M:	Danilo Krummrich <dakr@kernel.org>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
