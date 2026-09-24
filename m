Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E887C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CD310F556;
	Thu, 24 Sep 2026 13:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q3C0xxLU";
	dkim-atps=neutral
Received: from mail-wr2-f40.google.com (mail-wr2-f40.google.com
 [74.125.225.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCFC210F556
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:30:51 +0000 (UTC)
Received: by mail-wr2-f40.google.com with SMTP id
 ffacd0b85a97d-488780459e2so139909f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256650; x=1790861450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YRQIkeCTQEyb4HBTY3lpiZgTT4/cR8W38463IYXlT3A=;
 b=Q3C0xxLUXy8ZvwqYOflPH7ONB9BhZ2+p7ljLpvgQOXuP48kk3+F6biBQHiPFSLJ4wC
 vWREL5IN7yiO2uQU+a6tkwkhTcFqsrKmzzinNo4bIJYEeTscylc+FEf0vIeWBc2SDpD/
 EwvegffcI4WiIXfm9lHFX/ynIuPmAYIaaMLcAswDNIFGZ1f+ctiXNhCKF4y4GpNlxXlf
 4rFo2iuteRYFTjekPzcrlouYdhUOgYxR4EJvG1KO++Ue/e3bA05m/pNdjysz0PSf49hY
 XiDdHw9GEepb7kMCpBX55aEshiZPGSfrbV3NZBFO/3Ifr2mxcaQthaEsCIUybkqpaZSn
 O5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256650; x=1790861450;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YRQIkeCTQEyb4HBTY3lpiZgTT4/cR8W38463IYXlT3A=;
 b=PorcmaV70FtNqPL0y7+0PpeGT0SEDILrAKpUxDPguRt1JNmmcm7TfaT6gdJbL22EjL
 yG/vSNx1c17USBIV8sztDhKTQdibxHkhuc1XTS3WNs/XnmfUEBJwADKIQKpA1bHHl04J
 bAWs8UDiLH3RwQFtWIGzqWnkyMwZdKfChFjjivoTih9f9ACe9GswMpy/OC6aQ57+YYuI
 ZEq8N8W0VuHKRnRTnQ3aUqM4bIfuHL7LtjbOskEuVAhaWBLo50oIRxFv/pJBqGtnzPw2
 Wub3syDtOuIv4e3UaIYMBY797bHRjC0hsLozMZrH69v5y6V3SDKMjyllfFJ8I3bmpSxv
 VwJA==
X-Gm-Message-State: AFuF++mdcNcv5vrQxD9l3gtMmhOOXqZ8LwCn72h2KxK2B1rsbfhTdCkH
 ElAFw1ryJXwyKdyfK8je1Jxc41zSZS6R5KmX+Z6PQzsaK7IzdxXfJf1fnC88Kfxv69c=
X-Gm-Gg: AYBFou2f8pdXvdfX3BPUvy7iF8HqHoHXAAzkyc/QW1koC/mRunHCs6l02LS3+xjSQ8y
 SbEbgEANRa8jyNU5yQ/F2hJXfjyJk6xHP2Aevy+vm+6eC1JzdVtDvZq6hMkyAQ+dOFRqhdb0Gke
 mvSxYIPSJRMhPqAG4kitirkpLKm7NorSCiTHoSJ38+KRnIuQDSfF2pS0zf1lEgdaSvm4gjkXlZs
 Op9N2CoYGEPuviHu6oWsTTs7rEmp4u7ByNXRgd/fwShg4JvRnZs3pDl/RZ+EvaZ6qJSBYeiLkpg
 xwDCPnzGP31yAgSnv4FLwv9Cm3J4QcHrcb7F76as5rDgVDsN+LPSISL1ETzTSI8fMWz77EkYrdK
 HraGZCYpbwonGjvfr8E7tGiak6DzN72EgVixlyRNv+QMknj/ZKOEIgYY74QaiuRNoedCvvFKiT6
 lMdYPaTZUKSQJ/nnNAJRNak1r8WlETTyNIO1DUwwbS1N6HEB6dWAPEbGpPB0cQuHmm3USWw0o1F
 F18zxKCqac5E1PWgiisWj+ik+CJK9WoMPqR5ojcylcjPO96M2S/E7Y=
X-Received: by 2002:a05:6000:2301:b0:487:232a:9b68 with SMTP id
 ffacd0b85a97d-4887176973cmr4820755f8f.32.1790256649831; 
 Thu, 24 Sep 2026 06:30:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889130sm14483512f8f.37.2026.09.24.06.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:30:49 -0700 (PDT)
Message-ID: <b07a76df-ab1e-4b98-8c6d-ece2e8707102@linaro.org>
Date: Thu, 24 Sep 2026 15:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/3] drivers: gpu: drm: panel: Add BOE NT51021 driver
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nickolay Goppen <setotau@mainlining.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260917-qcom-novatek-nt51021-panels-v4-0-30afbc35d70c@mainlining.org>
 <20260917-qcom-novatek-nt51021-panels-v4-2-30afbc35d70c@mainlining.org>
 <ba4fe17c-ee29-4739-a14e-87b39e5efcc5@collabora.com>
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
In-Reply-To: <ba4fe17c-ee29-4739-a14e-87b39e5efcc5@collabora.com>
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

On 9/21/26 12:49, AngeloGioacchino Del Regno wrote:
> On 9/17/26 14:51, Nickolay Goppen wrote:
>> Add driver for BOE NT51021-based 8-inch and 10-inch DSI video mode
>> panels used in Xiaomi Mi Pad 4, Mi Pad 4 Plus (xiaomi-clover)
>> and Amazon Fire HD 10 (2017) (amazon-suez) tablets.
>>
>> NT51021-based panels also support content-adaptive brightness control by
>> generating a PWM signal for backlight driver IC. Content adaptation
>> means that content grey level scale can be increased while
>> simultaneously decreasing brightness of the backlight to achieve
>> same perceived brightness. This makes the power consumption of
>> backlight be reduced with keeping acceptable display quality.
>>
>> Both panels are very similar, differences are only in init sequence
>> and resolution.
>>
>> The register sequence of the TV101WUM-NM0 is the BOE branch of
>> init_lcm_registers() in drivers/misc/mediatek/lcm/nt51021_wuxga_dsi_vdo/
>> in the Fire OS 3.18 tree, command for command, with only a 120 ms wait
>> after sleep-out added where the vendor waits its trailing 5 ms.
>> The 0x8f 0xa5 and 0x8f 0x00 that bracket it are the vendor's command
>> interface selection, sent on every board that is not an early proto or
>> HVT unit.
>>
>> It is much shorter than boe_tv101wum_nx0_init() because this module is
>> left on its own factory trim. NT51021 R8CH selects whether V1/V14, gamma
>> and HAOP come from the panel's OTP memory or from control registers, and
>> the 0x8c 0x80 here leaves all three on OTP, where the NX0's 0x8e
>> switches
>> them to registers so that the three pages of gamma it then writes take
>> effect. So the absent gamma is deliberate rather than an omission, and
>> the differing 0x8c is its consequence. CABC is likewise untouched
>> because
>> the vendor drives it over I2C from the backlight path. What is left is
>> 0xc0 and 0xc8, which the public NT51021 specification does not describe;
>> everything else this sequence touches carries the same value as the
>> other
>> two panels, including the terminal resistor, TP_SYNC, the MIPI Rx drive
>> strength and all three test modes.
>>
>> The timings are the vendor's lcm_get_params(): hsync 1, hbp 32, hfp 110,
>> vsync 1, vbp 14, vfp 11, so htotal 1343 and vtotal 1946. The pixel clock
>> follows the vendor's PLL_CLOCK = 490, which after DDR is 980 Mbps per
>> lane and over four lanes at 24bpp is 163.33 MHz, so 62.5 Hz. The
>> bootloader leaves the MIPI TX PLL at that rate: read back before the
>> kernel touches it, this board's PLL decodes to exactly 980 Mbps per
>> lane, so the panel is already there when the kernel takes over.
>>
>> The front porch is the vendor's declared 110 rather than the smaller
>> value its own DSI driver ends up running. That driver also sets
>> clk_lp_per_line_enable, which makes ddp_dsi_config() overwrite HFP_WC
>> after the declared timing is programmed, shrinking it to leave just
>> enough room to take the clock lane to LP and back. That is a
>> controller-side workaround rather than a panel property, and it
>> contradicts the cont_clock = 1 set beside it, which disables the very LP
>> transition it makes room for. Mainline mtk_dsi handles the clock lane
>> itself, so the panel's declared timing is the right thing to carry here.
>>
>> The vendor asks for SYNC_EVENT_VDO_MODE with cont_clock = 1 rather than
>> burst, so make mode_flags per variant instead of fixed in probe(). The
>> two existing panels keep the flags they had. Burst was also tried on
>> this hardware and worked, but the vendor configuration is the one the
>> module is characterised for.
>>
>> The physical size is the datasheet active area, 216.576 x 135.36 mm,
>> which measures 216 x 135 on the glass. The vendor's declared a
>> physical_width = 136 and physical_height = 221, which appears to be an
>> error. The size of the test unit was physically measured. 1200/136 and
>> 1920/221 disagree by 1.5%.
>>
>> The vendor's bootloader and kernel both carry a second register sequence
>> for the Innolux module this board second-sources against, selected from
>> two board ID straps. No Innolux unit was available, so that sequence is
>> left out rather than carried untested; however, the Innolux part number
>> was identified as "P101KDA-AB0", should someone with that glass need to
>> upstream support in the future.
>>
>> Tested on the Amazon Fire HD 10 (2017) driven by mediatek-drm: 1200x1920
>> at 62.5 Hz across a cold boot, display off and on cycles and a
>> suspend/resume, with the MIPI TX PLL reading back at the intended rate
>> every time.
>>
>> Assisted-by: LLM
>> Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # Amazon Fire HD 10 (2017), boe,tv101wum-nm0
>> Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
>> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
>> Co-developed-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
>> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
>> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> 
> Though I would've preferred to see the commands put in arrays instead of
> multiple function calls with all of those values, the only improvement
> would be slightly lower code size... and I don't think it's worth it to
> request a v5 for just that.

Actually no, we switched to multiple function calls since it effectively lowers
the global size, arrays uses more space than code.

> 
> After all, it's anyway the same "mess" of unknown data going out to the
> panel's DriverIC - be it in one form or the other, it's not changing much.
> 
> So
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Cheers,
> Angelo

Neil
