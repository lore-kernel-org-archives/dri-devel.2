Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097E2CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C69E10E999;
	Mon, 28 Sep 2026 20:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XeAlniRo";
	dkim-atps=neutral
Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com
 [74.125.227.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D38510E999
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:36:23 +0000 (UTC)
Received: by mail-vs2-f38.google.com with SMTP id
 ada2fe7eead31-7b35eae3076so592399137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790627782; x=1791232582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/wqE0gOeMMpr/nqn1OVJOAEQ+QHtmheZQZYs7E5QFRI=;
 b=XeAlniRoQdSuZpAGVYTlBUKCSSH/qmiv3lHCP9gJK1qcbjqe0yHAD1drvkxqdLkYen
 J31YnwEvtUsPH32tczrVEwXIHiBU+BZsfoBKxL3uspI2Uvx4V38bOFNAkrLLsoHW3jrK
 GpXVoogL4rYWqYvM9vwulsMwVph9y9jxXRO6xle/lw2jm1Ix+MNxeSI4sPUJ2BY6LwQS
 wEnDv83Thyp6/mtyNMd4zvUiWGr++o/iGXdAc5R0DYR8SQC404WJlho6AYw3wz3pDoHG
 jiRMutfVm3vPIWAA/tsL+dUXnBWUHjWR1nA4O8NaC64NRozYnwO3kk2uTBbQkF3nfnv5
 4dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790627782; x=1791232582;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/wqE0gOeMMpr/nqn1OVJOAEQ+QHtmheZQZYs7E5QFRI=;
 b=0KXFWRP2dP8Fh9lzt2UZ4JqFKzBHdKIAlC5va/cKvBcgXfFbjVoDV1tIkz4/v0d0Z9
 uBaomr1Z2h2QReCGmNHc974Z9JO90MBN3wHp1czl3zRV4a0SYGpgu2qq6exbQ01/z3Ha
 5tqcN6sOtZP0WZTe6icBZ/la3Z4GFDthDW9B47Wya2oaJFBFyjyD0a2HlZC2/Ot3udJv
 3cv3uTc1d8cIdFH+z78Jb0LaCiwOQKUr3+pRTnJvW8Yxe3uOQZd64SilkRDqQANZyfha
 p/l9v5oX1iXhg1d6++pKTqJsmlXolbrB4aes4qO1hU3dIcRFSmOsIvBn4Bo8JXJpdBXp
 xLnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjMMIlN7YLweusjLxMzBDyBwXLvZIZDZdXDvjLpcWEvrmOJzhB+6/xR7SsUR5liF9G48KAdbZ/VF0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8wrN2+SFGccCPYSoyyvJuqwyVeCEVnkLtwurRD1a6K6GFckQ6
 oqPzjvfp1FXDEF0W3j8u4ECc8eO3NoVqM5GQoZUtEx0/Q6gwPwJHYWptzK/PO2LQXJY=
X-Gm-Gg: AYBFou3xJEqh2Qm91MNeRcRv4ajpRwYT0ezO5YlaKjurqEGDmkA/z0tKfnHOQylTmpU
 R+Z4PN21PzKuPIyyd5EbWCdmCgrvwHA5ChN/X0cLgUj3YAY0L/R0uFLuLexku4VHwQVx/BgPrTd
 YxQWaYJ1DNI5b+5nl1sSEnp1uMxs70XsQlK9VEfZ5KIHSY0MvSJWRAYPqloNSIBGPjjTanf2jot
 m2GYcJXPUOJQqSrKYflVHsaipbZdpBfeytgqN6uhk7EI5tWIbodlIwWuvCtGx0zZQIHUTKsGG8j
 ehqXRYJ5QZQf08e7Rq7Psyen+9P2nv0uj0+3AYSDHYPVx08pfIo5JUwUW97MPUeUjS0wlcftMxn
 kD9UwFKRHDIHLz/FjvcPdHajc493STXYZrbLlyPcyPbPV2iM+whQH7GY7ZdZGYYiOWMFS/j5gzj
 unFsnglv27aidlJjOAdLkqrLNChGUyjXCl5FwsMk96QVx9wTYGNrE//rbUVSS+Fd8ySS7RGi8/1
 0Ge+Ru8LoO4JbB8qrpL8Rf8ckCcs8cBLBGgEHtvRjihh3WUdMIGEvxpzGRSkdikans1oV06JBCG
 2ZkV7A7sury5t35FbA==
X-Received: by 2002:a05:6102:3972:b0:7b2:508e:3d57 with SMTP id
 ada2fe7eead31-7b2508e43dcmr1935899137.4.1790627781635; 
 Mon, 28 Sep 2026 13:36:21 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9889afc5c7csm8438164241.2.2026.09.28.13.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 13:36:21 -0700 (PDT)
Message-ID: <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org>
Date: Mon, 28 Sep 2026 22:36:18 +0200
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
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org> <arrAqg5n87INTHE6@beelink>
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
In-Reply-To: <arrAqg5n87INTHE6@beelink>
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

On 9/28/26 21:48, Benjamin Tissoires wrote:
> On Sep 28 2026, Neil Armstrong wrote:
>> On 9/28/26 19:24, Benjamin Tissoires wrote:
>>> On Sep 28 2026, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 9/28/26 18:22, Maxime Ripard wrote:
>>>>> Hi,
>>>>>
>>>>> Panels in general, and MIPI-DSI panels in particular, are pretty
>>>>> difficult to support and require pretty much a panel driver for each
>>>>> panel produced. Most of them are pretty simple, and require an opaque
>>>>> initialization sequence that is usually poorly documented.
>>>>>
>>>>> This creates a tension between OEMs and distros because OEMs will
>>>>> typically get a new panel to react to a sourcing issue during
>>>>> production, and thus need some swift turnaround between getting their
>>>>> new panel and it being operational in the OS. Distributions on the other
>>>>> hand can take years to ship a kernel with that new panel driver.
>>>>>
>>>>> To solve this, I followed the example of HID-BPF and wrote a panel
>>>>> driver that will rely on BPF programs to perform the panel
>>>>> initialization. That way, we can ship the programs separately from the
>>>>> kernel, and with a different lifecycle. If this driver is accepted, the
>>>>> plan is to have a userspace component started by udev to identify and
>>>>> load the right BPF program for the panels found on the device.
>>>>
>>>> This is kind of late for serious applications except if we manage to
>>>> solve the bootloader to Linux display engine transition.
>>>>
>>>>>
>>>>> This driver is fully functional and works with both 5" and 7" Touch
>>>>> Display 2 panels for the RaspberryPi. However, it breaks away from the
>>>>> typical panel driver in multiple ways:
>>>>>
>>>>> - BPF programs can only be loaded by userspace. This leaves us with two
>>>>>      choices:
>>>>>
>>>>>      * We prevent the driver from loading until the script itself is
>>>>>        loaded. This has the side effect of preventing any other output to
>>>>>        be used until the initramfs is ran at the earliest, and possibly
>>>>>        ever if the loader isn't installed for example.
>>>>
>>>> This adds a dependency on user-space behavior and if somehow the
>>>> initramfs doesn't load for a reason we won't have a way to display
>>>> an error.
>>>>
>>>>>
>>>>>      * Or we probe the driver all the time, but only report it as connected
>>>>>        once a program has been registered. This is somewhat unconventional,
>>>>>        but allows the other outputs to be functional, *and* allows the user
>>>>>        to force the output if their panel doesn't require any
>>>>>        initialization or during debugging. I chose this solution.
>>>>
>>>> Both options are not really great...
>>>>
>>>>>
>>>>> - It's not a panel driver, but a bridge one, which is also pretty
>>>>>      unconventional. This is required because panel drivers don't have
>>>>>      access to a detect callback that is required for the above, but I also
>>>>>      think that the recent work from Luca blurs the line from panels and
>>>>>      bridges and we'll end up going that road anyway.
>>>>
>>>> On this point, DDIC _are_ bridges, but in the current panel API we blur the line between
>>>> the panel and the DDIC. So being a bridge is fine, but in a general way we lack
>>>> a proper way to describe the display/panel/monitor independently of the DDIC.
>>>>
>>>> At first glance it's a nice driver, but moving the timings into a blob moves something
>>>> into possible proprietary binaries with possible closed licence and distribution
>>>> restriction so it's a downgrade for the same of bringing up a panel faster.
>>>
>>> Quick answer on this, because I had the very same questions regarding
>>> HID-BPF:
>>> - in BPF, you can require (and by default it does) that only GPL
>>> 	compatible BPF programs are loaded, closing the argument of "closed
>>> 	licence and distribution restriction"
>>> - also, a BPF program can be disassembled much easier than a binary
>>> 	blob, and I remember Alexei showing me an example where you get almost
>>> 	the source code from the BPF object in just one pass.
>>
>> Right, it "solve" one of my question, but doesn't really solve the issue
>> of vendors providing "GPL" bpf programs with source available "somewhere".
>>
>> Another big issue is the API, I don't want to keep the current API as-is,
>> we plan to support more advanced panel features and use try to use the
>> atomic states to support rate switching for example, and I'm not confident
>> it's a good idea since there's no "simple" and "forever valid" API
>> to initialize panels...
>>
> 
> That's exactly where BPF shines. The simple rule of thumb is: there is
> no API stability guaranteed. Basically, thanks to the verifier and CORE
> (Compile Once Run Everywhere), you don't need to keep the API stable and
> available forever. There are multiple ways of dealing with it, but the
> gist is that if a BPF is trying to load an "old" API, it will be
> rejected by the verifier.
> 
> Then it's a matter of being nice enough in the kernel and provide ways
> to deal with those.
> 
> To give you a few examples:
> 
> - in HID-BPF, in userspace, we keep old versions of APIs in separate
> 	compiled objects. Each is incremented (by 10 so we have a little bit
> 	of room in the middle). Then the loader tries first
> 	0020-device-with-new-api.bpf.o, and if it fails, it tries
> 	0010-device-with-old-api.bpf.o
> 
> 	I'm not saying we should do the same here, but that's one idea
> 
> - recently, a BPF commit broke the ABI of a function while removing
> 	implicits: bpf_wq_set_callback_impl() was replaced by
> 	bpf_wq_set_callback() with a different number of arguments. I simply
> 	had to add a new function in my header which basically does:
> 
> 	static inline int
> 	hid_bpf_wq_set_callback(struct bpf_wq *wq,
> 	                        int (*callback_fn)(void *, int *, void *),
> 	                        unsigned int flags)
> 	{
>        if (bpf_ksym_exists(bpf_wq_set_callback))
>                return bpf_wq_set_callback(wq, callback_fn, flags);
>        if (bpf_ksym_exists(bpf_wq_set_callback_impl))
>                return bpf_wq_set_callback_impl(wq, callback_fn, flags, NULL);
>    }
> 
>    And then I changed the bpf.c to use hid_bpf_wq_set_callback() and the
>    bpf is compatible with both APIs
> 
> - with CORE, struct fields are relocated on the fly when you load the BPF
>   
>    So for instance, if my BPF only accesses fields .name, .phys and .id
>    in the BPF, I can define:
>    struct hid_device {
>      char                       name[128];
>      char                       phys[64];
>      unsigned int               id;
>    }
> 
>    Then when loading the bpf, the verifier replaces all offset to the
>    ones actually used by the running kernel, and the program loads
>    transparently, even if you add fields before/after or change the
>    fields order in the kernel.
> 
> Changing the mindset is the hardest part of it. But once you are making
> the shift, it's actually much better to work with. It doesn't mean you
> can go yolo. You still need to be careful in your choices knowing the
> impact on your users. But the API at version 0 is not frozen and you
> don't need to maintain it forever, especially if you control the loader
> and the headers used to compile the BPFs.

It's really impressive, but there's no way this would become the de-facto
way to program the panels, and if the motivation is to make it simpler
this implementation requires adding bindings and bpf programs which that
are the same as native panel drivers, but won't be able to work until
user-space starts and will require to be in initramfs or rootfs to
have functional display.

Not sure to understand what are the positive features here
except isolating the panel code in a safe bpf program (is this really needed ?).

I mean the idea is cool and bpf is a nice thing, but I'm really not
convinced about it programming panels.

Neil

> 
> Cheers,
> Benjamin

