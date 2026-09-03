Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EB9C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7358410F527;
	Thu,  3 Sep 2026 11:44:38 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976CA10F527
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:44:36 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-74ab99038afso1733974137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 04:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788435875; x=1789040675;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8/u6qCvNI1eNvTKcm5+U1ybbBEt77cvtW8ZuFisi1PM=;
 b=jetidqJOl11Kp4OTZhK73MJF4RWrRBusVwQ2Z2XWFGAUTVuYgZZxjebbAajGCIaVcu
 9j75urLSi/jZTyG4iu5pG81cmPw8Oe+o0tx/QSJUZoZemY5T2OnReE/GULu0lk1rossQ
 PyFuhZWj6gp2UcTvGe66pwWJyHGktgU2Zc3TGUn+Ni1ZxuQ4wXK6ZFih5sIVIVtChKx2
 90Jtv5SMMt/WJPRa8EgubfYOmKA/9y2XTzJcNzUD+kQa3A2/863ulOlwfTxLfFL/+ejL
 r3sZczasAIM2kQKwmk7vWYm0dURu9hyrN6dt01NgQGGCiNFSB637fnCWQicGpSP9X2sB
 RkTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhnQ49+v0kuHxJUNZNEHckghOPg3fz0Jb0Ff6+ld9ZTyOGc2NRd1HqfxYqbQwvdfOJ8M1zCvapcD8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mBjfpi8R198I1HVxP+TPhjb2hXEShctHeNjSBkJOUZDu7Mq6s4
 Ixuda7FnZ1AQIIWfISXeKk1eNSnA2gbMGYCGS7tk1YGg7vueRM00fTqWm3KMKhA0h1E=
X-Gm-Gg: AYBFou16Mfw6XqgGn3vFGV5ASGj5WxpowxnrfoJ18pllaYnnTmf+q6hOuocfGKnORz5
 yf4PALohPykdB0xQc+1MuVfQXHB994wbfQMlVqdUoDt5oVj/NQHvywx16sGzHqBejZ1dvjq4RJ4
 L6HqI48Tf48Jpr73rwweYyrRSilKy9fE7MdF5SxN+4GRoP6q8DlDxVZvhNzUGJComNk4evUe6HD
 ba9TGGNIh42p+yb3Ket5IKvoOEICIki9ghLrlVXDWfpe8ibVjXvexu+K7/XQUya9ocgPz7ZDKfP
 rnOwbshI2Le3oV6a/pePUM7j4mbABxINIZfWku2hBmUH+ckMf5CgViftF9Km35GSnoh0Sg+mtRY
 Ef55WE/mvX5IJ6GbAVQa31loeLQkPSn/GimLVZMnluKJ9MXZMk+MSIlviKH8v4mCBudZlE2PJjH
 5NbxkAI3Xzm30h86RXeRQkZntQBhyfhp1dbwuzUHqMhalNJRZD9UaRM+QVvC5/fA2z/q4/n3Smo
 mZTgVkb3FcW34p4y4JO1O8dr9J75A==
X-Received: by 2002:a05:6102:2d0e:b0:784:b9ec:913d with SMTP id
 ada2fe7eead31-78a1f364141mr4773670137.8.1788435874999; 
 Thu, 03 Sep 2026 04:44:34 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com.
 [209.85.221.171]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78a1a510ca3sm4387589137.11.2026.09.03.04.44.32
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 04:44:33 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5c652293bcdso2393790e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 04:44:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxQc0xQgmUgfaqfR2WFfNAsFj5SkD76/zNRlAiZ81uy5sa5ZszaM/K85pKdjPE5Y2U8G0ntF73RGBc=@lists.freedesktop.org
X-Received: by 2002:a05:6123:2c5:b0:5c7:a844:48a with SMTP id
 71dfb90a1353d-5c7d2801fd4mr5329323e0c.8.1788435872300; Thu, 03 Sep 2026
 04:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
 <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
 <20260902-heavenly-ambrosial-trogon-b7ab03@quoll>
 <apgsOubuGuvw_0rf@tom-desktop>
 <CAMuHMdU0y5Dg9tW7fAM3QQHKpAw_+vmjj7v-XeZmrushQgQFAA@mail.gmail.com>
 <aplTgBjpPX9d6XEh@tom-desktop>
In-Reply-To: <aplTgBjpPX9d6XEh@tom-desktop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Sep 2026 13:44:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcHN9ndLyNCpinRDZpeX-qRQhfiL=Qxxh6gJhp9pURaQ@mail.gmail.com>
X-Gm-Features: AcwNN1XZ3OM_lakDx5H4wW1FhegMnSx1x5XdKbO9842TU5e3GqmmMjZwi3rTP4Y
Message-ID: <CAMuHMdWcHN9ndLyNCpinRDZpeX-qRQhfiL=Qxxh6gJhp9pURaQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] dt-bindings: display: renesas,rzg2l-du: Document
 RZ/G3E SoC
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, tomm.merciai@gmail.com, 
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Tommaso,

On Thu, 3 Sept 2026 at 13:01, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> On Wed, Sep 02, 2026 at 04:20:51PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 2 Sept 2026 at 16:03, Tommaso Merciai
> > <tommaso.merciai.xr@bp.renesas.com> wrote:
> > > On Wed, Sep 02, 2026 at 08:37:06AM +0200, Krzysztof Kozlowski wrote:
> > > > On Fri, Aug 28, 2026 at 02:21:04PM +0200, Tommaso Merciai wrote:
> > > > > The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
> > > > > Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
> > > > > Processor (VSPD), and Display Unit (DU).
> > > > >
> > > > >  - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> > > > >  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> > > > >
> > > > > Add new SoC-specific compatible string 'renesas,r9a09g047-du'.
> > > > >
> > > > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> >
> > > > > --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > > > > +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > > > > @@ -21,6 +21,7 @@ properties:
> > > > >            - renesas,r9a07g043u-du # RZ/G2UL
> > > > >            - renesas,r9a07g044-du # RZ/G2{L,LC}
> > > > >            - renesas,r9a08g046-du # RZ/G3L
> > > > > +          - renesas,r9a09g047-du # RZ/G3E
> > > > >            - renesas,r9a09g057-du # RZ/V2H(P)
> > > > >            - renesas,r9a09g077-du # RZ/T2H
> > > > >        - items:
> > > > > @@ -35,25 +36,51 @@ properties:
> > > > >            - const: renesas,r9a09g077-du # RZ/T2H fallback
> > > > >
> > > > >    reg:
> > > > > -    maxItems: 1
> > > > > +    minItems: 1
> > > > > +    maxItems: 2
> > > > > +
> > > > > +  reg-names:
> > > > > +    items:
> > > > > +      - const: du.0
> > > > > +      - const: du.1
> > > >
> > > > du is the name of the device, thus calling items "0" and "1" is pretty
> > > > pointless - indices already define that. Please drop the reg-names.
> > >
> > > Will drop this in v8.
> > >
> > > > >    interrupts:
> > > > > -    maxItems: 1
> > > > > +    minItems: 1
> > > > > +    maxItems: 2
> > > > > +
> > > > > +  interrupt-names:
> > > > > +    items:
> > > > > +      - const: du.0
> > > > > +      - const: du.1
> > > >
> > > > Same here
> > >
> > > Same, thanks.
> > >
> > > > >    clocks:
> > > > > +    minItems: 3
> > > > >      items:
> > > > >        - description: Main clock
> > > > >        - description: Register access clock
> > > > >        - description: Video clock
> > > > > +      - description: Main clock for DU1
> > > > > +      - description: Register access clock for DU1
> > > > > +      - description: Video clock for DU1
> > > > >
> > > > >    clock-names:
> > > > > +    minItems: 3
> > > > >      items:
> > > > >        - const: aclk
> > > > >        - const: pclk
> > > > >        - const: vclk
> > > > > +      - const: aclk1
> > > > > +      - const: pclk1
> > > > > +      - const: vclk1
> > > > >
> > > > >    resets:
> > > > > -    maxItems: 1
> > > > > +    minItems: 1
> > > > > +    maxItems: 2
> > > > > +
> > > > > +  reset-names:
> > > > > +    items:
> > > > > +      - const: resetn
> > > > > +      - const: resetn1
> > > >
> > > > Drop reset-names
> > >
> > > For reset-names, I got the the following comment from Philipp in v7 [1].
> > >
> > > Dropping reset-names would force the driver back to an index-based
> > > lookup, which is what that comment explicitly asked me to avoid.
> > >
> > > [1] https://lore.kernel.org/all/8382e2b9fd07fb1132c26e228b3899336fc1fdd4.camel@pengutronix.de/
> > >
> > > Philipp, Krzysztof, could you agree on which way you'd prefer?
> > > I'll follow whatever you decide.
> >
> > Until we get a variant with a third interrupt (or reset or reg),
> > which is not related to the number of channels...
>
> Just to make sure I follow: are you referring to variants like R-Car H3
> and M3-N, where the position in the array no longer matches the channel
> index? From renesas,du.yaml:

Not directly, as these don't have any non-"du.X" resets and clocks.
But yes, these cases are similar.

> [renesas,du-r8a7795: 4 channels, two resets] [1]
>   reset-names:
>     items:
>       - const: du.0
>       - const: du.2
>
> [renesas,du-r8a77965: 3 channels, du.2 (channel 2) does not exist] [2]
>   clock-names:
>     items:
>       - const: du.0
>       - const: du.1
>       - const: du.3
>   reset-names:
>     items:
>       - const: du.0
>       - const: du.3
>
> If so, I agree: the names are what makes these unambiguous, and an
> index-based lookup could not express them.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
