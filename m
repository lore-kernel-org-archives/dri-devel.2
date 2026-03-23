Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42285EC01B4
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88D410E0DD;
	Mon, 23 Mar 2026 09:40:52 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DF810E0DD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:40:51 +0000 (UTC)
Received: from [192.168.1.204] (unknown [112.94.102.202])
 by APP-03 (Coremail) with SMTP id rQCowABXdt2YCsFpREmJCw--.12851S2;
 Mon, 23 Mar 2026 17:40:42 +0800 (CST)
Message-ID: <4141b0a640f4d703053dad2c1dd257835881f0e2.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/loongson: stop to set get_vblank_timestamp for
 LS7A1000 CRTC
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Jianmin Lv <lvjianmin@loongson.cn>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Qianhai Wu	 <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai	 <jeffbai@aosc.io>, Xi
 Ruoyao <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Mar 2026 17:40:40 +0800
In-Reply-To: <e11078cb-7536-b5d2-b753-16d25093a403@loongson.cn>
References: <20260321092804.3519447-1-zhengxingda@iscas.ac.cn>
 <47337244ebd0ce4efd3e065183e863421925f99f.camel@iscas.ac.cn>
 <e11078cb-7536-b5d2-b753-16d25093a403@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowABXdt2YCsFpREmJCw--.12851S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWrtFW5Wry7tF47KrWxJFb_yoW7JF4fpF
 47JF1Ykr48tr17Jwsrtr1rJr1xKr1ay3ZrJr17twn8Aw1UGr18tF18ArW7GwnxWryDJ39x
 t3ZrJr4UKr92kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU56yI5UUUUU==
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

=E5=9C=A8 2026-03-23=E4=B8=80=E7=9A=84 11:40 +0800=EF=BC=8CJianmin Lv=E5=86=
=99=E9=81=93=EF=BC=9A
>=20
>=20
> On 2026/3/21 =E4=B8=8B=E5=8D=885:29, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-03-21=E5=85=AD=E7=9A=84 17:28 +0800=EF=BC=8CIcenowy Zhen=
g=E5=86=99=E9=81=93=EF=BC=9A
> > > As there's no known hardware capability about querying vblank on
> > > the
> > > LS7A1000 display controller, setting get_vblank_timestamp will
> > > mislead the
> > > kernel about the support of DC-backed high precision vblank
> > > query.
> > >=20
> > > Drop this function pointer in the CRTC function table for
> > > LS7A1000.
> > >=20
> > > This solves a kernel warning when booting Linux 7.0-rc3 on a
> > > Loongson-3A4000+LS7A1000 Haier Boyue G51 laptop (with injected
> > > EDID
> > > for
> > > replicating the display timing set by the firmware).
> > >=20
> The drm_crtc_vblank_helper_get_vblank_timestamp will call=20
> get_scanout_position hook to caculate timestamp, and the driver has=20
> get_scanout_position to support it (LS7A1000 has related register).
> So=20
> the get_vblank_timestamp hook is ok for LS7A1000, and we'd better
> look=20
> into the warning information.

The warning information is copied here:
```
[    0.334960] ------------[ cut here ]------------
[    0.334960] WARNING: drivers/gpu/drm/drm_vblank.c:747 at
drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x3c8/0x438,
CPU#0: kworker/0:1/11
[    0.334960] loongson 0000:00:06.1: [drm]
drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))
[    0.334960] Modules linked in:
[    0.334960] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted
7.0.0-rc4-3a4000-laptop-test+ #31 PREEMPT=20
[    0.334960] Hardware name: Haier Boyue G51/Boyue G51, BIOS
K3L3A4000.HR10.200909.T 09/09/2020
[    0.334960] Workqueue: events drm_fb_helper_damage_work
[    0.334960] Stack : ffffffff819dec03 0000000000000000
0000000000000018 9800000100223938
[    0.334960]         9800000100223938 9800000100223a68
0000000000000000 0000000000000000
[    0.334960]         b8e8b3f2ec6b8200 98000000092bffa8
9800000100223768 0000000000000000
[    0.334960]         ffffffff81632b08 0000000000000030
ffffffff813c9530 0000000000200b20
[    0.334960]         fffffffffffffffc 0000000000000000
0000000000000000 ffffffff816c1d50
[    0.334960]         ffffffff81890000 00000000000002eb
0000000000000000 ffffffff80c1b180
[    0.334960]         9800000100ff8500 0000000000000000
9800000005c965a8 0000000000000000
[    0.334960]         ffffffff81a70000 9800000100220000
9800000100223930 0000000000000000
[    0.334960]         ffffffff802274dc 0000000000000000
0000000000000000 0000000000000000
[    0.334960]         0000000000000000 0000000000000000
ffffffff802274fc b8e8b3f2ec6b8200
[    0.334960]         ...
[    0.334960] Call Trace:
[    0.334960] [<ffffffff802274fc>] show_stack+0x64/0x158
[    0.334960] [<ffffffff8021bac4>] dump_stack_lvl+0x70/0xb0
[    0.334960] [<ffffffff8026a988>] __warn+0xa8/0x120
[    0.334960] [<ffffffff8026ab60>] warn_slowpath_fmt+0x160/0x1f8
[    0.334960] [<ffffffff80be5668>]
drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x3c8/0x438
[    0.334960] [<ffffffff80be48d8>]
drm_crtc_get_last_vbltimestamp+0x68/0xb0
[    0.334960] [<ffffffff80be5e14>] drm_update_vblank_count+0xac/0x418
[    0.334960] [<ffffffff80be6270>] drm_vblank_enable+0xf0/0x288
[    0.334960] [<ffffffff80be7010>] drm_vblank_get+0xf8/0x160
[    0.334960] [<ffffffff80beb2e0>]
drm_client_modeset_wait_for_vblank+0x50/0xa0
[    0.334960] [<ffffffff80c0a144>]
drm_fb_helper_damage_work+0x8c/0x1d8
[    0.334960] [<ffffffff8028fac8>] process_one_work+0x198/0x348
[    0.334960] [<ffffffff802906c0>] worker_thread+0x238/0x390
[    0.334960] [<ffffffff8029c0d8>] kthread+0x160/0x198
[    0.334960] [<ffffffff8021fd8c>] ret_from_kernel_thread+0x14/0x1c

[    0.334960] ---[ end trace 0000000000000000 ]---
```

>=20
> > > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> >=20
> > Oh forgot to attach when crafting v2:
> >=20
> > ```
> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ```
> >=20
> > > ---
> > > Changes in v2:
> > > - Re-formatted Loongson product model numbers per request from
> > > Huacai.
> > >=20
> > > =C2=A0=C2=A0drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
> > > =C2=A0=C2=A01 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > index 587fbe285e9ef..b3af8e0cdb15f 100644
> > > --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > > @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
> > > ls7a1000_crtc_funcs =3D {
> > > =C2=A0=C2=A0	.late_register =3D lsdc_crtc_late_register,
> > > =C2=A0=C2=A0	.enable_vblank =3D lsdc_crtc_enable_vblank,
> > > =C2=A0=C2=A0	.disable_vblank =3D lsdc_crtc_disable_vblank,
> > > -	.get_vblank_timestamp =3D
> > > drm_crtc_vblank_helper_get_vblank_timestamp,
> > > =C2=A0=C2=A0	.atomic_print_state =3D lsdc_crtc_atomic_print_state,
> > > =C2=A0=C2=A0};
> > > =C2=A0=20

