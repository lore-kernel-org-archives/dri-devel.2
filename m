Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4720ECA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1EC210E555;
	Fri,  2 Oct 2026 08:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JwRKBawH";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA19E10E523
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:22:35 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso75965375e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790929354; x=1791534154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oXhQxjCZPJkDL/0F5UFiLvNFCGp+omiCYVv4WP26NK8=;
 b=JwRKBawHVZJvow9zQom2Iz62YqneQfB5dFR9nzdbtRLdi/zFZ+mGJjqbS/p2kHNeqX
 G8aolIIlsYKxxBdK40EJ2J80OVHuWj1H1vKL7IXyEvkdt/kYPvtUnrqB3406j/bGty9f
 Bt8OXComCGgSxrfN/idvU8OgDr6O7he1gLqwQDYC6TZZr3Kl4+c3lIUdXsTU+887v6Cw
 iRMKugVnM28C5/wIujcwSkoPCtDrUdV+rJI8MS8x/9kEwIzcwRvGDn0fSKQyLnDBgiLe
 O7GsVQ+6HhCKUgE9CcPih49BUaZ4VgTBqhC26ShZq3HBaTCtdJ+H8gn+gfiqIw3/Khkj
 FS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790929354; x=1791534154;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oXhQxjCZPJkDL/0F5UFiLvNFCGp+omiCYVv4WP26NK8=;
 b=mZyFEJYMVeCMpagj/T3AjADden8k9qnOlOhHljKLLRjPnRuiThuK999jJP+ZXj1C5b
 WwQO5pqPKDbNlL0zTNv2noEvb5Ke/Q3TThR36VeZ1uneSskgHbG71prfSVj89y37Oqat
 McZ5DFv7E9EsnDdOZaQhGJAUmGaM4tpzrnAAAyWKBLHlaFI3szEBvyVyu5ywVoDcaKmx
 H8+7J2hL559uGBqg4p6SYn4ieThy7XFxCaIMfw8oM6lWPDEeu+RGu6sJu+ww7YCvCD/g
 Is9XoWXLzo8i9T9/gU5N59+Sh2sTa1Qe+AEeUVuTMvrqYG+9T8AadEKR0yXD9Kz0Zenf
 VHxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwZ6aO0twI0prKf7eWlpxKNoe4kNGxDLT9YQpgfX7SpD1wL92rgN/S6QhdBavzQQOXWE5lpdzslvA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kO76l2Jck0r8llMjL7P/J4vd+Az64fEl4gBeCiJfPsl0Tpr7Ev
 V0exHnaiUdCf03b0xW69gilMv81wuircuTjELTW4XiXkW7SWYaDx/qbMDnvSGYOJUXY=
X-Gm-Gg: AYBFou3j7rTvC1UFGB5DkQxDom1duT/gXohggslvwxtuQgIdNAf+OgXo2W+nhfGScZb
 vk9otiBqM92oOrUYJyT3O2BrSMZw79NmRLSQyE2cZcI8Ys+xGFnotoWwbfpzShiQT5o+Sb73rQR
 xuxAUxUvAp/8ZR9vh2RObqJTlQ68pzyeDAaFztBQcRT4bvsp2Dy5xAAnsI3fIBoh0u6bqk6b/3d
 VzDXnNaYsAy61ZlWJI/SU/IZw3aNnQnfMc++M0xqlk/0TSL6413e07bpYQNbsXfdGoIQgHldw+a
 bL5RhKfUHJHd+yzeplYL9ZvN6b9mhYQq/wQjNi9MyK7aseJQHbIIVcY01p1zteRRjHuzhyYuNmU
 56XllUPXWioZtnPRmXIbpGvuhGsp7QjxGHO/nqYNDFKTn6/KSHj1qu/uKwR7ksWuA1sEWVu8DUb
 dAY1w+qNvOAv84PFo6smT1fcjhVGQtWMunWkYfBCRoQo8cIct2uu5Tk5PqqR7bdFEfOUB0a9o/P
 jnB3i0UTOhaAM3M3SHKa1QEfW5wudR4Un6CslLjGiMgAd+NFTyisA==
X-Received: by 2002:a05:600c:37cd:b0:49d:1840:4fd2 with SMTP id
 5b1f17b1804b1-4a0275a1d84mr37767835e9.23.1790929353841; 
 Fri, 02 Oct 2026 01:22:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027f2a4c4sm63997895e9.2.2026.10.02.01.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 01:22:33 -0700 (PDT)
Message-ID: <54da53e6-66db-4357-a00d-da27fb936117@linaro.org>
Date: Fri, 2 Oct 2026 10:22:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add optional wled-supply
To: Arpit Saini <arpit.saini@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 devicetree@vger.kernel.org, rajeevny@qti.qualcomm.com
References: <20260929-wled-supply-series-v1-0-75d0a83b4b00@oss.qualcomm.com>
 <20260929-wled-supply-series-v1-1-75d0a83b4b00@oss.qualcomm.com>
 <20261001-private-wooden-chachalaca-51aa57@quoll>
 <997cefa0-384c-466f-b318-077939946768@kernel.org>
 <cebrka4ya7u32ntiya42yx4txa3uryf5k2di234zm4enz3a6vy@xhily6qqmevo>
 <1cd249d8-0a26-45e4-8263-dd4a120fc89e@oss.qualcomm.com>
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
In-Reply-To: <1cd249d8-0a26-45e4-8263-dd4a120fc89e@oss.qualcomm.com>
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

On 10/1/26 20:09, Arpit Saini wrote:
> 
> 
> On 10/1/2026 3:25 PM, Dmitry Baryshkov wrote:
>> On Thu, Oct 01, 2026 at 08:57:52AM +0200, Krzysztof Kozlowski wrote:
>>> On 01/10/2026 08:55, Krzysztof Kozlowski wrote:
>>>> On Tue, Sep 29, 2026 at 06:42:20PM +0530, Arpit Saini wrote:
>>>>> Some boards drive the ILI7807S panel's backlight from an external
>>>>> WLED driver whose enable input is wired to a GPIO, typically modeled
>>>>> as a fixed regulator (e.g. vreg_wled).
>>>>
>>>> You describe something else. What's fixed regulator should not matter
>>>> here. Which pin is it in ILI7807S?
>>>>
>>>> It seems you just want to represent GPIO with a regulator. This is just
>>>> confusing and typical downstream workaround.
>>>
>>> What's more, you basically REVERT the review YOU RECEIVED in v1. Really,
>>> just sneak the same stuff 3 months after like the review never happened.
>>>
>>> NAK
>>
>> After discussing this offline with Krzysztof. It's not a supply (my
>> fault), it's an LCD driver. So, the best way to handle your displaycard
>> seems to add a gpio-backlight, reference it from the panel and then in
>> the driver check for the backlight's max_brightness level. If it's 1,
>> then you have to send extra DCS commands to control PWM. If it's
>> higher, use normal backlight class controls.
>>
> 
> Hi Dmitry, Krzysztof
> 
> I have a few clarifying questions regarding the proposed approach. Please let me know if I've misunderstood anything.
>   
>    panel_backlight: backlight {
>        compatible = "gpio-backlight";
>        gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
>        default-on;
>    };
> 
> 1) Adding gpio-backlight and check for max_brightness level if its 1,
> 
>     If we model LCD_BKLT_EN using gpio-backlight, the backlight device effectively exposes only on/off control (max_brightness = 1),
>     we can't support the full range of brightness i.e 0 to 16383 (0x3FFF)
> 
> 2) Adding gpio-backlight and based upon max_brightness level of 1 , are you suggesting to register another
>     backlight device that can actually drive DCS brightness. In that case we can actually have the MIPI DCS controlled brightness
> 
>     If so, wouldn't that result in two backlight devices associated with the same panel:
> 
>      gpio-backlight device for enable/disable
>      panel backlight device for DCS brightness control
>   
>     Is that the expected design?

It's a great question because there's a large variety of how backlight is
implemented, and some panels can drive a PWM to an actually backlight controller
which uses external pwm. In this case we should model the backlight IC as
backlight driver with only 1 or 0 capability and use the DCS to program
the PWM.

So it leads exactly to your issue. So perhaps one way would be to either:
- call into the gpio-backlight from the DCS callback, we may need to fix some locking issues
- add way to "link" backlight devices so the backlight value can be propagated


In any case the problem remains that both backlight devices will be exposed
to userspace, which we don't want. So additional changes will be needed.

> 
> 3) I previously tried modeling LCD_BKLT_EN using pinctrl states (panel_bl_en / panel_bl_suspend)
>     for the enable GPIO itself. However, Dmitry suggested modeling it as a regulator instead:
> 
>     Link : https://lore.kernel.org/all/qkhgg5x67sijiialucvzac275zhpjrtt47a4udjpyzmgvilut5@dcrslq3ai7mc/
> 
> 4) Modeled optional regulator wled-supply: a regulator that only gates the external backlight driver chip's power/enable,
>     with DCS remaining the sole brightness path in this current patch , the panel-himax-hx83121a.c does exactly the same.
>     
>     Would this can be the preferred modeling for such panels?
> 
> Please refer to this Hardware diagram I explained earlier ,
> Link : https://lore.kernel.org/all/bade420c-aeb8-4bdd-b0cf-3ade17b21c18@oss.qualcomm.com/
> 
> 
> Please let me know your suggestions.
> 
> Thanks,
> Arpit
> 
> 
>     
> 
>    

