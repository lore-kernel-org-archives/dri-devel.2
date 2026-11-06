Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572D606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bq2ecLd/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C1B10EB6D;
	Sat,  7 Nov 2026 14:28:21 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A04A10E90D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:39:47 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-492f563d1c6so222281f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793975985; x=1794580785;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ApDnH3pFxBWP98MgBtsP9HN4PO7e1RUuQTYY+krhQJU=;
 b=Bq2ecLd/KY0zPzlhiez22fvOtatqzpodFTFkd9whAiD9M40IEYYRcXiQyZg6i0C9nY
 foue9xcmEi/QIy3qamWjfHkc4DRsnKH3i85XNy55i2TkjZcl/kOWEWzoDiHPS7Qmfl2v
 fM5PZ1u6vm5f9zvTh+09tgICGhtMIaFzmP190ahhJMqV6zXCkrGLdp/B8ipQyJWg36EP
 GRq6iePpRLOInyxw0dt+265jKtHko+7jZ3BoCXLSoKyvL4HZvz54lGHjrAepoacecPzU
 kVjB7YxB2wes1yy4adaora5j5+GUaDgsHD98sYLd8QrrUmLTf4hXY0/O8oKgjylH3eIn
 ysKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793975985; x=1794580785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ApDnH3pFxBWP98MgBtsP9HN4PO7e1RUuQTYY+krhQJU=;
 b=jyO7SIMCWCjj7ZmPohiiVEvutRT6Ow1PLz/O87UMDNSW+bmv584RytEP1GtlLVtM2U
 ZhgEr2QbkXXrIlRaUkkQHVEwYweuHjcjQm5O4t8FhLseP8azYtu5GXmFkQSC9WWkoWnH
 IA+ByjlopwV5doU7V98ysmqj7Nuzb9UGxLsTCeIUMUNU39cxBneDOLW3QeokGgJ+C/jb
 emvuvYfzsUuGWpuce0U3IrOXhK+z0x+sucxLD0NdjwyJwH3yZIPneNwPZxj5fRGF4xjF
 +f+zVL7X2rw7omdN5s/esR356Aj4uWXYsoBMi13vIPeKiy3IsdCCwvSiKmpwtm3D2Sae
 ff+g==
X-Forwarded-Encrypted: i=1;
 AL+hErG9sUb7w7gMJUZDbVmx5DLIe7XEQ2tmiVU2ODCSc0bCEPWVpOtw50NTNweaDL+O2ke2kDclO82xIzo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/3ZZhw7dU5jkWhw05zzfvxWaT11Yd4/2jQTHxpYttLKaNhKDau
 /d1XpGIRU0HMYcb1WRrnbTmoCYYUN0E35DiFb0emzl07qqNQdRpWOGmpgk4R1bubSSY=
X-Gm-Gg: AYBFou2brKvfn6lmPbI0ExoybbvqIlro4PywvVjbNBG8fdnhTUwsXw+pPUpY0/7lvQv
 869PU8519VncvBzIBout5+UvXo0GrY/SRGoIWdR23ojWhrn5PM3qM+PhC9ogpZ1iI2ZzmusLj6E
 hDesVyHjjhU1JK0ou8iSTD5/wBgSglmTJuR5YhY6zhVVtkEg9PtBzcxeFWBBdbpLnbU8JNl/5Gh
 kkuVfSFVAjn+I/IRQxbDryPd+j7Oatcrx3Oqps7DZqSC5c0Fp2eqENDLGQx/GvD1DcnINMU6Ov7
 RJjdMOGhiVWCyqCKkmjzbpz7IhUiNKqKHdzIahp0MmykBcaDDgL8iNa3ZeCTzHrqjFeiNgd0qAZ
 7PjUyeBo7L1auLv+mjQICLg/ddnI75lB37AoNrrDob9VCna912YG3U2rds3SLWeH5l8065eNY9s
 Jw6iiVuYHcXVKG5V0kq0HW+mfRcFUqIw7tPhRdtura2tg8qz5EsnwvhNru+KVHCEYx4btMwZ5RH
 0T74hRfwMG4YzQPkfMsP3+xSp3yUbHVjZGGrD3q0Je7nomEMienrCNwYY4LhKeiALS7+ZmWETZf
 IIxLq/2/0y/6YnxYIj2Zkh/Ny6IY3iRc54Eacxw1vu6OEJWSvsc4jq6AaN6XJDs=
X-Received: by 2002:a05:6000:1861:b0:493:803e:800f with SMTP id
 ffacd0b85a97d-493803e802cmr1981879f8f.29.1793975985393; 
 Fri, 06 Nov 2026 06:39:45 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:30ce:e69c:9ae:c94a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d6382dsm3633050f8f.19.2026.11.06.06.39.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 06:39:45 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Paul Cercueil <paul@crapouillou.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] drm/ingenic: Add a driver for the X1600 display
 controller
Date: Fri,  6 Nov 2026 15:38:27 +0100
Message-ID: <20261106143827.15926-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <0a2e8ea782fa819a547e0a3075303bd74a7fde72.camel@crapouillou.net>
References: <20261106112000.1612-4-olivier@mgcrea.io>
 <0a2e8ea782fa819a547e0a3075303bd74a7fde72.camel@crapouillou.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Paul,

On Fri, Nov 06, 2026 at 02:34:08PM +0100, Paul Cercueil wrote:
> > +	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
>
> This bothers me a bit, shouldn't it be using 'crtc_state'?

Yes. v4 takes the mode from crtc_state.

> > +	writel(readl(lcd->base + X1600_LCD_ST), lcd->base +
> > X1600_LCD_CLR_ST);
>
> Not fond of the writel(readl()) nesting here.

OK, a local in v4, here and in probe.

> > +	writel(val, lcd->base + X1600_LCD_DISP_COM);
>
> This whole block above looks like out of place. Why not do it in
> x1600_lcd_encoder_atomic_mode_set()?
>
> Bonus point, you wouldn't need the 'bus_flags' and 'color_order' variables.

The controller only takes register writes while its clock runs, and the
clock is off when atomic_mode_set() is called: on a full modeset the
CRTC's atomic_disable() has stopped it, and atomic_enable() starts it
again afterwards. I checked it on the R1: with the clock gated (CLKGR0
bit 23), every register reads 0x80, and a write to TFT_HSYNC is lost,
the register still holds the old value once the clock is back.

So moving the block means starting the clock in atomic_mode_set() too,
or leaving it running while the CRTC is off. I'd rather keep the writes
in atomic_enable(), next to clk_prepare_enable(), and look the bus
format up in the new connector state there, so the two fields go
anyway. Would that work for you?

> > +	if (pixels > X1600_LCD_MAX_PIXELS)
> > +		return MODE_MEM;
>
> The max resolution is 1280x720 so you should check mode->hdisplay / mode-
> >vdisplay individually. Otherwise bogus resolutions like 1920x480 would be
> accepted.

Right for 1920x480, but 720 per side would refuse the R1's own panel,
which is 480x800 in portrait. The manual only says "frame size up to
720p". v4 can bound each side by 1280 and keep the 1280x720 pixel count,
would that do?

> > +		spin_lock(&lcd->drm.event_lock);
>
> spin_lock() can sleep with CONFIG_PREEMPT_RT so it looks wrong in an IRQ
> handler. I *think* you don't need to lock it here anyway, as the spinlock is
> locked in other places using spin_lock_irq().

On PREEMPT_RT the handler doesn't run in hard IRQ context:
force_irqthreads() is always true there, and the IRQ is requested
without IRQF_NO_THREAD, so the handler runs in a thread, where a
spinlock_t is fine (Documentation/locking/locktypes.rst).

And it needs the lock: drm_crtc_send_vblank_event() wants the caller to
hold event_lock, and lcd->event is shared with queue_event() and
atomic_disable(). Their spin_lock_irq() only keeps the handler off the
CPU they run on. armada, omapdrm and malidp take event_lock the same way
in their handlers. So I'd keep it.

> You enable it later in the probe, so you could just use devm_clk_get_enabled()
> here.

Probe only enables it to stop what the boot loader left running, and
disables it again before drm_dev_register(). From then on atomic_enable()
and atomic_disable() gate it. devm_clk_get_enabled() would keep it
running for as long as the driver is bound, display off included.

> I saw a patch from Maxime replacing these - you should be calling
> drm_mode_config_create_initial_state(drm) here (and handle the error).

Will do, it's in drm-misc-next already.

I'll leave v3 a few more days for the drm-misc side before sending v4.

Thanks for the review,
Olivier
