Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BF1C79FAC
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548C610EA3B;
	Tue,  8 Sep 2026 07:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dhffcqlg";
	dkim-atps=neutral
Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D26B10E054
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 23:27:27 +0000 (UTC)
Received: by mail-oi2-f5.google.com with SMTP id
 5614622812f47-4b3759b7ff0so1488760b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 16:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788823646; x=1789428446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S2mXpnCZ25GxwnmGohlXqYGxtFFG4TCx9pnjWCRTcOc=;
 b=DhffcqlgyYvB4j/fxt6iQblD+Ft9yG7mUAUtLZtq8nVKde0OR4Z7b2Ft1ZSyztFbJF
 gBVx7IktsidnAkRc4/zwocbhLM9dLzehwsYXwo06OUhz5NA+RWns/QC3yMVntQavjYpx
 pBCHA3fFjg/do17zwmUMU4iXv3SdzAItwKaZbUHtrGYay18A5LkgpoUSZLX97JNMFElu
 hPCUbWsoARlrTm1eWwo3W3fTmYpjSwV4ySXBkcL6wOm9CaKM8PHK81DDPJHlvl4CGh4v
 h7k2S98rOQpFuBlNyrAYIukuU3YufX8OvY2tTmO2ZNEVYwxodCLwMXbLNf9gbBTOf+TE
 UfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788823646; x=1789428446;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S2mXpnCZ25GxwnmGohlXqYGxtFFG4TCx9pnjWCRTcOc=;
 b=kkB9/7TT6d5Pb0bwSGXSpODwHzRgYRLlHR3oWNmk2oudsIcxeV0bC5xC4zrbpjPg/M
 ZiSjIrFCWN4QnrHIEOpduWmlwxiu4vdwN1fE1FaP6ORBO6mEoqI8QTgjLy+JJqJcY8X6
 LK8xavRG7g/R9cmr5n/HuLpZ25y3kkiYLTKVlUi+gxTWqdFBgaxZpi62yp/QpMqzhlST
 kd7/bvwbeqOSg14FykH18D0RguedJxbWR0Kzb3RBGO1fwf//mDA13OiLJIoWvS324FJn
 BAZ1Xm+dhFdJ8M1Yll3kn1xs2Mnf24Nu7vT6CPtWV8EtYHnMMR16FDIyh2ET0hMXmXPw
 qHww==
X-Gm-Message-State: AFuF++nWFFfj3pjUQg9v3xW19nD/A7+ReLED8EgxEarihj6P2AFUNyp8
 vVrGlw0uhSRMsBvGc7IjZx1IFo0M896GngGzZ4dLddL3Zo8/oWo8EX9e
X-Gm-Gg: AYBFou2dkAF4Tyj4r4V2/rltytsIWjXggemFOtEbTXnMjCHXDdbNk+nlySESb9C79X+
 b+EKJY1+mFjXTrIisyPr185+79y/FPADMfMpVoTEpRDOVpfT8XOK91/6YQLvKQJ2Y3etwouyhqF
 tmebytUKJFW3ElvrY0sAvjOhPOOzRRmBShJxb4M+dhlkNVNGBiYAJYA2UODNZAxkjWyFCQke9WI
 LyVxs4RW8+OOUwSLQHkOfqAmplrfarsn2nA54dZOzkiZUrPvVnT0xcwl1Qh7VvExzLh62yvjT8M
 qpH03bO0CVi5LyNfgametmX6twsrWqAeydeF7jS4GP8SiUHVouRSTnriIDE9abNOZ6ggQlK6Qps
 5dhb6oxBQUL4PGDnafUgbBS+BW04tAJtfNsLnol43V0UftENT+++WDZafFEarEVG+HPHhLvaZ2T
 5N8TMg8rG1eSbrvdvwaajmG5bN9M5cJsEKBs/bNcXDD5T9v6PaEPgAcs80KwMxaN6RI2DBllgYQ
 evr+Uk=
X-Received: by 2002:a05:6808:e8b:b0:4b9:a829:f00a with SMTP id
 5614622812f47-4b9a829f91dmr13256254b6e.22.1788823646304; 
 Mon, 07 Sep 2026 16:27:26 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b96babc2c3sm13310503b6e.0.2026.09.07.16.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 16:27:24 -0700 (PDT)
Message-ID: <668b6dce-32f1-478b-b78b-06f8b5d7e5e8@gmail.com>
Date: Mon, 7 Sep 2026 18:27:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Novatek NT51021 DSI panel IC driver
To: Nickolay Goppen <setotau@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
References: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
 <20260907060129.120497-1-ryanbrue.dev@gmail.com>
 <54719b3e-d882-4b0c-b477-1e12dcf65133@mainlining.org>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <54719b3e-d882-4b0c-b477-1e12dcf65133@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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


On 9/7/26 1:42 AM, Nickolay Goppen wrote:
>
> 07.09.2026 09:01, Ryan Brue wrote:
>> One question on the binding, which is as much about my patch as yours.
>> Where does "boe,tv101wum-nx0" come from? Xiaomi's panel dtsi
>> (dsi-panel-nt51021-boe-10wu-video.dtsi) gives only
>>
>>      qcom,mdss-dsi-panel-name = "NT51021_BOE_BOE10";
>>
>> with no part number, and the register sequence in your driver matches
>> that file byte for byte. TV101WUM-NX0 is a real BOE part, and its
>> datasheet active area of 216.576 x 135.36 mm agrees nicely with the
>> 135 x 216 in that dtsi, so the attribution looks reasonable. But if it
>> is inferred rather than read off the panel or a BOM, it may be worth
>> saying so in the commit message, or naming the compatible after the
>> board the way panel-novatek-nt36523.c does for
>> xiaomi,elish-boe-nt36523.
>>
>> I ask because my module has no identity I can establish at all. It
>> answers no DSI read, DCS or generic, before or after sleep-out; the
>> vendor kernel and bootloader name it only "BOE", chosen from two board
>> ID straps; and its vendor-declared physical height is arithmetically
>> impossible, since 1200/136 and 1920/221 disagree by 1.5%. So I am
>> naming mine after the board, and would rather not accidentally imply it
>> is or is not your part.
>
> I've found these part numbers on the photos of a replacement panels 
> from the AliExpress.
>
> Also, for TV101WUM-NX0, I have a confirmation from Alexey Min, who 
> disassembled
> Xiaomi Mi Pad 4 Plus and took a photo of the panel's part number.
>
I searched around on AliExpress for my panel, and could not find 
anything about the BOE

part number for mine. Oh well, since there's some precedent for naming 
unknown BOE

glass after the device that has it, I am hoping that will be OK for my case.

>> If it is useful, I have the Fire HD 10 panel ready as a variant on top
>> of your series: two patches, binding and driver, adding
>> amazon,suez-boe-nt51021. The only change it needs in your code is
>> making mode_flags per variant. My vendor asks for sync-event video mode
>> with a continuously running HS clock rather than burst, and your two
>> panels keep exactly the flags they have now. Burst worked on my panel
>> too, so this is about matching what the module is characterised for,
>> not a fix.
> I will try to do that. Can I add you to the maintainers of this panel 
> driver?

Yes, you may. Once you get the v2 out, I'll get a patch ready on top of that
for the Fire Tablet's BOE panel!

>> I will hold that until your v2, since Neil's renaming will touch every
>> identifier it adds. Happy to test v2 on this hardware when you post it.
>>
>> Thanks for doing this first.
>>
>> Ryan
>
