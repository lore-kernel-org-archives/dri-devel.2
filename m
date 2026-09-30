Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1915ACA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F99110E4CD;
	Wed, 30 Sep 2026 16:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b9HcRqiV";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA7310E4CD
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:43:51 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-9107051ba26so30015186d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786630; x=1791391430; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tQuiLgKEFgvUaPnU/nIMejNLh/kt/JowyvkWugrWOng=;
 b=b9HcRqiV16LbINBZeyDzL3nEpHTLAv5jXSf+iFXBMvpaQ17hL2Qh8xi+ii9DVXDKYI
 7ETL/r/1JudsDh8dvdOzTb6JNo/yZkvYgZ1CxQsN/FSAEXvSey+drGevjfLeisxVT3iJ
 3NZOQFOsEEqOLfV5D2lOD3yGjmpGvZVDuXP2x6AJN/Xnw9FEd2l6GiCW/ycQdwbP2qG0
 CPECXaml2azE9p99rwGGMSP3SzGAvmPqHpQJAtNHeFWGhWazoz37j1CIismgrDDsnqyy
 8Nqzcof4UUIdtd5hje1ZTKcggmCYAcypcHE84xh6o1069/jbtkFuOIvoGJhgGD/YCpdX
 gMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786630; x=1791391430;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tQuiLgKEFgvUaPnU/nIMejNLh/kt/JowyvkWugrWOng=;
 b=Ljwpb7yCk33l2gb3LCVzyrtdAXxqYMnCgOQGD/ws2dy/og4trmrYeP52FcvETv4Y7p
 8MBUeAIIEi73furjTlBC/7WtFxHrCFAzucNEl/KIyMBl5ktaGW4zW+LvNGCQERHOfSj7
 5QS/i19DEGeDUL153UV0Wl4Xfrm/9xW+FU5sFbMx/OHnuaTTLe29AJEffl9OwRgaVWfp
 0TLdfo/SAPDDJcM43Iega7Jf1rElQwiIUsZHLfHTAWjGsxQvOBuphYS9OQnwJsPFSTGZ
 jdAz6Rt4R6uSljsmjs+JTmrqLQgkmRgx1/vTw9esLRNk9zLVz98z2ZJPosC6/2xuzHft
 gFrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0c4qOjNXHimS7DFUEs6J48HERA9tB0anX7yMWupfa6ON7OKDt98YXCG6+xXJs3AJDGPleEYLjg68=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ8k3oisg20/z1nkXivm4qOTXGBAT9scQXxE30IleWf2jXS805y
 Fv9HlwKxpUsHmUGzMs1KYD53WMu+bCTGtPmZmX0Om1qiO5OW7HLjxOYyLQtaJeyEflQ=
X-Gm-Gg: AYBFou3OUpEbVQ5xQBecYamWziXzM4Pkxjm85THATU3pAKj4RD74lZu3Ce4UYZuPjKm
 dlbmG8t7V6mWw92oPAdybBH8qX+vJ9dPqBE4BUCB0KScVBc1eplRdaty2x7beW1374vN7dczPXt
 qhqEbo5sJUoxf3Nd0Wxo0iTLoHd66YqJ1bRcELj3qRTav7y8lRKcxzZog06O2026GgyjQywovjY
 ofwPj/FdiTlwRlQkABJiolzmfX0vUO9qCgoCDeM0Y9EBgaPbGj4ciMdLXpL2H8msUhde5WZ6fMZ
 YYE3WkfI6F/RDDAQvsKnhayc4a1iM8r8HvP9LhBhu0fL7uJQgAZwRl0qR0RhcWWzIpvIX40PCXP
 dTE5FGXLTW+4uxOfdLe5mtEU5uegqpYO/cFIfSPM7v0VUCaFa/4Gh5iSucRwxGC7RrSpJfDdpe+
 45rqSrqEJJH4IuDEpI3sCX113Cuf/VJWTMf64c2jrdPQEJcSHrvNLTOy4bgR7Mf5Aq1gsREGgyf
 JWjowaEfbarL7Odwq2DrlJh4iAAqhibTW84SpIL3oBMT4IA1Cfi59PwJhxA/XoFnYCeBFsf9ubr
 h7b5tpHMKuHXShmmCA==
X-Received: by 2002:a05:6214:c4c:b0:912:4680:c96f with SMTP id
 6a1803df08f44-917a09cf960mr34578076d6.3.1790786629576; 
 Wed, 30 Sep 2026 09:43:49 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a89a818bsm3800116d6.16.2026.09.30.09.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:43:49 -0700 (PDT)
Message-ID: <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
Date: Wed, 30 Sep 2026 18:43:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
To: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jun Nie <jun.nie@linaro.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <20260727-spotted-winged-mantis-7aa1ce@quoll>
 <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
 <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
 <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
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
In-Reply-To: <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
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

On 9/30/26 09:44, Linus Walleij wrote:
> On Tue, Sep 29, 2026 at 3:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> This entire binding seems like stitching two devices together, which
>> might be fine (I don't even remember this stuff... two months old) or
>> might be artificial grouping of separate devices.
> 
> I think that's a good point and fair pushback.
> 
> Neil and Jun talk about it yesterday at XDC (1:15 into the stream):
> https://www.youtube.com/watch?v=6tNGW8PoSzw
> 
> The current binding does not reflect the physical topology of the
> actual device, and the bindings need improvements. I have a feeling
> there is one display controller with two physical panels.

No there's really 2 controller and 2 separate panels, but they are not
classic panel, they are a pair of panels+lens which are in front of
the eyes which forms a single "image" for the brain, so they are
technically a single display and requires to be hard synchronized.

The R63455 is designed for this exact use case and are only supposed
to be use in XR application in pair.

See it like a single physical panel with 2 controllers which
shouldn't be used separately. While technically a controller could
be used to driver single panel, it's likely impossible Synaptics
would sell this IC for non XR applications.

We want the both panels to be seen at a single big panel because
physically the human eye will see it as a single display.

Describing both panels into separate nodes would only be possible
if we described a "VR display complex" nodes linked to both panels
but this would probably be solved by actually describing the "display"
linked to a DDIC controller and is out of subject for this serie,
and can be added later when we properly define things.

Nei

> 
> In that case I think it's better if we do:
> 
> panel: panel@0 {
>      /* This is the two-panel package with one display controller */
>      compatible = "sharp,ls026b3sa06", "synaptics,r63455";
>      reg = <0>;
>      #address-cells = <1>;
>      #size-cells = <0>;
> 
>      panel@0 {
>          reset-gpios = <&pm8550_gpios 3 GPIO_ACTIVE_HIGH>;
>          reg = <0>;
>           ....
>      };
> 
>      panel@1 {
>          reset-gpios = <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
>          reg = <1>;
>          ....
>      };
> 
> ...
> };
> 
> 
> Yours,
> Linus Walleij

