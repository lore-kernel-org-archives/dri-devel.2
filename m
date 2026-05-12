Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B387CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C3510ED1B;
	Wed, 13 May 2026 07:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FDSG0ygX";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C31A10E9B0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:02:12 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c801912c903so2346626a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778572932; x=1779177732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AvdMBdFTlgEZ+NgOQJwvclLyoLJxV/JPRMgoqHd4xoY=;
 b=FDSG0ygXFiQzB/MSsHucVJRmPP9PZfZPI2zde9/W+dYbfdgevfq65RnaLDPyY7+zKk
 Xww3vt8Xx4d0jIeiHPATTQBSZltLGMF7IYraXXapg1t/48Kb7AngVnXR6wbkRvFij/Qu
 9Gdci6C+YlMPkyTNe/YFqXRfZKU8e5mp9XCnscfwVmEV6mBxoH95Upfigu+gYWswcO/A
 CS0LggaUoEIkGBYZ+6uEoGEk5ffm0aQwIwozh3X6Tck3t5gkUjK/C6heB5k4Z/Fwwhfe
 Eh7MXDXOfI88II4n7ZubrJHMc69R2CwDnY8a+Zb3eqFMsi0hmaoh+XSqcrhc4UNnXpE9
 1QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778572932; x=1779177732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AvdMBdFTlgEZ+NgOQJwvclLyoLJxV/JPRMgoqHd4xoY=;
 b=NXaFZLM3r83Tku3jbXzruT0Q3ijSuRzsnD/+LtfSNaH41/fYQhhyGgbB6xMOiP1Wmu
 4VwpFhtYi3lBpH4m4AGDaycKXEEo613YTWMN+tt/GwluzR+AROtDOGZSafGqfl5op8J7
 7iXumtFb3AP8y+6APgLrEqkz6ndKstmAT9KAgzn2xOoWh+e+kYztahQPmeqkQcBzKcGJ
 7faFNXQOw3mZphjB4jBtflGIw40IzKy9Kv8THzZ/FiEoiIhACdd/l7k03/R0uO7MjNQK
 EUygUHJeG4PDToDfBKGCsgLD8CQ6vhjaBVp7O09o8/VnIz9IPvPYfP9wGWkuMh/aUE4M
 B6kQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mdrOCr1QfeD22Vsobs+hZv9U4LNwn+hRFlSuVo24URkueUG1q/DFIBj/rUnZLo3D80Vcbxh+y4MI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9w3g3OtYkKb2JnGEVcYLDNq1tQHltQEDUL8CC+Lle4Clg0LZq
 5cwf3DJxexUGa/dqCTuesRY/7vKwFsUeDTmC49NMFTmKiE6p82ilS4pY
X-Gm-Gg: Acq92OGyvQAu6WKxCMAvSovPbXTimpV7EMGaqZipjdwSwcUrCGbzvbzJE0Chm4kv97k
 /iAdWPujhEbdfWrRnNpO6I4JlRdXdJLU4OLVSLQdqrnybM5lr0th9joqARKAYy6JhDRYTwG7cXl
 cmtJyn4cBpcZrjceRCp5bBW4qxrFW9xF9P0bl6PEK01rFD2Df0Mn8WGXWfPvs7ENG15VN3uf0Bn
 c1HwjWvVKZih+9ZceOY1sqw28PdOdTYzB4+k3QjGb9Y72auwdyJvEr5YmppVrjfMsav1NUAOWOw
 5HJ0lmW5yt7ku4YeVT5XSZTJEkPq0fwKlvuQt1TkJ9bTtQ+06qWGqWbbWUClzZiqxA8ohCBULoC
 yE/LPml7YXQAHdySjFmOl2KnmG6mrXbv/XxKB4Qms4irJm95NuSMHGyrxU45DeZLF1seyPEZstm
 TcckHIQXWHmh2sGuSQUGfbIEAmnMy9sPZB8tEfBmsvgI5/ifnP3MGTKjrMwOFPYyTuc1Qq3ryJK
 EDI
X-Received: by 2002:a05:6a20:9144:b0:3a3:adea:83ac with SMTP id
 adf61e73a8af0-3aad44c2583mr14068901637.46.1778572931739; 
 Tue, 12 May 2026 01:02:11 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965d36a12sm20537152b3a.27.2026.05.12.01.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 01:02:11 -0700 (PDT)
Message-ID: <8904a207-9dd8-4fd3-a0d8-7c688361bea3@gmail.com>
Date: Tue, 12 May 2026 16:02:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: verisilicon, dc: generalize for
 DCUltra Lite variant
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-2-a0987203069@gmail.com>
 <cb69490652409eb4f07b3ee642d478e1b2e28c5b.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <cb69490652409eb4f07b3ee642d478e1b2e28c5b.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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


On 5/11/2026 5:59 PM, Icenowy Zheng wrote:
> 在 2026-05-11一的 15:51 +0800，Joey Lu写道：
>> Extend the verisilicon,dc base schema to accommodate the Nuvoton
>> MA35D1
>> DCUltra Lite (a previous generation of the DC8000 series) which has a
>> different clock topology, no reset control, and a single output.
>>
>> - Replace the fixed clock/reset item lists with minItems/maxItems
>> ranges
>>    so sub-schemas can enforce variant-specific constraints
>> - Add a 'port' property (single-port alias) alongside the existing
>> 'ports'
>>    for single-output variants
>> - Remove the mandatory 'ports' requirement from the base schema; sub-
>> schemas
>>    shall enforce their own port topology
>> - Add a 'select' stanza so the validator matches any node whose
>> compatible
>>    contains a known Verisilicon DC string, including SoC-specific glue
>> - Relax additionalProperties to allow unevaluatedProperties
>> enforcement in
>>    sub-schemas
>> - Fix a minor whitespace issue in the port@0 description
>>
>> Add nuvoton,ma35d1-dcu.yaml as a sub-schema for the Nuvoton MA35D1
>> DCUltra
>> Lite display controller:
>>
>> The Nuvoton MA35D1 integrates the Verisilicon DCUltra Lite display
>> controller. It is a single-output display controller with a 32-bit
>> RGB (DPI) interface. Unlike the DC8000, it does not have discoverable
>> chip identity registers, does not support the CONFIG_EX commit path,
>> and uses dedicated IRQ status/enable registers at offsets
>> 0x147C/0x1480.
>> The clock topology uses two clocks (bus gate and pixel divider) and
>> does not require explicit reset control from the driver.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/display/nuvoton,ma35d1-dcu.yaml  | 94
>> +++++++++++++++++++
>>   .../bindings/display/verisilicon,dc.yaml      | 64 +++++++------
>>   2 files changed, 131 insertions(+), 27 deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml
>> b/Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml
>> new file mode 100644
>> index 000000000000..9279004ae27c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/nuvoton,ma35d1-
>> dcu.yaml
>> @@ -0,0 +1,94 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/nuvoton,ma35d1-dcu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 DCUltra Lite display controller
>> +
>> +maintainers:
>> +  - Joey Lu <yclu4@nuvoton.com>
>> +
>> +description:
>> +  The Nuvoton MA35D1 integrates the Verisilicon DCUltra Lite display
>> +  controller. It is a single-output display controller with a 32-bit
>> +  RGB (DPI) interface.
> You'd better write this in verisilicon,dc.yaml with if clauses. See
> Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml for an
> example for a generic IP with different integrations, and how it
> constraints different SoC's integration.
Understood. I'll drop both the separate nuvoton,ma35d1-dcu.yaml
file and the `nuvoton,ma35d1-dcu` compatible string entirely. Since the
chip identity registers are present on the DCUltra Lite (model=0x0,
rev=0x5560, customer=0x305), the MA35D1 DT node will use
`compatible = "verisilicon,dc"` directly. The YAML will use a single
`if/then/else` block in `allOf:` keyed on whether `thead,th1520-dc8200`
is present in the compatible list: the `then` branch enforces DC8200
constraints (5 clocks, 3 resets, `ports` required), and the `else`
branch enforces DCUltra Lite / generic constraints (2 clocks, 1 reset,
`port` required, `ports` forbidden). The Nuvoton MA35D1 example will use
`compatible = "verisilicon,dc"` and fall into the `else` branch.
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - nuvoton,ma35d1-dcu
>> +  required:
>> +    - compatible
>> +
>> +allOf:
>> +  - $ref: http://devicetree.org/schemas/display/verisilicon,dc.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-dcu
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description:
>> +      Register range of the DCUltra Lite controller. The address
>> space
>> +      is 0x2000 bytes.
> Is it really 0x2000 bytes? The next peripherals in the address space,
> the GC520L 2D GPU, is 0x20000 bytes away from the start of DCU
> registers space.
Good point. The 0x2000 figure is the driver's `max_register`,
not the full hardware block size. I'll remove the description text
claiming "0x2000 bytes" and update the example to use `0x20000` to
match the actual hardware address space.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Bus clock that gates register access (DCU_GATE)
>> +      - description: Pixel clock divider for display timing
>> (DCUP_DIV)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: pix0
>> +
>> +  resets:
>> +    maxItems: 1
>> +    description:
>> +      Optional reset for the display controller. The driver does not
>> +      assert or deassert this reset; it may be used by firmware or
>> +      boot loaders to bring the hardware to a clean state.
> Why is there a reset in hardware but not toggled in the software?
The driver will handle the reset in v2. The probe path will call
`devm_reset_control_bulk_get_optional_shared()` unconditionally with all
three names ("core", "axi", "ahb"). Since the MA35D1 DT only provides a
single reset named "core", the "axi" and "ahb" entries will be no-op
handles — optional bulk reset lookup skips absent entries silently.
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>> +    description:
>> +      Output port to the downstream display device (e.g. RGB panel).
>> +      The DCUltra Lite supports a single parallel RGB output.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - port
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
>> +    display@40260000 {
>> +        compatible = "nuvoton,ma35d1-dcu";
>> +        reg = <0x40260000 0x2000>;
>> +        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&clk DCU_GATE>, <&clk DCUP_DIV>;
>> +        clock-names = "core", "pix0";
>> +        resets = <&sys MA35D1_RESET_DISP>;
>> +
>> +        port {
>> +            dpi_out: endpoint {
>> +                remote-endpoint = <&panel_in>;
>> +            };
>> +        };
>> +    };
>> diff --git
>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> index 9dc35ab973f2..00884529f8c1 100644
>> --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> @@ -9,15 +9,34 @@ title: Verisilicon DC-series display controllers
>>   maintainers:
>>     - Icenowy Zheng <uwu@icenowy.me>
>>   
>> +description:
>> +  Verisilicon DC-series display controllers.
>> +
>> +# Select any node whose compatible contains one of the known
>> Verisilicon DC
>> +# or DC-derived compatible strings, including SoC-specific glue
>> variants.
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - verisilicon,dc
>> +          - thead,th1520-dc8200
>> +          - nuvoton,ma35d1-dcu
>> +  required:
>> +    - compatible
>> +
>>   properties:
>>     $nodename:
>>       pattern: "^display@[0-9a-f]+$"
>>   
>>     compatible:
>> -    items:
>> -      - enum:
>> -          - thead,th1520-dc8200
>> -      - const: verisilicon,dc # DC IPs have discoverable ID/revision
>> registers
>> +    # Enumerated in full so the schema validator can verify any
>> compatible
>> +    # string against this list, including those from child schemas.
>> +    contains:
>> +      enum:
>> +        - verisilicon,dc
>> +        - thead,th1520-dc8200
>> +        - nuvoton,ma35d1-dcu
>>   
>>     reg:
>>       maxItems: 1
>> @@ -26,32 +45,24 @@ properties:
>>       maxItems: 1
>>   
>>     clocks:
>> -    items:
>> -      - description: DC Core clock
>> -      - description: DMA AXI bus clock
>> -      - description: Configuration AHB bus clock
>> -      - description: Pixel clock of output 0
>> -      - description: Pixel clock of output 1
>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     clock-names:
>> -    items:
>> -      - const: core
>> -      - const: axi
>> -      - const: ahb
>> -      - const: pix0
>> -      - const: pix1
>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     resets:
>> -    items:
>> -      - description: DC Core reset
>> -      - description: DMA AXI bus reset
>> -      - description: Configuration AHB bus reset
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     reset-names:
>> -    items:
>> -      - const: core
>> -      - const: axi
>> -      - const: ahb
>> +    minItems: 1
>> +    maxItems: 3
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>> +    description: Single video output port for single-output
>> variants.
>>   
>>     ports:
>>       $ref: /schemas/graph.yaml#/properties/ports
>> @@ -59,7 +70,7 @@ properties:
>>       properties:
>>         port@0:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -        description: The first output channel , endpoint 0 should be
>> +        description: The first output channel, endpoint 0 should be
>>             used for DPI format output and endpoint 1 should be used
>>             for DP format output.
>>   
>> @@ -75,9 +86,8 @@ required:
>>     - interrupts
>>     - clocks
>>     - clock-names
>> -  - ports
>>   
>> -additionalProperties: false
>> +additionalProperties: true
>>   
>>   examples:
>>     - |
