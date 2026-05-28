Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD65CD6E45
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 18:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5667710F57B;
	Thu, 28 May 2026 18:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CazHrvqS";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCDC10F579
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 18:53:32 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-304dc707bfbso87231eec.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 11:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779994412; cv=none;
 d=google.com; s=arc-20240605;
 b=GFqR7ubqF+cXI0ly7WPowN4LypxY9pvtqKXScviH98/KZBEKW0GItGXHH0vLgvYiRj
 qCkH28vVFIETNvoLNivrRyLppsh3zAis/IhVATkssTab5kOz/VIbzZouoRvfjZBgmRBt
 A/K4VLB23RWwTjU9A4bbHg2kGsBgWmttA/EWPi4zKSMsLfoIHhmXYxlnbq7IHB0/qK0s
 rCsAGbfge5RKCoEprK01oDK8GI9iGgjH/KAHqdJiPmdW3l4x2/0BAUlX2tYoTPK3eStB
 F0/0KLT8rnf6/xTzh2mLQBqTx7KaqL6ZqaZd0S0yWROrlFtTU4XFFHrxv5v7EsPBkpPS
 U7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QFbOhKi6Sf1NEZDDos5MvJiK9AoGgYaFGK6pRA7anxY=;
 fh=clYZP55BPdMvwk8lDFC/FvmRpClj02RdGJ6eD8vRtgg=;
 b=H5d0QePWtyIgEt4ozIdCkLgUr4Ii1ZCLHvryrsYzxdVPvz7p3R0DxrKkPICL9OR1rI
 KcZHIMsacXjzEcelLCR91kFYHLrV3ory9qzS74pk7x0ZumJl7z8Pr/x4qfdaZNkQQlXY
 IIJNT+hZ3lP2h6PqKMasTCZaTL2cIrwlsZdtz/Q3CAys3Oamac/Ea3eQPgf/xLBXXueQ
 6AFtPmWLVAa/kzTR4R347cdovGapoZ325JCQpGAWKBrlPxQ8zeSTFD1VgASxJdanw9ND
 MqMbkBOnLv2lG1A04QPAEh5dDuIgwemt5sO2WAqw4qtj6FTEZYgujirrUyZyXdNdKMac
 t8TQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779994412; x=1780599212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFbOhKi6Sf1NEZDDos5MvJiK9AoGgYaFGK6pRA7anxY=;
 b=CazHrvqS7+zgr8977+tGqtjzgGTfN9Ed7yy8j28GTZZlDQjcmT1ATVoJr4yGCCgVMw
 nk1i0pRirSm2DlNvN2+hBqgVMZBt/jVrelgaRD1fgo+wmXzZlIqI9p2++8ywOobCO15i
 JRZHGvHdoMoW53yho2QOSxKo1hxHGDGYC0gONCwpt/r+aiHbhI0QwMcuVSMficxskXZT
 atjWYpQUxSmgl2Sqqcwpl9d3wT1545JnGKMyhwZAC9d6KoGv1TXjm62mK9m06Jp6SEAR
 AO5AiRtyP5ZY0nIk59MmcNlQdPZf5HsjqcS7rXBkvpBT8QvIY1BtsEIrkxMUpX7wXr7Z
 YQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779994412; x=1780599212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QFbOhKi6Sf1NEZDDos5MvJiK9AoGgYaFGK6pRA7anxY=;
 b=kRBHinQjISJUBreurC7+ileOXYBMxB0iokBBtN0Ape6rWickpbSGgWFbRI3+8lkTvf
 hD6jtrC6HINH4idugw+a0eDPsbZlx2M22Pwz9J3HW9lgT0t1VQAngUYIIX+dFYhqwrQR
 vS+4OPTXb3xQ6UH49VRKiLKPCk3bz5Mixf6iegje/mQN7lb1n7buwnq9IfspZNwTxu7G
 kbSERtn6VKQGUt0OblPeFnGedUkkzzB1+FE0msWqg/kjf76nWm/mDR72EZFIxe6x7fgb
 lTPDr3vQVVGrKCIq3nvQQQLvBgtZePl2ZUIeqfQ2JSql0kUPoH4WmWc6tYPmKhhA+xl8
 YqRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sqKJjxqFYJLgndPBRnKK6tDJVi2Hx8mpCAqQ19s9ylq2vEvDTkY6ICGZx+ysxeE21fd3V2UFVOI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWKFclsKZ4+XdrntnKEyv8BTOu9k3PN32jwG2MY1KJVFJGghBf
 AmWritVS059Hv0YqoMzsmhbOn5fM3Cn5qrmklW2YG91onVsgyy9M4s/vq+42Jx18dTIw2g14LN1
 j+OjEmnVh9ULDhRVINieQhxrO+pzG9dU=
X-Gm-Gg: Acq92OEFmIuFDGGJN9PnbiBLnocdKEc8mwJeDIfwd2Q2NNHqAdyRa4Y4Z8LPHKIFBpc
 LYcRA/6KjFokQBc1+YwnorbJahcwDcla7bqTJYjTzDkyNOeAVXUVhffevuzR4NoYC2uLlWkuirU
 w5IkcVRbg+lYCScIEjZngb77LvCb1xgdKq1/89wUNCqNknL8VSpG8z7GlfV2WKViwUI7fSnRrTd
 NEaA81Lmf1C1DhpPAYk4ZjL37Y3nct+OqM8Y0+2elvx0UzS7qY4qQPs9F8PcRON/HSPkrPlJj0p
 k81bvwObXfIVAP4g1dyTLdbwmq/Aod+oKsTLVLuSW6j/U06H63DuAej8dzSx8VYPNrX+nXrpEGN
 3RcXg
X-Received: by 2002:a05:7300:fd09:b0:304:e327:aef8 with SMTP id
 5a478bee46e88-304e8ad211dmr69370eec.2.1779994411845; Thu, 28 May 2026
 11:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_Pq947+u3U-iVXLanuDQa_WxJKr_=DzJg1z+4rS334NqQ@mail.gmail.com>
 <20260527222012.2943-2-gilles.risch@gmail.com>
In-Reply-To: <20260527222012.2943-2-gilles.risch@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 14:53:19 -0400
X-Gm-Features: AVHnY4KmhQGP5DYOuY1yl2dq_Qr8fCWYqU_WmakQhXxNTwPhVpEmMDo8xyMux4Q
Message-ID: <CADnq5_N5nM4Vn8=YbzBTJWcp8SEjMmb2KZurNqgqsxOpxQGUoA@mail.gmail.com>
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

On Thu, May 28, 2026 at 3:39=E2=80=AFAM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
> (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> DisplayPort path. Without this fix the display stays dark under KMS.
>
> The same problem already exists for iMac10,1 and iMac11,2. Three fixes:
>
> 1. Introduce ASIC_IS_DCE31() for CHIP_RV770 and newer. Note that
>    CHIP_RV770 precedes CHIP_RV730 in the enum, so ASIC_IS_DCE31()
>    subsumes ASIC_IS_DCE32().
>
> 2. Extend the Link B encoder quirk from ASIC_IS_DCE32() to
>    ASIC_IS_DCE31() and add iMac11,1 to the DMI list.
>
> 3. The 2560x1440 panel needs RADEON_PLL_USE_FRAC_FB_DIV and
>    ATOM_ENCODER_CMD_DP_VIDEO_ON. These are limited to iMac11,1
>    via dmi_match() to avoid affecting other DCE3.1 boards.
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> ---
>  drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
>  drivers/gpu/drm/radeon/atombios_encoders.c | 11 ++++++-----
>  drivers/gpu/drm/radeon/radeon.h            |  1 +
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/rad=
eon/atombios_crtc.c
> index 2fc0334e0..075eba2d4 100644
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
> index 5cfd8fcfa..4de60559f 100644
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
> @@ -2123,12 +2123,13 @@ int radeon_atom_pick_dig_encoder(struct drm_encod=
er *encoder, int fe_idx)
>         }
>
>         /*
> -        * On DCE32 any encoder can drive any block so usually just use c=
rtc id,
> -        * but Apple thinks different at least on iMac10,1 and iMac11,2, =
so there use linkb,
> -        * otherwise the internal eDP panel will stay dark.
> +        * On DCE31 and DCE32 any encoder can drive any block so usually =
just use crtc id,
> +        * but Apple thinks different at least on iMac10,1, iMac11,1 and =
iMac11,2,
> +        * so there use linkb, otherwise the internal eDP panel will stay=
 dark.
>          */
> -       if (ASIC_IS_DCE32(rdev)) {
> +       if (ASIC_IS_DCE31(rdev)) {

This will change the routing for DCE3.1 as well.  Probably best to do
something like:

if (dmi_match(DMI_PRODUCT_NAME, "iMac11,1")) {
    enc_idx =3D (dig->linkb) ? 1 : 0;
    goto assigned;
}

before or after the DCE32() block.

>                 if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> +                   dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
>                     dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
>                         enc_idx =3D (dig->linkb) ? 1 : 0;
>                 else
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/rad=
eon.h
> index 527b9d19d..6b7c0abe4 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -2625,6 +2625,7 @@ void r100_pll_errata_after_index(struct radeon_devi=
ce *rdev);
>                             (rdev->family =3D=3D CHIP_RS740)  ||    \
>                             (rdev->family >=3D CHIP_R600))
>  #define ASIC_IS_DCE3(rdev) ((rdev->family >=3D CHIP_RV620))
> +#define ASIC_IS_DCE31(rdev) ((rdev->family >=3D CHIP_RV770))
>  #define ASIC_IS_DCE32(rdev) ((rdev->family >=3D CHIP_RV730))
>  #define ASIC_IS_DCE4(rdev) ((rdev->family >=3D CHIP_CEDAR))
>  #define ASIC_IS_DCE41(rdev) ((rdev->family >=3D CHIP_PALM) && \
>
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> --
> 2.47.3
>
