Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E791C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970BA89919;
	Wed, 12 Aug 2026 12:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="mgeZRaea";
	dkim-atps=neutral
Received: from ixit.cz (ixit.cz [84.42.129.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BA889919
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:53:29 +0000 (UTC)
Received: from [172.16.124.192] (ip-78-44-13-22.bb.vodafone.cz [78.44.13.22])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 9BB6953415E8;
 Wed, 12 Aug 2026 14:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1786539207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QFoEkDseBygLJup+3sVpOMkFCrsRQiH8l8iJu4zhQzQ=;
 b=mgeZRaeagXcK9JmjiyQlxe7zXAN6/g5kCxQ5Ea843c0XJM3U8NfllQ7S2bByouV14Ehka4
 eO50lXjSal+G3IUBT+xy5a/0OI/YlY1hCTIwTuquwP4+tkIH4tjRM7WtK9meQmPoP1v3yt
 hCYsMS3aevfoIU6V9bPlOlkiA8CVZ+8=
Message-ID: <e2b1c037-fd3a-4c0a-912f-fccc2c5ab843@ixit.cz>
Date: Wed, 12 Aug 2026 14:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add bindings for Novatek
 NT37703
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Esteban Urrutia <esteuwu@proton.me>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260811-nt37703-bup-v1-0-34ad42b064a3@proton.me>
 <20260811-nt37703-bup-v1-1-34ad42b064a3@proton.me>
 <8c3e9384-7964-4d03-a3a9-de15d26de822@ixit.cz>
 <58d7ddd4-1488-4c34-be85-6345138aa238@proton.me>
 <7097b617-90be-492d-9637-4a2a101379e0@ixit.cz>
 <05d2ad33-a681-41e4-87f7-e3aaeb5428a8@linaro.org>
 <803e354d-55b9-4904-a4a0-9eeefa0c6ffd@ixit.cz>
 <19e120fc-4b60-4188-86d8-cb3705a5fd33@linaro.org>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <19e120fc-4b60-4188-86d8-cb3705a5fd33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/08/2026 14:22, Neil Armstrong wrote:
> On 8/12/26 14:15, David Heidelberg wrote:
>> On 12/08/2026 13:52, Neil Armstrong wrote:
>>> On 8/12/26 10:46, David Heidelberg wrote:
>>>> On 12/08/2026 07:21, Esteban Urrutia wrote:
>>>>> On 8/11/26 9:05 AM, David Heidelberg wrote:
>>>>>> Hi Esteban,
>>>>>>
>>>>>> Usually the used pattern is vendor,ddic+panel-model
>>>>>>
>>>>>> novatek,nt37703-motorola-bronco
>>>>>>
>>>>>> ...but motorola bronco isn't the model of the panel.
>>>>>>
>>>>>> My recommendation - look at some video of screen replacement, stop at moment
>>>>>> when FLEX cable from panel is visible and that's where the panel model 
>>>>>> usually is.
>>>>>
>>>>>
>>>>> I somewhat doubt the panel model would be located in the FPC cable.
>>>>> I did search anyway but didn't find anything of interest. And I'm not
>>>>> willing to risk damaging the display flex or the battery of my
>>>>> development device just for a possibility either.
>>>>
>>>> No-one asks you to disassemble the device :)
>>>> Sadly, I haven't found any video doing display replacement either.
>>>> In worst case such as this I assume it make sense keep the phone model in 
>>>> the compatible until panel codename is found.
>>>>
>>>>> For the compatible pattern I used the implemented pattern for the
>>>>> NT36523 TDDI, which is also used for other ICs such as the RM69380.
>>>>>
>>>>> So, I believe it should be okay to leave the compatible as is.
>>>>
>>>> I would like to hear a word from Neil first. In similar cases like this 
>>>> would make sense to have one way defining these compatible strings used in 
>>>> phones.
>>>>
>>>>
>>>> bit I missed in the review the part:
>>>>
>>>> +            compatible = "motorola,bronco-tianma-v2-nt37703", 
>>>> "novatek,nt37703";
>>>>
>>>> Unless the driver is able to auto-detect the connected panel (unlikely), 
>>>> novatek,nt37703 doesn't make sense. The DDIC without the panel is useless.
>>>>
>>>> For example, in sdm845-oneplus-fajita and enchilada, we have the generic 
>>>> compatible because it was introduced before, so it's kept for compatibility 
>>>> reasons. There is no need to do that here.
>>>
>>> Yeah today the norm is to add the ddic as second compatible entry so the 
>>> first compatible just describes the pane, so here it should be:
>>>
>>> compatible = "motorola,bronco-tianma-v2", "novatek,nt37703";
>>
>> So let's me present a situation which can happen, let say I'll be upstreaming:
>>
>> DDIC (novatek,nt37700) + panel (samsung,amb630qy).
>>
>> For the example I choose samsung,amb630qy because here the panel has phone 
>> model in it, which avoids the possible issue I'll be describing with this schema.
>>
>> Vendor can pair this panel with different DDIC. Thus it would be
>>
>> compatible = "samsung,amb630qy", "novatek,nt37700"; // new one
>> compatible = "samsung,amb630qy", "novatek,nt37703"; // existing
>>
>> The reality the driver picks only the first compatible, and that's all causing 
>> to load wrong driver now.
> 
> No, the core will pick the first compatible that matches, so...
> 
>>
>> Solution here would be differentiate between
>>
>> a) DDIC + panel
>> b) module name (consisting DDIC + panel).
>>
>> We could say module is motorola,bronco-tianma-v2 and contains [ DDIC + unknown 
>> panel ], which doesn't even have to be mentioned in device-tree.
>>
>> While it may seems I overthinking, in this case it doesn't matter that much, I 
>> already have patchsets for DDIC which can be combined with three types of 
>> panels (and using different schema) and I would like to have good solution for 
>> longterm contributions and development.
> 
> ... in theory we could have:
> 
> compatible = "samsung,amb630qy", "novatek,nt37700"; // new one
> compatible = "samsung,amb630qy", "novatek,nt37703"; // existing
> 
> and drivers would only have:
> 
> "novatek,nt37700"
> 
> and
> 
> "novatek,nt37703"
> 
> as compatible and then a separate match table with :
> 
> "samsung,amb630qy" and "samsung,amb630qy" which associates with the panel data.
> 
> If it doesn't match, return -ENODEV and it would work like before,
> 
> I mean it's valid, it's a matter of implementation, if the same module can have
> different DDIC then it should be described like that.
> 
> In this case, the bindings should be for the module and not for the DDIC.

Definitely make sense in the context. This would mean I'll need to adapt my 
patchset to-be-sent :)

Btw the disccusion slowly mentally gets me closer to the Camera module model, 
where you have multiple components such as

module (sunny-XY) -> camera (sony,imx519)
                   -> focus (dongwoon,dw9714)
                   -> OIS
                   -> fixed components as optics

where as we have here only

"module" (motorola-bronco-tianma-v2) -> DDIC (nt37703)
                                             ↕
                                      -> panel (unknown)
                                      -> touchscreen (sometimes, depend on the
                                                      phone build)

Sometimes init sequences and stuff depends on each other, thus touchscreen is 
part of the module in some cases.

Would it make sense to somehow model this into DT?

Since we doing all the stuff in the panel node, it could be something like

display@0 {
     compatible = "novatek,nt37703"; // first thing we interact with here
     module = "motorola-bronco-tianma-v2"; // DDIC driver picks the module data

     vddio-supply = "...";
     backlight = <&pmi8998_wled>;
     ...

     // I already have combination where two panels has different supplies
     // Samsung S9 vs Pixel 3 XL. One wiring is over DDIC it seems, second
     // directly to the panel
     panel { // REAL panel node
         compatible = "samsung,ams622xy" // maybe as a docs?
         vddneg-supply = <&lab>;
         vddpos-supply = <&ibb>;
     }
}

Just dumping my brain, feel free to ignore if it's complete nonsense.


David



> 
> Neil
> 
>>
>> What do you think?
>> David
>>
>>
>>>
>>> Neil
>>>
>>>>
>>>> Thanks
>>>> David
>>>>
>>>>>
>>>>>> David Heidelberg
>>>>>
>>>>>
>>>>> Regards,
>>>>> Esteban
>>>>>
>>>
>>
> 

-- 
David Heidelberg

