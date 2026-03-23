Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCEBEC01CF
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E90510E4E8;
	Mon, 23 Mar 2026 11:42:17 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D912710E444
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:42:14 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.202])
 by APP-05 (Coremail) with SMTP id zQCowABX7A8IJ8FpfUU5Cw--.45208S2;
 Mon, 23 Mar 2026 19:42:01 +0800 (CST)
Message-ID: <ce8f801931ddde8b12086eb560e628a39e79b58c.camel@iscas.ac.cn>
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
Date: Mon, 23 Mar 2026 19:42:00 +0800
In-Reply-To: <681588dc-b4d9-4af4-b6c0-c117024593df@suse.de>
References: <20260321092804.3519447-1-zhengxingda@iscas.ac.cn>
 <47337244ebd0ce4efd3e065183e863421925f99f.camel@iscas.ac.cn>
 <e11078cb-7536-b5d2-b753-16d25093a403@loongson.cn>
 <4141b0a640f4d703053dad2c1dd257835881f0e2.camel@iscas.ac.cn>
 <681588dc-b4d9-4af4-b6c0-c117024593df@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowABX7A8IJ8FpfUU5Cw--.45208S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrykCFy3Ar1kJr48Zr1fJFb_yoWxCr1xpr
 n7JFWYkrW8Jr1xJw1qyF1rJry8KF1ayasrXrn5J3WDAr4qkr10q3W8XrW2gFnrJrs7Ar13
 tw4Dtr429ryUCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

=E5=9C=A8 2026-03-23=E4=B8=80=E7=9A=84 11:31 +0100=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 23.03.26 um 10:40 schrieb Icenowy Zheng:
> > =E5=9C=A8 2026-03-23=E4=B8=80=E7=9A=84 11:40 +0800=EF=BC=8CJianmin Lv=
=E5=86=99=E9=81=93=EF=BC=9A
> > >=20
> > > On 2026/3/21 =E4=B8=8B=E5=8D=885:29, Icenowy Zheng wrote:
> > > > =E5=9C=A8 2026-03-21=E5=85=AD=E7=9A=84 17:28 +0800=EF=BC=8CIcenowy =
Zheng=E5=86=99=E9=81=93=EF=BC=9A
> > > > > As there's no known hardware capability about querying vblank
> > > > > on
> > > > > the
> > > > > LS7A1000 display controller, setting get_vblank_timestamp
> > > > > will
> > > > > mislead the
> > > > > kernel about the support of DC-backed high precision vblank
> > > > > query.
> > > > >=20
> > > > > Drop this function pointer in the CRTC function table for
> > > > > LS7A1000.
> > > > >=20
> > > > > This solves a kernel warning when booting Linux 7.0-rc3 on a
> > > > > Loongson-3A4000+LS7A1000 Haier Boyue G51 laptop (with
> > > > > injected
> > > > > EDID
> > > > > for
> > > > > replicating the display timing set by the firmware).
> > > > >=20
> > > The drm_crtc_vblank_helper_get_vblank_timestamp will call
> > > get_scanout_position hook to caculate timestamp, and the driver
> > > has
> > > get_scanout_position to support it (LS7A1000 has related
> > > register).
> > > So
> > > the get_vblank_timestamp hook is ok for LS7A1000, and we'd better
> > > look
> > > into the warning information.
> > The warning information is copied here:
> > ```
> > [=C2=A0=C2=A0=C2=A0 0.334960] ------------[ cut here ]------------
> > [=C2=A0=C2=A0=C2=A0 0.334960] WARNING: drivers/gpu/drm/drm_vblank.c:747=
 at
> > drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x3c8/0x438,
> > CPU#0: kworker/0:1/11
> > [=C2=A0=C2=A0=C2=A0 0.334960] loongson 0000:00:06.1: [drm]
> > drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))
>=20
> This is what you should investigate. mode->crtc_clock seems invalid.
> [1]
>=20
> [1]=20
> https://elixir.bootlin.com/linux/v6.19.9/source/drivers/gpu/drm/drm_vblan=
k.c#L743
>=20
> Best regards
> Thomas
>=20
> > [=C2=A0=C2=A0=C2=A0 0.334960] Modules linked in:
> > [=C2=A0=C2=A0=C2=A0 0.334960] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 N=
ot tainted
> > 7.0.0-rc4-3a4000-laptop-test+ #31 PREEMPT
> > [=C2=A0=C2=A0=C2=A0 0.334960] Hardware name: Haier Boyue G51/Boyue G51,=
 BIOS
> > K3L3A4000.HR10.200909.T 09/09/2020
> > [=C2=A0=C2=A0=C2=A0 0.334960] Workqueue: events drm_fb_helper_damage_wo=
rk
> > [=C2=A0=C2=A0=C2=A0 0.334960] Stack : ffffffff819dec03 0000000000000000
> > 0000000000000018 9800000100223938
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 9800000100223938 9800000100223a68
> > 0000000000000000 0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 b8e8b3f2ec6b8200 98000000092bffa8
> > 9800000100223768 0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ffffffff81632b08 0000000000000030
> > ffffffff813c9530 0000000000200b20
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fffffffffffffffc 0000000000000000
> > 0000000000000000 ffffffff816c1d50
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ffffffff81890000 00000000000002eb
> > 0000000000000000 ffffffff80c1b180
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 9800000100ff8500 0000000000000000
> > 9800000005c965a8 0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ffffffff81a70000 9800000100220000
> > 9800000100223930 0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ffffffff802274dc 0000000000000000
> > 0000000000000000 0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0000000000000000 0000000000000000
> > ffffffff802274fc b8e8b3f2ec6b8200
> > [=C2=A0=C2=A0=C2=A0 0.334960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ...
> > [=C2=A0=C2=A0=C2=A0 0.334960] Call Trace:
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff802274fc>] show_stack+0x64/0x15=
8
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8021bac4>] dump_stack_lvl+0x70/=
0xb0
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8026a988>] __warn+0xa8/0x120
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8026ab60>] warn_slowpath_fmt+0x=
160/0x1f8
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80be5668>]
> > drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x3c8/0x438
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80be48d8>]
> > drm_crtc_get_last_vbltimestamp+0x68/0xb0
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80be5e14>]
> > drm_update_vblank_count+0xac/0x418
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80be6270>] drm_vblank_enable+0x=
f0/0x288
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80be7010>] drm_vblank_get+0xf8/=
0x160
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80beb2e0>]
> > drm_client_modeset_wait_for_vblank+0x50/0xa0

I doubt the problem here is that the function above is called with
hardcoded 0 by drm_fb_helper_fb_dirty() (being inlined into
drm_fb_helper_damage_work() by the compiler). Then on my setup it
failed because my primary output (laptop LCD) is on CRTC 1 (CRTC 0 is
external HDMI instead).

This is new behavior introduced by d8c4bddcd8bc ("drm/fb-helper:
Synchronize dirty worker with vblank"), and the commit messages say
`This allows several screen updates to pile up and acts as a rate
limiter.` .

Should it wait for any vblanks instead of waiting for one on CRTC 0 ?
(Or check whether CRTC 0 is on before waiting on it?)

Thanks,
Icenowy

> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff80c0a144>]
> > drm_fb_helper_damage_work+0x8c/0x1d8
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8028fac8>] process_one_work+0x1=
98/0x348
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff802906c0>] worker_thread+0x238/=
0x390
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8029c0d8>] kthread+0x160/0x198
> > [=C2=A0=C2=A0=C2=A0 0.334960] [<ffffffff8021fd8c>]
> > ret_from_kernel_thread+0x14/0x1c
> >=20
> > [=C2=A0=C2=A0=C2=A0 0.334960] ---[ end trace 0000000000000000 ]---
> > ```
> >=20
> > > > > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > > > Oh forgot to attach when crafting v2:
> > > >=20
> > > > ```
> > > > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > ```
> > > >=20
> > > > > ---
> > > > > Changes in v2:
> > > > > - Re-formatted Loongson product model numbers per request
> > > > > from
> > > > > Huacai.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
> > > > > =C2=A0=C2=A0=C2=A01 file changed, 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > > b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > > index 587fbe285e9ef..b3af8e0cdb15f 100644
> > > > > --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > > +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > > > @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
> > > > > ls7a1000_crtc_funcs =3D {
> > > > > =C2=A0=C2=A0=C2=A0	.late_register =3D lsdc_crtc_late_register,
> > > > > =C2=A0=C2=A0=C2=A0	.enable_vblank =3D lsdc_crtc_enable_vblank,
> > > > > =C2=A0=C2=A0=C2=A0	.disable_vblank =3D lsdc_crtc_disable_vblank,
> > > > > -	.get_vblank_timestamp =3D
> > > > > drm_crtc_vblank_helper_get_vblank_timestamp,
> > > > > =C2=A0=C2=A0=C2=A0	.atomic_print_state =3D lsdc_crtc_atomic_print=
_state,
> > > > > =C2=A0=C2=A0=C2=A0};
> > > > > =C2=A0=C2=A0=20

