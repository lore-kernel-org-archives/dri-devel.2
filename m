Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55FAC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0613E10E4AA;
	Mon, 21 Sep 2026 07:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjm1AVw8";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7E010E0B4
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:47:29 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ed1368so30090415ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789958849; x=1790563649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+O5egBgvsUIuHoGJAoHI3ORXx+xU1etkOpoJliWaQik=;
 b=kjm1AVw8u8WC2wATit23F2oo15PCXwSmeVyHhyx3cZ2GrWfrOQ2z6buGTAkgwjKgI9
 O/I2sR3idBG5+OvKjooWq+RHQo3jC+mpE9LGcd5KMshP8SPE+PdBnkp5OBOBnUIakkZi
 h1p1L78du/DOpYrZn1gvoNLD2mxlfKbrACsXxUFcCDYzBJr+dBN73+NUTn1ArAw800by
 kRaONQo3NhoD+6Fn5jXfIDaeCOXeNB+nllM8c7WZo0W4SD1/OlfKMJgSZ20ZYStfTkSC
 9OM90zUiT+6E6sd6u8WXC+JJuaILOLmzMHEBylM+O4zILexwTf1HVc+HArq+ImxeYMRX
 yAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789958849; x=1790563649;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+O5egBgvsUIuHoGJAoHI3ORXx+xU1etkOpoJliWaQik=;
 b=E6Hih/WdAA7mJlzvcipK8ulC21mjX/9ezOavvpr/6SLFNz38PN35nYAUBFiv02sKs+
 /r6ehzyfBVKgOv6wdkB6OnQtBuU2A9mAc42dJtrSVSD85RfjUJMy+e75dGJxwom7iOL7
 88+CeViYJitkWLnFi7VJYVjhy4c+0DywSy9NflKvCj63MOupNdrNJIEcZc6KGUidTmjr
 35v3u2GfqmrXL0/6pMqtfLUj09NGERDkWNS3jRj7MoXQDG1p9AyOFOFL8KNEabYe3aa/
 JLDhzdDkL3b1zKLiY+LPf5b3XO3cXRMWjYUrx5vOZ8NkQ2t9gPTFhNhhjfkXUHn+s4/o
 R32Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBycOAxif+JicnDh50OhRiEKsBnO/83erLLFBWB2cLlqHzqSOqEcGcw7Ohxi4D95p70JI4nedbaD68M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRyrI8j7vunWjvjS+QtlV+LdiZlpmkZGN4zVRS2YqPNwUSAV/F
 j5QE2rNfjM2l2PgtFxpflhYOjVhDRfb+2nG1OdtgcrLe1XNoy/hPgXFC
X-Gm-Gg: AYBFou35Ey3Ke1hCqZl7gEKWLbEwifzG9s1nYqXoxPd44THaMyuNfxRE3zUBMVdQ1Cd
 S/gmlkQG7k70vPPAiT0bj7E/jGnnkzDFURNbiMYTkXisM5erAQ01dvdjcnnHJcaoGEZXG6xdeJX
 di/XU2PGkxv5MIYVyaaaw6Z5uBxxO+mkzXWlkhwAGegP6FcmLUDRseoHczkEC8RnXbciPza5u4J
 u+BaR6RmL4lajm7HMQ+ahNClmGS1INaFsMLWwanX5ccEsp1S8giXie8iWoHyvVgN/wfki7K8XSS
 lD9yFcLGkZ3hv01gyJFk6rB2B+mAVAfYB8+kfgSVimCQfweN7awK7d/3hxMpwb2ZKUDvXO5xS4V
 6vV3KYFe8DlK9nauySXtYakbdqKGsSOS128eCpyYcJdg3BFJIbBreZO9I9Rx2b28PdKjmkWo5Vm
 9BlMdca3TcuqnlSKKM9UObsw1rByW/h0+q1DLrZA3bgp+J1W19yM/IQJoTn7KfKuk+SpxIhsAnq
 z+dZScigvnrUzeoTZ6J8cEzRIu/FcZlII3CtttoHYVcUTSAuc6H9A8=
X-Received: by 2002:a17:903:2349:b0:2dd:c100:b2c6 with SMTP id
 d9443c01a7336-2ddc100b360mr85279055ad.49.1789958849031; 
 Sun, 20 Sep 2026 19:47:29 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc16b4a99sm25390025ad.5.2026.09.20.19.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:47:28 -0700 (PDT)
Message-ID: <7b5c7095-e086-45de-bdc2-9063e8229222@gmail.com>
Date: Mon, 21 Sep 2026 10:47:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] dt-bindings: display: verisilicon, dc: add support
 for nuvoton,ma35d1-dcu
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260918030125.315978-1-a0987203069@gmail.com>
 <20260918030125.315978-2-a0987203069@gmail.com>
 <ea18c92ce2af08a65bfd8834ea7f262d1bcb4bf2.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <ea18c92ce2af08a65bfd8834ea7f262d1bcb4bf2.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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


Icenowy Zheng 於 2026/9/18 下午 06:50 寫道:
> 在 2026-09-18五的 11:01 +0800，Joey Lu写道：
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
>>
>> Move the clocks/clock-names minItems to 4 and resets/reset-names
>> minItems to 1 at the top level, since that is the lowest count any
>> supported variant needs.  Add an allOf/if block that tightens the
>> constraint back up to the fixed 5-clock/3-reset topology required by
>> the existing thead,th1520-dc8200 compatible, and another one that
>> caps
>> the new nuvoton,ma35d1-dcu compatible at the 4-clock/1-reset count it
>> actually wires up.
>>
>> Restrict the same nuvoton,ma35d1-dcu if block to a single port@0,
>> since the DCUltraLite only has one output port.
> By the way, when will the MA35D1 device tree sources be updated? I saw
> a lot of drivers being merged but w/o corresponding DT nodes: sdhci-of-
> ma35d1, nuvoton-ma35d1-nand-controller, phy-ma35d1-usb2, rtc-ma35d1,
> spi-ma35d1-qspi, ma35d1_wdt.
>
> Thanks,
> Icenowy
We are currently reviewing several peripheral device tree updates, 
including USB/PHY, CAN, and other related blocks.

Once the core driver support is in place, we plan to do a more thorough 
review and update of the MA35D1 device tree
sources to ensure the corresponding DT nodes are properly added and 
aligned with the upstream drivers.

Thanks for your patience and feedback.
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   .../bindings/display/verisilicon,dc.yaml      | 51
>> +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>> index 919a900122012..e1e6a3a953646 100644
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
>> @@ -79,6 +84,52 @@ required:
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
>> +
>> +        ports:
>> +          properties:
>> +            port@1: false
>> +
>> +          required:
>> +            - port@0
>> +
>>   additionalProperties: false
>>   
>>   examples:
