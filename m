Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24437CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB4110F404;
	Wed, 30 Sep 2026 13:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MtDm4ywu";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD30710F404
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:38:09 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5b76694fb7aso1845307e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790775488; x=1791380288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JZB4UkUo4DToHt4/+zjrF9qsPrLf22VKvL6EK3fyUl0=;
 b=MtDm4ywuNNZyocbnPYnzy0F0HLUwTFDoyQb3XGh0bLu2taxLe/LxSqDW8FQd3xrUT7
 ZkC6Jeoy2AtLwoPZPBmyQnvjxwTuT51CqklW/ATxpr5Pqq5uom2uHoP9qBvKZY0ZZhSm
 zdxRRdHIzf/OzJcMEPztYZ7q1T11jrS/XkzLQ5E/Vi2FLFf1P8q0ysdMJ3g8zm3Fz6El
 vF9ZHBZOIbtGwRI8rxw9HdbtX7YCzZd4MTuAlggtT03fzU5mr7EJYfL0qpKEAA0jFaE9
 rBkAj7pbCldugd/uThrQOk+OltOE+Q5lPz6CPoMl5582y6MoIcH2OYDnrypwIM4JOW5e
 aSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775488; x=1791380288;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JZB4UkUo4DToHt4/+zjrF9qsPrLf22VKvL6EK3fyUl0=;
 b=ekYsysDOy8DdqmIW8vrICLWU1nRdadXWn0KuwfIA+yF1VXVRplcq/wOsB05ttBJyPk
 qMhBJRgVdJUqrVH1WBJ46FLg75P4HdS6bQ5xOjpE5uPn76wTqX5xPbuotDlw4wJRgv4T
 IzxUsZkFfd0+hgZEGJS2g9ns5SnoYNMX3m2MeJzT0EmsFxhhdCLBelenf67rRvahxAJA
 CXmxoIKZUxfDM0wJR47nwUWV56+BtvgKJGdJg0hEmnomBbQKtPE9OQJy8g9h3CW3Ee0W
 HdKvm0jK4l4vfqaTq2q9vwxoZVmTLmDos9bvK4GFqtQLlblCh3hWI4u2267AlCfNG4PT
 1Nmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW+2MvYucgAP+GUD0oPQcv61hIb2DIA8M9PXFFHwYXprtPe5uJXkAp9RiEdTicln25IREvYf9ptt0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPpP1u+gVfL3I5g9kzJzKvkYpG7vGMUv8/d72Rv2bnqG2vGgzg
 eGGqxb4fOvuGAfACMx00pKT6eUlKBfb23DaQSiUyYuHFSyzOaEykW8CATVF67/GEr/k=
X-Gm-Gg: AYBFou1nRFNTue2O3UMAyJWkKa7744KgOU+btoZOuAuYMXIvLzUwKOh2xcPXeDQ7eO4
 RHm9Yd8lnFz7EzVDskS4juw6BnT3DTJCO46gC5u2vjVqhuTaZj7MLSFwbwCkdE66kP3QaAPRtOS
 Lk4K9mFntT5Ze+SlcVjriKwlxG7LF7ShZKDTnrLANmrpgM9a0zX4IlLRDwxjXfqhDwxjk2ceA67
 k54J8/AOSLM4rExA6+apuGeIcUvgoxrP+u1xLpQ7y21GgnVpfHFr84sn9kJewae1kS6sKGKKGSf
 NUvdmbdCUqwYKdWucp62yVGaGeNHbhcx5oj65gLK3W6YhZY7I223TrcqzR7xHMtoANWk/lUGDKz
 TZLujKqM3gPbGO0gvaCs1U3hAGWZvKYIOVpIixj+J8AnZ/WsucTtN99hjC065Of87is/wCyWaWe
 zLH9oTBQkxeeJys1b4mrvBYgylcQnP3STwljnFVjnamQZ5DN+tenC9I1Jtjir19erbvj1J6itOe
 7+hZEPmtkSsn2Esw80dBJMut455JaAHTbDbsFo9mljhuINnhVbyrKAhyTn4omDzGlR8ObEtzYjO
 R/xyKZe+
X-Received: by 2002:a05:6512:39ce:b0:5b8:f9ae:1816 with SMTP id
 2adb3069b0e04-5ba405f319dmr575166e87.17.1790775487315; 
 Wed, 30 Sep 2026 06:38:07 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3fc02f2esm360270e87.77.2026.09.30.06.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 06:38:06 -0700 (PDT)
Message-ID: <828c9108-2db1-45a6-9301-19159a094301@linaro.org>
Date: Wed, 30 Sep 2026 15:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
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
In-Reply-To: <xlv1wls4ebjq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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

On 9/29/26 09:55, Javier Martinez Canillas wrote:
> Maxime Ripard <mripard@kernel.org> writes:
> 
>> On Mon, Sep 28, 2026 at 10:36:18PM +0200, Neil Armstrong wrote:
>>> On 9/28/26 21:48, Benjamin Tissoires wrote:
>>>> On Sep 28 2026, Neil Armstrong wrote:
>>>>> On 9/28/26 19:24, Benjamin Tissoires wrote:
>>>>>> On Sep 28 2026, Neil Armstrong wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 9/28/26 18:22, Maxime Ripard wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Panels in general, and MIPI-DSI panels in particular, are pretty
>>>>>>>> difficult to support and require pretty much a panel driver for each
>>>>>>>> panel produced. Most of them are pretty simple, and require an opaque
>>>>>>>> initialization sequence that is usually poorly documented.
>>>>>>>>
>>>>>>>> This creates a tension between OEMs and distros because OEMs will
>>>>>>>> typically get a new panel to react to a sourcing issue during
>>>>>>>> production, and thus need some swift turnaround between getting their
>>>>>>>> new panel and it being operational in the OS. Distributions on the other
>>>>>>>> hand can take years to ship a kernel with that new panel driver.
>>>>>>>>
>>>>>>>> To solve this, I followed the example of HID-BPF and wrote a panel
>>>>>>>> driver that will rely on BPF programs to perform the panel
>>>>>>>> initialization. That way, we can ship the programs separately from the
>>>>>>>> kernel, and with a different lifecycle. If this driver is accepted, the
>>>>>>>> plan is to have a userspace component started by udev to identify and
>>>>>>>> load the right BPF program for the panels found on the device.
>>>>>>>
>>>>>>> This is kind of late for serious applications except if we manage to
>>>>>>> solve the bootloader to Linux display engine transition.
>>>>>>>
> 
> Besides what Maxime already mentioned (that most general purpose Linux distributions
> built the drivers as modules anyways), it doesn't have to be mutually exclusive.
> 
> A simple panel could be supported using this BPF-based driver and then a panel driver
> added to the kernel, if is found that some applications need to have it built-in and
> earlier in the boot path.
> 
> I don't see why this would be any different than HDI-BPF or other BPF-based infra,
> such as sched_ext.
> 

I don't want to add a supplementary maintenance burden for the sake of using a cool
technology which has serious drawbacks and dependencies on user-space even if looks
really cool.

Neil
