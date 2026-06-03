Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20594CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7154011209C;
	Wed,  3 Jun 2026 16:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qjz0ynBA";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F5D11209C
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 16:25:22 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-396771119c4so42407121fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780503921; x=1781108721; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=8bFE4+s9zgaljDPO1AWoluZ0vX4iTVWOm+qf5IujDVo=;
 b=qjz0ynBAYEbo2p40hrny2zdPNv9fkZ5AZLLBcJaAA8XkZpzGMYq4pnYeRZ35BlEUlD
 wqfzKzKBbewLkX5AmVXhsVJtEkQTn9S3PuaGxWFQ3gMBtrkoVD+Ubv6qXVCEF3HOk+zb
 QuNDLwgz+Awyu2SvByHGNtf4rYCmPSPHip4X4vUtTqJvUF9yT8CdUo8BGuFGCwTmp72W
 EHEIFluurGAhP204Sax5Gr8C1VrI1OwpsmcW0mT5chX1Ie4egdJbtdxPvczPim5XEDRi
 9ut9neIH3OWB7t2f8wvb+PTSh5PHTVlIBN32orL3D2mXLJOYfkOfizo1FmwnofsCUuyv
 lJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503921; x=1781108721;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bFE4+s9zgaljDPO1AWoluZ0vX4iTVWOm+qf5IujDVo=;
 b=dKKrpJ2/Wt0chVGxX1yiPFD6J6aRdPXJ2sx+vofCuzNbcyXzIy/MB5Nck8QOuHt7+a
 fWr024Z/cfdfT2ikfUUZ5xcRmNkfzFBuzPVeXRAiuqpzqDlABDxBCTow3PRtzKFN/ihY
 W8C6YcS3pCRLSnGaCyK1gPzhIPDontmkGlyfbrIQNdbJctKEp9ICEYqxIVTaEnSJ0JLo
 bWWzBq8n2vkcZAu05A2cGN4Yja0qAESqZDyzxsj58V6KB9rsNWGOFD1HxHmdbT+xizkv
 jS+SmKgWwegUko0hi6CBytDob+zCUPWFQ+gvyJXnbwIpCIfRnenNh+jH1tkfwlqwxq/B
 5LgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nKHvI7OaMdY7AdBVKZ6xjH3Ylkf4vlVFdWHzqwLbQCrk7JM30h46r84ro33e8SYtrQqexnSdoRuc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPVus8wC6Ua1aBL4q4tzVGPfsRga6yw/Ud0/Hwc+5hEnWbIN81
 FwD3HyB3PRn34a2nStm2mBEsSmHD3KETIYhpkz4ohnOEN/oeU18Rn9tTYN8hKskgGY4=
X-Gm-Gg: Acq92OFewdUd83W5OVLSxfn4EISdydcfCNbDRvKdqvfkwK+sJ4ypQxxQk6fDmUPXqSv
 aJ7xUDQRbN2R7MLNwSTBm8pNS7uHkbtncItZwNG7WPPdT6j68ApgQm47VD1R+XI3UiCkIfwdynd
 gt3uvg+R1Q5A9JA1nb4NYUDULEEq/urqjxTFG4Uh0nuKK3IeJr0VAHCVfrblN5v3/9ebiQM0L1T
 gmcX/5uDh45T69InEHFzpotXsq3ZhULB2rrsBDYWlO2MoOMoYZVjfl8ahm/ivILgKY0qa+hPRoY
 nSqWnV/vJp4/TsoqGqc5tW7E92OjZIvsq8XuJN4aXhFw8kEtjQfNNdyqSRXeQpC/BEh4ig5fS51
 aMeSBrm4BZ1P4NV3hoNlCPRoUt9jPYcHcKUWgSvPXNTW+QhkBX4hXyASi55KANZrN2I2GGI1Dti
 xFsp/SfSG6qrpFZU5JXkHq1bbSt7Awh7QgfidI90ht+GhTK3TV+TbFw1TT4yTTaNN+9w6l0qtie
 FJa0Fydw/61igm2IpuZzfCBmSMs
X-Received: by 2002:a05:651c:244:b0:38d:e220:8dc2 with SMTP id
 38308e7fff4ca-396af476a70mr12594011fa.20.1780503920820; 
 Wed, 03 Jun 2026 09:25:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2a0:317e:910e:9ac9?
 ([2a01:e0a:106d:1080:a2a0:317e:910e:9ac9])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2be1a3sm10048021fa.20.2026.06.03.09.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 09:25:20 -0700 (PDT)
Message-ID: <bf6155fa-1bf6-45d6-affe-1c8baa3561ba@linaro.org>
Date: Wed, 3 Jun 2026 18:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Document BOE BF068MWM-TD0
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260603-asteroids-panel-support-v1-0-109c6ac81c8f@pm.me>
 <20260603-asteroids-panel-support-v1-1-109c6ac81c8f@pm.me>
 <4a7c19a3-bb00-4a68-beea-146ef65f9e5c@linaro.org>
 <ALMSs_2ssEuRgFGXhTUpuP022Q2bMpEn0F-QqFgw4PYn8RkcSWGh0e7_lL3XZy1MQpViwpnMj_98Mi8lTP6A3UsRAYi8XuZWdqIAFVT2dq4=@pm.me>
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
In-Reply-To: <ALMSs_2ssEuRgFGXhTUpuP022Q2bMpEn0F-QqFgw4PYn8RkcSWGh0e7_lL3XZy1MQpViwpnMj_98Mi8lTP6A3UsRAYi8XuZWdqIAFVT2dq4=@pm.me>
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

On 6/3/26 16:01, Alexander Koskovich wrote:
> On Wednesday, June 3rd, 2026 at 9:58 AM, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 6/3/26 15:03, Alexander Koskovich wrote:
>>> +description:
>>> +  This is a 6.77" AMOLED video mode display panel on a MIPI-DSI 4-lane
>>> +  interface.
>>> +
>>> +  The panel also requires ELVDD/ELVSS/ELAVDD rails but these are
>>> +  internally managed by the panel via EL_ON1 (ELAVDD) and EL_ON2
>>> +  (ELVDD/ELVSS) control signals, they are not managed by the platform.
>>> +
>>> +  The driver IC for this panel assembly is an RM69220.
>>
>> If you know the DDIC, please switch to bindings & driver around the RM69220 DDIC
>> instead.
> 
> Question about this, isn't the DDIC kind of generic? E.g. another panel
> assembly with RM69220 cannot use this driver if the actual panel assembly
> is different.

The goal is to be able to support DDICs directly in order to support panels on top,
so just rename it to the DDIC name and add the DDIC as fallback in the compatibles.

We usually don't know the DDIC, but when it's known let's use the info.

No need to add panel selection logic now.

Neil

> 
> Thanks,
> Alex

