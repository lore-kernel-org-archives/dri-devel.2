Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F08CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C80A010FF4C;
	Fri, 29 May 2026 13:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nnx3uq4n";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61E610FF3C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:31:20 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12db2e9b5a7so389153c88.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780061480; cv=none;
 d=google.com; s=arc-20240605;
 b=Sg7Ig7Qyd56NNGHaBcdwe9GfMZfrNQRyT3NpYJegohC/PUtgzIidc0RI60gaFMxAKE
 tAoXNdzYj4Y8DzmJcIAgQnAhIYjV+oCR35QMS7qw8b74J488sbGAJ9K1bOzV1snE3y0h
 y+GUaFUOg+MMmh9tX77OsIPnpKVvLqK5vLv2PzUT67NAbYnvGwEuZMUaByvoeAPFKdGf
 6EGLpMaul9gttfdzJrg0Nrs8UtJkBRIdSjw8CpIcbYgJ0N/H94h/SgiwPGwG8GZq23Ws
 v4ts9HYJlqJal3zmvxb01yh86Laq2Z39TJetTv6SSlzth/KvNCXvDoO5udWo3zS4xuwE
 0rQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v6cPRqm8IHnVfrpS8wOaTOvXEDclNohXLKceEFLhjp8=;
 fh=jvLp8cT9giLMTA/tdIvzhILQaEh7SgOPxuPTPLwlJPg=;
 b=PtxaricUfJu4ghx2DTo128vCEoR2M213VIBz5xu8maH20atP7Z2RFr66IMOIPCA6Yh
 lE7lPQtAIVHB3flEzPX4IolMlhcRgVTOOD52bPCG7zR62pz6HIgQCWQ75w3lIuQtlCKZ
 pJdqFTuwpA+CCS5EL4H4xMGsSfWxiWpIQBr1t9jn1ZTVGCHBDWLIiImovWl6kJUG4nnq
 9+rDuXPN33iMkoAjexWkTg4pE6rIrasrcIXxxt2GajoufsIv+aTMtLr/UzbviSDTSZ4G
 OJ9+VUmuAHFLugIPkA4KWCcHDMrLDvp7bTs4P8jMYEPMkFkZwHfChazreqXfzFCw+aEO
 whQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780061480; x=1780666280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6cPRqm8IHnVfrpS8wOaTOvXEDclNohXLKceEFLhjp8=;
 b=Nnx3uq4n89i/+2tNwpEkLRPfF/PPmI73q9dLNUBfIhHyPExekhKrXLyZ6RfGJNYFBt
 Vx3uEkPGBUUs8ye2COl2lVZd01WHDCpkMV11u/Q5kNEkFT5rwEknu+0kasUi6+EdR6hm
 BFTh+zPUJn5hA8OsvOl0vuJPl/lD6bMIh4XPGxJ0L/xSihe9hUYSpeo0O+ReTXuUtKTe
 k0D05B0zwJAxTQn367YfSmdj7RoO3sL58ZvVAarobgpN2RwPl4KC5zx7TD0rH5M/mom6
 6vj3Mjb/FjL6oUlYX4UefgjWxCYb9Xx32lTezmZ5Qqcp5Op9JyucXe5Qd4hRDp7RVTgY
 fv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780061480; x=1780666280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v6cPRqm8IHnVfrpS8wOaTOvXEDclNohXLKceEFLhjp8=;
 b=dbglN+JL7aEhQeELTMT8nj17PiDYF/qazE8rwySO8B2U1mosOGEl8fk/5RwBr1UqnJ
 gRtTfPn/1tr+YZn6cuvtJniflAw8ygEJb0/E6Tw8p5Wl8YU1NpqcBW7G1Q9m+QQW74th
 44wjOfI+lRmO9r6Ln/b+Jjz6Qhg5H5ZsvWIL63H9+DzLFj2UumPr/ddXYM/jSNJrpgYp
 l3815bfDD0L2/U7iXAXnwv6KSa3TX5p4WxfyHBFiiJ1RoqtRX9o6O4kYoaj3edpG3VSw
 Gy5x2J9cCpUunbEGA4c/Q9HINATSMa5tDZ2MumuEsOneOOfwn6vT2eDEJ6RaT2Gvv8/r
 lzFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Kpz9yNzDaIwSdXGcRlw6Ilynlsokvjp9IfB7xmzziy0c2jEIJ9kzLSz4zOo8GSUBvCZnAM+2PKvs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynQYUVm8MJj20f5mPqb/YWvvB3ZbCbhTrdWxwPBTZYHmwgyD37
 BjpGgkXcQFyT+qkHcksKoT9myW85xnV9LDb9YBreEN8tdTCb9/UY3jfz4NimXWrTZPPD/kD0Fw/
 0yq1tKzEDwZ2LqoV7Sq8gJkNHblNCIF4xOQ==
X-Gm-Gg: Acq92OHR8+xWF4ZsIXDr85LVzGGIDUGtbqbTPgCSqVpdA50/pXvLonBR9Yk6zvcp4em
 URnQ6NcQxMxuHLl94f2ZLOjEjgzkHOE9lxTtViImPsa62gL41zAU0nuGDrTNqN0LC0uTo1njRc6
 rxTr2d9I0L6SKHKoVLsiC/FT28VOnu6lt0x4+3A1SzDoYmnApcwm1s++Cy3r73fGjDNZi+Ub2ly
 56C13HdC0UjlsXHoQT6VUCBrLBks8Xk83KB74xUy3hrF1cJo3DMCNOS/k5QxR09kLKr9vgMBOEr
 Pob6ms5wk88mfDaf9s6uDAcasYk5JEGLjK2RKs3c8xKSsRPJasQ6nO2DF8fmpsxZ1WQdBA+wbrv
 BU66L
X-Received: by 2002:a05:7022:618c:b0:12c:90f9:4da0 with SMTP id
 a92af1059eb24-137af00013amr550533c88.3.1780061479755; Fri, 29 May 2026
 06:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_Pq947+u3U-iVXLanuDQa_WxJKr_=DzJg1z+4rS334NqQ@mail.gmail.com>
 <20260527222012.2943-2-gilles.risch@gmail.com>
 <CADnq5_N5nM4Vn8=YbzBTJWcp8SEjMmb2KZurNqgqsxOpxQGUoA@mail.gmail.com>
 <CALnjqVky2zET5U5N_PEorrsWG4stHQSeTJZV6fA8G0q0XU5ZDQ@mail.gmail.com>
In-Reply-To: <CALnjqVky2zET5U5N_PEorrsWG4stHQSeTJZV6fA8G0q0XU5ZDQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 May 2026 09:31:06 -0400
X-Gm-Features: AVHnY4IlPL3S6I-gZw-2aHB-hkNVfot9Hd4ECfLF5UFC4BrHvDqXPMzhX4Z3y4k
Message-ID: <CADnq5_Os2Bk8Dd9d8m_CkK9nYSporzUqbiRA=YD85nRBB6XjMw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
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

On Fri, May 29, 2026 at 3:43=E2=80=AFAM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> Good morning,
>
> I'll make that adjustment, shouldn't I just regroup all three iMac
> machines in one if statement?

Yeah, that works too.

Alex

>
> Am Do., 28. Mai 2026 um 20:53 Uhr schrieb Alex Deucher <alexdeucher@gmail=
.com>:
> >
> > On Thu, May 28, 2026 at 3:39=E2=80=AFAM Gilles Risch <gilles.risch@gmai=
l.com> wrote:
> > >
> > > The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 485=
0
> > > (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> > > DisplayPort path. Without this fix the display stays dark under KMS.
> > >
> > > The same problem already exists for iMac10,1 and iMac11,2. Three fixe=
s:
> > >
> > > 1. Introduce ASIC_IS_DCE31() for CHIP_RV770 and newer. Note that
> > >    CHIP_RV770 precedes CHIP_RV730 in the enum, so ASIC_IS_DCE31()
> > >    subsumes ASIC_IS_DCE32().
> > >
> > > 2. Extend the Link B encoder quirk from ASIC_IS_DCE32() to
> > >    ASIC_IS_DCE31() and add iMac11,1 to the DMI list.
> > >
> > > 3. The 2560x1440 panel needs RADEON_PLL_USE_FRAC_FB_DIV and
> > >    ATOM_ENCODER_CMD_DP_VIDEO_ON. These are limited to iMac11,1
> > >    via dmi_match() to avoid affecting other DCE3.1 boards.
> > >
> > > Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> > > ---
> > >  drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
> > >  drivers/gpu/drm/radeon/atombios_encoders.c | 11 ++++++-----
> > >  drivers/gpu/drm/radeon/radeon.h            |  1 +
> > >  3 files changed, 11 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm=
/radeon/atombios_crtc.c
> > > index 2fc0334e0..075eba2d4 100644
> > > --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> > > +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> > > @@ -24,6 +24,8 @@
> > >   *          Alex Deucher
> > >   */
> > >
> > > +#include <linux/dmi.h>
> > > +
> > >  #include <drm/drm_fixed.h>
> > >  #include <drm/drm_fourcc.h>
> > >  #include <drm/drm_framebuffer.h>
> > > @@ -594,7 +596,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *c=
rtc,
> > >                 if (((rdev->family =3D=3D CHIP_RS780) || (rdev->famil=
y =3D=3D CHIP_RS880))
> > >                     && !radeon_crtc->ss_enabled)
> > >                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FR=
AC_FB_DIV;
> > > -               if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
> > > +               if ((ASIC_IS_DCE32(rdev) || dmi_match(DMI_PRODUCT_NAM=
E, "iMac11,1"))
> > > +                   && mode->clock > 165000)
> > >                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FR=
AC_FB_DIV;
> > >         } else {
> > >                 radeon_crtc->pll_flags |=3D RADEON_PLL_LEGACY;
> > > diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu=
/drm/radeon/atombios_encoders.c
> > > index 5cfd8fcfa..4de60559f 100644
> > > --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> > > +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> > > @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder=
 *encoder, int mode)
> > >                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(enco=
der)) && connector) {
> > >                         /* DP_SET_POWER_D0 is set in radeon_dp_link_t=
rain */
> > >                         radeon_dp_link_train(encoder, connector);
> > > -                       if (ASIC_IS_DCE4(rdev))
> > > +                       if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODU=
CT_NAME, "iMac11,1"))
> > >                                 atombios_dig_encoder_setup(encoder, A=
TOM_ENCODER_CMD_DP_VIDEO_ON, 0);
> > >                 }
> > >                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPOR=
T)) {
> > > @@ -2123,12 +2123,13 @@ int radeon_atom_pick_dig_encoder(struct drm_e=
ncoder *encoder, int fe_idx)
> > >         }
> > >
> > >         /*
> > > -        * On DCE32 any encoder can drive any block so usually just u=
se crtc id,
> > > -        * but Apple thinks different at least on iMac10,1 and iMac11=
,2, so there use linkb,
> > > -        * otherwise the internal eDP panel will stay dark.
> > > +        * On DCE31 and DCE32 any encoder can drive any block so usua=
lly just use crtc id,
> > > +        * but Apple thinks different at least on iMac10,1, iMac11,1 =
and iMac11,2,
> > > +        * so there use linkb, otherwise the internal eDP panel will =
stay dark.
> > >          */
> > > -       if (ASIC_IS_DCE32(rdev)) {
> > > +       if (ASIC_IS_DCE31(rdev)) {
> >
> > This will change the routing for DCE3.1 as well.  Probably best to do
> > something like:
> >
> > if (dmi_match(DMI_PRODUCT_NAME, "iMac11,1")) {
> >     enc_idx =3D (dig->linkb) ? 1 : 0;
> >     goto assigned;
> > }
> >
> > before or after the DCE32() block.
> >
> > >                 if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> > > +                   dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
> > >                     dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
> > >                         enc_idx =3D (dig->linkb) ? 1 : 0;
> > >                 else
> > > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon=
/radeon.h
> > > index 527b9d19d..6b7c0abe4 100644
> > > --- a/drivers/gpu/drm/radeon/radeon.h
> > > +++ b/drivers/gpu/drm/radeon/radeon.h
> > > @@ -2625,6 +2625,7 @@ void r100_pll_errata_after_index(struct radeon_=
device *rdev);
> > >                             (rdev->family =3D=3D CHIP_RS740)  ||    \
> > >                             (rdev->family >=3D CHIP_R600))
> > >  #define ASIC_IS_DCE3(rdev) ((rdev->family >=3D CHIP_RV620))
> > > +#define ASIC_IS_DCE31(rdev) ((rdev->family >=3D CHIP_RV770))
> > >  #define ASIC_IS_DCE32(rdev) ((rdev->family >=3D CHIP_RV730))
> > >  #define ASIC_IS_DCE4(rdev) ((rdev->family >=3D CHIP_CEDAR))
> > >  #define ASIC_IS_DCE41(rdev) ((rdev->family >=3D CHIP_PALM) && \
> > >
> > > base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> > > --
> > > 2.47.3
> > >
>
>
>
> --
> Gilles
>
> Sent from my Commodore C=3D64
