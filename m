Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD89C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7464110E063;
	Thu,  3 Sep 2026 06:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X32yC4uX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E061510E063
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:05:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 874A24098B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8E71F000E9
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788415546;
 bh=cpJs+hSn6eYojSRlFlfvqcalxEqBdBcxk+2/sCVqfeI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=X32yC4uXWZLkOT88eeKfXCEpvYvStVsGVQphP31Uywmr28M9WSgqchy/8732Fkfae
 SL4tx7pVXbeaKs6zYf3PkHobC50egIk3xdTXe1U6OyOcWdDtiYQp7yXYGjb7L1QeRh
 QPQl6DTrDKFLg3ALCxHecpe2+ilGOGuqV2YIWqIcEMu8nir+QPFfDf/EbvaJPZ2zjU
 XanlMZi0+ZUwMAwhIPKc9pKZLzHtTxqsgVyVHOqfCULilOaAmX8+EKUngSdP9RxTnz
 DiZwki5n8peyEWxQyrN1ghJ03F+pPD7h04ICtmvj4XgybAfMaJENLXdhnLR4scydW2
 m1HvMPwNL60BA==
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c253425b253so291321966b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 23:05:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBz0m2L3/gNXHZHtW6nkYBcjz4QS5KTO83l5fJp5NB+1ChoNIz8tbSLQGBQTmqZYRoMdbvNyfuQnQXU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfX797SigSEEImeNlI9yn4qhWSh+EgDULFrTKPDhjEpZc871t1
 I3+Pv2bKsXI5wwA/WK5I+2ww9800/znZTfuoJp4mN9nXZQZebTVvXXCltCEdEJg1aLgKS894bmp
 0aaUnCVN/2pmYIaQdHUrGjdaKzLf2Ctw=
X-Received: by 2002:a17:906:7308:b0:c24:bf0b:6b62 with SMTP id
 a640c23a62f3a-c25d520a6ebmr678586866b.4.1788415545065; Wed, 02 Sep 2026
 23:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260902132152.3170934-1-chenhuacai@loongson.cn>
 <c321d3ea800e6754cb8a904a87f432d17ab3d21c.camel@iscas.ac.cn>
 <436e6744-8649-133d-17a7-e90332027269@loongson.cn>
In-Reply-To: <436e6744-8649-133d-17a7-e90332027269@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 3 Sep 2026 14:05:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4NRkBoCWMS8a17DYr7sDqTN0Amx3EDX+oxH+7DFzuFDw@mail.gmail.com>
X-Gm-Features: AcwNN1WqD0GG_a_V5bIKWZfx0Z6tMw1OcDfaNDaEVTFGOovyWJu2KuFmBYQky14
Message-ID: <CAAhV-H4NRkBoCWMS8a17DYr7sDqTN0Amx3EDX+oxH+7DFzuFDw@mail.gmail.com>
Subject: Re: [PATCH V2] drm/loongson: Create blend mode property for cursor
 plane
To: Jianmin Lv <lvjianmin@loongson.cn>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Qianhai Wu <wuqianhai@loongson.cn>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, dri-devel@lists.freedesktop.org
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

On Thu, Sep 3, 2026 at 10:41=E2=80=AFAM Jianmin Lv <lvjianmin@loongson.cn> =
wrote:
>
>
>
> On 2026/9/2 =E4=B8=8B=E5=8D=8811:29, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-09-02=E4=B8=89=E7=9A=84 21:21 +0800=EF=BC=8CHuacai Chen=
=E5=86=99=E9=81=93=EF=BC=9A
> >> After commit 860e748bddcc929 ("drm: ensure blend mode supported if
> >> pixel
> >> format with alpha exposed") we get warnings at boot:
> >>
> >> loongson 0000:00:06.1: [drm] [PLANE:41:ls-cursor-plane-0] pixel
> >> format with alpha exposed but blend mode not setup. Please fix.
> >> loongson 0000:00:06.1: [drm] [PLANE:46:ls-cursor-plane-1] pixel
> >> format with alpha exposed but blend mode not setup. Please fix.
> >>
> >> The reason is the cursor plane supports color formats with alpha but
> >> the
> >> driver doesn't create blend mode property, which triggers the warning
> >> in
> >> validate_blend_mode_for_alpha_formats().
> >>
> >> The loongson DC HW doesn't support DRM_MODE_BLEND_PREMULTI, so create
> >> a blend mode with "DRM_MODE_BLEND_PIXEL_NONE |
> >> DRM_MODE_BLEND_COVERAGE"
> >> for cursor planes.
> >>
> >> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >> ---
> >>   drivers/gpu/drm/loongson/lsdc_plane.c | 11 +++++++----
> >>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
> >> b/drivers/gpu/drm/loongson/lsdc_plane.c
> >> index bea42215796d..969b2aaa4fd0 100644
> >> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> >> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> >> @@ -7,6 +7,7 @@
> >>
> >>   #include <drm/drm_atomic.h>
> >>   #include <drm/drm_atomic_helper.h>
> >> +#include <drm/drm_blend.h>
> >>   #include <drm/drm_framebuffer.h>
> >>   #include <drm/drm_gem_atomic_helper.h>
> >>   #include <drm/drm_print.h>
> >> @@ -747,8 +748,9 @@ int ls7a1000_cursor_plane_init(struct drm_device
> >> *ddev,
> >>                             struct drm_plane *plane,
> >>                             unsigned int index)
> >>   {
> >> -    struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> >>      int ret;
> >> +    unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> >> BIT(DRM_MODE_BLEND_COVERAGE);
> >> +    struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> >>
> >>      ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
> >>                                     &lsdc_plane_funcs,
> >> @@ -765,15 +767,16 @@ int ls7a1000_cursor_plane_init(struct
> >> drm_device *ddev,
> >>
> >>      drm_plane_helper_add(plane,
> >> &ls7a1000_cursor_plane_helper_funcs);
> >>
> >> -    return 0;
> >> +    return drm_plane_create_blend_mode_property(plane,
> >> blend_caps);
> >>   }
> >>
> >>   int ls7a2000_cursor_plane_init(struct drm_device *ddev,
> >>                             struct drm_plane *plane,
> >>                             unsigned int index)
> >>   {
> >> -    struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> >>      int ret;
> >> +    unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> >> BIT(DRM_MODE_BLEND_COVERAGE);
> >
> > I think code needs to be present for setting up PIXEL_NONE blend mode,
> > if it's exposed.
> >
> > Personally, from my copy of =E9=BE=99=E8=8A=AF 7A2000 =E6=A1=A5=E7=89=
=87=E7=94=A8=E6=88=B7=E6=89=8B=E5=86=8C V1.0, I can find no
> > information of a PIXEL_NONE blend mode -- there's no bits controlling
> > the enablement of blending (except for completely disabling the
> > cursor), and the format has no option of XRGB8888 instead of ARGB8888.
> >
> > Thanks,
> > Icenowy
> >
> Agree, COVERAGE mode is internally fixed in the chip with no register to
> control.
OK, I will remove PIXEL_NONE in V3.

Huacai

> >> +    struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> >>
> >>      ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
> >>                                     &lsdc_plane_funcs,
> >> @@ -790,5 +793,5 @@ int ls7a2000_cursor_plane_init(struct drm_device
> >> *ddev,
> >>
> >>      drm_plane_helper_add(plane,
> >> &ls7a2000_cursor_plane_helper_funcs);
> >>
> >> -    return 0;
> >> +    return drm_plane_create_blend_mode_property(plane,
> >> blend_caps);
> >>   }
>
