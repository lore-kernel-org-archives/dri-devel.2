Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16649C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC5510EB4E;
	Tue, 30 Jun 2026 07:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QrPl1+xD";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE1910EAD9
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 07:08:13 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-37fc01881f2so2520928a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782803293; x=1783408093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tyLQLQryK7/S92ya5PLfuOu/W+JvCTVmwNrWVc0CbCI=;
 b=QrPl1+xDFwb8f9WqE9x8fkCPfdT88kT71vpDf2u/UbXDtkdbufyuWfOy5/V4XLYSA6
 oMYqv+0Z20tQuSxcK3ncgyhkjCTXD1Y1U3uMQxhMLMhH9VfarVbl9sUz18q9WlNb/h4h
 MReN9tm6QjFEDRBRzb1HBSMV8g9YqtUlC6w2eIKB9OKcvuSl+Cq2zaQrb6M0DETJ0Z+S
 DhlwZau2jim8DmEGt0Sh0cQzMII1WY54YDztADJZhBemTzqiERo/260BxDhyGpaZYrEN
 5mLhfbpf2cmS1w6LCLUrI6hsKocoBRAYAKCdXMMda/MIIC7X+4KdPRPlaQUVQrZcWE4t
 N4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782803293; x=1783408093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tyLQLQryK7/S92ya5PLfuOu/W+JvCTVmwNrWVc0CbCI=;
 b=HMQ2SwYgfDKoW23t1EDe5LJvpwbj/VkcG9m2J+mzdxFfuFN46HaDB7OqITxEt6yfLL
 3R4FHhrU6eUuS9u21eab0eh1lDRhTZWsaJxtFMwNgIZiejE3ANCwDY8plYAoxaOWOXHS
 TgbtC+g/+kNOu1k/bkx0S0RPkuzKCJHVY4t5Hp9VCroHcoDwXNDz87OQh9CQINLyDbhf
 vIE7YBcvXPEMZsBWaVLtKOVia5+ilwTxJOKmYziAnrxQbeeeri1fsPsVaV4+AJ9dgFp2
 V6pzDenFSQiVuK9sx35PpwzEaFH1VTG9ZvgCQowTthByBuu0BhzndcCwXvPD9IEGFilW
 5EOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ywhMUbm6lVJK9+2XE5GIddaCNsJIwiW4wx+XGk3IJhnGseUH21FEf/UFMe8tH8pdwoOrjROT9y90=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+wBhyLrgz/th3h7sz3C1T+/xePGnSsGvuOPRFwAGuxEWYj2h9
 FLQgwoYwgVWMujbGtrI6IWL7diXTL0aggqJu7FJITwOao8U/bDHytv5F
X-Gm-Gg: AfdE7cm9FFXJq/d1GTVZJ+qvVdheIofZD8Akkq6PGwWmOAtA4ogIhobr6iGu3wYS2jS
 GRzfiXyhtCHIFuc/gOzSC1TvwmAivsILQog2YomXPCtrSou1PnZL5l3NBtbtDPVcu0RsFCqy1mL
 c2UoQgcPrLdJEQcen0VfCwgq4wETA46tzYZNq347zKMZUFEuaRavD/Hnwow1nqgw3rn2v5+3Swk
 V7DZLAdbR3Ve0wntQz4n6hqTMtAba90+YGOWQXSoyxjchLxUn6peOQho8zUezir80Wy/oNmSVA2
 0Ig3QkFUc3fdFnPw07euneHwGMM2dcdli8Tov5YuwCK/XMuwMzYy6t6PNbuip5rInnKME6jARaT
 hnfFCt2e0LGnfbiJcOAh65HjufqpOPs+YjAOpwxEFIgVX4bbMrI6PmKqZqgajgk/ym/2HqxU7td
 r9VUI7/swLL0v9iQ+q/rp7FCU3iM6hHVx+s7cIKNPVvBmcKATC+JzKj0ZxHiNDXRDVpA==
X-Received: by 2002:a05:6a20:4393:b0:3bf:c28f:8afd with SMTP id
 adf61e73a8af0-3bfc5275c9cmr2386643637.31.1782803293270; 
 Tue, 30 Jun 2026 00:08:13 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9bb9fdbe64sm996296a12.0.2026.06.30.00.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 00:08:12 -0700 (PDT)
Message-ID: <54fd4b86-d978-4f21-8634-292ecbe484ed@gmail.com>
Date: Tue, 30 Jun 2026 15:08:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
To: Conor Dooley <conor@kernel.org>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 yclu4@nuvoton.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
 <e3fe23ddbc504879bd797bbaa595d3653fa139ff.camel@iscas.ac.cn>
 <20260626-astrology-mural-853d3860e048@wendy>
 <c0731801729713d35f97bec40ebc21cef31b72b5.camel@iscas.ac.cn>
 <20260626-everybody-epilogue-8fb298a54981@wendy>
 <9456bde5059bea3aac1ed64355e3f017dd9bd3e5.camel@iscas.ac.cn>
 <b3b7a0f8-93a8-4965-a2f3-3ca1552a25d6@gmail.com>
 <80ae28925a67b7bee3b8873db3c113111437e717.camel@iscas.ac.cn>
 <20260629-chevron-awhile-7cf456a768a0@spud>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260629-chevron-awhile-7cf456a768a0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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


On 6/29/2026 11:02 PM, Conor Dooley wrote:
> On Mon, Jun 29, 2026 at 01:31:46PM +0800, Icenowy Zheng wrote:
>>>>>>>>>> +
>>>>>>>>>> +        resets:
>>>>>>>>>> +          minItems: 1
>>>>>>>>>> +          maxItems: 1
>>>>>>>>>> +
>>>>>>>>>> +        reset-names:
>>>>>>>>>> +          items:
>>>>>>>>>> +            - const: core
>>>>>>>>> This is just maxItems: 1.
>>>>>>>> Well the implicit rules of DT binding schemas are quite
>>>>>>>> weird...
>>>>>>> I don't think it is that strange, as the binding has
>>>>>>>     reset-names:
>>>>>>>       items:
>>>>>>>         - const: core
>>>>>>>         - const: axi
>>>>>>>         - const: ahb
>>>>>> Ah does the list constraint the order of items? If it
>>>>>> constrains
>>>>>> the
>>>>> It does, yes.
>>>>> Alternatively, using an enum permits free ordering.
>>>> Ah in this case this should be converted to an enum, I think.
>>>>
>>>> Should I send a patch for converting it?
>>>>
>>>> Thanks,
>>>> Icenowy
>>> Thank you all for the detailed review and discussion, it really
>>> helped
>>> clarify the right approach.
>>>
>>> Since I will supply all four clocks with the same phandle for
>>> core/axi/ahb,
>>> and only one reset "core" for MA35D1, the ordering constraint in the
>>> `items` list is not a problem, "core" is already the first entry.
>>> There
>>> is no need to convert to an enum.
>>>
>>> Regarding the clock situation for the MA35D1: I agree with supplying
>>> all
>>> four clocks (core, axi, ahb, pix0) in the devicetree, even though the
>>> MA35D1 clock controller gates core/axi/ahb with a single bit. The DT
>>> will
>>> use the same clock phandle for core, axi, and ahb:
>>>
>>>     clocks = <&clk X>, <&clk X>, <&clk X>, <&pix_clk Y>;
>>>     clock-names = "core", "axi", "ahb", "pix0";
>>>
>>> This correctly models the hardware topology. Since all three names
>> No, this doesn't correctly model the hardware topology -- this will
>> lead to clk_get_rate() return the rate of DC core clock when checking
>> the AXI clock rate, which is problematic because both clocks are
>> limiting the performance of the DC.
You are right. The current MA35D1 clock driver does not correctly reflect
the real AXI/AHB clock rates, and I think it needs a more comprehensive
review and rework. I will address this in a separate clock driver patch
series in the future.

For this DRM patch series, the AXI and AHB clocks are shared system bus
clocks fixed by the SoC clock tree and are not managed by the display
driver. The driver does not query their frequencies for mode validation
or bandwidth decisions. Therefore, driver correctness is independent of
the reported AXI/AHB clock rates, meaning it will remain unaffected when
the clock driver is later reworked.
>>> resolve
>>> to the same underlying clock node, the CCF's standard enable
>>> refcounting
>>> handles the shared gate correctly without any custom implementation
>>> needed.
>>> I will also revert the change in patch 4/7 that made axi and ahb
>>> clocks
>>> optional, since they will now always be provided in the devicetree.
>>>
>>> Regarding moving `resets` and `reset-names` to the top-level
>>> `required:`,
>>> I will wait for Icenowy's patch to land before sending v6 to avoid
>>> duplicating the work.
>> The patch is sent.
Got it.
>>> In v6 I will update patch 1/7 with:
>>> - Update the subject to "dt-bindings: display: verisilicon,dc: add
>>>     support for nuvoton,ma35d1-dcu"
>>> - Lower `clocks`/`clock-names` `minItems` to 4 at the top level
>>> - Remove the `thead,th1520-dc8200` conditional block entirely
>> I think this conditional block will still be needed, because it will
>> need to constrain the minItems to ensure all clocks / resets are
>> populated.
> Correct. When the outer constraints are relaxed to deal with the new
> device the conditional block for the th1520 becomes required. Or having
> an else, but if all devices are likely to be different in terms of
> configuration specific conditional blocks is better.
Understood. I will keep the `thead,th1520-dc8200` conditional block.
