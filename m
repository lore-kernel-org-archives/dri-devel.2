Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB0EFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 06:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D7910E038;
	Tue,  5 May 2026 06:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="HekaSd/E";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A5DA10E038
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 06:40:20 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so3430242f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777963219; x=1778568019; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6FO20EYGAs2fwB6e1zerXDAb7NyQnTU9vNFbNdbR+I=;
 b=HekaSd/ElunzMrMgN02rqhExE2wrf8NH+OnD6ajhNlmWTqFyYd91BeNs/+dpXGBGoL
 5Jk8sdwSF2zMc9xjwy7z2u+EHH/+3oCLuEPAZGHYp6mfHHX20ozi5eHptNPlDMgs+89l
 5zb65h92vmM0hNyGSiZZ1LWVznAUTWeX51AvYElh0Sbs4zW/YZyZvdT9i2SUb0nOdB36
 NHIFAnWcnNwjU8ocPEvaoCU/kgk/U8MWSF4S+JmNCoO3N8fHAERGPOmBk29zK7L2pUMr
 iKDanEuYKIAyH9CHbhlXxVe9W4z4H1eLqHKRTHUtTE3utbRTrm8OXc+W72/sT+aNnMmi
 pUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963219; x=1778568019;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6FO20EYGAs2fwB6e1zerXDAb7NyQnTU9vNFbNdbR+I=;
 b=h2YuM4OqiBWHXR9BPHWqjk+bZJ5Dv0DnJ1DZbAIQFpPQLTvegNDiyQRN3A7w+yF4VS
 I4q5FgOPStaEqQPh0Lwa2M9F4qJxrAP47ahtrJ+d+WFGxvOEF64scafSpusfLBdAdm5M
 +LB8tJe3t360sMP6xNYUIq4MXt1ysXvIjKWGlB1Pbf2T3PF8sdK+IwXIsTel3h5l0jlu
 M0OvsbG7y4svLv4/KtUOwpZq1Ml5R9+strQefz8GP0F4OvRpxFLDewsh48UgTAmmdVOT
 Ad/lal6FsarthpcuIZKzy0n7R6vlR8V3RvSu0izsizmDsGodg4Zn0wASZV0KgpckWPLO
 nEow==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yJkmBRG9w8yIeUtJ99tUtehC+/02K1KBCpI/yfQodzCrg9Ury+n5DvL3zw6aRvoFKXEqZkwrsgfc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYSibFKPPlno2rum/TF8ZQs5NGirGNoZwFjQRlZFHK7+xnC3N8
 JW77YNj3hIR/+eCm61BdpHGV7hTqASCpjIcH5OP49DdKx/r5zk7WSJXYdZjIVjJGv+E=
X-Gm-Gg: AeBDievO9o/T2EpN8fQ15hE59KDykdKTRnammd36Cp/mib0M167jhKiIybFdlfu6SmH
 3cR3AT+Y5RMT0KO9hQdr65HqcpKiZrcVt5VM0RMYLrYe32xGtwY3UXg6yXVeyeeXUEWSrSMnLIj
 ElqXCDmLWGgoFm32lMNTR/W/I63pur9kSUm5YcopTkA0VkRXeMzuJdh3rHnsYz7BiHLGv4TZr4z
 oi2M0YMuKEDR0tT/5uzanfvptq0+sR2iNXTjk10LkR1lWbhdLnoYkMOGW6BNRxi4R8S8mTZT8xd
 KhqRf9O3reCA6oYM1X4kKRL2yNuFPNWiCNS/QL+JK638Oen9D6oFPweo/0VNH9v6mw64kgQcvPI
 UyKKFEF9oRggGFhRdw0aTjFDBusYwpsmrDNtWSRLLjt0IZ6vzhIlF5hGTAnpuApQ3K0mUDKY7JW
 qpTo6AdEthtJ6XpxZXwlDKOQGC0PuoKp8/z1032uw=
X-Received: by 2002:a05:6000:2001:b0:441:377f:82a7 with SMTP id
 ffacd0b85a97d-44bb6d95a09mr22079695f8f.32.1777963218742; 
 Mon, 04 May 2026 23:40:18 -0700 (PDT)
Received: from localhost ([213.208.155.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055d36dacsm2083055f8f.32.2026.05.04.23.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 23:40:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 08:40:09 +0200
Message-Id: <DIAJCURQ37FA.1CNEKX6QM6ZO8@fairphone.com>
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
In-Reply-To: <a2444df4-abf1-4b56-8556-7efb238bc677@kernel.org>
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

On Mon May 4, 2026 at 10:45 PM CEST, Krzysztof Kozlowski wrote:
> On 04/05/2026 15:36, Luca Weiss wrote:
>> Hi Conor,
>>=20
>> On Fri May 1, 2026 at 5:51 PM CEST, Conor Dooley wrote:
>>> On Fri, May 01, 2026 at 03:52:45PM +0200, Luca Weiss wrote:
>>>> Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels=
.
>>>>
>>>> Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
>>>> from BOE) using it.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>  .../bindings/display/panel/novatek,nt37705.yaml    | 72 +++++++++++++=
+++++++++
>>>>  1 file changed, 72 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,n=
t37705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt377=
05.yaml
>>>> new file mode 100644
>>>> index 000000000000..1c796599f6fc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.=
yaml
>>>> @@ -0,0 +1,72 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml=
#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Novatek NT37705-based DSI display panels
>>>> +
>>>> +maintainers:
>>>> +  - Luca Weiss <luca.weiss@fairphone.com>
>>>> +
>>>> +description:
>>>> +  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLE=
D panels.
>>>> +
>>>> +allOf:
>>>> +  - $ref: panel-common.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    contains:
>>>> +      const: boe,bj631jhm-t71-d900
>>>
>>> Compatible doesn't match the filename, nor does the commit message matc=
h
>>> what you've got here. Sounds like you're missing a fallback to
>>> $filename.
>>=20
>> The last times I was upstreaming panel drivers (Feb 2024 and June 2025),
>> this was the requested way of doing things.
>
> So this was requested that time and is requested now. What is here
> uncertain?
>
>>=20
>> Compatible being the company and model number making the actual panel
>> assembly (driver IC + touchscreen + glass etc), while the rest being
>> named after the driver IC manufacturer & number.
>
> So exactly what was asked for...

I don't quite understand what is asked for now, that's my issue.

1. Change the filename to boe,bj631jhm-t71-d900.yaml and leave the rest
   as-is.

2. Add a fallback compatible for novatek,nt37705. IIRC last time it was
   argued that a "generic" nt37705 driver will never be correct for a
   specific panel since it's missing a bunch of panel-specific init. So
   that's why there should not be a fallback to nt37705.

Either way, it's different to what I was working on with the two
examples I gave. Please help to clarify.

Regards
Luca

>> As seen in
>> * himax,hx83112b + djn,98-03057-6598b-i (Fairphone 3)
>> * himax,hx83112a + djn,9a-3r063-1102b (Fairphone 4)
>>=20
>> Fairphone 5 panel (raydium,rm692e5) was upstreamed earlier and follows
>> different naming.
