Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8033ACA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3B310E550;
	Fri,  2 Oct 2026 08:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HfDEo0h0";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C135210E550
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:11:18 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af5ae31d8so3310247f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790928677; x=1791533477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qa8a08zy/9EMmaSnon0+MVyVSBQZTq4II4ieN33FiZM=;
 b=HfDEo0h0pcybWcnFPL7KZeMziPQX6tsFxQXZvhqraV4RREVGzL3/cvd2ZVRSoFOxfI
 Akh8JNbCnd6XkbjAJMoZ7UYenP//0KNwyT4L5NzizmaL7kkDRqRGrt0ZTowQdgwABZFr
 47FI343HUnATKR7wcFbcIgR9xSLbrD80kNXCUavoQYTMme9y5T47PUAihyfZGP4dMjoG
 UhEej44TIEipBT19ftkhveXlDgouM2ivx+bwzbBlhL97XnuL9IvUXZe3ccIbKMBLmOql
 zPBrm1IdAu1P/DvE4X7R9run3Fc+x2xzv9cxQojPqAlOt5vBaxY1nLmpinA7Ux8EonUq
 l+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790928677; x=1791533477;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qa8a08zy/9EMmaSnon0+MVyVSBQZTq4II4ieN33FiZM=;
 b=QkvQvTjm/SjtfVeEHejwqAf7af4osmiahc17WSy2ue/H+TqJoaCebBNsefkOy5Gn6g
 BzqCKeTIqGdtNK8iLCr3lk52McmsoFtCfNvroThS5oB5jBQE7p/DLlvsl2ueuuVW7i8N
 7kYIFf3SOz3FhFQAn+Nq11TsBaE/XypJROixPeYl7yXFPPi+taJvmW6OarsILtbAM/ve
 7dWwQ/X9hweycEOsqYLc+H3bG5De4kS4ZOYK2xsp6gveqCl/1lONEueOuEumAIznqOrd
 dZ8gtWqGl46U/xE9n0kZ9cT/PyswXgiKzl+EXovv2gM9r6nvTlIc6ai7WXyNuU6VbcjI
 mmvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh8Lm4+T/v4osZtsKV+lxIrxLUryyosOqx13QTRpRFpylZjmcLOULIAm7z9NnYZ4w/IwDNEGZjrv4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLLma8+fmAlabLAkHQrIKaJOX0Si26zK3St0bO5EZnkRhaFQ8b8
 2G/2owNxC8qfUpQyzpnBV1tkOtQ5ibgPDJMab00BdD8lN6RStzc+Ytzu+PGt1ESj8AQ=
X-Gm-Gg: AYBFou3fzpSZc9g87z7ECFxLXXcU7v3Lk98JHd1xQga0J3v9nmW/93wQthWGLA0Jg1a
 vfmyFmVZpa3k3JU+lXUkWGWYhBkfg4l3ZUvd7zJ8OikZf+gEOjrYPZxxkKkI+mKhIxT4hSHIrJ1
 7z+IiXcUBeejxiMZoML5aQAMxJXnTVxb1MIg1PBperWNIDSWETrdPW3kv93LkBVqLKBu/8fuXI1
 ruyxkq+qcqQtEWMdzN0cEa0oqLxw+m0RkBv1UeQ/5Cfgi4hdTPhC9/x5Vf9DYKdO1h94erBpr1c
 hZKRynlIHpULpgGFI+Sy+utmJJzjDr3/54yz2Z1tEKr5d0lJuKoHhNrDQKh7hiOmd2dyyb2nqUT
 7TQvRKRZdEPiVIaS8X8YQAjocK7qTLfuBCMRRnmgdQSfSuFz1f8bJ/BmZrqDEzhCBq0ACeBqWiE
 UZVf+gSC+bHzybz+c2d3rYW2kyFY8ifImrb57a2ZD+xu8T5V4gz0p2cM8Qj9B/+gCLlH5UCzAIE
 YmZT8LIS862ajKY/0ziSFQo0Ncvj1kkAUYoqlTR0HwjWVxDpvQ=
X-Received: by 2002:a05:6000:480b:b0:48b:f92:1f75 with SMTP id
 ffacd0b85a97d-48b12726376mr3833848f8f.48.1790928676871; 
 Fri, 02 Oct 2026 01:11:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380fab11sm3944624f8f.16.2026.10.02.01.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 01:11:16 -0700 (PDT)
Message-ID: <116b4574-a9a7-49c6-9806-9b6424d2fd2c@linaro.org>
Date: Fri, 2 Oct 2026 10:11:14 +0200
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
 <c75feb5d-055d-403a-8dba-3c187cdb8e7d@linaro.org> <ar4ADESgOoIx4F5d@houat>
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
In-Reply-To: <ar4ADESgOoIx4F5d@houat>
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

On 10/1/26 08:48, Maxime Ripard wrote:
> On Wed, Sep 30, 2026 at 03:46:04PM +0200, Neil Armstrong wrote:
>> On 9/29/26 09:13, Maxime Ripard wrote:
>>> Hi Neil,
>>>
>>> On Mon, Sep 28, 2026 at 06:39:58PM +0200, Neil Armstrong wrote:
>>>> On 9/28/26 18:22, Maxime Ripard wrote:
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
>>>
>>> Virtually all "generic" distributions are shipping the panel as modules
>>> today anyway, because anything else is nothing but impractical. But
>>> maybe you don't consider them serious enough. Also, applications live in
>>> userspace already, so can be ran after this driver would be initialized
>>> anyway.
>>
>> So what would this exactly solve ? keeping out-of-tree BPF driver + bindings
>> driver forever and never upstreaming then ? Is this what we really want ?
>>
>>>
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
>>>
>>> Yes, if an error happens before the DRM driver loads, it won't be shown
>>> on the screen. This is already the case for any panel driver today on
>>> any major !embedded distribution. And with built-in drivers, this can
>>> also happen before or while the DRM driver loads.
>>>
>>> The solution is always the same though: load simpledrm first, move to
>>> the proper DRM device once it's functional. It still works with this
>>> solution.
>>
>> Module != bpf programs, maybe one day it will change.
> 
> I have exactly zero idea what your point is here. You were saying that
> it's bad because panels get to probe later now and you wouldn't see an
> error. I'm saying it's already what happens today with a significant
> part of the install base and doesn't seem to bother you.
> 
> I'm not talking about BPF programs themselves, I'm talking about your
> double standard.

I just expressed that you're trying to compare modules which are already
hard to handle since they can be loaded anytime with BPF. Adding an additional
complexity on top of modules won't simplify things at all.

> 
>>>>>      * Or we probe the driver all the time, but only report it as connected
>>>>>        once a program has been registered. This is somewhat unconventional,
>>>>>        but allows the other outputs to be functional, *and* allows the user
>>>>>        to force the output if their panel doesn't require any
>>>>>        initialization or during debugging. I chose this solution.
>>>>
>>>> Both options are not really great...
>>>
>>> Feel free to make any suggestions
>>>
>>>>>
>>>>> - It's not a panel driver, but a bridge one, which is also pretty
>>>>>      unconventional. This is required because panel drivers don't have
>>>>>      access to a detect callback that is required for the above, but I also
>>>>>      think that the recent work from Luca blurs the line from panels and
>>>>>      bridges and we'll end up going that road anyway.
>>>>
>>>> On this point, DDIC _are_ bridges,
>>>
>>> I have no idea what a DDIC mean.
>>
>> The DDIC is the Display Driver Interface Controller, basically the
>> IC which received DSI packets and physically drives the display.
>>
>> It's basically a bridge to the panel, and this is mainly what we program.
> 
> I've been writing panel drivers longer than you did, there's no need to
> be patronizing.

Sorry I never meant to patronize you in any way, I just explained my position
on why DDIC are bridges. So perhaps I didn't understand your question.

> 
>>>> but in the current panel API we blur the line between the panel and
>>>> the DDIC. So being a bridge is fine, but in a general way we lack a
>>>> proper way to describe the display/panel/monitor independently of the
>>>> DDIC.
>>>>
>>>> At first glance it's a nice driver, but moving the timings into a blob
>>>
>>> Let's not kid ourselves, it's *already* a blob. We just sugar-coated it
>>> enough that we can be happy and call it GPL.
>>
>> It's the case for most drivers, but since we don't get proper
>> documentation we're stuck using registers list and can't
>> implement advanced features. And moving this to a bpf won't solve
>> but enhance the problem by a large factor.
> 
> How? You keep saying those broad, alarmist statements. Look at the BPF
> examples I provided. *How* is it "making the problem worse by a large
> factor" exactly?
> 
> Just like I said to Rob, I don't mind changing that driver to accomodate
> your fear or anxiety. But "this is shit" isn't a review, it's abusive
> behaviour. If you plan on continuing that trend, don't.

I'm sorry if you felt like this, I expressed multiple times this patchset
is great and very well written, I only expressed some legitimate questions
about BPF because I'm ignorant on the subject and the impact it will have
on my volunteer DRM panel maintenance activity.

I'm sorry if this felt as fear, anxiety or abusive behaviour.

> 
>>>> moves something into possible proprietary binaries with possible
>>>> closed licence and distribution restriction so it's a downgrade for
>>>> the same of bringing up a panel faster.
>>>
>>> We can already make a proprietary, out-of-tree, panel driver today. That
>>> being said, the only license we allow for BPF programs here is GPL, so
>>> if anything it would be less of a concern for this than it would be for
>>> regular panels.
>>
>> So you're on to facilitate keeping panel driver out-of-tree and never
>> upstream them ? this is awkward TBH.
> 
> Hahahaha, yeah, sure. I don't care about upstreaming anymore and just
> want to scorch-earth the entire kernel to have an excuse to retire and
> do goat farming. You got me.
> 
> However, given the current state of this discussion and the intention
> you're giving me, it does sound appealing.

So this remark comes from directly from the cover letter arguments, which
are mainly helping to facilitate OEMs and distros to ship panels drivers
faster and would help "ship the programs separately from the
kernel, and with a different lifecycle".

Since I still don't understand how it will help OEM and distros, because I'm
no more an OEM for while and I don't run a distro and since I maintain the
subsystem I feel legitimate to understand exactly how it would solve
the *real* issue you expressed.

Let me be clear, I want people to upstream panel drivers, and since I took
over the panel maintainership I have a constant driver review and merge
rate, so perhaps it means I need to improve how I handle the susbsystem ?
Or is writing a panel driver too hard ? Am I to strict on the review ?
TBH I'll handle the BPF driver the same way, so again it makes me feel
this solution is not the right way to solve this, or I should just do
something else ?

I think we should stop arguing here, since my words were badly interpreted,
and we should leverage the Plumbers and OSS/ELC next week to discuss this
in-person.

Thanks,
Neil

> 
> Maxime

