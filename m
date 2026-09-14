Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA56CC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1ED10EE42;
	Mon, 14 Sep 2026 13:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dRHX1F8l";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB1410EBFA
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:15:44 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d715f4a587so42647565ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789373744; x=1789978544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a+mbYj9gFoY+dF3f91W1Xx4566ofLNjeGKmQ/I7aiac=;
 b=dRHX1F8l1Ts77m8fOkLmFfZh0HndIwXbvrkBwLIi5UniKBjfOgPT0JXRm1wTupIofi
 E8n4t5wtXaDYF04gt4OEI373PZDBB1cW4gwNmoKyExY5PNSJwGGU7iZXvBcfTTAV/DWV
 ni1SSvB/i8itKUB0jihWndU6enMhkIi8FrCL+G/cwmX3iR+PtA2K1zJ53oaoOAwJE10E
 8jhjkBod4jgE9u/FrWMtQqVypRYVtkfa85gQilEkCkdSK1hR+sA0U9L+lx7+QYiyIbbh
 Tm7aRd+CtYoKvfEV3tNV4uAcRgLOTU7LGidJc1DSMfmy9ZY4BEVtw/8OrBadnhEekG52
 DQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789373744; x=1789978544;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a+mbYj9gFoY+dF3f91W1Xx4566ofLNjeGKmQ/I7aiac=;
 b=A3SYB4ssNLyrK9evf4BUzAoD/psVKQ7hGwEPCcWsr0qfHjTj5xGHL/pM0cOkByvt/U
 psuM5W0wEo3ZyU0MAxJcdOOwLNKdVJPWxuyXK1ZNCGOlcRlJc7yxXjyAxzxqyzTfzVzr
 UsW1463m1SPLj0i3znbkTwuG5v23TW+MZum7og/SqqCpqX6L20qJzqQd3XViSkWf7UAB
 zW/+smF2X7jJ9nW8PBBTjIUoGVFu6ZA1coy5IlVkiGAC4llQaQfekmehSqTmD1KjF2II
 fPcM/IadGqLqleoTqV3T+/jq2/6TrOc3T/UU6snmzKtgADy+ejRMnDaaJtvIgz3cI0ND
 /CoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzlgQxb+3gAvyQGHNkzQahMcJmLOSjf7M3Z1qzmtv3mdFrhH3TpiRicbfzg2EAN8EALAcTsBBTwag=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lfJlc5Ufyd+vBStpiyf4mTzLxWEIMoaYWn9+CsT+qoGeunyb7j
 MCEbXCMS3xmhRErKyjH/127LW6U5qk2yjshE1X/iuSBc/8K1LuSUihvr
X-Gm-Gg: AYBFou2ndlbiDhgv+ExBBxDlJDSeoTfWgXLoe2Eb9FLVJLyT7CjmgqJbgYPd/gEQH5b
 KbtOcG9LRRodHznzs5x1oxHJ50TjaHCPEZN1NfFO29eEXAsbokwuMau+NEZF7DKEXbXrXWn88ua
 +BLgPQSNnsZd3pxzXIT8L97OYKmzCZA20WMKIk3UIiNx/mg3LTV02IVv8P+2V18bJ260q/T+4eK
 bce0AWcpsZ7BYwDoUFFVN73RTgDH8Zlc9O/7IbiLeiLnKINj3v7Zf2kAOTVACIlfxmUdccvrvZB
 CLvl+2RvWWA/Vrq+hmISUk504d6XUJfAHUPcyWtETivOvYnh3f/+oCQ/ZPjxw0qtSMyLKUkEm7i
 5kUZE12i7y53yw+c+V1QVKMhQrTjBQOu4vwZik+N99hBTLKKtMJq89eu2ruwcI1T80zkKbLn80k
 XzF7QLVITN00JXN3K49zXLf+Agjm3NXjAZaf/8VEQDTq5zzRRdKLPqPg11H4L4KJzUBH52Pt2l2
 JiUg0NT/v4e6SMcihYr8y4SpIpvVvzx3S3UvRa9kuhWdhWE1iOXiibRWYQPuilKpQ==
X-Received: by 2002:a17:902:e744:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2dd6c4835d0mr31756845ad.0.1789373744241; 
 Mon, 14 Sep 2026 01:15:44 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cec8483sm44238255ad.44.2026.09.14.01.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 01:15:42 -0700 (PDT)
Message-ID: <2fd1f320-05a8-4782-8134-157c50024adb@gmail.com>
Date: Mon, 14 Sep 2026 16:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] dt-bindings: display: verisilicon, dc: add support
 for nuvoton,ma35d1-dcu
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260908092840.225220-1-a0987203069@gmail.com>
 <20260908092840.225220-2-a0987203069@gmail.com>
 <f74168b54fe8f070b7cfe79dc2fc83a63c2e8842.camel@iscas.ac.cn>
 <9d697240-3632-401f-aeba-c1fa5c2a29d4@gmail.com>
 <14f7fdf36a25b9669145b766becc6f32ef205320.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <14f7fdf36a25b9669145b766becc6f32ef205320.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:11:03 +0000
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


Icenowy Zheng 於 2026/9/10 下午 03:08 寫道:
> 在 2026-09-10四的 09:52 +0800，Joey Lu写道：
>> Icenowy Zheng 於 2026/9/9 下午 01:44 寫道:
>>> 在 2026-09-08二的 17:28 +0800，Joey Lu写道：
>>>> Add the Nuvoton MA35D1 DCUltraLite (nuvoton,ma35d1-dcu) to the
>>>> binding.
>>>> The DCUltraLite uses only four clocks (core, axi, ahb, pix0) and
>>>> one
>>>> reset (core), with a single output port.
>>>>
>>>> The MA35D1 clock controller gates the core, AXI and AHB clocks
>>>> with a
>>>> single bit, but each remains a distinct clock line feeding the IP
>>>> with
>>>> its own rate constraints, so all four must still be listed
>>>> individually
>>>> in the devicetree; core, axi and ahb happen to share the same
>>>> clock
>>>> phandle.
>>> This is weird, but I must admit that we're limited by the Common
>>> Clock
>>> Framework here, so I cannot give a better solution either.
>>>
>>> Anyway let's settle with the current result.
>>>
>>>> Move the clocks/clock-names minItems to 4 and resets/reset-names
>>>> minItems to 1 at the top level, since that is the lowest count
>>>> any
>>>> supported variant needs.  Add an allOf/if block that tightens the
>>>> constraint back up to the fixed 5-clock/3-reset topology required
>>>> by
>>>> the existing thead,th1520-dc8200 compatible, and another one that
>>>> caps
>>>> the new nuvoton,ma35d1-dcu compatible at the 4-clock/1-reset
>>>> count it
>>>> actually wires up.
>>>>
>>>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>>>> ---
>>>>    .../bindings/display/verisilicon,dc.yaml      | 44
>>>> +++++++++++++++++++
>>>>    1 file changed, 44 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>>> index 919a900122012..773966677d0f4 100644
>>>> ---
>>>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>>> +++
>>>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>>> @@ -17,6 +17,7 @@ properties:
>>>>        items:
>>>>          - enum:
>>>>              - thead,th1520-dc8200
>>>> +          - nuvoton,ma35d1-dcu
>>>>          - const: verisilicon,dc # DC IPs have discoverable
>>>> ID/revision
>>>> registers
>>>>    
>>>>      reg:
>>>> @@ -26,6 +27,7 @@ properties:
>>>>        maxItems: 1
>>>>    
>>>>      clocks:
>>>> +    minItems: 4
>>>>        items:
>>>>          - description: DC Core clock
>>>>          - description: DMA AXI bus clock
>>>> @@ -34,6 +36,7 @@ properties:
>>>>          - description: Pixel clock of output 1
>>>>    
>>>>      clock-names:
>>>> +    minItems: 4
>>>>        items:
>>>>          - const: core
>>>>          - const: axi
>>>> @@ -42,12 +45,14 @@ properties:
>>>>          - const: pix1
>>>>    
>>>>      resets:
>>>> +    minItems: 1
>>>>        items:
>>>>          - description: DC Core reset
>>>>          - description: DMA AXI bus reset
>>>>          - description: Configuration AHB bus reset
>>>>    
>>>>      reset-names:
>>>> +    minItems: 1
>>>>        items:
>>>>          - const: core
>>>>          - const: axi
>>>> @@ -79,6 +84,45 @@ required:
>>>>      - reset-names
>>>>      - ports
>>>>    
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: thead,th1520-dc8200
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 5
>>>> +
>>>> +        clock-names:
>>>> +          minItems: 5
>>>> +
>>>> +        resets:
>>>> +          minItems: 3
>>>> +
>>>> +        reset-names:
>>>> +          minItems: 3
>>>> +
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: nuvoton,ma35d1-dcu
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          maxItems: 4
>>>> +
>>>> +        clock-names:
>>>> +          maxItems: 4
>>>> +
>>>> +        resets:
>>>> +          maxItems: 1
>>>> +
>>>> +        reset-names:
>>>> +          maxItems: 1
>>> Maybe it's reasonable to restrict max port count to 1 for MA35D1?
>>> Although I am not sure about how to do this...
>>>
>>> Thanks,
>>> Icenowy
>>    I found the same kind of per-compatible port restriction already
>> used
>> upstream in renesas,du.yaml, e.g.:
>>
>>           ports:
>>             properties:
>>               port@2: false
>>               port@3: false
>>             required:
>>               - port@0
>>               - port@1
>>
>> Applied to our binding, that would look like:
>>
>>           ports:
>>             properties:
>>               port@1: false
>>             required:
>>               - port@0
>>
>> in the existing nuvoton,ma35d1-dcu allOf/if/then block, so schema
>> checks
>> would reject a port@1 node on this compatible instead of silently
>> accepting it.
>>
>> Happy to add it if you'd like the schema to enforce this, but wanted
>> to
>> check whether you consider it worth the extra lines given it doesn't
>> reflect an actual bug in any DT today. Let me know which way you'd
>> prefer and I'll fold it into the next version.
> Personally I think this is good, but maybe adding it as an additional
> patch after merging isn't a big problem, because this just plays as
> kind of a safety guard.
>
> Well this depends on how DT binding maintainers think, but as Conor has
> dropped his Ack, this shouldn't be a big issue.
>
> Thanks,
> Icenowy
I'll send the port@1: false restriction as a follow-up patch once this 
series lands.
Thanks!
>> Thanks.
>>>> +
>>>>    additionalProperties: false
>>>>    
>>>>    examples:
