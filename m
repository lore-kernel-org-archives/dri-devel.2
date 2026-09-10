Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875B8C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F5010F3EC;
	Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ERSfU4C4";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA34110E22B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:53:04 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d8fb334ddcso8648265ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 18:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789005184; x=1789609984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B3AxC7gchtFJwmTqUc6Eo/wyWrQDc1+3uptrgZICrdw=;
 b=ERSfU4C47hBJ+L0cBZjesKZiOfutG30BimUp2NPvFbnivNHwHDiMqDUyEPCn3AYkM5
 RF+Ie6VxY5aaSs7EVYiCsOKA5j9l5SmCfuO1aybRcBVM+DbzsJbGQ257w9a+uYbM6jPi
 6Poi9VSGmdTaoLLs9jiUwhJxzmE9lMGfZI9i2hnyf4OnVWxfmdTEBKd5XazT2r37cbNG
 GUVtCiyWhNFHOh3GapfODsjbW5uxVKcX6OJgvr6QyTwtHvmTwAE20DSdts8i+CYLxoA0
 QdVq7etSenfn72wdG7Y/pTwGu7sYnJdewc/IqrMAvx1X8FmsBtm1zfvjT+VXpzJMbXed
 GMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789005184; x=1789609984;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B3AxC7gchtFJwmTqUc6Eo/wyWrQDc1+3uptrgZICrdw=;
 b=jG9LseJrHRSP1urcDRuCTXdJSA7Hkzos2rgBVmf4f4Wy4SbezE8HjcgHZJf80Hi4HN
 D903hTAJjugSoMsCaqjzD/07VMzoz1MSemRjSHcpuroM5MmjLRR0BI9h31rctvvAdOEX
 TkNPQbPBOVepD/LINDAJTAUjgYZ1BfFDDiqPF3pGAXscqjujAJgAshOB2b46D1xqNmR4
 tFOV9W3k9+PRyu0xaU7Bo73zGns1fOoZxRRAYcS/W44klQ1DZyM/cRmPsyVmPa8ACGAX
 1qGP6JZ6Tyw2VcYmWoAbsslsaOnr7o4GltTkVQh1/S1oBUCqcd/8ahc1FjCvEyylE9at
 noOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnNG+799BMvVKPp7DrOf0Zplg3kzkXDyIKq74+kPcXKw7FZjYLduB/WJDwe6ktzIJ/QZpYf2u0HBs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nVpjepMqkmTrq9XlIShZfORB/Gp0JG3y+2bpdB52uJxicU0Lx0
 XHQqVW73BJeE0PcTMecC2UABe52WuN+Bwz2rTFsqxn2cNoLdq7ctlfbp
X-Gm-Gg: AYBFou0XQbAi6CFkPZnqc8lCUh1vY4L4bBburLQ1x4YocV8Hy+BC8+f8n7nLhYATapX
 npKRcJLWSWZENBmudP4/D/NZoCX0VH1LE5zEXBDUx8j1hcjTJsVf4MLqL4WDajz3Zjj77tQ0oPA
 1aNHo8QmTFeTwXFsAWq78LvP3fPtABKkJI7PqBaYhBvWBGAs405WHlpgjZe7gC9mkldFY6LAqVN
 UQhvMTsYlfJpny1oO59mQhYybWF25q7JgENG7yr28GMGzzkDh8SqYQ3pcaNJVf9hv/3mCsmPR7j
 wzxl27F4bKjxq6RHDkmz5sv3RMTbhcJFe5yAJ4qso/s7f4vIMjooOFezv02k0LfDJbZ/4EOheK7
 0qBgsRiwLComPCtI0gnL3T2JbYi/09MueJw7mE54qNWxOHkmS7q6vEcqdpIlKgA+kfeQ4XEQ4PP
 /KZtRoOq4Y6dDIuo8/o26dJaemPmAaP6bFqk2C2jDDN7wVwOwMLwFwHzf3/wTfvmuhJNN4UKkd6
 Jm4ls5BWy9Y7UgbRXBldBjVyiFJeQJMJiTmwKPxANrnYIVKQvTzyDs=
X-Received: by 2002:a17:902:d58a:b0:2d9:4358:73ab with SMTP id
 d9443c01a7336-2dd07b9c78cmr64548885ad.19.1789005184028; 
 Wed, 09 Sep 2026 18:53:04 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499d92dsm79698945ad.52.2026.09.09.18.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 18:53:03 -0700 (PDT)
Message-ID: <9d697240-3632-401f-aeba-c1fa5c2a29d4@gmail.com>
Date: Thu, 10 Sep 2026 09:52:58 +0800
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
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <f74168b54fe8f070b7cfe79dc2fc83a63c2e8842.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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


Icenowy Zheng 於 2026/9/9 下午 01:44 寫道:
> 在 2026-09-08二的 17:28 +0800，Joey Lu写道：
>> Add the Nuvoton MA35D1 DCUltraLite (nuvoton,ma35d1-dcu) to the
>> binding.
>> The DCUltraLite uses only four clocks (core, axi, ahb, pix0) and one
>> reset (core), with a single output port.
>>
>> The MA35D1 clock controller gates the core, AXI and AHB clocks with a
>> single bit, but each remains a distinct clock line feeding the IP
>> with
>> its own rate constraints, so all four must still be listed
>> individually
>> in the devicetree; core, axi and ahb happen to share the same clock
>> phandle.
> This is weird, but I must admit that we're limited by the Common Clock
> Framework here, so I cannot give a better solution either.
>
> Anyway let's settle with the current result.
>
>> Move the clocks/clock-names minItems to 4 and resets/reset-names
>> minItems to 1 at the top level, since that is the lowest count any
>> supported variant needs.  Add an allOf/if block that tightens the
>> constraint back up to the fixed 5-clock/3-reset topology required by
>> the existing thead,th1520-dc8200 compatible, and another one that
>> caps
>> the new nuvoton,ma35d1-dcu compatible at the 4-clock/1-reset count it
>> actually wires up.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/display/verisilicon,dc.yaml      | 44
>> +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> index 919a900122012..773966677d0f4 100644
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
>> @@ -26,6 +27,7 @@ properties:
>>       maxItems: 1
>>   
>>     clocks:
>> +    minItems: 4
>>       items:
>>         - description: DC Core clock
>>         - description: DMA AXI bus clock
>> @@ -34,6 +36,7 @@ properties:
>>         - description: Pixel clock of output 1
>>   
>>     clock-names:
>> +    minItems: 4
>>       items:
>>         - const: core
>>         - const: axi
>> @@ -42,12 +45,14 @@ properties:
>>         - const: pix1
>>   
>>     resets:
>> +    minItems: 1
>>       items:
>>         - description: DC Core reset
>>         - description: DMA AXI bus reset
>>         - description: Configuration AHB bus reset
>>   
>>     reset-names:
>> +    minItems: 1
>>       items:
>>         - const: core
>>         - const: axi
>> @@ -79,6 +84,45 @@ required:
>>     - reset-names
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
>> +
>> +        clock-names:
>> +          minItems: 5
>> +
>> +        resets:
>> +          minItems: 3
>> +
>> +        reset-names:
>> +          minItems: 3
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nuvoton,ma35d1-dcu
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 4
>> +
>> +        clock-names:
>> +          maxItems: 4
>> +
>> +        resets:
>> +          maxItems: 1
>> +
>> +        reset-names:
>> +          maxItems: 1
> Maybe it's reasonable to restrict max port count to 1 for MA35D1?
> Although I am not sure about how to do this...
>
> Thanks,
> Icenowy
  I found the same kind of per-compatible port restriction already used 
upstream in renesas,du.yaml, e.g.:

         ports:
           properties:
             port@2: false
             port@3: false
           required:
             - port@0
             - port@1

Applied to our binding, that would look like:

         ports:
           properties:
             port@1: false
           required:
             - port@0

in the existing nuvoton,ma35d1-dcu allOf/if/then block, so schema checks 
would reject a port@1 node on this compatible instead of silently 
accepting it.

Happy to add it if you'd like the schema to enforce this, but wanted to 
check whether you consider it worth the extra lines given it doesn't 
reflect an actual bug in any DT today. Let me know which way you'd 
prefer and I'll fold it into the next version.

Thanks.
>> +
>>   additionalProperties: false
>>   
>>   examples:
