Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA51C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A57F410E570;
	Thu, 23 Jul 2026 09:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="qaLWn5K1";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AC710E570
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:55:46 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 93A361FB1B;
 Thu, 23 Jul 2026 11:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784800545;
 bh=Y3tZ5O24GEXnRTH52xgqivlFmeqGANuaEw/IVeFgWqc=; h=From:To:Subject;
 b=qaLWn5K1d/MISN2NzJx2HXw7bDdBbvecuILtiHNRvSZhyp46mFlAwTbb8Qe+8eGFT
 GLaBdBwmbyw4K3/+6VuHJcjjQUPsR2v5ELfsah4//XT3newYLL96nefSjtF8D4u2NB
 zAwZhIi+vKXGDRdPTeZvg1iPu5prh4Wgd1NHHRS2uG+uNr5g/1XFDhvbOV0hy7TZx9
 vQ889N47V5i/SgaxofkXuUHobVY+odVGxV24t/I3fSEDPm4KaD8u7FH21W8h+dgK2q
 Zp9ONutZFDmFglyB2QKuEntZ9dhcRG13yMzzIZ7pRx85OpCbAFq/hCNSqMJJ5PkoHI
 u4LqSep0mTvWQ==
Date: Thu, 23 Jul 2026 11:55:43 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] drm: mxsfb: Add optional DPI output bus-width
 configuration
Message-ID: <20260723095543.GB180480@francesco-nb>
References: <20260723093813.180089-1-francesco@dolcini.it>
 <20260723093813.180089-3-francesco@dolcini.it>
 <nwemnkwk5sjo5w6yelba5nmdlxgu7pxsalrxjixnrjlhfyceza@tamb54s7iswz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nwemnkwk5sjo5w6yelba5nmdlxgu7pxsalrxjixnrjlhfyceza@tamb54s7iswz>
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

Hello Marco,
thanks for the review

On Thu, Jul 23, 2026 at 11:48:03AM +0200, Marco Felsch wrote:
> On 26-07-23, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > LCDIF programs LCD_DATABUS_WIDTH from the selected media bus format. The
> > format reported by the downstream panel or bridge describes the display
> > input, but it does not describe how the LCDIF data pins are physically
> > wired on the board.
> > 
> > These can differ. For example, a 16-bit LCDIF bus can be connected to a
> > 24-bit display by wiring the available color bits to the corresponding
> > display inputs. In that case, using the display's 24-bit format to
> > configure LCDIF selects the wrong data-bus mode and changes the assignment
> > of color bits on the LCD_DATA pins.
> > 
> > Read the optional bus-width endpoint property from the LCDIF output port
> > and use it to select the media bus format used to configure LCDIF. This
> > allows the LCDIF bus mode to describe the physical interface
> > independently of the downstream display format.
> > 
> > When the optional property is absent, continue using the format reported
> > by the downstream display device, preserving the existing behavior.
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > v2: use the common bus-width property instead of the legacy interface-pix-fmt
> > ---
> >  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 24 ++++++++++++++++++++++++
> >  drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
> >  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 12 ++++++++++++
> >  3 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > index 9b8fbda85d28..0545718a4b65 100644
> > --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > @@ -12,7 +12,10 @@
> >  #include <linux/clk.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/io.h>
> > +#include <linux/media-bus-format.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_graph.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> >  #include <linux/pm_runtime.h>
> > @@ -209,7 +212,10 @@ static int mxsfb_load(struct drm_device *drm,
> >  		      const struct mxsfb_devdata *devdata)
> >  {
> >  	struct platform_device *pdev = to_platform_device(drm->dev);
> > +	struct device_node *np = pdev->dev.of_node;
> >  	struct mxsfb_drm_private *mxsfb;
> > +	struct device_node *ep;
> > +	u32 bus_width = 0;
> 
> With this beeing set to '0' and ...
> 
> >  	int ret;
> >  
> >  	mxsfb = devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);
> > @@ -236,6 +242,24 @@ static int mxsfb_load(struct drm_device *drm,
> >  	if (IS_ERR(mxsfb->clk_disp_axi))
> >  		mxsfb->clk_disp_axi = NULL;
> >  
> > +	ep = of_graph_get_next_endpoint(np, NULL);
> > +	if (ep) {
> > +		of_property_read_u32(ep, "bus-width", &bus_width);
> 
> no bus-width property present, this ...
> 
> > +		of_node_put(ep);
> 
> Furthermore please see
> 20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com
> for a proper error handling.

Not sure if I see the value on doing this. You are just doing the
validation of the DT again in the code. My understanding is that this is
not the way to go.

BTW, I assume you are suggesting something like this, if this is not the
case please let me know

	if (ep) {
		err = of_property_read_u32();
		of_node_put(ep);

		if (err && err != -EINVAL)
			return dev_err_probe(dev, err,
					     "failed to query bus-width\n");
	}

> 
> > +	}
> > +
> > +	switch (bus_width) {
> 
> switch should fail. Therefore I would recommend to set the default to
> 24 (bit) aka no limitation.

I would not do that.

We have an optional property, the DT is validated against the binding
for correctness, we should not validate it again in the code. If the
property is not present or it contains an invalid value it is
just ignored, preserving the existing behavior.

Francesco

