Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91802C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE91C10EF8A;
	Wed, 12 Aug 2026 12:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CafdmKVi";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBB010EF8A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:23:03 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so748369f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537382; x=1787142182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zAxA3lYXjYvQzaKtcs4NSsbwGX9ohjI2k2yZr9N60vs=;
 b=CafdmKViRoi0z/3S0GwOkFriHNByoKGU5EYmciNWHzPogPQAZ3IT4QmNrbtMixMpTk
 n0H+2OmN5kBgYNsQp9S8jdNtgvPquQL0YHEol2buNfhmMPnlUPiGljQN6YHPL2dpAVm+
 1JnRxPiEubtQ2NjhMYe9S/0X7ZNTe4tn4b6m9hvYONcBNlnDFv6yJ45SbDLwPYl2B2i/
 gp5y44eMF1oGOPTcuhRASOAZ51oR/duDfqgN1lB2wI7dvIw5xkuxt1ABPG1TDoxuMnmf
 XAyihAWNn6VepBDw4jjp09aE5qb4ClrKb7PcYSkloR6IqiFcvYiHEIHeFiRfqBP2myTz
 Sj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537382; x=1787142182;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zAxA3lYXjYvQzaKtcs4NSsbwGX9ohjI2k2yZr9N60vs=;
 b=N97mPHwCJeTW8Rhe1P4zPdSjqbiy2vrMN5hN4GdSRPdMVksIkY0Y5k1JFGHbTo1gD0
 hgfwxQ/qnlp8uabTgs0g8IRhn6hXJSPLsknA6AnXot5L8AgNp6sj83YcvPU/v5o8ljC9
 RZH49tHDeGhrp1LNnibO97ixmD54ojyovsSdSeR+hWEWxrNysomrLBJ20pzVRSZX8maJ
 QfIeiWdgrhur5dEf3JBSm6YM+egsZmcl2mPqOfUNhd21ZeQKFCLK/HHvnJ8IGDhdq1MX
 qiICwh4yK+AUctXvsV2WcWmR9vTJAi9d4CiAI3QdN8o2ItGmEp9Jz4nZcv4Z1PzckByq
 Cc2Q==
X-Gm-Message-State: AOJu0YxN2wcmljOxotwml4+o84MGd1lNeWGF58vfzBtNB5WPkyj2TzDJ
 b1rBduga2vOVQqiUNxMP3A9pjEIW3VpOVMOgmshrl6uBmJyOl/3N7KZiARtd+Ie3Zno=
X-Gm-Gg: AR+sD13Y4vuFr4+lQ7MIWMS8dC4XncjWZnkmiIybUCyIfNEXqlP2rUwo9iyLtgNwS02
 knqOP8WCC0rj6Ah3GxdMixEF1zUHpsaLS8+pjFepx3/1YGX8+PAPo+IuMZe/WSPJ1PXA13mCUzk
 IFmIeOW+kQywQGGAzbvxCOwCH0CpEWzt+aHzV2A5B/y/xMSdAqjDo/ZnuwwJRPPPe3o746+DfR2
 1kxyH+gCeOHlGnW9kyIot3Ewg1CkaCJZXGnxNu6ggWDQmyM+qT2d6f69AgN6wUMdl84lYh3g3ZV
 TQokn6tpSao8V+TNnhrzZ7D2JDDp4CIq8hoFzZk0whJF7SDETz8BBJrZggelo9BxQbsKWy6obVz
 gp4Ai3x8IEsUzKfaVw2JCjMQa+4QaCi5KCPp3ZnM2+xif1oA2UbEqOQ4aoqVZUOsLzLkRawZhNd
 T09d8xOY9/Y24OmLWdjTLpVE5qynTcJo5OiGkxKC5x6Dj1712SzDoKW2iAsRwWXqZphqHYcbwi+
 +qEOwqfRMRuhSQ1ypYVu+0gYzTmJF5y0Ub1bAySKfWX
X-Received: by 2002:a05:600c:3111:b0:493:a438:7f98 with SMTP id
 5b1f17b1804b1-4997c16fb4amr56418655e9.18.1786537381780; 
 Wed, 12 Aug 2026 05:23:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:405d:735d:801e:de34?
 ([2a01:e0a:106d:1080:405d:735d:801e:de34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abf94c1sm66698225e9.14.2026.08.12.05.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 05:23:01 -0700 (PDT)
Message-ID: <19e120fc-4b60-4188-86d8-cb3705a5fd33@linaro.org>
Date: Wed, 12 Aug 2026 14:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add bindings for Novatek
 NT37703
To: David Heidelberg <david@ixit.cz>, Esteban Urrutia <esteuwu@proton.me>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260811-nt37703-bup-v1-0-34ad42b064a3@proton.me>
 <20260811-nt37703-bup-v1-1-34ad42b064a3@proton.me>
 <8c3e9384-7964-4d03-a3a9-de15d26de822@ixit.cz>
 <58d7ddd4-1488-4c34-be85-6345138aa238@proton.me>
 <7097b617-90be-492d-9637-4a2a101379e0@ixit.cz>
 <05d2ad33-a681-41e4-87f7-e3aaeb5428a8@linaro.org>
 <803e354d-55b9-4904-a4a0-9eeefa0c6ffd@ixit.cz>
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
In-Reply-To: <803e354d-55b9-4904-a4a0-9eeefa0c6ffd@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/12/26 14:15, David Heidelberg wrote:
> On 12/08/2026 13:52, Neil Armstrong wrote:
>> On 8/12/26 10:46, David Heidelberg wrote:
>>> On 12/08/2026 07:21, Esteban Urrutia wrote:
>>>> On 8/11/26 9:05 AM, David Heidelberg wrote:
>>>>> Hi Esteban,
>>>>>
>>>>> Usually the used pattern is vendor,ddic+panel-model
>>>>>
>>>>> novatek,nt37703-motorola-bronco
>>>>>
>>>>> ...but motorola bronco isn't the model of the panel.
>>>>>
>>>>> My recommendation - look at some video of screen replacement, stop at moment
>>>>> when FLEX cable from panel is visible and that's where the panel model usually is.
>>>>
>>>>
>>>> I somewhat doubt the panel model would be located in the FPC cable.
>>>> I did search anyway but didn't find anything of interest. And I'm not
>>>> willing to risk damaging the display flex or the battery of my
>>>> development device just for a possibility either.
>>>
>>> No-one asks you to disassemble the device :)
>>> Sadly, I haven't found any video doing display replacement either.
>>> In worst case such as this I assume it make sense keep the phone model in the compatible until panel codename is found.
>>>
>>>> For the compatible pattern I used the implemented pattern for the
>>>> NT36523 TDDI, which is also used for other ICs such as the RM69380.
>>>>
>>>> So, I believe it should be okay to leave the compatible as is.
>>>
>>> I would like to hear a word from Neil first. In similar cases like this would make sense to have one way defining these compatible strings used in phones.
>>>
>>>
>>> bit I missed in the review the part:
>>>
>>> +            compatible = "motorola,bronco-tianma-v2-nt37703", "novatek,nt37703";
>>>
>>> Unless the driver is able to auto-detect the connected panel (unlikely), novatek,nt37703 doesn't make sense. The DDIC without the panel is useless.
>>>
>>> For example, in sdm845-oneplus-fajita and enchilada, we have the generic compatible because it was introduced before, so it's kept for compatibility reasons. There is no need to do that here.
>>
>> Yeah today the norm is to add the ddic as second compatible entry so the first compatible just describes the pane, so here it should be:
>>
>> compatible = "motorola,bronco-tianma-v2", "novatek,nt37703";
> 
> So let's me present a situation which can happen, let say I'll be upstreaming:
> 
> DDIC (novatek,nt37700) + panel (samsung,amb630qy).
> 
> For the example I choose samsung,amb630qy because here the panel has phone model in it, which avoids the possible issue I'll be describing with this schema.
> 
> Vendor can pair this panel with different DDIC. Thus it would be
> 
> compatible = "samsung,amb630qy", "novatek,nt37700"; // new one
> compatible = "samsung,amb630qy", "novatek,nt37703"; // existing
> 
> The reality the driver picks only the first compatible, and that's all causing to load wrong driver now.

No, the core will pick the first compatible that matches, so...

> 
> Solution here would be differentiate between
> 
> a) DDIC + panel
> b) module name (consisting DDIC + panel).
> 
> We could say module is motorola,bronco-tianma-v2 and contains [ DDIC + unknown panel ], which doesn't even have to be mentioned in device-tree.
> 
> While it may seems I overthinking, in this case it doesn't matter that much, I already have patchsets for DDIC which can be combined with three types of panels (and using different schema) and I would like to have good solution for longterm contributions and development.

... in theory we could have:

compatible = "samsung,amb630qy", "novatek,nt37700"; // new one
compatible = "samsung,amb630qy", "novatek,nt37703"; // existing

and drivers would only have:

"novatek,nt37700"

and

"novatek,nt37703"

as compatible and then a separate match table with :

"samsung,amb630qy" and "samsung,amb630qy" which associates with the panel data.

If it doesn't match, return -ENODEV and it would work like before,

I mean it's valid, it's a matter of implementation, if the same module can have
different DDIC then it should be described like that.

In this case, the bindings should be for the module and not for the DDIC.

Neil

> 
> What do you think?
> David
> 
> 
>>
>> Neil
>>
>>>
>>> Thanks
>>> David
>>>
>>>>
>>>>> David Heidelberg
>>>>
>>>>
>>>> Regards,
>>>> Esteban
>>>>
>>
> 

