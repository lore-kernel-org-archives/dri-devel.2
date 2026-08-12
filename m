Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F585C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BA610F06E;
	Wed, 12 Aug 2026 15:50:57 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5362C10F06E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:50:55 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.96.94])
 by APP-03 (Coremail) with SMTP id rQCowAD3AUBZlnxqPq74BA--.21148S2;
 Wed, 12 Aug 2026 23:50:50 +0800 (CST)
Message-ID: <6b3a485b8bbdd8cc790f4e6e8156d9f679872aa7.camel@iscas.ac.cn>
Subject: Re: [PATCH RFC v2] drm/verisilicon: Switch to drm_fb_dma_get_addr()
 for framebuffer addresses
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Chen-Yu Tsai <wenst@chromium.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Aug 2026 23:50:49 +0800
In-Reply-To: <6c2b92efec2b8ed58da9b85b63935ba2e7f2a6ed.camel@iscas.ac.cn>
References: <20260807114654.1373305-1-wenst@chromium.org>
 <6c2b92efec2b8ed58da9b85b63935ba2e7f2a6ed.camel@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAD3AUBZlnxqPq74BA--.21148S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4fKr18tF13AFW7WrW7urg_yoWxWF1UpF
 ZFyFWUtrs0ya1vgr9rJw1jyay3ua1fJ34xWr1kGw10krs0yry29F1DXr95uFZ8JrWxWw1S
 qrsxAr9xuF4YyF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bYgA7UUUUU=
X-Originating-IP: [120.85.96.94]
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

=E5=9C=A8 2026-08-12=E4=B8=89=E7=9A=84 23:36 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2026-08-07=E4=BA=94=E7=9A=84 19:46 +0800=EF=BC=8CChen-Yu Tsai=
=E5=86=99=E9=81=93=EF=BC=9A
> > The verisilicon driver has a custom framebuffer address calculating
> > helper that the common drm_fb_dma_get_addr() can substitute.
> >=20
> > Differences from drm_fb_dma_get_addr():
> >=20
> > - Uses drm_format_info_min_pitch() to calculate the horizontal
> > offset;
> > =C2=A0 however the driver does not support any of the blocked formats,
> > so
>=20
> Technically this DC, advertised as part of the "Vivante" product line
> (considering Vivante Corporation is acquired by VeriSilicon), seems
> to
> support DRM_FORMAT_MOD_VIVANTE_SUPER_TILED modifier (the TH1520
> documentation says the DC supports
> `SuperTileX8x8/SuperTileX8x4/SuperTileY4x8`, although I think
> DRM_FORMAT_MOD_VIVANTE_SUPER_TILED is just one of these tiling).
>=20
> However, as my accessible SoCs with such DC have no GC-series 3D GPUs
> (TH1520 does have a 2D-only GC620 GPU), I think it's quite difficult
> to
> get this piece of thing right and it should be low-priority.
>=20
> > =C2=A0 this just ends up being the same as in drm_fb_dma_get_addr():
> > =C2=A0 "cpp[plane] * y"
> >=20
> > - Uses clipped source coordinates instead of non-clipped
> > coordinates
> > =C2=A0 as in drm_fb_dma_get_addr();
> >=20
> > =C2=A0 For the primary plane this doesn't matter, since the primary
> > plane
> > =C2=A0 must match the output, i.e. it cannot be clipped. Also this
> > driver
> > =C2=A0 doesn't support scaling.
> >=20
> > =C2=A0 For the cursor plane this seems wrong, as the clipping seems to
> > be
> > =C2=A0 done by the hardware, and thus the buffer address should be
> > unclipped.
>=20
> Yes this is right and the current state of the cursor plane is
> broken.
>=20
> However another error compensates this error so I didn't catch it
> when
> developing -- the [XY]_OFF fields aren't properly written because I
> forgot to shift the values for them (and then the value gets masked
> by
> regmap_update_bits()), which prevents the HW clipping to happen, and
> the normal-state arrow cursor happens to have no non-transparent
> pixels
> before the hotspot. When testing with `X -retro`, the retro X cursor
> gets quite glitchy with the current code; and when this patch is
> applied w/o the offset fix, the cursor isn't clipped at all.
>=20
> Both errors deserve fixes, I will then send the fix for the offset
> writing problem.

That's sent as=C2=A0[1].

Thanks,
Icenowy

[1]
https://lore.kernel.org/all/20260812154829.671777-1-zhengxingda@iscas.ac.cn=
/

>=20
> Thanks,
> Icenowy
>=20
> >=20
> > As such, it should be fine to use the common helper and drop the
> > custom
> > code.
> >=20
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - Fixed compile issues
> >=20
> > This is only compile tested. I do not have the hardware.
> > ---
> > =C2=A0drivers/gpu/drm/verisilicon/vs_cursor_plane.c |=C2=A0 4 +++-
> > =C2=A0drivers/gpu/drm/verisilicon/vs_plane.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 20 ---------------
> > --
> > --
> > =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 7 ++++++-
> > =C2=A03 files changed, 9 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > index fa4f601dd0c8..59778433ae84 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > @@ -12,6 +12,7 @@
> > =C2=A0#include <drm/drm_atomic.h>
> > =C2=A0#include <drm/drm_atomic_helper.h>
> > =C2=A0#include <drm/drm_crtc.h>
> > +#include <drm/drm_fb_dma_helper.h>
> > =C2=A0#include <drm/drm_fourcc.h>
> > =C2=A0#include <drm/drm_framebuffer.h>
> > =C2=A0#include <drm/drm_gem_atomic_helper.h>
> > @@ -176,7 +177,8 @@ static void
> > vs_cursor_plane_atomic_update(struct
> > drm_plane *plane,
> > =C2=A0		break;
> > =C2=A0	}
> > =C2=A0
> > -	dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);
> > +	/* hardware handles clipping as seen below */
> > +	dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, 0);
> > =C2=A0
> > =C2=A0	regmap_write(dc->regs, VSDC_CURSOR_ADDRESS(output),
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 lower_32_bits(dma_addr));
> > diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c
> > b/drivers/gpu/drm/verisilicon/vs_plane.c
> > index d81f7b8f4c65..38b8b536eccb 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_plane.c
> > +++ b/drivers/gpu/drm/verisilicon/vs_plane.c
> > @@ -107,26 +107,6 @@ int drm_format_to_vs_format(u32 drm_format,
> > struct vs_format *vs_format)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > -dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_rect *src_rect)
> > -{
> > -	struct drm_gem_dma_object *gem;
> > -	dma_addr_t dma_addr;
> > -
> > -	/* Get the physical address of the buffer in memory */
> > -	gem =3D drm_fb_dma_get_gem_obj(fb, 0);
> > -
> > -	/* Compute the start of the displayed memory */
> > -	dma_addr =3D gem->dma_addr + fb->offsets[0];
> > -
> > -	/* Fixup framebuffer address for src coordinates */
> > -	dma_addr +=3D drm_format_info_min_pitch(fb->format, 0,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src_rect->x1 >> 16);
> > -	dma_addr +=3D (src_rect->y1 >> 16) * fb->pitches[0];
> > -
> > -	return dma_addr;
> > -}
> > -
> > =C2=A0struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane
> > *plane)
> > =C2=A0{
> > =C2=A0	struct vs_plane_state *vs_state, *vs_state_old;
> > diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > index 1f2be41ae496..2750016a7f2c 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > @@ -8,6 +8,7 @@
> > =C2=A0#include <drm/drm_atomic.h>
> > =C2=A0#include <drm/drm_atomic_helper.h>
> > =C2=A0#include <drm/drm_crtc.h>
> > +#include <drm/drm_fb_dma_helper.h>
> > =C2=A0#include <drm/drm_fourcc.h>
> > =C2=A0#include <drm/drm_framebuffer.h>
> > =C2=A0#include <drm/drm_gem_atomic_helper.h>
> > @@ -126,7 +127,11 @@ static void
> > vs_primary_plane_atomic_update(struct drm_plane *plane,
> > =C2=A0			=C2=A0=C2=A0 VSDC_FB_CONFIG_UV_SWIZZLE_EN,
> > =C2=A0			=C2=A0=C2=A0 vs_state->format.uv_swizzle);
> > =C2=A0
> > -	dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);
> > +	/*
> > +	 * Primary plane cannot be moved, no clipping is involved,
> > +	 * so the non-clipped framebuffer address can be used.
> > +	 */
> > +	dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, 0);
> > =C2=A0
> > =C2=A0	regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 lower_32_bits(dma_addr));

