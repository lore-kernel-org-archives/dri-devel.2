Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6873C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497BB10E825;
	Mon, 17 Aug 2026 15:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="alfYxwYF";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F111E10E82D
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:10:10 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5c2b6d3f2f6so129082e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979410; cv=none;
 d=google.com; s=arc-20260327;
 b=cY9CxFpZbfssGi2DzJUICGK5OWQ3Om5TIoEkcoXFh/gD5qm2MUoCx7arsANlt3wved
 Em5X7bISj0gy8SMB4H20RohutDaPbRsdimi+TQ8Rvhp3zSAaNX/N2ag6xHlRHiV5W9nv
 CfZzrD1Ox8jvijwBm3kKnPCxFt/4NjAByPozyCdJ9qIoKpgx8aEbFcq6uUjc25Np/z4e
 c+ZocC1pEhEZzaMzYzCbyOQeTKFVcqo3B7c6l3RzQYV85LhNCFOzG3FTaYvNexX/FzG0
 VaSkin32PxcGhdMXe/u6v9x09RsaLFVla7ID7bKNeK2V7yUpAnqz80yBlZIAZ+jyp0cL
 yKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5Vs4z9VETMAlhC8TDC7AO7aGvoR74ABE5Di5IsBaUZI=;
 fh=6t4MUmALxcIZ11ICyXdyFkJoSqd17y3oyGYBqDKJBvs=;
 b=hRKOlQdF9l1gWc3aGUoXDLZ+PfKRsc1oU8g4Aogz0vWij/+07m1PJ1NiLct7cu//uw
 wlbvCq659mMXBF6LU65FuiZlQNgjiPvJZLuWtn/0FxRc+4TyiyMpruHPdxcDn/zoTuSB
 Rs19WDsQ8s6WV7NT54FQXuD5KQG+VvCBsUcdEFW0EzYLiPCrvEt7SqHPecVYv42Idixc
 HPXDovZBdWty0VK3xEZ8zTnpptbH14F1tehAq8D9285LOHBCpIqW9ZZwewPFmJv6P0u2
 A7vK9HFwEt9FJVfQR7kJCAoy4uCSw5Xvcnsy4pwSldVSa/pwlCPhvua1zzjBXZvHlrBc
 4pRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786979410; x=1787584210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Vs4z9VETMAlhC8TDC7AO7aGvoR74ABE5Di5IsBaUZI=;
 b=alfYxwYF08F3Ogx4epenZyquUGzrSDaoBUYJTJk1rrk/Mg7J+DE83YDFWRYJxvASWf
 vlwlmn+TNbT10j2SIpF1U5AjoMoKTyDWzuA4ZmQj5p7B71gux4Oei0Mox0gzccDk9lbO
 VDDnKsiVQkw/bmQYz800QNYAeT174OS0w++2kQHfi7Ml1ySkzMjjzkQ4JKiDTj8Qy/62
 5wDRGOjjfe/PdnHC4bJbJzd9QadA7Y2XZLuxPGdRwvTHcrLloIUMX40mW0Cjz2N5D1jZ
 ZOhzOyVydrOzIn3qNZc6+KWtkrhh/XLL6DgI/EP0SUayz8+Ypo6zru4NjxPq1nboQO9Y
 9+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979410; x=1787584210;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Vs4z9VETMAlhC8TDC7AO7aGvoR74ABE5Di5IsBaUZI=;
 b=J0MtNNSxPuWG3CRL5zr0VTiZZcdpINfxNLTdnThZ9sKrRundr4WSC3hJAYIfMCSADb
 I03DgCc484IU6sPx0apCtfZxxXQKV+uKtI31x+RM4VY99iS9cC2jIt3In0bJQ1QqjlbS
 QJZiKbrIcpBa61ra7HFeDqI8nI193BK0eZEmChWFasO/pFlB+MpjtZtfAMS0+LsZ3DnW
 4TZMZFRQSi5xXnKJqkfnIs1QyTXVyWRqMvli3xyCBEiyQE6TZX87dpX6zrlPV5T9WtF7
 Aild0rCcG8PyCpyYHM9Ye/lw5ho1vP+c8gKQ7ZFUWY1I9qP8z5KT5xyaOudrLkGkQJw3
 FxTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqR0B6IIaZotQYarYszAjUkxbamx8N3lravUsy3dM1Re2Vu/J+0NUrAiOQm7IdFT8K06q1PftdhniY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwllphWa5kBdXyi9n8AmLP1XXjjZw1WVo4KPB857Ep5GdTFSql+
 YBWqG5fSICnqt0imuvnhKARFQNCqBBw8t6BMqxhO2JWfPMWuxMW/KITHWULqcbqz6mltPB4jOda
 cqHogH0gCAAMIR3bcKEQ4MR7Fg0UsIAY=
X-Gm-Gg: AR+sD133BHK1iFyjuLq1lhOqHjhJY6PKMbQoJ6xSFD6nNbHzLI2X1k8JQlK8t9LOFj8
 h3q0SIPpzaoCW+9TV5GJwnuJghdZ0tkerW2dZ5bQD2pJ2BWVLEMVHKsKhqlv4/7+Dnh9+9/s6F+
 X/X5SAuEQ5ED4ZhkfM56bRvJWmFa3vLG0Vz92xRmo08YysjNPREfmv25aaAkYmH/PEl4TjS9dfp
 DvrYH53J/WMUmKkEJkhknlGq+1MQZ+tWcntJr6YQDRzQJCUCeoyQHdBaLaxJ2v16a4rA6te3Qys
 AVCdyXRj2Q24beCP5GSstl3hNjUcjUlU2gG/+0NpSD872kBw/e0jtwJU/XfrysaM+xxsfY7Zqky
 KCsdXLnpo6FK4AS8tt5CKwjZXPpi/7etlJwlh
X-Received: by 2002:a05:6102:2ad0:b0:756:32ba:1a83 with SMTP id
 ada2fe7eead31-76f2c9430damr1845779137.2.1786979409622; Mon, 17 Aug 2026
 08:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <180318e7-0432-403a-b87b-6f9a455bb86a@gmail.com>
 <20260817004326.3192-1-gilles.risch@gmail.com>
In-Reply-To: <20260817004326.3192-1-gilles.risch@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 11:09:56 -0400
X-Gm-Features: AcwNN1XLOqNILg4yZI4rdPExnRh06Vw-U8A0OXdUm9EOG9yczYIphNcdXXJDLto
Message-ID: <CADnq5_N9-3fF4UFur3oA7+AkNLTiBg_CHdP4SJd0w4UmWZLR8A@mail.gmail.com>
Subject: Re: [PATCH v6] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, lukas@wunner.de
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

Applied.  Thanks!

Alex

On Sun, Aug 16, 2026 at 8:43=E2=80=AFPM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
> (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> DisplayPort path. Without this fix the display stays dark under KMS.
>
> This machine suffers from the same issue as iMac10,1 and iMac11,2:
> Apple routes the internal display through Link B of the DIG encoder
> instead of Link A. Add iMac11,1 to the existing DMI quirk and move
> the Apple-specific encoder assignment into its own block, independent
> of the DCE version check.
>
> Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
> and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
> to avoid affecting other boards.
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
>
> Good morning,
>
> this is v6 of the patch, rebased on top of amd-staging-drm-next
> (agd5f/linux).
>
> There are no functional or code changes since v5.
>
> Regarding Lukas Wunner's previous Reviewed-by (which was provided on v2),
> I have kept him in CC so he can confirm if his review still stands given
> the changes between v2 and v5.
>
> Could you have a look at this when you have a spare moment?
>
> Regards,
> Gilles
>
> Changes in v6:
> - Rebased on amd-staging-drm-next (no functional/code changes since v5)
> ---
>  drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
>  drivers/gpu/drm/radeon/atombios_encoders.c | 23 ++++++++++++----------
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/rad=
eon/atombios_crtc.c
> index 2fc0334e0d6c..075eba2d47f3 100644
> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> @@ -24,6 +24,8 @@
>   *          Alex Deucher
>   */
>
> +#include <linux/dmi.h>
> +
>  #include <drm/drm_fixed.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
> @@ -594,7 +596,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
>                 if (((rdev->family =3D=3D CHIP_RS780) || (rdev->family =
=3D=3D CHIP_RS880))
>                     && !radeon_crtc->ss_enabled)
>                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FRAC_F=
B_DIV;
> -               if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
> +               if ((ASIC_IS_DCE32(rdev) || dmi_match(DMI_PRODUCT_NAME, "=
iMac11,1"))
> +                   && mode->clock > 165000)
>                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FRAC_F=
B_DIV;
>         } else {
>                 radeon_crtc->pll_flags |=3D RADEON_PLL_LEGACY;
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 5cfd8fcfa5e8..8b3f8303a967 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)=
) && connector) {
>                         /* DP_SET_POWER_D0 is set in radeon_dp_link_train=
 */
>                         radeon_dp_link_train(encoder, connector);
> -                       if (ASIC_IS_DCE4(rdev))
> +                       if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_N=
AME, "iMac11,1"))
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_ON, 0);
>                 }
>                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) =
{
> @@ -2123,17 +2123,20 @@ int radeon_atom_pick_dig_encoder(struct drm_encod=
er *encoder, int fe_idx)
>         }
>
>         /*
> -        * On DCE32 any encoder can drive any block so usually just use c=
rtc id,
> -        * but Apple thinks different at least on iMac10,1 and iMac11,2, =
so there use linkb,
> -        * otherwise the internal eDP panel will stay dark.
> +        * Apple routes the internal eDP panel through Link B of the DIG =
encoder
> +        * instead of Link A on the iMac10,1, iMac11,1 and iMac11,2.
> +        * Use linkb to avoid a dark display.
>          */
> -       if (ASIC_IS_DCE32(rdev)) {
> -               if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> -                   dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
> -                       enc_idx =3D (dig->linkb) ? 1 : 0;
> -               else
> -                       enc_idx =3D radeon_crtc->crtc_id;
> +       if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> +           dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
> +           dmi_match(DMI_PRODUCT_NAME, "iMac11,2")) {
> +               enc_idx =3D (dig->linkb) ? 1 : 0;
> +               goto assigned;
> +       }
>
> +       /* on DCE32 and encoder can driver any block so just crtc id */
> +       if (ASIC_IS_DCE32(rdev)) {
> +               enc_idx =3D radeon_crtc->crtc_id;
>                 goto assigned;
>         }
>
>
> base-commit: 21c50d41af7c46e138b542dba2dcf6d2a978ae99
> --
> 2.47.3
>
