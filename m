Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C383CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2BA10F41F;
	Wed, 30 Sep 2026 19:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iE4GTCvx";
	dkim-atps=neutral
Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com
 [74.125.227.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE9610E263
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:18:59 +0000 (UTC)
Received: by mail-vs2-f39.google.com with SMTP id
 ada2fe7eead31-7bdf5a43fa8so342117137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790795939; x=1791400739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ewIF0riMHpbsIkdRakHTnfj8HYILpZHHiLSDM7xGPeE=;
 b=iE4GTCvxAmDTg/v2k8isB3zOUeOFQ3SR7zTyFvwj6v6vkqPmVQ61jnZvFP/+9rnC21
 XlZzgNmJCdsxl7y7NLE08KYs99vO2YV1nxe+a6TsJLT/ng5BiZv0se8mkqBu27XLqVIf
 7YEOdRwH5JRgsDi8suID+T5RsCFcsPZOcIfjcvqdm71NrReX9aMvkfQ1aUwrNqUhb+8R
 XTgZEkJnbM78Na+RGO1Wxh6fbZgKHDm7NQsMc3aa/5sYh63dG+4W5L8aNuPOAIAeeqtv
 2izPA5M68ZUWLzH/rX1hurTIK8sVhxJA9y5VQ0RSPILEUyD3oOmtRtJ2ERdB3heWtyc7
 uu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790795939; x=1791400739;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ewIF0riMHpbsIkdRakHTnfj8HYILpZHHiLSDM7xGPeE=;
 b=C81+K+dcz9TWaIe7btgTOFBhb/0WzFmqsFvEY1tsPF1XalY88EvAMax2FoFA0oyjD9
 YlTay90PRC/YI7D3WShimMejJ/9azp1YyYlIth+8auNGUOMwRtmnY0EGHiKwbxWZIasx
 UiR1CtjA6BnCOngeaN4yRRARUV+1S9qlhIFyVGI3x8TAgul5T7AKq5N2YOHXdvsveKz7
 hikPibBoSrPPRdGmLfI7klte33NPLZYoVutby0mr/072HMxMAQaZEUsnCuQcFSS+ajRD
 itHX/4nMzTHu1CXS3ayHuKzEm/wQP/gaTC6iuUdMEDxWiaYWxYUqHv6k+i3Mc4+iUImm
 O6RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByb28qv3yEn67SdWXQg2BvqUm2SvaK9FOIRkkkOmuKvGeYFX4k0t3jkWTCWwHJ17O+9TDBhIww47HM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwCpDWaroWOBDzyalsesaRyiRDAbyFPAguaErLF7HNyFGyGHer
 QFeXWMgrEtmCZuv6wpxeCK4GjbwpZ1oOJO3bLrMokETMQVksIG2SuhW1v8Qm3YA86q8=
X-Gm-Gg: AYBFou2SNmhx3cRtQgnvZh4t5Rr2vH5AsMg7NKB8u+NtTc3QVS6517Tv8xtYq16kuzh
 0JCIad/WgYKN1WP1cx8Qq+Znxm10ZSO22B0j3x6daG+55dqXXI/OKUJa5MOBHskl9r620LTjOXA
 YF2162lEuDE42PMukTxRYpITfht6Iu0XbHJ4kDpMjy/N1SO202XtUUCUZpeYDesYYl3fMTi5Lk5
 RTCAT/Cc3MQA43Ll3rMC7HRE57uKQMclOduUPGn8LYghj9w0z3L461EK30v8cB+pQy1M9qFgI1T
 EfIrKxxWLN43Suz4q8JHy7PKLg27KxzM2ddHS7XF+3tUaTfiZLli48M8ixF0I1jy+Lkg1yxEtCj
 hWZ9l0SHkX9SFwXcKlo2R1hdAWusDta7wwJfkx0+kH0OVbJ4q0NfCbtWGtrGfCeuMKLD//82vph
 OudR2bDyHUs2+8XCA1+VZEjP5UxLDafoY1hVMflc6scuJUfCzbAbfEp6wQ6z/LcmkLMHjqxYZSR
 77OLzCHkRVayvf4WxJGV/LJcz/2Y8+wIhXWhH15Kd3FdhhwvuFv09suW0bxYQwxrIOoiiRZWVSs
 Q7sHJ+w=
X-Received: by 2002:a05:6102:9d8:b0:7a8:15ba:c509 with SMTP id
 ada2fe7eead31-7be622a2858mr567244137.1.1790795938407; 
 Wed, 30 Sep 2026 12:18:58 -0700 (PDT)
Received: from [10.21.51.184]
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-98a870e08d7sm819586241.9.2026.09.30.12.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 12:18:57 -0700 (PDT)
Message-ID: <4d053234-06d8-4268-b60a-2fccc78da654@linaro.org>
Date: Wed, 30 Sep 2026 21:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jun Nie <jun.nie@linaro.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
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
 <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
 <2lcpzwh7fxecpffnakpnp5lecrm3e6u64ztat7cd75nuxofxa2@clj27bzgjy3r>
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
In-Reply-To: <2lcpzwh7fxecpffnakpnp5lecrm3e6u64ztat7cd75nuxofxa2@clj27bzgjy3r>
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

On 9/30/26 21:04, Dmitry Baryshkov wrote:
> On Wed, Sep 30, 2026 at 06:43:47PM +0200, Neil Armstrong wrote:
>> On 9/30/26 09:44, Linus Walleij wrote:
>>> On Tue, Sep 29, 2026 at 3:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>>> This entire binding seems like stitching two devices together, which
>>>> might be fine (I don't even remember this stuff... two months old) or
>>>> might be artificial grouping of separate devices.
>>>
>>> I think that's a good point and fair pushback.
>>>
>>> Neil and Jun talk about it yesterday at XDC (1:15 into the stream):
>>> https://www.youtube.com/watch?v=6tNGW8PoSzw
>>>
>>> The current binding does not reflect the physical topology of the
>>> actual device, and the bindings need improvements. I have a feeling
>>> there is one display controller with two physical panels.
>>
>> No there's really 2 controller and 2 separate panels, but they are not
>> classic panel, they are a pair of panels+lens which are in front of
>> the eyes which forms a single "image" for the brain, so they are
>> technically a single display and requires to be hard synchronized.
> 
> Yes. However this approach makes it impossible to share the code between
> the double-panel drivers and single-panel drivers. I think, that the
> panel driver should still reference a single glass+DDIC, while letting
> the DSI host driver to handle the bifurcation.

Yes, and no, it must really be considered as a "single panel driven by 2 identical controllers",
and even this is really purely software implementation issue.

> 
>> The R63455 is designed for this exact use case and are only supposed
>> to be use in XR application in pair.
> 
> yes, but no, but yes, but no. I mean, nothing prevents one from using
> this DDIC in some other usecase.

Seriously, no, it's a likely very very improbable situation and
we need to accept to ignore things that will never happen.

> 
>> See it like a single physical panel with 2 controllers which
>> shouldn't be used separately. While technically a controller could
>> be used to driver single panel, it's likely impossible Synaptics
>> would sell this IC for non XR applications.
> 
> I think, this was causing an issue with the DSC too. A normal
> bonded-DSI-panel-with-DSC and this-double-panel require different widths
> to be programmed. Having a panel report real resolution would drop that
> quirk from the DSI host driver.

This is purely software implementation.

> 
>> We want the both panels to be seen at a single big panel because
>> physically the human eye will see it as a single display.
> 
> That's the CRTC side.

This is purely software implementation.

> 
>> Describing both panels into separate nodes would only be possible
>> if we described a "VR display complex" nodes linked to both panels
>> but this would probably be solved by actually describing the "display"
>> linked to a DDIC controller and is out of subject for this serie,
>> and can be added later when we properly define things.
> 
> I like the VR complex idea. In the end, you have two modes which you
> most likely might want to support:
> - L+R, having double-width CRTC scanning over a double-width framebuffer
> - Mx2, having a single-width CRTC and a single-width framebuffer
>    displaying the same picture to both eyes. I can imaging that knowing
>    about L+R might be an explicit opt-in feature of the DRM interface.
> 

This makes no sense to support both modes, and this will never be used,
and anyway this is purely software implementation.

We're defining bindings here, describing the real reality, not hypothetical
situation that will never happen.

Neil
