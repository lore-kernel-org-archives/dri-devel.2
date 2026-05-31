Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340ACCD6E56
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 10:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FE010E47D;
	Sun, 31 May 2026 10:08:44 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43B710E47D
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 10:08:42 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.239])
 by APP-03 (Coremail) with SMTP id rQCowAAnDOOYCBxqdzgVEw--.24352S2;
 Sun, 31 May 2026 18:08:25 +0800 (CST)
Message-ID: <ebd83509449ce8f4699882c0caf2dd93ffd3f9e6.camel@iscas.ac.cn>
Subject: Re: [PATCH 70/76] drm/verisilicon: Switch to atomic_create_state
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maxime Ripard <mripard@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart	
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
Date: Sun, 31 May 2026 18:08:23 +0800
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-70-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-70-875d828d31bc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAAnDOOYCBxqdzgVEw--.24352S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUWFyfAFy7Jw1xJFWkJFb_yoW5JF18pr
 4qq3yYqr45Xa1DWa9rCw4jqw15Ca90y3y5Gr4ktr92vr13KFZrW3Wvv398uF4UAFW8JF95
 JF17A34jkr4jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU8U5r7UUUUU==
X-Originating-IP: [112.94.101.239]
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

=E5=9C=A8 2026-05-30=E5=85=AD=E7=9A=84 16:00 +0200=EF=BC=8CMaxime Ripard=E5=
=86=99=E9=81=93=EF=BC=9A
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
>=20
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.

Looks good to me.

```
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

Thanks,
Icenowy

>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> ---
> To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Cc: dri-devel@lists.freedesktop.org
> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index 7a93049368db..dc7c85b07fe3 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -244,11 +244,11 @@ static const struct drm_bridge_funcs
> vs_dpi_bridge_funcs =3D {
> =C2=A0	.atomic_disable =3D vs_bridge_atomic_disable,
> =C2=A0	.atomic_get_input_bus_fmts =3D
> drm_atomic_helper_bridge_propagate_bus_fmt,
> =C2=A0	.atomic_get_output_bus_fmts =3D
> vs_bridge_atomic_get_output_bus_fmts_dpi,
> =C2=A0	.atomic_duplicate_state =3D
> drm_atomic_helper_bridge_duplicate_state,
> =C2=A0	.atomic_destroy_state =3D
> drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D
> drm_atomic_helper_bridge_create_state,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct drm_bridge_funcs vs_dp_bridge_funcs =3D {
> =C2=A0	.attach =3D vs_bridge_attach,
> =C2=A0	.atomic_enable =3D vs_bridge_atomic_enable_dp,
> @@ -256,11 +256,11 @@ static const struct drm_bridge_funcs
> vs_dp_bridge_funcs =3D {
> =C2=A0	.atomic_check =3D vs_bridge_atomic_check_dp,
> =C2=A0	.atomic_get_input_bus_fmts =3D
> vs_bridge_atomic_get_input_bus_fmts_dp,
> =C2=A0	.atomic_get_output_bus_fmts =3D
> vs_bridge_atomic_get_output_bus_fmts_dp,
> =C2=A0	.atomic_duplicate_state =3D
> drm_atomic_helper_bridge_duplicate_state,
> =C2=A0	.atomic_destroy_state =3D
> drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D
> drm_atomic_helper_bridge_create_state,
> =C2=A0};
> =C2=A0
> =C2=A0static int vs_bridge_detect_output_interface(struct device_node
> *of_node,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int output)
> =C2=A0{

