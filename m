Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E375BF94CDE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A1D10E95A;
	Wed, 22 Apr 2026 08:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q952IHRF";
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB52F10E24D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:46:47 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-67c22b05346so2522181eaf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776818807; cv=none;
 d=google.com; s=arc-20240605;
 b=RLSiTon8RkfcbZv+g0i/TX4GZC7EKCPNEPx2j8TgbHTA78skbMnc2nQ3jo+a4wFFFy
 A3MKPRwCcrHe8usjYwMTdpbsi/ppSHWfISejiSOnJspGEuJELnWDlHZjbljdvcJZl8mA
 jHy4RhdHUitgIEjd0DDoJXjr79PSPqC9bs6F7KqldG4Q2ElHucixk4eWGTZJ9cJxyq4p
 avk7Q7vAxjdNYpWMk7tTIVnoWmOj6f3947Du56tIruMzHzgJM3yrlrQyvY2OYWqETgLr
 i9KYe8kp8ljueMcwI8uiTAJ8DZvkIOtcNcUATiDWGUCM1+rZBb4zLeEVsdee0oWj1GvC
 h+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mSe58fOFaOjHqfOKP37Pb/hThMA88xjGpfgXKdNEDJs=;
 fh=wDCBupWERu5uKs8bAfwgdm7pa5OlSVqt2KYWc4EPM8Q=;
 b=NxxgPG5u84Waxolk31keA/7Z1Mhz2l/+DU0+bAcUlc9SyLvOJQ7AKZmAnSsjrVFr6s
 VSNJrSH6qRsGhG9Sn8lkSxDTmN+CMFIz8WFq70MQqxLgIgTdqAK/xt0lbDS4PnjdOLjn
 RHNh+jiDNrWUYcHNu5KmOpXZR9DKMOPX1QIGXhK+yuwSd9bwo0CngsinJ1P1ZZ+CDOG+
 iWN7sWK3h0yy3XEeNp9eyD8Jc97D289K23Chl99Zws3j8yewd2oudz6e7hYZN9sjqj3A
 3Uc/xTJZfl+EKSHgE86Y/g8XutbbPi5stI2NvA257IvkcceyJLlmbLLMWmsQfekqIw9q
 mmJQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776818807; x=1777423607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSe58fOFaOjHqfOKP37Pb/hThMA88xjGpfgXKdNEDJs=;
 b=q952IHRFN+yz4PpVH869pFjYVkluCc5IWFuk71DbIlL03NW4IHxJtDhGFQLhZEQ6TU
 I93gnKGNAcxJ6Z0KaZDGYt8KCVddSTYqG57GEVAbQKeukkjvsOf0pBi/OjgBynD2I5hX
 lP2rpvGW1hnKFyEmcd5DxAvnzjF6bxyeHn57mYYsfl+XqLewHP7rwEDs94tqDqzXsi3b
 wDTf0IcFtBXWJEs19TXLEK0GgbPi78tif/I9DIZd19tTi9gQg1NzNFN5ae66MQw57St6
 LfzLgkDha6znUCHdjg9+9zM/cXNv9bFpzzPD8QKtx8xYunfXFdlwkVafWfoNu5hvpf7z
 dxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776818807; x=1777423607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSe58fOFaOjHqfOKP37Pb/hThMA88xjGpfgXKdNEDJs=;
 b=reg+1uvdsUJHWT2xPG9TDtQGYstTKbr3XLewsQdrEYYx98/GJjzf0UxpXhlG5i8ldV
 ZZN336w0baijcx8ZCr350k/fsEKo+T2kwI8/obh9MtCEOPHpqbkGq9VyuIRNy38rzSHl
 5Hi4pbHuDKX5+5AMni8M+xZ/LY9pLv/UyotPfeomirNdSsIzx5N1cijIP4Pq6ydXx8YV
 b3zPDgTIPjgjG+FqHRiDZpo9G0325xcqVuIdjTzam47s6PhIAJPbCSfCplxEfuH4fwe+
 HIqItII2xxomJ0dk7d1XBE/hREUnzDqqjE/xEjafC8yGomFU1CdQEZ5riZOrNbUnk4nG
 e/ZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D0HAOqsQPt1373rKmaFS57CZOKLiwKhQdqVyO6T+t3U590swYnXxxUeeUuR9iWdWBDT3ejkZuRWY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysZoEfURvd8I49MtGHR0sG938bQ5i8+jIl+eM92T2B3AzeiR30
 /iHKAldDUVAI79Y68SJ2Z8lGau7v9YZsUoaSBAGc1lLOMafYEeWt2dHYT0UdP1j8KcZBOYghd6z
 8lstowNLj9CPtGCXNMPAgS3dvCbF6BK8=
X-Gm-Gg: AeBDieuGnF8yxFEE+Fe2ogZ1hEBgzgS1jUqOL+E7KI35sgpQU5Zg4tdIZ/wYxsUCNT0
 7vZLX86uhz5WtO9u1vg8fDM7wJYcJknNwm0j0apadR6XWljIG9bbl58W8KtE6cNoHc1Lw61vHxt
 UHRPqqmVoSiuiuQ0SOfC5jJoGQwnibhI1Fg0p7gzj2Asn5ojAap9mq/bUij/DkXZg8qJXGdd8Wr
 ciatlrE6LGgjHPKiD1a7/ZGZEVJgLtaOrLR24IBEnpkW3hcIklydK2/3HtC8dr/Fo9BaIsQuT9H
 UyxdqGYxOtTgZTkD4g==
X-Received: by 2002:a05:6820:1f03:b0:68b:bc93:1de with SMTP id
 006d021491bc7-69462ef7d6emr11074951eaf.35.1776818806817; Tue, 21 Apr 2026
 17:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-2-syyang@lontium.com>
 <CAO9ioeWhWemzyF30t8KDJht6_59b1Y5+GrH9nYCeKuPwddVLHQ@mail.gmail.com>
 <CAFQXuNbyH88Ab_LgfZknRxhK9QzN8Xe-G9NuRMuECZF_SrRpfA@mail.gmail.com>
 <p3aruen3h3ddmzlqbdseksuqwuwvxa32qbi66yf4gjwdtb5h2a@xs3dleimg2an>
In-Reply-To: <p3aruen3h3ddmzlqbdseksuqwuwvxa32qbi66yf4gjwdtb5h2a@xs3dleimg2an>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Wed, 22 Apr 2026 08:46:33 +0800
X-Gm-Features: AQROBzDc9IJyF3Xn3lpEIA-y1LhWtZTKb7TWhaYpenzuvNRvda7Iutpwgc3w54M
Message-ID: <CAFQXuNaHLzvSKkNo+ZNxRiYMtP98php=Qa0i3r1XMDA2b16gjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings:bridge Add LT7911EXC binding
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 tzimmermann@suse.de, rlyu@lontium.com, xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:26:51 +0000
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
4=E6=9C=8821=E6=97=A5=E5=91=A8=E4=BA=8C 19:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 21, 2026 at 09:33:34AM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90 wro=
te:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B44=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 11:12=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > ote, your message didn't reach dri-devel. Please check why. You might
> > > need to switch to B4 Web relay submission, if there are any issues
> > > with the SMTP on your side.
> > >
> > > On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
> > > >
> > > > From: Sunyun Yang <syyang@lontium.com>
> > > >
> > > > -binding for lt7911exc.
> > >
> > > Less is more, but here please settle for slightly more information
> > > about the chip.
> > >
> >
> > It will be modified in the next version.
> >
> > > >
> > > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > > ---
> > > >  .../display/bridge/lontium,lt7911exc.yaml     | 91 +++++++++++++++=
++++
> > > >  1 file changed, 91 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/bridg=
e/lontium,lt7911exc.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/lonti=
um,lt7911exc.yaml b/Documentation/devicetree/bindings/display/bridge/lontiu=
m,lt7911exc.yaml
> > > > new file mode 100644
> > > > index 000000000000..54a73d41635a
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt79=
11exc.yaml
> > > > @@ -0,0 +1,91 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/bridge/lontium,lt7911ex=
c.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Lontium LT7911EXC eDP to MIPI Bridge
> > > > +
> > > > +maintainers:
> > > > +  - Sunyun Yang <syyang@lontium.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - lontium,lt7911exc
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  reset-gpios:
> > > > +    maxItems: 1
> > > > +    description: GPIO connected to RST_ pin.
> > > > +
> > > > +  vdd-supply:
> > > > +    description: Regulator for 1.2V MIPI phy power.
> > > > +
> > > > +  vcc-supply:
> > > > +    description: Regulator for 3.3V IO power.
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: Video port for mipi dsi output.
> > >
> > > MIPI, DSI
> > >
> > It will be use MIPI DSI,  in the next version.
> >
> > > > +
> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: Video port for eDP input.
> > > > +
> > > > +    required:
> > > > +      - port@0
> > > > +      - port@1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - reset-gpios
> > > > +  - vdd-supply
> > > > +  - vcc-supply
> > > > +  - ports
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > +    i2c {
> > > > +        #address-cells =3D <1>;
> > > > +        #size-cells =3D <0>;
> > > > +
> > > > +        mipi-bridge@41 {
> > > > +            compatible =3D "lontium,lt7911exc";
> > > > +            reg =3D <0x41>;
> > > > +            reset-gpios =3D <&gpy8 8 GPIO_ACTIVE_HIGH>;
> > >
> > > Reset pins are usually active low.
> > >
> > if reset pins use active low, lt7911exc_reset function needs to be modi=
fied to:
> > static void lt7911exc_reset(struct lt7911exc *lt7911exc)
> > {
> >     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> >     msleep(20);
> >
> >     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
> >     msleep(20);
> >
> >     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> >     msleep(400);
> >
> >     dev_dbg(lt7911exc->dev, "lt7911exc reset");
> > }
> >
> > I think the two are essentially the same. Please confirm whether I
> > need to make the change?
>
> If the GPIO is active-low in the hardware, it should be declared so in
> DT.
>
It will use active-low  in the next version.

> >
> > > > +            vdd-supply =3D <&lt7911exc_1v2>;
> > > > +            vcc-supply =3D <&lt7911exc_3v3>;
> > > > +
> > > > +            ports {
> > > > +                #address-cells =3D <1>;
> > > > +                #size-cells =3D <0>;
> > > > +
> > > > +                port@0 {
> > > > +                    reg =3D <0>;
> > > > +
> > > > +                    bridge_out: endpoint {
> > > > +                        remote-endpoint =3D <&panel_in>;
> > > > +                    };
> > > > +                };
> > > > +
> > > > +                port@1 {
> > > > +                    reg =3D <1>;
> > > > +
> > > > +                    bridge_in: endpoint {
> > > > +                        remote-endpoint =3D <&edp_out>;
> > > > +                    };
> > > > +                };
> > > > +            };
> > > > +        };
> > > > +    };
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry
