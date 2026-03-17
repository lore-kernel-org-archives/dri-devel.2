Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3D4FED9E3
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B3410E580;
	Tue, 17 Mar 2026 15:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="bAee6BV6";
	dkim-atps=neutral
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E3110E580
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=default;
 h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
 To:From:Date:subject:date:message-id:reply-to;
 bh=5ngl+Ap5grElFEXeZgbviZ+lopCVtw5NPZrbz+BiTao=; b=bAee6BV6+Ljm3OyeULkcCpB1fH
 hjElonm6IAMSBovTzjmvaxR5VIUFHDk3xmLoO70Y9Bjwxx161bBjDElNLgdwKnRFrq9/8CAgEkt1S
 B1WKtI3G3Dk7gjiRPmrTvxkV8ok6RXo0ThNljsYkiDfgUln7EFPs94xYSZt/Wxv1Ypxg=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]
 helo=debian-lenovo) by mail.hugovil.com with esmtpa (Exim 4.98.2)
 (envelope-from <hugo@hugovil.com>) id 1w2WE1-000000002HH-0IVP;
 Tue, 17 Mar 2026 11:20:53 -0400
Date: Tue, 17 Mar 2026 11:20:52 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: biju.das.au <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Chris Brandt
 <Chris.Brandt@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/2] drm: renesas: rzg2l_mipi_dsi: Fix the power-on
 sequence
Message-Id: <20260317112052.3dc4b56b42b906381df80e94@hugovil.com>
In-Reply-To: <TY3PR01MB113462F9E8CEA0506984299768641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
 <20260317123610.329630-3-biju.das.jz@bp.renesas.com>
 <20260317110112.338259354289bb60a57fc259@hugovil.com>
 <TY3PR01MB113462F9E8CEA0506984299768641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --
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

Hi Biju,

On Tue, 17 Mar 2026 15:13:07 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Hugo,
> 
> Thanks for the feedback.
> 
> > -----Original Message-----
> > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Hugo Villeneuve
> > Sent: 17 March 2026 15:01
> > Subject: Re: [PATCH 2/2] drm: renesas: rzg2l_mipi_dsi: Fix the power-on sequence
> > 
> > Hi Biju,
> > 
> > On Tue, 17 Mar 2026 12:36:01 +0000
> > Biju <biju.das.au@gmail.com> wrote:
> > 
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Move reset_control_deassert() and reset_control_assert() from
> > > rzg2l_mipi_dsi_dphy_init()/rzg2l_mipi_dsi_dphy_exit() to
> > > atomic_pre_enable() and atomic_post_disable() respectively, and move
> > > rzg2l_mipi_dsi_set_display_timing() from atomic_pre_enable() to
> > > atomic_enable(), to align with the power-on sequence described in
> > > Figure 34.5 of section "34.4.2.1 Reset" of the RZ/G2L hardware manual
> > > Rev.1.50 May 2025.
> > >
> > > According to the hardware manual, LINK registers must be written
> > > before deasserting CMN_RSTB, and the 1ms delay is retained in
> > > atomic_pre_enable() after the deassert.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > 
> > Seems to me like this should be backported to stable branches (missing Fixes / Cc: stable tags)?
> 
> OK, will add fixes/stable tags.
> 
> > 
> > 
> > > ---
> > >  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 27 +++++++++++--------
> > >  1 file changed, 16 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > > b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > > index e53b48e4de56..9053ce037b75 100644
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > > @@ -484,7 +484,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
> > >  	u32 dphytim1;
> > >  	u32 dphytim2;
> > >  	u32 dphytim3;
> > > -	int ret;
> > >
> > >  	/* All DSI global operation timings are set with recommended setting */
> > >  	for (i = 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) { @@
> > > -524,12 +523,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
> > >  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM2, dphytim2);
> > >  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM3, dphytim3);
> > >
> > > -	ret = reset_control_deassert(dsi->rstc);
> > > -	if (ret < 0)
> > > -		return ret;
> > > -
> > > -	fsleep(1000);
> > > -
> > >  	return 0;
> > >  }
> > >
> > > @@ -541,8 +534,6 @@ static void rzg2l_mipi_dsi_dphy_exit(struct
> > > rzg2l_mipi_dsi *dsi)
> > >
> > >  	dphyctrl0 &= ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
> > >  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
> > > -
> > > -	reset_control_assert(dsi->rstc);
> > >  }
> > >
> > >  static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned
> > > long mode_freq, @@ -1030,24 +1021,37 @@ static void rzg2l_mipi_dsi_atomic_pre_enable(struct
> > drm_bridge *bridge,
> > >  	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> > >  	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
> > >  	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
> > > -
> > 
> > This is not related to your commit message (coding style change).
> 
> Ack. Will restore it.
> 
> > 
> > 
> > >  	ret = rzg2l_mipi_dsi_startup(dsi, mode);
> > >  	if (ret < 0)
> > >  		return;
> > >
> > > -	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
> > > +	ret = reset_control_deassert(dsi->rstc);
> > > +	if (ret < 0)
> > > +		return;
> > > +
> > > +	if (dsi->rstc)
> > 
> > This seems new and not documented in the commit message? Is this a fix?
> 
> RZ/V2H does not need this as it uses different IP. Previously fsleep() is in
> RZ/G2L specific function. I will update commit description for this change.

Suggestion: maybe move this to a separate patch, to facilitate review/understanding...


> Cheers,
> Biju
> 
> > 
> > 
> > > +		fsleep(1000);
> > >  }
> > >
> > >  static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
> > >  					 struct drm_atomic_state *state)  {
> > >  	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
> > > +	const struct drm_display_mode *mode;
> > > +	struct drm_connector *connector;
> > > +	struct drm_crtc *crtc;
> > >  	int ret;
> > >
> > >  	ret = rzg2l_mipi_dsi_start_hs_clock(dsi);
> > >  	if (ret < 0)
> > >  		goto err_stop;
> > >
> > > +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> > > +	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
> > > +	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
> > > +
> > > +	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
> > > +
> > >  	ret = rzg2l_mipi_dsi_start_video(dsi);
> > >  	if (ret < 0)
> > >  		goto err_stop_clock;
> > > @@ -1074,6 +1078,7 @@ static void
> > > rzg2l_mipi_dsi_atomic_post_disable(struct drm_bridge *bridge,  {
> > >  	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
> > >
> > > +	reset_control_assert(dsi->rstc);
> > >  	rzg2l_mipi_dsi_stop(dsi);
> > >  }
> > >
> > > --
> > > 2.43.0
> > >
> > >
> > 
> > 
> > --
> > Hugo Villeneuve <hugo@hugovil.com>
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
