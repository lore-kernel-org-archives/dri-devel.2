Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AD4CD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 20:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D7310E07B;
	Sun, 17 May 2026 20:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qyhwZREc";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A426C10E07B
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:30:55 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso17585745e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779049854; cv=none;
 d=google.com; s=arc-20240605;
 b=DzTpzMo0a6Y9ofj0+PZmMh/WJOEvxvfaUgNBdmnvinszSuF3IZKvNAgSnBmFcYQsMf
 FoBlkDFOdJVRn6zieT0VXP4J1VNM19Vp3nqvT45x4YMnXIGzQUkE5SrJeBvusLZTQgWu
 IvnGT21CohJNeaG3dkIuAFe297fnAyQaQ+i2AzWizmIBlIcH6eWrcAMREp/ASXtUa3+n
 tVXbYaktIVp4pamlSBcnXZBK+Oz6kfxKzqEAdJlqrGpyBOB44rokB2WzHZ4nQZQnJaff
 2c5AIfKDmsoAOwvNRoBc3dIp4G9ctSWfIJzrrKYnlcgd3NzJAyrBjgKIydh1jZr8xmC5
 rUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m5W2yksOeDngCRoP0/L217ADV5Bob6V0u6vG3fCF/SQ=;
 fh=EIwFpjYLh/ZlLqajPhmJDYfFciQcIdWXtd8MD8KSCoI=;
 b=BtlLZAWlQFRMPJjq+RI+tV9y2Xmxalwrujcpqu5sWbZjfth0gNseFaacOQG7L3uNK7
 FzRKj2sObLZQycY5/evWZ7EUI9c7ezWcL2nbS1n1TKXABAPc2U+uAJ8bFI5uQMGhTDex
 1i7BLrZY8YWwgsYnVd6K50EnfLpqmoxVm2MUO72RPMOqLPczZZlP+A3L0qNLcq1KmO34
 LpYKry1ysRZ2fccxrG+3AjURNxWb3dOOXR+TYU04P3wd0v4PPJ0JMxxvBMohIC1K7YnT
 0AFwNLoLysky5GS4h1wb0zQqbcT6xCOxhM6RduXANjIvusIGURVCVF6phttGm7UuErBG
 c3bg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779049854; x=1779654654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5W2yksOeDngCRoP0/L217ADV5Bob6V0u6vG3fCF/SQ=;
 b=qyhwZREcmO6Z3g1bOJes02P3MYDEb07X6YIyNW4z/zhoQlZdc7cnnbwURK8H2xo24v
 ZJe1ugbb98BktGr/qmAsdTYmKMmLFIRAx+txdA0sKrGo6yYYuuWomDECSqzuS7QMhESL
 QCclBu4ylhQLdFMHk+70pe/ITYSi6p0rSfIYBLr2yAc38z50z53JqLsFLaQlweLOq/CK
 xZf7w5hLkQoL1hYHbpRdYhEzwkXjlZvtoSrEpsf7X55J+ZGTQMYs6oFTSn37bZbgAzBq
 T+5/WnR2FQHNwtMrnmnRDJtygAyc8mRcUFTulQPKeq0jL5OmT/mz6q0MjL9aIckNW+vV
 5VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779049854; x=1779654654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m5W2yksOeDngCRoP0/L217ADV5Bob6V0u6vG3fCF/SQ=;
 b=s4L+yGNQRtboouM+MokGc2ICEqBI7eu0Xsm2ZAoyRao1HIH/azYIXlY1ATCaY8Y30z
 0H21RQMqLWisO0GawFFR88FzbFjJFGnoFYx1X4VAqxLW41ooIti5ZRFyPAuam0BsPpU5
 q22u3bs9WroSORJRKW+3wQD4643QeGlAQReOVwm5ZvdROn1FPdm5h4IH4aO1QfqUF+Z8
 RYrwLDcmZFaPuQ/gI+TA6BgEM/fjTujLU+3O9tyXaTKdqIIrWpCxf2Opc+o0gFPyWE/q
 A61NKdCQ5glfG6nmeBXfUZ/Zq5Xsm/r7zJMjz2IEvpzrxrJhK39ig4PvVU9yMDfJ7tCV
 933Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ekf3+w5i5azC6JAXWm4Dg6+S03dKJU9px7Xjmvig6L3QWqC9/XAV3FVxA7+cQLIa8E+6acubFZFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2CQz+6KEl5z/2mkTix5qNCBPmXqkdm34yzXBTMRIaPmaOKTko
 EKrP6Gnu8ij1E8wm4emvMTihYIjbvNcoM4v3pYftGd7uslSQjoq0tnD8ZIRLWs0RiYSHIBAu20q
 JwVGx6FH3q55Rl0dttwAYPODniTCG214=
X-Gm-Gg: Acq92OEHt4pcxY2lZMdDX3e1mXfFD0daqD1cdCFEyJmMX7tXEd9qcu03aAbnfp5G76e
 jptIBUfKTMKqoyAkdDrUEEkCv9ODGYGnpsVXq5OeoVvn/E0iu9q1LB8i2XPvX9/lzZlo8RqhGWK
 IhiZxdbMrHmz0EabNxxXA3TNN7LjC6nmbIrvb8uxrgOex90q4DGzZBfY8PNmog/Ew0YcSlUJ8S1
 +q2zj3QrFzqNxeFpjGrKQe9aGVSzfMcMy0QOycy+YsxpstW8SVmQdVikHNEXo7unypVmqec+P7l
 zwQgfSK+y/LGkIZr6rgwGX10DmaAkVjkH7AWqy2zWvCk9koI1aWerixTFTnpq3ZLFjlCNup9LYp
 tN7Q=
X-Received: by 2002:a05:600c:4e02:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48fe6322416mr195114775e9.18.1779049853553; Sun, 17 May 2026
 13:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260512144104.761531-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY3PR01MB11346174DD5FFD70AB39F570086022@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346174DD5FFD70AB39F570086022@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 17 May 2026 21:30:26 +0100
X-Gm-Features: AVHnY4L4Iw5hWO4PauuBTrDRjWPhgs5UmEFDfgWOBP_KZfNbj_cxu6qjfmeyJWg
Message-ID: <CA+V-a8v_gmPEcWgFsC3Kv4X_M_qzbVHeEY=EmzdYxzy+PkyB-Q@mail.gmail.com>
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

Thank you for the review.

On Sun, May 17, 2026 at 6:59=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 12 May 2026 15:41
> > Subject: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic to p=
er-output clock limits
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Move pixel clock validation from a fixed encoder check to per-output co=
nstraints stored in
> > rzg2l_du_output_routing.
> >
> > Previously, rzg2l_du_encoder_mode_valid() applied a hard-coded 83.5 MHz=
 upper limit specifically for
> > DPAD0. This approach cannot scale across the RZ DU family because pixel=
 clock limits vary per SoC and
> > per output interface.
> >
> > Add mode_clock_min and mode_clock_max fields to rzg2l_du_output_routing=
 so that clock constraints are
> > expressed at the granularity of individual output interfaces rather tha=
n globally per SoC. Update
> > rzg2l_du_encoder_mode_valid() to look up the routing entry for the acti=
ve output and return
> > MODE_CLOCK_LOW or MODE_CLOCK_HIGH when the pixel clock falls outside th=
e declared range. A value of 0
> > for either field means no bound is enforced in that direction.
> >
> > Set the DPAD0 pixel clock limits for RZ/G2UL (R9A07G043U) to 20.875 MHz=
 minimum and 83.5 MHz maximum.
> > RZ/G2L and RZ/G2LC (R9A07G044) share the same DPAD0 pixel clock limits.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3:
> > - Moved clock limits from device_info to output_routing to allow
> >   per-output constraints.
> > - Updated commit message to reflect the change in approach.
> >
> > v1->v2:
> > - Dropped storing info pointer in struct rzg2l_du_encoder as it's not n=
eeded.
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 4 ++++
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu=
/drm/renesas/rz-
> > du/rzg2l_du_drv.c
> > index 0fef33a5a089..d1bc205eb5f8 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -33,6 +33,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a=
07g043u_info =3D {
> >               [RZG2L_DU_OUTPUT_DPAD0] =3D {
> >                       .possible_outputs =3D BIT(0),
> >                       .port =3D 0,
> > +                     .mode_clock_min =3D 20875,
> > +                     .mode_clock_max =3D 83500,
> >               },
> >       },
> >  };
> > @@ -47,6 +49,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a=
07g044_info =3D {
> >               [RZG2L_DU_OUTPUT_DPAD0] =3D {
> >                       .possible_outputs =3D BIT(0),
> >                       .port =3D 1,
> > +                     .mode_clock_min =3D 20875,
> > +                     .mode_clock_max =3D 83500,
> >               }
> >       }
> >  };
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu=
/drm/renesas/rz-
> > du/rzg2l_du_drv.h
> > index 58806c2a8f2b..307ae70dd382 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > @@ -30,6 +30,8 @@ enum rzg2l_du_output {
> >   * struct rzg2l_du_output_routing - Output routing specification
> >   * @possible_outputs: bitmask of possible outputs
> >   * @port: device tree port number corresponding to this output route
> > + * @mode_clock_min: minimum pixel clock in kHz
> > + * @mode_clock_max: maximum pixel clock in kHz
> >   *
> >   * The DU has 2 possible outputs (DPAD0, DSI0). Output routing data
> >   * specify the valid SoC outputs, which CRTC can drive the output, and=
 the type @@ -38,6 +40,8 @@ enum
> > rzg2l_du_output {  struct rzg2l_du_output_routing {
> >       unsigned int possible_outputs;
> >       unsigned int port;
> > +     int mode_clock_min;
> > +     int mode_clock_max;
> >  };
> >
> >  /*
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers=
/gpu/drm/renesas/rz-
> > du/rzg2l_du_encoder.c
> > index 0e567b57a408..4af2ae09ff39 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > @@ -50,8 +50,12 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *enco=
der,
> >                           const struct drm_display_mode *mode)  {
> >       struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);
> > +     struct rzg2l_du_device *rcdu =3D to_rzg2l_du_device(renc->base.de=
v);
> > +     const struct rzg2l_du_output_routing *route =3D
> > +&rcdu->info->routes[renc->output];
> >
> > -     if (renc->output =3D=3D RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83=
500)
>
> Please retain the check for DPAD output, to avoid checking the same for D=
SI and LVDS.
>
This patch checks only for pads that have added constraints.

Cheers,
Prabhakar
