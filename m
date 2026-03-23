Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664E2F4612C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB9410E03F;
	Mon, 23 Mar 2026 14:33:48 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B159710E03F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:33:47 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.202])
 by APP-03 (Coremail) with SMTP id rQCowAB3l95BT8Fp41ePCw--.62737S2;
 Mon, 23 Mar 2026 22:33:37 +0800 (CST)
Message-ID: <a647782a7f7ddb7d7ed1a86a211267ce88b8b0a9.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/loongson: stop to set get_vblank_timestamp for
 LS7A1000 CRTC
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Thomas Zimmermann <tzimmermann@suse.de>, Jianmin Lv
 <lvjianmin@loongson.cn>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Qianhai
 Wu	 <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Mingcong
 Bai	 <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Mar 2026 22:33:36 +0800
In-Reply-To: <f98ea316-f7f7-4506-aead-4658f2a03c8d@suse.de>
References: <20260321092804.3519447-1-zhengxingda@iscas.ac.cn>
 <47337244ebd0ce4efd3e065183e863421925f99f.camel@iscas.ac.cn>
 <e11078cb-7536-b5d2-b753-16d25093a403@loongson.cn>
 <4141b0a640f4d703053dad2c1dd257835881f0e2.camel@iscas.ac.cn>
 <681588dc-b4d9-4af4-b6c0-c117024593df@suse.de>
 <ce8f801931ddde8b12086eb560e628a39e79b58c.camel@iscas.ac.cn>
 <f98ea316-f7f7-4506-aead-4658f2a03c8d@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAB3l95BT8Fp41ePCw--.62737S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW5JFW7GF45Ww48KryxuFg_yoWrZFW5pr
 s7GF1YyrWkJryxAwsFq3W8Ja48KF45JasrZr98J3Z8Z398Krn2g3W8Zr43uFnrWrs3A343
 tr4Dtr129r1qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
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
X-Originating-IP: [112.94.102.202]
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

=E5=9C=A8 2026-03-23=E4=B8=80=E7=9A=84 14:32 +0100=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 23.03.26 um 12:42 schrieb Icenowy Zheng:
> [...]
> > > > drm_update_vblank_count+0xac/0x418
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80be6270>]
> > > > drm_vblank_enable+0xf0/0x288
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80be7010>] drm_vblank_get+0=
xf8/0x160
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80beb2e0>]
> > > > drm_client_modeset_wait_for_vblank+0x50/0xa0
> > I doubt the problem here is that the function above is called with
> > hardcoded 0 by drm_fb_helper_fb_dirty() (being inlined into
> > drm_fb_helper_damage_work() by the compiler). Then on my setup it
> > failed because my primary output (laptop LCD) is on CRTC 1 (CRTC 0
> > is
> > external HDMI instead).
>=20
> The CRTC 0 has vblank interrupt. The CRTC 1 does not. Is that
> correct?

Both have vblank interrupts support. The situation here is that only
the CRTC 1 is actively outputting an image; the CRTC 0 has remaining
timing programmed by the firmware and being running the timing
generator, but not doing DMA nor generating image. (I think this could
be on purpose to prevent some registers from being erased?)

BTW after this warning, the vblank of CRTC 0 is enabled, and no one
bother to disable it, so the interrupt triggers continously.

>=20
> >=20
> > This is new behavior introduced by d8c4bddcd8bc ("drm/fb-helper:
> > Synchronize dirty worker with vblank"), and the commit messages say
> > `This allows several screen updates to pile up and acts as a rate
> > limiter.` .
>=20
> This should work if the vblanks are configured correctly.

Hardcoding 0 here sounds not correct to me, see my analyze below.

By the way, the other codepath, ioctl FBIO_WAITFORVSYNC, mentions that
hardcoding 0 there is just guessing `The first CRTC should be the
integrated panel on most drivers`, and suggests affected applications
to switch to KMS -- but the fb dirty codepath is used by fbcon, the
biggest fbdev consumer here not yet converted...

>=20
>=20
> >=20
> > Should it wait for any vblanks instead of waiting for one on CRTC 0
> > ?
> > (Or check whether CRTC 0 is on before waiting on it?)
>=20
> It should only wait for the vblank on the CRTC it uses (1 in your
> case).

I traced some code:

The second parameter of drm_client_modeset_wait_for_vblank is called
crtc_index, and it tries to retrieve the CRTC with `client->
modesets[crtc_index].crtc` ; the modesets array is initialized with:

```
	drm_for_each_crtc(crtc, dev)
		client->modesets[i++].crtc =3D crtc;
```

So non-active CRTCs are also included, and hardcoding 0 here can easily
hit non-active CRTC 0.

Thanks,
Icenowy

>=20
> Best regards
> Thomas
>=20
>=20
> >=20
> > Thanks,
> > Icenowy
> >=20
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80c0a144>]
> > > > drm_fb_helper_damage_work+0x8c/0x1d8
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8028fac8>]
> > > > process_one_work+0x198/0x348
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff802906c0>] worker_thread+0x=
238/0x390
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8029c0d8>] kthread+0x160/0x=
198
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8021fd8c>]
> > > > ret_from_kernel_thread+0x14/0x1c
> > > >=20
> > > > [=C2=A0=C2=A0=C2=A0 0.334960] ---[ end trace 0000000000000000 ]---
> > > > ```
> > > >=20
> > > > > > > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > > > > > Oh forgot to attach when crafting v2:
> > > > > >=20
> > > > > > ```
> > > > > > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > > ```
> > > > > >=20
> > > > > > > ---
> > > > > > > Changes in v2:
> > > > > > > - Re-formatted Loongson product model numbers per request
> > > > > > > from
> > > > > > > Huacai.
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/loongson/lsdc_crtc.c =
| 1 -
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A01 file changed, 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > > > > b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > > > > index 587fbe285e9ef..b3af8e0cdb15f 100644
> > > > > > > --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > > > > +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > > > > @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
> > > > > > > ls7a1000_crtc_funcs =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	.late_register =3D lsdc_crtc_late_re=
gister,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	.enable_vblank =3D lsdc_crtc_enable_=
vblank,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	.disable_vblank =3D lsdc_crtc_disabl=
e_vblank,
> > > > > > > -	.get_vblank_timestamp =3D
> > > > > > > drm_crtc_vblank_helper_get_vblank_timestamp,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	.atomic_print_state =3D
> > > > > > > lsdc_crtc_atomic_print_state,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0};
> > > > > > > =C2=A0=C2=A0=C2=A0=20

