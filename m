Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90DBCA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4FD10E094;
	Wed, 30 Sep 2026 18:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MerEiXRO";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF16F10E094
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:03:32 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-34b3a9cd8edso1072484eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790791412; cv=none;
 d=google.com; s=arc-20260327;
 b=D5ye7fwhl5j3BgP9Os7KXhlItBisWtII4mUwxDprA4dWOH+xn9Hzf4UM0EtAz08qMk
 zQT1vY5tAOfptXh77cGijXk+bRL6xvmHaujN/GtKK5EKDUUczMGnXrF077xOOTHT+pYc
 NQl9KqCLUtebq5Z1TiqMi6bqg5HkTB3VBX0kQMbI5hNPNBEAHU0NIoApMMQrUy4IX98/
 6ITGKxgw8jvZEa+Cl57Sgr6JWYRaEwjgD6kvkZhTt0sepOBZVpxiCDi5SAq/Rwqc+iL8
 cYY5X1f+erP3ZuUsm8A3wZvOAxyumlyp8KMdOh1GPR/M14jN+ZkMACcRJzXolGvJRGdE
 XK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hFazgWQfgrqX5tXQzvSSrxoFxe7hMQG/LSZ4puiNeNc=;
 fh=KmKvHgCzDe5wxVNHp5/Naa1I4abAllAMIdk3rylibLA=;
 b=Rcbzt7fuZSxvcuDQYVfgtJ5YcqiCa2qC0eH8WTIb0qFCoLaVRWpT2+lVWM4mQcnBQp
 rJPeVLWCR87wQHrbQq3tOhiu9TepVwHFKZmJ+w574L13sAC+BcEM8Mgrik0np6N1n2Uw
 ey4Cn7u52lLsPXl6q+4MUxHhtU/rXNuRy9ljSQbFzA0LIovgSwwwG5CGegkB2Iv0x9yw
 JV4RREwU9aHeG8h/lOHVXdhWZHeSCoV+hO/d+oAIEEpjRwvGCgY/fVF+CKKPJOHo4OA2
 QAzfSEyhTiwxXr8xP9atXoz2+QC5+cIQ/2vamhdjMaTCXG02QvhhF7I8elKlgdzRRXWs
 4d5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790791412; x=1791396212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hFazgWQfgrqX5tXQzvSSrxoFxe7hMQG/LSZ4puiNeNc=;
 b=MerEiXROTv158P/F/Cyev7TVqphGb6AWYoEA/L6Ks0zMLQ2DNe5FpxcSQidmkgHnb/
 rc4wHJuBY/ebjsNXWcNjU2FpIIR+3Xpon4V35WWBnHpByzdr0AARBjiHWQ34RP6MmcQ+
 2M13MHuUh1SUU+Skd46jV3KZ1n/4pl9G5V6NvHNWWydWVsMsdufVATp7V2QR8viVzkBQ
 ih7jBrVXb+z1jFBjnsNHljMGY8ADk12Qz8exf21MNHHacVAaM1vT7MU8TXm5YZlzkz0V
 JaUsBUap5y2N4DLnV3XfQh/nu1atjk7sJXQjumqOND1KNKMXphSxga+mBBFiz6lfb0Rd
 tRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790791412; x=1791396212;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hFazgWQfgrqX5tXQzvSSrxoFxe7hMQG/LSZ4puiNeNc=;
 b=yfBzejqz+l3RKnBfE2ivPCeSUJ+Tqx04Uh1W5WSTkGKsa1AtwJxNXQ4usXvI+Scsgv
 K5m9Aa1NVCBnsfaXRyVUtAUGkJR/un2eatIpxA1B1KZcvfENkF/WI4XUV7gw6Y9sExKX
 YNZYUeLyv7GQmyHjSm9oC51vwBvpU7S/VECikJV/xa8F0sluGYqz65LJ2CLdM3HG9Jxk
 B7x3Rwg9xDrGQ9ZxhLd5r8Bh36FiJxaM1/iBv/TdHJenT1LRROb1CeLf4PJ858WpfSBV
 pmeT02ElWG5CbbMKqhzXuO+uGWKdunPH4GOveBRm9d2+/rDTGH4MVXvGqT46HpfyUV4t
 fM2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSOvyMC1JrdAZjj4wCVcP7jbv7DCrUVWX00eRB+hV6LeMc3Left5A+2p5c8stc3sC68VzSpaJ8VEM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lBHpBGtHFgu9JIqolsI69C+hn+tUdOAprOaXFOugzGEmGneT1D
 WY01l+8oYG9Ig4Wr/G7sBKuKBZIpvJbgrkvdfcvqP6zJ8YuTtodB4GAK/vRX7z69lVw0eHVop2Q
 9eQ1Rifx9kHbjrOOe2gCmZRAiUYZWKcQ=
X-Gm-Gg: AYBFou0B//dH96v2QHTC7dUxvUX5dqYc+k6TsfEjNQEaRoFZvZ+uC7AqsQ5ay4lTvTW
 Ko18yuSY0+ux0j/Yku1ZFG8C+L6wxJPrKV1WCRLHoWIgMLkUdoi5f95ws420UvD6EEzld9aagvA
 K4gxMi3XMY4PGEuJj5hVJGeza2yhadawFPCPMP/CRoUGn7b7C0c8sabL+dfw4sBoPGd9lR1Boqm
 tkjmsvaKSWRBi8TeOI7FBAlJTq0tIHkRR1gyMuL7T9EcQPwYGPu4aDQSQ6cPXmPMT6Qq1JVI4iZ
 TjOO1QUr3xVb/4xRw6or5bmnzQXQa7nOa/A/rFi8+5FxoKq9UnZPlnSWPfa8UxE4MIkVGFxHzdc
 NNODc+CKgp7yp
X-Received: by 2002:a05:693c:6302:b0:33b:f87e:9e24 with SMTP id
 5a478bee46e88-34db442e062mr301482eec.0.1790791411529; Wed, 30 Sep 2026
 11:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
In-Reply-To: <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 21:03:19 +0300
X-Gm-Features: AclHuK-1QxITN8tXKEVLFacuZ52BTqv5hd6JiagMmZ8V3B_11Lh2NaeMasip5dQ
Message-ID: <CAPVz0n2mwC1r+Wsm8j13J-zoZyzjEH2sepsYKVbf847Gqnapgw@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:19 Mikk=
o Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > Tegra20/30 SoCs display controller.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvi=
dia,tegra-8bit-cpu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra-8bit-cpu.yaml
> > new file mode 100644
> > index 0000000000000..f0dab608b2936
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit=
-cpu.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-cpu=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description: The display controller in Tegra20/30 SoCs features an
> > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > +  protocol and is referred to as '8-bit CPU'. Each display controller
> > +  provides two such interfaces, which can be used to send MIPI DCS
> > +  commands to initialize and control the panel while image data is
> > +  transmitted via 16/18/24-line RGB.
> > +
> > +properties:
> > +  compatible:
> > +    const: nvidia,tegra-8bit-cpu
> > +
> > +  dc-gpios:
> > +    description: Data/command selection pin.
> > +    maxItems: 1
> > +
> > +  rw-gpios:
> > +    description: Read/write pin.
> > +    maxItems: 1
> > +
> > +  cs-gpios:
> > +    description: Chip select pin.
> > +    maxItems: 1
> > +
> > +  data-gpios:
> > +    description: Specifies a set of 8 gpio pins used to transfer data.
> > +    minItems: 8
> > +    maxItems: 8
>
> Based on my admittedly brief research, according to the TRM the display
> controller can drive all of these pins - of which there are two fixed
> sets as you mention - directly. So we'd need to describe which interface
> the display is connected to in DT, but not any GPIOs (which they really
> aren't).
>

Thierry, Mikko.

I am not sure how to approach GPIOs defined outside of Device Tree.
All GPIO interactions are done either by ofnode/fwnode or software
nodes. Global gpio declaration is in process of being removed and
legacy GPIO API seem to be not long-therm sustainable. How to resolve
this? Should I keep above layout with GPIOs defined in the tree?

> > +
> > +  nvidia,init-sequence:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: Device specific set of values used in DC DISP_SPI_INI=
T_SEQ
> > +      registers.
> > +    minItems: 4
> > +    maxItems: 4
>
> And AIUI this is panel-specific DBI commands the display controller will
> transmit. So ideally the display driver should receive this data from
> the panel driver.
>
> Thank you
> Mikko
>
> > +
> > +  panel:
> > +    type: object
> > +    description: Node of supported panel driven by the bridge.
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: Video port for RGB input.
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              bus-width:
> > +                enum: [ 16, 18, 24 ]
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Video port for DBI output (panel or connector).
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    dbi-bridge {
> > +        compatible =3D "nvidia,tegra-8bit-cpu";
> > +
> > +        dc-gpios =3D <&gpio 110 GPIO_ACTIVE_HIGH>;
> > +        rw-gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
> > +        cs-gpios =3D <&gpio 108 GPIO_ACTIVE_HIGH>;
> > +
> > +        data-gpios =3D <&gpio 32 GPIO_ACTIVE_HIGH>, <&gpio 33 GPIO_ACT=
IVE_HIGH>,
> > +                     <&gpio 34 GPIO_ACTIVE_HIGH>, <&gpio 35 GPIO_ACTIV=
E_HIGH>,
> > +                     <&gpio 36 GPIO_ACTIVE_HIGH>, <&gpio 37 GPIO_ACTIV=
E_HIGH>,
> > +                     <&gpio 38 GPIO_ACTIVE_HIGH>, <&gpio 39 GPIO_ACTIV=
E_HIGH>;
> > +
> > +        nvidia,init-sequence =3D <0x0000002c 0x0 0x0 0x00005000>;
> > +
> > +        panel {
> > +            compatible =3D "hit,tx10d07vm0baa";
> > +
> > +            reset-gpios =3D <&gpio 175 GPIO_ACTIVE_LOW>;
> > +
> > +            avci-supply =3D <&vcc_2v8_lcd>;
> > +            iovcc-supply =3D <&iovcc_1v8_lcd>;
> > +
> > +            backlight =3D <&backlight>;
> > +
> > +            port {
> > +                panel_input: endpoint {
> > +                    remote-endpoint =3D <&bridge_output>;
> > +                };
> > +            };
> > +        };
> > +
> > +        ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            port@0 {
> > +                reg =3D <0>;
> > +
> > +                bridge_input: endpoint {
> > +                    remote-endpoint =3D <&dpi_output>;
> > +                };
> > +            };
> > +
> > +            port@1 {
> > +                reg =3D <1>;
> > +
> > +                bridge_output: endpoint {
> > +                    remote-endpoint =3D <&panel_input>;
> > +                };
> > +            };
> > +        };
> > +    };
> > --
> > 2.53.0
> >
> >
>
>
>
>
