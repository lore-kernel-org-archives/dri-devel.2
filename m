Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BC606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=jyGZ22fK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7430310EEAF;
	Tue, 10 Nov 2026 08:33:51 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 950CB10E273
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:47:58 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa87so768270f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mgcrea.io; s=google; t=1794246477; x=1794851277; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xT5wwu1nZ1qpjPGd0nNHLklZ2axNl7KOUWGDWBxQnDk=;
 b=jyGZ22fKaoggquDS0oCO3iLV+YujiMmuD3PtxrrnZ0wXLGjuFFgApPL5EIUf5Twoq0
 F75n7AkHEp2YMuEvlJnLQmX3q9pDFhLmZiaxWj+vMXcb7wo/lZ6WSiAbqyyCChCx7ZEZ
 BgLhw/Yfk1PGZ3zt/eZpESDUAZjo9VDT+BR8RBfl1x/Iwzenj51LtIsbyz8yY0he9lDW
 VQDWzgmLNyJUEH7i2XxoT6RNhyQbAUXE9Ujdt2vB+QKJNA1d+LvAtl8LOyVZN3sD7Zh9
 /EljOrWL8gN8XGa5dWXmEy9GYSQ6NUlUS+wtLtfiNDtBOZKqgYBQVzT2Oi+anpFCPWKP
 Nc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794246477; x=1794851277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xT5wwu1nZ1qpjPGd0nNHLklZ2axNl7KOUWGDWBxQnDk=;
 b=P0rqCCKtRsmIAi8VBOoc06u8yq4ydRJ7YMJtTqKQOTn9LW7iAYaKUFylGOQ2uhLKBR
 ljjrnGevoqeTVL/cCSnzkok1s+OaELEzmrg0e0NhWviG4wSnT5W1Lt6S1DszbZ1JnB//
 La9ll09Ad2vZJmgfAQ2kGnSYKr3sSDuoaxc17eCDx8tQL04KmMvkSlnRIQak71qelO05
 qdahop9Uii3M7VQ6BHniYgOuj5VuQgD2KWRVf0gSIClK4e4V9r7jWvjXy9SjlSwsIUIn
 KEUxMiKwV5r3aOhF9vEJFICDRBlrv4ke4V8C06TN/dXLeoHUNjRCznbF0tf3/MwNBhVa
 FShw==
X-Forwarded-Encrypted: i=1;
 AL+hErG9bxQ5kKfAkRwGG5kmpFr4xijnTudrpq7JQBXn94jJOVz1BCj8HW1N8abfVs+YCiGK/GUOUYWrwTg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8zuedmr2GTJcEHSm5gA10FcMYhsqds2GcgkhiE0d1gIUx4jgnU
 YoeNMNMe4qVrnO5+xAM9kGngzfSdw+RihRdJpw0rXcLu+L5/RgHnt4AtWDuQsPMa/BU=
X-Gm-Gg: AYBFou0qRaPILWMN1GJcr/wzx+zGhRtLhrJDxMSW8EVagJAP/9vCcd84iodrQMHW150
 tKQvkEXJfMFGGwXtlanE/D/hXxjWT2OEwXV/IwgiMKxinEy1OpzsfXkOoY60IzIBzVe4DeZiEws
 d3RG9f1e1DVng1btmziocEkO8QxnyRhWTlc/tYVOruDGP5bLW3kmVfenAUnRa+ITeowhOhXLBE0
 M31Ow3HOG2VSApzp5uykpRDcuQWxA3Vfso+MlpCJW8PvOtuU2oSWhAjFKm5cHJ35OPsZ2k8TkXA
 FRWV5/vfPJRZw7mRzOx7csPZH9F4bgvWWiIwtN9FXIvhTGjuzZG43NqLniEeQ4dhr2oACSveJgS
 XIlYUDIJwLposZA+ZWxLcvWvEtSLKUKYYjnCdWbyagFsvmydxtGyytKygeaAvNLt+oEOlUAni60
 wUPmCIeVXRjmftcd8RRfqJ4A+cKLarDeP513hz5wqzHksNfLOQo5xkkIZP8/VBIisYHxZ4sQi+7
 P2cfvbF0gzFPk+EPuPKXAue3F1GWz47vC0j1uzwD65zQoT16Wz78HOpZ0kqAR7gW4/aKXaLCGa3
 ZKf8mPfIbUIfnTxZUmjI4qZ5tepioY0wl90CxOoaAZHqme/TEWtQdVuJqPucvkk=
X-Received: by 2002:a05:6000:2212:b0:488:89c7:31aa with SMTP id
 ffacd0b85a97d-498307c50c2mr300693f8f.39.1794246476845; 
 Mon, 09 Nov 2026 09:47:56 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:e834:fd4d:2ecb:b787])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm167322f8f.53.2026.11.09.09.47.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 09:47:56 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v4 0/5] drm/ingenic: Add the X1600 display controller and the
 HiBy R1 panel
Date: Mon,  9 Nov 2026 18:46:35 +0100
Message-ID: <20261109174640.96951-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The display controller of the Ingenic X1600 is not the one ingenic-drm
drives: it fetches frames through descriptors and keeps its interface and
timings in register blocks of their own. It is the X2000's DPU without
the composer. This series adds a binding and a driver for it, then the
panel of the HiBy R1, an X1600 audio player: 480x800 parallel RGB, set up
over a 3-wire SPI bus.

The driver covers what the R1 uses and what could be tested: parallel RGB
panels on a 24-bit bus and one full-screen RGB565 plane. The composer,
smart panels and other pixel formats are left out.

Two things come from the vendor kernel rather than the manual. A flip
also writes SRD_CHAIN_START, which the manual doesn't describe for a
running controller; flips without it were not tried. The panel's set-up
sequence is the vendor's too: HiBy calls the panel LG35583, its maker and
controller are unknown, hence the hiby prefix.

Changes in v4:
- 3/5: the clock runs from probe to unbind (devm_clk_get_enabled()), as
  in ingenic-drm, instead of being gated with the CRTC (Paul). The
  controller only takes register writes while clocked, so the timings
  and the output format can now be set in the encoder's
  atomic_mode_set(), and the bus_flags and color_order fields go. The
  burst length is set once in probe, and atomic_disable() no longer has
  a failed clock start to handle.
- 3/5: probe brings the clock down to at most a 720p pixel clock right
  after enabling it. After a reset it runs at its parent's rate, 1.4 GHz
  on the R1, and kept that fast until the first modeset the controller
  hung the R1 at every cold start.
- 3/5: atomic_enable() takes the mode from the new CRTC state, there is
  no writel(readl()) nesting, and drm_mode_config_create_initial_state()
  replaces drm_mode_config_reset() (Paul).
- 3/5: mode_valid() still checks the pixel count against 1280x720 rather
  than 720 per side, which would refuse the R1's 480x800 panel (Paul
  agreed).
- 3/5: the file is ingenic-dpu-x1600.c, and the module and driver are
  ingenic-dpu-x1600 (Nikolaus).
- 5/5: unprepare() turns vcc off before vccio, the reverse of prepare()
  (Sashiko).
- Rebased on drm-misc-next.

Changes in v3:
- The compatible is ingenic,x1600-dpu, and the binding and the driver say
  "display controller" rather than "LCD controller" (Nikolaus). The X2000
  and X2600 manuals call this block the DPU, and the X1600 manual does too
  in its register and clock names. There is no generic ingenic,dpu
  fallback, as writing-bindings.rst asks for SoC compatibles: an X2000
  binding can fall back to the X1600's. The driver keeps its file name;
  splitting it for the X2000's composer and interfaces belongs with
  X2000 support.
- 2/5: no $nodename and no clock-names; the driver takes its one clock
  unnamed (Krzysztof). The example's node is display-controller@.
- 2/5: there is no IPU in front of this controller (Krzysztof asked on v2,
  Paul answered): it fetches its own frames, so the output port is its
  only link.
- 4/5: reset-gpios, backlight and port dropped, panel-common has them
  (Krzysztof). The example's endpoint points at the controller's new
  label.
- Krzysztof's Acked-by on 1/5 and Reviewed-by on 4/5.
- Rebased on drm-misc-next after -rc1.

Changes in v2, all in 3/5 and all found by the Sashiko review of v1:
- Commits wait for flip_done instead of a vblank before the planes are
  cleaned up. A flip's event waits until the controller reports reading
  the new descriptor, which can be a frame after the vblank that v1's
  default commit_tail waited for, so the old framebuffer could be freed
  while still scanned out.
- A CRTC being enabled sends its event from atomic_enable(), once the
  controller runs; v1 sent it from atomic_flush(), which runs first.
- A plane that is not visible is rejected: the controller always scans
  out a whole frame, so v1 would have read past the end of a small
  framebuffer placed off-screen.
- atomic_disable() returns early when atomic_enable() failed to start
  the pixel clock, instead of touching an unclocked controller.

Tested on a HiBy R1: the fbdev console and a player drawing through
fbdev, blanking and unblanking, 60 page flips in 0.97 s at about 61 Hz,
and the colour order (RGB order swaps red and blue on this panel). For
v2 also: 120 fbdev pans in 1.95 s (one flip per frame, none timing out),
three blank/unblank cycles, and a 64x64 framebuffer set on the primary
plane just past the right edge through SETPLANE, which v1 accepted and
v2 refuses with -EINVAL, while a full-screen one is still accepted. v3
was run on the R1 with its node changed to match: the driver binds to
ingenic,x1600-dpu with its clock unnamed, and the player draws. For v4:
four blank/unblank cycles with the clock left running and the timing
registers kept, 60 pans in 0.98 s and 120 in 1.97 s with none failing,
an unbind and bind of the driver, which turns the clock off and then
writes the timings again from atomic_mode_set() on the first modeset,
and five cold starts with the kernel loaded into RAM through the boot
ROM's USB mode and started as the boot loader does.

The X1600 has no device tree upstream yet; its support is being posted
one subsystem at a time. The R1's backlight uses the X1600 PWM driver
posted separately, now at v3:
https://lore.kernel.org/r/20261102201325.29507-1-olivier@mgcrea.io

v3: https://lore.kernel.org/r/20261106112000.1612-1-olivier@mgcrea.io
v2: https://lore.kernel.org/r/20261025191640.13592-1-olivier@mgcrea.io
v1: https://lore.kernel.org/r/20261025085816.60405-1-olivier@mgcrea.io

Olivier Louvignes (5):
  dt-bindings: vendor-prefixes: Add HiBy
  dt-bindings: display: Add the Ingenic X1600 display controller
  drm/ingenic: Add a driver for the X1600 display controller
  dt-bindings: display: panel: Add the HiBy LG35583
  drm/panel: Add the HiBy LG35583

 .../bindings/display/ingenic,x1600-dpu.yaml   |  61 ++
 .../bindings/display/panel/hiby,lg35583.yaml  |  67 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  12 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/ingenic/Kconfig               |  22 +
 drivers/gpu/drm/ingenic/Makefile              |   1 +
 drivers/gpu/drm/ingenic/ingenic-dpu-x1600.c   | 739 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-hiby-lg35583.c    | 342 ++++++++
 11 files changed, 1258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
 create mode 100644 drivers/gpu/drm/ingenic/ingenic-dpu-x1600.c
 create mode 100644 drivers/gpu/drm/panel/panel-hiby-lg35583.c


base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
-- 
2.39.5

