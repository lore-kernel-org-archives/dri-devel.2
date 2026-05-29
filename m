Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F291FCD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 05:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9687D112715;
	Sat, 30 May 2026 05:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h6WyF4Hj";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A8810FA32
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:43:29 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bdbcc6c4500so1287519866b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 00:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780040608; cv=none;
 d=google.com; s=arc-20240605;
 b=LYi6DhmIAaI7NvP4WoR7q8T8EdyAmF6mwNlXKTjWvjZsrGMgAGpOm0r4HLg+aD5x5q
 Ssf+OH7JBGn0oEubEnBfa8Tf3pkqybizJGGf1AUCPQR/M7pQglL4wg2iZ9HuXnhpZpkm
 QZT+PYQP6udA4+vH4HMsH71V+30B9yhip5Vs9Cw+8j/xnFF1ys6+g/fqn10GV+3isiN4
 oLR/N/QbDUBcjW1Vys8rKQ/MLpu6PRsWQc8iTE+0RP5T1xXa9RpDm5pw2DLGENK+YF51
 cODZT8imUxxyVYXE3UZAFX3XmygguvNBGUDRV7ChNWD90jB+6HAcX4JgQLtcaIwHxlHH
 d/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GzZHOwAgPk7upKhwwz8rSQvZhiNurmaPnPBWCLZlTTc=;
 fh=qxR42mG3aC30TE9oKeQtjBfSJx66fiQqDzkXETsw1hg=;
 b=ZHHlvjnyLZZVVVg5B0jkyzo8rPkLtWuDll9lJK6Zn1Sg8/ag8NOJrHpA70NHvLSerg
 +Hui69tWkZzimicNu9mE9h19ZGt7B1nwBOFE0ZkJooG7pUhTWGBdKSruY6TwctU2nsAu
 KMZrx2vsDhXC3QeG+bTExQoIaC+1uxSQhLJh4PQ252OiNKzspAMJD52cur0+TvFO+kLM
 fvoR+wV7EuglmlswTlZc6bglMKZbnlQTUut2PLCteZlZxffM/u2pvn7g/tE4TjLHvFt4
 173+PPkEWR5mU7a3LspCIi19mI4+C9+4dLFVuOPV9fpCBSG7NEaIZgK5gLD9mSt9t156
 OZFA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780040608; x=1780645408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzZHOwAgPk7upKhwwz8rSQvZhiNurmaPnPBWCLZlTTc=;
 b=h6WyF4HjM2NJdCDMiseAsuWpVLHsyEKdEPYkyAZ2mk0l7Diw5FbRW5RZfjV52NEPzs
 jf8Ll2WRAD0duZENmuL4MdyjsljggZcVT22zz6psVQylzE8DphZN7SRvhTWxrQq+xLlT
 XNRn8uzbPjLmkwyvmGs+Dv5wvIHpZWNqWDdPra/drM0IaaqurCIDFdNLMsDlad072gxf
 RRUOq1asZQbs+PRFPBjuKOuM8bSbwIPJBO/cDz0sPudbAJv11zBjJmOdCQZtYDpB28Ll
 utWH8IzVOlO3sgAsv62UssQI+8yXIMg1ZJNRvW0wn9fPff8BfKCWEa5QB93iWR0gbUPq
 l4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780040608; x=1780645408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GzZHOwAgPk7upKhwwz8rSQvZhiNurmaPnPBWCLZlTTc=;
 b=Fn0VDuqenyR/hWWOa2dgwG8MSkR06kKqE1XIKdQZV+T8WeYYnAPm/XtR6jNGWu3Gem
 w89O6zbcKSGduAXO3mMxAsmNY0EPfTxaBXSk4zrRpfWQzdjfr+WmTKz3aphuPNZZr3vq
 TJqFrhFjNRi+d+CzI3ya1zCY+55/e3UmeS3faCfRA7E5btYWRoClKnvkFucqOGFfL+Sa
 THaQ/G1GXXJQb9syQv7ngQzVkpvIS1Q0EYSvGA3/WsJlIt2FINyX0J0nn4BiaCg+c34z
 C9GkO+dC6cZg4eBDDZDeU1WaIptCTfXpgcuLX+OaQpGwvvMnn9ecN4/6AF96/nf5Ugvh
 xbWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ89YZ26UBze+giYaXAW7rpCzBDUJSporZ1V44mY08FoY/59Z7FaXDgrjDhhazlQe9Xy1yehbuWyMW4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzreCCvHZkekaCRJW0AhvpU1S/cnR4vdMO7bOnak3vp16X+8j5K
 VYV71KttJdtLhFuxMkME8COvV7CVcMHWMbYi0eGwrZAfEMnUvJ0vA/0QN4o9Qn3xet03/ggai8R
 xLSvccnkE9MYQkf901zGSrmXto9Yio14BtAe8
X-Gm-Gg: Acq92OHmrwb5klANqHMfkNTs7OT8FTL/DloV6SLfDJX4ZsGlHTIVARjZlkIphda4m3e
 F45io82DphKIrJ0A19QXeAIeIAAPQ1g5H+ZQFwWasghMNFFvKt3fF0GBA1Jo+6jtqjcjFke+mbc
 hbsdF8NdpYKfN00HJfFIrrO46LGHYW2NRFaHdlKxZlEV41lPuGFyEEFAWJwUq7DsvPe/54qAO74
 Iv5xwc2EcVegPrjXUUKXyPbQiLJoZ8GxxVQnKsu0t6GmOkHsEpwQkJMdSrbolhx3a9oxZJOgwzA
 LcFi5evnJmps3oUg
X-Received: by 2002:a17:906:8468:b0:be2:d66:eb21 with SMTP id
 a640c23a62f3a-be9cbcc413fmr67394166b.26.1780040607489; Fri, 29 May 2026
 00:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_Pq947+u3U-iVXLanuDQa_WxJKr_=DzJg1z+4rS334NqQ@mail.gmail.com>
 <20260527222012.2943-2-gilles.risch@gmail.com>
 <CADnq5_N5nM4Vn8=YbzBTJWcp8SEjMmb2KZurNqgqsxOpxQGUoA@mail.gmail.com>
In-Reply-To: <CADnq5_N5nM4Vn8=YbzBTJWcp8SEjMmb2KZurNqgqsxOpxQGUoA@mail.gmail.com>
From: Gilles Risch <gilles.risch@gmail.com>
Date: Fri, 29 May 2026 09:43:13 +0200
X-Gm-Features: AVHnY4Ivf1vLxWzTWtlywRo5k9qKgdZdfdYYM0JHnqyU5gCLM8x3Gg-PPb2P0ZY
Message-ID: <CALnjqVky2zET5U5N_PEorrsWG4stHQSeTJZV6fA8G0q0XU5ZDQ@mail.gmail.com>
Subject: Re: [PATCH v4] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 30 May 2026 05:55:19 +0000
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

Good morning,

I'll make that adjustment, shouldn't I just regroup all three iMac
machines in one if statement?

Am Do., 28. Mai 2026 um 20:53 Uhr schrieb Alex Deucher <alexdeucher@gmail.c=
om>:
>
> On Thu, May 28, 2026 at 3:39=E2=80=AFAM Gilles Risch <gilles.risch@gmail.=
com> wrote:
> >
> > The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
> > (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> > DisplayPort path. Without this fix the display stays dark under KMS.
> >
> > The same problem already exists for iMac10,1 and iMac11,2. Three fixes:
> >
> > 1. Introduce ASIC_IS_DCE31() for CHIP_RV770 and newer. Note that
> >    CHIP_RV770 precedes CHIP_RV730 in the enum, so ASIC_IS_DCE31()
> >    subsumes ASIC_IS_DCE32().
> >
> > 2. Extend the Link B encoder quirk from ASIC_IS_DCE32() to
> >    ASIC_IS_DCE31() and add iMac11,1 to the DMI list.
> >
> > 3. The 2560x1440 panel needs RADEON_PLL_USE_FRAC_FB_DIV and
> >    ATOM_ENCODER_CMD_DP_VIDEO_ON. These are limited to iMac11,1
> >    via dmi_match() to avoid affecting other DCE3.1 boards.
> >
> > Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> > ---
> >  drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
> >  drivers/gpu/drm/radeon/atombios_encoders.c | 11 ++++++-----
> >  drivers/gpu/drm/radeon/radeon.h            |  1 +
> >  3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/r=
adeon/atombios_crtc.c
> > index 2fc0334e0..075eba2d4 100644
> > --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> > +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> > @@ -24,6 +24,8 @@
> >   *          Alex Deucher
> >   */
> >
> > +#include <linux/dmi.h>
> > +
> >  #include <drm/drm_fixed.h>
> >  #include <drm/drm_fourcc.h>
> >  #include <drm/drm_framebuffer.h>
> > @@ -594,7 +596,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crt=
c,
> >                 if (((rdev->family =3D=3D CHIP_RS780) || (rdev->family =
=3D=3D CHIP_RS880))
> >                     && !radeon_crtc->ss_enabled)
> >                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FRAC=
_FB_DIV;
> > -               if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
> > +               if ((ASIC_IS_DCE32(rdev) || dmi_match(DMI_PRODUCT_NAME,=
 "iMac11,1"))
> > +                   && mode->clock > 165000)
> >                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FRAC=
_FB_DIV;
> >         } else {
> >                 radeon_crtc->pll_flags |=3D RADEON_PLL_LEGACY;
> > diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/d=
rm/radeon/atombios_encoders.c
> > index 5cfd8fcfa..4de60559f 100644
> > --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> > +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> > @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *=
encoder, int mode)
> >                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encode=
r)) && connector) {
> >                         /* DP_SET_POWER_D0 is set in radeon_dp_link_tra=
in */
> >                         radeon_dp_link_train(encoder, connector);
> > -                       if (ASIC_IS_DCE4(rdev))
> > +                       if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT=
_NAME, "iMac11,1"))
> >                                 atombios_dig_encoder_setup(encoder, ATO=
M_ENCODER_CMD_DP_VIDEO_ON, 0);
> >                 }
> >                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)=
) {
> > @@ -2123,12 +2123,13 @@ int radeon_atom_pick_dig_encoder(struct drm_enc=
oder *encoder, int fe_idx)
> >         }
> >
> >         /*
> > -        * On DCE32 any encoder can drive any block so usually just use=
 crtc id,
> > -        * but Apple thinks different at least on iMac10,1 and iMac11,2=
, so there use linkb,
> > -        * otherwise the internal eDP panel will stay dark.
> > +        * On DCE31 and DCE32 any encoder can drive any block so usuall=
y just use crtc id,
> > +        * but Apple thinks different at least on iMac10,1, iMac11,1 an=
d iMac11,2,
> > +        * so there use linkb, otherwise the internal eDP panel will st=
ay dark.
> >          */
> > -       if (ASIC_IS_DCE32(rdev)) {
> > +       if (ASIC_IS_DCE31(rdev)) {
>
> This will change the routing for DCE3.1 as well.  Probably best to do
> something like:
>
> if (dmi_match(DMI_PRODUCT_NAME, "iMac11,1")) {
>     enc_idx =3D (dig->linkb) ? 1 : 0;
>     goto assigned;
> }
>
> before or after the DCE32() block.
>
> >                 if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> > +                   dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
> >                     dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
> >                         enc_idx =3D (dig->linkb) ? 1 : 0;
> >                 else
> > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/r=
adeon.h
> > index 527b9d19d..6b7c0abe4 100644
> > --- a/drivers/gpu/drm/radeon/radeon.h
> > +++ b/drivers/gpu/drm/radeon/radeon.h
> > @@ -2625,6 +2625,7 @@ void r100_pll_errata_after_index(struct radeon_de=
vice *rdev);
> >                             (rdev->family =3D=3D CHIP_RS740)  ||    \
> >                             (rdev->family >=3D CHIP_R600))
> >  #define ASIC_IS_DCE3(rdev) ((rdev->family >=3D CHIP_RV620))
> > +#define ASIC_IS_DCE31(rdev) ((rdev->family >=3D CHIP_RV770))
> >  #define ASIC_IS_DCE32(rdev) ((rdev->family >=3D CHIP_RV730))
> >  #define ASIC_IS_DCE4(rdev) ((rdev->family >=3D CHIP_CEDAR))
> >  #define ASIC_IS_DCE41(rdev) ((rdev->family >=3D CHIP_PALM) && \
> >
> > base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> > --
> > 2.47.3
> >



--=20
Gilles

Sent from my Commodore C=3D64
