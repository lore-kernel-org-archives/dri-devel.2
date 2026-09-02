Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3182AC624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A6B10F23E;
	Wed,  2 Sep 2026 14:21:21 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB6F10E051
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 14:21:20 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-98076bb236eso108353241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 07:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358879; x=1788963679;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=evP2uDnq5KuHvliZWqlHGeP115Ejr4LNw5LNG8+8bBg=;
 b=MZG41thNdQbVYV4pdzyMMiYp1VoNOYsdEQVwSKovtKS4bKJLLT5QMis6DOYGnopgow
 ixI7f/zrAM+ysxMpVYYZlxPjlfI7PMgfqeTxNleiQ8ImvrHkQTBbHzVDiDl62VMNa2Vi
 7PJsHZO6U2ioAWOrOBnOfD/AW0I9eN9PLXTsQgR8GR3XWFPlztg0jT4XSMO8QRe1f76D
 qXYXe3RA6b/PS0FJCBpXFo3VGiwQ2KNSlTzAqs2h3+CGxQVuHkRjTnhy6oFkWmqJ7NFG
 3ably2Eo1uFJrLZyT+3FS4/Vou2QXvhd/hPuHyTnf/I1RIzNKu5mcd36Fe79+mrvaSWp
 mLgA==
X-Forwarded-Encrypted: i=1;
 AKwUvByOKUpWHUkeMClw/o01K2vRLFicPjypWAIOj9zbLC1H/h65tM+RBqQAQ4U0tIEceKjDQ4g9VdUEAdE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQYj5iKuaHLeQPkjv3eXLV2YxV+yXOx26Ik/uRXuvD+PyFtpjM
 9l/UOKFE2/H3ZEeDbVtYy2sdZP5zFPpCb9o3GbM34cpUcUV84qcxsavU1We0A0gw
X-Gm-Gg: AYBFou1yvmEoQOPZvDgcVqkpbMJO+v0a+wPxuhzpNrUyxD1DEgQeT66gUDQUneMp3qI
 iSUqNyAQiNT40dMBGURGfeUgLE6py05JcNU3cfvsormDMjaWJSy4MnwwFLIXUgXRW+rjEh9b/kN
 EQmUpHTfjN6oFT7uJhm7xtFlmh4y9A6m3FhvUnuK9MwLiv5yTz2IvYis2t7Nq5EtnXEKdjM0otQ
 dVbSVoIlFGEAb0D+gwGR85WiYT4nTQjutT08o7ki2mM5WoQkJkDEOWeSlLjvACmh7PFnQUy8XsU
 Vt3xgI6hyLDB8h0RsGYNaZPs/rHjbdFU3RZr61orWEbjqzGLVYVgEurfmb65BASLMi9wYr+ssLF
 4kgJoINMjQjZ/TdkV7iJrKSg9WfAb6ud8r42Iv15fmINeG2FVeFzrYtgGiPvA+4I064oyHOyVjn
 SVGmbxUqx64boLiZbT1cA4Rbu6aO26MGgNepkPh6CxSU08VfEL1aD0QMx4Ab8qIzfy4Xdqxpk/w
 cF+usmfp3svdnuF5wBbJC9cz+dpnYxYBDuf+dFSyA==
X-Received: by 2002:a05:6102:3fa8:b0:785:d308:cc2e with SMTP id
 ada2fe7eead31-78a1f363e2cmr1722048137.9.1788358878580; 
 Wed, 02 Sep 2026 07:21:18 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com.
 [209.85.221.170]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78a19f8f68esm2223121137.0.2026.09.02.07.21.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 07:21:17 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5c7bf03c4d0so965026e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 07:21:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByyWzAZCgozZUBjfXzRyU5Odgg8fLNN6pVpuaI/k2I0cd977oXZT4Hs4V/AM282rXsdw/o8VQACxk4=@lists.freedesktop.org
X-Received: by 2002:a05:6122:3701:b0:5c6:731e:3c8a with SMTP id
 71dfb90a1353d-5c7d2489256mr2442213e0c.1.1788358863528; Wed, 02 Sep 2026
 07:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
 <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
 <20260902-heavenly-ambrosial-trogon-b7ab03@quoll>
 <apgsOubuGuvw_0rf@tom-desktop>
In-Reply-To: <apgsOubuGuvw_0rf@tom-desktop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Sep 2026 16:20:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0y5Dg9tW7fAM3QQHKpAw_+vmjj7v-XeZmrushQgQFAA@mail.gmail.com>
X-Gm-Features: AcwNN1X9A4V0FkbVpKVtvPWiA_DTIG3JNljzBRxP5oY3Ch7smDLgUzau8FWVpIQ
Message-ID: <CAMuHMdU0y5Dg9tW7fAM3QQHKpAw_+vmjj7v-XeZmrushQgQFAA@mail.gmail.com>
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

Hi all,

On Wed, 2 Sept 2026 at 16:03, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> On Wed, Sep 02, 2026 at 08:37:06AM +0200, Krzysztof Kozlowski wrote:
> > On Fri, Aug 28, 2026 at 02:21:04PM +0200, Tommaso Merciai wrote:
> > > The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
> > > Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
> > > Processor (VSPD), and Display Unit (DU).
> > >
> > >  - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> > >  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> > >
> > > Add new SoC-specific compatible string 'renesas,r9a09g047-du'.
> > >
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> > > --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > > +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > > @@ -21,6 +21,7 @@ properties:
> > >            - renesas,r9a07g043u-du # RZ/G2UL
> > >            - renesas,r9a07g044-du # RZ/G2{L,LC}
> > >            - renesas,r9a08g046-du # RZ/G3L
> > > +          - renesas,r9a09g047-du # RZ/G3E
> > >            - renesas,r9a09g057-du # RZ/V2H(P)
> > >            - renesas,r9a09g077-du # RZ/T2H
> > >        - items:
> > > @@ -35,25 +36,51 @@ properties:
> > >            - const: renesas,r9a09g077-du # RZ/T2H fallback
> > >
> > >    reg:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: du.0
> > > +      - const: du.1
> >
> > du is the name of the device, thus calling items "0" and "1" is pretty
> > pointless - indices already define that. Please drop the reg-names.
>
> Will drop this in v8.
>
> > >    interrupts:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: du.0
> > > +      - const: du.1
> >
> > Same here
>
> Same, thanks.
>
> >
> > >
> > >    clocks:
> > > +    minItems: 3
> > >      items:
> > >        - description: Main clock
> > >        - description: Register access clock
> > >        - description: Video clock
> > > +      - description: Main clock for DU1
> > > +      - description: Register access clock for DU1
> > > +      - description: Video clock for DU1
> > >
> > >    clock-names:
> > > +    minItems: 3
> > >      items:
> > >        - const: aclk
> > >        - const: pclk
> > >        - const: vclk
> > > +      - const: aclk1
> > > +      - const: pclk1
> > > +      - const: vclk1
> > >
> > >    resets:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: resetn
> > > +      - const: resetn1
> >
> > Drop reset-names
>
> For reset-names, I got the the following comment from Philipp in v7 [1].
>
> Dropping reset-names would force the driver back to an index-based
> lookup, which is what that comment explicitly asked me to avoid.
>
> [1] https://lore.kernel.org/all/8382e2b9fd07fb1132c26e228b3899336fc1fdd4.camel@pengutronix.de/
>
> Philipp, Krzysztof, could you agree on which way you'd prefer?
> I'll follow whatever you decide.

Until we get a variant with a third interrupt (or reset or reg),
which is not related to the number of channels...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
