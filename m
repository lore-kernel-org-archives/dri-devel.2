Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1602CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4451910FF59;
	Fri, 29 May 2026 13:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TM0xLTkP";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C1B410FF59
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:41:10 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45eea3448f2so1029580f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780062069; x=1780666869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=w5IgzBtL3hdaFI1JoT3J9eqUHcohZ+48uLSQ9wTYks4=;
 b=TM0xLTkP4gcXOO/rL5cweiL4falQX7vREygQfvLcZMPaoLwA44WcCtnVOmEGyMFOQL
 8deVQT+GP9+S/41g8XVe7HzI6yEapUye+LYanMVW3rigXuufTDT1pBbsqA+7ZalDtdTA
 DicgITvqibmlYVRxbYmBzqmQQZ/iWEZvJgkhojSC+/ncHFtztzj+h9ym56CrNBLyI6+0
 GnGKm5cfV7WNE4INdL23WEzorN2go7QxQjIQ12LClcfoOIeHOp/ItGq9c6HVGK5g+da6
 iWQpMc6eHgt8lidAa5CgJAePMZLjf9ifR1GwOpdc2aRV97xLZyBxl8h3brx8sTFjsAfD
 TGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062069; x=1780666869;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5IgzBtL3hdaFI1JoT3J9eqUHcohZ+48uLSQ9wTYks4=;
 b=G8uvn3t3x0lMp7wwd5Z4c8E5gQECYOmP/VpYE1nrsNbVWof7Bd2Hun5TXsosnKBn3y
 sA4JNOniTTeNzpsPYJcnhIzsDnUmka76xQx6vy4fOg3o1areVynuTSotzzzVbHNW71R0
 r3GYR30QH2rqy9OA0ZFBJ4LbciDhX50W9YCuTGuZb+81ZwT+39ihoID5iNOw5Me0SwlL
 hCXc/FhGC5i1m4Vkla/t78xYY6KNf63D83eMuUDu3AX61hpwnbzFMpocgXTGGkKEDJzL
 cyUS8T2sa2ZbBWaAhEmmcvLwiSjhmE3QR3vw59gkt+bIj5m1FgvG8lVGlwjAjUXF5Mzb
 IYEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HhPnZgP+ybubfdNQRvCibPAc+kboswMJXBzOnu7e0mCHFpQYc+sWFI0GQv00bUgfGp4Hv1qd/52s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywbscscxWp4CI24HDei3ahIMSNf0PAQdk/y/GnZczyqkcL8PvU
 0NaIle66dzbDrl4HRFmnbfWFbLT+XSOaw+YH2bz3Sn4MEFAJpwbd+0IQPndD0h9ybfY=
X-Gm-Gg: Acq92OHyQfmnT5BPtKwLgzqUrLT0IBU0HhKbRTp4kn5Tt0kXhBSBk32+TDopO2RCuB+
 ySMhYVhheqx127JAcOjCD00AjcbHzfDM9+gMXreM3sOWEvgyp0E2UAtL2iXWt/u3W0lLe4dqYl7
 qd+Tr8SQwuB++0TZUV8d5SJeV+4qqJj88ccpsyq+13C3QXNfV/V6tMeBfeT/LuL/Nbgeo21ZXtJ
 wUUG5jeCHqUFbgbWc2j8XREC1EGi41GE0ypimjiUdQadDHU2/op2ZN8DE/r6J9mt0v76K1oIsYP
 rTEwNQ8vD8UtoeFgWKEp+/RsM7Bg64x+KB3320LxZKhmnpJdGQ6pZG2fSYpaPfCOKXenV/vhck3
 LxbveM9mXV8e9WUwnO+4wL7MjskNKUetXcLBY6WM3ebpczKKkhTnKiNevy8kszWTqOxX99fno7W
 g3sy2zt7Oe3w/4IZ0k7xcNMy7CJ1XkQt0iyXtgJFCmNXij3D9GrXdm8AYMJZ7LU23hW1vrFNZ8z
 tHClvW0piqes84zYA==
X-Received: by 2002:a05:600d:848c:10b0:490:48e2:5618 with SMTP id
 5b1f17b1804b1-4909c0affedmr41223155e9.22.1780062068618; 
 Fri, 29 May 2026 06:41:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b6d0:a628:be51:f552?
 ([2a01:e0a:106d:1080:b6d0:a628:be51:f552])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm3488697f8f.18.2026.05.29.06.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 06:41:08 -0700 (PDT)
Message-ID: <a0d209bc-f37a-4962-9e38-5cf9d1e8d936@linaro.org>
Date: Fri, 29 May 2026 15:41:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH v3 00/11] arm64: dts: ti: k3-am62-verdin: Add
 display and peripheral overlays
To: Nishanth Menon <nm@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Vitor Soares <ivitro@gmail.com>,
 Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260522161105.277519-13-ivitro@gmail.com>
 <177980721984.3070642.16547338359984019493.b4-ty@b4>
 <20260528114043.n226kfd5urad22xe@sulphate>
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
In-Reply-To: <20260528114043.n226kfd5urad22xe@sulphate>
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

On 5/28/26 13:40, Nishanth Menon wrote:
> On 16:53-20260526, Neil Armstrong wrote:
>> Hi,
>>
>> On Fri, 22 May 2026 17:11:04 +0100, Vitor Soares wrote:
>>> From: Vitor Soares <vitor.soares@toradex.com>
>>>
>>> This series adds device tree overlays, expanding the hardware support for
>>> the Toradex Verdin AM62 SoM. The overlays target displays, cameras, audio,
>>> and peripherals available through Toradex carrier boards and the accessory
>>> ecosystem.
>>>
>>> [...]
>>
>> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
>>
>> [04/11] dt-bindings: display: panel-lvds: Add Riverdi RVT70HSLNWCA0 and RVT101HVLNWC00
>>          https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3c3c5fb9b36836d279ebe370189d68a0a3387362
> 
> Neil,
> 
> Could https://lore.kernel.org/linux-arm-kernel/20260522161105.277519-16-ivitro@gmail.com/
> go through your tree as well?
> 

Yes sorry will push it now

Neil
