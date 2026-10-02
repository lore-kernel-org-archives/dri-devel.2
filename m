Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C217CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18F910EF62;
	Fri,  2 Oct 2026 07:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ApXqPPY/";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDD710EF62
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:30:14 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so55538675e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790926213; x=1791531013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pk49vmsIM+yCxOu67mrioHkagQNao6fvAH0GFEMFZCU=;
 b=ApXqPPY/qlfK4hpaDS4nUe3n9I8zzg45ndyWfdhTjzL1cIIZ7Qm0bTorcI/++zhsQz
 W0upsv7hUCpZD60TUuZvUgjDW57IamA7prjeCiVWh6pPsBkZx9yM1u94z1wez6d023En
 xf5kcbH3LHBmXhVfwxY1oXjzRxxFimP0axE5HxPdMUlxFv8sqGRJeOSB0+ndIcZlt0QR
 PEjw5FTTYf/Z505NKNfCQUSCyJB6IT4CVhTXdCcSZrjI/GXif/id+vrRbKzWcjyFTEq9
 H7vDA+Tk0IhPpbur3cl5kWPAJHUSFuYDwrRt+B/Jg8wuCaDMZpiiKEhfIGmZLM3Cirup
 3Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926213; x=1791531013;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pk49vmsIM+yCxOu67mrioHkagQNao6fvAH0GFEMFZCU=;
 b=HiHVL8sKgaM35WQpAGDtp5Maon6Iz7b35WLO3Fb9mLPJl0ki562oyq9l1rS+CtRI3y
 7I9tLJl9z9l6L39ia9weNmXGkuB1TzTmiDwsCkcdXIv77TKa+sIWdJFxwRkfsaURuZYx
 AJ9ois2Yc31SvNxpCmMVTViOHpc4TIJxCf6c5B6L8TqoAmEvAkwvTDsht/fsGAtMU9/f
 7lnVaY1gv7PxkkvhWv7mKXSij11kn6Sf34f08Qv+4Z0XzXl1bpYG7yDfn1vFEuN/rAap
 6CRi3bw428cJ976Ql8cBq8/iK7lSnaFeKY49CA5NWO+T4zsXXD0seSE0IKIXEjQXfR7C
 ZzhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzy6w03P3Q5mYm8VxTfgwKr9ZTMQdZrU9Anu/VFXxU5kQRd/GkwTOdVT5RPrDC9aU2Bc3pMhLZ58Wo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lOHgeLJ0C0zPKCEzZGjoHhYv8lHm9r1bGSAnLChMcxTJZx8vHN
 MUcztPU9oAvobPxhZnCA54JKmodVhSFo00ds/LSYUsU7prStezO7upyeUWwMcC1fZy0=
X-Gm-Gg: AYBFou16QTgklJEdjmwtyD3aFaZF/E3+DKZMt8k/z4W1cG8KCkraooVdjaSwQOzGcU5
 WqyU5MU0RLTFGJsTFYUpk3Jwl1bWNdkscyMj4f4bBEE1TZIlzXMyZiXk8GRE2Nj5Fc0KuX0ehlI
 hiG3S+pF0NKJei9q+JZx/cv+lh0PuC4+U5dq+M9NQcTq/cyFQCNZ1yByelZgCgaWwhwvwSBoI0N
 7E2sFOW2+mYa0QGBLhLUBCpsBvr4xTSKmn5aMmxKgVIVvuIKiN61hzyvG5hERu/IAbsSY+EX7oV
 tV8Jd7GtE7XxgocGaX9maDt1vPydreyaP/R63I39T52fx+YJ5qY1eQs64qBVbFTNYu5r/x5pjpE
 t+nl1fCv9VzBB3PsRDtapn0nkO8K6UVsO+m5gLmwxBez9tdUKWQVZw0QMqvTlDgsIPzbLZZCD2S
 bB76WxojPGr9TZtWWfgpOSDCrosBdLk6uaCNz+UI18msjpnXOubuDljoaix68/RV9kbWYrvOgXj
 6YxcSJSkCqz60URHs44jNrRPWP1IeN4ZaFF99EDXAa5JFYSKedN
X-Received: by 2002:a05:600c:1911:b0:49c:ffab:551f with SMTP id
 5b1f17b1804b1-4a0275657a1mr32220045e9.22.1790926211263; 
 Fri, 02 Oct 2026 00:30:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104e07sm3611058f8f.31.2026.10.02.00.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 00:30:10 -0700 (PDT)
Message-ID: <2bd17843-4a65-49b0-9e10-7b73afb206b6@linaro.org>
Date: Fri, 2 Oct 2026 09:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
To: Maxime Ripard <mripard@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
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
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org> <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org> <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org> <artpBMeM13Dd0lLy@houat>
 <xlv1wls4ebjq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <828c9108-2db1-45a6-9301-19159a094301@linaro.org> <ar4CRTMQGs5_nGKY@houat>
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
In-Reply-To: <ar4CRTMQGs5_nGKY@houat>
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

On 10/1/26 08:50, Maxime Ripard wrote:
> On Wed, Sep 30, 2026 at 03:37:58PM +0200, Neil Armstrong wrote:
>> On 9/29/26 09:55, Javier Martinez Canillas wrote:
>>> Maxime Ripard <mripard@kernel.org> writes:
>>>
>>>> On Mon, Sep 28, 2026 at 10:36:18PM +0200, Neil Armstrong wrote:
>>>>> On 9/28/26 21:48, Benjamin Tissoires wrote:
>>>>>> On Sep 28 2026, Neil Armstrong wrote:
>>>>>>> On 9/28/26 19:24, Benjamin Tissoires wrote:
>>>>>>>> On Sep 28 2026, Neil Armstrong wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 9/28/26 18:22, Maxime Ripard wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> Panels in general, and MIPI-DSI panels in particular, are pretty
>>>>>>>>>> difficult to support and require pretty much a panel driver for each
>>>>>>>>>> panel produced. Most of them are pretty simple, and require an opaque
>>>>>>>>>> initialization sequence that is usually poorly documented.
>>>>>>>>>>
>>>>>>>>>> This creates a tension between OEMs and distros because OEMs will
>>>>>>>>>> typically get a new panel to react to a sourcing issue during
>>>>>>>>>> production, and thus need some swift turnaround between getting their
>>>>>>>>>> new panel and it being operational in the OS. Distributions on the other
>>>>>>>>>> hand can take years to ship a kernel with that new panel driver.
>>>>>>>>>>
>>>>>>>>>> To solve this, I followed the example of HID-BPF and wrote a panel
>>>>>>>>>> driver that will rely on BPF programs to perform the panel
>>>>>>>>>> initialization. That way, we can ship the programs separately from the
>>>>>>>>>> kernel, and with a different lifecycle. If this driver is accepted, the
>>>>>>>>>> plan is to have a userspace component started by udev to identify and
>>>>>>>>>> load the right BPF program for the panels found on the device.
>>>>>>>>>
>>>>>>>>> This is kind of late for serious applications except if we manage to
>>>>>>>>> solve the bootloader to Linux display engine transition.
>>>>>>>>>
>>>
>>> Besides what Maxime already mentioned (that most general purpose Linux distributions
>>> built the drivers as modules anyways), it doesn't have to be mutually exclusive.
>>>
>>> A simple panel could be supported using this BPF-based driver and then a panel driver
>>> added to the kernel, if is found that some applications need to have it built-in and
>>> earlier in the boot path.
>>>
>>> I don't see why this would be any different than HDI-BPF or other BPF-based infra,
>>> such as sched_ext.
>>
>> I don't want to add a supplementary maintenance burden for the sake of using a cool
>> technology which has serious drawbacks and dependencies on user-space even if looks
>> really cool.
> 
> Spoiler alert: v2 won't. I've got the in-kernel loader to work and thus
> you can have a built-in panel driver that works without user-space
> intervention. So this is not a topic of discussion anymore.

It will still have users-space dependency, meaning the BPF files will need to
exist in the fs when drivers probes.

Neil

> 
> Maxime
> 
> 
> will work

