Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C51CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7179110EF6C;
	Wed, 20 May 2026 08:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5XrrNqz";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB50D10EF6C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:14:17 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so3694672f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779264856; cv=none;
 d=google.com; s=arc-20240605;
 b=DGHqI/vNDL9L7hCug6j/cp/Pkj0OQAx3eHaXycu30cCLhmDogief53YeDLqBf5B1s9
 stlaDb/5KPe8oDoNRq7bak77EeUMN3q/bhymRqYIe2imiLDq+dtHsaLjtzFkjmOQTUyQ
 UR1ZuZSsuNyeh2dO+kfdWeQkmWJ6sBaGSy5kzDLoSE81b6rSMfvhdkjnWyRQ7XY3qTMg
 a226O7uFhg1hqdnu0Ov9+iJIrLH0r+v54fajZUKF1KDe4PwrGn2H6TFVrk80pu1SYI6m
 05SlfZzA5gg9FZDoV2l0U3grBUZvu7SzUQIcIqkjYtyFSjWPetY4FY9sGsEctmhn3i0B
 9fAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ouGZIX16N7k23aqaPlMKraG3urpO1iCAJlk835dT/hs=;
 fh=I3MB7WAIpEpylwG45StbnAEODVsdEvWDVE/citOQT+Y=;
 b=bHDOU8da+vunQ4UpLv+o6WSbpKHLU2AYKFD1EE6w/6j6Lr7h6aEnjvVUhIN9y6QYD4
 exfeLNskM7S6IH+GUUdW+SKROjrFe6K9cL7gCVW7NO11RoLZmVYdwZQ7B5wMbWes+vp/
 I+XItJrcbuIe4fsq0NE8kT/Fi6LI+sOhLjQ7yV7ZJjipP1b/9+wWQQC1AKsXpMCeaCy4
 qmTOoSgKDFQXnUxLy3g6uV29Lq9EWVJwTkVWYH3gMixn7SObsH+CHVXHa/rkOppLIEPH
 81r3UqwTgFLJagMX3vECT//PPrhkqGYFTzEBiKFRtx5+xTJd6e1WcKUWMurK+vrTqAdS
 8/Ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779264856; x=1779869656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouGZIX16N7k23aqaPlMKraG3urpO1iCAJlk835dT/hs=;
 b=F5XrrNqzfdxsFv9EFqqQMtBT7X0AdrS0JN/jGG1SbBaEXw0kQYQrjdB7nYaOI3uU2F
 smf4yX5si4tbBsVB+d/q4DdPzPScF0KgSugBmvKtv5Me7JTIRrKuvVIcXj9w/dlh9zJM
 kT4e5NpqY6Wwl17HRn0U78+YSngL9+smcibtkb4SViKnG7cKVwz7sA+kA12hGAf9gyrz
 /F7GhYCFeDs/vEZ1NS3D7eTT50vGU1b9F3fDtsv7leFLxBqVwF1TEcD9+p1veuAOpZRo
 RzJBwEtcYProeuvEu4y4GSjRf9cxqkeZw2hUkC3SD8LkSXd55XH1/mmTtuiAGtinqfsQ
 yd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779264856; x=1779869656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ouGZIX16N7k23aqaPlMKraG3urpO1iCAJlk835dT/hs=;
 b=XzLxOF8e3cIsdOi/WiMC0lBZjDpIwRfNEosJZmdQCAPPf4X0Qd/tOcVCOquXtMYzkP
 xuOehM/pmPwOPJjBtCdjn/ODblRo9cybXxsZew2o3M7RJNjPhjEqOC9inbJDZvRQxR4R
 7Q5uGgFU50jLTxBEwfdLJsFjKhL0qEzfFaioLct7A9Wm6MVOmYkbdHGXI0SXkQhE7POC
 Ue3tZXlCIWsgUr4vQsmu2VtwNtqYjTXjj6XyuJU87Dlb04RiXxH+NE0yjiYlREPxU4wh
 /lSlhs7KgWuoszcelcZUj53I7rvJfcISuO0yNSPmWYhXq80YJIEnemX8gCfYSTUJUaPB
 7ZVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PuSqvc9Aeo+jXMBDDIumxggiIG8LHWQ68kUTHuGmxYT3Gda5XhfW2j48tdEg4XdBoI7ufsbBY9IA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1aJ+8FjfWu9PQlGz+mINJFSmA4J9f9OGE+26jphMbKNWObq31
 bzY6GImm9WTtgm3fKPF6jTpQUljzHejKUyI/cHrguJz+85UNZskcX6Udn+LWp5SBKlnfROJ9ss+
 U11LV+OcZM1ln2HJ5HZNUvq0ykEj6vEU=
X-Gm-Gg: Acq92OH8BATp/upSbE3s+ioJmFBiyR2UCsbpzzcJE8gIIcJxwkERFhmIKB+zsM4bQnW
 OQUVWcumqf+8rR7LLI+5ZCneDBWCwliywOLN9cXSIjHOg3gw6wK2ZzROhbLHSRDtxiXXpiT3k2z
 O+AmykREdqCaRvBiLTz8wq5W68eF626Rl2CUzHKcUH5ZqE9WWJ4Ja+0emHpNw2Ml7Jx2LLYqd7M
 osJcQtsCIYNmlzo6SDz578a0oxdbJVICeT1QnxyY+w6yH6LZl9SDH99IDypZQi3S4WPH2GCPqyY
 hXWursy6v30e0sJdUmg2bIb9YNkBQy+6zq6QbGkSpc3XOuNiSALaZPmvo3Qkg2gRynyNGw==
X-Received: by 2002:a05:6000:402c:b0:453:9897:76aa with SMTP id
 ffacd0b85a97d-45d93eccfbfmr43930776f8f.21.1779264855863; Wed, 20 May 2026
 01:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260519160825.4082566-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY3PR01MB11346AD5B7CDBB72EC8FEA16686012@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346AD5B7CDBB72EC8FEA16686012@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 20 May 2026 09:13:49 +0100
X-Gm-Features: AVHnY4K6O83Oaua7x5OeGyEOVQr-EpCuxk3Ub_S6X1YfPWB6IzfjGTmlm_zyy3E
Message-ID: <CA+V-a8uReGLazx5xPfCG+EfSeT_zDy-xfq8Et2pEkmgOKT+8QA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm: renesas: rz-du: Move mode_valid logic to
 per-SoC clock limits
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

Thank you for the review.

On Wed, May 20, 2026 at 6:36=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 19 May 2026 17:08
> > Subject: [PATCH v4 4/5] drm: renesas: rz-du: Move mode_valid logic to p=
er-SoC clock limits
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Move pixel clock validation from a fixed encoder check to per SoC const=
raints stored in
> > rzg2l_du_device_info.
> >
> > Pixel clock limits differ across SoCs in the RZ DU family and cannot be=
 expressed by a single shared
> > rule. For example, RZ/G2UL and RZ/G2L limit the DPAD0 pixel clock to a =
narrow window, while other SoCs
> > such as RZ/T2H require a wider operating range.
> >
> > Add mode_clock_min and mode_clock_max fields to rzg2l_du_device_info to=
 describe the supported pixel
> > clock range for each SoC. Update
> > rzg2l_du_encoder_mode_valid() to check these bounds when evaluating
> > DPAD0 outputs, returning MODE_CLOCK_LOW when the pixel clock falls belo=
w mode_clock_min and
> > MODE_CLOCK_HIGH when it exceeds mode_clock_max.
> >
> > Populate the pixel clock limits for both the RZ/G2UL (R9A07G043U) and R=
Z/G2L (R9A07G044) variants to a
> > minimum of 20875 kHz and a maximum of
> > 83500 kHz.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v3->v4:
> > - Dropped per pad limits
> > - Updated commit message to reflect the change in approach.
> >
> > v2->v3:
> > - Moved clock limits from device_info to output_routing to allow
> >   per-output constraints.
> > - Updated commit message to reflect the change in approach.
> >
> > v1->v2:
> > - Dropped storing info pointer in struct rzg2l_du_encoder as it's not n=
eeded.
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 6 +++++-
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 9 ++++++++-
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu=
/drm/renesas/rz-
> > du/rzg2l_du_drv.c
> > index 0fef33a5a089..1e4b9f38c55b 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -35,6 +35,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a=
07g043u_info =3D {
> >                       .port =3D 0,
> >               },
> >       },
> > +     .mode_clock_min =3D 20875,
> > +     .mode_clock_max =3D 83500,
> >  };
> >
> >  static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info =3D {=
 @@ -48,7 +50,9 @@ static const
> > struct rzg2l_du_device_info rzg2l_du_r9a07g044_info =3D {
> >                       .possible_outputs =3D BIT(0),
> >                       .port =3D 1,
> >               }
> > -     }
> > +     },
> > +     .mode_clock_min =3D 20875,
> > +     .mode_clock_max =3D 83500,
> >  };
> >
> >  static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info =3D {=
 diff --git
> > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesa=
s/rz-du/rzg2l_du_drv.h
> > index 58806c2a8f2b..885558eb9547 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > @@ -44,10 +44,14 @@ struct rzg2l_du_output_routing {
> >   * struct rzg2l_du_device_info - DU model-specific information
> >   * @channels_mask: bit mask of available DU channels
> >   * @routes: array of CRTC to output routes, indexed by output (RZG2L_D=
U_OUTPUT_*)
> > + * @mode_clock_min: minimum pixel clock in kHz
> > + * @mode_clock_max: maximum pixel clock in kHz
> >   */
> >  struct rzg2l_du_device_info {
> >       unsigned int channels_mask;
> >       struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
> > +     u32 mode_clock_min;
> > +     u32 mode_clock_max;
> >  };
> >
> >  #define RZG2L_DU_MAX_CRTCS           1
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers=
/gpu/drm/renesas/rz-
> > du/rzg2l_du_encoder.c
> > index 0e567b57a408..56220139a149 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > @@ -50,8 +50,15 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *enco=
der,
> >                           const struct drm_display_mode *mode)  {
> >       struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);
> > +     struct rzg2l_du_device *rcdu =3D to_rzg2l_du_device(renc->base.de=
v);
> > +     const struct rzg2l_du_device_info *info =3D rcdu->info;
> >
> > -     if (renc->output =3D=3D RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83=
500)
> > +     if (renc->output !=3D RZG2L_DU_OUTPUT_DPAD0)
> > +             return MODE_OK;
> > +
> > +     if (info->mode_clock_min && mode->clock < info->mode_clock_min)
>
> I will avoid checking the first part as it is mandatory for SoCs with DPI=
 support
> and DPI check above make sure that this part of the code is reachable onl=
y for DPI
> output.
>
Will you fix up while applying or shall I send a new version?

Cheers,
Prabhakar
> > +             return MODE_CLOCK_LOW;
> > +     if (info->mode_clock_max && mode->clock > info->mode_clock_max)
>
> Same here.
>
> Cheers,
> Biju
>
> >               return MODE_CLOCK_HIGH;
> >
> >       return MODE_OK;
> > --
> > 2.54.0
>
