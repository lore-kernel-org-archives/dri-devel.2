Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB734C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2ED10F1D2;
	Wed,  2 Sep 2026 13:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LtBqlTLt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E8B10F1C5
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:06:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 800F5600C8
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384CD1F000E9
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788354380;
 bh=FYHyRZ16+hHiXsfPBU8FqXpRjfNJoFE2h08MCL8rYAk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=LtBqlTLto7qrFH05R3YMLQuKpRK55TUL8+nhAH9qRPugFX8+wDodeTTnNIZaOPtT0
 UELDR4PFpQhg9iBr/Zfe11koH0/hjXv/YQ1SXJqeGyHrUfimrieOUg/S04Xlpr/khL
 4t7YAoWerN5d9qbR9+HtBLss8lXuMcBbJuSpMyp0ZSQqS4GDn/x1azTuQnHUrM8Eh0
 g07L0wW57BOzVj7gnBQOPubMcUVQQJsqEUIDm8xk6wypg757UsrzBvHBwr/MvQ3EEg
 qe4DnfAjGNA/vAIwmrXO615ft/I5W31x8a8w8GM21QCSIqCt3YNdyih71RoTdjQmXk
 J5HXPFpjCNYVQ==
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a68ca482e2so529173a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 06:06:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ10KD4MiiUy5bbp9vGUiY5RRxBNFAN9q7NMKfRAuG20s6ds8RrrzrpgHKyP4J8JbUtXzpT747DLI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mfIT2bwMVs5fRmdU3klA+No715V6HZF6WFFttKs2Y8/+oGxyHl
 IgqV7kmf/YhaZ2gbBOoAYutiQae8zUkbYgBrUQM7nYNeIKJpE6USDmvCvUUF9Ko071aepegHilB
 e6AfEHaziHRWfFSLb5J99C6vLeeMJr+s=
X-Received: by 2002:a05:6402:43c8:b0:6a3:ff14:ebc9 with SMTP id
 4fb4d7f45d1cf-6a6829afdaemr2713266a12.11.1788354378860; Wed, 02 Sep 2026
 06:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260901095924.2839059-1-chenhuacai@loongson.cn>
 <0d915332db93ac6affae218a35a35e79f8396fab.camel@iscas.ac.cn>
 <2968d3399ccb56784e63939e88566ba6fd2b0bef.camel@iscas.ac.cn>
 <a547078c91dd575e76952c70fcc112539f0dfc75.camel@iscas.ac.cn>
In-Reply-To: <a547078c91dd575e76952c70fcc112539f0dfc75.camel@iscas.ac.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 2 Sep 2026 21:06:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5cbUnz1hn1Kt-wtr_EbEQUHMgpQ9jGvN84p_=+v+DiqQ@mail.gmail.com>
X-Gm-Features: AcwNN1XzrLI05ko1Mnoj3fcMxGx-LZOFHsdOhk-U8Lahbt7uMfma6JW_4t6unyk
Message-ID: <CAAhV-H5cbUnz1hn1Kt-wtr_EbEQUHMgpQ9jGvN84p_=+v+DiqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/loongson: Create blend mode property for cursor plane
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jianmin Lv <lvjianmin@loongson.cn>, 
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

Hi, Icenowy,

On Tue, Sep 1, 2026 at 10:41=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-09-01=E4=BA=8C=E7=9A=84 22:26 +0800=EF=BC=8CIcenowy Zheng=
=E5=86=99=E9=81=93=EF=BC=9A
> > =E5=9C=A8 2026-09-01=E4=BA=8C=E7=9A=84 18:10 +0800=EF=BC=8CIcenowy Zhen=
g=E5=86=99=E9=81=93=EF=BC=9A
> > > =E5=9C=A8 2026-09-01=E4=BA=8C=E7=9A=84 17:59 +0800=EF=BC=8CHuacai Che=
n=E5=86=99=E9=81=93=EF=BC=9A
> > > > After commit 860e748bddcc929 ("drm: ensure blend mode supported
> > > > if
> > > > pixel
> > > > format with alpha exposed") we get warnings at boot:
> > > >
> > > > loongson 0000:00:06.1: [drm] [PLANE:41:ls-cursor-plane-0] pixel
> > > > format with alpha exposed but blend mode not setup. Please fix.
> > > > loongson 0000:00:06.1: [drm] [PLANE:46:ls-cursor-plane-1] pixel
> > > > format with alpha exposed but blend mode not setup. Please fix.
> > > >
> > > > The reason is the cursor plane supports color formats with alpha
> > > > but
> > > > the
> > > > driver doesn't create blend mode property, which triggers the
> > > > warning
> > > > in
> > > > validate_blend_mode_for_alpha_formats().
> > > >
> > > > The loongson DC only supports DRM_MODE_BLEND_PIXEL_NONE, so
> > > > create
> > > > blend
> > >
> > > I think this means alpha is ignored, which isn't the expected
> > > behavior
> > > for a cursor plane.
> > >
> > > I assume PREMULTI is more reasonable, although this would need some
> > > experiment.
> >
> > I hacked modetest to generate a cursor plane filled with r=3Dg=3D0,
> > b=3D0xff,
> > a=3D0x40, and this cursor is quite visible on a white background --
> > which
> > seems to mean the blending mode is COVERAGE.
>
> BTW with a cursor filled with r=3Dg=3Db=3D0xff, a=3D0x40, the pattern bel=
ow is
> still visible, which means the cursor plane isn't premultiplied either.
I  discussed with Jianmin, he told me that the primary plane doesn't
support PREMULTI and COVERAGE, while the cursor plane doesn't support
PREMULTI but supports COVERAGE, so we can use COVERAGE here.


Huacai

>
> Thanks,
> Icenowy
>
> >
> > (Tested on 7A1000)
> >
> > Thanks,
> > Icenowy
> >
> > >
> > > Thanks,
> > > Icenowy
> > >
> > > > mode property with DRM_MODE_BLEND_PIXEL_NONE for cursor planes.
> > > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/gpu/drm/loongson/lsdc_plane.c | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
> > > > b/drivers/gpu/drm/loongson/lsdc_plane.c
> > > > index bea42215796d..efef25eaa659 100644
> > > > --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> > > > +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> > > > @@ -7,6 +7,7 @@
> > > >
> > > >  #include <drm/drm_atomic.h>
> > > >  #include <drm/drm_atomic_helper.h>
> > > > +#include <drm/drm_blend.h>
> > > >  #include <drm/drm_framebuffer.h>
> > > >  #include <drm/drm_gem_atomic_helper.h>
> > > >  #include <drm/drm_print.h>
> > > > @@ -747,8 +748,9 @@ int ls7a1000_cursor_plane_init(struct
> > > > drm_device
> > > > *ddev,
> > > >                          struct drm_plane *plane,
> > > >                          unsigned int index)
> > > >  {
> > > > - struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> > > >   int ret;
> > > > + unsigned int blend_caps =3D
> > > > BIT(DRM_MODE_BLEND_PIXEL_NONE);
> > > > + struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> > > >
> > > >   ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
> > > >                                  &lsdc_plane_funcs,
> > > > @@ -765,15 +767,16 @@ int ls7a1000_cursor_plane_init(struct
> > > > drm_device *ddev,
> > > >
> > > >   drm_plane_helper_add(plane,
> > > > &ls7a1000_cursor_plane_helper_funcs);
> > > >
> > > > - return 0;
> > > > + return drm_plane_create_blend_mode_property(plane,
> > > > blend_caps);
> > > >  }
> > > >
> > > >  int ls7a2000_cursor_plane_init(struct drm_device *ddev,
> > > >                          struct drm_plane *plane,
> > > >                          unsigned int index)
> > > >  {
> > > > - struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> > > >   int ret;
> > > > + unsigned int blend_caps =3D
> > > > BIT(DRM_MODE_BLEND_PIXEL_NONE);
> > > > + struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> > > >
> > > >   ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
> > > >                                  &lsdc_plane_funcs,
> > > > @@ -790,5 +793,5 @@ int ls7a2000_cursor_plane_init(struct
> > > > drm_device
> > > > *ddev,
> > > >
> > > >   drm_plane_helper_add(plane,
> > > > &ls7a2000_cursor_plane_helper_funcs);
> > > >
> > > > - return 0;
> > > > + return drm_plane_create_blend_mode_property(plane,
> > > > blend_caps);
> > > >  }
>
