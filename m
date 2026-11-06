Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A66606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9505891AA;
	Fri,  6 Nov 2026 15:06:58 +0000 (UTC)
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082E3891AA
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:06:56 +0000 (UTC)
Message-ID: <71aa432f71144f446dba2037ab5664eea3569fdc.camel@crapouillou.net>
Subject: Re: [PATCH v3 3/5] drm/ingenic: Add a driver for the X1600 display
 controller
From: Paul Cercueil <paul@crapouillou.net>
To: Olivier Louvignes <olivier@mgcrea.io>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>, Thomas
 Petazzoni	 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 06 Nov 2026 16:06:50 +0100
In-Reply-To: <20261106143827.15926-1-olivier@mgcrea.io>
References: <20261106112000.1612-4-olivier@mgcrea.io>
 <0a2e8ea782fa819a547e0a3075303bd74a7fde72.camel@crapouillou.net>
 <20261106143827.15926-1-olivier@mgcrea.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le vendredi 06 novembre 2026 =C3=A0 15:38 +0100, Olivier Louvignes a =C3=A9=
crit=C2=A0:
> Hi Paul,
>=20
> On Fri, Nov 06, 2026 at 02:34:08PM +0100, Paul Cercueil wrote:
> > > +	struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
> >=20
> > This bothers me a bit, shouldn't it be using 'crtc_state'?
>=20
> Yes. v4 takes the mode from crtc_state.
>=20
> > > +	writel(readl(lcd->base + X1600_LCD_ST), lcd->base +
> > > X1600_LCD_CLR_ST);
> >=20
> > Not fond of the writel(readl()) nesting here.
>=20
> OK, a local in v4, here and in probe.
>=20
> > > +	writel(val, lcd->base + X1600_LCD_DISP_COM);
> >=20
> > This whole block above looks like out of place. Why not do it in
> > x1600_lcd_encoder_atomic_mode_set()?
> >=20
> > Bonus point, you wouldn't need the 'bus_flags' and 'color_order' variab=
les.
>=20
> The controller only takes register writes while its clock runs, and the
> clock is off when atomic_mode_set() is called: on a full modeset the
> CRTC's atomic_disable() has stopped it, and atomic_enable() starts it
> again afterwards. I checked it on the R1: with the clock gated (CLKGR0
> bit 23), every register reads 0x80, and a write to TFT_HSYNC is lost,
> the register still holds the old value once the clock is back.
>=20
> So moving the block means starting the clock in atomic_mode_set() too,
> or leaving it running while the CRTC is off. I'd rather keep the writes
> in atomic_enable(), next to clk_prepare_enable(), and look the bus
> format up in the new connector state there, so the two fields go
> anyway. Would that work for you?

Is there really a point in enabling the clock on-demand? Why not keep it en=
abled
always? It makes the driver more complex and I don't see a real benefit.

>=20
> > > +	if (pixels > X1600_LCD_MAX_PIXELS)
> > > +		return MODE_MEM;
> >=20
> > The max resolution is 1280x720 so you should check mode->hdisplay / mod=
e-
> > > vdisplay individually. Otherwise bogus resolutions like 1920x480 woul=
d be
> > accepted.
>=20
> Right for 1920x480, but 720 per side would refuse the R1's own panel,
> which is 480x800 in portrait. The manual only says "frame size up to
> 720p". v4 can bound each side by 1280 and keep the 1280x720 pixel count,
> would that do?

Ok. Then I guess keep the current check.

> > > +		spin_lock(&lcd->drm.event_lock);
> >=20
> > spin_lock() can sleep with CONFIG_PREEMPT_RT so it looks wrong in an IR=
Q
> > handler. I *think* you don't need to lock it here anyway, as the spinlo=
ck is
> > locked in other places using spin_lock_irq().
>=20
> On PREEMPT_RT the handler doesn't run in hard IRQ context:
> force_irqthreads() is always true there, and the IRQ is requested
> without IRQF_NO_THREAD, so the handler runs in a thread, where a
> spinlock_t is fine (Documentation/locking/locktypes.rst).
>=20
> And it needs the lock: drm_crtc_send_vblank_event() wants the caller to
> hold event_lock, and lcd->event is shared with queue_event() and
> atomic_disable(). Their spin_lock_irq() only keeps the handler off the
> CPU they run on. armada, omapdrm and malidp take event_lock the same way
> in their handlers. So I'd keep it.

Ok.

> > You enable it later in the probe, so you could just use
> > devm_clk_get_enabled()
> > here.
>=20
> Probe only enables it to stop what the boot loader left running, and
> disables it again before drm_dev_register(). From then on atomic_enable()
> and atomic_disable() gate it. devm_clk_get_enabled() would keep it
> running for as long as the driver is bound, display off included.

Yeah, I forgot that the devm action would cause a clk_disable_unprepare() t=
o be
called on unprobe, which wouldn't work here. So ignore that.

As for the clock running for as long as the driver is bound, I don't think
that's much of a problem.

> > I saw a patch from Maxime replacing these - you should be calling
> > drm_mode_config_create_initial_state(drm) here (and handle the error).
>=20
> Will do, it's in drm-misc-next already.
>=20
> I'll leave v3 a few more days for the drm-misc side before sending v4.

Great.

Cheers,
-Paul
