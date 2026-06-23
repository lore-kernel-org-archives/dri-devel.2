Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC644CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F6D10EA8C;
	Tue, 23 Jun 2026 10:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TsbFraGx";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1880110EA8C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 10:41:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 623A64E40761;
 Tue, 23 Jun 2026 10:41:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2CA7A601C2;
 Tue, 23 Jun 2026 10:41:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1C89A106C8442; 
 Tue, 23 Jun 2026 12:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782211305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nW1cfszAg7S4GsG7xpMPmAq99XG9RkOhVx8ssV5Hh5c=;
 b=TsbFraGxXYHV0bJDmyjJ8nWcVEoBmdokwtEcPMViUEQJr3dI8dWjtCRqglpRmCiSQl7eUm
 zXTT9XttBj49SaAJebbKEG88UPnERka2W9CCKKrPvv9WmBgxV6zqujW97fD4hVmiksLmA4
 PNRg5K1B9HIGJTRCeFRs+FKhjJkxh8dP8wBIMSVweGib4+T/FncpYCcKpppU6LiQMGoa8P
 FguDA0RmM2I1ccDbBRKVbYhp/ds5aPgKdQT7g1r77Pt/ve2fynQg8R0/7kutRNYpOvhgB0
 yYocI55vQdENSLFfgwzDfLMiKSKF+qGbdtlAsiEhBuABs3K9zeHmkiIx1roGvw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 12:41:36 +0200
Message-Id: <DJGD6EW5D0FD.V4WHCIICLXQ7@bootlin.com>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3] drm/bridge: imx93-mipi-dsi: Fix mode validation
X-Mailer: aerc 0.21.0
References: <20260515-imx93-mipi-dsi-fix-mode-validation-v3-1-91f7d22b2fe4@nxp.com>
 <DJD6I8NMLN3W.3LVT4L17HT5TU@bootlin.com> <ajjpuroFPI_U2Fw6@raspi>
In-Reply-To: <ajjpuroFPI_U2Fw6@raspi>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Liu,

On Mon Jun 22, 2026 at 9:52 AM CEST, Liu Ying wrote:
> On Fri, Jun 19, 2026 at 06:49:55PM +0200, Luca Ceresoli wrote:
>> Hello Liu,
>
> Hi Luca,
>
>>
>> On Fri May 15, 2026 at 8:54 AM CEST, Liu Ying wrote:
>> > i.MX93 MIPI DPHY PLL has limitation for matching with some pixel clock
>> > rates, e.g., the best DPHY PLL frequency is 445.333333MHz for a typica=
l
>> > 1920x1080p@60Hz CEA/DMT display mode with a pixel clock rate running
>> > at 148.5MHz with 4 data lanes + RGB888 pixel in MIPI DSI sync pulse mo=
de,
>> > while the expected PLL frequency is (148.5 * 24) / 4 / 2 MHz =3D 445.5=
MHz.
>> > Fortunately, VESA Display Monitor Timing Standard allows +/-0.5% pixel
>> > clock rate deviation for timings.  So, for those display modes read
>> > from EDID through a bridge with DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP=
_EDID
>> > operation bit masks set, pixel clock rate could be adjusted to match
>> > with the PLL frequency(for the above example, the pixel clock rate is
>> > adjusted to be 148.444444MHz with about -0.03% deviation from the 148.=
5MHz
>> > nominal rate so that the adjusted rate matches with the 445.333333MHz =
PLL
>> > frequency).
>> >
>> > Instead of checking the last bridge's operation bit masks against
>> > DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID to determine if allowing
>> > +/-0.5% pixel clock rate deviation, check any bridge after this bridge=
,
>> > because the last bridge is usually a display connector bridge without
>> > any operation bit mask when the clock rate deviation is allowed.
>> >
>> > Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
>> > Fixes: 5849eff7f067 ("drm/bridge: imx93-mipi-dsi: use drm_bridge_chain=
_get_last_bridge()")
>> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>
>> I'm perhaps not the most qualified to review this change, but let me try=
.
>
> Thanks for your review.
>
>>
>> > --- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
>> > +++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
>> > @@ -489,25 +489,43 @@ static int imx93_dsi_get_phy_configure_opts(stru=
ct imx93_dsi *dsi,
>> >  	return 0;
>> >  }
>> >
>> > +static inline struct drm_bridge *
>> > +imx93_dsi_get_next_bridge_in_chain(struct drm_bridge *bridge)
>> > +{
>> > +	struct drm_bridge *next =3D drm_bridge_get_next_bridge(bridge);
>> > +
>> > +	drm_bridge_put(bridge);
>> > +
>> > +	return next;
>> > +}
>> > +
>> >  static enum drm_mode_status
>> >  imx93_dsi_validate_mode(struct imx93_dsi *dsi, const struct drm_displ=
ay_mode *mode)
>> >  {
>> >  	struct drm_bridge *dmd_bridge =3D dw_mipi_dsi_get_bridge(dsi->dmd);
>> > -	struct drm_bridge *last_bridge __free(drm_bridge_put) =3D
>> > -		drm_bridge_chain_get_last_bridge(dmd_bridge->encoder);
>> > +	struct drm_bridge *bridge;
>> >
>> > -	if ((last_bridge->ops & DRM_BRIDGE_OP_DETECT) &&
>> > -	    (last_bridge->ops & DRM_BRIDGE_OP_EDID)) {
>> > -		unsigned long pixel_clock_rate =3D mode->clock * 1000;
>> > -		unsigned long rounded_rate;
>> > +	for (bridge =3D drm_bridge_get_next_bridge(dmd_bridge);
>> > +	     bridge;
>> > +	     bridge =3D imx93_dsi_get_next_bridge_in_chain(bridge)) {
>> > +		if ((bridge->ops & DRM_BRIDGE_OP_DETECT) &&
>> > +		    (bridge->ops & DRM_BRIDGE_OP_EDID)) {
>> > +			unsigned long pixel_clock_rate =3D mode->clock * 1000;
>> > +			unsigned long rounded_rate;
>> >
>> > -		/* Allow +/-0.5% pixel clock rate deviation */
>> > -		rounded_rate =3D clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
>> > -		if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
>> > -		    rounded_rate > pixel_clock_rate * 1005 / 1000) {
>> > -			dev_dbg(dsi->dev, "failed to round clock for mode " DRM_MODE_FMT "=
\n",
>> > -				DRM_MODE_ARG(mode));
>> > -			return MODE_NOCLOCK;
>> > +			/* Allow +/-0.5% pixel clock rate deviation */
>> > +			rounded_rate =3D clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
>> > +			if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
>> > +			    rounded_rate > pixel_clock_rate * 1005 / 1000) {
>> > +				dev_dbg(dsi->dev,
>> > +					"failed to round clock for mode " DRM_MODE_FMT "\n",
>> > +					DRM_MODE_ARG(mode));
>> > +				drm_bridge_put(bridge);
>> > +				return MODE_NOCLOCK;
>> > +			}
>> > +
>> > +			drm_bridge_put(bridge);
>> > +			break;
>> >  		}
>> >  	}
>>
>> Is this logic specific to the imx93 MIPI DSI host only? Or should it be
>> made generic for all dw-hdmi users, or even every DSI host?
>
> I think it's kind of specific to the i.MX93 MIPI DSI host only, because
> 1) the i.MX93 MIPI DPHY PLL(integrated into i.MX93 MIPI DPHY IP) supports
> the best DPHY PLL frequency @445.333333MHz for the typical 1920x1080p@60H=
z
> display mode, which is lower than the expected/nominal frequency @445.5MH=
z
> and 2) the generic DW MIPI DSI driver(dw-mipi-dsi.c) is PHY-agnostic, whi=
ch
> means vendors may attach different MIPI DPHY IPs to the common MIPI DSI h=
ost
> IP and likely there would be no frequency mismatch between the pixel cloc=
k
> and the PLL like i.MX93 has.

I see, OK, thanks for the clarification!

>> Also, iterating over the bridge chain is not very clean. I'm working on
>> bridge hotplug (not upstream yet) and bad things would happen if a bridg=
e
>> were hot-unplugged during this loop.
>
> The iterating is essentially the same to drm_for_each_bridge_in_chain_fro=
m()
> except that bridge_chain_mutex is not taken(since it's already taken) and
> the starting bridge is fixed to be the next bridge.  A few bridge core AP=
Is
> like drm_bridge_chain_mode_valid() call drm_for_each_bridge_in_chain_from=
().
> So, the iterating looks clean to me and I'm not aware of any bad things w=
hich
> would happen when bridge hotplug is considered.

I had missed this is called from drm_bridge_chain_mode_valid(), which
already takes the bridge_chain_mutex thanks to
drm_for_each_bridge_in_chain_from().

So that means this loop is safe, but it would be nice to add a comment to
make it clear to future readers. E.g. "/* we are called by
drm_bridge_chain_mode_valid(), so the bridge_chain_mutex is locked */".

Still I'm not a fan of having a loop over the bridge chain (this function)
inside another loop over the same bridge chain (in
drm_bridge_chain_mode_valid(). And even more I'm not a fan of drivers
walking around the bridge chain on their own, IMO the core (perhaps
drm_bridge.c in this case) should to the loops . However this is a general
concern, it happens also elsewhere, and I have no immediate proposal to
improve this, so don't consider it as a blocker for this patch.

>> If the core did this sort of algorithm
>> it would be able to be more robust.
>
> Is the core dw-mipi-dsi.c?
> If yes, do you think it's worth doing that even if the frequency mismatch
> between the pixel clock and the PLL is kind of specific to the i.MX93 MIP=
I
> DSI host?
>
>>
>> Finally, out of my utter ignorance on the subject, is the VESA +/-0.5%
>> margin generic enough that this driver can always rely on it?
>
> I see several upstream drivers rely on it, see "git grep '0.5%' drivers/g=
pu/"
> output.  And every display mode allows -/+ 0.5% pixel clock rate deviatio=
n
> according to VESA Display Monitor Timing Standard [1], though [1] is a fo=
und
> by a random Google search.
>
> [1] https://glenwing.github.io/docs/VESA-DMT-1.13.pdf

As I said I'm quite ignorance about this aspect, so I asked to better
understand. In reply to another part fo the thread: no, I don't have a
specific concern if this is the common practice.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
