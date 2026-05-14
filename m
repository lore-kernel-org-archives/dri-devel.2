Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09760CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 15:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AD110E166;
	Thu, 14 May 2026 15:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d6e1zB+Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EEE10E166
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:11:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B13E42AE7;
 Thu, 14 May 2026 15:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F04C2BCB3;
 Thu, 14 May 2026 15:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778771484;
 bh=hozAw0rEPrOq8LRlaqbe/lv3mLiyhX6RyL3aLIPpo+c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d6e1zB+Z2U3ZKOLAXZGNXOymdfqOhsVQiU7tH6xzvehhkecwNID9tf5GGum6vWgHE
 IEdluTVOKmAGhLV6piProU2wXkZHQrbCs190J7AMp3bbC4R2u0u+vCMUtrKtfEuUTi
 9ysLKtvpZ+FXoJg7imltNnF1XeDzwKLlFvLf28bICokhgN4oPTkq39m+oYbOQtL4F/
 E0+WBuDm1bj67U2Zb1aWDsjr9lnQuZFRZgsCwxGhiW/0gcyWk+iw/t3BwPEdAf9a4Y
 04MwWseJ04cgKYwlZIhsRGKv/SWe+tARJXSFgvQgsFtcFGMDTBbtLvj/uNMEeNMlni
 ktyWHbzrhU+5A==
Message-ID: <81a3c207-4d8f-490f-8e2a-6f3f4c2acd35@kernel.org>
Date: Thu, 14 May 2026 17:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: Add Novatek NT37705
To: Luca Weiss <luca.weiss@fairphone.com>, Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
 <20260501-fp6-panel-v1-1-e09cb05651cc@fairphone.com>
 <20260501-yogurt-wise-2a2884e3ec59@spud>
 <DI9XL1VYYTY7.19IRSM8VIDO53@fairphone.com>
 <a2444df4-abf1-4b56-8556-7efb238bc677@kernel.org>
 <DIAJCURQ37FA.1CNEKX6QM6ZO8@fairphone.com>
 <dd7ebb25-014c-4983-ae31-6a6cbd24e628@kernel.org>
 <DID4LW3GMLDV.338VDV2L2IPL@fairphone.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <DID4LW3GMLDV.338VDV2L2IPL@fairphone.com>
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

On 08/05/2026 09:44, Luca Weiss wrote:
> Hi Krzysztof,
> 
> On Tue May 5, 2026 at 9:25 AM CEST, Krzysztof Kozlowski wrote:
>> On 05/05/2026 08:40, Luca Weiss wrote:
>>>>>>> +  compatible:
>>>>>>> +    contains:
>>>>>>> +      const: boe,bj631jhm-t71-d900
>>>>>>
>>>>>> Compatible doesn't match the filename, nor does the commit message match
>>>>>> what you've got here. Sounds like you're missing a fallback to
>>>>>> $filename.
>>>>>
>>>>> The last times I was upstreaming panel drivers (Feb 2024 and June 2025),
>>>>> this was the requested way of doing things.
>>>>
>>>> So this was requested that time and is requested now. What is here
>>>> uncertain?
>>>>
>>>>>
>>>>> Compatible being the company and model number making the actual panel
>>>>> assembly (driver IC + touchscreen + glass etc), while the rest being
>>>>> named after the driver IC manufacturer & number.
>>>>
>>>> So exactly what was asked for...
>>>
>>> I don't quite understand what is asked for now, that's my issue.
>>>
>>> 1. Change the filename to boe,bj631jhm-t71-d900.yaml and leave the rest
>>>    as-is.
>>>
>>> 2. Add a fallback compatible for novatek,nt37705. IIRC last time it was
>>>    argued that a "generic" nt37705 driver will never be correct for a
>>>    specific panel since it's missing a bunch of panel-specific init. So
>>>    that's why there should not be a fallback to nt37705.
>>
>> To my limited knowledge the (2) with fallback describing the specific IC
>> is preferred, because that compatible although not currently usable is
>> still specific and describes actual IC used. I imagine that such
>> fallback still could be useful to some SW implementation to determine
>> the IC and act based on that.
>>
>> If you have sources of other preference, please share, but I just gave
>> same review to Neil for his ayaneo,wt0600-2k panels.
> 
> I found the discussion from 2024 for the Fairphone 4 panel:
> 
> https://lore.kernel.org/lkml/f9164049-6529-42c1-a35a-e91132c823b9@linaro.org/
> 
> (quoting)
> 
> '''
>   Not sure if "himax,hx83112a" is needed here, the "djn,9a-3r063-1102b"
>   is enough to know the IC is hx83112a.
> 
>   I don't think you'll ever find a "djn,9a-3r063-1102b" with another
>   controller IC ?
> 
>   And "himax,hx83112a" alone as fallback is not enough to describe the
>   panel hardware, so I think it should be dropped.
> '''
> 
> With Konrad replying "+1" to that.

The arguments from Linux drivers point of view are correct. And you can
apply the same to board-level compatibles. Each most-specific board
level compatible already defines the soc, thus soc-compatible fallback
is redundant, right?

And also the soc-compatible fallback is too generic to be used alone by
the SW in many cases.

Yet we use it. Same here. Why? For the same reasons as we use for
board-level compatibles. Because that's convenient way for defining
quirks for the controller IC which otherwise would need to match all
panel compatibles.

I do not insist on this (for panels, of course), however I would prefer
consistency in the code and in the reviews. Heh, I bet you too would
prefer consistency. :) All my recent reviews were proposing to have the
fallback, thus I consistently propose one here, but I won't object for
the patch in current form, thus:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

But please also add Link to this exact email I am writing.

( Link: ....)

Best regards,
Krzysztof
