Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0181FCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0E310ED7B;
	Thu, 18 Jun 2026 11:52:09 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 364B610F2C9
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 11:52:08 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6A021200320;
 Thu, 18 Jun 2026 13:52:06 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e]
 helo=lupine)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1waBHy-003QhG-0z;
 Thu, 18 Jun 2026 13:52:06 +0200
Received: from pza by lupine with local (Exim 4.98.2)
 (envelope-from <p.zabel@pengutronix.de>) id 1waBHy-0000000096F-0jLY;
 Thu, 18 Jun 2026 13:52:06 +0200
Message-ID: <604a73b122bd5fb7b35fe5bfeb0352bd9fd99046.camel@pengutronix.de>
Subject: Re: [PATCH 2/9] drm/rockchip: vop2: Reset AXI and DCLK to improve
 robustness
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Sandy Huang	
 <hjc@rock-chips.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda	 <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>,  Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman	
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2026 13:52:05 +0200
In-Reply-To: <302d42b0-108e-4936-bc34-49b9194985f1@collabora.com>
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <20260617-dw-hdmi-qp-yuv-v1-2-a665cfd06d7d@collabora.com>
 <7c79f233c863654b0266de4b5ec5a8c72bb17715.camel@pengutronix.de>
 <302d42b0-108e-4936-bc34-49b9194985f1@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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

On Do, 2026-06-18 at 14:46 +0300, Cristian Ciocaltea wrote:
> On 6/18/26 12:39 PM, Philipp Zabel wrote:
> > On Mi, 2026-06-17 at 21:51 +0300, Cristian Ciocaltea wrote:
> > > Assert the AXI reset in the CRTC disable path, and the VP DCLK reset =
in
> > > the enable path.
> > >=20
> > > These resets are intended to leave the hardware in a clean state for =
the
> > > next use, helping recover from exceptions such as IOMMU page faults, =
as
> > > well as to prevent random display output glitches, such as a blank
> > > image, observed when switching modes that also change the color forma=
t,
> > > e.g. from RGB to YUV420 and vice versa.
> > >=20
> > > For now this seems to affect only the RK3588, hence the resets are
> > > optional and will be provided in the device tree for this SoC only.
> > >=20
> > > Co-developed-by: Andy Yan <andy.yan@rock-chips.com>
> > > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > > ---
> > >  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 35 ++++++++++++++++++=
++++++++++
> > >  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  4 ++++
> > >  2 files changed, 39 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/g=
pu/drm/rockchip/rockchip_drm_vop2.c
> > > index 4cce3e336f5b..2833fb49ad81 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/reset.h>
> > >  #include <linux/swab.h>
> > > =20
> > >  #include <drm/drm.h>
> > > @@ -860,6 +861,26 @@ static int vop2_core_clks_prepare_enable(struct =
vop2 *vop2)
> > >  	return ret;
> > >  }
> > > =20
> > > +static void vop2_clk_reset(struct vop2 *vop2, struct reset_control *=
rstc)
> >=20
> > The _clk part of the function name is misleading ...
>=20
> Ack. =20
>=20
> We need to make this clearly distinct from another similarly named functi=
on,
> vop2_crtc_reset(), hence I'd propose:
>=20
> - vop2_reset_assert_deassert()
> - vop2_reset_cycle()
> - vop2_do_reset()
>=20
> Any preference / alternative suggestions?

Or vop2_reset_control_reset(). The three above are equally fine.

regards
Philipp
