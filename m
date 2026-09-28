Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FDACA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899FC10EB70;
	Mon, 28 Sep 2026 19:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PP0gpRY9";
	dkim-atps=neutral
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com
 [74.125.227.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4336610EB70
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 19:16:24 +0000 (UTC)
Received: by mail-vs2-f42.google.com with SMTP id
 71dfb90a1353d-5c963d7503fso1146266e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790622983; x=1791227783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BQ/QxsaYA9sPy0Rq4QivZtNIQwREX4bWNN8dGL2Ve94=;
 b=PP0gpRY9U61JF4snEJXdHtiEay4tmvdd08HR7Sfw3nrdBE2uE+9Vsz2cVGF/utuzn3
 4b7HaiDQoi2KGSP2LeA2UiWwzC5Y/+Dzdd7g4HD31HAGYaMocBLlZZ4VAM1bRXNd65O7
 /9aU8y0KLWOhaxvugY4nFRbY0fi1Rznd2bh+qQjRpzBdVO8jYPHysXI47HLcSp/v8m/h
 EeC5ySnRgtmAqqL3u7c6sEbZE2hscIixad/0wiL1pFXjUC8zAR/1CQmaO3k4jFxcxc0+
 0cbylCA8H0R7hmqxJYIZ/Ygbk1SqgvKtxtyjQZ2IfBFQK39oqLfxxvlzryDJeB5Lalrr
 9Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622983; x=1791227783;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BQ/QxsaYA9sPy0Rq4QivZtNIQwREX4bWNN8dGL2Ve94=;
 b=hlPffAzSMuzqInxwB7a6mBC6hfijNwiaOBSdqLBd1tIeXVXyt9T5w8SR/gvvxrXJZS
 ygjRvXCPrJbesMJy6FwLq7nbt4Zb0wqCvy+jMnONOeoodAO1ZEYWNeHnckiOQ00AJgQ/
 LIB9UFc4G1uXWrk9kQA98A7PS0YaDOUEBPYiO99OtfiiU6N8QjNvgjJUf0oLR2CiiZey
 GqC8xO+vgxwDq5t51iFdW7Npogg4b78tB51UL800xB2QfrBdmHUBD2ICW3sXBWt2XR2h
 LaGscPz4woLWYKaZlWuxrFWUGWmI1DKk5Zzw24nv1aUq8+wRF/X1BJkyetpGbtcqmJlA
 C9IQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/MBE86N+tTiJd77/1VIU4wDDCsZggWN4YMR9wCch34TdssIuCp87vjmbY4AnRjEU28OoXhDPnCNU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIxRixx9oqdxajiaf4OT6BEB6lJNtxZxkMh6T7N0nC4FAqAQ1zR
 CHxpXoVr6Fom+OJdbgOd6IbHS/r5AlTe5aKEBLIf9Fa6WxdYvgiTG+wZY5SKz9XIGMc=
X-Gm-Gg: AYBFou0dKuLG4iPWmIWfN3y/Yq7sPnbTCJDQ07AGMKR4rbs5+XunzfX9fGiUAFopxhs
 hW+0FViU7vGhJiMktGqh02ag41wJSmABFh6dJPJpJEr5u/Vrenz9BPXgyzycREZ28GyNhq+bOUx
 VD033fVuLSR8eCAVClB1vY8zZir9E0RFNdQVCQiMoPzeBOoQHaNuCgDG6bqda+Xhohnf0lB01KU
 V4puXJMJWGx5aD7UJ5Rds/NM5B8ugxCHLkKNjOqZKh5giYoWqd9MT0gs60gOoyvOT6VQAX5C0WS
 afjlSL+iF3zXGzjQ12tD7Q8XdReaMS5OCCbwDFZ3L4dRJJG9MEXEVDMbGCicEa5SgJGaS2WOYZg
 VnAwFv6TL3R2fLKF0OujMoigxzv0kh/LzfnYqOx2VTblCn/g/hPVF7RBsZ0h8dtrXqGs6vLQYa0
 qefFILmB14yeSx+J1mPSw8lap9kPEaJTGmo0W0F6hMx/ivT4fNRnOhEG3qliH7TsLr9GUb412Pl
 RrJMTN2WmVwKu/VK9bts9i5xQieKdg0siXdjhEH/EQKwhctcsQe5nP/TFN7TYKkLMZeTov8Ju/u
 tGKsPPE=
X-Received: by 2002:a05:6122:1313:b0:5c9:a60b:e5d5 with SMTP id
 71dfb90a1353d-5cb0b67e6bbmr5760667e0c.15.1790622982793; 
 Mon, 28 Sep 2026 12:16:22 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5cde4f969b9sm10052205e0c.3.2026.09.28.12.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 12:16:22 -0700 (PDT)
Message-ID: <8fa0c826-9d4a-487c-b7db-5412118364d5@linaro.org>
Date: Mon, 28 Sep 2026 21:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
To: Maxime Ripard <mripard@kernel.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
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
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
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

On 9/28/26 18:22, Maxime Ripard wrote:
> Most MIPI-DSI panel drivers follow an identical pattern: acquire
> regulators and GPIOs, perform a reset pulse with specific timing,
> send a vendor-supplied sequence of DSI commands, then enable the
> display. The only truly panel-specific part is the init sequence
> and power-on/off timing.
> 
> The panel-mipi-dsi-bpf driver replaces per-panel kernel modules
> with a single generic driver whose panel-specific behavior is
> provided by BPF programs loaded from userspace at runtime,
> following the HID-BPF model. This enables new panel support
> without kernel patches.
> 
> Panel DT nodes use a two-entry compatible with the panel-specific
> string first and "panel-mipi-dsi-bpf" as fallback. The generic
> driver matches on the fallback, while the first compatible is used
> to identify which BPF program to load.
> 
> Six normalized optional regulator supplies cover ~95% of existing
> MIPI-DSI panels: vcc (IC core), iovcc (I/O interface), avdd/avee
> (positive/negative analog), and elvdd/elvss (OLED EL driver).
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   .../bindings/display/panel/panel-mipi-dsi-bpf.yaml | 184 +++++++++++++++++++++
>   1 file changed, 184 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml
> new file mode 100644
> index 000000000000..9a20a21cf70e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-mipi-dsi-bpf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic MIPI-DSI panel with BPF init sequences
> +
> +maintainers:
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +description: |
> +  A generic MIPI-DSI panel driver where the panel-specific power sequencing
> +  and DSI init commands are provided by BPF programs.
> +
> +  Panel DT nodes use a fallback compatible so the generic driver matches on
> +  "panel-mipi-dsi-bpf" while the first compatible identifies the specific
> +  panel for BPF program matching.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - description: Panel-specific compatible string
> +      - const: panel-mipi-dsi-bpf

I don't see how this can be a valid hardware description, bfp is a software
implementation and has nothing to do in the bindings.

Neil
