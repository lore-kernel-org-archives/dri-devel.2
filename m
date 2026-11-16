Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F9606A88C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54C610F26A;
	Mon, 16 Nov 2026 15:11:38 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2082410F26A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:11:19 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.23])
 by APP-05 (Coremail) with SMTP id zQCowAA30LUPHftqjuJEAQ--.4731S2;
 Mon, 16 Nov 2026 23:11:12 +0800 (CST)
Message-ID: <5830251f1420c152b2efc2ee37248057bdfc901d.camel@iscas.ac.cn>
Subject: Re: [PATCH v2 2/4] drm/verisilicon: nuke planes' atomic_enable hooks
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Joey Lu
 <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 16 Nov 2026 23:11:10 +0800
In-Reply-To: <8e3b36c6-e2d8-4746-aefe-462bba1a4b05@suse.de>
References: <20261102075710.1286456-1-zhengxingda@iscas.ac.cn>
 <20261102075710.1286456-3-zhengxingda@iscas.ac.cn>
 <8e3b36c6-e2d8-4746-aefe-462bba1a4b05@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: zQCowAA30LUPHftqjuJEAQ--.4731S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1xtr4rCr1kWF1xWryDZFb_yoWxWF43pr
 sYyFW8Kw4rZayvqF9rtw4DKay3Ww4Iy34Igr4DG3ZIqrnxtwsrua18Xr93uF4DJrZ7G3Wf
 tFsFywnxAr1fAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
 ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-16=E4=B8=80=E7=9A=84 14:37 +0100=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 02.11.26 um 08:57 schrieb Icenowy Zheng:
> > The atomic_update hooks of both planes are just bailing out early
> > when
> > the planes are invisible, so it's reasonable to just remove these
> > hooks
> > and update the enabled state in atomic_update.
> >=20
> > This fixes the problem that invisible but enabled planes won't be
> > shown when made visible, as pointed by Sashiko.
> >=20
> > Fixes: dbf21777caa8 ("drm: verisilicon: add a driver for
> > Verisilicon display controllers")
> > Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor
> > planes")
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> > =C2=A0 drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 22 +++----------=
-
> > --
> > =C2=A0 .../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 | 2=
6 +++++---------
> > -----
> > =C2=A0 2 files changed, 10 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > index da456dced88aa..5295dc2f9ee2e 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > @@ -98,23 +98,6 @@ static void vs_cursor_plane_commit(struct vs_dc
> > *dc, unsigned int output)
> > =C2=A0=C2=A0			VSDC_CURSOR_CONFIG_IMG_UPDATE);
> > =C2=A0 }
> > =C2=A0=20
> > -static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
> > -					=C2=A0=C2=A0 struct
> > drm_atomic_commit *atomic_state)
> > -{
> > -	struct drm_plane_state *state =3D
> > drm_atomic_get_new_plane_state(atomic_state,
> > -
> > 								=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 plane);
> > -	struct drm_crtc *crtc =3D state->crtc;
> > -	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > -	unsigned int output =3D vcrtc->id;
> > -	struct vs_dc *dc =3D vcrtc->dc;
> > -
> > -	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> > -			=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_FMT_MASK,
> > -			=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_FMT_ARGB8888);
> > -
> > -	vs_cursor_plane_commit(dc, output);
> > -}
> > -
> > =C2=A0 static void vs_cursor_plane_atomic_disable(struct drm_plane
> > *plane,
> > =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0 struct
> > drm_atomic_commit *atomic_state)
> > =C2=A0 {
> > @@ -153,6 +136,10 @@ static void
> > vs_cursor_plane_atomic_update(struct drm_plane *plane,
> > =C2=A0=C2=A0	output =3D vcrtc->id;
> > =C2=A0=C2=A0	dc =3D vcrtc->dc;
> > =C2=A0=20
> > +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> > +			=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_FMT_MASK,
> > +			=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_FMT_ARGB8888);
> > +
> > =C2=A0=C2=A0	/* Other sizes should be rejected by atomic_check */
> > =C2=A0=C2=A0	switch (state->crtc_w) {
> > =C2=A0=C2=A0	case 32:
> > @@ -225,7 +212,6 @@ static void
> > vs_cursor_plane_atomic_update(struct drm_plane *plane,
> > =C2=A0 static const struct drm_plane_helper_funcs
> > vs_cursor_plane_helper_funcs =3D {
> > =C2=A0=C2=A0	.atomic_check	=3D vs_cursor_plane_atomic_check,
> > =C2=A0=C2=A0	.atomic_update	=3D vs_cursor_plane_atomic_update,
> > -	.atomic_enable	=3D vs_cursor_plane_atomic_enable,
> > =C2=A0=C2=A0	.atomic_disable	=3D vs_cursor_plane_atomic_disable,
>=20
> But now you have the worst of both worlds: atomic_disable is still=20
> around but also done by atomic_update. And atomic_update always sets=20
> these registers even if the plane is already visible.
>=20
> I'd instead remove the disable calls from atomic_update [1] . I think
> you should never reach this is you have an atomic_disable installed.
> See=20
> [1] for the logic.

The drm_atomic_plane_disabling() function only checks whether a CRTC is
bound -- I think it could be possible that a plane is bound to a CRTC
but with an invisible coordinate (especially for the cursor plane).

The end of drm_atomic_helper_check_plane_state() says:

```
	if (!plane_state->visible)
		/*
		 * Plane isn't visible; some drivers can handle this
		 * so we just return success here.  Drivers that can't
		 * (including those that use the primary plane
helper's
		 * update function) will return an error from their
		 * update_plane handler.
		 */
		return 0;
```

Thanks,
Icenowy

>=20
> [1]=20
> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/drm_atomic=
_helper.c#L3030
>=20
> Best regards
> Thomas
>=20
> > =C2=A0 };
> > =C2=A0=20
> > diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > index 8e94491693019..fca692f4f7d5c 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > @@ -59,25 +59,6 @@ static void vs_primary_plane_commit(struct vs_dc
> > *dc, unsigned int output)
> > =C2=A0=C2=A0			VSDC_FB_CONFIG_EX_COMMIT);
> > =C2=A0 }
> > =C2=A0=20
> > -static void vs_primary_plane_atomic_enable(struct drm_plane
> > *plane,
> > -					=C2=A0=C2=A0 struct
> > drm_atomic_commit *atomic_state)
> > -{
> > -	struct drm_plane_state *state =3D
> > drm_atomic_get_new_plane_state(atomic_state,
> > -
> > 								=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 plane);
> > -	struct drm_crtc *crtc =3D state->crtc;
> > -	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > -	unsigned int output =3D vcrtc->id;
> > -	struct vs_dc *dc =3D vcrtc->dc;
> > -
> > -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > -			VSDC_FB_CONFIG_EX_FB_EN);
> > -	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > -			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> > -			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> > -
> > -	vs_primary_plane_commit(dc, output);
> > -}
> > -
> > =C2=A0 static void vs_primary_plane_atomic_disable(struct drm_plane
> > *plane,
> > =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0 struct
> > drm_atomic_commit *atomic_state)
> > =C2=A0 {
> > @@ -144,13 +125,18 @@ static void
> > vs_primary_plane_atomic_update(struct drm_plane *plane,
> > =C2=A0=C2=A0	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
> > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_FB_BLEND_CONFIG_BLEND_DISAB=
LE);
> > =C2=A0=20
> > +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > +			VSDC_FB_CONFIG_EX_FB_EN);
> > +	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > +			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> > +			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> > +
> > =C2=A0=C2=A0	vs_primary_plane_commit(dc, output);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static const struct drm_plane_helper_funcs
> > vs_primary_plane_helper_funcs =3D {
> > =C2=A0=C2=A0	.atomic_check	=3D vs_primary_plane_atomic_check,
> > =C2=A0=C2=A0	.atomic_update	=3D vs_primary_plane_atomic_update,
> > -	.atomic_enable	=3D vs_primary_plane_atomic_enable,
> > =C2=A0=C2=A0	.atomic_disable	=3D vs_primary_plane_atomic_disable,
> > =C2=A0 };
> > =C2=A0=20

