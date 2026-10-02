Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB302CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005B810F85D;
	Fri,  2 Oct 2026 14:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="mnw9/1hh";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A341810F85D
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:00:53 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae54so12153295a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790949652; x=1791554452; darn=lists.freedesktop.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FhuCqWE46Oix2LB6rL8UWqZIc/9YnixRqUY7dkp01xw=;
 b=mnw9/1hhkM3z7LEz2iwhH0I8m+JBwIl80IBzW1KO1S2sLvmECBM/kWAPt35he6ZQ39
 KbtDejgZtWVrjJn/ltwWXF8NN3VUMQm99b/0xY+sb7T2zTxwj50ccIYLDdD7g5nq13V6
 bFJjwy2Df3fYxJ63XJM4y3BP8xYTG9LNFmttcaUynUoj3DtafpJeMg6wJj2rZnatScra
 mUz1VVLCwhA/9h3fP4pyQAAsIeX80zw8yySbfAGUuR1kMawA/kMc3aMtPluewdFS5PfT
 hIG7O0O7kJBUPWE9vyFT3Hyj0Y0v+kMds+s7nK8BPKrIVs8HkMhNec4jjRHCEs8HiZ70
 ZX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949652; x=1791554452;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FhuCqWE46Oix2LB6rL8UWqZIc/9YnixRqUY7dkp01xw=;
 b=gqja250sEYqAaVGNkS8EklCk+al/MVSwKUVtLRQdXezaaWITqixzllP2Gy/XKHNMD3
 XDzkcZYeuF7PVE+vA/AHP6gW66q4IlYf8jQISyKyt5zqP8tWanvB+8aa93QoVdT0s2RD
 lWLpNlUbiMZlBDFPECkt4m57/HduPbeCrx6K2X480nnrHjGvkL7qJOYHFkZMtWeSz9W4
 0GU8N+8PihmU4d2ZEYluYhhQOw0lpFOy0SQHd5BRRMKikIkVc5GCdqdXpjfbCWKFNmBX
 wMgIUEk2BhjeX77mwIBY8pd465ydPEIKRCynWOqqqkGzxLSioMQwVY4uda7h/xMhEaRq
 k1bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2H+/NIIifys+TIb3fyhavaZlD/264LByTk0Z9Udq3C0xK8WYUkEZ3bynriIwigwwGyzMd0eQxFus=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKnb/Msg7J+P1cj+P5CINQsKWhcoVgtYDpZOc/zM/xhxzSvux9L
 1m8F+X3gM7iF+KX3E3oBP61BNkEci6EjhqWqVLKkUOEuFN8pwlRXMkMJd6KX4cr8p24=
X-Gm-Gg: AYBFou3PtQNkwG1lO1DUtIvrsTvNN9BI3U9PfaZWwCnDOjea3T/nM3tYzH8SBJPGgEX
 SGonsOItsAH6ewFAC4rFhpNOl9oTohNBJEZB4bbToq73jVKl31dnlVKrSzi9ra0fxFpDxGY4i03
 JJHTV2ExcSAFqb0lQucDUFu9iybP40/Cz/hmuMXV60GmVArFj44VpG/Whlxw0d/cmJ+vXAndYJd
 SUwExyYtMYHFaxak0xtgFKdZEToP37X/gGTbgWcsY+wg0VsW+CtltfkcVrnbn+e37V0fvZsiupt
 upnDl9mNqVaHYIHv6uNsP1IkCWip0F+oZOGpL5uVqEgsTuI712xEeSjivxhVMvxshfqhKYy5LsH
 juo9U14IsVlHTq90P8ErfHxvpo7lPJj+f5s0nmoh1fXZCy1DBESlBWrHrA20yB8WKEjj/IxGrQr
 vVaSEQXPl5F//+C0gPZPj93EVW8RsECiv8UxHY5OmGUispP1W/WJO/qcePZtUM7udhnVXLIEker
 B6nMPOqG9TVskj4Wx5mY3wssR46xMAu4mod38UxQu0=
X-Received: by 2002:a05:6402:3228:b0:6ac:7d0c:2cb8 with SMTP id
 4fb4d7f45d1cf-6af9e342728mr1802843a12.30.1790949651896; 
 Fri, 02 Oct 2026 07:00:51 -0700 (PDT)
Received: from localhost (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6af9d8a5361sm944608a12.21.2026.10.02.07.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 07:00:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 16:00:49 +0200
Message-Id: <DLUENYYQNULZ.BMYEQYCFZ258@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Rob Herring" <robh@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: Add Novatek NT37705
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
 <20260918-fp6-panel-v2-1-6695c4008920@fairphone.com>
 <20260918213518.GA2337779-robh@kernel.org>
In-Reply-To: <20260918213518.GA2337779-robh@kernel.org>
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

Hi Rob,

On Fri Sep 18, 2026 at 11:35 PM CEST, Rob Herring wrote:
> On Fri, Sep 18, 2026 at 04:40:04PM +0200, Luca Weiss wrote:
>> Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels.
>>=20
>> Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
>> from BOE) using it.
>>=20
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Link: https://lore.kernel.org/r/81a3c207-4d8f-490f-8e2a-6f3f4c2acd35@ker=
nel.org/
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
>
> Did novatek,nt37705 get dropped as a compatible, but the filename=20
> remains?

That's how himax,hx83112a.yaml and himax,hx83112b.yaml are as well,
which I have upstreamed before. I *really* don't have strong opinions
either way, but as in the email referred to in "Link:" the versions I
have upstreamed before have been accepted without issue, and even
discussion pointing in the way I have done things here.

>
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
>
> As sashiko reports, "contains" is too loose.

Will fix, seems to also be an issue in the hx83112a/b yamls.

>
>> +      const: boe,bj631jhm-t71-d900
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vddio-supply:
>> +    description: I/O voltage rail
>> +
>> +  dvdd-supply:
>> +    description: Digital voltage rail
>> +
>> +  vci-supply:
>> +    description: Analog voltage rail
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reset-gpios
>> +  - vddio-supply
>> +  - dvdd-supply
>> +  - vci-supply
>> +  - port
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    dsi {
>> +        #address-cells =3D <1>;
>> +        #size-cells =3D <0>;
>> +
>> +        panel@0 {
>> +            compatible =3D "boe,bj631jhm-t71-d900";
>> +            reg =3D <0>;
>> +
>> +            reset-gpios =3D <&tlmm 12 GPIO_ACTIVE_LOW>;
>> +
>> +            vci-supply =3D <&vreg_l19b>;
>> +            vddio-supply =3D <&vreg_l9b>;
>> +            dvdd-supply =3D <&vreg_oled_dvdd_1p2>;
>> +
>> +            port {
>> +                panel_in_0: endpoint {
>> +                    remote-endpoint =3D <&dsi0_out>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> +...
>>=20
>> --=20
>> 2.55.0
>>=20


