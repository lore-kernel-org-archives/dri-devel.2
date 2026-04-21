Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01809F327AD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D480710E819;
	Tue, 21 Apr 2026 07:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DpZHCknN";
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA4910E0E0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:33:48 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-6948e6bc30cso412123eaf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 18:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776735227; cv=none;
 d=google.com; s=arc-20240605;
 b=O8VBNa2Jo8JbhK5ew60q6RvcmjLbUZ8KMwh6MgRPl/NYZvXxe3bvxVWH0so9+Ui+Oa
 kwI0YbaaKV9eUAa36lPtxdKJ4xGESVLRpuAfhYm0q5upx2onJsXfQd/bd/uEZShfhS/q
 ZLacERcJExBTKp4Yri0EaCJsku+ZaHR4xYDqdDc2xCTcIPTiv1mABvYqbRk2SZub9dzD
 q95b6nwrQM2hxkve2wMA+3jjsNWlzEdOh9lC5dmbyHCpHJeO8nbK6dHXFOhDKmIFNNGe
 xpknyGUt5u5PnO/iNvZdVsyd4p8n9i6ii/UbxdGPmkl2MVa0zOAj1qAXmt17W+A9kZWJ
 Nxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2ro4c5Yj9UOYed9OjkB0PmZ4Fty4O5ffP4GqAvAQb7k=;
 fh=gskco0se90RHIQxqTKt66j9oKDmTbXNzf4OTjGnARnQ=;
 b=D81w/wHkkCwF8Vs5pDg8oEni6lkJWeY4REnsNLccZNv/dnS7IGQFNDx8LaLgJctiE1
 4KCgwpxrx2ZZSxW/7bSZ0JI6ONwt3iwPXNuD5VXGTDb7buDt6YHhcVTDHSWbdXGViVN0
 f2UMtU/xZP3JAXMgzfUR0Cyy91lKFyuTkln9qa1JeDGMi6BN8tXDQDAxQPkDcQFMHHLV
 aZ51omyC3z0eoqg06JYJMXk/ll3bNDEk3FPcyXtIzAklkpEbufzFv/zIAKDUobM6A5CP
 3rKzRczEUkA9qYurQT4Rpm1TzsE6JD0+6ler2pNX0JxgUnIgsh2dgxs2MBYZHEnzhN0K
 4AWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776735227; x=1777340027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ro4c5Yj9UOYed9OjkB0PmZ4Fty4O5ffP4GqAvAQb7k=;
 b=DpZHCknNrcTKy3avvmBWR2pBvm9S2iBVDb2CrJ7fp1KHG68f1mQkipF/Iv+ID2vBUh
 RHgAzgv/EiHkEaz85fq5i9lZ+Su8//yjU5F87wTCFj9ztIdCeBGcLvMKeiGXw9aZH/Ze
 Ogevc1gK4bOPRk3/fQMARdlXDVKgBhq3kFJTsmgvchm8tDLNlGa5uKwDGcWcRNr+4Bfg
 GroCXHStvR2ke9Hv7yFJD+8HbxI5jH3fBokQ3xpzsbDqUic5wpvDYT2qPyGYwdVJiPA6
 FTp4IS4syulVGOJ2m9TYvZVAOVixS9ftjabj8y2SCMou2g2N248uCd/9XmTQId56Umkz
 yazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776735227; x=1777340027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ro4c5Yj9UOYed9OjkB0PmZ4Fty4O5ffP4GqAvAQb7k=;
 b=AKcicDBVUXP9tQDTYGpIc3dJN1XkpX+3S4q78OR0x76bslcEsPqUbBBgpA3qcv41lK
 HonX5xgT97ePF1I4vKl7Vh8tyH03gWEtIIBNSTMtJrOIRV/XCgWai/2Tf2nwkGLgCMLr
 waLRG8VgGc0ZrYKICcxBrtcbcRQ2r7IBnDs2p1TavQ0qVH3JT24YBgm2gYykiUlfAN3F
 CBRt4IKdfpx5VGMymKSkt2XClohi9bT/KbNboR+7MlU0JPkZ0XVR/KGudmbSgO88no3u
 hLYdzZ98c30a1vBFRoA80RvgZM7gQvge1uM83r2fmKaPU0lDk5ekcLOwvelkQ9uFxK5c
 De0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hRVlHJCtZ5a9Rq+axr4wRVjS017SMzK4uUGeWjiEx3xNMdOGBhkPucaMNwrYcLnl2B+9oJCWA00w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwReS20uwdbvdK0nKmVXkoNFRWrNVmGWB1nHWTD8IVnZM0KmzOV
 NZgC1ezwGcEDZFXawO0ZoQ1YxB1h8ZW5K5JWJFe989UuMvxrfC1G3j0Tfx1zl8kSvWYqwyR2RYJ
 XrTkpK1hvB3dzjMupjxIFmGnhRDAdsOw=
X-Gm-Gg: AeBDiesaytQGfvdjvPzFgGF9yu6DJh7vz8E9lU7MUK2PHAbT+goyVgEoef8yGMsiRhC
 p3BlqesmVEbagN24gi684A4ZtuboMmrKv3qIYH/bUg2OKkCPeJg4wB5R68954hFTq3NY73qH3kY
 LLD7FkwjNDMp+wZdl87rJnZJjKZHJuPtg7lGCMDFFt6VDKaROPVaBmI0RaNNRie5KWrlpDL20Pq
 uZAB6QAOTl7zWWMT4Dd8YiXS4KTbxaIcGP/wZ1ImJwGz7ZFKiySA2Kit6gudBpjOePZyEolo80I
 UE+oJWyZNBJYuBh1
X-Received: by 2002:a05:6820:8c3:b0:67e:447e:d1a with SMTP id
 006d021491bc7-69462e21352mr8979705eaf.6.1776735227190; Mon, 20 Apr 2026
 18:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-2-syyang@lontium.com>
 <CAO9ioeWhWemzyF30t8KDJht6_59b1Y5+GrH9nYCeKuPwddVLHQ@mail.gmail.com>
In-Reply-To: <CAO9ioeWhWemzyF30t8KDJht6_59b1Y5+GrH9nYCeKuPwddVLHQ@mail.gmail.com>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 21 Apr 2026 09:33:34 +0800
X-Gm-Features: AQROBzBN_QwHqnaPP8ZW4aL0Yv-pDE7geB_VDmJoG9ke-1GZvesdJrXvLgHpc-c
Message-ID: <CAFQXuNbyH88Ab_LgfZknRxhK9QzN8Xe-G9NuRMuECZF_SrRpfA@mail.gmail.com>
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
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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
4=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 11:12=E5=86=99=E9=81=93=EF=BC=9A
>
> ote, your message didn't reach dri-devel. Please check why. You might
> need to switch to B4 Web relay submission, if there are any issues
> with the SMTP on your side.
>
> On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
> >
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > -binding for lt7911exc.
>
> Less is more, but here please settle for slightly more information
> about the chip.
>

It will be modified in the next version.

> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > ---
> >  .../display/bridge/lontium,lt7911exc.yaml     | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/lo=
ntium,lt7911exc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,l=
t7911exc.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt=
7911exc.yaml
> > new file mode 100644
> > index 000000000000..54a73d41635a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911ex=
c.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/lontium,lt7911exc.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lontium LT7911EXC eDP to MIPI Bridge
> > +
> > +maintainers:
> > +  - Sunyun Yang <syyang@lontium.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lontium,lt7911exc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: GPIO connected to RST_ pin.
> > +
> > +  vdd-supply:
> > +    description: Regulator for 1.2V MIPI phy power.
> > +
> > +  vcc-supply:
> > +    description: Regulator for 3.3V IO power.
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Video port for mipi dsi output.
>
> MIPI, DSI
>
It will be use MIPI DSI,  in the next version.

> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Video port for eDP input.
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset-gpios
> > +  - vdd-supply
> > +  - vcc-supply
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        mipi-bridge@41 {
> > +            compatible =3D "lontium,lt7911exc";
> > +            reg =3D <0x41>;
> > +            reset-gpios =3D <&gpy8 8 GPIO_ACTIVE_HIGH>;
>
> Reset pins are usually active low.
>
if reset pins use active low, lt7911exc_reset function needs to be modified=
 to:
static void lt7911exc_reset(struct lt7911exc *lt7911exc)
{
    gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
    msleep(20);

    gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
    msleep(20);

    gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
    msleep(400);

    dev_dbg(lt7911exc->dev, "lt7911exc reset");
}

I think the two are essentially the same. Please confirm whether I
need to make the change?

> > +            vdd-supply =3D <&lt7911exc_1v2>;
> > +            vcc-supply =3D <&lt7911exc_3v3>;
> > +
> > +            ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0>;
> > +
> > +                    bridge_out: endpoint {
> > +                        remote-endpoint =3D <&panel_in>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    reg =3D <1>;
> > +
> > +                    bridge_in: endpoint {
> > +                        remote-endpoint =3D <&edp_out>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
>
> --
> With best wishes
> Dmitry
