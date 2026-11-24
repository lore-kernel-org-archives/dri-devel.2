Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39131606A333
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZZ6e+hPK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA6210F67A;
	Tue, 24 Nov 2026 14:19:18 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E5010F67A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:19:12 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so4343355f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795529951; x=1796134751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dM6V10H2uN2HsH17aDZgwf86TRQA17jV5PgSS9wL+RY=;
 b=ZZ6e+hPKk3y37TJ3M2Orub8uSL1MkykayPTSufk/LGxbfEWH0XVEsnvOkKd1Zlykys
 ed/rJsCLutUhk8rC5UhEJXGApJbtR5Mx+piOI03rpyNb2BPlPrVicCJGvB9+TzQ0Fy4Q
 kIToz0YM4zwZDwdLmo+4oOdS5E+Nq2PUUHzqZkUVv7m1IL2rRGxdtiK9j7ZHcgH8oRj0
 u4jHc757MKyjZO9Z5vVKbK4QSjJPT3NW7egZqqLgx+ML2L7xmCIR4ABlS6c3h5a0gaJw
 4jYWpsQjlPbhDChqr2UrG5kdzgxfA4j+ZuwfFQTC99zZv0BGj/qFlsZrR4XUZCtzC2hy
 8STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529951; x=1796134751;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dM6V10H2uN2HsH17aDZgwf86TRQA17jV5PgSS9wL+RY=;
 b=HAQZoh6Gx0+MRVQ32qiBoGgPaDdBrLxsKzZTdXpjZJ+hvQSBw5RRPWGEYSjJ4lbufG
 kbYvCllidQsFyA4rVA88LUI7KInWw+cADTwIXhAW3l0Wa9pBY57JigYFHbZrOyocx0cZ
 s2I3ci7IlqSiKgzQzOX80Lsbejbe08gyl1dRhhGL6eNQxcxwDx7BqNrEGaO00uGGxp35
 fi0FjSdH37cb/7jiIxqrjo01XrfT1ksNkwB6LaH9dp3voCboGbnN510pl+/Id65IJ2km
 o16zhvRVKxqV8TbtwF1IBWYi/Q5FVyqac9NPhvcj00AC10nRX26rr+k007JP8iWlzdDK
 ISRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGqcKAMeVp9cU7VeUmIgaDIOpyJ2pMCOFqAqG0gaRBiPjMLSbMznuqW5FyOQWLzr0PqHuVauQdWpbM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z88qDf+5eVz5HStbvwbXtKECwQcIqkY2QclJoDpSKaro72jpah5
 tjOiF0ctU73v536coX2lUP3IOSVdo7MZiNVqrqYgkv+SoNiUj6N6PnxYfxT0J4v9
X-Gm-Gg: AZFdTZd9h262RVaU3kplxviX8DDt8PPiCE97f+2mNPluRx9woELuulEw6q+2mjIJDOh
 01Z80e9wdE9bicuXXnGsMA2mteAcsYs5L9bbVnWWQA5ydzj0jmgYaU+jCZbaZCjf09YIZ6eBFyP
 pbX4uWuQ98OAcxAKZhnRqVbSci2p7JHJczsouXC2cZvU51yYKxxu3nD8Ak9kQZe2aTgv22jB4sq
 g3HAgwjWFAcC1jw4RyHeAYaNev6njmUwGcWdx/gvkP/jHdfyJaS6SLGAcWHft0PDSAMw2IZFMCo
 O8ayunwgJ86V1VHbq2IfQfXvJuuHOmYAjvndFdMAFjgssiJmCy1b9EXYkrvr0npDU6zMxaN6EKs
 2S9qpF7H93Zl5zLO/p3XsHvA/G5sJJ0/VQGzGWpglQck9eQu3igHYmCp2dSyRLEu8HZXUnfHNmE
 UihSLm9LWH28NT9SDcqFEC6inowQw1kZeIRmkq0JgVnF8rlK2zqtP11MQkjdZwK8KQwVvnCOsRk
 tu0i22PCnsaJwh+d7x9Ebaf+YBi4yoMjECDrEu5gWY/ELH/05TqE1q89PK07tIqQ7VpWif/YLbx
 dR0l8c/tEBigIDUCMC3EzgBeTlbEqUpSQuB0izRSxfp/gis59XdhQpQj
X-Received: by 2002:a05:6000:184b:b0:48e:5cd4:aa60 with SMTP id
 ffacd0b85a97d-4abb42e9099mr28737909f8f.42.1795529950351; 
 Tue, 24 Nov 2026 06:19:10 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm28994719f8f.3.2026.11.24.06.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:19:09 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/2] drm/tilcdc: Implement state readout
Date: Tue, 24 Nov 2026 15:19:06 +0100
Message-Id: <20261124141908.443764-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This implements hardware state readout for tilcdc, so that the kernel
takes over the display as the bootloader left it and a boot logo stays on
screen, with no blanking or flicker, until userspace replaces it.

It applies on top of Maxime's state readout series v9 and his patch
switching tilcdc to drm_mode_config_create_initial_state(), from the
no-more-config-reset series:

https://lore.kernel.org/r/20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org
https://lore.kernel.org/r/20261116-drm-no-more-config-reset-v2-43-0bb471f4d1e0@kernel.org

Patch 1 is the tilcdc readout itself. Patch 2 keeps panel-simple from
turning the panel off at probe by driving its enable GPIO low.

For the backlight, pwm-tiecap needs a .get_state(), sent separately:

https://lore.kernel.org/r/20261116142251.1296742-1-maximpedraza@gmail.com

Tested on an AM335x board (Fides T075, out-of-tree DT) with U-Boot leaving
an 800x480 RGB565 logo, with no state comparison warning and no WARN or
oops:
- The logo stays on screen, untouched, from U-Boot to userspace.
- First commits from userspace: a framebuffer flip without modeset, a full
  modeset to the panel mode, and ACTIVE=0 then 1 on the adopted
  framebuffer.
- Modesets at 20 pixel clocks between 16.9 and 45 MHz, to check the clock
  read back against the one programmed.
- With drm.atomic_readout=0 the raster stops and the first commit does a
  full modeset.
- Without video set up by U-Boot nothing is adopted.
- The SGX530 driver and a Qt EGLFS application take over from the adopted
  logo without a modeset.

The DT needs a reserved-memory node for the U-Boot framebuffer, and
ti,no-reset-on-init on the GPIO banks and the PWMSS so that ti-sysc doesn't
reset the panel enable and backlight lines. The panel timings must describe
the VSYNC polarity. HSYNC is the odd one: tilcdc_crtc_mode_fixup() flips it,
so a panel needing an active low HSYNC has to leave hsync-active out, as
discussed in v1.

The backlight needs the same care as in v1: with the PWM configured by the
bootloader and the pin muxed to it, the handover is seamless. If the
bootloader drives the backlight some other way, for instance with the pin
as a plain GPIO, the light goes off when the kernel muxes the pin to the
PWM, until the panel is enabled.

Changes in v2:
- Rebase on v9, and drop the bridge install hook and the panel bridge
  readout, now covered by the series.
- Rely on Maxime's patch for drm_mode_config_create_initial_state().
- Round the pixel clock read back to the nearest kHz, and accept a 1%
  pixel clock difference in the CRTC state comparison.
- Pick the adopted framebuffer format from blue-and-red-wiring.
- Keep the DMA address of the adopted framebuffer, so that the CRTC can be
  re-enabled with it.
- Reword the commit message about the sync polarity.
- Link to v1: https://lore.kernel.org/r/20261116142707.1299360-1-maximpedraza@gmail.com

Thanks,
Màxim

Màxim Pedraza Padilla (2):
  drm/tilcdc: Implement state readout support
  drm/panel: simple: Keep the enable GPIO as left by the bootloader

 drivers/gpu/drm/panel/panel-simple.c    |   4 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c    | 207 +++++++++++++++++++++++-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c     |  10 ++
 drivers/gpu/drm/tilcdc/tilcdc_drv.h     |  12 ++
 drivers/gpu/drm/tilcdc/tilcdc_encoder.c |  29 +++-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c   | 127 +++++++++++++++
 6 files changed, 380 insertions(+), 9 deletions(-)


base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
prerequisite-patch-id: 6b275034bd67b4c999266b09c3ea43bb35fed61d
prerequisite-patch-id: 0b49abc230751bbc8235b4f23e5b2f5bc154f807
prerequisite-patch-id: cb32051331d83506b8e6fd512f93595724905a9f
prerequisite-patch-id: 72acc5f5b50b767484ff995256e7fb155c05f6eb
prerequisite-patch-id: f2473524d89ba9ce123a49b043c75d1c83d0e64f
prerequisite-patch-id: 07b90d1294c4bc812bb4d7aa301aacb8e03bab91
prerequisite-patch-id: ceafb1e8145790a933dcbc47bb7d297370e77bdc
prerequisite-patch-id: 1a6e113d6f412d798052a924269a7dc876d91ded
prerequisite-patch-id: 8eacf9b84574fe303134a78ce9c3fcc4ec1c8dbf
prerequisite-patch-id: 3179aab2efd1b77833b2d54a549a71b222f41cc2
prerequisite-patch-id: 70bbeaa10689bf333f87504126edf04acb54095d
prerequisite-patch-id: 0ab25f681f68659f8a0e4f0da80fdf70952dcf8d
prerequisite-patch-id: acb4fc48e98c2dfdaedb38cba8584b45e8f04933
prerequisite-patch-id: 96725d7d0c7e6752e37382ea24b82b8c25156204
prerequisite-patch-id: 7222acb3da2926f0a19d5c062a9fde33daa19b3e
prerequisite-patch-id: deac6b37eea1730f55d118baa518bb6d47ec34d0
prerequisite-patch-id: 7f59656a7dc51a359fe1973f6724a14fbaffb0a4
prerequisite-patch-id: 3459ea8c4e46c2e87bce3a79af06e19bd24c5f0a
prerequisite-patch-id: 338f0ad6e4d90c226c9e4531afdc3dd80ea71a60
prerequisite-patch-id: 2dfe6357a636b3662dbd8db80bc29bd36a0329ad
prerequisite-patch-id: a6261679a50cb9f18f0a47d8f519939e1a414acb
prerequisite-patch-id: ed747bcebd2d6f1ec3ff73f89d116c5e196c75ff
prerequisite-patch-id: 15f0cd9da6c6a6377c8c7ffbaf417d325723df43
prerequisite-patch-id: 1ec019e5f6045c6429377264d1fc456a0054354d
prerequisite-patch-id: 563c77055b805b0d640cd8517627a8c491bce385
prerequisite-patch-id: c15cdbb845bbd252a037d410f806a910c0831917
prerequisite-patch-id: 00948e9d39586344109e9512a7fdee6753f849dd
prerequisite-patch-id: 4fafee08b92675ea8a6f7fb5e27ff5a769325208
prerequisite-patch-id: 6c0369731a723fdef00863dfb1d083ecf4de5d10
prerequisite-patch-id: c2ac26af16bce3d138ec2946ddaa0e57d53b529a
prerequisite-patch-id: 52f7fe449e4812a1aef27bd1182e537002e1f9b4
prerequisite-patch-id: ab15a09bb9e176330cd6f9991e841513315f07dc
prerequisite-patch-id: 402669fd5f97dfc3c3577a104cd8fdb14462cc90
prerequisite-patch-id: e0eb2c02c507fffa786135636227a5cda60f9d3d
prerequisite-patch-id: 631552c07c8ff48b44c65372c44719bf1753253e
prerequisite-patch-id: cbee6a4e6e2b5d0715ef97fad5bcccddb1d097b5
prerequisite-patch-id: 0c8a54b1f9bf053b817e949eb82538e7a0630d01
prerequisite-patch-id: ed873cdcbb8a12ab5ea8b33878dd5112d5e284d5
prerequisite-patch-id: 76b67bf5eab8683095aa758a46efbcb4f0be297b
prerequisite-patch-id: b878fee755a682f5af5f89b74f0ef2cd4eeb9ff8
prerequisite-patch-id: 4de5c8ffb89150dc1475f0ad8eb5ba05102d7022
prerequisite-patch-id: b41f34105087422cbb9386e311033b486a66859d
prerequisite-patch-id: 9e54b77c687ec32b156c2af70d62c2ac24859478
-- 
2.39.5

