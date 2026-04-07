Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C3FF5136
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89BFD89F31;
	Tue,  7 Apr 2026 19:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aUg+SEvH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1205E89F31
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 19:30:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CD3574050D;
 Tue,  7 Apr 2026 19:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA444C116C6;
 Tue,  7 Apr 2026 19:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775590214;
 bh=RJp2WhnzkhKGVYaMRGQ9Rf31nG4dmH/ZN8pD+88bwCE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aUg+SEvHW+bMleXQnXSt2JC4f2vciEHKwFF6fmVWa2VJhMbMn3BtuSgdhjYJoEbqK
 uFKJ0WVtd/9i4Jncj1IvZmi4y/NvTfrM84FlhFv+FNXQY/Jw3gbyTJufelODKVRseW
 I3FqRo2P7HMsbsUw51AwEYGxn1tzn/UeeUBWVilM+8Cn3Br2mjqEt6PXyiE/r9RNea
 bNnPJNkhWsqIBv2xRYlrCIN7PcyBOUzvWeIUe7Nxbn02ifFRDNpGRW+02JzuhgEFsC
 bbBugRjOJJ4S9hMReDBNFxGq6HsFN4eMLq3hRQSV6/SzaIRq0f0KOpnrqKyZtGobP4
 ZJMO+Xp6eN31A==
Message-ID: <22f25d09-136b-4e53-8b64-2e03f6d18b76@kernel.org>
Date: Tue, 7 Apr 2026 21:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: lt9211: Require data-lanes
 on DSI input ports
To: Marek Vasut <marex@nabladev.com>
Cc: devicetree@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260404034123.340818-1-marex@nabladev.com>
 <20260407-invaluable-pretty-leopard-1e8dfc@quoll>
 <c3a9c4eb-92ce-48c2-83ff-18c7ce03acd9@nabladev.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <c3a9c4eb-92ce-48c2-83ff-18c7ce03acd9@nabladev.com>
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

On 07/04/2026 16:51, Marek Vasut wrote:
> On 4/7/26 10:00 AM, Krzysztof Kozlowski wrote:
> 
>>> NOTE: For example Linux kernel driver does already use that information
>>>        and fails to probe if it is missing. There are currently no intree
>>
>> The first sentence must be part of the commit msg. That is important
>> reason why you are doing this... but I don't see how you achieve any of
>> this. Look:
>>
>>
>>>        users for this binding, so no new warnings will be generated once
>>>        this is applied, but a new user is about to be added.
>>
>> What warnings? How?
> 
> There are no in-tree users of this binding, so no DT checker warnings 
> will be produced on existing in-tree DTs. I am in the process of adding 
> a DTO which uses this binding now in arm64: dts: imx8mm: imx8mp: Add 
> DTOs for Data Modul i.MX8M Mini and Plus eDM SBC

So add new user, apply this and what warnings are you seeing?

> 
>>> ---
>>>   .../display/bridge/lontium,lt9211.yaml        | 37 ++++++++++++++++++-
>>>   1 file changed, 35 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
>>> index 9a6e9b25d14a9..5264fb2b68b78 100644
>>> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
>>> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
>>> @@ -36,18 +36,50 @@ properties:
>>>   
>>>       properties:
>>>         port@0:
>>> -        $ref: /schemas/graph.yaml#/properties/port
>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>
>> OK, that's correct.
>>
>>> +        unevaluatedProperties: false
>>>           description:
>>>             Primary MIPI DSI port-1 for MIPI input or
>>>             LVDS port-1 for LVDS input or DPI input.
>>>   
>>> +        properties:
>>> +          endpoint:
>>> +            $ref: /schemas/media/video-interfaces.yaml#
>>> +            unevaluatedProperties: false
>>
>> That's correct.
>>
>>> +
>>> +            properties:
>>> +              data-lanes:
>>> +                description: array of physical DSI data lane indexes.
>>> +                minItems: 1
>>> +                items:
>>> +                  - const: 1
>>> +                  - const: 2
>>> +                  - const: 3
>>> +                  - const: 4
>>
>> That's almost redundant in this context - it was already there - and the
>> point is that it solves noting in the problem you had. Binding still
>> does not validate the ABI and does not match it, still.
>>
>> Since commit foo bar, driver needs data-lanes, so what you need to do is
>> allow them and to require them. You can also specify their constraints
>> if device can be configured multiple ways, up to 4 lanes.
> Please pardon my ignorance, what exactly do you propose I change in this 
> patch ?

Follow the subject - require data-lanes. That's was the main point of
this change, no?

Best regards,
Krzysztof
