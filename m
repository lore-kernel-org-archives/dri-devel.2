Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16E2CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4831610E734;
	Mon, 28 Sep 2026 19:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LB6Yx6u9";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BCE10E734
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 19:20:16 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-97e7c7b4ed1so2018512241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790623215; x=1791228015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3EOtyWnpj6H2JKh2l6IAWizW9Kgj+njv8aMgbCxIvr4=;
 b=LB6Yx6u9nIXovg7R3Vfnps4moQZsHzpe4QWifal79PRj2G+K3S5XMMOz3QJ1RtJCWk
 cc1jvMamXH40SqJzr6QIa+uo6UcfxnD6PjRJ08HGq7c/akBkdnckkVqbzEw9BlK30nqw
 0dA7fGpCZBfOFhYZZZgI9lGRMy7eCSD5BlVclkJqSTuQU9qAKxoJivAX3m7MsIVeiBYd
 jG9X6fBxgQuUPoA0eaEzdr7tQXcz8jSiIwR4Fr/7bPDZbtLSxo+rAL2F+nV9nbnz4wgF
 /zjK2nhf+oUDmNM/AHk4Vi37V7zlSccLu510FEx5lxikdWowQtiNkkXBAPVs81ApcBE7
 cspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790623215; x=1791228015;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3EOtyWnpj6H2JKh2l6IAWizW9Kgj+njv8aMgbCxIvr4=;
 b=rjvnz6VnB8fwKBmxnpn2oQBpjs4PMvUHgNxCIBNPJAcbeoj7OsyOp8BREDG3428lw8
 gQ+U7ylIAsB87sgjNQGHbEYn3Jm8yaTd2/cfbZ6ePuWUsrsNvJqQyLXzhgbxvbrTxwBR
 GSF9rbNtzBA9RnqWM2uMd61ZzRWj946TaWNA4H7EYRJvLA+BUvjil0f3bj2u55mR+3tp
 Dyqac0bE+2Gv82MgjIy7xAVQ+sgx0LROJ2qr7HC8hZL42avvqUmq4oEgrz28ZhhJwZlq
 yjUjN8tbpBMt1LnJOPggykuBzmnN9lfKo3jqmK06HMMFD9pH/8/jfx/YJ+VeJfrtzjFn
 iB9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXRBq2pGqEkxE1LoeZT0lr4KcQr3+Y0Hul6Fo0vjVCjKFN0CdUBXqwVMl8SI/BE0hZ1r5/ftgndKg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIy0WfrfYolU0pGd7BJIs+SxmlGjCIMbQfJrZC/zFrORgJxqaER
 VT8/tyXK+JTokey975n7JlFjTakw4VRaTcgv1ZhXrm9hPLLi1/fCIU1QFFdpcMi1AR8=
X-Gm-Gg: AYBFou0Iqk4DNp/oK3KBtyP79xQbpN1D/dmqMd5go7+Cizp0oJgR7eBGj6+FgTw+QIe
 0o/RldsdDxcf/1dOfjWjRjkvNyfXiZJ3JaRGHv4uQShW3PoG8ajiGNosk9QGkoLP8Cd2TPAqie3
 VVlFpmPIfQcPD6s3PFepBFve+lsjf0ePRV7HA+H9fxNVpDqEJS8kmYE4zRhaGSUJxN6LP4kXD9C
 qmqvqdX8GMulTdq/oh2iY6WQs5nXNEaNhSE5uDppKXVOoiXtvyllEpC54XHaoqFkPpjFgzRQods
 v7e6UgAnfpFQ5/7l2JjDeMjyM3+kUvI+QRmB8pgxsjO5HZQLvFjjfmvTbWVVeL8hFPrsfuhjr4F
 ih0qdoe0KS4Ce+90oUizWjFK7WlGt6CE8Ug552quBAvMniMSXYKh5Xg6GVE6z7EiyggGFV3o1wM
 sNi12DNEmOVbCjmoe/Ypwqx7gMPoVtl1dFaJWxN+cW4imIlg+KR705w57zP7sh143SKCvEIVSm3
 J/ubnfW2jUoZS0qSqkttdyS3sJ22pwfelhQwuJI99OBxAl4L4otSUN4/ViioWtV01LdMSrj57vl
 NmJYs2Gn2GyuFxwvNQ==
X-Received: by 2002:a05:6102:3f8b:b0:7a6:bc69:5a32 with SMTP id
 ada2fe7eead31-7af1e6f3640mr5363208137.23.1790623214949; 
 Mon, 28 Sep 2026 12:20:14 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9889afc5c7csm8124301241.2.2026.09.28.12.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 12:20:14 -0700 (PDT)
Message-ID: <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
Date: Mon, 28 Sep 2026 21:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
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
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org> <arqhwHiVf00j94J7@beelink>
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
In-Reply-To: <arqhwHiVf00j94J7@beelink>
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

On 9/28/26 19:24, Benjamin Tissoires wrote:
> On Sep 28 2026, Neil Armstrong wrote:
>> Hi,
>>
>> On 9/28/26 18:22, Maxime Ripard wrote:
>>> Hi,
>>>
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
>>
>>>
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
>>
>>>
>>>     * Or we probe the driver all the time, but only report it as connected
>>>       once a program has been registered. This is somewhat unconventional,
>>>       but allows the other outputs to be functional, *and* allows the user
>>>       to force the output if their panel doesn't require any
>>>       initialization or during debugging. I chose this solution.
>>
>> Both options are not really great...
>>
>>>
>>> - It's not a panel driver, but a bridge one, which is also pretty
>>>     unconventional. This is required because panel drivers don't have
>>>     access to a detect callback that is required for the above, but I also
>>>     think that the recent work from Luca blurs the line from panels and
>>>     bridges and we'll end up going that road anyway.
>>
>> On this point, DDIC _are_ bridges, but in the current panel API we blur the line between
>> the panel and the DDIC. So being a bridge is fine, but in a general way we lack
>> a proper way to describe the display/panel/monitor independently of the DDIC.
>>
>> At first glance it's a nice driver, but moving the timings into a blob moves something
>> into possible proprietary binaries with possible closed licence and distribution
>> restriction so it's a downgrade for the same of bringing up a panel faster.
> 
> Quick answer on this, because I had the very same questions regarding
> HID-BPF:
> - in BPF, you can require (and by default it does) that only GPL
> 	compatible BPF programs are loaded, closing the argument of "closed
> 	licence and distribution restriction"
> - also, a BPF program can be disassembled much easier than a binary
> 	blob, and I remember Alexei showing me an example where you get almost
> 	the source code from the BPF object in just one pass.

Right, it "solve" one of my question, but doesn't really solve the issue
of vendors providing "GPL" bpf programs with source available "somewhere".

Another big issue is the API, I don't want to keep the current API as-is,
we plan to support more advanced panel features and use try to use the
atomic states to support rate switching for example, and I'm not confident
it's a good idea since there's no "simple" and "forever valid" API
to initialize panels...

Neil

> 
> Cheers,
> Benjamin

