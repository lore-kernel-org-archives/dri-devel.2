Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36B606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E9C10FDA2;
	Wed, 18 Nov 2026 14:55:02 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B972210FD7F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:54:59 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.23])
 by APP-05 (Coremail) with SMTP id zQCowAAXrrM7vP1q8AppAQ--.6503S2;
 Wed, 18 Nov 2026 22:54:51 +0800 (CST)
Message-ID: <14e5c5d17414562b36b1650955dc440a68a83e71.camel@iscas.ac.cn>
Subject: Re: [PATCH v2 2/4] drm/verisilicon: nuke planes' atomic_enable hooks
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Joey Lu
 <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 22:54:50 +0800
In-Reply-To: <4404265c-ae14-4d17-82ad-46ed6c123c6b@suse.de>
References: <20261102075710.1286456-1-zhengxingda@iscas.ac.cn>
 <20261102075710.1286456-3-zhengxingda@iscas.ac.cn>
 <8e3b36c6-e2d8-4746-aefe-462bba1a4b05@suse.de>
 <5830251f1420c152b2efc2ee37248057bdfc901d.camel@iscas.ac.cn>
 <55991183-ab5f-4445-afce-37a79310ef27@suse.de>
 <83aa9fb5be26fb407c7f1393bc01099d374cf51f.camel@iscas.ac.cn>
 <7e4b4fd185f47404bb5f18e7c2c8086d24e673f4.camel@iscas.ac.cn>
 <a96e7813-6918-44f5-82e2-ca40051abea0@suse.de>
 <73f4e371c37c36581240ff355fef3de2afaaa033.camel@iscas.ac.cn>
 <4404265c-ae14-4d17-82ad-46ed6c123c6b@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: zQCowAAXrrM7vP1q8AppAQ--.6503S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWfXrWxur4kGr1fWFW7Jwb_yoWfKFyxpr
 WktF18KrWrXry8Jry7tw4jyFWaqr4Ut347Xr15JF1jqrn0krnrWF18trnruF48Xr48G3Wx
 Jr47AF9rZr18AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-17=E4=BA=8C=E7=9A=84 08:39 +0100=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 17.11.26 um 08:34 schrieb Icenowy Zheng:
> > =E5=9C=A8 2026-11-17=E4=BA=8C=E7=9A=84 08:25 +0100=EF=BC=8CThomas Zimme=
rmann=E5=86=99=E9=81=93=EF=BC=9A
> > > Hi
> > >=20
> > > Am 17.11.26 um 06:19 schrieb Icenowy Zheng:
> > > [...]
> > > > > > Sure, but is that a problem for this hardware?
> > > > > For the cursor plane, the unchecked coordinate might be
> > > > > improper
> > > > > for
> > > > > the registers.
> > > > >=20
> > > > > For the primary plane, if the plane is found to be totally
> > > > > off by
> > > > > drm_atomic_helper_check_plane_state(), the check for
> > > > > can_position,
> > > > > which is below the code snippet I referenced, would be
> > > > > bypassed,
> > > > > and
> > > > > such plane would be programmed to be visible by the
> > > > > atomic_update
> > > > > hook
> > > > > even if it shouldn't be visible.
> > > > Well I am now thinking that bound-but-invisible situation is
> > > > commonly
> > > > ignored by drivers.
> > > >=20
> > > > For drm/verisilicon, maybe I'd remove both atomic_disable and
> > > > atomic_enable; however I think the atomic helpers may need some
> > > > flag to
> > > > consider bound-but-invisible planes when calling
> > > > atomic_{dis,en}able.
> > > I don't think I really understand what you're up to, but it seems
> > > you're
> > > overthinking the whole thing. Other drivers only care about plane
> > > on/off
> > Well I don't know whether I am overthinking...
> >=20
> > Enabled but invisible planes are explicitly allowed in
> > drm_atomic_helper_check_plane_state(), and even the can_position
> > check
> > is bypassed in such case (so such a configuration can even appear
> > on
> > primary planes). In addition, in most implementations for
> > atomic_check,
> > the invisible situations have the validity check explicitly
> > skipped, so
> > just disallow enabled-but-invisible planes in atomic_check would
> > make
> > the behavior quite different with most drivers.
> >=20
> > Maybe I should craft some "evil" programs to check for this
> > situation.
>=20
> If you can make an igt test case for broken plane coordinates, go for
> it.

Well the behavior here is possible to be examined with modetest.

My conclusion is that off-screen plane coordinates is really something
needed to be handled. I think I am not overthinking, but I will drop
both atomic_enable and atomic_disable for symmetry in the next revision
of this patchset.

In the following tests, connector 48 is connected to a HDMI sink (a
capture card) with a preferred mode at 1280x720@60, CRTC 46 is second
CRTC (which is hardwired to the HDMI connector), plane 41 is the
primary plane of CRTC 46 and plane 43 is the cursor plane of CRTC 46.

`modetest -s 48:1280x720 -P 43@46:64x64+200+200@AR24` properly creates
a 64x64 overlay at (200, 200).

`modetest -s 48:1280x720 -P=C2=A041@46:1280x720@XR24` changes the whole
primary plane to a overlay pattern.

`modetest -s 48:1280x720 -P 41@46:1280x720+200+200@XR24` displays SMPTE
pattern (instead of overlay pattern) on the primary plane, and the
plane operation fails with `failed to enable plane: Invalid argument`
error message (which means an offseted position of the primary plane is
rejected).

With no patch applied to v7.4-rc3 drm/verisilicon:

`modetest -s 48:1280x720 -P 43@46:64x64+2000+2000@AR24` crashes the
kernel with NULL pointer dereference caused by
vs_cursor_plane_atomic_disable() called by
vs_cursor_plane_atomic_update().

With vs_cursor_plane_atomic_disable() call removed from
vs_cursor_plane_atomic_update():

`modetest -s 48:1280x720 -P 43@46:64x64+2000+2000@AR24` leaves dirty
state in the cursor configuration registers, and the cursor is fully
visible when it shouldn't (when running after setting the cursor at
(200, 200), the cursor is left at (200, 200) instead of being hidden).

Even `modetest -s 48:1280x720 -P 43@46:40x64+2000+2000@AR24` in this
case shows the cursor plane despite the hardware only accepts squared
cursors because of the validity check of off-screen planes is skipped
(which means programming registers in atomic_update callback is now not
safe).

Then, with PATCH v2 3/4 from this patchset applied:

`modetest -s 48:1280x720 -P 41@46:1280x720+2000+2000@XR24` leaves a
black screen, without any error message (because the off-screen
position of the primary plane isn't rejected and makes the plane
invisible).

Then, with vs_primary_plane_atomic_disable() call removed from
vs_primary_plane_atomic_update():

`modetest -s 48:1280x720 -P 41@46:1280x720+2000+2000@XR24` displays
SMPTE pattern (instead of overlay pattern) on the primary plane, and no
error message is shown.

Thanks,
Icenowy

>=20
> Best regards
> Thomas
>=20
> >=20
> > Thanks,
> > Icenowy
> >=20
> > > and the contained image. That's also what the 3 callbacks are
> > > for. It
> > > usually works nicely. Hence me asking. But maybe verisilicon is
> > > different, IDK.
> > >=20
> > > My suggestion is therefore to remove _enable and _disable and
> > > keep
> > > all
> > > logic in _update.
> > >=20
> > > atomic_update()
> > > {
> > > =C2=A0=C2=A0=C2=A0 =C2=A0 if (plane_state->visible) {
> > > =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 // do update
> > > =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 // enable hw plane
> > > =C2=A0=C2=A0=C2=A0 =C2=A0 } else {
> > > =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 // disable hw plane
> > > =C2=A0=C2=A0=C2=A0 =C2=A0 }
> > > }
> > >=20
> > > If you have any special cases where you want visible to be false
> > > (or
> > > true), detect them in atomic_check and set the flags accordingly.
> > >=20
> > > atomic_check()
> > > {
> > > drm_atomic_helper_check_plane_state() =C2=A0 =C2=A0 if (awkward coord=
s)
> > > =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plane_state->visible =
=3D false;
> > > }
> > >=20
> > > Best regards
> > > Thomas
> > >=20
> > > > Thanks,
> > > > Icenowy
> > > >=20
> > > > > Thanks,
> > > > > Icenowy
> > > > >=20
> > > > > > Best regards
> > > > > > Thomas
> > > > > >=20
> > > > > > > The end of drm_atomic_helper_check_plane_state() says:
> > > > > > >=20
> > > > > > > ```
> > > > > > > 	if (!plane_state->visible)
> > > > > > > 		/*
> > > > > > > 		 * Plane isn't visible; some drivers can
> > > > > > > handle
> > > > > > > this
> > > > > > > 		 * so we just return success here.=C2=A0
> > > > > > > Drivers
> > > > > > > that
> > > > > > > can't
> > > > > > > 		 * (including those that use the primary
> > > > > > > plane
> > > > > > > helper's
> > > > > > > 		 * update function) will return an error
> > > > > > > from
> > > > > > > their
> > > > > > > 		 * update_plane handler.
> > > > > > > 		 */
> > > > > > > 		return 0;
> > > > > > > ```
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > > Icenowy
> > > > > > >=20
> > > > > > > > [1]
> > > > > > > > https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/=
drm/drm_atomic_helper.c#L3030
> > > > > > > >=20
> > > > > > > > Best regards
> > > > > > > > Thomas
> > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > diff --git
> > > > > > > > > a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > > > > > > > > b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > > > > > > > > index 8e94491693019..fca692f4f7d5c 100644
> > > > > > > > > --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > > > > > > > > +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > > > > > > > > @@ -59,25 +59,6 @@ static void
> > > > > > > > > vs_primary_plane_commit(struct
> > > > > > > > > vs_dc
> > > > > > > > > *dc, unsigned int output)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0			VSDC_FB_CONFIG_EX_COMMIT=
);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > -static void vs_primary_plane_atomic_enable(struct
> > > > > > > > > drm_plane
> > > > > > > > > *plane,
> > > > > > > > > -					=C2=A0=C2=A0 struct
> > > > > > > > > drm_atomic_commit *atomic_state)
> > > > > > > > > -{
> > > > > > > > > -	struct drm_plane_state *state =3D
> > > > > > > > > drm_atomic_get_new_plane_state(atomic_state,
> > > > > > > > > -
> > > > > > > > > 					=09
> > > > > > > > > =09
> > > > > > > > > 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 plane);
> > > > > > > > > -	struct drm_crtc *crtc =3D state->crtc;
> > > > > > > > > -	struct vs_crtc *vcrtc =3D
> > > > > > > > > drm_crtc_to_vs_crtc(crtc);
> > > > > > > > > -	unsigned int output =3D vcrtc->id;
> > > > > > > > > -	struct vs_dc *dc =3D vcrtc->dc;
> > > > > > > > > -
> > > > > > > > > -	regmap_set_bits(dc->regs,
> > > > > > > > > VSDC_FB_CONFIG_EX(output),
> > > > > > > > > -			VSDC_FB_CONFIG_EX_FB_EN);
> > > > > > > > > -	regmap_update_bits(dc->regs,
> > > > > > > > > VSDC_FB_CONFIG_EX(output),
> > > > > > > > > -		=09
> > > > > > > > > VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> > > > > > > > > -		=09
> > > > > > > > > VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> > > > > > > > > -
> > > > > > > > > -	vs_primary_plane_commit(dc, output);
> > > > > > > > > -}
> > > > > > > > > -
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 static void
> > > > > > > > > vs_primary_plane_atomic_disable(struct
> > > > > > > > > drm_plane
> > > > > > > > > *plane,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0 str=
uct
> > > > > > > > > drm_atomic_commit *atomic_state)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 {
> > > > > > > > > @@ -144,13 +125,18 @@ static void
> > > > > > > > > vs_primary_plane_atomic_update(struct drm_plane
> > > > > > > > > *plane,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	regmap_write(dc->regs,
> > > > > > > > > VSDC_FB_BLEND_CONFIG(output),
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	=09
> > > > > > > > > VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > +	regmap_set_bits(dc->regs,
> > > > > > > > > VSDC_FB_CONFIG_EX(output),
> > > > > > > > > +			VSDC_FB_CONFIG_EX_FB_EN);
> > > > > > > > > +	regmap_update_bits(dc->regs,
> > > > > > > > > VSDC_FB_CONFIG_EX(output),
> > > > > > > > > +		=09
> > > > > > > > > VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> > > > > > > > > +		=09
> > > > > > > > > VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	vs_primary_plane_commit(dc=
, output);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 static const struct drm_plane_he=
lper_funcs
> > > > > > > > > vs_primary_plane_helper_funcs =3D {
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	.atomic_check	=3D
> > > > > > > > > vs_primary_plane_atomic_check,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	.atomic_update	=3D
> > > > > > > > > vs_primary_plane_atomic_update,
> > > > > > > > > -	.atomic_enable	=3D
> > > > > > > > > vs_primary_plane_atomic_enable,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	.atomic_disable	=3D
> > > > > > > > > vs_primary_plane_atomic_disable,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20

