Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC23CD98F6
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EC310F1A4;
	Thu, 18 Jun 2026 07:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PPTnoHEs";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17CD10E9BF
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:25:08 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2c6a97e1d1bso10323205ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781691908; x=1782296708; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VbVg/KwHCVhdvL9LHCxz6CTvTzl761Uhp31GttVosv0=;
 b=PPTnoHEszw0bJnSSJQ3uLlDMruk+C7H6KqDZ+mOAfVnI4nvw4/phgjXljgaA06VkRb
 9oxINEDNsi32xiNhnj6kO2TwrpQRfT5Ao6I3oqCKxhUAVJzArCYbysg/uiV1YBYsrZJ0
 B4dxqg8rz7RajCk7eXNjuHQwWvhd+R2pfEw6z0xkSwVNaBCw9XDKmXiqqxOw+H8e7EYQ
 4V5YTHI1VH9VPaCVOmO0yVkMSshfvJB5rFZJDeQds/rF7NKoQDdXoDB36bzuUhZmSzXt
 k+X3DcWCGRpXOjFHIxdzKMHWUjsKoLjfv0sB1kyVeG79Kg96yI+79ZGBPXdDAn3qlgTO
 tjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691908; x=1782296708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbVg/KwHCVhdvL9LHCxz6CTvTzl761Uhp31GttVosv0=;
 b=SHEQe2vUQ9qwIH8I4p1/LB5f7B/dLWHqMuZZn1eS+ihwS5H2cs9KPnJAO4uSbai/Fq
 ynMYvjXlPCAws/DCrvoxriIsXs0083rR7Jw4QgpFx9730naJTPLVi0Yi8h7EXOiVNoB1
 HmAlSFhROWcS1t7QS5XjE/YpLebQsNJDnpYRgELQ1VWESq4KKqqDAF3FGMh8gRlWqVOX
 fJPotriwozFSmrKkQLHjU04N7367i9zQ8O07kzxmYqjqkUJjgSPMFNvF9iAtmDrKYPVv
 llbKZHUU5XMCQjNHd0Ahy3gXZW1fG04OICPvDPezSFMmv3iTMu86OG3Gvo+kODZDRkfZ
 MtbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AGqeD9AyiMVOJekWPUwcfQX/5CP87pkwRbl/VBxWuEsna/PeP94hOaQ5C/Z3xVPS55j6epzTap4Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6zitqeraKMYBaRAFg9RLQctxvKZWH05xTI/JgzXJ51IZYMsZ8
 VbFgZwScG6xx/F7rIXa2SWxarJUgPgUCRw627nYtPUjoOt7e4TIrzrkk
X-Gm-Gg: AfdE7clNlp3e9welZt6WCuvCYCzUiBaYv+1DmtJ8pQIQp5K3r4sDMju5IQGqZS8lPH6
 ycv/jQaCCsn3jM/OdBQNJtzr0NN+Mu/kOHar7laiOHqjvgm6VK/0cfikTlTaNH3KdCxYF+gp389
 Yc8kMmceiGqXVbYIVVuu1bbXcn6qmOABWK/wUoC5BnsVgGrhzZsng0IUFJnENvo1O0/StnUcZKH
 npO+38KX3LU+0LXfdr+y3G2P0f0bwoL+KMx+95moIQ6N3tKlsC4DDOHGj14B3KJywvvXqKTb2No
 Mpo/52U0oDW5L7yIYAm1V/OU2YNH7xoSPbFZHrH/4PUmQcxspovHlLDk02SeWyIdycy9hYeyuap
 eMinrumLYGx2AhXDVkVu9yimQw3hteDRirFb3+Znqw5CbdD0YwEcmqdupWxN16LVuMTjJ7V3ECr
 qtM8z5lfvJQk5eHTYHaH7xs5OfWwDWPY8K35BKiGfqwVsx3Fbsq6NHjjsw3R/aXuJAWA==
X-Received: by 2002:a17:902:ef44:b0:2c6:c66b:4b03 with SMTP id
 d9443c01a7336-2c6c66b4d39mr11874145ad.10.1781691908280; 
 Wed, 17 Jun 2026 03:25:08 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42fbb4134sm143780715ad.30.2026.06.17.03.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 03:25:07 -0700 (PDT)
Message-ID: <6d3e3121-22f2-4c59-9678-df2f57ff4d31@gmail.com>
Date: Wed, 17 Jun 2026 18:25:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: display: verisilicon, dc: generalize
 for single-output variants
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260615065003.76661-1-a0987203069@gmail.com>
 <20260615065003.76661-2-a0987203069@gmail.com>
 <3683c5c617324f5835529617325745ef48fa1943.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <3683c5c617324f5835529617325745ef48fa1943.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:12:07 +0000
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


On 6/15/2026 4:19 PM, Icenowy Zheng wrote:
> 在 2026-06-15一的 14:49 +0800，Joey Lu写道：
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
>> - Move clock and reset items descriptions into the per-variant
>> allOf/if
>>    blocks; keep only minItems/maxItems at the top level so the base
>> schema
>>    accepts all variants.
>> - Restore full items lists for clock-names and reset-names at the top
>>    level with minItems so the names are validated against the
>> descriptions.
>> - Keep ports in the global required list and keep
>> additionalProperties: false.
>> - Add an allOf/if block for thead,th1520-dc8200: five-clock (core,
>> axi,
>>    ahb, pix0, pix1), three-reset (core, axi, ahb), required resets.
>> - Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core,
>> pix0),
>>    one-reset (core), required resets.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/display/verisilicon,dc.yaml      | 80
>> +++++++++++++++++--
>>   1 file changed, 73 insertions(+), 7 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> index 9dc35ab973f2..0c41286b8223 100644
>> --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> @@ -17,6 +17,7 @@ properties:
>>       items:
>>         - enum:
>>             - thead,th1520-dc8200
>> +          - nuvoton,ma35d1-dcu
>>         - const: verisilicon,dc # DC IPs have discoverable ID/revision
>> registers
>>   
>>     reg:
>> @@ -26,14 +27,12 @@ properties:
>>       maxItems: 1
>>   
>>     clocks:
>> -    items:
>> -      - description: DC Core clock
>> -      - description: DMA AXI bus clock
>> -      - description: Configuration AHB bus clock
>> -      - description: Pixel clock of output 0
>> -      - description: Pixel clock of output 1
> Clock descriptions should still be in the global part instead of the
> per-compatible part.
>
> In the per-compatible part, clock-names should be constraint for SoCs.
I will move the `items:` clock descriptions back into the global 
`clocks:` property, covering all five possible clocks. In the 
per-compatible sections I will remove the description items and only 
constrain `clocks: minItems/maxItems` and `clock-names: 
minItems/maxItems`; for nuvoton,ma35d1-dcu I will additionally override 
`clock-names: items:` to the two names actually used (core, pix0).
>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     clock-names:
>> +    minItems: 2
>> +    maxItems: 5
>>       items:
>>         - const: core
>>         - const: axi
>> @@ -42,12 +41,16 @@ properties:
>>         - const: pix1
>>   
>>     resets:
>> +    minItems: 1
>> +    maxItems: 3
>>       items:
>>         - description: DC Core reset
>>         - description: DMA AXI bus reset
>>         - description: Configuration AHB bus reset
>>   
>>     reset-names:
>> +    minItems: 1
>> +    maxItems: 3
>>       items:
>>         - const: core
>>         - const: axi
>> @@ -59,7 +62,7 @@ properties:
>>       properties:
>>         port@0:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -        description: The first output channel , endpoint 0 should be
>> +        description: The first output channel, endpoint 0 should be
> If you really want to fix this, please make it a separated patch
> instead of doing it here, for commit atomicity.
>
> Thanks,
> Icenowy
I’ll drop this change and keep it as is
>>             used for DPI format output and endpoint 1 should be used
>>             for DP format output.
>>   
>> @@ -77,6 +80,69 @@ required:
>>     - clock-names
>>     - ports
>>   
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
>> +          items:
>> +            - description: DC Core clock
>> +            - description: DMA AXI bus clock
>> +            - description: Configuration AHB bus clock
>> +            - description: Pixel clock of output 0
>> +            - description: Pixel clock of output 1
>> +
>> +        clock-names:
>> +          minItems: 5
>> +          maxItems: 5
>> +
>> +        resets:
>> +          minItems: 3
>> +          maxItems: 3
>> +
>> +        reset-names:
>> +          minItems: 3
>> +          maxItems: 3
>> +
>> +      required:
>> +        - resets
>> +        - reset-names
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
>> +          items:
>> +            - description: DC Core clock
>> +            - description: Pixel clock of output 0
>> +
>> +        clock-names:
>> +          minItems: 2
>> +          maxItems: 2
>> +
>> +        resets:
>> +          minItems: 1
>> +          maxItems: 1
>> +
>> +        reset-names:
>> +          maxItems: 1
>> +
>> +      required:
>> +        - resets
>> +        - reset-names
>> +
>>   additionalProperties: false
>>   
>>   examples:
