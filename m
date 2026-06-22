Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E36CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C7610E9E1;
	Tue, 23 Jun 2026 08:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOXSdL+N";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DA710E429
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:28:55 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8453bcf7276so2064542b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 19:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782095335; x=1782700135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gu0ES1O9klC+0ewrJmA1SFEVoTTP2kjyfbea71Glr8c=;
 b=YOXSdL+N7gbHgKgGPq2E2inD3SFDBkkuqovo2Y1a4hZTTr+OEBJYmCEhD3ctH+BZKi
 LStQ3FOrB+1ZDaL0MbOsjg0zvdonnw5go7cUGtdxv5B4ZoeaG2qSF1G0TaxMDED7Vx46
 bHMj15yRBV1qtGzSsia8fJ5n+x8+kKXvD7DgHFuoXb65jmlqZA+HQmF8Wa2uLvPlg09k
 2KDN/I221SKPFC0dMJwtWTCVfNUrCuZY1iTk908NL/2+p5uuwe2bXL9fJudUiPpTpqw0
 ncWpuMDStIqgq4CtVBzokCEXORxIdnfuXcWP4k/xmvpFruTczOKL9Nk8rRTHv69dcu5q
 jPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782095335; x=1782700135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gu0ES1O9klC+0ewrJmA1SFEVoTTP2kjyfbea71Glr8c=;
 b=Cut4ZA8GPX1OYO0VXmDkmqWv2En3W/dxKWsUNANnQLuWgHpr0/no/B0y3nskrcBxtn
 QlhJGfJaeV6LZkZbXSY8H2e2vLCJOwWczBuwo7wDmgU1Yr1bKZHicjk6saf+ulWO5/7T
 fcjaOzQGLdWq1m6KDzcBLJF4q+w/fLWYv9MhPqm6SkoiFcHa5NW4rZ0SrzVosksDxs/D
 RLo1cVBqXBuFrRpi+U13dKu0o4hlmW6Erwm84574lsubXpSUrsUMFSvd8DKWaLhqAl2u
 rEdrD9UPh24lvS9bDZlCGidvi3QNrG/P3KL10ScOIlW2u4unsB8q0qu6a6p6lKw4zwKz
 QJBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qhY6Qufc+Ns3qiHXEcfzyDV+T5R/JAIvlEMWJ035AWf+w+Kz3x+VdWKgW4o2I5lV/AAPHuQKbzus=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBEmCebQxRizJhoVgANSygZMEnVXLnmA2sNmMztoTWT7SkrPXW
 5ckQ+R2ws0lFwnh5Y0fPLLVQV7ZluD3ZGtzHHCMXzx0Dhu+LYoMMVHjws1ha/g==
X-Gm-Gg: AfdE7clHRw/cL+NaKfoCRkomAhVQ7QG0ALhO9KURjbvvBMWZHMrXa0rqXmAbXOWzxcL
 EsO+lWs9fuSNDzCUS0ADaPuU4WHC8BvQyk/9Yt9qww3bqhg37FJxvHJPa9slY3Hp79L2/oil0no
 0aF//i9clW1dY8NQYmVRaB3XidcclfOH4o8pT3UaeK37yWwj2E6q/8gXjsbhN89GYq+nc4mCSF1
 3/uUg5OtNrXJV6S9VAOzwRgOdvAV9RNs9zjDkg4OKNN3hTdGXAVFt4UoDSSyHTQp7XvGatr42VS
 1uX7CVrMrcbBpVrr38zRKfjSupSaGqWRxX1ra7mo75AthKZaIA/7seqnRcWNUgs2Nt/3K/71tLO
 A0SmhDuYwrMDUQboQL8ysy9RD4BEQrRB01p0ICW/a6J5jL2u8o64x4SQHxWXtMsv+3Q7a7Wog6H
 ObYTQdggPKbCoIn+bXvUaIl6wtvq/b7nAyOI5SeTXZFm3wn6Un2BhnVpEjZZUneXRgPTwW4ZgUD
 MuC
X-Received: by 2002:a05:6a00:4104:b0:845:33e1:9664 with SMTP id
 d2e1a72fcca58-845508ff81bmr13600889b3a.40.1782095334770; 
 Sun, 21 Jun 2026 19:28:54 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564ee3dc2sm5573489b3a.58.2026.06.21.19.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2026 19:28:54 -0700 (PDT)
Message-ID: <98725dea-9bfd-43bb-8bce-e314f821d081@gmail.com>
Date: Mon, 22 Jun 2026 10:28:46 +0800
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
 <6d3e3121-22f2-4c59-9678-df2f57ff4d31@gmail.com>
 <b08277e8a9350f6c68c9774b1b6185b1eb71cd1e.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <b08277e8a9350f6c68c9774b1b6185b1eb71cd1e.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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


On 6/18/2026 6:24 PM, Icenowy Zheng wrote:
> 在 2026-06-17三的 18:25 +0800，Joey Lu写道：
>> On 6/15/2026 4:19 PM, Icenowy Zheng wrote:
>>> 在 2026-06-15一的 14:49 +0800，Joey Lu写道：
>>>> The existing schema hard-codes the five-clock/three-reset/dual-
>>>> port
>>>> topology of the DC8200 IP block, preventing reuse for single-
>>>> output
>>>> variants such as the Verisilicon DCUltraLite used in the Nuvoton
>>>> MA35D1
>>>> SoC.
>>>>
>>>> Rework the schema so that variant-specific constraints are
>>>> expressed
>>>> via
>>>> allOf/if blocks:
>>>>
>>>> - Add nuvoton,ma35d1-dcu to the SoC-specific compatible enum.
>>>> The
>>>>     generic verisilicon,dc fallback remains the driver-binding
>>>> string.
>>>> - Move clock and reset items descriptions into the per-variant
>>>> allOf/if
>>>>     blocks; keep only minItems/maxItems at the top level so the
>>>> base
>>>> schema
>>>>     accepts all variants.
>>>> - Restore full items lists for clock-names and reset-names at the
>>>> top
>>>>     level with minItems so the names are validated against the
>>>> descriptions.
>>>> - Keep ports in the global required list and keep
>>>> additionalProperties: false.
>>>> - Add an allOf/if block for thead,th1520-dc8200: five-clock
>>>> (core,
>>>> axi,
>>>>     ahb, pix0, pix1), three-reset (core, axi, ahb), required
>>>> resets.
>>>> - Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core,
>>>> pix0),
>>>>     one-reset (core), required resets.
>>>>
>>>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>>>> ---
>>>>    .../bindings/display/verisilicon,dc.yaml      | 80
>>>> +++++++++++++++++--
>>>>    1 file changed, 73 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>>> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
>>>> index 9dc35ab973f2..0c41286b8223 100644
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
>>>> @@ -26,14 +27,12 @@ properties:
>>>>        maxItems: 1
>>>>    
>>>>      clocks:
>>>> -    items:
>>>> -      - description: DC Core clock
>>>> -      - description: DMA AXI bus clock
>>>> -      - description: Configuration AHB bus clock
>>>> -      - description: Pixel clock of output 0
>>>> -      - description: Pixel clock of output 1
>>> Clock descriptions should still be in the global part instead of
>>> the
>>> per-compatible part.
>>>
>>> In the per-compatible part, clock-names should be constraint for
>>> SoCs.
>> I will move the `items:` clock descriptions back into the global
>> `clocks:` property, covering all five possible clocks. In the
>> per-compatible sections I will remove the description items and only
>> constrain `clocks: minItems/maxItems` and `clock-names:
>> minItems/maxItems`; for nuvoton,ma35d1-dcu I will additionally
>> override
>> `clock-names: items:` to the two names actually used (core, pix0).
> Yes, this should be the correct practice, although I wonder whether the
> minItems and maxItems properties are needed globally (because these two
> seem to have default implicit value).
>
> BTW the MA35D1 manual in fact shows 4 clocks for "DCUltra" in the clock
> tree, maybe the DT binding needs to be reconsidered?
>
> Thanks,
> Icenowy
I will drop the global `minItems`/`maxItems` on `clocks` and 
`clock-names` in v5, as they are redundant with the implicit defaults.

Regarding the 4-clock question: the TRM clock tree diagram does show 
four paths reaching DCUltra (display core mux/gate, AXI ACLK, AHB HCLK, 
and the pixel clock divider). However, the MA35D1 hardware provides only 
one software-controllable enable bit (SYSCLK0[26]) that gates the core 
clock together with the AXI and AHB bus clocks through shared ICG cells; 
there are no separate register bits for the bus clocks alone. Due to 
this hardware design constraint, the `clk-ma35d1` driver is 
intentionally designed to register only three DCU-related CCF nodes: 
`dcu_mux` (ID 61, an internal routing mux), `dcu_gate` (ID 62, the 
single gate at SYSCLK0 bit 26), and `dcup_div` (ID 63, the pixel divider 
from VPLL at CLKDIV0[18:16]), with no independent AXI or AHB gate 
entries for DCU. Since the DT binding can only reference clock handles 
that the platform clock driver actually provides, the MA35D1 binding 
will remain at two clock entries: "core" mapped to `DCU_GATE` and "pix0" 
mapped to `DCUP_DIV`.

Thanks.

>
>>>> +    minItems: 2
>>>> +    maxItems: 5
>>>>    
>>>>      clock-names:
>>>> +    minItems: 2
>>>> +    maxItems: 5
>>>>        items:
>>>>          - const: core
>>>>          - const: axi
