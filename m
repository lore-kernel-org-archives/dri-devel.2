Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856C0C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D745B10EF0F;
	Tue, 29 Sep 2026 14:42:37 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 772B710EF0F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:42:36 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowAC3IDtEzrtqWCqvCQ--.41306S2;
 Tue, 29 Sep 2026 22:42:15 +0800 (CST)
Message-ID: <e044caae8c2160d96a29073bb1e60efff5883513.camel@iscas.ac.cn>
Subject: Re: [PATCH v2 2/7] drm: verisilicon: stop using deprecated
 devm_drm_of_get_bridge()
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li	 <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda	
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman	 <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Dave Stevenson	
 <dave.stevenson@raspberrypi.com>, =?ISO-8859-1?Q?Ma=EDra?= Canal	
 <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance	
 <kernel-list@raspberrypi.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@kernel.org>, Doug Anderson <dianders@chromium.org>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni	 <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, 	imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, kernel test robot <lkp@intel.com>
Date: Tue, 29 Sep 2026 22:42:12 +0800
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v2-2-6da431d8f180@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v2-2-6da431d8f180@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowAC3IDtEzrtqWCqvCQ--.41306S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry7Jr15Kw43Cw1DZFWkZwb_yoWrJF1rpF
 40qa98try5XrWxXw42kr4j9FyYya4Dtw4rGFWUt34Fvr1FqF4DGF1kAry5Z3W5CF17GF1r
 tr4DtFySv3W8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxUv4EEDUUUU
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

=E5=9C=A8 2026-09-29=E4=BA=8C=E7=9A=84 15:39 +0200=EF=BC=8CLuca Ceresoli=E5=
=86=99=E9=81=93=EF=BC=9A
> devm_drm_of_get_bridge() is deprecated, switch to
> of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint()
> returns
> a refcounted bridge, ensure it is put by using bridge.next_bridge.
>=20
> Fixes build failure when CONFIG_OF is disabled.
>=20
> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to
> drm_panel.c")
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Closes:
> https://lore.kernel.org/r/20260928161605.2271412-1-arnd@kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202609291109.OIsGTysr-lkp@intel.com=
/
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202609290408.BOs7sk55-lkp@intel.com=
/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Checked the code in drm_bridge.c, and it looks like the lifetime of
next_bridge should be indirectly managed by devm when
devm_drm_bridge_alloc() successes and the next_bridge field assigned,
so the only explicit put needed here should be in the alloc failure
path.

Patch is:

```
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

>=20
> ---
>=20
> Changes in v2:
> - fix bridge reference leak on attach error path

It should be `bridge alloc error` instead of `attach error`, but I
don't know how to correct the error in the changelog, and anyway it
won't be part of the final commit.

Thanks,
Icenowy

> - mention lkp report
> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c | 11 ++++++-----
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.h |=C2=A0 1 -
> =C2=A02 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index dc7c85b07fe3..3a5091c0ac2c 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -29,7 +29,7 @@ static int vs_bridge_attach(struct drm_bridge
> *bridge,
> =C2=A0{
> =C2=A0	struct vs_bridge *vbridge =3D drm_bridge_to_vs_bridge(bridge);
> =C2=A0
> -	return drm_bridge_attach(encoder, vbridge->next_bridge,
> +	return drm_bridge_attach(encoder, vbridge->base.next_bridge,
> =C2=A0				 bridge, flags);
> =C2=A0}
> =C2=A0
> @@ -303,8 +303,7 @@ struct vs_bridge *vs_bridge_init(struct
> drm_device *drm_dev,
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> -	next =3D devm_drm_of_get_bridge(drm_dev->dev, drm_dev->dev-
> >of_node,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output, intf);
> +	next =3D of_drm_get_bridge_by_endpoint(drm_dev->dev->of_node,
> output, intf);
> =C2=A0	if (IS_ERR(next)) {
> =C2=A0		ret =3D PTR_ERR(next);
> =C2=A0		if (ret !=3D -EPROBE_DEFER)
> @@ -321,12 +320,14 @@ struct vs_bridge *vs_bridge_init(struct
> drm_device *drm_dev,
> =C2=A0
> =C2=A0	bridge =3D devm_drm_bridge_alloc(drm_dev->dev, struct
> vs_bridge, base,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge_funcs);
> -	if (IS_ERR(bridge))
> +	if (IS_ERR(bridge)) {
> +		drm_bridge_put(next);
> =C2=A0		return ERR_PTR(PTR_ERR(bridge));
> +	}
> =C2=A0
> =C2=A0	bridge->crtc =3D crtc;
> =C2=A0	bridge->intf =3D intf;
> -	bridge->next_bridge =3D next;
> +	bridge->base.next_bridge =3D next;
> =C2=A0
> =C2=A0	if (intf =3D=3D VSDC_OUTPUT_INTERFACE_DPI)
> =C2=A0		enctype =3D DRM_MODE_ENCODER_DPI;
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.h
> b/drivers/gpu/drm/verisilicon/vs_bridge.h
> index 70fee1749699..2b0ed94e4520 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.h
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.h
> @@ -25,7 +25,6 @@ struct vs_bridge {
> =C2=A0	struct drm_connector *conn;
> =C2=A0
> =C2=A0	struct vs_crtc *crtc;
> -	struct drm_bridge *next_bridge;
> =C2=A0	enum vs_bridge_output_interface intf;
> =C2=A0};
> =C2=A0

