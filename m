Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C31EC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39FD10E63F;
	Wed, 29 Jul 2026 05:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DjFzZLn/";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DCA10E63F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:26:59 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b29599b81cso542975e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 22:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785302818; cv=none;
 d=google.com; s=arc-20260327;
 b=RMQ7mBLCh/3wDy4G663s28KcjL2y74FB6CeBpLiCcA7io8BNf2yoSu8sVAixyAT8vH
 wN4dU5qPlA0BmgS6Sgn6YfYphEBC8/oF9N34amHCDLeXqAIli6PQV7JKHmW13u5LehWs
 z3nFMb1I7xO66FMFc7G2A2orJzlsjIUR82M6WxbFyJXLoP4UEpIugkttgJmQstJnl3jw
 boxhaJtU74Hg6SAeLi2WsMx3Ce8mAXDRcUFTWWO4XzQxPGI2unbTPVKTlFzX1SW79rxr
 t/JtX3kvprZjEKTht7g54J7kx7bT4G0O/indoThO7IktY33p6Jf6OB8VxATRV2n0imZ2
 IlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1gq5mVrsBxUmsAUg+v2KspXYM+4/OX/vO7HmHZRJjaU=;
 fh=Zwb99hHpJKVI5/pG1UxrgO6FXAUm1o+haDi8/4AaTgc=;
 b=qfvei8BJXNxNlftWxqRe7b4xHarPvTRLibDXIwJ/WZj3AIJF7NHn3xNEYWbLR9+sr+
 5rXxmmFbX+g94oaxMCoLFJQMzejK/ZmdR1d57FVZjRg/9JCKyJcp5K++2njLyTJjHk/+
 GS+giXAK7aXiriHzxxUrNHwqEhw00g+aM425Iyt8buM7qOef+ZvAELhV7Zd/xJzMNeNh
 kBZgb6AIJqFePGMtHGU2Tt5ypgcD1cygJpmPyUGvyJXuI3LtgSO0WWt5F/QO30VtH9TQ
 Gj62liV9KmaJ21rhZRmmAFlHVCAL+BTz57gpHxOXZjSymU49718F1SaXqvRZ9lapqYjU
 J6cg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785302818; x=1785907618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1gq5mVrsBxUmsAUg+v2KspXYM+4/OX/vO7HmHZRJjaU=;
 b=DjFzZLn/yg7+gE7azQt1jSodSYNYiFLxjP1busYRGD2IADwyZDqwNShw4xnKjyonlC
 St4zvu1ULHrduJoSTM2Xz/fdU+h1W2K1PRJ4sgIvIPCqB4YiRTKuMpXRdRpnHbfARQLy
 Gv73mQstC0UNmJ0KKjZ4kVE6Cjt0bo4dzUa1/VOQ3lN+5nENjMFgDodSNKpQSQxGDtMk
 YsJ8uySmFJTWqON7T7nPHeFTQruKnYa98n+LtjtVSSQC6Oc9SKaw+b23a5prtq6c5PYo
 thcotISgvbHRik9A26j0gasz9nk1sl8zggj8Nsk4wYv+tE3IBvhR/4tnAmtAjDeQatzm
 3Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785302818; x=1785907618;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1gq5mVrsBxUmsAUg+v2KspXYM+4/OX/vO7HmHZRJjaU=;
 b=sL39GBR0H8V+aV/b4jfVwBGRqfYDKiyIXepPk9r9svdzpBIicxyI5MEzioGg18E3xq
 mgnq3IZvP4g/Gba8wfk0FMff4OcdiydCRO6mbRnOsf1imLWsgvTskxZvwqMmL730PmKK
 6QSWBKcYbhLeYscUz6yxJjcdeyb6kxZqab65q5BvSXOzztaGst6E3/NUDblNXbTtJve3
 wVvlG0zVG0F3QO9p7MdqH4d0aaZoh8XBM+JrFVpgPqOdTK2+jgucupidah9VXhBrMph6
 Sxld5Hd6eVG4dGKa074pV/GN3jzT3LFfYI71VbeRRb4O4/ZTUElNq9hzxzztzFmy7/te
 kKgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGdZsbG5SMq1ZPFLiTTraM1p5sa2bji5LaOy0AJLmbOH8TLK2l78FhLbbEUbcqzGnUGNje0eRr47w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNrupl+hGWpMClfN58fMo8SrWEjqL2d0Quci7lQSRlUTUngEhL
 lWpf3DqxXj0dESGdDQhr8C4HITxLPRmkzdlWnb26a7nFGhLRRU1lwM9nSMIHSlP+wQT7953gi1y
 Pc/I63qI4RLhBFZc0P3LF7Gg7jJZhhf8=
X-Gm-Gg: AR+sD10cOD75lBD90kwIDMg1w9Xkyvqz6GDcnAVLpSLNiQY+1+cbZqIg+nU4+pMwyS7
 1pI4nIRBK0cq/WDGO9FD4RwrgwT0oCtKZjF1i0O+y0zZKa0CY9QBoNiOmx6UhMSTGtcm8iGty5r
 YKycDzjHxwHJ6ChaKL6ipMIWvPu7qkfAQ3v9TsaOrngU0MzTiW83WwolDasgncVaICUYI7JtrZk
 O+b65JCZzzKsY0AZBCMCGlls95LC+mFoRLMdYbZFt6wVyKRZ3IZDH9aiYayTD0MDA9uthDIYtNE
 l5QAYlIMOCdn8aVNobvTCQBS65jCWCOvEhR6GeVbq3CSWw2gzuB9iLz06GhcIjTQ5TEOxkzISPG
 mv3mztIMRNkIGZMlrdG1YJ1pkWKSp+g==
X-Received: by 2002:a05:6512:a81:b0:5ae:ae75:5c43 with SMTP id
 2adb3069b0e04-5b2d026b739mr981596e87.49.1785302817446; Tue, 28 Jul 2026
 22:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-icna35xx-pps-v1-1-691d79d13ee4@gmail.com>
 <36c73363-faa0-458b-92f3-31096ebc6139@linaro.org>
In-Reply-To: <36c73363-faa0-458b-92f3-31096ebc6139@linaro.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 29 Jul 2026 00:26:46 -0500
X-Gm-Features: AUfX_mzFJ70aZtLZDu7i5aeFGvu_iHQXX3Usojuj4ueRKSP_gR2PwLffBXaK4B0
Message-ID: <CALHNRZ9CJAY3cfVqcujG+LW91DXQe4UDdXMp=r3+fBMDB3rS4w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: chipone-icna35xx: Fix picture parameter set
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Jul 28, 2026 at 10:33=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 7/28/26 03:02, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > These ddic's do not handle the standard mipi dsi command for pps.
> > Instead, there are per chip vendor commands to write the packed struct
> > directly to manufacturer registers.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>
> Any Fixes tag ?

Ah oops, I did forget that.

Fixes: f747473a838ec ("drm/panel: Add panel driver for Chipone
ICNA35XX based panels")

>
> > ---
> > This patch results in no change at runtime because the ddic defaults to
> > the config being set by the existing mode. The issue was found while
> > doing testing running the panel in a 10-bit mode. But since it is a rea=
l
> > problem, better to fix it early.
> > ---
> >   drivers/gpu/drm/panel/panel-chipone-icna35xx.c | 20 +++++++++++++++++=
+--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c b/drivers/g=
pu/drm/panel/panel-chipone-icna35xx.c
> > index 2cc16494a4cef..b2422ffc1d1c5 100644
> > --- a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
> > +++ b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
> > @@ -69,6 +69,7 @@ static int icna3512_init_sequence(struct panel_info *=
pinfo)
> >   {
> >       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D pinfo->dsi }=
;
> >       struct drm_dsc_picture_parameter_set pps;
> > +     u8 *pps_ptr =3D (u8 *)&pps;
> >
> >       pinfo->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> >
> > @@ -91,7 +92,14 @@ static int icna3512_init_sequence(struct panel_info =
*pinfo)
> >       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x20);
> >
> >       drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
> > -     mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> > +     mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
> > +     mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xC6, 0x11, 0x88);
> > +
> > +     mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC7, pps_ptr, 32);
> > +     mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC8, pps_ptr + 32, 32);
> > +     mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC9, pps_ptr + 64, 24);
> > +
> > +     mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0xA5, 0xA5);
> >
> >       mipi_dsi_msleep(&dsi_ctx, 20);
> >
> > @@ -104,6 +112,7 @@ static int icna3520_init_sequence(struct panel_info=
 *pinfo)
> >   {
> >       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D pinfo->dsi }=
;
> >       struct drm_dsc_picture_parameter_set pps;
> > +     u8 *pps_ptr =3D (u8 *)&pps;
> >
> >       pinfo->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> >
> > @@ -133,7 +142,14 @@ static int icna3520_init_sequence(struct panel_inf=
o *pinfo)
> >       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2, 0x24);
> >
> >       drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
> > -     mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> > +     mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
> > +     mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xC0, 0x1A, 0x71);
> > +
> > +     mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC1, pps_ptr, 32);
> > +     mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC2, pps_ptr + 32, 32);
> > +     mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC3, pps_ptr + 64, 24);
> > +
> > +     mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0xA5, 0xA5);
> >
> >       mipi_dsi_msleep(&dsi_ctx, 20);
> >
>
> Otherwise it looks good.
>
> Thanks,
> Neil
>
> >
> > ---
> > base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
> > change-id: 20260727-icna35xx-pps-bdd353e188cc
> >
> > Best regards,
>

Aaron
