Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A78DC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5411010E111;
	Wed,  9 Sep 2026 11:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KNm8FlNj";
	dkim-atps=neutral
Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com
 [74.125.231.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08C510E111
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 11:11:49 +0000 (UTC)
Received: by mail-oi2-f13.google.com with SMTP id
 5614622812f47-4c0766cbe64so42668b6e.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 04:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788952309; cv=none;
 d=google.com; s=arc-20260327;
 b=CmQazk0JAHu7Q6NlR0GgJrpHgHBf9MAO3JaGlEC3eRyTEOAp2ZY+XhYHAML0NHQqit
 nfm3NZMcsXz20lCgijeqtkbHGZ5DU8f7tbHNNPyJO15Za2YpwGbWHm9rswb7MsBvHsAq
 uvL694dm1ikIU6nB2cBEVk29uY4vDRDJ27xnuTi3G2b9+eH0UDCEnNcRqBJ17NaaxPpw
 AzVl2pk6T5ityXfJvvgRanNu2rcmWxDFUydFytTtIdgrEd06zisOBusJbebNDJyKJEO1
 942H7LfH5BFlGsmc8luQnjlERTss41yRQpCjEwd8jP/w/HKy14nG/12RdGr01/s7/VLv
 MO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ck8lakGDSM+8IA5gpwp94I/I8q3qxhf1fiaN168K/CQ=;
 fh=QcAiv51foEEp/poTcMcL0Fpeg9pcUWNJEev7+LQnv8s=;
 b=k0+80k520suuKJWDMax03ESVtSvtppXs37rEKU2fssfPi1I4+bnkSrlhwzOxJTkiUR
 sVAC7VtC9tzv+UnKrEn5nJe8pxFos2/W0rGTqarDQFco89jVjbepionQRu5FbGDnnp1m
 BIp3iMIcwMxUswhyZjsXd8p16PGrBRHx3KqFQpMY7YZTmer2Zl92HvBgBX62KIXBpNP0
 r6Em+IkQl1Ur4JiLyM2JBMBhUe1U/c4c05pMyhMBcqeX1qRvBQznT+JYBbdLHRenQUbZ
 az/oz3592N5hbTg/MXEklR/VG6fHW8g9fTdZyUvPdOLlU0IMXorL2M445M56AWJqz3QI
 D0Lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788952309; x=1789557109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ck8lakGDSM+8IA5gpwp94I/I8q3qxhf1fiaN168K/CQ=;
 b=KNm8FlNjMeA+mFwwJC5jHEom1JlLx01qefZZFLJJAeI6Gs3EmD1848pBl1/g9dFyeu
 y6Z1UCuNNU9UAUdEvXTDYnjKq0lE+MvffpFOLMukdPGjtBI1V9aWHS1TuptJdKvJ2uSD
 79KU61R0eBIs6HHSRtFJNYn2MPsijetFMetaq2Oc5kvxUZy3P1iYCpyykR8uSvDR0dLV
 xXJewMRQn+coVbOUiGGdzO5QxUYMxfI03ZBLA2tdVsBVT8dcHYP3mpMsAQwcuCVJ9VGf
 tfuFIW/EyopAlQ2/xzJD/3fpVE/KCjYSs7OnGOpHg4rBfuRmBF/XKPu/x8U3tLnbBCMQ
 Gstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788952309; x=1789557109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ck8lakGDSM+8IA5gpwp94I/I8q3qxhf1fiaN168K/CQ=;
 b=BqNzlakmic0Ujgs9L7eiObCNPOh4YLap/0RJA1FzLBtam0MWwEMWqRAlx5Ly7VEeeY
 UV8SyZUtyT7hqa4VNaB6E2DuwRIO3ytnOZCgCICWj2NRIOd1hoBPB3olaDD4TBNrtINr
 b1Ur8KSvuB867cmDfUDQ3MLJKKIS6TDbqJjxwd02pC80yXMeUD8Otb6Udxokcgbkg0hh
 5Cd5VLhNwXyMilxjrdA52CiAzh4A0C6+tQipzGTMakVx5Yh9ApnA9LS902i5bn4/J8ZG
 xKRkqrJ4r1SaSUsp9eJUOhBjl5N6oz52OMWoERdnRntS4tFGN5/y6q2OIRfT0O6B8MFA
 zseQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByDttO7dQaoUB8oWzwQt26Ih+043J+xW1D9tFm/6PCIBziyULSAdEJ29kAhKBdXKASrg/K/gciGz40=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nEc40pXYuYMvoI8eiY6o+Zm+2Odmj7NIcvXWy7nAfcRUChuwd+
 Si7iBT6O5VKMy7vPc1Ww3xxMmNKK/+5WDC1MwfspcoV2qzUiffV66oxDXbgtpo+LNcV8BzaukJ6
 JZLvRuh2yYjVXl+qNt3kPYNRGU2BCGxM=
X-Gm-Gg: AYBFou2kutlilWS4egLrr0vmGCKmiyLqO4jxRISvVuurkiEriNWN6HtRiEbTKdim1Ql
 kveMVaia8iEre13E8S1OzFnQdnvbG6aEFly2XG/lU/rKAxq0cnSuy+gMGAY9+UtIvGLz/9QEAwB
 UzemTQy4BC2wPz5dH3c0+oXYzrJe6HRe2QTI7RsAojNr7Eb5nCKEmQmhnBptVRgDtAZMQMxLsE+
 BMeqcJOb3g1zKIt5K7V0PeCPjcrWQTrPxKlXArnwu6af5mHnhLJsEVHTqJkPqcR/22+I4Y6220j
 7gpirgNKbzH9MsVOzMjPxYV9XminK5IvUBL6r7n7/APwILUccZlZs54=
X-Received: by 2002:a05:6808:4f60:b0:4be:d8dc:be57 with SMTP id
 5614622812f47-4c14069c4e9mr417269b6e.4.1788952308835; Wed, 09 Sep 2026
 04:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260903071149.423579-1-oushixiong1025@163.com>
In-Reply-To: <20260903071149.423579-1-oushixiong1025@163.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 9 Sep 2026 13:11:37 +0200
X-Gm-Features: AcwNN1WC5y6ETq-rkRFRm9BLnr617x6FxvJuPUgFKT2cKfdWM2Rc3Anl1-zwsRI
Message-ID: <CAMeQTsaMhb=neBOcfi62rs5hHCB0nvE2_4qaF0GbeHonp-JZ3Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/gma500: Create the primary plane in the driver
To: oushixiong1025@163.com
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Shixiong Ou <oushixiong@kylinos.cn>
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

On Thu, Sep 3, 2026 at 9:12=E2=80=AFAM <oushixiong1025@163.com> wrote:
>
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> drm_crtc_init() creates the primary plane from a fixed format list
> that includes ARGB8888. The display engine programs the primary plane
> with DISPPLANE_32BPP_NO_ALPHA, so it does not support per-pixel alpha
> and must not advertise alpha formats. Since commit 860e748bddcc
> ("drm: ensure blend mode supported if pixel format with alpha exposed"),
> drm_mode_config_validate() warns about this at probe time.
>
> Replace drm_crtc_init() with a driver-owned primary plane that
> advertises only XRGB8888. The plane is allocated by
> drmm_universal_plane_alloc() and the "pixel blend mode" property is
> not needed because no format with alpha is exposed.
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

Thanks for the patch. Applied to drm-misc-next

-Patrik

> ---
> v1->v2:
>   - Open-code DRM_PLANE_NON_ATOMIC_FUNCS without .destroy, which
>     drmm_universal_plane_alloc() rejects
>   - Use drmm_universal_plane_alloc() for automatic cleanup
>   - Move the formats comment above the array
>
>  drivers/gpu/drm/gma500/psb_intel_display.c | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm=
/gma500/psb_intel_display.c
> index 0df75a4a7739..f79484b9d593 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
> @@ -9,8 +9,11 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_modeset_helper.h>
>  #include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_plane_helper.h>
>  #include <drm/drm_print.h>
>
>  #include "framebuffer.h"
> @@ -471,11 +474,25 @@ static void psb_intel_cursor_init(struct drm_device=
 *dev,
>         REG_WRITE(base[gma_crtc->pipe], 0);
>  }
>
> +/*
> + * The display engine programs the primary plane with
> + * DISPPLANE_32BPP_NO_ALPHA, so no formats with alpha.
> + */
> +static const uint32_t gma_primary_formats[] =3D {
> +       DRM_FORMAT_XRGB8888,
> +};
> +
> +static const struct drm_plane_funcs gma_primary_plane_funcs =3D {
> +       .update_plane =3D drm_plane_helper_update_primary,
> +       .disable_plane =3D drm_plane_helper_disable_primary,
> +};
> +
>  void psb_intel_crtc_init(struct drm_device *dev, int pipe,
>                      struct psb_intel_mode_device *mode_dev)
>  {
>         struct drm_psb_private *dev_priv =3D to_drm_psb_private(dev);
>         struct gma_crtc *gma_crtc;
> +       struct drm_plane *primary;
>         int i;
>
>         /* We allocate a extra array of drm_connector pointers
> @@ -494,7 +511,17 @@ void psb_intel_crtc_init(struct drm_device *dev, int=
 pipe,
>                 return;
>         }
>
> -       drm_crtc_init(dev, &gma_crtc->base, &gma_crtc_funcs);
> +       primary =3D drmm_universal_plane_alloc(dev, struct drm_plane, dev=
, 0,
> +                                            &gma_primary_plane_funcs,
> +                                            gma_primary_formats,
> +                                            ARRAY_SIZE(gma_primary_forma=
ts),
> +                                            NULL, DRM_PLANE_TYPE_PRIMARY=
, NULL);
> +       if (IS_ERR(primary))
> +               goto err_free_crtc;
> +
> +       if (drm_crtc_init_with_planes(dev, &gma_crtc->base, primary, NULL=
,
> +                                     &gma_crtc_funcs, NULL))
> +               goto err_free_crtc;
>
>         /* Set the CRTC clock functions from chip specific data */
>         gma_crtc->clock_funcs =3D dev_priv->ops->clock_funcs;
> @@ -524,6 +551,11 @@ void psb_intel_crtc_init(struct drm_device *dev, int=
 pipe,
>
>         /* Set to true so that the pipe is forced off on initial config. =
*/
>         gma_crtc->active =3D true;
> +       return;
> +
> +err_free_crtc:
> +       kfree(gma_crtc->crtc_state);
> +       kfree(gma_crtc);
>  }
>
>  struct drm_crtc *psb_intel_get_crtc_from_pipe(struct drm_device *dev, in=
t pipe)
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
