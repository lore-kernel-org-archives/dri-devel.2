Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2689CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE0A10E5CD;
	Fri,  8 May 2026 11:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rxOPa2rV";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BE310E5CD
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:23:17 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15272BCA;
 Fri,  8 May 2026 13:23:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778239391;
 bh=BCIW8buEqE5jd6zwfLPqWshQHwruVnljujWd3gOftvw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rxOPa2rVxyMWrzHoMeqqFuvpuqSX3x5Qt9NNkBjO41TQ60+sW1kSBotfz+bBZoMnS
 JEv29K0XrRxrcTwtgI6H/9RblMeMa5wjCEPuN1ZrHwFAX0IrtzhooghME6SiikRXfe
 X0QZTXdod/CS6psXGWfJZtmBgC+99vd3hWkKdxaM=
Date: Fri, 8 May 2026 14:23:14 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/4] drm: renesas: rz-du: Move mode_valid logic to
 per-SoC clock limits
Message-ID: <20260508112314.GF2176058@killaraus.ideasonboard.com>
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506201400.GC1652535@killaraus.ideasonboard.com>
 <CA+V-a8u_74SmeAKAXUqSKyWvp41pJavd_b_ESUOozCnrifBEpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8u_74SmeAKAXUqSKyWvp41pJavd_b_ESUOozCnrifBEpA@mail.gmail.com>
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

On Fri, May 08, 2026 at 11:00:15AM +0100, Lad, Prabhakar wrote:
> On Wed, May 6, 2026 at 9:14 PM Laurent Pinchart wrote:
> > On Wed, Apr 29, 2026 at 06:00:11PM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Move pixel clock validation from a fixed encoder check to per SoC
> > > constraints stored in rzg2l_du_device_info.
> > >
> > > Pixel clock limits differ across SoCs in the RZ DU family and cannot be
> > > expressed by a single shared rule. For example, RZ/G2UL (R9A07G043U)
> > > limits the DPAD0 pixel clock to 83.5 MHz, while other SoCs such as
> > > RZ/T2H require a wider operating range.
> > >
> > > Add mode_clock_min and mode_clock_max fields to rzg2l_du_device_info to
> > > describe the supported pixel clock range for each SoC. Update
> > > rzg2l_du_encoder_mode_valid() to return MODE_CLOCK_LOW when the pixel
> > > clock falls below mode_clock_min and MODE_CLOCK_HIGH when it exceeds
> > > mode_clock_max.
> > >
> > > Set the pixel clock limits for RZ/G2UL(R9A07G043U) to 20.875MHz minimum
> > > and 83.5MHz maximum.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 2 ++
> > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
> > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
> > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h | 2 ++
> > >  4 files changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > index 0fef33a5a089..3b7162c6e1f4 100644
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > @@ -35,6 +35,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g043u_info = {
> > >                       .port = 0,
> > >               },
> > >       },
> > > +     .mode_clock_min = 20875,
> > > +     .mode_clock_max = 83500,
> > >  };
> > >
> > >  static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
> > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > > index 58806c2a8f2b..885558eb9547 100644
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > > @@ -44,10 +44,14 @@ struct rzg2l_du_output_routing {
> > >   * struct rzg2l_du_device_info - DU model-specific information
> > >   * @channels_mask: bit mask of available DU channels
> > >   * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
> > > + * @mode_clock_min: minimum pixel clock in kHz
> > > + * @mode_clock_max: maximum pixel clock in kHz
> > >   */
> > >  struct rzg2l_du_device_info {
> > >       unsigned int channels_mask;
> > >       struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
> > > +     u32 mode_clock_min;
> > > +     u32 mode_clock_max;
> > >  };
> > >
> > >  #define RZG2L_DU_MAX_CRTCS           1
> > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > > index d53068733c66..ad02efec1c23 100644
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > > @@ -50,8 +50,11 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
> > >                           const struct drm_display_mode *mode)
> > >  {
> > >       struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
> > > +     const struct rzg2l_du_device_info *info = renc->info;
> >
> > You could use
> >
> >         struct rzg2l_du_device *rcdu = to_rzg2l_du_device(renc->base.dev);
> >         const struct rzg2l_du_device_info *info = rcdu->info;
> >
> > and avoid the info pointer in struct rzg2l_du_encoder. Up to you.
> 
> Agreed, I will drop the info pointer for now.
> 
> > >
> > > -     if (renc->output == RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)
> > > +     if (info->mode_clock_min && mode->clock < info->mode_clock_min)
> > > +             return MODE_CLOCK_LOW;
> > > +     if (info->mode_clock_max && mode->clock > info->mode_clock_max)
> > >               return MODE_CLOCK_HIGH;
> >
> > The new check now applies to all outputs, not just the DPAD0 output. Is
> > that intentional ?
> 
> The RZ/G2UL SoC only supports DPAD0 so the check is redundant.

Ah right. Please mention that in the commit message.

> > >
> > >       return MODE_OK;
> > > @@ -107,6 +110,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
> > >       if (IS_ERR(renc))
> > >               return PTR_ERR(renc);
> > >
> > > +     renc->info = rcdu->info;
> > >       renc->output = output;
> > >       drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_funcs);
> > >
> > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > > index 3e430c1f6132..39a1d178b856 100644
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > > @@ -14,10 +14,12 @@
> > >  #include <linux/container_of.h>
> > >
> > >  struct rzg2l_du_device;
> > > +struct rzg2l_du_device_info;
> > >
> > >  struct rzg2l_du_encoder {
> > >       struct drm_encoder base;
> > >       enum rzg2l_du_output output;
> > > +     const struct rzg2l_du_device_info *info;
> >
> > If you want to keep a pointer here to avoid going through
> > to_rzg2l_du_device(), I would store a backpointer to rzg2l_du_device
> > instead of just an info pointer, it could come handy in other places.
> 
> As agreed above I will drop this pointer for now.

-- 
Regards,

Laurent Pinchart
