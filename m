Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F5BC624D4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B898A10E520;
	Tue,  1 Sep 2026 14:26:43 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E4710E520
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 14:26:42 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.96.74])
 by APP-03 (Coremail) with SMTP id rQCowABHTTua4JZqQxq4Bg--.40614S2;
 Tue, 01 Sep 2026 22:26:34 +0800 (CST)
Message-ID: <2968d3399ccb56784e63939e88566ba6fd2b0bef.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/loongson: Create blend mode property for cursor plane
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Huacai Chen <chenhuacai@kernel.org>,
 Jianmin Lv <lvjianmin@loongson.cn>,  Qianhai Wu <wuqianhai@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Mingcong Bai
 <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org
Date: Tue, 01 Sep 2026 22:26:34 +0800
In-Reply-To: <0d915332db93ac6affae218a35a35e79f8396fab.camel@iscas.ac.cn>
References: <20260901095924.2839059-1-chenhuacai@loongson.cn>
 <0d915332db93ac6affae218a35a35e79f8396fab.camel@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowABHTTua4JZqQxq4Bg--.40614S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13try7ZF1Uuw4fJw1kXwb_yoW5KFWDpF
 4vyFW0krWYka92kry7tr1kCayfXw4fK3s2qryrJay29r4jyrnFvF1xWr9I9FWUJr48Gw1Y
 qrnrArnruF4kGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07betCcUUUUU=
X-Originating-IP: [120.85.96.74]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-09-01=E4=BA=8C=E7=9A=84 18:10 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2026-09-01=E4=BA=8C=E7=9A=84 17:59 +0800=EF=BC=8CHuacai Chen=E5=
=86=99=E9=81=93=EF=BC=9A
> > After commit 860e748bddcc929 ("drm: ensure blend mode supported if
> > pixel
> > format with alpha exposed") we get warnings at boot:
> >=20
> > loongson 0000:00:06.1: [drm] [PLANE:41:ls-cursor-plane-0] pixel
> > format with alpha exposed but blend mode not setup. Please fix.
> > loongson 0000:00:06.1: [drm] [PLANE:46:ls-cursor-plane-1] pixel
> > format with alpha exposed but blend mode not setup. Please fix.
> >=20
> > The reason is the cursor plane supports color formats with alpha
> > but
> > the
> > driver doesn't create blend mode property, which triggers the
> > warning
> > in
> > validate_blend_mode_for_alpha_formats().
> >=20
> > The loongson DC only supports DRM_MODE_BLEND_PIXEL_NONE, so create
> > blend
>=20
> I think this means alpha is ignored, which isn't the expected
> behavior
> for a cursor plane.
>=20
> I assume PREMULTI is more reasonable, although this would need some
> experiment.

I hacked modetest to generate a cursor plane filled with r=3Dg=3D0, b=3D0xf=
f,
a=3D0x40, and this cursor is quite visible on a white background -- which
seems to mean the blending mode is COVERAGE.

(Tested on 7A1000)

Thanks,
Icenowy

>=20
> Thanks,
> Icenowy
>=20
> > mode property with DRM_MODE_BLEND_PIXEL_NONE for cursor planes.
> >=20
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > =C2=A0drivers/gpu/drm/loongson/lsdc_plane.c | 11 +++++++----
> > =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
> > b/drivers/gpu/drm/loongson/lsdc_plane.c
> > index bea42215796d..efef25eaa659 100644
> > --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> > +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> > @@ -7,6 +7,7 @@
> > =C2=A0
> > =C2=A0#include <drm/drm_atomic.h>
> > =C2=A0#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_blend.h>
> > =C2=A0#include <drm/drm_framebuffer.h>
> > =C2=A0#include <drm/drm_gem_atomic_helper.h>
> > =C2=A0#include <drm/drm_print.h>
> > @@ -747,8 +748,9 @@ int ls7a1000_cursor_plane_init(struct
> > drm_device
> > *ddev,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_plane *plane,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int index)
> > =C2=A0{
> > -	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> > =C2=A0	int ret;
> > +	unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE);
> > +	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> > =C2=A0
> > =C2=A0	ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lsdc_plane_funcs,
> > @@ -765,15 +767,16 @@ int ls7a1000_cursor_plane_init(struct
> > drm_device *ddev,
> > =C2=A0
> > =C2=A0	drm_plane_helper_add(plane,
> > &ls7a1000_cursor_plane_helper_funcs);
> > =C2=A0
> > -	return 0;
> > +	return drm_plane_create_blend_mode_property(plane,
> > blend_caps);
> > =C2=A0}
> > =C2=A0
> > =C2=A0int ls7a2000_cursor_plane_init(struct drm_device *ddev,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_plane *plane,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int index)
> > =C2=A0{
> > -	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> > =C2=A0	int ret;
> > +	unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE);
> > +	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> > =C2=A0
> > =C2=A0	ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lsdc_plane_funcs,
> > @@ -790,5 +793,5 @@ int ls7a2000_cursor_plane_init(struct
> > drm_device
> > *ddev,
> > =C2=A0
> > =C2=A0	drm_plane_helper_add(plane,
> > &ls7a2000_cursor_plane_helper_funcs);
> > =C2=A0
> > -	return 0;
> > +	return drm_plane_create_blend_mode_property(plane,
> > blend_caps);
> > =C2=A0}

