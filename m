Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE03CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D26810F5D7;
	Mon,  8 Jun 2026 15:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jc01C1Hd";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E28210F06D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:42:42 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84232e83ca9so1702765b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780911762; x=1781516562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K89RrwpcqLo8zDg2OvFefmB2AQCgF8PACyQq7p8WH+I=;
 b=Jc01C1HdjJF0juAl/KVPc/bOwJdPaZ7VV+Xhr7ZIKHy1E7+klX5wIMPow71NFQz41J
 MxqoSchS6w/cIM/ROVeaWkYIuXT3bBlek2yLFLx40Qio3GSCCSSx6jr46kVbU2GstFNY
 2OczwFROq+kcHQwKIleots/o20GWIECAoYrGPhzAMNe9MU+HEPCtvTNqWVJYU7e+61ef
 jwkJlcQCIizetJXHVyVHzu0tMTc3LOF/KrhMwLiSpTe8SmUSXPcTtXTzV5JmOsWtZSb1
 0PwJIbbeU/AjQ+rRzmdMV7bEBDNYbBP2ZvsLwA/plQLq1waOSNGRVyRkQ/z7Syda0myO
 dkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911762; x=1781516562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K89RrwpcqLo8zDg2OvFefmB2AQCgF8PACyQq7p8WH+I=;
 b=c9Lzy0AcLr0NoaOfenbOI7duFSFYqOBpAw80DlBPexnssr+2v2v7oZtF2C4LdUSQ+m
 1SerCkn7vmrDfpx22WW5RS3xfnASpzSEKlhxrkLlLnqp9nMLF07dJBZ2dPNWjMgTeuvV
 zTaSjKffyvIOLKkzJLYdNqGc5Y3gtJCA7MjF9KZG8qWlfcpKBBYgOhkF/xeCIHDSJnOl
 QrBylWKjNyqZvvu9t8xd3/gjdYwWi8OReu5Gvdzgalr/Cuaj+Ssy9jA5E9mPISwxUkAW
 1xKcsOv8Zj8RLHL7hnPbT7Z0RQwZEcvUAStWVFsVn/FpmI5YX3cRsKveZZefBpZOYoB7
 pYrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CJHkjyzXR313/CKWLWMIwdsq2vz2q79lP4hAjIXY203dVXBstTKz95lAHwHVx8Q3rpouBfzTcFFk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziyNoGz0OPhqwl9D7itfuBdtlj2xdVxfoMGEeCob2DlYf87eAe
 Uh3/1hS70gmasDrYAtOMsWCwN1oZhiSXIBTI9KBtfF3R/mkgc+03OJPw
X-Gm-Gg: Acq92OGWRfZGmY+25/M1cBw3eRZVJn4jK5p+bb5d8jNxaX8TD6eR3fCJLeL+/oTy3gz
 ijhfUYvU3cfaOTwY2U05is8PnVZ+oSKMGXUvm0+iwu95jcgJYOqrVF3kN/DYreLzAKlkVrx9F28
 xepD78oR7ZHEX+FfS4vG2ELaICO7RtDSYBzoUGLFc1BJfydHbrAVq5lwHTreiBEAx1oosyk41GS
 4UJ/QtyPfbAERYq4tO5Ut+0FfHnGU8DPzicgOpPG3+Rue+ChARfTFtvbdDe39fC/1tnA3XD1aIv
 93xe5TmeYjV3cprRRz8FWWKOe7eBbqV2w/f97JHMxdY5fqW5GX9yJHf9gjpnWVaAtgwJYHepfY5
 sYKi0Ih5w1Hbodx3luoo60ujR0e2+K6Po8wfuj/YoxnF0weCyQFVAq2b0XSJWchVHaONCTC7Kk2
 3OnvFKqdAjYWV9UzbYmGPUgUXw8iwosxVKZxdrSSOARkdEfK4aRQdgbRYl/QMyvDM18TTpSkCV8
 sBtal1W8mcOyrs=
X-Received: by 2002:a05:6a00:a227:b0:842:5719:455c with SMTP id
 d2e1a72fcca58-842b106587dmr14714982b3a.25.1780911761597; 
 Mon, 08 Jun 2026 02:42:41 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282372868sm19883930b3a.17.2026.06.08.02.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:42:41 -0700 (PDT)
Message-ID: <684fde52-569c-4b38-904c-dbb05054634f@gmail.com>
Date: Mon, 8 Jun 2026 17:42:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-2-a0987203069@gmail.com>
 <a3f6fa4529bff5390dd1beb164d600208dc650a5.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <a3f6fa4529bff5390dd1beb164d600208dc650a5.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 6/8/2026 2:32 PM, Icenowy Zheng wrote:
> 在 2026-06-08一的 10:32 +0800，Joey Lu写道：
>> The existing schema hard-codes the five-clock/three-reset/dual-port
>> topology of the DC8200 IP block, preventing reuse for single-output
>> variants such as the Verisilicon DCUltraLite used in the Nuvoton
>> MA35D1
>> SoC.
>>
>> Rework the schema so that variant-specific constraints are expressed
>> via
>> allOf/if blocks:
>>
>> - Add nuvoton,ma35d1-dcu to the SoC-specific compatible enum.  The
>>    generic verisilicon,dc fallback remains the driver-binding string.
>> - Relax the top-level clocks/resets definitions to minItems ranges so
>>    the base schema accepts both variants.
>> - Keep ports in the global required list and keep
>> additionalProperties
>>    tightened to unevaluatedProperties.
>> - Add an allOf/if block for thead,th1520-dc8200: five-clock (core,
>> axi,
>>    ahb, pix0, pix1), three-reset (core, axi, ahb).
>> - Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core,
>> pix0),
>>    one-reset (core).
>> - Fix a stray space in the port@0 description.
>> - Add a DT example for the Nuvoton MA35D1 DCU Lite using
>> ports/port@0.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/display/verisilicon,dc.yaml      | 103 +++++++++++++++-
>> --
>>   1 file changed, 90 insertions(+), 13 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> index 9dc35ab973f2..db0260d874c5 100644
>> --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> @@ -17,7 +17,8 @@ properties:
>>       items:
>>         - enum:
>>             - thead,th1520-dc8200
>> -      - const: verisilicon,dc # DC IPs have discoverable ID/revision
>> registers
>> +          - nuvoton,ma35d1-dcu
>> +      - const: verisilicon,dc  # DC IPs have discoverable
>> ID/revision registers
> Ah is an extra space added here, which leads to this hunk looking
> strange?
The extra space was added because `yamllint` reports "too few spaces 
before comment" (warning: comments) when only one space precedes the 
`#`. However, since this constitutes an unrelated whitespace change that 
makes the diff harder to read, I will revert to the original 
single-space form to keep the patch clean.
>>   
>>     reg:
>>       maxItems: 1
>> @@ -26,6 +27,7 @@ properties:
>>       maxItems: 1
>>   
>>     clocks:
>> +    minItems: 2
> Maybe restrictions about the clock count shouldn't be inserted here,
> and technically it's possible that only the pixel clock is controllable
> by Linux (all other clocks are in a fixed configuration).
Understood. I will remove the per-variant clock items descriptions from 
the top-level `clocks:` section and move them into the respective 
allOf/if blocks. The top-level will only carry `minItems`/`maxItems` for 
schema validation range.
>>       items:
>>         - description: DC Core clock
>>         - description: DMA AXI bus clock
>> @@ -34,24 +36,19 @@ properties:
>>         - description: Pixel clock of output 1
>>   
>>     clock-names:
>> -    items:
>> -      - const: core
>> -      - const: axi
>> -      - const: ahb
>> -      - const: pix0
>> -      - const: pix1
> Ah I think the total list should still appear here, and they should be
> corresponding to the descriptions above?
Understood. I will restore the full items list for `clock-names` at the 
top level (all five entries: core, axi, ahb, pix0, pix1) and add 
`minItems` to make it flexible. Per-variant allOf blocks will only 
constrain with `minItems`/`maxItems`.
>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     resets:
>> +    minItems: 1
>>       items:
>>         - description: DC Core reset
>>         - description: DMA AXI bus reset
>>         - description: Configuration AHB bus reset
>>   
>>     reset-names:
>> -    items:
>> -      - const: core
>> -      - const: axi
>> -      - const: ahb
> Ditto here.
Understood. I will restore the full items list for `reset-names` at the 
top level (core, axi, ahb) with `minItems`. Same pattern as clock-names.
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     ports:
>>       $ref: /schemas/graph.yaml#/properties/ports
>> @@ -59,7 +56,7 @@ properties:
>>       properties:
>>         port@0:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -        description: The first output channel , endpoint 0 should be
>> +        description: The first output channel, endpoint 0 should be
>>             used for DPI format output and endpoint 1 should be used
>>             for DP format output.
>>   
>> @@ -77,7 +74,60 @@ required:
>>     - clock-names
>>     - ports
>>   
>> -additionalProperties: false
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: thead,th1520-dc8200
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 5
>> +          maxItems: 5
>> +
>> +        clock-names:
>> +          items:
>> +            - const: core
>> +            - const: axi
>> +            - const: ahb
>> +            - const: pix0
>> +            - const: pix1
>> +
>> +        resets:
>> +          minItems: 3
>> +          maxItems: 3
>> +
>> +        reset-names:
>> +          items:
>> +            - const: core
>> +            - const: axi
>> +            - const: ahb
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nuvoton,ma35d1-dcu
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
>> +          maxItems: 2
>> +
>> +        clock-names:
>> +          items:
>> +            - const: core
>> +            - const: pix0
>> +
>> +        resets:
> Do we have minItems: 1 here? (The DT schema validator always has some
> quirks that I fail to remember, so I am not sure.)
Yes, I will add `minItems: 1` to `resets:` in the nuvoton block.
>> +          maxItems: 1
>> +
>> +        reset-names:
>> +          items:
>> +            - const: core
>> +
> I think resets should be described as required in both device-specific
> bindings.
>
> Thanks,
> Icenowy

Understood. I will add `required: [resets, reset-names]` inside the 
`then:` block for both thead,th1520-dc8200 and nuvoton,ma35d1-dcu.

Many thanks!

>> +unevaluatedProperties: false
>>   
>>   examples:
>>     - |
>> @@ -120,3 +170,30 @@ examples:
>>           };
>>         };
>>       };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
>> +    display@40260000 {
>> +        compatible = "nuvoton,ma35d1-dcu", "verisilicon,dc";
>> +        reg = <0x40260000 0x20000>;
>> +        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&clk DCU_GATE>, <&clk DCUP_DIV>;
>> +        clock-names = "core", "pix0";
>> +        resets = <&sys MA35D1_RESET_DISP>;
>> +        reset-names = "core";
>> +
>> +        ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            port@0 {
>> +                reg = <0>;
>> +                dpi_out: endpoint {
>> +                    remote-endpoint = <&panel_in>;
>> +                };
>> +            };
>> +        };
>> +    };
