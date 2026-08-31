Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5A2C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A59E10E2E1;
	Mon, 31 Aug 2026 16:09:01 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125AD10E2E1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:08:59 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.96.74])
 by APP-01 (Coremail) with SMTP id qwCowAC3iu4Lp5Vqlfb0Bg--.4195S2;
 Tue, 01 Sep 2026 00:08:45 +0800 (CST)
Message-ID: <c2fb145e17b0a1e03904005b13f83884225cd680.camel@iscas.ac.cn>
Subject: Re: [PATCH v2 08/13] drm/loongson: Move hardware reset to CRTC
 creation
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Huacai Chen <chenhuacai@kernel.org>, 
 Jianmin Lv <lvjianmin@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>, Qianhai
 Wu <wuqianhai@loongson.cn>,  Xi Ruoyao <xry111@xry111.site>
Date: Tue, 01 Sep 2026 00:08:42 +0800
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-8-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-8-4500d49a337f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAC3iu4Lp5Vqlfb0Bg--.4195S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7Aw18Ary7CF4rCFykXwb_yoW5uF15pF
 s3Ar17Krs8ZFn5K39rJa1qka45Ga1Fy347tr4rJ34furyvqr15XF18ZrZrua17WFWxG343
 trnFkrn09F129aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxU2wIDUUUUU
X-Originating-IP: [120.85.96.74]
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

=E5=9C=A8 2026-08-31=E4=B8=80=E7=9A=84 17:34 +0200=EF=BC=8CMaxime Ripard=E5=
=86=99=E9=81=93=EF=BC=9A
> The loongson crtc reset hook performs both atomic state
> initialization
> using __drm_atomic_helper_crtc_reset() and hardware-level register
> writes to reset the CRTC.
>=20
> The hardware reset is not related to atomic state initialization, and
> the reset hook is being converted to atomic_create_state which only
> deals with state allocation. Move the hardware reset to the CRTC
> creation path instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Cc: Jianmin Lv <lvjianmin@loongson.cn>
> Cc: Mingcong Bai <jeffbai@aosc.io>
> Cc: Qianhai Wu <wuqianhai@loongson.cn>
> Cc: Xi Ruoyao <xry111@xry111.site>
> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_crtc.c | 15 ++++++++++-----
> =C2=A01 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
> b/drivers/gpu/drm/loongson/lsdc_crtc.c
> index 16b8f36a4071..7cca574e3b6a 100644
> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> @@ -388,12 +388,10 @@ static const struct lsdc_crtc_hw_ops
> ls7a2000_crtc_hw_ops[2] =3D {
> =C2=A0	},
> =C2=A0};
> =C2=A0
> =C2=A0static void lsdc_crtc_reset(struct drm_crtc *crtc)
> =C2=A0{
> -	struct lsdc_crtc *lcrtc =3D to_lsdc_crtc(crtc);
> -	const struct lsdc_crtc_hw_ops *ops =3D lcrtc->hw_ops;
> =C2=A0	struct lsdc_crtc_state *priv_crtc_state;
> =C2=A0
> =C2=A0	if (crtc->state)
> =C2=A0		crtc->funcs->atomic_destroy_state(crtc, crtc-
> >state);
> =C2=A0
> @@ -401,13 +399,10 @@ static void lsdc_crtc_reset(struct drm_crtc
> *crtc)
> =C2=A0
> =C2=A0	if (!priv_crtc_state)
> =C2=A0		__drm_atomic_helper_crtc_reset(crtc, NULL);
> =C2=A0	else
> =C2=A0		__drm_atomic_helper_crtc_reset(crtc,
> &priv_crtc_state->base);
> -
> -	/* Reset the CRTC hardware, this is required for S3 support
> */
> -	ops->reset(lcrtc);
> =C2=A0}
> =C2=A0
> =C2=A0static void lsdc_crtc_atomic_destroy_state(struct drm_crtc *crtc,
> =C2=A0					=C2=A0=C2=A0 struct drm_crtc_state
> *state)
> =C2=A0{
> @@ -935,18 +930,28 @@ static bool
> lsdc_crtc_get_scanout_position(struct drm_crtc *crtc,
> =C2=A0		*etime =3D ktime_get();
> =C2=A0
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> +static void lsdc_crtc_hw_reset(struct drm_crtc *crtc)
> +{
> +	struct lsdc_crtc *lcrtc =3D to_lsdc_crtc(crtc);
> +
> +	/* Reset the CRTC hardware, this is required for S3 support
> */
> +	if (lcrtc->hw_ops->reset)
> +		lcrtc->hw_ops->reset(lcrtc);
> +}
> +
> =C2=A0static const struct drm_crtc_helper_funcs lsdc_crtc_helper_funcs =
=3D {
> =C2=A0	.mode_valid =3D lsdc_crtc_mode_valid,
> =C2=A0	.mode_set_nofb =3D lsdc_crtc_mode_set_nofb,
> =C2=A0	.atomic_enable =3D lsdc_crtc_atomic_enable,
> =C2=A0	.atomic_disable =3D lsdc_crtc_atomic_disable,
> =C2=A0	.atomic_check =3D lsdc_crtc_helper_atomic_check,
> =C2=A0	.atomic_flush =3D lsdc_crtc_atomic_flush,
> =C2=A0	.get_scanout_position =3D lsdc_crtc_get_scanout_position,
> +	.hw_reset =3D lsdc_crtc_hw_reset,

This seems good but I don't know whether I have a device to test this -
- I don't know whether MIPS-based Loongson devices can do S3 on the
mainline kernel.

Thanks,
Icenowy

> =C2=A0};
> =C2=A0
> =C2=A0int ls7a1000_crtc_init(struct drm_device *ddev,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_crtc *crtc,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_plane *primary,

