Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03A3CA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C3E10F40E;
	Wed, 30 Sep 2026 13:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T4QaW1Ii";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754A110F40E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:46:13 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so468001f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790775972; x=1791380772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CHcqKszk+BLOaoNOEO2+3FAWySZdw8cPx3mMZwkgNqk=;
 b=T4QaW1IirQRd/vjpx22y5qVFVWsEzF949cTk1qwMrIygf8Fi4HDaNi5mtuLwLLfQAQ
 GKKVsgZi63E5cHqxpJ+AsaQ1xtvJetkd0Jg4eRb04O0vo7fbkrsG3QqlNWvx9pK6Vy5R
 mP4sPznsdrIxK34FHmlRQQCHyHey98ggSUmYyPxC3siuHep2PFfUm5D5v0LK37D6vlVx
 0Tf7VW7GVsIbGjz786cNrusI9cEt+SSz8+sdR9z1tCVa1OPeuaf6HZpRRz1bMu6cRKwo
 H3Aj6Ke7m34eul2Bia0n1fnOohZTbe11wFjBswUiQaH6lNyZqDZtfgClRZ3MayvXSaVV
 494g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775972; x=1791380772;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CHcqKszk+BLOaoNOEO2+3FAWySZdw8cPx3mMZwkgNqk=;
 b=qFo8P2gEnUMWR6dM244ahW/Oc06UsoQukyyrTy94TerSJZmj/R0vmlAlJGRxsTiCXG
 GdjzOBKtkiT/bFd0mK+zc7rXKLJEGuTPqMI1wpCTYcOJU48y3y58cd6ZSAh5xhvB3eDy
 OVbj3uy7p/lkpJu3UgH2kNPiTP7XdblA0gC6e3dlHtPz8/izCszGXJxAfqZaHClARXoO
 y/8GH70dtgde6VTPXlJFMC67CK+/mRlSuYicJLuID9aHSDlMZQLq0vDO8b2ZTYaDY50T
 0rxsh55iib5bNRSmoA1bWVh7vFmjP4z58c10HaHvbX1Z5jOCfnqSnhoqs3iSMPB7VYmU
 bgug==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMMqFSh77kcvaOkeJZKZiV19q/lAUsqQTs9iKsZllaRYAK51fIHLwoh1l0rN4gBcc+zeFQp6CqvMo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKgr0qrar2OjXZe+tUJabkU+7FjEFsEKupCg4880yVU7MQFH4I/
 hhSoLufithBopAnv8d0HoagwmF2OBgimpaWCoDOtis6mWzW93/Pvxa+gqBXvQ5k1Css=
X-Gm-Gg: AYBFou1ozUoyS2bIaBfPS4bl4EIBowYTUFCe+lyVqwHjDN5beXbruyF9KodBOdtyjAa
 tZn0/jkv0ksu6DUJSLT0iF5mkTSrtZlXZ8EeVz3ZcIq4mzTQYIVYbrABijy+UGGZhMQBrgWvV7E
 EHOYw62689JAcGK2D6SU5hlzkvs3n3mWMwbhHIGP8XOKfWczfZIlMrrbUU5JwnKzdxI3s6sRfaM
 O/7nbsRvvhgC1ZbiSVCDIpImyJ4MB3+d59g+7YQ38kmyLlVduD8EeOZFaMaoENDhm2vbff/YKqr
 i75RrQjXVTB6POz5MRfQj84bUOP3+sWBmDWfH7/eswLH9/qB/d77dcJVqlZlZN5uyVBNDkgUi+k
 r3xHNdqXBBEpqXej7xiDA/AcqKDMdcZ6+Tfqq2uWM/cjNUwimoS4mJP2pBmux3HyhMwRLyYVFEL
 DiHzj9QOJb2Q73tOf9YqHhR6+rSiSOkCfJCghYUTViZFlALU7MHW/IYPlrl+rqmeaCf4wW3SreH
 DvL5QYV3LXq3jkj04FEnUAXau4RG36IDenuEdUbHHqkWQed3xIm2oKfr9Wt5hr1EP9k7espQkrd
 sQxHgZY=
X-Received: by 2002:a5d:5f81:0:b0:488:84e2:cb0b with SMTP id
 ffacd0b85a97d-48b02549be8mr3355158f8f.51.1790775971655; 
 Wed, 30 Sep 2026 06:46:11 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029e51b8sm3780276f8f.20.2026.09.30.06.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 06:46:10 -0700 (PDT)
Message-ID: <c75feb5d-055d-403a-8dba-3c187cdb8e7d@linaro.org>
Date: Wed, 30 Sep 2026 15:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
To: Maxime Ripard <mripard@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
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
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org> <artgrTe6wvKxnUOG@houat>
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
In-Reply-To: <artgrTe6wvKxnUOG@houat>
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

On 9/29/26 09:13, Maxime Ripard wrote:
> Hi Neil,
> 
> On Mon, Sep 28, 2026 at 06:39:58PM +0200, Neil Armstrong wrote:
>> On 9/28/26 18:22, Maxime Ripard wrote:
>>> Panels in general, and MIPI-DSI panels in particular, are pretty
>>> difficult to support and require pretty much a panel driver for each
>>> panel produced. Most of them are pretty simple, and require an opaque
>>> initialization sequence that is usually poorly documented.
>>>
>>> This creates a tension between OEMs and distros because OEMs will
>>> typically get a new panel to react to a sourcing issue during
>>> production, and thus need some swift turnaround between getting their
>>> new panel and it being operational in the OS. Distributions on the other
>>> hand can take years to ship a kernel with that new panel driver.
>>>
>>> To solve this, I followed the example of HID-BPF and wrote a panel
>>> driver that will rely on BPF programs to perform the panel
>>> initialization. That way, we can ship the programs separately from the
>>> kernel, and with a different lifecycle. If this driver is accepted, the
>>> plan is to have a userspace component started by udev to identify and
>>> load the right BPF program for the panels found on the device.
>>
>> This is kind of late for serious applications except if we manage to
>> solve the bootloader to Linux display engine transition.
> 
> Virtually all "generic" distributions are shipping the panel as modules
> today anyway, because anything else is nothing but impractical. But
> maybe you don't consider them serious enough. Also, applications live in
> userspace already, so can be ran after this driver would be initialized
> anyway.

So what would this exactly solve ? keeping out-of-tree BPF driver + bindings
driver forever and never upstreaming then ? Is this what we really want ?

> 
>>> This driver is fully functional and works with both 5" and 7" Touch
>>> Display 2 panels for the RaspberryPi. However, it breaks away from the
>>> typical panel driver in multiple ways:
>>>
>>> - BPF programs can only be loaded by userspace. This leaves us with two
>>>     choices:
>>>
>>>     * We prevent the driver from loading until the script itself is
>>>       loaded. This has the side effect of preventing any other output to
>>>       be used until the initramfs is ran at the earliest, and possibly
>>>       ever if the loader isn't installed for example.
>>
>> This adds a dependency on user-space behavior and if somehow the
>> initramfs doesn't load for a reason we won't have a way to display
>> an error.
> 
> Yes, if an error happens before the DRM driver loads, it won't be shown
> on the screen. This is already the case for any panel driver today on
> any major !embedded distribution. And with built-in drivers, this can
> also happen before or while the DRM driver loads.
> 
> The solution is always the same though: load simpledrm first, move to
> the proper DRM device once it's functional. It still works with this
> solution.

Module != bpf programs, maybe one day it will change.

> 
>>>
>>>     * Or we probe the driver all the time, but only report it as connected
>>>       once a program has been registered. This is somewhat unconventional,
>>>       but allows the other outputs to be functional, *and* allows the user
>>>       to force the output if their panel doesn't require any
>>>       initialization or during debugging. I chose this solution.
>>
>> Both options are not really great...
> 
> Feel free to make any suggestions
> 
>>>
>>> - It's not a panel driver, but a bridge one, which is also pretty
>>>     unconventional. This is required because panel drivers don't have
>>>     access to a detect callback that is required for the above, but I also
>>>     think that the recent work from Luca blurs the line from panels and
>>>     bridges and we'll end up going that road anyway.
>>
>> On this point, DDIC _are_ bridges,
> 
> I have no idea what a DDIC mean.

The DDIC is the Display Driver Interface Controller, basically the
IC which received DSI packets and physically drives the display.

It's basically a bridge to the panel, and this is mainly what we program.

> 
>> but in the current panel API we blur the line between the panel and
>> the DDIC. So being a bridge is fine, but in a general way we lack a
>> proper way to describe the display/panel/monitor independently of the
>> DDIC.
>>
>> At first glance it's a nice driver, but moving the timings into a blob
> 
> Let's not kid ourselves, it's *already* a blob. We just sugar-coated it
> enough that we can be happy and call it GPL.

It's the case for most drivers, but since we don't get proper
documentation we're stuck using registers list and can't
implement advanced features. And moving this to a bpf won't solve
but enhance the problem by a large factor.

> 
>> moves something into possible proprietary binaries with possible
>> closed licence and distribution restriction so it's a downgrade for
>> the same of bringing up a panel faster.
> 
> We can already make a proprietary, out-of-tree, panel driver today. That
> being said, the only license we allow for BPF programs here is GPL, so
> if anything it would be less of a concern for this than it would be for
> regular panels.

So you're on to facilitate keeping panel driver out-of-tree and never
upstream them ? this is awkward TBH.

> 
> Maxime

