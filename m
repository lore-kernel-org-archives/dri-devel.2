Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7E8C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA92D89C48;
	Wed, 16 Sep 2026 10:01:34 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B792E10E039
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:01:32 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.103.44])
 by APP-05 (Coremail) with SMTP id zQCowABn0z33aKpq16xnCA--.15755S2;
 Wed, 16 Sep 2026 18:01:27 +0800 (CST)
Message-ID: <c3ac76b91f85c8e886a79b4ceb9b9109d1ce12ee.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/verisilicon: set blend mode for the cursor plane
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 18:01:27 +0800
In-Reply-To: <20260910094904.3502741-1-zhengxingda@iscas.ac.cn>
References: <20260910094904.3502741-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowABn0z33aKpq16xnCA--.15755S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw45ZF13XFy8XFW8Zr43Jrb_yoW8AF43pF
 4YyFWDAF90yanxtry7C3WxKay7ua15G3Z7XF95u34UZwn8try5Ar1rGr1S9F4UJr47W34r
 KFsrAr9xAry09F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5-txPUUUUU==
X-Originating-IP: [112.94.103.44]
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

=E5=9C=A8 2026-09-10=E5=9B=9B=E7=9A=84 17:49 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> Blend mode properties are now required to expose pixel formats w/
> alpha.
>=20
> Experiments show that the fixed blending mode for the cursor seems to
> be
> COVERAGE:
>=20
> - With a cursor plane filled with R=3DG=3D0, B=3D0xff, A=3D0x40, the curs=
or
> is
> =C2=A0 visible on a pure-white background, which means the background is
> =C2=A0 multiplied.
> - With a cursor plane filled with R=3DG=3DB=3D0xff, A=3D0x40, the cursor
> isn't
> =C2=A0 pure white and non-white patterns can be see through, which means
> the
> =C2=A0 cursor is multiplied.
>=20
> Add a fixed COVERAGE blend mode property for the cursor plane.
>=20
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Applied onto drm-misc-fixes.

Thanks,
Icenowy

> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> index fa4f601dd0c87..da456dced88aa 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> @@ -11,6 +11,7 @@
> =C2=A0
> =C2=A0#include <drm/drm_atomic.h>
> =C2=A0#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
> =C2=A0#include <drm/drm_crtc.h>
> =C2=A0#include <drm/drm_fourcc.h>
> =C2=A0#include <drm/drm_framebuffer.h>
> @@ -267,6 +268,7 @@ struct drm_plane *vs_cursor_plane_init(struct
> drm_device *drm_dev,
> =C2=A0		return plane;
> =C2=A0
> =C2=A0	drm_plane_helper_add(plane, &vs_cursor_plane_helper_funcs);
> +	drm_plane_create_blend_mode_property(plane,
> BIT(DRM_MODE_BLEND_COVERAGE));
> =C2=A0
> =C2=A0	return plane;
> =C2=A0}

