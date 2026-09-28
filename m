Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82436CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C291110E948;
	Mon, 28 Sep 2026 16:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lR/rtoNS";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1745A10E948
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:40:08 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff23af865so25967685e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790613606; x=1791218406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FZUYNBRcOcwahT/HwUn9HlQGjcQyMs/osOqncN2KOUo=;
 b=lR/rtoNS4LH1xDEI/1Xi3Xl9hoskBm0xcElPGYGpz40wG8nC9uQy7LSXN6N1ruEvDK
 YuKEC8WvTKtfYv6yfKbqEeQHBHKFa2fia4bOMQL2ucHJQlLG3KuJHseZPSv2AeZGRvYu
 zsaGYAFmJqwioWb0ih9mwrfyk9dNkzDqZkOCewZphIGgrRusrpeXQ9lS3FYSysEisoEJ
 oRujHdQF1Bw6tYVIJqvxbnSpC15GpJZ4kGsCC6R3PWPxsHDvjwLA6gzrsyWbwHM9mWio
 ns8JyRjGR9yhEeayYSmgp4JhrHlKyV48f5B0I7p+qAZT/nG5Lx3V/5L1Y1OXCGAWQs7R
 uCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790613606; x=1791218406;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FZUYNBRcOcwahT/HwUn9HlQGjcQyMs/osOqncN2KOUo=;
 b=xYZlBieXIDHU42qSZXfLBWnHf9pPhvbm55Vrl3O2LGgfu/fHqyOkbVCLb5wboIzmD8
 uwkZRWQxDSn6spzvOJ3DJcYZRiTaYKZTYttRXaOzOfI9qQ+8dFJPIgj2C+y/C3uxhXH6
 P1ZYJRRpk7np76lOCULPSTfHsUHL1ZxPZnAwovcb1ujJE6XbPZueveST1iDQDnQ6IxYB
 mkkheV+ezx0DEcnNYrUvrduanSj//QEIr8FF0VQjLEq/+ZhiEFkqe57ku1JJGayPgJHx
 Uh/CMzjFHUV+tMRbRT6o203WuQAkshcJRPqnl6JBlv/rgvWrbgoLkX+KlNQCclNhS76R
 nucg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJGIEYYddXwsosS8Vuc4adq+Bf0NfNj9RgLcOPSlgAIaA80vvRP1Dlagt+U8+O5BEEoRYYsJscoJI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nzLR//d21bzyAnOd19TQsW+v5oFhoIAvXP0poLNCoSnj1X0Pgf
 UOHuh0emSA1NUF9cy9bsyxKaDIo9GT56aI2VFWkMFmSVphzF44dspaACk2cW+ah+UhQ=
X-Gm-Gg: AYBFou1dUGYORA4BJMoskv8fS4kamg4J2+75MaYgAFAAHW/HI/+1tBHJBZd09AJ1CfO
 flhq4z9U9o0KKR89Pk/mZzHVTeET4xvTCoHXLMDYTbWKSHa8QmffwtqrvjReEwnKpI7jIIpqH5u
 xjvLpUg0oUkUz7hSkutkyPVg8QTOyhizAk96XMpJzjH3qn2+fU45DpaNtXk3uqkKhU2MOvx0MHP
 BCHeNtDhxU7YXViTx2AeBVytfzIRQk0+GPk2NRdHNWApd3l9yH6Cdu1qmOl12XSb082g2Irct0i
 eObY+SZ/l3QsV5mu9VA2SgDkjRtI7+p/4vEePwwOhNUJmwYGW6AEFycDR+LwcQ0PGrYPbTXP1JE
 yyO6/xVKHlUxxrkjicZoE95kA4K46TWunk31+j5jce+X/a/Hb4kGuH/9PHGWUGrad1vZpt0oO1I
 Kr3XAVmMT8arnlka5U7cgl7nxm2DyqGC+sPhTAYTqDfVmtdwY1xVLQtQu2jOjDq22xljcXotYPf
 zcJU4/yYCHCgdQ77i3rTBhWszcGiuagIJcj88m9JpHf/es=
X-Received: by 2002:a05:600c:4e12:b0:49c:fc6e:a3df with SMTP id
 5b1f17b1804b1-49fe66f82d8mr225035645e9.30.1790613606106; 
 Mon, 28 Sep 2026 09:40:06 -0700 (PDT)
Received: from [192.168.27.65] (82-64-67-166.subs.proxad.net. [82.64.67.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d0ea071sm3637265e9.9.2026.09.28.09.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:40:05 -0700 (PDT)
Message-ID: <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
Date: Mon, 28 Sep 2026 18:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
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
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
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

Hi,

On 9/28/26 18:22, Maxime Ripard wrote:
> Hi,
> 
> Panels in general, and MIPI-DSI panels in particular, are pretty
> difficult to support and require pretty much a panel driver for each
> panel produced. Most of them are pretty simple, and require an opaque
> initialization sequence that is usually poorly documented.
> 
> This creates a tension between OEMs and distros because OEMs will
> typically get a new panel to react to a sourcing issue during
> production, and thus need some swift turnaround between getting their
> new panel and it being operational in the OS. Distributions on the other
> hand can take years to ship a kernel with that new panel driver.
> 
> To solve this, I followed the example of HID-BPF and wrote a panel
> driver that will rely on BPF programs to perform the panel
> initialization. That way, we can ship the programs separately from the
> kernel, and with a different lifecycle. If this driver is accepted, the
> plan is to have a userspace component started by udev to identify and
> load the right BPF program for the panels found on the device.

This is kind of late for serious applications except if we manage to
solve the bootloader to Linux display engine transition.

> 
> This driver is fully functional and works with both 5" and 7" Touch
> Display 2 panels for the RaspberryPi. However, it breaks away from the
> typical panel driver in multiple ways:
> 
> - BPF programs can only be loaded by userspace. This leaves us with two
>    choices:
> 
>    * We prevent the driver from loading until the script itself is
>      loaded. This has the side effect of preventing any other output to
>      be used until the initramfs is ran at the earliest, and possibly
>      ever if the loader isn't installed for example.

This adds a dependency on user-space behavior and if somehow the
initramfs doesn't load for a reason we won't have a way to display
an error.

> 
>    * Or we probe the driver all the time, but only report it as connected
>      once a program has been registered. This is somewhat unconventional,
>      but allows the other outputs to be functional, *and* allows the user
>      to force the output if their panel doesn't require any
>      initialization or during debugging. I chose this solution.

Both options are not really great...

> 
> - It's not a panel driver, but a bridge one, which is also pretty
>    unconventional. This is required because panel drivers don't have
>    access to a detect callback that is required for the above, but I also
>    think that the recent work from Luca blurs the line from panels and
>    bridges and we'll end up going that road anyway.

On this point, DDIC _are_ bridges, but in the current panel API we blur the line between
the panel and the DDIC. So being a bridge is fine, but in a general way we lack
a proper way to describe the display/panel/monitor independently of the DDIC.

At first glance it's a nice driver, but moving the timings into a blob moves something
into possible proprietary binaries with possible closed licence and distribution
restriction so it's a downgrade for the same of bringing up a panel faster.

I'll review further and comment.

> 
> Let me know what you think,
> Maxime
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Maxime Ripard (6):
>        dt-bindings: display: Add panel-mipi-dsi-bpf generic panel binding
>        drm/panel: Add generic MIPI-DSI panel driver with BPF init sequences
>        drm/panel: dsi-bpf: Add BPF program build infrastructure and helper header
>        drm/panel: dsi-bpf: Add Raspberry Pi 7-inch panel BPF program
>        drm/panel: dsi-bpf: Add Raspberry Pi 5-inch panel BPF program
>        [DO NOT MERGE] arm64: dts: broadcom: Add Raspberry Pi ILI9881C DSI panel overlays
> 
>   .../bindings/display/panel/panel-mipi-dsi-bpf.yaml | 184 +++++++++
>   arch/arm64/boot/dts/broadcom/Makefile              |   8 +
>   .../bcm2711-rpi-4-b-dsi-ili9881-5inch.dtso         |  22 +
>   .../bcm2711-rpi-4-b-dsi-ili9881-7inch.dtso         |  22 +
>   .../dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dtsi  |  65 +++
>   drivers/gpu/drm/panel/Kconfig                      |   3 +
>   drivers/gpu/drm/panel/Makefile                     |   1 +
>   drivers/gpu/drm/panel/bpf/Kconfig                  |  28 ++
>   drivers/gpu/drm/panel/bpf/Makefile                 |  10 +
>   .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-core.c    | 452 +++++++++++++++++++++
>   .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c  | 278 +++++++++++++
>   drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c | 242 +++++++++++
>   .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.c   |   4 +
>   .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.h   | 246 +++++++++++
>   drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi.h     | 264 ++++++++++++
>   drivers/gpu/drm/panel/bpf/progs/Makefile           |  93 +++++
>   .../panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c   | 266 ++++++++++++
>   .../panel/bpf/progs/Raspberrypi__dsi-7inch.bpf.c   | 271 ++++++++++++
>   .../gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h   |  95 +++++
>   19 files changed, 2554 insertions(+)
> ---
> base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
> change-id: 20260928-drm-mipi-dsi-panel-ebpf-d78b72a9c47f
> 
> Best regards,

