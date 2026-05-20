Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D0CD4F5E
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFC910EF2B;
	Wed, 20 May 2026 07:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lai7+177";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD77910E625
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 03:06:12 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-36936dcf19dso1997223a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779246372; x=1779851172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nIAQ9DaAotLVRz2iB1AFoG5yBrv9qo1aI5uct5Q5rhg=;
 b=lai7+177wmRLzx1wdAMH1m8jl1A8VE7YSUU76JTabm1n8TvrMYSSRZslAcRuRq/OW2
 z4FKlfIrzWOhASM1jtfVQw3Y0pTTSV+P9JQJ4KfSrlv/ASNIOIc3wNSvmwN+tgIKqefy
 LOQ4R33QPb362c0Tms7qR5KOP7W7yKKwO/gQA2helgEOqwgTYnib6q/ddIimQfPYFAbm
 3jmMBdiJQn54EhKy2yql9l7A0QpRNTQYioDnIFsFpmzvliSsDuU2NXc9Yd3PbR/f3Yzi
 gmE9srCObuosYjAgd58zX3a2+rAhEoGxAdGpITYvjlUCn2rb3ZpQA55smdJTR/n7iXqt
 Brmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779246372; x=1779851172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nIAQ9DaAotLVRz2iB1AFoG5yBrv9qo1aI5uct5Q5rhg=;
 b=oRK2RA7O4LwBZSEpo8+3LxmHBOuQufFBnpEu63MD9+ZPvPmVyONnGDAoX/IFBQCv4z
 9w71/ZNAx/iVIQ43MqMB15EFSklIC6V3l3GIlGX9ZPnp35gTsi66b2Zjswh9Susk5Fnm
 oSqwGu5BANY43gya8r7Py+ZclMvSG9JtHPgVGW9ff/3o2iBEIzlPjUDr0wbOpl97gJ8i
 tG/hxPpXvTgJiUnZWlTdSLVuCuIgYwmUwSUmrtOJmYh9eCre2wevLcUMurFEOWUfxEAQ
 1C9P3i8IAgHVWl2kVMpWbKw70AW8k2I2/DHNpKZsdMgYtRdyaJ5ikMYMPth+TkMQs0uC
 4mWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CCEmQewP8ZQy9HwJpYRRxJ9q6WS3YGWB4QYO1ZdvVbODwHFpBjGvg3a38UMXf5RuCJD0sxP9aOQk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNGibjd/EndoyF4ZMPtGIu3eJ5C3dIE2uLzut7DMIMFeTIjDvL
 pXsqHZdbTo0+RcofUmHx/0Qn8zDdnvhOialGVzC2XTjsajU2LO4qT4Yf
X-Gm-Gg: Acq92OGY3ApYoVeASDyxCIeF4fOPRLTetKRrnmZhKe5p31hlk/O07P88CwDXJxtuScN
 iKi4A5ToxAfIZ0iIpyW/XCaoVFjnEZbiarEMh8ogYq495DQWqS8NAB/XthHeNlBpske3KDFPt90
 GJV9+4QkuMglTqC9u5gv8r+5lSTy4jfHPUnT79gq2M0OOkuFs4CvzZQvFfHTC9PskjngIOxf8E/
 zJxM9CM5L/Nc2itHaHJ9Q3LBskjNTcnkYEB4SHg8Bf4KvVkJeb5jq28LZXVabvzpgZIE8lwwECR
 QpadmQNox7Nfhq6T6QszKpuj2i3LJXVeVRT9bBmTb6qZxaC1mDHXMJ/y8vvO0zkiEaCMtPpTiyv
 LmXR5mj7o/qarHCZG346gm/QWou1KOQ5MX94vExTgBSDuRgXMWD0zL+Zq7K/ZuoTCgxzj4BHjcE
 RyUULIHe/7f6oX9Myhu25Dm+wBkMoWImKkYCI/TRh7qLqeH7BoWFippj2MSZeizPYW9DBVMgJaE
 MKhxV0S6crC6k4=
X-Received: by 2002:a17:90b:1fce:b0:368:5367:d679 with SMTP id
 98e67ed59e1d1-369519cb5d1mr21310800a91.9.1779246371983; 
 Tue, 19 May 2026 20:06:11 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm15491821a91.12.2026.05.19.20.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 20:06:11 -0700 (PDT)
Message-ID: <a112cb8b-21fb-4c33-89a3-14a4feb5e3f9@gmail.com>
Date: Wed, 20 May 2026 11:06:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: display: verisilicon, dc: generalize
 for single-output variants
To: Conor Dooley <conor@kernel.org>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260519055114.1886525-1-a0987203069@gmail.com>
 <20260519055114.1886525-2-a0987203069@gmail.com>
 <a66cc60fe163167e30e42f0b4be996cae1170a5e.camel@iscas.ac.cn>
 <20260519-fretful-blush-1aac18fa1360@spud>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260519-fretful-blush-1aac18fa1360@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

On 5/20/2026 12:47 AM, Conor Dooley wrote:
> On Tue, May 19, 2026 at 03:26:58PM +0800, Icenowy Zheng wrote:
>> 在 2026-05-19二的 13:51 +0800，Joey Lu写道：
>>> The existing schema assumes a fixed clock/reset topology and dual-
>>> output
>>> port structure matching the DC8200 IP block.  This prevents reuse for
>>> single-output variants such as the Verisilicon DCU Lite used in the
>>> Nuvoton MA35D1 SoC.
>>>
>>> Rework the schema so that variant-specific constraints are expressed
>>> via allOf/if-then-else:
>>>
>>> - The thead,th1520-dc8200 compatible keeps its existing five-clock,
>>>    three-reset, dual-port requirements.
>>>
>>> - A standalone verisilicon,dc compatible covers IPs whose identity is
>>>    discovered entirely through hardware registers; these have flexible
>>>    clock and reset counts, a single 'port' property, and no 'ports'
>>>    requirement.
>>>
>>> Changes to the base schema:
>>> - Replace the fixed clock/reset items lists with minItems/maxItems
>>>    ranges; variant sub-schemas tighten the constraints via if-then-
>>> else.
>>> - Add a 'port' property (graph.yaml single-port alias) alongside the
>>>    existing 'ports', for single-output variants.
>>> - Drop the unconditional 'ports' requirement; each if-branch enforces
>>>    its own port topology.
>>> - Tighten additionalProperties to unevaluatedProperties to allow
>>>    per-variant schemas to add their own constraints cleanly.
>>> - Fix a stray space in the port@0 description.
>>> - Add a DT example for the generic verisilicon,dc compatible
>>>    (Nuvoton MA35D1 DCU Lite).
>>>
>>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>>> ---
>>>   .../bindings/display/verisilicon,dc.yaml      | 135 ++++++++++++++--
>>> --
>>>   1 file changed, 108 insertions(+), 27 deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>> index 9dc35ab973f2..3a814c2e083e 100644
>>> --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>> +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>> @@ -14,10 +14,12 @@ properties:
>>>       pattern: "^display@[0-9a-f]+$"
>>>   
>>>     compatible:
>>> -    items:
>>> -      - enum:
>>> -          - thead,th1520-dc8200
>> You should add a fallback compatible here for your SoC, in case its
>> integration gets something quirky; this compatible is usually not
>> consumed by the driver (see how thead,th1520-dc8200 exists in the
>> binding but not the driver).
> s/fallback compatible/soc-specific compatible/, but yes.
> NAK to what's been done here, especially after the discussions on
> earlier versions of this verisilicon binding.
> pw-bot: changes-requested
Understood. I will add `nuvoton,ma35d1-dcu` as the SoC-specific 
compatible string paired with `verisilicon,dc` as the generic fallback, 
matching the pattern used for `thead,th1520-dc8200`. The standalone 
`verisilicon,dc` compatible will be removed from the binding. The driver 
match table is not changed since hardware detection is done via ID 
registers.
>>> -      - const: verisilicon,dc # DC IPs have discoverable ID/revision
>>> registers
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - thead,th1520-dc8200
>>> +          - const: verisilicon,dc
>>> +      - const: verisilicon,dc  # DC IPs have discoverable
>>> ID/revision registers
>>>   
>>>     reg:
>>>       maxItems: 1
>>> @@ -26,32 +28,24 @@ properties:
>>>       maxItems: 1
>>>   
>>>     clocks:
>>> -    items:
>>> -      - description: DC Core clock
>>> -      - description: DMA AXI bus clock
>>> -      - description: Configuration AHB bus clock
>>> -      - description: Pixel clock of output 0
>>> -      - description: Pixel clock of output 1
>>> +    minItems: 2
>>> +    maxItems: 5
>>>   
>>>     clock-names:
>>> -    items:
>>> -      - const: core
>>> -      - const: axi
>>> -      - const: ahb
>>> -      - const: pix0
>>> -      - const: pix1
>>> +    minItems: 2
>>> +    maxItems: 5
>>>   
>>>     resets:
>>> -    items:
>>> -      - description: DC Core reset
>>> -      - description: DMA AXI bus reset
>>> -      - description: Configuration AHB bus reset
>>> +    minItems: 1
>>> +    maxItems: 3
>>>   
>>>     reset-names:
>>> -    items:
>>> -      - const: core
>>> -      - const: axi
>>> -      - const: ahb
>>> +    minItems: 1
>>> +    maxItems: 3
>>> +
>>> +  port:
>>> +    $ref: /schemas/graph.yaml#/properties/port
>>> +    description: Single video output port for single-output
>>> variants.
>> Maybe the endpoint numbering rule needs a move to here? (I am not very
>> sure).
I will add a description to the `port` property noting that endpoint 0 
is used for DPI output, which is the only output type for DCUltraLite.
>>>   
>>>     ports:
>>>       $ref: /schemas/graph.yaml#/properties/ports
>>> @@ -59,7 +53,7 @@ properties:
>>>       properties:
>>>         port@0:
>>>           $ref: /schemas/graph.yaml#/properties/port
>>> -        description: The first output channel , endpoint 0 should be
>>> +        description: The first output channel, endpoint 0 should be
>>>             used for DPI format output and endpoint 1 should be used
>>>             for DP format output.
>>>   
>>> @@ -75,9 +69,75 @@ required:
>>>     - interrupts
>>>     - clocks
>>>     - clock-names
>>> -  - ports
>>>   
>>> -additionalProperties: false
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: thead,th1520-dc8200
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          items:
>>> +            - description: DC Core clock
>>> +            - description: DMA AXI bus clock
>>> +            - description: Configuration AHB bus clock
>>> +            - description: Pixel clock of output 0
>>> +            - description: Pixel clock of output 1
>>> +
>>> +        clock-names:
>>> +          items:
>>> +            - const: core
>>> +            - const: axi
>>> +            - const: ahb
>>> +            - const: pix0
>>> +            - const: pix1
>>> +
>>> +        resets:
>>> +          items:
>>> +            - description: DC Core reset
>>> +            - description: DMA AXI bus reset
>>> +            - description: Configuration AHB bus reset
>>> +
>>> +        reset-names:
>>> +          items:
>>> +            - const: core
>>> +            - const: axi
>>> +            - const: ahb
>>> +
>>> +      required:
>>> +        - ports
>>> +
>>> +    else:
>>> +      properties:
>>> +        clocks:
>>> +          items:
>>> +            - description: Bus clock that gates register access
>>> +            - description: Pixel clock divider for display timing
>> Please don't make compatible-specific description strings for
>> individual compatibles, and keep these descriptions outside of the if.
>> The compatible-specific part should be used to specify what's required
>> for the specific SoC, for dt validation purpose.
>>
>> BTW if the clock is both the working clock and bus clock for the
>> controller, I suggest listing it twice, except if the IP core is
>> provided without a dedicated core clock (in the case I suggest to use
>> "bus" only).
> I agree. If the same clock is provided to two+ ports on the IP, that
> should still be two+ clocks in the devicetree.
>
>> Here's an example for "listing it twice":
>> ```
>> clocks = <&clk DCU_GATE>, <&clk DCU_GATE>, <&clk DCUP_DIV>;
>> clock-names = "core", "bus", "pix0";
>> ```
>>
>> Well nonetheless the name "core" does not match the description "Bus
>> clock that gates register access".
>>
>> Thanks,
>> Icenowy

Understood. I will remove all description strings from the if/else 
branches; the if/then clauses will only constrain clock-names and 
reset-names items (name values only, no descriptions). Regarding clock 
naming: DCU_GATE on MA35D1 is a peripheral gate clock without a separate 
dedicated core working clock, so I will keep "core" as the name and drop 
the misleading description "Bus clock that gates register access". The 
description mismatch was entirely in the if/else strings which are now 
removed.

Thanks.

>>
>>> +
>>> +        clock-names:
>>> +          items:
>>> +            - const: core
>>> +            - const: pix0
>>> +
>>> +        resets:
>>> +          maxItems: 1
>>> +          description:
>>> +            Reset line for the display controller.
>>> +
>>> +        reset-names:
>>> +          items:
>>> +            - const: core
>>> +
>>> +      required:
>>> +        - port
>>> +
>>> +      not:
>>> +        required:
>>> +          - ports
>>> +
>>> +unevaluatedProperties: false
>>>   
>>>   examples:
>>>     - |
>>> @@ -120,3 +180,24 @@ examples:
>>>           };
>>>         };
>>>       };
>>> +
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>>> +
>>> +    display@40260000 {
>>> +        compatible = "verisilicon,dc";
>>> +        reg = <0x40260000 0x20000>;
>>> +        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&clk DCU_GATE>, <&clk DCUP_DIV>;
>>> +        clock-names = "core", "pix0";
>>> +        resets = <&sys MA35D1_RESET_DISP>;
>>> +        reset-names = "core";
>>> +
>>> +        port {
>>> +            dpi_out: endpoint {
>>> +                remote-endpoint = <&panel_in>;
>>> +            };
>>> +        };
>>> +    };
