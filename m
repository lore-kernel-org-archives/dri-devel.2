Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7356D1094462
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 09:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C988C10E269;
	Sat, 21 Mar 2026 09:29:31 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6C210E269
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 09:29:30 +0000 (UTC)
Received: from [192.168.1.204] (unknown [112.94.102.202])
 by APP-01 (Coremail) with SMTP id qwCowAB3HGjzZL5pqtuyCg--.4345S2;
 Sat, 21 Mar 2026 17:29:24 +0800 (CST)
Message-ID: <47337244ebd0ce4efd3e065183e863421925f99f.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/loongson: stop to set get_vblank_timestamp for
 LS7A1000 CRTC
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jianmin Lv	
 <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen	
 <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao	
 <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Sat, 21 Mar 2026 17:29:23 +0800
In-Reply-To: <20260321092804.3519447-1-zhengxingda@iscas.ac.cn>
References: <20260321092804.3519447-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAB3HGjzZL5pqtuyCg--.4345S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy8KFW3CrWkXr47AryDGFg_yoW8Xw1fpF
 srCr47trykXFyavwnrJ3W8u3Wfuay5Jr93uFy7tw13uw4UKr1UGF18AFsruw47XF9rJ34I
 gr1kKF1YkF429aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
 xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
 VjvjDU0xZFpf9x07beoGdUUUUU=
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

=E5=9C=A8 2026-03-21=E5=85=AD=E7=9A=84 17:28 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> As there's no known hardware capability about querying vblank on the
> LS7A1000 display controller, setting get_vblank_timestamp will
> mislead the
> kernel about the support of DC-backed high precision vblank query.
>=20
> Drop this function pointer in the CRTC function table for LS7A1000.
>=20
> This solves a kernel warning when booting Linux 7.0-rc3 on a
> Loongson-3A4000+LS7A1000 Haier Boyue G51 laptop (with injected EDID
> for
> replicating the display timing set by the firmware).
>=20
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Oh forgot to attach when crafting v2:

```
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
```

> ---
> Changes in v2:
> - Re-formatted Loongson product model numbers per request from
> Huacai.
>=20
> =C2=A0drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
> b/drivers/gpu/drm/loongson/lsdc_crtc.c
> index 587fbe285e9ef..b3af8e0cdb15f 100644
> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
> ls7a1000_crtc_funcs =3D {
> =C2=A0	.late_register =3D lsdc_crtc_late_register,
> =C2=A0	.enable_vblank =3D lsdc_crtc_enable_vblank,
> =C2=A0	.disable_vblank =3D lsdc_crtc_disable_vblank,
> -	.get_vblank_timestamp =3D
> drm_crtc_vblank_helper_get_vblank_timestamp,
> =C2=A0	.atomic_print_state =3D lsdc_crtc_atomic_print_state,
> =C2=A0};
> =C2=A0

