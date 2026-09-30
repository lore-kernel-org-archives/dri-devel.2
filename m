Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D87ECA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A06C10F3D2;
	Wed, 30 Sep 2026 13:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AlyvTR88";
	dkim-atps=neutral
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com
 [74.125.229.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3080B10F3D2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:32:28 +0000 (UTC)
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b8c1b8d7b5so4761898e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790775146; x=1791379946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=00vEEH7L1j3RTeCAPOrHPZHBxJBgpO2ITSxaC+oPgZQ=;
 b=AlyvTR88h6nMbVLVLFWNch5xRSA9Bmh7HsMbvgHzU+T1aSBAIgPqnU36Rx8H/Kn6AY
 JBuNm8A6GqcLiwwweXpU8Kj2VOT4LEBHEMEYFYxKF/5ztFrL2wRVapl2ZlH2Wfg9LR3j
 H6y6XdGWqHzAqqoRo5Lv0yyXwURFpMvbnw/lA/G8qlLi6hc17T8qKhpLzqHC2UjMdrCE
 ZjcXcOz4BEod2d2E+UICUXI2yfasuCn5g/OEsoEZFBWUyzk5tC5fMs/V47KN6k/goEEN
 4LfJSLCm5mNj2+ZSHGkU1mhaLELh2yEGoaWQaeqe7mdbxl6hH+0vLDZzhh+5NyX8VB9w
 6U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775146; x=1791379946;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=00vEEH7L1j3RTeCAPOrHPZHBxJBgpO2ITSxaC+oPgZQ=;
 b=saZSCWYUk5rO/xgVIKRXr5JNb+CSKRSrzlz86GYZNf1Bem+WEw7E25a74Y5Exob+ee
 Q7AFzC4N3AFhVDlfy1kaqg9pvGN/VzNf6LwSLCgwK3KMqQbIrsB5nCYLZ/NhEvwBTBj2
 hqYJA0nqZ/dNTsWB9BinWZdR3TRrOBS8ASizvvLjMlcwD2qE8rXy0Dx/9ui7nn6KsOQ8
 GVBLxTZbA3KNMU/XufyzX3I1H+QwlBO4m/d0B5+M+7Scyk2wUnU8C0VZY+n3LF2wd2DY
 AsU6a6krI8EEV9TwTsVuN+ov3qjZ/bHKU5VaArWPK6/yHMWr3CJPJpSf6ei4uP9EWOJ+
 kC2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjq1U+CaXCf7XZWEaGEivX+A1IkRjxc/PdhO5Z+0qBVF5eDHJqozHRzcD6T/QT3HrxKSNZ3Q+4Wp4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYISsn3SFePNtKtfqjdu9goiHCYPZicnm+6Ik8fA4RviFZsXi2iO
 J8Jh9JtjqnRHhFNOtxgKVFKvkJnLJK5285sYDIRbSqWHBA6l0giZCgzz8bNePW5wwAk=
X-Gm-Gg: AYBFou0Duc9kVTiyeDYfSQxuDDO9vV9Lt9zeCuNX1bg/3mvWvCbPq6JVLS6PnrggpGR
 X+H84m+3VioHw3HEttuKRUURDeMnvl38fWfCXsLMIexxHwliGDpYeOksEgvQQWrZ6ZdKwj+/hco
 34GSMbpQTjnud+nYPOfJiOFOH+jkgw7Up4tON4bFW2OmeymsOx3IM2tyx1qLpPfXwrfZx8mHXVg
 l79bwW6Mtt6ulbLvldhseGbVjW4tWvFJBmdcNvVqXMzRjrfdOaMkJhTWirU0Ol4tLxKl9Q1446R
 AYejuiJ5UtyxyoGcHGrhE+kTd2eLLb/hf2BW6g8A2EIjtGaENdcl6Fcovfu2c++6a9wPEe2+kNY
 q2HwvqFWDhPUmQJ/GIM2yKAuWvsMm4KiH31bRfoL7CTkMt73GAD+Q+Pn/3cEWQzuCU9h+kg3pOD
 hIc34IUKnkze93Z8sxwOdDIDy3iraBSHqwS4/QlXOW/JN1UVJ6FtZ1dSDBA2zKEp7naoaIh7C9K
 gvYqfH76htulNp0w6sDBpcFIY0dBkU1jjjk68t3naOrLvlaBcQzdyZplJanum2Lh+IhRaPyjipf
 dSSLUw4=
X-Received: by 2002:a05:6512:290b:b0:5b8:ea1d:ce0f with SMTP id
 2adb3069b0e04-5ba40600866mr515249e87.67.1790775146114; 
 Wed, 30 Sep 2026 06:32:26 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3fbbc003sm357173e87.12.2026.09.30.06.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 06:32:25 -0700 (PDT)
Message-ID: <742d5bab-51cc-49f0-825a-f299a055bb1e@linaro.org>
Date: Wed, 30 Sep 2026 15:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
To: Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve
 <aesteve@redhat.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Benjamin Tissoires <bentiss@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org> <artyl8fD3zzng8Uh@houat>
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
In-Reply-To: <artyl8fD3zzng8Uh@houat>
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

On 9/29/26 10:39, Maxime Ripard wrote:
> Hi,
> 
>
<snip>

> 
> panel-mipi-dsi-spi is a generic panel that will load a firmware, and
> quite similar to this one. google,android-pipe and qcom,fastrpc don't
> attach to anything and will just open a tunnel to userspace, which is
> somewhat equivalent but more dramatic than what this driver is doing.
> simple-card or its variations will just instantiate a kernel driver from
> the DT and is used pretty much everywhere.
> 
> I reused the binding from panel-mipi-dsi-spi for this. It was reviewed
> by rob, and acked by a panel maintainer, and 4 years ago, so we're way
> past the "oh but we didn't know what we were doing back then" argument.
> 
> So, let's phrase this differently: what's different about the
> description than panel-mipi-dsi-spi, or any other binding already in
> tree?

The panel-mipi-dsi-spi still describes a class of H/W control interface,
not a pure software driver implementation type.

"panel-mipi-dsi-bpf" or "panel-mipi-dsi-rust" or "panel-mipi-dsi-cplusplus"
would be the same problem.

> 
> If it's the BPF part, BPF is not Linux-only, and there's hardware with
> direct BPF support these days, so it can be considered OS-agnostic and
> not an implementation detail.

If somehow panels used a standardized MIPI firmware we could define this
in DT, but here we're basically inventing our own type of firmware from
thin air.

Neil

> 
> Maxime

