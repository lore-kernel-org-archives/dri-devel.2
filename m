Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B2FCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89BFE10EB6C;
	Tue, 19 May 2026 14:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gi/6xcck";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3440510E5E0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:40:13 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so3137637f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779201612; cv=none;
 d=google.com; s=arc-20240605;
 b=iIXVpOhkD9IeRu682j0dyR3zKSyA/aEof5qszlAY75vmrGEUy76qNjyoMN112oZ1nA
 I7tEGrNzHTGT8YxDb/roXgrZGC9uqBrc3UVJQX2Tn/MyRPWaL5eVWwVFkALnjYTwIcV3
 ofTjs5WFv28+au2y6aNHn0DKMs5K0mNqNqmHH5U6ERW8u+4uERTfEyNeaTnfeOC4LciB
 OhfcKkXOLji1fWF3417eCRObyL6G601iax8dmlENj2n/oTZh9SBzkDsddsEzFkIWb39m
 BuDn4z2+W/3yB7OcLal8A9TePLiNVHhfdbpEGXMptEUT3tCRNLVCToH1h+293mVmcuT2
 +pPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1OmyzMyEm/LGiksBOL5pvZw6xuB+Es7o+zSzCGxEqtw=;
 fh=X9bWk4aG4qnjH5royO/ghZZRcxkI8flFstL4A2AwnrU=;
 b=LUXrs/PsJiGU6YYBX0a2OoOb049IP4yfXXnG/j6ueDbadzCczuTt5GmJw8hMpkdbNc
 oatICx0G2ZO13HtJgfuOI2sgRCdMTZqyAwfdibRBMvlmUIpneDwf02TbCeH3osvMK9+P
 7X9cjDq2Bwlgyepapwf+K+p2gEjyC5R9GlfIBSQfXojNGq2la+uchbzf+0Z2uv7okTT7
 /er7loqZfZb4pbBDilCsF+wqp3YBYjXdSU0v6lnMvn31Hpj/03QlTSMB/WeY/Sa3cczs
 D4WeOzag2TPOFe1dcYW5E+05C3p7PgN5rXi5/ugvAJh8FC9L3f3vtExNhiFb0d77wHGD
 1uHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779201612; x=1779806412; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OmyzMyEm/LGiksBOL5pvZw6xuB+Es7o+zSzCGxEqtw=;
 b=gi/6xcck9kKxy0vRsK5jgeYWoGj3ats3NUYk0Vt0Ffvcec6G6uI2qe1lGAzh9gUQkD
 mmXXTPJoZZemPlj7v96ccXguWnz5qauxmZb54t38Wo4glNo4biX3hSUXF78JAiXLPGIg
 Amd0BzGMlGHRS/lFTVSZR2HSFg8Ka8vrZpuOBWe+K6/QMMorAc7SPfQgiPMXeH8POav3
 p24rdwGX+KWELY0FusWT6niT626TWLM1vFiSlWgPrRLJajS9eBa4SmpJLAS7oPfi1+Bw
 cSQpcaEy5nn9ppHpkINu2/0XnRffVjjcW+/xx3dMTcTDF2fRkeELrpjRloapG3migP3s
 YqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201612; x=1779806412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1OmyzMyEm/LGiksBOL5pvZw6xuB+Es7o+zSzCGxEqtw=;
 b=alZqCy09gianTDofBVWjgW/0BXpGsCeI2TEjiwgwsCpxXH8HEE7+gDPtJiBjMyLP9E
 j9vkIbUVuDH1jgIcYeFlPrL4vsU88QPQlLnbGGb2530NZ8pvVP/kFsSeG5wjllTeiewU
 sus3LdoO7F3zRVbP6p4tjhK2gmIw+WYJ+/n/IaC6fiSFLjYiKPPQoIEzyCAOhGb3oRwE
 dM/JOmkQJs4+RQf4tPKkveXwE77lUzPvjQUWCgkoFKt3Hnj6lSjF4OQR5WMKATxPWDUy
 LnCjC++5hcp+Yr93tKP87WpjWdHRpBepElOwpvltAU0mmKtGU5qRDoKfFJ69T8exV0Lb
 q6xQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+UnSAPtFCzs62LzGudCA2JZbFuAkQptkLKIWAx56hNV6MggOiuqf/JcbjDtQ8ukPoosPbtS2rFxM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuqFuGzyBD08/95DR8RDWU/wtTAQdBWfU3PS6heAjTVO7XWCRs
 qDJ1eJ/Yo1mHefS8EJkGz8XPJPHO17papZo8X7O/qvznIn+B0WU1LX04vkGDOxnaa+tDUlMwjPW
 pz7Bi2x79LvReWMsXRAk+LTde3mj1jek=
X-Gm-Gg: Acq92OEDh/G/HqFhzZxkijH/sMy3SUGyWFNeub4tWpaBnDnS8YNXFF7SajweR6CZfiJ
 KOKCniSl89S7iTddHpJdMFkmOfLWs8TWa5zvoOwCoJhvjM0eKKlsZtbYfGIMTAjX55Ylihv9vR4
 swaPmQ9R0fpbTzkcVui/h0ajpkYuEz+lbwIVj/Zx4snJCI3bnJlUc5IsSshI/L6EwK2FtePL9ZO
 TUm9BV8mxakg6/uq0tE90ZH0c5n76gjkf9cDFEiSBtWIQSDBkTW4BlJ7L2uxqFHnRFiukFLiw8k
 cgpmy7T3QQzSVRPnAXMY6OymFHo3fA5Lfm1j2DlGmThsuzXFY2z+fUlqJcZe/1L3jrV1
X-Received: by 2002:a5d:5850:0:b0:452:f380:5508 with SMTP id
 ffacd0b85a97d-45e5b681925mr31609485f8f.0.1779201611516; Tue, 19 May 2026
 07:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260512144104.761531-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY3PR01MB11346174DD5FFD70AB39F570086022@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CA+V-a8v_gmPEcWgFsC3Kv4X_M_qzbVHeEY=EmzdYxzy+PkyB-Q@mail.gmail.com>
 <TY3PR01MB11346178F22560ED8A8A38DBD86032@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346178F22560ED8A8A38DBD86032@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 15:39:44 +0100
X-Gm-Features: AVHnY4LmRnxW-jhziRMaTvD5C7T7dWBrBp1GfrKUh4KZMXnga4r65Ov9CP8dIJo
Message-ID: <CA+V-a8sfvB5uEr8x6FkzxY2LcnUhyFfWRx9aLN2aFoyZ0CQt+Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic to
 per-output clock limits
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 "magnus.damm" <magnus.damm@gmail.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju,

On Mon, May 18, 2026 at 8:12=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Prabhakar,
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 17 May 2026 21:30
> > Subject: Re: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic =
to per-output clock limits
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Sun, May 17, 2026 at 6:59=E2=80=AFPM Biju Das <biju.das.jz@bp.renesa=
s.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > Thanks for the patch.
> > >
> > > > -----Original Message-----
> > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > Sent: 12 May 2026 15:41
> > > > Subject: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic
> > > > to per-output clock limits
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Move pixel clock validation from a fixed encoder check to per-outpu=
t
> > > > constraints stored in rzg2l_du_output_routing.
> > > >
> > > > Previously, rzg2l_du_encoder_mode_valid() applied a hard-coded 83.5
> > > > MHz upper limit specifically for DPAD0. This approach cannot scale
> > > > across the RZ DU family because pixel clock limits vary per SoC and=
 per output interface.
> > > >
> > > > Add mode_clock_min and mode_clock_max fields to
> > > > rzg2l_du_output_routing so that clock constraints are expressed at
> > > > the granularity of individual output interfaces rather than globall=
y
> > > > per SoC. Update
> > > > rzg2l_du_encoder_mode_valid() to look up the routing entry for the
> > > > active output and return MODE_CLOCK_LOW or MODE_CLOCK_HIGH when the
> > > > pixel clock falls outside the declared range. A value of 0 for eith=
er field means no bound is
> > enforced in that direction.
> > > >
> > > > Set the DPAD0 pixel clock limits for RZ/G2UL (R9A07G043U) to 20.875=
 MHz minimum and 83.5 MHz
> > maximum.
> > > > RZ/G2L and RZ/G2LC (R9A07G044) share the same DPAD0 pixel clock lim=
its.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > v2->v3:
> > > > - Moved clock limits from device_info to output_routing to allow
> > > >   per-output constraints.
> > > > - Updated commit message to reflect the change in approach.
> > > >
> > > > v1->v2:
> > > > - Dropped storing info pointer in struct rzg2l_du_encoder as it's n=
ot needed.
> > > > ---
> > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 4 ++++
> > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
> > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
> > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > 0fef33a5a089..d1bc205eb5f8 100644
> > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > @@ -33,6 +33,8 @@ static const struct rzg2l_du_device_info rzg2l_du=
_r9a07g043u_info =3D {
> > > >               [RZG2L_DU_OUTPUT_DPAD0] =3D {
> > > >                       .possible_outputs =3D BIT(0),
> > > >                       .port =3D 0,
> > > > +                     .mode_clock_min =3D 20875,
> > > > +                     .mode_clock_max =3D 83500,
> > > >               },
> > > >       },
> > > >  };
> > > > @@ -47,6 +49,8 @@ static const struct rzg2l_du_device_info rzg2l_du=
_r9a07g044_info =3D {
> > > >               [RZG2L_DU_OUTPUT_DPAD0] =3D {
> > > >                       .possible_outputs =3D BIT(0),
> > > >                       .port =3D 1,
> > > > +                     .mode_clock_min =3D 20875,
> > > > +                     .mode_clock_max =3D 83500,
> > > >               }
> > > >       }
> > > >  };
> > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.h index
> > > > 58806c2a8f2b..307ae70dd382 100644
> > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > > > @@ -30,6 +30,8 @@ enum rzg2l_du_output {
> > > >   * struct rzg2l_du_output_routing - Output routing specification
> > > >   * @possible_outputs: bitmask of possible outputs
> > > >   * @port: device tree port number corresponding to this output
> > > > route
> > > > + * @mode_clock_min: minimum pixel clock in kHz
> > > > + * @mode_clock_max: maximum pixel clock in kHz
> > > >   *
> > > >   * The DU has 2 possible outputs (DPAD0, DSI0). Output routing dat=
a
> > > >   * specify the valid SoC outputs, which CRTC can drive the output,
> > > > and the type @@ -38,6 +40,8 @@ enum rzg2l_du_output {  struct rzg2l=
_du_output_routing {
> > > >       unsigned int possible_outputs;
> > > >       unsigned int port;
> > > > +     int mode_clock_min;
> > > > +     int mode_clock_max;
> > > >  };
> > > >
> > > >  /*
> > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_encoder.c index
> > > > 0e567b57a408..4af2ae09ff39 100644
> > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > > > @@ -50,8 +50,12 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *=
encoder,
> > > >                           const struct drm_display_mode *mode)  {
> > > >       struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);
> > > > +     struct rzg2l_du_device *rcdu =3D to_rzg2l_du_device(renc->bas=
e.dev);
> > > > +     const struct rzg2l_du_output_routing *route =3D
> > > > +&rcdu->info->routes[renc->output];
> > > >
> > > > -     if (renc->output =3D=3D RZG2L_DU_OUTPUT_DPAD0 && mode->clock =
> 83500)
> > >
> > > Please retain the check for DPAD output, to avoid checking the same f=
or DSI and LVDS.
> > >
> > This patch checks only for pads that have added constraints.
>
> It will lead to two checks route->mode_clock_min and route->mode_clock_ma=
x.
>
> Whereas by checking
>
> if (renc->output !=3D RZG2L_DU_OUTPUT_DPAD0) is a single check and it is =
meant
> for skipping DSI and LVDS as the respective encoder drivers do have mode_=
valid().
>
Ok, I will move the constraints out for per pad and make it global and
add a check for RZG2L_DU_OUTPUT_DPAD0.

Cheers,
Prabhakar
