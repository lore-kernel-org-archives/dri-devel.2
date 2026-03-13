Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1393106FD9A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3F610EB10;
	Fri, 13 Mar 2026 08:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EYs5mD6/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE49E10EB10
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:32:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F18EA60133;
 Fri, 13 Mar 2026 08:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D27C19424;
 Fri, 13 Mar 2026 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773390740;
 bh=Nl+7LWtkxv6+ukIGHNTsuAHfdV43ujZAEvxFTAY1mD8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EYs5mD6/OMIB8MxF7KtH8yGzdMiS16u4t8pL24wgXbPXL5Qsz99xd85z6hQfvAs0Z
 Szf3uLOzX3POmHvCyokYelXTUE5bQUqNDocPuNM0yQ8i0WT2fSgd+BVi2a7Mzu9lr6
 pvniiL5mxW2dGs9Qn7C28ac4XWyziHf97HlZIPn6bAAunBcP0JAVq60Gib3fWqLAJq
 H+uGVprrlXur7feqkVlb2E7gLbvfhM+JKCk46WxIAvFT2Bp91PoAyqSRUOR8BbK8uR
 9ZDL2ziMroPI5c2vEFFT6e5df7F9CrJJb0LmUQiY83oTS/OzqidkKTvdVNFLEMupQe
 5Bel/e8GR+FfQ==
Message-ID: <2d0afdab-78b7-4e60-b132-98cfcbbbb5af@kernel.org>
Date: Fri, 13 Mar 2026 09:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: display: panel: Add Novatek NT35532 LCD
 DSI
To: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260308-rimob-new-features-v1-0-aa2c330572c0@protonmail.com>
 <20260308-rimob-new-features-v1-1-aa2c330572c0@protonmail.com>
 <369b48d9-f089-49a2-89cb-a4e0c68f92fa@kernel.org>
 <7Ft_cDw10-3MmNTrKncMut5g08sodd9CL7r7AGXAtPPqZpXtHEgmqm05WhEpYMZzFEs4B0KWz-LU27Z0_YDnc44nXhdUrUt5X2dWK7D6pYM=@protonmail.com>
 <db04882b-7f30-464c-91a6-578302aef4ff@kernel.org>
 <Nz_hTfDbWqQk8-FcCknxZKO8dIhCAGueG89SRe2LkTG1VK4KjoH-UZH6bsOvqEySwNRjJtsEUL7vxxIXOWyyzLOtM9YLZaCuhPfxNz0mVyk=@protonmail.com>
 <4cfc7b40-f172-4eae-8f19-4a3eb858075e@kernel.org>
 <q2whOVhy_Cqm5m8toyiZ0PQQThv6LLoo8a5ialb_td0o5yM1FRLIMRZh2FKRiwSuwPfmfibU6Z6_jz6kJFJGlFfu3V-ELMteHVDM7zpnSBI=@protonmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <q2whOVhy_Cqm5m8toyiZ0PQQThv6LLoo8a5ialb_td0o5yM1FRLIMRZh2FKRiwSuwPfmfibU6Z6_jz6kJFJGlFfu3V-ELMteHVDM7zpnSBI=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 13/03/2026 09:26, cristian_ci wrote:
> 
> On Tuesday, March 10th, 2026 at 21:06, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 10/03/2026 18:48, cristian_ci wrote:
>>> On Monday, March 9th, 2026 at 16:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>>> On 09/03/2026 15:52, cristian_ci wrote:
>>>>> On Sunday, March 8th, 2026 at 17:13, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>
>>>>>>> +  vsp-supply:
>>>>>>> +    description: positive voltage supply for analog circuits
>>>>>>
>>>>>> Both are odd. Datasheet says vci, vddi, vddam and optional avdd, avee.
>>>>>>
>>>>>> There is no VSN and VSP. Otherwise please point the page in datasheet or
>>>>>> some schematics.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>>
>>>>> I'm not sure about that. Writing panel dt-bindings has been based pretty mostly on vendor devicetree - which also describes somehow the panel and makes that working with the final product released to the market - so I've to necessarily consider that.
>>>>> Then, I could agree that vendor devicetree might be not compliant with upstream rules and could possibly make mistakes with describing the hardware, so I'd like to find a way to describe that in a more proper way, according to upstream rules.
>>>>>
>>>>> That said, vendor devicetree describes lists four power supplies for  DSI: 'vdd', 'vddio', 'lab' and 'ibb' (which have the following property names, respectively, in qcom,mdss_dsi_ctrl node: 'vdd-supply', 'vddio-supply', 'lab-supply' and 'ibb-supply'.
>>>>> Two of these are related to ds/controller (apparently, 'vddio' should match VDDI power supply in NT35532 datasheet.
>>>>>
>>>>> The remaining two supplies are related to panel ('lab' and 'ibb'). These ones are two 'external ' regulators ('external' from NT35532 perspective), which provide power supply to display, located in the qcom PMIC (in this case, that should be PMI8950). WRT to power supply names described in the bindings ('vsp-supply' and 'vsn-supply') are the same as 'lab-supply' and 'ibb-supply', just named differently in the vendor devicetrees.
>>>>>
>>>>> Usage of 'vsp'/'vsn' naming for power supply properties is grounded on they commonly being used at upstream (different panel bindings make use of these properties), on one side, and also described on schematics of devices with the same hardware configuration (LCD_VSN and LCD_VSP), on the other.
>>>>>
>>>>> In the meantime, I've found out schematics for 'xiaomi-mido' (another MSM8953 device) - a variant of this device is shipped with a panel also using NT35532 IC (just like my device) - and LCD_VSN/LCD_VSP are clearly shown there too.
>>>>>
>>>>> I couldn't find much more information about the display on my device and the only resources available about that are those listed above, as of today. In light of my reply, I ask if it is still necessary to describe, in the bindings, power supply properties properties not used currently in the board DTS file.
>>>>
>>>> Please wrap your answers so this will be possible to parse.
>>>>
>>>> You write bindings matching the hardware and for the hardware, not for
>>>> the downstream code. You cannot add supplies which do not exist
>>>> regardless what some vendor wrote somewhere
>>>
>>> Vendor has also described the hardware by storing information (by including info
>>> about panel too) directly inside the device itself (/sys/firmware/fdt).
>>
>> Vendor does not care about rules of DT thus puts there completely fake
>> information just to make their drivers working
>> .
> 
> I'm not sure what that statement is based on in the specific case of

It's based on years of looking at vendor code.

> the panel I'm actually testing. A set of clues (some of which were also mentioned
> in my first reply some days ago) point out that rimob's panel is really supplied by
> two regulators part of PMIC [1]. Not only for this reason, I do not have
> enough solid reasons, after all, to consider vendor data about the panel mounted in
> this device (rimob) as not decently reliable, so I cannot ignore them, at least.

And I did not disagree that you need regulators and that vendor
correctly wired two of them.

The comments are about naming!

I discussed of using argument of incomplete or not fully correct vendor
code when the true hardware description is available. If the vendor
calls them in vendor DTS "yellow-pony-supply" you are going to use that
argument to write bindings? And then argue that "not sure what that
statement is based on"?

It's obvious - vendor code is crap. There are no VSN and VSP inputs. We
already confirmed that.

You claim that vendor called like that thus you can use them as well is
simply not correct approach.


Best regards,
Krzysztof
