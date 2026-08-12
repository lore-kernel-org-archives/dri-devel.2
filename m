Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF89C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E5310EF71;
	Wed, 12 Aug 2026 11:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="geLAOGNL";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21A310EF77
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 11:52:46 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so8771885e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786535565; x=1787140365; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mryJFKNp9U/j2vl+1/90AHsRvVjI17dKCWsj626BK1E=;
 b=geLAOGNLRwC3pSCPLU4PjaWsKRHAte/D1iqaQH4UKfq8TXTrj4Wn4YXfKtpEVK8Nxa
 ZcLweuFSueRuYYEqWPWs4PtHmpFFYif3qYIzHDVpgCtgO8B5dvDgxIRlncNG/E+KJoVQ
 tdaD/d4DuMmjb50v3PaeVqZW8FtPCvSm3y2jQx4jEj5sYjTthNqhgWDYL2PrdiZyFy2n
 aBdavdxLjjzL6/dVVeimKKCc+r/S4QJ1xRYg0sJS1Pqog+4RflcgVnYdlyVBBksTbyQD
 17O+OOgJQjzivThKhJ3s3uCxwu9hH7wHs0OVs933Q6CRMAyk5n9nhn4Izn7iLAM2rEZr
 5mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786535565; x=1787140365;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mryJFKNp9U/j2vl+1/90AHsRvVjI17dKCWsj626BK1E=;
 b=b6fKXwt82SLx+2KQ6Xzlt0CJF0jhf5WRPfHCVHInZPHFe4t3lXbu6Pbidd7yEO8Dt0
 QYmV+UEe+eqnYL6RCQXSvca3KaSk5FcBPW6QYm0dL/OF0j9N4CY3HGRjubqG4fQ9Tr8o
 VWBufE3vLX1FRBw+kkEdalywgb/PPWyypz9lbxG/k37hIfYwiZgAc4ga8WvR36IJKrre
 D02sSTpfootVFRUzi6KGEZ5pe3SEBMChDyVQnny2PiPxeGLJtSgsgeh/qo2nDZUZ2nUS
 KEv43ljxxbRxckuqc4PgQahVMuy581jHb/E/QcU6uMF6O6TjVuLjnJLZbAIwdQYEDWNr
 KTSQ==
X-Gm-Message-State: AOJu0Yx6vtTjxciXAJ2RC+H2Wjuna88byLyAkuo80Dnsf0d4KgsVyEL+
 b93UlnVSvBAeODd9DwVTdnZtKkjRhDS6HkAyK64JdnZ9riBm/H3LAgMz29dqcG1tglA=
X-Gm-Gg: AR+sD10uJA5wyezdyC0h6XWEes07w1kwsbW/2MP5i5K5lHjUcqgyVB6UiYXdG1WY8ou
 cCGK3JuV9t/66ETuclKAvZNEWRbxWYE/cT7i/RF0PBel+3m3jlSIqZtlvmzfxQ6Yot2UDp5DuJg
 BhRk0qxLkqvT+o2Yfqm2wPiqcWGGYCFyaYxJXNUdMCXMDLcHls7ZFWbAGAyb0a/vzjw7fx/SCug
 S0BOYES9lfR0tIM9w84IYCIbo2GuOXhvOYWLD4mb+kjTZhZ59Zh8W0Hg/AosE96FZAiZzr7tkvi
 gtbw45mbmpSa59OqItqhvNShnlWPEQvJDOaKLQLYAbhGxqgZiiMjgxq+hhpg4OloOLl2aBkmcvD
 bgDSse9alZiU41/pg9uu8NqHiCTBnAgLgF8rblIAqiZ9xRgmTdAWTOVD6CegFhMOKxxCJ/qKBhI
 2w6RQ8smgB40/Q0LcxX7ePn+V8MHZPzpk5AnZcYkuJbUyHpaw9ytoizc5HMfNPPFhznJ65YGcW6
 rpSjhm7mDGVIa0BcEymkjJzHtsq18apFZJNsKf9qmM6cqAdgvlBIOiU
X-Received: by 2002:a05:600c:37ce:b0:495:58fe:88e5 with SMTP id
 5b1f17b1804b1-4997ac86c84mr97794675e9.2.1786535564943; 
 Wed, 12 Aug 2026 04:52:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:405d:735d:801e:de34?
 ([2a01:e0a:106d:1080:405d:735d:801e:de34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5eb2csm6558329f8f.30.2026.08.12.04.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 04:52:44 -0700 (PDT)
Message-ID: <05d2ad33-a681-41e4-87f7-e3aaeb5428a8@linaro.org>
Date: Wed, 12 Aug 2026 13:52:43 +0200
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
In-Reply-To: <7097b617-90be-492d-9637-4a2a101379e0@ixit.cz>
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

On 8/12/26 10:46, David Heidelberg wrote:
> On 12/08/2026 07:21, Esteban Urrutia wrote:
>> On 8/11/26 9:05 AM, David Heidelberg wrote:
>>> Hi Esteban,
>>>
>>> Usually the used pattern is vendor,ddic+panel-model
>>>
>>> novatek,nt37703-motorola-bronco
>>>
>>> ...but motorola bronco isn't the model of the panel.
>>>
>>> My recommendation - look at some video of screen replacement, stop at moment
>>> when FLEX cable from panel is visible and that's where the panel model usually is.
>>
>>
>> I somewhat doubt the panel model would be located in the FPC cable.
>> I did search anyway but didn't find anything of interest. And I'm not
>> willing to risk damaging the display flex or the battery of my
>> development device just for a possibility either.
> 
> No-one asks you to disassemble the device :)
> Sadly, I haven't found any video doing display replacement either.
> In worst case such as this I assume it make sense keep the phone model in the compatible until panel codename is found.
> 
>> For the compatible pattern I used the implemented pattern for the
>> NT36523 TDDI, which is also used for other ICs such as the RM69380.
>>
>> So, I believe it should be okay to leave the compatible as is.
> 
> I would like to hear a word from Neil first. In similar cases like this would make sense to have one way defining these compatible strings used in phones.
> 
> 
> bit I missed in the review the part:
> 
> +            compatible = "motorola,bronco-tianma-v2-nt37703", "novatek,nt37703";
> 
> Unless the driver is able to auto-detect the connected panel (unlikely), novatek,nt37703 doesn't make sense. The DDIC without the panel is useless.
> 
> For example, in sdm845-oneplus-fajita and enchilada, we have the generic compatible because it was introduced before, so it's kept for compatibility reasons. There is no need to do that here.

Yeah today the norm is to add the ddic as second compatible entry so the first compatible just describes the pane, so here it should be:

compatible = "motorola,bronco-tianma-v2", "novatek,nt37703";

Neil

> 
> Thanks
> David
> 
>>
>>> David Heidelberg
>>
>>
>> Regards,
>> Esteban
>>

