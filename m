Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B620CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E56E10E8D0;
	Mon, 18 May 2026 14:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ae41LUKD";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A21110E8D0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:57:14 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-13246a5110bso122119c88.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779116233; cv=none;
 d=google.com; s=arc-20240605;
 b=HKgqFZ5SXdi6hg5cLB5eXYvBbRWydLIygdoLRmym2ht7MLlOlA5c8Q0cy0CqyEENHg
 xI2oTZAhPDJ6qgC/Vwf9Z+Y05yRRN1CGnZUcBEjc0fxbz0JplLtL6GO59ZVZEd3+N4FX
 1Xai0heregaTngxTVY4ApxCX8KSTqrCMcA1TQc1reIDvzD+qHoga21a3tp/wjUlVz/Jc
 kmWc+ZKPebQqXYS4ZXl4evf5gpZ1+yMKmJ/r9ihEan+/v6Sj14g8lQOlXpCiKQDTe+lr
 gmr2S8TTHByAp9+BClmWXShNF4d56nW3mRv2Xz4P4Qn0mgtr962ss27PIzLwpR6eTdnd
 J6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xq8u5f31pXaP8oXObK+OzpJM6Tn9XjFRH5zwjKhcZoU=;
 fh=Mwp0wHPPbitEux4353AuU2cToNIOjfju4fbdM92ovSI=;
 b=Ixk257qR+vRQ4VyC9/JGyTwrBnG3++jGDrK9/+gfEVGdqKiw2qdNJ59O05jhjd0v8d
 iwcFf9BVvyBnssruCbJCauckCf2vBwVvuiMn0quGNETQN+EvJI30Jf2vLuGipZe/8x46
 o80UZAYgVPUHO39l26hyafNS/uy4VtAaujMX1rQtwwoxumP26dV1s478s70c27vkr6Jd
 5c9yE3sA8fPWKA4gNI2wuFxTyzs6OlXVy690+ajNyV6QxfrNeBILBa6PwmThZtmv0I8s
 BvjNJrWGuqP7FbOI9pGnmL0sfpJKSFOjtTSCd301/qYdzyA2iZYucrV3h/S1v8dJxjD9
 Fiaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779116233; x=1779721033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xq8u5f31pXaP8oXObK+OzpJM6Tn9XjFRH5zwjKhcZoU=;
 b=ae41LUKDXiSkQ3+2In3IWiUkJqKj7gbvbUAbl/k36raIoSudOY5IbMzKoiIoF3cYHz
 TI6N53np4+bHEkwhD36riIfoaYpAHec3K0evgnmz++lxxS+w4Gnd1ZyAGvb5/17vdECR
 qrCtzU9Hgt4QZ79yuGtqrma5mn0f91fhzvu+VscM4yr2IC+FnEr8jAisVnw/gg9o4aRn
 xkl7iG25dHHI94K+tMja+W8+tp7Olh2wgBrUHSV38+o/lk5H3+BkGNRXF1lqGptTs6oX
 WFXTmoB/k9XM9XdWemoVqKcdqejxnfYk/yYl7MH/YvPMru5fK9y3iMDFhZoEZyDfqsoK
 vLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779116233; x=1779721033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xq8u5f31pXaP8oXObK+OzpJM6Tn9XjFRH5zwjKhcZoU=;
 b=ae/MxUKwrTDTSyPtdkkYTHhskkTIGWeHBwqXVHhwvQ/swPLhRiNF4Rdv6FXD9FAQY7
 r01Hc8iDgOr7850QQXKSkGlY3whV1lGnLaQQ1A6RnC3IsNLIcBdO0Ktr2qjzdY4q9kdn
 4yFMihqPqjvQVmJpfFTehBuwy1oKJtpJ0WHPnQanfP4XS2siHQn6R/+frOEsUlhlkPkL
 UQ+fmvHHnwtDrLiHIKAoAZCwJjBeNsrIj+5/nqn0bqufheb1Bww/jrcmtaNsQmnbyN5W
 UQf5xlhDIU76aAOHQRtM5OFqTr6k/ma1tLkkdxc2Rcdi8coqcejlssVcSWGVoFoP31Xn
 R1yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/G5m4hfDI7zjPTEDdEeNVeTt/pK0CCn01CR2Gk51I/C28IFEulCpgrbLh9ZZ8qLx3z232bt3m36Qo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJ3dcCiymlwagLYF7rV6DyQ9Lbu6LVHKeOFXRu0aJYHLEShvlX
 hWS5hh4VZpJsqpXUr8qVzGL2/r72joiGweqLG53QiHOiQ+/u7xkn/YKQzqx/heA8RPo5XtlN9WE
 UjvHcdlbwQa5A1etOQ22EyzzeCr7QU7Q=
X-Gm-Gg: Acq92OEnF7t714yQvtmdGZWeX9fIqTbH2/q7QBartsNGgumsoHgAX5SjCyG/9tKuQGH
 oPwsLc55DObQA9sV9m9MKdpvq5PmPppHL015TZCY+DZGimGxym4G4Q7t7BP2MjGi02Pog7p5OMw
 OXIX6TqeGCrw5et0WWW9rCjs2yBGyytFDPlmDrcya8HbaJ2GRBwVVCLrL4ujzryBKb6KL8qP0OV
 ABUy9/I+XLccyj6qjmLlpzG9bn1Vk52FLgYos8mG6ezTD7jjQZAjsf/MCF9Iq2vJMEiEzCfGOyn
 7TnT5KL4FR5gRJTCMlyKrq94Dfcuvz43rAyVj8bzkY2rYv0QU2yWs80k0gAZ1MA/ocVEJg==
X-Received: by 2002:a05:7022:6994:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-1350483f16cmr2784227c88.5.1779116233412; Mon, 18 May 2026
 07:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260516092420.3579-2-gilles.risch@gmail.com>
 <20260516185226.3005-1-gilles.risch@gmail.com>
 <CADnq5_OZ8c4r-b6EzWCWuPA4BfDWs99ypJx-tS0FBuRZqHzH8w@mail.gmail.com>
 <CALnjqVm06ZJ0mAE9=mQdPwDrNu0gtPmsQpwzn0NDbXDNugvJxg@mail.gmail.com>
In-Reply-To: <CALnjqVm06ZJ0mAE9=mQdPwDrNu0gtPmsQpwzn0NDbXDNugvJxg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:57:02 -0400
X-Gm-Features: AVHnY4Ktkg12a4pMf_elgsPpmUvCgTmiiwYBKdluESGgIbHvvkDDAQcByDdkP4E
Message-ID: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix eDP resume from suspend on iMac11, 1 /
 DCE3.1 systems
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Mon, May 18, 2026 at 10:40=E2=80=AFAM Gilles Risch <gilles.risch@gmail.c=
om> wrote:
>
> Am Mo., 18. Mai 2026 um 16:13 Uhr schrieb Alex Deucher <alexdeucher@gmail=
.com>:
> >
> > On Sat, May 16, 2026 at 2:52=E2=80=AFPM Gilles Risch <gilles.risch@gmai=
l.com> wrote:
> > >
> > > After suspend/resume the internal eDP display on iMac11,1 (and
> > > potentially other DCE3.1 systems) stays dark because
> > > atombios_set_edp_panel_power() skips panel power control for
> > > anything older than DCE4.
> > >
> > > Fix this by:
> > > - Extending atombios_set_edp_panel_power() to also handle DCE3.1
> > >   by changing the !ASIC_IS_DCE4() guard to !ASIC_IS_DCE31().
> > >   HPD polling works correctly on DCE3.1 (verified: HPD is asserted
> > >   at iteration 0 on iMac11,1).
> > > - Issuing ATOM_ENCODER_CMD_DP_VIDEO_ON/OFF for DCE3.1 in addition
> > >   to DCE4+.
> > >
> > > Tested on iMac11,1 (Mobility Radeon HD 4850, RV770/DCE3.1).
> > >
> > > Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> > > ---
> > >  drivers/gpu/drm/radeon/atombios_encoders.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu=
/drm/radeon/atombios_encoders.c
> > > index 4e984973c043..b62fd713efcf 100644
> > > --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> > > +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> > > @@ -1383,7 +1383,7 @@ atombios_set_edp_panel_power(struct drm_connect=
or *connector, int action)
> > >         if (connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP)
> > >                 goto done;
> > >
> > > -       if (!ASIC_IS_DCE4(rdev))
> > > +       if (!ASIC_IS_DCE31(rdev))
> > >                 goto done;
> > >
> > >         if ((action !=3D ATOM_TRANSMITTER_ACTION_POWER_ON) &&
> > > @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder=
 *encoder, int mode)
> > >                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(enco=
der)) && connector) {
> > >                         /* DP_SET_POWER_D0 is set in radeon_dp_link_t=
rain */
> > >                         radeon_dp_link_train(encoder, connector);
> > > -                       if (ASIC_IS_DCE4(rdev))
> > > +                       if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev)=
)
> > >                                 atombios_dig_encoder_setup(encoder, A=
TOM_ENCODER_CMD_DP_VIDEO_ON, 0);
> > >                 }
> > >                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPOR=
T)) {
> > > @@ -1724,7 +1724,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder=
 *encoder, int mode)
> > >         case DRM_MODE_DPMS_SUSPEND:
> > >         case DRM_MODE_DPMS_OFF:
> > >
> > > -               if (ASIC_IS_DCE4(rdev)) {
> > > +               if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev)) {
> > >                         if (ENCODER_MODE_IS_DP(atombios_get_encoder_m=
ode(encoder)) && connector)
> > >                                 atombios_dig_encoder_setup(encoder, A=
TOM_ENCODER_CMD_DP_VIDEO_OFF, 0);
> > >                 }
> >
> > These changes don't make sense and will break other DCE3.c boards.   I
> > had the attached patch from you in one of my old branches, does it fix
> > the issue?
> >
> > Alex
>
> While the initial attached patch resolved the dark screen issue after
> a fresh boot, this follow-up patch addresses the same problem
> occurring after resuming from suspend. Should I used dmi_match() to
> avoid breaking other DCE3.c boards?

Yes.  Even that is a hack.  You are effectively just skipping some of
the required programming sequences.  Presumably the mac is wired up
strangely or there are issues with its atom tables.  Ideally we'd sort
that out, but this hardware is pretty old so I'm ok with a hack.

Alex
