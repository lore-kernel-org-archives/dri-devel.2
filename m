Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B508FCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF7B710E5BC;
	Fri,  8 May 2026 07:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="OXB/9Bbj";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012A310E06A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:44:43 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-ba6838e76f2so214037666b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1778226282; x=1778831082; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDjfGFQB/3KLdXokArqrjAXXqhWAtauRetXWKTzWGMw=;
 b=OXB/9BbjuQTa0zAycj7tFo89Y9gaxDKHkUbXBI2mBnCQGnZ+GorAiy+tF5zrbMDqe6
 +k1FNkTwWcyCLY7TXV2mb/BhkLhYaXTx3GHJy0w/N04C+xgILISwe0yyVi+71rWWdyo3
 UguQ4M5O0q9rvDJlUQyksuI7g+SlcY/bt5FRICXsrwcdAHvHm0LZi5+nxD6arRbxMVev
 XmzuzP0M6oxevtcJQ+E+uGJmpmKfT4ibCGrUyhzSaLfYgILOkTkRUznOnK5k491Xcpf8
 ZsjONUL6K5NcYX2mbGsIDjHzLkunBtR1PaqVEMbtqw576vJNtFyiHf8Cqq1yLwgM2QyT
 dHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778226282; x=1778831082;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nDjfGFQB/3KLdXokArqrjAXXqhWAtauRetXWKTzWGMw=;
 b=UXFyM92TL+tZlFrv/WmEk0X/ZeO9lbAyad5XhXBlQE8XKB1VegjiWEWsYdApsTAQzr
 Bl0/RYtEFGRYjXJSvBp1Fg7Pl3srSLN0QqWBz6SmxPHM8JWU8YjDTt7kmv8Mgh6VlcXQ
 rQeKinp80Yyjl3LvsxsXRgxcxZLmCsjTyMqz2NgNW8XupVeN87HXUWNrqPxf33wBOEZd
 8KuySf1grm1LXnHqqU3eQVVRCut9MaC5ZsVmldljXkLc+6WODqeHW74hPQlbu6IUWbLv
 WRFlvZqdB9l5nG3TT4Mll/14CmlKT4JW6plVbCHmz75HKfN7bC/5iINxExULfd+9Ijfw
 XvdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R0Vn4OZ6PMS/13vJw/4QZVQn5lMiDJVGYscm7toToU1UYGubvG5n91XgWuU5A0AEGYcbdyazVIEE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuLanVMCguJsy2e1B4UFKs+/Yiy6AC52zQTRCrOkBJgjMZpWLo
 M8aNcmimVOepSghmKlKa/c/AsNYnQq6IPs/9ZF7QwnkfMw4wyKBTDGqBYa/3RESqk6k=
X-Gm-Gg: Acq92OHTKjkK5KNawpEEmkOYakntFoBEVCYpYQwyYJnpj9q4VAusQKavfDR+Cdhkv1J
 pQmUitrwEWtxU2boagVn8/fhppo7a5pfF4p8OjjAxxz9l4SeLYFP6xw4JL0phKHN7oqFitrEZWQ
 jQJqxuEaKygIrsYGxG00wfJWth2+SiBmDRUym4+2tF1b7kbEZxlPfio/IKBKxk5Adn9kTIxmSej
 l1QV8KBwJ9CTW/wwVgx74qr6H/7qLRLNWhZO055UNodK6uJ6Sqx5a/3IjO3q1KUKAmRleqKTk0j
 xGJFJjU6BhnM/00EEuJYM4v6WplFfwrs9+s/H2DFTZmyyolIUgDQw02Y4KWrAZjRUnKKMhZl4jJ
 oggFlwApWTJUaQDelcVT0peHX5NwSBjcW3ZOy67Wl9SRx/Zg6WlDY3LKfVhqZpzGbwVkP3dNDyC
 ljXIoLBlISmX74JAc0AImdU5KiJmaTH67buMdajinqFaWjxDAd8UdbAijwxZES4+/zfX8y
X-Received: by 2002:a17:906:c394:b0:bc5:cff4:8e3c with SMTP id
 a640c23a62f3a-bc5cff4af34mr446060566b.40.1778226282237; 
 Fri, 08 May 2026 00:44:42 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcac43581bfsm42651566b.46.2026.05.08.00.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 00:44:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 09:44:41 +0200
Message-Id: <DID4LW3GMLDV.338VDV2L2IPL@fairphone.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: Add Novatek NT37705
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Conor Dooley" <conor@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
 <20260501-fp6-panel-v1-1-e09cb05651cc@fairphone.com>
 <20260501-yogurt-wise-2a2884e3ec59@spud>
 <DI9XL1VYYTY7.19IRSM8VIDO53@fairphone.com>
 <a2444df4-abf1-4b56-8556-7efb238bc677@kernel.org>
 <DIAJCURQ37FA.1CNEKX6QM6ZO8@fairphone.com>
 <dd7ebb25-014c-4983-ae31-6a6cbd24e628@kernel.org>
In-Reply-To: <dd7ebb25-014c-4983-ae31-6a6cbd24e628@kernel.org>
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

Hi Krzysztof,

On Tue May 5, 2026 at 9:25 AM CEST, Krzysztof Kozlowski wrote:
> On 05/05/2026 08:40, Luca Weiss wrote:
>>>>>> +  compatible:
>>>>>> +    contains:
>>>>>> +      const: boe,bj631jhm-t71-d900
>>>>>
>>>>> Compatible doesn't match the filename, nor does the commit message ma=
tch
>>>>> what you've got here. Sounds like you're missing a fallback to
>>>>> $filename.
>>>>
>>>> The last times I was upstreaming panel drivers (Feb 2024 and June 2025=
),
>>>> this was the requested way of doing things.
>>>
>>> So this was requested that time and is requested now. What is here
>>> uncertain?
>>>
>>>>
>>>> Compatible being the company and model number making the actual panel
>>>> assembly (driver IC + touchscreen + glass etc), while the rest being
>>>> named after the driver IC manufacturer & number.
>>>
>>> So exactly what was asked for...
>>=20
>> I don't quite understand what is asked for now, that's my issue.
>>=20
>> 1. Change the filename to boe,bj631jhm-t71-d900.yaml and leave the rest
>>    as-is.
>>=20
>> 2. Add a fallback compatible for novatek,nt37705. IIRC last time it was
>>    argued that a "generic" nt37705 driver will never be correct for a
>>    specific panel since it's missing a bunch of panel-specific init. So
>>    that's why there should not be a fallback to nt37705.
>
> To my limited knowledge the (2) with fallback describing the specific IC
> is preferred, because that compatible although not currently usable is
> still specific and describes actual IC used. I imagine that such
> fallback still could be useful to some SW implementation to determine
> the IC and act based on that.
>
> If you have sources of other preference, please share, but I just gave
> same review to Neil for his ayaneo,wt0600-2k panels.

I found the discussion from 2024 for the Fairphone 4 panel:

https://lore.kernel.org/lkml/f9164049-6529-42c1-a35a-e91132c823b9@linaro.or=
g/

(quoting)

'''
  Not sure if "himax,hx83112a" is needed here, the "djn,9a-3r063-1102b"
  is enough to know the IC is hx83112a.

  I don't think you'll ever find a "djn,9a-3r063-1102b" with another
  controller IC ?

  And "himax,hx83112a" alone as fallback is not enough to describe the
  panel hardware, so I think it should be dropped.
'''

With Konrad replying "+1" to that.

Regards
Luca
