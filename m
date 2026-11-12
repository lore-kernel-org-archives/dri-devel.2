Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68960A6F4C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr1Wwv/B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824ED10EB55;
	Thu, 12 Nov 2026 08:32:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4869C10EB55
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:32:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E4E49478E8;
 Thu, 12 Nov 2026 08:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355B61F00A05;
 Thu, 12 Nov 2026 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794472356;
 bh=ufWZis3EGqkdSN4VSNsZPHtwom5XkDipXVyVOPQcZLM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fr1Wwv/BrXzj64byfXP+wi/q7J8Ic+yvuVCa7DL01i5CP9FiwrJP0C0kIMzIsd5kG
 bg0Y2dhVW/msaXhNH6nGRtql7prJ6Taz9/A8ZnGNPAe7ZPEO47cA9BLgd99Kc/Y49M
 iHsrQo4gQWYLkMuCMU/O5oINvGG96EWnkGxw42KFw8t4MELXgTG/yvIVPccYBKpq+4
 8YFJucjcj3LzLyQyUht1aI1GUsc0tWWET/PVTY72LbZHnoP/xHEragG25uo3HBBzKs
 1rIN36widjK1U9+MzLLwsSepSWPR4DuUP0Tj3vDDi4EoRNoT/kRt1fRWoQiRUPvCNe
 OOxejcXQaaXvg==
Message-ID: <3c6fd46a-8666-408d-8866-f2bb1f293c05@kernel.org>
Date: Thu, 12 Nov 2026 09:32:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/28] dt-bindings: gpu: panthor: Document AM system
 bindings
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-12-karunika.choo@arm.com>
 <20261111-grumpy-carp-of-superiority-eddeb9@quoll>
 <d74eb465-554b-43d6-bbfa-3fb671931462@arm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <d74eb465-554b-43d6-bbfa-3fb671931462@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 11:43, Karunika Choo wrote:
> On 11/11/2026 08:29, Krzysztof Kozlowski wrote:
>> On Tue, Nov 10, 2026 at 03:38:32PM +0000, Karunika Choo wrote:
>>> Mali 5th-Gen AM GPUs expose an AM_SYSTEM block for GPU-wide control and
>>> the AM_ASSIGN block for HW resource assignment outside the GPU
>>> job submission register window.
>>>
>>> Document the system node compatible, register and interrupt resources,
>>> GPU clock, and assignment properties for HW resource assignment.
>>>
>>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>>> ---
>>> v2:
>>> - Add an optional AM_ASSIGN register range. Require this range when the
>>>   assignments node is present.
>>> - Describe resource-group assignments for AXI buses, partitions, slices
>>>   and access windows on partition-capable GPUs.
>>> - Allow gpu-arbitration child nodes and the #address-cells, #size-cells
>>>   and ranges properties.
>>> - Remove the panthor-system node-name restriction.
>>> - Remove gpu-supply from the schema and example.
>>> - Add an example with assignments for partition-capable GPU with four
>>>   resource groups.
>>> - Move the MAINTAINERS update to the GPU schema patch.
>>>
>>>  .../bindings/gpu/arm,mali-gen5-am-system.yaml | 196 ++++++++++++++++++
>>>  1 file changed, 196 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>> new file mode 100644
>>> index 0000000000000..9e0477b8b723a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>> @@ -0,0 +1,196 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +# Copyright 2026 ARM Limited. All rights reserved.
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-system.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ARM Mali 5th-Gen GPU System Device
>>> +
>>> +maintainers:
>>> +  - Liviu Dudau <liviu.dudau@arm.com>
>>> +  - Boris Brezillon <boris.brezillon@collabora.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: arm,mali-gen5-am-system
>>> +
>>> +  reg:
>>> +    minItems: 1
>>> +    maxItems: 2
>>
>> Why is this flexible? There is no description in the binding which would
>> explain oddities in choices of hardware representation.
> 
> I will restore the description that was previously asked to be dropped.

Hm, let me open the cover letter to find lore link to previous
discussion and check... ah wait, no cover letter!

> 
>>> +
>>> +  reg-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: system
>>> +      - const: assign
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  dma-coherent: true
>>> +
>>> +  "#address-cells": true
>>> +
>>> +  "#size-cells": true
>>
>> Both need to be const or enum.
>>
>>> +
>>> +  ranges: true
>>> +
>>> +  assignments:
>>
>> Do not mix nodes with and without bus addressing. That's mess.
> 
> Hi, I was asked to use a more generic DT such that should the

By whom?

> hardware registers change in the future we can still retain
> some compatibility. Is it necessarily a problem?

Bindings are not generic, but specific.

...

>>> +patternProperties:
>>> +  '^gpu-arbitration@[a-f0-9]+$':
>>> +    $ref: arm,mali-gen5-am-arbitration.yaml#
>>
>> There is no such file. You did not really test it.
> 
> Sorry, this was included from a later patch that
> introduces this file. I will move it there in v3.
> 
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - reg-names
>>> +  - interrupts
>>> +  - clocks
>>> +
>>> +additionalProperties: false
>>
>> This goes after allOf: block.
>>
>>> +
>>> +allOf:
>>> +  - if:
>>> +      required:
>>> +        - assignments
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 2
>>> +        reg-names:
>>> +          minItems: 2
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +    gpu-system@68000000 {
>>> +      compatible = "arm,mali-gen5-am-system";
>>> +      reg = <0x68000000 0x10000>;
>>> +      reg-names = "system";
>>> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>>> +      clocks = <&mali_gpu_clk>;
>>> +    };
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +    gpu-system@68000000 {
>>> +      compatible = "arm,mali-gen5-am-system";
>>> +      reg = <0x68000000 0x10000>, <0x68010000 0x10000>;
>>> +      reg-names = "system", "assign";
>>> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>>> +      clocks = <&mali_gpu_clk>;
>>> +
>>> +      assignments {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        resource-group@0 {
>>> +          reg = <0>;
>>> +          arm,axi-bus = <0>;
>>> +          arm,partition-mask = <0x1>;
>>> +          arm,slice-mask = <0x3>;
>>> +          arm,access-window-mask = <0xf>;
>>> +        };
>>> +
>>> +        resource-group@1 {
>>> +          reg = <1>;
>>> +          arm,axi-bus = <0>;
>>> +          arm,partition-mask = <0x2>;
>>> +          arm,slice-mask = <0xc>;
>>> +          arm,access-window-mask = <0xf0>;
>>> +        };
>>> +
>>> +        resource-group@2 {
>>> +          reg = <2>;
>>> +          arm,axi-bus = <1>;
>>> +          arm,partition-mask = <0x4>;
>>> +          arm,slice-mask = <0x30>;
>>> +          arm,access-window-mask = <0xf00>;
>>> +        };
>>> +
>>> +        resource-group@3 {
>>> +          reg = <3>;
>>> +          arm,axi-bus = <1>;
>>> +          arm,partition-mask = <0x8>;
>>> +          arm,slice-mask = <0xc0>;
>>> +          arm,access-window-mask = <0xf000>;
>>> +        };
>>
>> Your example is incomplete.
> 
> Could you clarify what specifically is missing?

ll the properties you added in the binding.

Best regards,
Krzysztof
