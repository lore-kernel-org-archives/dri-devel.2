Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255E6FCD0C5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCFC10E6B7;
	Wed, 18 Mar 2026 07:15:41 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA6A10E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:15:39 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.43])
 by APP-05 (Coremail) with SMTP id zQCowAAntwoVUbppdR69Cg--.45953S2;
 Wed, 18 Mar 2026 15:15:34 +0800 (CST)
Message-ID: <5a6f224147ad80d9c873b00208e387de429fcb2c.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/loongson: stop to set get_vblank_timestamp for
 7A1000 CRTC
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Thomas Zimmermann <tzimmermann@suse.de>, Sui Jingfeng	
 <suijingfeng@loongson.cn>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Mar 2026 15:15:33 +0800
In-Reply-To: <27689c69-dca3-4d5b-b385-b9ee2391a9d9@suse.de>
References: <20260314165421.1201790-1-zhengxingda@iscas.ac.cn>
 <e716ebde-a4f3-4035-bb21-3c6ab2fe06a4@suse.de>
 <8b52a9190a237a8bb94a23bf06b6a0589394f553.camel@iscas.ac.cn>
 <27689c69-dca3-4d5b-b385-b9ee2391a9d9@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowAAntwoVUbppdR69Cg--.45953S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF17Kr17KF45tFyrZFyfXrb_yoWrCw48pF
 WqkFnFyr4DtFyaywnFqF18ZayF93yrJF93WryDKw13C3yDtF1xCF40yr43uFy7Xrn3Ga12
 qrn2gr1akFn09aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgcTQUUUUU
X-Originating-IP: [112.94.100.43]
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

=E5=9C=A8 2026-03-18=E4=B8=89=E7=9A=84 08:09 +0100=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 18.03.26 um 07:16 schrieb Icenowy Zheng:
> > =E5=9C=A8 2026-03-16=E4=B8=80=E7=9A=84 08:53 +0100=EF=BC=8CThomas Zimme=
rmann=E5=86=99=E9=81=93=EF=BC=9A
> > >=20
> > > Am 14.03.26 um 17:54 schrieb Icenowy Zheng:
> > > > As there's no known hardware capability about querying vblank
> > > > on
> > > > the
> > > > 7A1000 display controller, setting get_vblank_timestamp will
> > > > mislead the
> > > > kernel about the support of DC-backed high precision vblank
> > > > query.
> > > >=20
> > > > Drop this function pointer in the CRTC function table for
> > > > 7A1000.
> > > >=20
> > > > This solves a kernel warning when booting Linux 7.0-rc3 on a
> > > > 3A4000+7A1000 Haier Boyue G51 laptop (with injected EDID for
> > > > replicating
> > > > the display timing set by the firmware).
> > > >=20
> > > > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Well, is my following understand right?
> >=20
> > - A hardware that does not have hardware vblank timing/counting
> > ability
> > shouldn't set .get_vblank_timestamp .
> > - A hardware that supports vblank counting but not timing should
> > set
> > .get_vblank_timestamp to the
> > drm_crtc_vblank_helper_get_vblank_timestamp helper to allow vblank
> > timing estimate with counter.
>=20
> Setting drm_crtc_vblank_helper_get_vblank_timestamp() also requires
> to=20
> read out the x/y positions. See get_scanout_position. You can leave
> out=20
> get_vblank_timestamp entirely and DRM will approximate the values
> with=20
> the system timer. For reading the vblank counter, there's=20
> get_vblank_counter if the hardware supports it.

It seems that the loongson driver already implemented
.get_scanout_position hook.

Is both .get_scanout_position and .get_vblank_counter requirement for
drm_crtc_vblank_helper_get_vblank_timestamp() to work?

> >=20
> > (P.S. There's a DisplayCurrentLocation register that is valid for
> > 7A1000, which returns the current X and Y positions; but I wonder
> > whether this is meaningful for vblank querying.
>=20
> That sounds like the functionality required for get_scanout_position.
>=20
> > In addition, this DC looks quite similar to Verisilicon DCNano,
> > which
> > was used by i.MX8ULP (although many functionality on the i.MX8ULP
> > manual is missing, things until cursor0 match between LS7A2000
> > manual
> > and i.MX8ULP manual). I wonder whether NXP people abandoned the
> > mainlining of DCNano driver because of drm/loongson?)
>=20
> IDK anything about that.

Well I wonder about such kind of "similar display hardware on different
bus" things, because PCI devices usually use different memory
management system than platform devices (the former usually use TTM and
the latter usually directly use dma memory).

In fact LS7A1000 contains a Vivante GPU that isn't supported by etnaviv
driver yet (and the etnaviv driver now hardcodes to use DMA memory,
although the GPU has private memory that is shared with DC (currently
managed by DC driver's TTM)).

>=20
>=20
> > P.S.2. I saw that Sui Jingfeng's mailbox is bouncing and the driver
> > is
> > going to be orphaned. If he wouldn't react with other ways, maybe I
> > could try to maintain this driver? I have Loongson-3A4000 +
> > LS7A1000
> > and Loongson-3A6000 + LS7A2000 hardwares at home.
>=20
> Yes, the driver is now orphaned.=C2=A0 No one else from Loongson has show=
n
> up=20
> to maintain it either. If you want it, just send a patch to add you
> as=20
> maintainer with a short rational.
>=20
> Best regards
> Thomas
>=20
> >=20
> > > > ---
> > > > =C2=A0=C2=A0 drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
> > > > =C2=A0=C2=A0 1 file changed, 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > index 587fbe285e9ef..b3af8e0cdb15f 100644
> > > > --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
> > > > ls7a1000_crtc_funcs =3D {
> > > > =C2=A0=C2=A0=C2=A0	.late_register =3D lsdc_crtc_late_register,
> > > > =C2=A0=C2=A0=C2=A0	.enable_vblank =3D lsdc_crtc_enable_vblank,
> > > > =C2=A0=C2=A0=C2=A0	.disable_vblank =3D lsdc_crtc_disable_vblank,
> > > > -	.get_vblank_timestamp =3D
> > > > drm_crtc_vblank_helper_get_vblank_timestamp,
> > > > =C2=A0=C2=A0=C2=A0	.atomic_print_state =3D lsdc_crtc_atomic_print_s=
tate,
> > > > =C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=20

