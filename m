Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56035C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D3310E6ED;
	Mon, 29 Jun 2026 07:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TRE0/4QN";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378EF10E002
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:47:13 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-37fc02e660bso881257a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 20:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782704833; x=1783309633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z4glFEoTlSdEvWgu5Qz9SrofqHmqDCDT1GO9md08oew=;
 b=TRE0/4QN6MWjbt5nhD1nWjNnwduh3NNoDuHmO/LSwTSvNNTvBxnL+/nzTelQYFVYxt
 WniGDlVxbD++hPcbiQwSJt5bX4ITkQsmopREtDJEytvIXODCi4nLnVE6YxSeeouXoy1a
 3Xt0BbuyprSYLRqtfN7ZQFVnpmrv6lQI3Bf08D/HJTaHw3H/UYpf7BdlIgJ8nafTkHeh
 ELOvAx+tmdG3lHGQbPUWyYc3b/qUEpwJuDm1XCtBu+KfR0kFvNgLtiIFI0QPpdfI2a5b
 w4YUH2jbM4R0aW41oqpsYPJDa9QuJ/nPmXBU6cPA4Wpj0Cm94fpQMuEg67bvFLRbN6d5
 45Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782704833; x=1783309633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4glFEoTlSdEvWgu5Qz9SrofqHmqDCDT1GO9md08oew=;
 b=cqb139iFjbJL9vqX2qLpzYMmb+qbcxlVqJyUCFwk/VDkQrTKGqWguE8zEUIlfrHtq/
 YNkCe6vfHUrBMZiDAxeSxZvY9W/gRoO12vsUBFR98z43sQtcjhomcyhsWhHgfRU9mxXz
 1GZvRfEY2iVW5lsZEruNhkUwkLiQk4qQ9EDDjUHNc6vCSkUW+u4C6REq5qINuhsTuS83
 Qb2SeFo3paErZt8vWViPRhMeiIZNBBOxSnUPO8u4wohfIdT6v/KUf6LdtgX7/soocwdW
 dL89aExl7dr3GwSNUbpev4ZHtJZPDb3GYRiBAiOr3YcppW46qQU6qduI6CTc4ny0sMQz
 fHcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOemfDcCXaoTZhCqhylvDVYxGZgKyYe3xmke2RMVc3gQFKwM5G9QyOpaLIqVcxJvJvz8yJkCmiWkA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMEn8Yz0IfKd0V7/3h2w0WBSkqGmd3qsHPOTKfV6DYwEK/REQE
 7LLN/HL4AydSwH3Wk5gVzFcoxWwExvhd+RufQtqhjimaskPRN/T4t9ap
X-Gm-Gg: AfdE7cnwfKDsy7y9Y6MdlY93O8sseZ2Ypynb1p2A7vDROGphh+ywYMRaNi8AELC/IoP
 cga2ez0ilj4doEwAxIPgw9dCpXdFKElvrsawMpr/KK6moKZmNJu/CrPoFrF0QWAJXdLQeWS9OtM
 xTz5zk0NCFFs15XuIGx8AuDN8SLmxlcEfUv7HitjaKKjN6opzFjJlxpMCY1VeBATbNFarCQNjPR
 VlvR/881Ay2a835gtmrs8PNorGuGkPkbr/4bjzC0lBsGG28qFIJtO/FkZ4xnZhqWfRXVCXz6vRi
 tZ01/vwNm8uh0mc0NBeumzHaDqcGdzNo94KcK3ppOYg2jk3gVovf2N13xJXb+NmUA+hLuQKNf3v
 +hcCBHZ3H6LZApMpyKyrl3elQTMkBNv6HcWWXriOHfyqO5YgjEw1TfVhRKKDYtWVZnl3G6Z6GyJ
 nG0q3MmB2ibCuFkqR4Yped67wFSWbe5trO1bMDGn2ZShIJHFNynJKfsfBS9z1c6RE35g==
X-Received: by 2002:a17:90b:28d0:b0:37f:9ce3:ca92 with SMTP id
 98e67ed59e1d1-37f9ce3cb4emr6630306a91.27.1782704832538; 
 Sun, 28 Jun 2026 20:47:12 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37eaff87f61sm4687705a91.17.2026.06.28.20.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 20:47:11 -0700 (PDT)
Message-ID: <b3b7a0f8-93a8-4965-a2f3-3ca1552a25d6@gmail.com>
Date: Mon, 29 Jun 2026 11:47:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
 <e3fe23ddbc504879bd797bbaa595d3653fa139ff.camel@iscas.ac.cn>
 <20260626-astrology-mural-853d3860e048@wendy>
 <c0731801729713d35f97bec40ebc21cef31b72b5.camel@iscas.ac.cn>
 <20260626-everybody-epilogue-8fb298a54981@wendy>
 <9456bde5059bea3aac1ed64355e3f017dd9bd3e5.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <9456bde5059bea3aac1ed64355e3f017dd9bd3e5.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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


On 6/26/2026 5:33 PM, Icenowy Zheng wrote:
> 在 2026-06-26五的 10:26 +0100，Conor Dooley写道：
>> On Fri, Jun 26, 2026 at 05:00:35PM +0800, Icenowy Zheng wrote:
>>> 在 2026-06-26五的 08:19 +0100，Conor Dooley写道：
>>>> On Fri, Jun 26, 2026 at 01:27:21PM +0800, Icenowy Zheng wrote:
>>>>> 在 2026-06-25四的 17:33 +0100，Conor Dooley写道：
>>>>>> On Thu, Jun 25, 2026 at 05:44:43PM +0800, Joey Lu wrote:
>>>>>>> +allOf:
>>>>>>> +  - if:
>>>>>>> +      properties:
>>>>>>> +        compatible:
>>>>>>> +          contains:
>>>>>>> +            const: thead,th1520-dc8200
>>>>>>> +    then:
>>>>>>> +      properties:
>>>>>>> +        clocks:
>>>>>>> +          minItems: 5
>>>>>>> +          maxItems: 5
>>>>>>> +
>>>>>>> +        clock-names:
>>>>>>> +          minItems: 5
>>>>>>> +          maxItems: 5
>>>>>> All the maxItems here repeat the maximum constraint and do
>>>>>> nothing.
>>>>>>
>>>>>> Since you didn't change the minimum constraint at the top
>>>>>> level,
>>>>>> your
>>>>>> minItems also do nothing.
>>>>>>
>>>>>>> +
>>>>>>> +        resets:
>>>>>>> +          minItems: 3
>>>>>>> +          maxItems: 3
>>>>>>> +
>>>>>>> +        reset-names:
>>>>>>> +          minItems: 3
>>>>>>> +          maxItems: 3
>>>>>>> +
>>>>>>> +      required:
>>>>>>> +        - resets
>>>>>>> +        - reset-names
>>>>>> Both conditional sections have this, but the original binding
>>>>>> doesn't
>>>>>> require these for the thead device. This is a functional
>>>>>> change
>>>>>> therefore and shouldn't be in a patch calling itself
>>>>>> "generalise
>>>>>> for
>>>>>> single ended variants".
>>>>> Well yes they're required.
>>>>>
>>>>> Should I send a patch adding the `thead,th1520-dc8200` part of
>>>>> the
>>>>> schema?
>>>> If you mean the code above, no. Adding a conditional section when
>>>> there's only that compatible doesn't make sense.
>>>>
>>>> What you could do is just add it at the top level though, which
>>>> would
>>>> also benefit this patch since it'd not have to be conditionally
>>>> added
>>>> for the new nuvoton device.
>>>> Just note in your commit message about what the ABI impact of the
>>>> change
>>>> to required properties is (effectively nothing because it's
>>>> optional
>>>> in
>>>> the driver and the only user has the properties).
>>> Okay, I will craft such a patch and send it.
>>>
>>>>>>> +
>>>>>>> +        resets:
>>>>>>> +          minItems: 1
>>>>>>> +          maxItems: 1
>>>>>>> +
>>>>>>> +        reset-names:
>>>>>>> +          items:
>>>>>>> +            - const: core
>>>>>> This is just maxItems: 1.
>>>>> Well the implicit rules of DT binding schemas are quite
>>>>> weird...
>>>> I don't think it is that strange, as the binding has
>>>>    reset-names:
>>>>      items:
>>>>        - const: core
>>>>        - const: axi
>>>>        - const: ahb
>>> Ah does the list constraint the order of items? If it constrains
>>> the
>> It does, yes.
>> Alternatively, using an enum permits free ordering.
> Ah in this case this should be converted to an enum, I think.
>
> Should I send a patch for converting it?
>
> Thanks,
> Icenowy
Thank you all for the detailed review and discussion, it really helped
clarify the right approach.

Since I will supply all four clocks with the same phandle for core/axi/ahb,
and only one reset "core" for MA35D1, the ordering constraint in the
`items` list is not a problem, "core" is already the first entry. There
is no need to convert to an enum.

Regarding the clock situation for the MA35D1: I agree with supplying all
four clocks (core, axi, ahb, pix0) in the devicetree, even though the
MA35D1 clock controller gates core/axi/ahb with a single bit. The DT will
use the same clock phandle for core, axi, and ahb:

   clocks = <&clk X>, <&clk X>, <&clk X>, <&pix_clk Y>;
   clock-names = "core", "axi", "ahb", "pix0";

This correctly models the hardware topology. Since all three names resolve
to the same underlying clock node, the CCF's standard enable refcounting
handles the shared gate correctly without any custom implementation needed.
I will also revert the change in patch 4/7 that made axi and ahb clocks
optional, since they will now always be provided in the devicetree.

Regarding moving `resets` and `reset-names` to the top-level `required:`,
I will wait for Icenowy's patch to land before sending v6 to avoid
duplicating the work.

In v6 I will update patch 1/7 with:
- Update the subject to "dt-bindings: display: verisilicon,dc: add
   support for nuvoton,ma35d1-dcu"
- Lower `clocks`/`clock-names` `minItems` to 4 at the top level
- Remove the `thead,th1520-dc8200` conditional block entirely
- Keep only the `nuvoton,ma35d1-dcu` conditional block, using only
   `maxItems: 4` for clocks/clock-names and `maxItems: 1` for
   resets/reset-names to tighten the top-level constraints

BR,
Joey
>>> order, it partly breaks the intention of having names; if it does
>>> not
>>> constrain the order, it needs to be clarified that the required 1
>>> reset
>>> is core instead of the other two.
>> Given the discussion we're having on the clocks, I wonder if this is
>> also an oversimplification and the IP has three resets inputs hooked
>> up
>> to one output of the reset controller (or 3 outputs controlled by one
>> bit..).
