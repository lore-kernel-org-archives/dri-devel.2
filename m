Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC02CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 19:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D896C112442;
	Fri, 29 May 2026 19:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eJxhKZnp";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A490112442
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 19:17:12 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45eea3448f2so1211313f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780082231; x=1780687031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2foRsWJ0lba68yU2GxP5AU7MU0MvJx9Tate1Ll6nIZs=;
 b=eJxhKZnpoklNZt8nol/GGQ7lWEcIuKrc6sF1TiC33UlffLM0xOQt4GaKaZmxPW7u4G
 PBAzugQV9RrtK+F3vVdxVY39uDsZrB6VTXgi470dBNHuTqX1ZiMh54Q52ahXUMQ1yBvK
 jKDDZU+Jgq3Vf+InHInpxnnj+1ROIERpI/urJKV8pC4V8QFKByUejrQ106+LzKOgHVqm
 wzqhUUz6gUaTCetQrHmYREhAYoNfiwJd5kprpeKnQG14SlE4P+MnmvQeT65kPA/1/TrF
 wImV9oqSnWOK/fLTdCCLAlXMSUBikCjfYQ/d0FYNcEEak/S2XLcZXvl9CBnrLGP1tf+E
 +2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780082231; x=1780687031;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2foRsWJ0lba68yU2GxP5AU7MU0MvJx9Tate1Ll6nIZs=;
 b=h/Bz1tfQ7f83AYGQerHNFdaiSGS60XK0831qsaSSrkhdyPOc/kGgARTAnJmNaA9jzZ
 cNK4Z1oA2pjPGYQR7Ukzyirx7JVtohz/yv0afrs+N+GeMgQ+IF5inDgz3zp66dz7fodh
 8wk/hwpdkC08GyeBP22nnBW6B/wZ+04TofqP3hTzCT+4FM+igQKRRMePU1lGPDBBG3av
 fzErLBkGf6PATy+fJl/tcB9p83zZbgfeO1V94aGeSJDdu0ZX6B+7LSmhnBQM7M+xCWTh
 qU2HGFS50UbDhHHCze7LQhLxTq0/rDY8jGwdVJyM1V6QZi9a2KjAH2zoMzoRs/Q+CSOQ
 mxXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6KBNngiOK7WoSmuKTjj4orfwFgr83/og6FMpxUErbr1cZf9WI+kOZqfzebGkxR4RpH80S8iovXDs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZodpBiLylY6wAvj6GlmtvDEhf2wLcZ6rcowAMXBpbM+MeQh8H
 YgwCJ+KSLjDbiMMaAw8vLm3shQTW8aln5zbbUCOqqYEBnsaduVzuhZg5wKI6+rVtMIM=
X-Gm-Gg: Acq92OGk0XIyANRksFnSuLclLX0ssch1eowlPi3SoyzMQSwr9d0iw7K5MaiYdUx/RNJ
 2AGCEH++ANCXyCPYmY3kPNZixpYQJ942kpz6Q+FlMjOlU8yZkqRFQQwxr0fJqqntmetMj6dOx0K
 xP0M39yv+Odh8zwStS3E82NYEwWJwlvAmnfdsOKJspczGnO0MxxLiEJ3fv117mSrhcNgo3V5f/X
 apNKLvBFV0sZ+/t8zVo6MrOTYxxuSOrA2juHk8wkvlD05UhhkVaga0D0Wpq+4uBcWvy4H/lVPi0
 7v5C9Xfs/Top+7PBR22ng9ZhyNmfZOVzMnu9rrsTCMQLRwWDWfh/VgkDbwVLFUyQYN0bkE5NjN9
 DzIWcQeSzAR/aAVxLpHtY8eqpf0562wquhIiT0CHiTyb5bulXj/r2ywbKYWW4YUxFRXp9HGE+BB
 GRmxqihqQh0pzwNalHRRXsUo9qSGopgZyZzlBQMJ8cEkWZIzOO4mBTvhkxyWnL1KaAHyZ/AuXqI
 lJR6FzLSFI/jp5H9sReh6/aR2We
X-Received: by 2002:adf:fad1:0:b0:45e:f5bf:6c25 with SMTP id
 ffacd0b85a97d-45ef6b6c555mr1668157f8f.32.1780082230243; 
 Fri, 29 May 2026 12:17:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b6d0:a628:be51:f552?
 ([2a01:e0a:106d:1080:b6d0:a628:be51:f552])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd87sm5174852f8f.24.2026.05.29.12.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 12:17:09 -0700 (PDT)
Message-ID: <ddf8ea10-b0e7-49be-ab9e-bdfad1b34327@linaro.org>
Date: Fri, 29 May 2026 21:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
To: Daniel Thompson <daniel@riscstar.com>
Cc: Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
 <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
 <ahllT_HVTAJ5MbkS@aspen.lan>
 <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
 <ahlr5PnX5O0tEd6G@aspen.lan>
 <4001cf6a-b7de-4933-96bc-c9b4ccb53e4d@linaro.org>
 <ahmfZ0tdxbVfD_y4@aspen.lan> <ahmkirIuOYhd1rkM@aspen.lan>
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
In-Reply-To: <ahmkirIuOYhd1rkM@aspen.lan>
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

On 5/29/26 16:36, Daniel Thompson wrote:
> On Fri, May 29, 2026 at 03:15:03PM +0100, Daniel Thompson wrote:
>> On Fri, May 29, 2026 at 02:50:43PM +0200, Neil Armstrong wrote:
>>> On 5/29/26 12:35, Daniel Thompson wrote:
>>>> On Fri, May 29, 2026 at 12:16:07PM +0200, Neil Armstrong wrote:
>>> So it's not really 2 regulators, and having regulators means the enable
>>> signal can be shared and would have regulator characteristics which it hasn't.
>>
>> Agreed. If the EN pin is merely use as an enable and voltage reference
>> then it are not two regulators.
>>
>> However, it is also *not* vddio-supply and enable-gpios. We don't need
>> the board design to check this. The pinout diagram in the datasheet
>> should be sufficient!
>>
>> If you have to activate vddio-supply for the backlight to work on the
>> board are you sure you don't just have a misnamed vdd-supply that needs
>> to be taken care of? That would make much more sense given the datasheet.
> 
> After posting this I figured there is another possibility.
> 
> If the host GPIO pin is not capable of delivering the 1mA requires by
> the chip then the board designer would have to add a buffer and that
> buffer would need a power supply... and that power supply could, in
> pinciple, be switchable.
> 
> However if that were the case then I don't think the power supply for
> the buffer would belong in the bindings for the sy7758 so I'm afraid
> whichever way I turn it I can't make vddio-supply make sense.

Yeah seems you're probably right, I'll move it to vdd instead and make it optional.

Thanks,
Neil

> 
> Daniel.

