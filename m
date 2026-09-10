Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC8FC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B2A10F3AF;
	Thu, 10 Sep 2026 09:08:22 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E01E610F3AF
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:08:19 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.66])
 by APP-01 (Coremail) with SMTP id qwCowAAH3vF+c6Jq6_qXBw--.49530S2;
 Thu, 10 Sep 2026 17:08:14 +0800 (CST)
Message-ID: <125d55143d0877b7ed0d84e622eed913e2d58794.camel@iscas.ac.cn>
Subject: Re: [PATCH 1/2] drm/verisilicon: set blend mode for the primary plane
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 17:08:13 +0800
In-Reply-To: <953008c0-57b3-49b7-ab81-027b7626269c@suse.de>
References: <20260901171703.1161592-1-zhengxingda@iscas.ac.cn>
 <953008c0-57b3-49b7-ab81-027b7626269c@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAAH3vF+c6Jq6_qXBw--.49530S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1DGr4fZrWrKw1xtF4rAFb_yoW8AFykpF
 sxAFWDtr4rAwsrAFy7Cw12ka9xua1fGF92gry8ZwnFvFWDKFy5CF18tr909FW5Jr42gw1S
 k3sxAF98Cr1UCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07j1nmiUUUUU=
X-Originating-IP: [112.94.100.66]
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

=E5=9C=A8 2026-09-10=E5=9B=9B=E7=9A=84 10:49 +0200=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> Am 01.09.26 um 19:17 schrieb Icenowy Zheng:
> > Blend modes are now required to expose pixel formats w/ alpha.
> >=20
> > As it's the primary plane and blending is explicitly disabled, just
> > expose PIXEL_NONE blend mode.
> >=20
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> > =C2=A0 drivers/gpu/drm/verisilicon/vs_primary_plane.c | 3 +++
> > =C2=A0 1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > index 1f2be41ae496c..8d58682d88ef8 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > @@ -7,6 +7,7 @@
> > =C2=A0=20
> > =C2=A0 #include <drm/drm_atomic.h>
> > =C2=A0 #include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_blend.h>
> > =C2=A0 #include <drm/drm_crtc.h>
> > =C2=A0 #include <drm/drm_fourcc.h>
> > =C2=A0 #include <drm/drm_framebuffer.h>
> > @@ -179,5 +180,7 @@ struct drm_plane *vs_primary_plane_init(struct
> > drm_device *drm_dev, struct vs_dc
> > =C2=A0=20
> > =C2=A0=C2=A0	drm_plane_helper_add(plane,
> > &vs_primary_plane_helper_funcs);
> > =C2=A0=20
> > +	drm_plane_create_blend_mode_property(plane,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0
> > BIT(DRM_MODE_BLEND_PIXEL_NONE));
>=20
> No empty line before that call. I think it also fits onto a single

The plane blend mode call exceeds 80 columns (82 columns for COVERAGE
and 83 columns for PIXEL_NONE), although I heard that sometimes the
limit is 100 columns instead (but coding-style.rst still says 80
columns is preferred).

Thanks,
Icenowy

> line.=20
> Apart from the style
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
>=20
> > =C2=A0=C2=A0	return plane;
> > =C2=A0 }

