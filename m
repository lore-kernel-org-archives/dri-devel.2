Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65158FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC55710EED3;
	Wed, 29 Apr 2026 09:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wG8ufrAS";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0359510EED3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:03:53 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so7902552f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777453431; x=1778058231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RSpsznma6FPd297vSkEgjiyMuhjrOLr3Zucu2Me0roU=;
 b=wG8ufrASnTNYxxoAVNXmNcTWj41ueGmGIE5jh/Ir6+pbRV9U+Y2YPZRWNZsgtoU1m5
 aJ+3rSTFG9PgISahQzCtprL7CMgNrMM1s34HuSTACHUVIjDhfeEg8I2b6b8EP1j0GPLh
 +QXxRcktToKl7VvNUmmGLjjQDFWA8sjdq/jHTvqYIhUCYr76w1ME23/FyF4APfGWRAR8
 vh0yG7Sjir0xesaXO3v6Bssg1QBMMdJEXcaji45Ui2V6T93jBNgXrtR/9ZOwK4/3bM14
 aSZKjFnBWVIJ25+w1jXW5+RSCxDXcNJlfoKymRq8ZXFxUmZxpjlsd6oCCyuqT9V+ml7q
 x58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777453431; x=1778058231;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSpsznma6FPd297vSkEgjiyMuhjrOLr3Zucu2Me0roU=;
 b=DWCnZ41Pc56GSXbweRsL+N6wxnczjPnj/oVzrxWRgEVfYerFdMBqSoxrQ2Epv5rr8e
 HFM5yOkLAS7sHnmQNUE8aXkdHKQUSUrwJU0TXADr0rFyKCAsc8hW9DVYYi8ze2H4zUIR
 5+LCrQ6Lcef2K4rojH6KrAcYbZTQYi3tZi6mt6fbgg3iv1+6olsBkEFVYsi23cO0qQk1
 s1dPO8cDxH7ab4eX1VipdsABSXwIzC2Q1gCTxHFCqhWmLmvKSNA0q8rKKVpfgsfkE1jf
 +eg6RoQcROsjcl0pYwKgD8o2WtnUsLUwqBhSaHcxUBMx8LbVaGtun80KVMRyhNLOV/lb
 fpJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YrwdRo+vzLEVjHy1kG7zJwBBG4eygxJe9vzvXKhO/IWXoUDPL5dQ90NtxI9DbFt6XPHfhY9DDiNQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNi7zo1Qlrqs3S1r/N/aNR132gjKBdxijN53lIU5TZnZlml9bk
 Pyeh9UR5YaCtmOCrsXzma4L+T+9HRwapgfe3oIMeStSAivYfqrAcDy26gvvll/Odk54=
X-Gm-Gg: AeBDieul0dzGhiWs8kzCDomKXJorLZN9tgq+NFkvbDbaLnh9Uo4XWareMSAxmDcPm9h
 RSj/dhOHNcQ9nLNi+cZ8mHKrtO/8Ps9cv7c/hKXCUtKJvF44x+VwAjbAzz4j0WvePETQEXlo3Rg
 VuFb9v0SxaHsuwOANe1yM+HoL0nXdYfp4gLjZOc/w52HHwcbyvdO7sUyzXLOH5+61LfNp5igpBZ
 +iOZs1VRJNJPD+Wkmeoape27o62T6kcy0mgcFrWY+bmoVInW4BzkM4k+Vd3XiDZPWsejouSCXVg
 fPbuq69Jdr/LOoVPZkOVR+aleRqiUnvJxOAEcoNPvXI8MDfHzwZzwpQD575Eln1sIQ1Uql5feqA
 AFGqzIh4bOJf7EaryrXvjDMRixjQTbt7fqlOsT+Ajr27RLM8ldaQIxu3n19bbpckmb6QUcU6hIl
 8kcbMf1WBv3YLl/7ifToULpb2EtEdtdeuDaB9Vqn2YuddqOuYm5L9b+0an7YmE5bTtqQmroFb2x
 7S23XkrISQ3XylKpA==
X-Received: by 2002:a05:6000:2dc2:b0:43d:7403:4b65 with SMTP id
 ffacd0b85a97d-44648f28e88mr11536798f8f.6.1777453431182; 
 Wed, 29 Apr 2026 02:03:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b679:2e1c:a552:545b?
 ([2a01:e0a:106d:1080:b679:2e1c:a552:545b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5bf2sm4322188f8f.27.2026.04.29.02.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 02:03:50 -0700 (PDT)
Message-ID: <bac23b70-758f-4944-b040-753fc40a53c5@linaro.org>
Date: Wed, 29 Apr 2026 11:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
References: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
 <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-2-0caade5fdb32@linaro.org>
 <CAKbEznvPAYFUt-ykH7rCQwMFUq6N68B9x7Dd97WRDm3Mvj34fw@mail.gmail.com>
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
In-Reply-To: <CAKbEznvPAYFUt-ykH7rCQwMFUq6N68B9x7Dd97WRDm3Mvj34fw@mail.gmail.com>
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

On 4/29/26 01:35, Gyeyoung Baek wrote:
> Hi,
> 
>> +
>> +static int sy7758_probe(struct i2c_client *client)
>> +{
> 
>> +
>> +       /* try read and check device id */
>> +       ret = regmap_read(sydev->regmap, REG_DEV_ID, &dev_id);
>> +       if (ret < 0)
>> +               return dev_err_probe(dev, -EPROBE_DEFER,
>> +                                    "failed to read device id\n");
> 
> regmap_read() seems it can return errors other than -EPROBE_DEFER
> (like -EINVAL,), and hardcoding -EPROBE_DEFER here might drop the
> actual error.
> And maybe would keep retrying probe forever

I forgot to change it, initially the powering was clunky and we had a read error
in the first probe, but now it's solved so I'll remove it.

Neil

> 
> How about this?
>> +               return dev_err_probe(dev, ret, "failed to read device id\n");
> 
> 

