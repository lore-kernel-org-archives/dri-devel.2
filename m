Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69ACCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDF910F5C9;
	Mon,  8 Jun 2026 15:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cml47MSe";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445B310F071
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:44:05 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c85893bce34so1550677a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780911845; x=1781516645; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdqtVwTNX0imLywa7I0ecwdu4Le2YQgpibN80cjQUTg=;
 b=Cml47MSeNSgEQimPEO8eOzey6uCQfdMu6TGBYF1wXVY5gpA1wUUNcx22SXlEsNeD+B
 jgMbX8I/fh9l9rfblRD1oNYCuowvSs89yh84YRSXthzzENYckDF5oOGz/5b419n+xmvK
 fTkjqGwRpDkI92jw5xIFQ2tEDqcfNj6A0LIF3ezVrgUXvIPVWO8s6TmPVQtFu94YGnUz
 hftOo1iWeUgTAV7u5bvrgWh1rpAK3km6HtFqgmn1UIP7wK96Mu3j7oJmtXbwCcd4YGmc
 1dHo2O6rjGSvlZArpQB7jFX39nOlgkqMb6hDZ4RAJWvdiB/DMcIAdiE8ej0NnkHa/1yn
 We1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911845; x=1781516645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QdqtVwTNX0imLywa7I0ecwdu4Le2YQgpibN80cjQUTg=;
 b=Xi9Iuok5eFavGAjrphZzOBzpuWmbkvokStP7fCFolxXBrJwVf7o2TOAUhIDhEdZDq4
 QNUEdME0tkQCoUbwoKR/0peXi0GMMIVlt0xP1wkssf3AGRDQdnvqwfyXN8bzdRBeNF9h
 xmU46Q/hKGNFZaiwY6air+OQ3Sa4/hobPjd46WQdJh3QGJrz3kEnAY30aP9hMLawLiUL
 nRZnu4F0KWOy3PRgbA10BODjZ4oIZ9E6EDHXXptoL4L/a5PA1DYLL6M47HI97XURkewn
 9/gYxfP+48psfBWmnffz/xGV21u6fxmTCngCm+I2/TlAw78n2koCywHyu6wU9J4uE5bn
 P05A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kbgtvZclU1rmP7eh5ZJiZPGXQd3Gp04pTuLg8dWZMEozJXH8tdTbLMxwqirlDIX8oKBYzpmjIecY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ1A7OsvGAI3eaB2a6eFzoUrs+uqF1YJyA37HO7psQu9CksdnO
 p0rJT8TEl+94oBq3mh2i0iz1d76rm1zpUeYaTwqK7GFeMR0VEplkunM7
X-Gm-Gg: Acq92OFZ10jsIcuFk/5bGJWUVwVMVyMN1DUl/aLpUKgi6/pUkZIlAqzgsTrUOiulemG
 JAfytWktm1J0shAi9uTPUrOOME/GT9uNida7jha0lHygExz7ZyxywTvH2tEpDOrHeNZ6JfMShDo
 n1WTiNHhYxXEw3xXzJzBoh2Mz0BJXHc7kmwv6oPLQqYmOtZpvJPLvg3g+P0LQFSnIH4P/B3CO0f
 /B/02fNaYiWUB0JHbsPVjXM22NprVuFxv+W03Z//iDdux5vJ33bL89Kjh3EDVVq8kcSwk4YbnCi
 iMJ3s+t2Rt9WeBxSxftJLfn5q4cd17BYyaVlEP9kSSgFaI46ai4r4EmouoWCLBClKx2/fdnkuo1
 Z5FBqsJpQT5yPRooBxTPHZcrEAIudUaQ7kBbuAiify+8GG91QZlSX91DXJQW49HPVKwhFUF+/JA
 kPBCEpYB8RQxrqJeYIGkMyqMyxsz1SWF3UxKXHBb6LG+yQM+CbKbmvjanV4M8rAmp1fnlGLTMXa
 E5ZAzW/B0L0Zkk=
X-Received: by 2002:a05:6a21:700e:b0:39b:f026:6f8d with SMTP id
 adf61e73a8af0-3b4cd09b5a1mr17772625637.43.1780911844599; 
 Mon, 08 Jun 2026 02:44:04 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0bdb98sm14220666a12.31.2026.06.08.02.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:44:04 -0700 (PDT)
Message-ID: <fb9c51bb-5e17-4e62-bfab-efc648cff4d6@gmail.com>
Date: Mon, 8 Jun 2026 17:44:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-2-a0987203069@gmail.com>
 <20260608-emotional-rapid-woodlouse-61f7b9@quoll>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260608-emotional-rapid-woodlouse-61f7b9@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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


On 6/8/2026 4:00 PM, Krzysztof Kozlowski wrote:
> On Mon, Jun 08, 2026 at 10:32:33AM +0800, Joey Lu wrote:
>> The existing schema hard-codes the five-clock/three-reset/dual-port
>> topology of the DC8200 IP block, preventing reuse for single-output
>> variants such as the Verisilicon DCUltraLite used in the Nuvoton MA35D1
>> SoC.
>>
>> Rework the schema so that variant-specific constraints are expressed via
>> allOf/if blocks:
>>
>> - Add nuvoton,ma35d1-dcu to the SoC-specific compatible enum.  The
>>    generic verisilicon,dc fallback remains the driver-binding string.
>> - Relax the top-level clocks/resets definitions to minItems ranges so
>>    the base schema accepts both variants.
>> - Keep ports in the global required list and keep additionalProperties
>>    tightened to unevaluatedProperties.
>> - Add an allOf/if block for thead,th1520-dc8200: five-clock (core, axi,
>>    ahb, pix0, pix1), three-reset (core, axi, ahb).
>> - Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core, pix0),
>>    one-reset (core).
>> - Fix a stray space in the port@0 description.
>> - Add a DT example for the Nuvoton MA35D1 DCU Lite using ports/port@0.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/display/verisilicon,dc.yaml      | 103 +++++++++++++++---
>>   1 file changed, 90 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> index 9dc35ab973f2..db0260d874c5 100644
>> --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> @@ -17,7 +17,8 @@ properties:
>>       items:
>>         - enum:
>>             - thead,th1520-dc8200
>> -      - const: verisilicon,dc # DC IPs have discoverable ID/revision registers
>> +          - nuvoton,ma35d1-dcu
>> +      - const: verisilicon,dc  # DC IPs have discoverable ID/revision registers
> Why do you need to change indentation? Why introducing irrelevant
> changes to the diff?
The extra space was introduced to satisfy `yamllint`'s "too few spaces 
before comment" warning, which requires two spaces before an inline `#`. 
Since this is an unrelated change that pollutes the diff, I will revert 
it to the original single-space form.
>>   
>>     reg:
>>       maxItems: 1
>> @@ -26,6 +27,7 @@ properties:
>>       maxItems: 1
>>   
>>     clocks:
>> +    minItems: 2
>>       items:
>>         - description: DC Core clock
>>         - description: DMA AXI bus clock
> That's not true anymore. In such case the list should also be defined
> per variant and here only min/maxItems.
>
Understood. I will remove the `items:` description list from the 
top-level `clocks:` and keep only `minItems`/`maxItems`. The per-variant 
items descriptions will be moved into the allOf/if blocks.
>> @@ -34,24 +36,19 @@ properties:
>>         - description: Pixel clock of output 1
>>   
>>     clock-names:
>> -    items:
>> -      - const: core
>> -      - const: axi
>> -      - const: ahb
>> -      - const: pix0
>> -      - const: pix1
>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     resets:
>> +    minItems: 1
>>       items:
>>         - description: DC Core reset
>>         - description: DMA AXI bus reset
>>         - description: Configuration AHB bus reset
>>   
>>     reset-names:
>> -    items:
>> -      - const: core
>> -      - const: axi
>> -      - const: ahb
> This stays, with minItems. Variants only need min/maxItems
>
Understood. I will restore the top-level `clock-names` and `reset-names` 
items lists and add `minItems` to each. The per-variant allOf blocks 
will only carry `minItems`/`maxItems`.
>
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     ports:
>>       $ref: /schemas/graph.yaml#/properties/ports
>> @@ -59,7 +56,7 @@ properties:
>>       properties:
>>         port@0:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -        description: The first output channel , endpoint 0 should be
>> +        description: The first output channel, endpoint 0 should be
>>             used for DPI format output and endpoint 1 should be used
>>             for DP format output.
>>   
>> @@ -77,7 +74,60 @@ required:
>>     - clock-names
>>     - ports
>>   
>> -additionalProperties: false
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: thead,th1520-dc8200
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 5
>> +          maxItems: 5
>> +
>> +        clock-names:
>> +          items:
>> +            - const: core
>> +            - const: axi
>> +            - const: ahb
>> +            - const: pix0
>> +            - const: pix1
>> +
>> +        resets:
>> +          minItems: 3
>> +          maxItems: 3
>> +
>> +        reset-names:
> minItems: 3
Understood. I will add `minItems: 3` to `reset-names` in the 
thead,th1520-dc8200 block.
>> +          items:
>> +            - const: core
>> +            - const: axi
>> +            - const: ahb
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nuvoton,ma35d1-dcu
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
>> +          maxItems: 2
>> +
>> +        clock-names:
>> +          items:
>> +            - const: core
>> +            - const: pix0
>> +
>> +        resets:
>> +          maxItems: 1
>> +
>> +        reset-names:
> maxItems: 1
Understood. I will add `maxItems: 1` to `reset-names` in the nuvoton block.
>> +          items:
>> +            - const: core
>> +
>> +unevaluatedProperties: false
> Stop making random changes to the binding.
>
> Best regards,
> Krzysztof

Understood. I will revert to `additionalProperties: false` as in the 
original binding.

Many thanks!

