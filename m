Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFA7C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CE210F278;
	Wed,  2 Sep 2026 15:29:25 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E366D10F278
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:29:23 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.96.74])
 by APP-03 (Coremail) with SMTP id rQCowADHzz3GQJhqfxvGBg--.30041S2;
 Wed, 02 Sep 2026 23:29:10 +0800 (CST)
Message-ID: <c321d3ea800e6754cb8a904a87f432d17ab3d21c.camel@iscas.ac.cn>
Subject: Re: [PATCH V2] drm/loongson: Create blend mode property for cursor
 plane
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Huacai Chen <chenhuacai@kernel.org>,
 Jianmin Lv <lvjianmin@loongson.cn>,  Qianhai Wu <wuqianhai@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Mingcong Bai
 <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org
Date: Wed, 02 Sep 2026 23:29:09 +0800
In-Reply-To: <20260902132152.3170934-1-chenhuacai@loongson.cn>
References: <20260902132152.3170934-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowADHzz3GQJhqfxvGBg--.30041S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF17Aw1fWF1ruw15ZF4rAFb_yoW5tw4UpF
 4vyFW0krWYkFWktrykt34kGayfXw4fG34IqryrJa9Fgr15KF12vF10gwnI9rWUJr4kGw13
 XrnrCrn8CF4UGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

=E5=9C=A8 2026-09-02=E4=B8=89=E7=9A=84 21:21 +0800=EF=BC=8CHuacai Chen=E5=
=86=99=E9=81=93=EF=BC=9A
> After commit 860e748bddcc929 ("drm: ensure blend mode supported if
> pixel
> format with alpha exposed") we get warnings at boot:
>=20
> loongson 0000:00:06.1: [drm] [PLANE:41:ls-cursor-plane-0] pixel
> format with alpha exposed but blend mode not setup. Please fix.
> loongson 0000:00:06.1: [drm] [PLANE:46:ls-cursor-plane-1] pixel
> format with alpha exposed but blend mode not setup. Please fix.
>=20
> The reason is the cursor plane supports color formats with alpha but
> the
> driver doesn't create blend mode property, which triggers the warning
> in
> validate_blend_mode_for_alpha_formats().
>=20
> The loongson DC HW doesn't support DRM_MODE_BLEND_PREMULTI, so create
> a blend mode with "DRM_MODE_BLEND_PIXEL_NONE |
> DRM_MODE_BLEND_COVERAGE"
> for cursor planes.
>=20
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_plane.c | 11 +++++++----
> =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
> b/drivers/gpu/drm/loongson/lsdc_plane.c
> index bea42215796d..969b2aaa4fd0 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> @@ -7,6 +7,7 @@
> =C2=A0
> =C2=A0#include <drm/drm_atomic.h>
> =C2=A0#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
> =C2=A0#include <drm/drm_framebuffer.h>
> =C2=A0#include <drm/drm_gem_atomic_helper.h>
> =C2=A0#include <drm/drm_print.h>
> @@ -747,8 +748,9 @@ int ls7a1000_cursor_plane_init(struct drm_device
> *ddev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_plane *plane,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int index)
> =C2=A0{
> -	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> =C2=A0	int ret;
> +	unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> BIT(DRM_MODE_BLEND_COVERAGE);
> +	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> =C2=A0
> =C2=A0	ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lsdc_plane_funcs,
> @@ -765,15 +767,16 @@ int ls7a1000_cursor_plane_init(struct
> drm_device *ddev,
> =C2=A0
> =C2=A0	drm_plane_helper_add(plane,
> &ls7a1000_cursor_plane_helper_funcs);
> =C2=A0
> -	return 0;
> +	return drm_plane_create_blend_mode_property(plane,
> blend_caps);
> =C2=A0}
> =C2=A0
> =C2=A0int ls7a2000_cursor_plane_init(struct drm_device *ddev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_plane *plane,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int index)
> =C2=A0{
> -	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> =C2=A0	int ret;
> +	unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> BIT(DRM_MODE_BLEND_COVERAGE);

I think code needs to be present for setting up PIXEL_NONE blend mode,
if it's exposed.

Personally, from my copy of =E9=BE=99=E8=8A=AF 7A2000 =E6=A1=A5=E7=89=87=E7=
=94=A8=E6=88=B7=E6=89=8B=E5=86=8C V1.0, I can find no
information of a PIXEL_NONE blend mode -- there's no bits controlling
the enablement of blending (except for completely disabling the
cursor), and the format has no option of XRGB8888 instead of ARGB8888.

Thanks,
Icenowy

> +	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> =C2=A0
> =C2=A0	ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lsdc_plane_funcs,
> @@ -790,5 +793,5 @@ int ls7a2000_cursor_plane_init(struct drm_device
> *ddev,
> =C2=A0
> =C2=A0	drm_plane_helper_add(plane,
> &ls7a2000_cursor_plane_helper_funcs);
> =C2=A0
> -	return 0;
> +	return drm_plane_create_blend_mode_property(plane,
> blend_caps);
> =C2=A0}

