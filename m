Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F5606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=er+pQOom
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEB410E25A;
	Tue, 24 Nov 2026 16:12:16 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB1989091
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:12:09 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so40238685e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795536728; x=1796141528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+6LKQYgkr2YxzPjh0brr5Y4vnuislFHhKsvQIh4zTc8=;
 b=er+pQOom3K+R3X/hx+d+2iOa5zhJvhEzwTfHhTktQ+XMY1GQeJKZrF/sEDQ+4DqCev
 I2PMt/wN40VD7GlOOE+CF0p1MJWNH4lAlV4ztWUXUPRDg1sD4Xfsis2y3FsTrQIAZxN5
 /1O5TaTZNwsB+mAxiiCvea4dcs4oqJX17Up+tbFMrqAbOnfy7nAmPsR4xgD46o2WhTL2
 6eMSD0fTjv7vqwo7K109tuecVLw7pnkQlaQrLhHfOLsuvxk8ii3BFcrO2DjBZxTgQzY2
 qKj3wfeXAPp6cY0W2AY1tePiTDq/wMDfjjcS2cvpViRcO4J/uA5LtQh1ffgifyNh+zvd
 Sjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795536728; x=1796141528;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+6LKQYgkr2YxzPjh0brr5Y4vnuislFHhKsvQIh4zTc8=;
 b=G4tAhgGwhH2KmKa/zmEjHdbyOdOg3yJc+/Oe9WMDEg8jPhNjHVPuTDQGMe60eXoHrj
 JqPSR4w5lMdWqeQhkAafVPIFXFcQafactd5ESE02709SsWYVh4CqC7yJOBfYM9NtrkvH
 JindGZi6Xen+792KKs9SZ/7uuhoAxxWp5ENlgaL4cRxNxJL2/6i1EdjaFtS0ZxpHr3ls
 /Yd+2ykaJPvZsEXvAX5yZCPw8hqClIukPFX/ITdSurfCS1HS9e5QBiliYLa9RAAVMBVd
 uQzIbRyuakWhnAkKXvgcOabO0hbkxXJwjKF4dTFzBK2J//iSkSAXqW5vs9Ow5tKgCkAm
 yRKw==
X-Forwarded-Encrypted: i=1;
 AL+hErGQrzhkzvGxE857isvqkWVGBwru3M61GBJMj7EHcUcrcNteOQy56fZfaNtgjzzBqni0uawoFF/lzXk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dk+h8vRaaGBwfXOd1AmNaanwxxa/Y+QtbCYq8MejmPGcZrOZ+
 ck4PrE8Jznu8puOXEZ/WJwqlwPYH3cl72nkgcEPwKsKJKiXDXfgsGRw+72QguPuPY5Q=
X-Gm-Gg: AZFdTZfjPnJzV/WzE7s1g6W8B2sL+YkQwQC2ZdBKNQF8JPY1glDo+EW+X4UBAjUNSlg
 ST9MjhTRZ2OScWTrVXKvshSNmTAmyDhKlW5U0SuI+kuJlv9dRtmMxQVDB9+FwUCqQ/aZID/5FHJ
 BKAq2AarhF8IFiCGX4QPfZgxfec77dayrw6HxQqoXidt5UlpSAiY6hZPlfUmiGI1MYu2WtlwERJ
 Dzg4cfNvGurh8CpzVxaLqYi1pN6APZTBZ3sSzqy2rRqY8lvJeo7RUrlp2piZmqhyHN8r43NzVA1
 cLjnDuTTmNgMkI8nawSf6x68aIrQQWXgmr5kzbufk8tbVqEgshX0xNA1l40p+ZhGlnUdRdQdJBj
 tnnBGW8TIcoI0ts87qasZ2E9zgDiwp3HcEa7Ik2jms0YVu+vDykBE2vH7Jdtp8xelNnl+JWhgL2
 aLkJA0XAUz0lgbdQgFo4pFDUKJE/hhGAcJRDMuqdm7uLHgp/o/8DP76ha85yWNR0CiyW2dj68z0
 s6oh08o+ilU2TnO0Etk3CNbWC7a/dHg1rkwxW5hxeAHNhm0H+hJB2DWKYApBYoYlWK6tcePflTF
 hsupV5B9srDxDJABHh5Kr0+RcAkmER3dozlW1dQUkejQIUHkX5bX+WEFl7MR/A/mUiHuwI3rBn3
 S4Q4sp5Js
X-Received: by 2002:a05:600d:82d3:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4bb8880f0ebmr344659275e9.9.1795536727863; 
 Tue, 24 Nov 2026 08:12:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:ac27:24a0:7b1a:dd94?
 ([2a01:e0a:106d:1080:ac27:24a0:7b1a:dd94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm358970025e9.0.2026.11.24.08.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 08:12:07 -0800 (PST)
Message-ID: <afcf78be-b017-485c-8e11-402b0948c9f8@linaro.org>
Date: Tue, 24 Nov 2026 17:12:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH 0/2] drm/meson: add HDMI support for GXLX2
To: zinan@mieulab.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260718111527.119231-1-zinan@mieulab.com>
 <ac5ef957c03ab3bf3fdb464680f3b024a883aefa@mieulab.com>
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
In-Reply-To: <ac5ef957c03ab3bf3fdb464680f3b024a883aefa@mieulab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/24/26 15:19, zinan@mieulab.com wrote:
> Hi Neil and all,
> 
> Following up on this GXLX2 HDMI RFC from July. Since then, users have reported working HDMI output on several
> S905L3-family boxes with a downstream implementation, including a P291 board. Their reports are here:
> https://github.com/ophub/amlogic-s9xxx-armbian/issues/3604 <https://github.com/ophub/amlogic-s9xxx-armbian/issues/3604>
> Before I refresh the series, would you recommend keeping the proposed amlogic,meson-gxlx2-dw-hdmi compatible and a
> single MMIO resource for DWC and TOP, or describing the two windows as separate named resources?

Please rebase on https://lore.kernel.org/all/20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr/ and adapt your patch.

Thanks,
Neil

> 
> Thanks,
> Zinan
> 
> July 18, 2026 at 8:15 PM, "Zinan Zhou" <zinan@mieulab.com <mailto:zinan@mieulab.com?to=%22Zinan%20Zhou%22%20%3Czinan%40mieulab.com%3E>> wrote:
> 
>     This RFC adds HDMI transmitter support for the Amlogic GXLX2 family,
>     observed as an S905L3 (CPU major ID 0x2a) in a FiberHome HG680-LC set-top
>     box.
> 
>     GXLX2 is unusual in that the display pipeline, clocks and HDMI PHY follow
>     the older GXL path, while the HDMI controller register interface is
>     directly mapped: DWC registers are byte-addressed from 0xda800000 and TOP
>     registers are 32-bit registers at 0xda808000 + index * 4. The existing
>     G12A access callbacks implement this layout, but using all G12A match data
>     would select the wrong PHY initialization for GXLX2.
> 
>     Patch 1 proposes a dedicated amlogic,meson-gxlx2-dw-hdmi compatible
>     without a meson-gx-dw-hdmi fallback. Patch 2 adds dedicated match data
>     combining direct register callbacks with GXL PHY behavior. It also handles
>     the GXLX2 value for the 297 MHz PHY bucket and adds the compatible to the
>     Meson DRM component match list.
> 
>     This RFC depends on the separately posted common Meson DW-HDMI regmap fix:
> 
>     drm/meson: constrain the DW-HDMI regmap range
>     https://lore.kernel.org/all/20260718090710.70534-1-zinan@mieulab.com/ <https://lore.kernel.org/all/20260718090710.70534-1-zinan@mieulab.com/>
> 
>     That formal bug-fix patch bounds register iteration below the directly
>     mapped TOP block and prevents the legacy 16-bit indirect interface from
>     wrapping. It is intentionally not part of this RFC so it can be reviewed
>     and merged without waiting for agreement on the GXLX2 DT ABI.
> 
>     I would particularly appreciate feedback on two DT ABI questions:
> 
>     1. Is amlogic,meson-gxlx2-dw-hdmi the appropriate block compatible name?
>     2. Should the DWC and TOP windows be represented as one contiguous MMIO
>     resource, as in this RFC, or as two named resources?
> 
>     Evidence and disclosure:
> 
>     - The GXLX2 addresses and 297 MHz value are factual results of analysis of
>     the HG680-LC vendor kernel. Firmware SHA-256 and focused behavioral
>     evidence can be supplied if useful, but no firmware, kallsyms dump or
>     disassembly is part of this submission.
>     - Public Amlogic-derived GPL source documents the ordinary GXL 2.97 Gbps
>     values and public GPL-2.0+/MIT source documents the same direct DWC/TOP
>     access mechanism used on later SoCs. The implementation here does not
>     copy a vendor function body.
> 
>     Testing:
> 
>     - An equivalent Linux 6.6.18 implementation boots from eMMC on the
>     HG680-LC.
>     - 1920x1080 HDMI video was physically verified on an LG 27GL850.
>     - Two-channel HDMI LPCM through the display and analog stereo audio were
>     physically verified.
>     - The downstream 6.12 port boots from eMMC with working Ethernet/SSH and
>     has physically verified 1920x1080@60 video and HDMI LPCM.
>     - With the generic Meson non-CEA mode-range change already present in
>     current mainline, 2560x1440@59.95 video and HDMI LPCM were physically
>     verified on the display's native timing.
>     - The RFC port builds on arm64 and its binding passes dt_binding_check.
>     - 3840x2160 at 30 Hz has not yet been physically tested. That test is
>     required before a non-RFC PATCH v1 because it exercises the
>     GXLX2-specific 297 MHz branch. It is not a blocker for the verified
>     1080p/1440p use case.
>     - No other GXLX2 board has been tested yet.
> 
>     The initial RFC intentionally contains no board DTS. A downstream-only
>     HG680-LC DTS is being kept as DO NOT MERGE until the compatible and resource
>     model have received initial feedback.
> 
>     Assisted-by: Codex:gpt-5.6-sol
> 
>     Zinan Zhou (2):
>     dt-bindings: display: meson-dw-hdmi: add GXLX2 compatible
>     drm/meson: add GXLX2 HDMI register support
> 
>     .../display/amlogic,meson-dw-hdmi.yaml | 7 ++--
>     drivers/gpu/drm/meson/meson_drv.c | 1 +
>     drivers/gpu/drm/meson/meson_dw_hdmi.c | 33 ++++++++++++++++---
>     3 files changed, 34 insertions(+), 7 deletions(-)
> 
> 
>     base-commit: b0a652436b892eb9a036a031b33099dca036faaa
>     prerequisite-patch-id: 0a689485bbc3c1d77d52aeee0b81e4943d1e904a
>     -- 
>     2.43.0
> 
> 

