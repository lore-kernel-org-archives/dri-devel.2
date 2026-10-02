Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9670CCA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D6010E332;
	Fri,  2 Oct 2026 07:22:50 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20AD10E332
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:22:49 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-03 (Coremail) with SMTP id rQCowAC3wT_CW79qxa5fCQ--.28708S2;
 Fri, 02 Oct 2026 15:22:43 +0800 (CST)
Message-ID: <fe6bd298fe7560f3aeb566532d2bf3d60d5a5304.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/verisilicon: use ERR_CAST instead of
 ERR_PTR(PTR_ERR())
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Aryan Sinha <sinha.aryan03@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 15:22:42 +0800
In-Reply-To: <20261001163104.51165-1-sinha.aryan03@gmail.com>
References: <20261001163104.51165-1-sinha.aryan03@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAC3wT_CW79qxa5fCQ--.28708S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1xAr4fGr4UJr13tr4ktFb_yoW8AFyrpa
 yjvay0yryrZw47Xr9rAa1qkFy5AasrKwsagr47JwsYvr4vyF1DWFn8Ary5AF98Jay7GrWS
 qF4vkF1FkryI9FUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU89Z23UUUUU==
X-Originating-IP: [112.94.101.54]
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

=E5=9C=A8 2026-10-01=E5=9B=9B=E7=9A=84 22:00 +0530=EF=BC=8CAryan Sinha=E5=
=86=99=E9=81=93=EF=BC=9A
> ERR_CAST says the same thing without the round trip through an error
> code.

Yes, I didn't know this thing yet when I was creating this driver.

```
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

Thanks for this patch!

Icenowy

>=20
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c | 2 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_crtc.c=C2=A0=C2=A0 | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index dc7c85b07..32f9984d8 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -322,7 +322,7 @@ struct vs_bridge *vs_bridge_init(struct
> drm_device *drm_dev,
> =C2=A0	bridge =3D devm_drm_bridge_alloc(drm_dev->dev, struct
> vs_bridge, base,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge_funcs);
> =C2=A0	if (IS_ERR(bridge))
> -		return ERR_PTR(PTR_ERR(bridge));
> +		return ERR_CAST(bridge);
> =C2=A0
> =C2=A0	bridge->crtc =3D crtc;
> =C2=A0	bridge->intf =3D intf;
> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c
> b/drivers/gpu/drm/verisilicon/vs_crtc.c
> index 0b8a35d09..af8e33c96 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> @@ -172,7 +172,7 @@ struct vs_crtc *vs_crtc_init(struct drm_device
> *drm_dev, struct vs_dc *dc,
> =C2=A0	primary =3D vs_primary_plane_init(drm_dev, dc);
> =C2=A0	if (IS_ERR(primary)) {
> =C2=A0		drm_err(drm_dev, "Couldn't create the primary
> plane\n");
> -		return ERR_PTR(PTR_ERR(primary));
> +		return ERR_CAST(primary);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Create our cursor plane */

