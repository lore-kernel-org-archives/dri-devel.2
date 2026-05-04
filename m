Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEB6FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 13:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B2C10E6BA;
	Mon,  4 May 2026 13:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="n+LExFfj";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8615E10E6BA
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 13:36:32 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso769932366b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777901791; x=1778506591; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxl8aaXII9jrd89JJtrtzoxkaO727e2zu5aa5KJCGNY=;
 b=n+LExFfjtP/UbuWkqP+LwIOitA8QWf49OYyTOe0Dy7IBRqT8b1WAr+/yNUGWxmFH9U
 9DcjsEYWMRq9QwI9hAdhWNESHRdQNCd//tWIxjCXwmwGTrrCGmCaL9UfPA90xGImPhfl
 SIKKuClGsIbpDR3Y98ZMowtMsFfcjp8iivy1aSt6PHnBXhieh41+Bp91FzN7H5CgG15f
 P0+pTsgc2GyVvaoRTAFl7aW4KC5vy/rRICH/R+9mPj7DsSMGtCz3eA7jzuVHQEwAJAMC
 U/KU+rD1w1Qgu+oNySR25jBzSTDwa54w0SXMjVadFIAzLdXXXihY4GlEMs5bsHCARhqv
 Cc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777901791; x=1778506591;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zxl8aaXII9jrd89JJtrtzoxkaO727e2zu5aa5KJCGNY=;
 b=CAmh/1+VRC9s6dj8j2GX6U7rjroYMe2lbzS7ZTvi8I3zFij1l4XCsROLTQuW0tnp6w
 er1rOXj+0ldr8bipwrCLn9Haw6OI9wh9lc8ZEYNG+VTNtH5WixNZ2YFMVlWBiukdlzRv
 AWc6lTtbYJSQjEgxgvU4aIiFiIwgfo7Lc9P4X39OsxFLPwZlLtiwDyFu9soYny9S2aG3
 2zuhRN/43s0CS3u4zXBJqpWqsjyfaOh6VuWb+FIXmpPUApWV12Nu7ThJ100ykq8Q8TJj
 6DOwb0ltjgi2E4VKwJEaGGwMh3aup7ZQ4uCVvkGuAu8pTPygc1dWv80PrthMR8QN+82q
 2kTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iXq8h0IUfRiLwm5fTqUNHG2XsSpC1+uSF3AxQHtftN3svb/1P1PtM2NYF6tnWDIgClvbz7XlCLh4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRbfOXmSnFIFbZCzFzqjNxAvOkueQ8ko9Ol4NL9bGMEwvk4m/b
 15JFPi33ZvprCTQM4xllxNngML/9ctmzL48xRpTj3odJVEgwA2HtLz0t9n9aBWunWGo=
X-Gm-Gg: AeBDieuGvMZXTTxEIlfn0uxORRCKU8F/kBlUTooMPh0j8NHd4/cPYXoCi6Wzq330OAV
 5dylq9pPulvq7kNZQDOiO0/Y8dNQZrRrxsosoSHIHjaRSu/HpRM0WE/iU5Y6I1ny6OIelsv3+5J
 Lf4kpVSmsl+EVTIG5RR0VGLdEvLHEi6a80s57fgIaT+cbaaRd5lIdf0iDePDoxK1veOmpbxuC8U
 YWDr+WdLNfnQ1AN+SXvh36YHPR0vz77aBUFhx5FQqbdIXOj9kib1ljH+deozktFl22dNVpzRj+M
 LvWL9cTRzsl5nIGvBFaTYkqFYnoBI0vtm86EMjHZxjlEJqvG7cOOc2eK78a/MzALy88sA2dGz4q
 yBPRbK2l/rnNaOgbTdh4br5THtVfHkkwSP3nSN7fB2CGRj+XfR8CzEregJPRIzAUvzHaJ925IHd
 kEQInwjZ6eulbkKn4JgYFiv0u+GjLbFwHqycjAhsXY5gfePPyf5ot2paJiLVC4YrchYsbTzkzBL
 5F8CDk=
X-Received: by 2002:a17:907:1c9c:b0:bc3:5f51:7a3 with SMTP id
 a640c23a62f3a-bc35f5107f2mr72609466b.16.1777901790709; 
 Mon, 04 May 2026 06:36:30 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bc1ad2d59fcsm151369766b.45.2026.05.04.06.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 06:36:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 15:36:27 +0200
Message-Id: <DI9XL1VYYTY7.19IRSM8VIDO53@fairphone.com>
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
To: "Conor Dooley" <conor@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
 <20260501-fp6-panel-v1-1-e09cb05651cc@fairphone.com>
 <20260501-yogurt-wise-2a2884e3ec59@spud>
In-Reply-To: <20260501-yogurt-wise-2a2884e3ec59@spud>
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

Hi Conor,

On Fri May 1, 2026 at 5:51 PM CEST, Conor Dooley wrote:
> On Fri, May 01, 2026 at 03:52:45PM +0200, Luca Weiss wrote:
>> Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels.
>>=20
>> Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
>> from BOE) using it.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  .../bindings/display/panel/novatek,nt37705.yaml    | 72 +++++++++++++++=
+++++++
>>  1 file changed, 72 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt3=
7705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37705=
.yaml
>> new file mode 100644
>> index 000000000000..1c796599f6fc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.ya=
ml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Novatek NT37705-based DSI display panels
>> +
>> +maintainers:
>> +  - Luca Weiss <luca.weiss@fairphone.com>
>> +
>> +description:
>> +  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLED =
panels.
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>> +      const: boe,bj631jhm-t71-d900
>
> Compatible doesn't match the filename, nor does the commit message match
> what you've got here. Sounds like you're missing a fallback to
> $filename.

The last times I was upstreaming panel drivers (Feb 2024 and June 2025),
this was the requested way of doing things.

Compatible being the company and model number making the actual panel
assembly (driver IC + touchscreen + glass etc), while the rest being
named after the driver IC manufacturer & number.

As seen in
* himax,hx83112b + djn,98-03057-6598b-i (Fairphone 3)
* himax,hx83112a + djn,9a-3r063-1102b (Fairphone 4)

Fairphone 5 panel (raydium,rm692e5) was upstreamed earlier and follows
different naming.

Has the way of doing things changed since then?

Regards
Luca
