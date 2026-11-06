Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF6606A32E
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ilp7Tjoy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7437F10EB74;
	Sat,  7 Nov 2026 14:28:22 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4AE10E49E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 11:21:18 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so4720715e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793964077; x=1794568877;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YbS7SiekKOpCPQzFzLejVy7uNAuDQrZb4aNVnuN+e7A=;
 b=Ilp7TjoyjXab+AJN8ZLZY7ZLOIP08avQBmx6Yo5MLrvw+BAcfgm+2Q9egBbOoM0vra
 a+SlnLckc8Dd7egqzOf1I1Xigyy/SDlwcJLtN3NnpqNg32pvpMirwfuijYWkf2EhRX10
 SorqRH0NXb6NumNyvSpQzruR8ehXQLiETRcKVhl14uUVjd1b10p98jqNeT5pWYjyfHm+
 0+TapZzSkrdANE5fRfF6nXr9dwwP3OTCQjLlZR8kuJ5nmNP2MBCgfN5yY34+t2/3YsHB
 M4c5kofN3vs+zNJsDbXcyRZpCX9aoXNh5xVUwTiOEhyDVBzZxMMZYPir5+bimjCzTw4l
 7+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964077; x=1794568877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YbS7SiekKOpCPQzFzLejVy7uNAuDQrZb4aNVnuN+e7A=;
 b=taoWe0LM3Q6wpRtaViTg3QHl3bizsSM9xkgTnugP/cOM/9tNuAoRTO40+LF5gGMAfa
 9Jggd9F7cxA+d18Ar01ffj8P7DN8AFv0sMsfITagtgTv9+XNfnnGmI2fwVFKJMXwuNCY
 EEW/nUERoTZDm+kvdmKFwHoTH1l09NTilZdEphMQyNDzShOKcxIZ1GKyk+7wyRfiQG3D
 gjDCmPFFy7ed9p0T4gr2oeoqWcWdnTyPy5BSg42wX1/v7kF86vLmIn3CwlgzoK1AcqAU
 4CAe8tYPpMnYOjlhThYHiYYs1ld4tOyzJPBZ1kNEvWDMUiC40X7WFhcwkGgCG0jpMW6U
 hHYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxinB4LQ4Aft9apOEFo40nXGaJs1Q8ZW4ZJjIlj56LfKBYUXMEVRMiZxESkW1efFT3xEd7hFZhe+UI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+mjm9+MbVnLSlEkF5Yfo+IKXq1jp4w8rypDVEcNyYuk9QeWEj+
 vh3J/IOL9FF3yZZq9QgLkl5D1oGh81303RgnmXGl5rG1Hs9qGJ2ZPto+EL8JxsTZqI8=
X-Gm-Gg: AYBFou3en4lxMYdlS4qcDgi9T5QBgIH/RMvmOpkhDkN0AjKOusCWeY4q3k8cNjCS6lb
 dAJLQVHwh8j3Hqda2/1kfZ5GrJ2RsA5DVVPaivrxCpSsNC7Q45hxiBKUtH+l3ADsSrNFDOWZdLi
 TpGPkzsMtydgI6R6QUAtaXaUWASdJK0jYcnl8CrHDF8saq9kAgQueqnqFd3NUagpNygG18eJze4
 +mqoGfO9nZS8UeYMZPDbRnJCCQbq2KzOucv72TZMGUAAo7W3u9E7XQGc36Huz0FTZqGIQL3m5kK
 on6qOOUzhnSRURx4Iews0dBgokoVg8ixj2uaeOBgzv/i8UfvCR6/86VJHkxlBTHdBhU8buPevKX
 HK7ffbjOueOC1XabsqOvKbDgDgIMMRBsDrzqyFkq1E8Nqp9SZ6keFLJFxvaJ4vWPiD95XsQGUOf
 xlZNS/wq9U/LpFd/fQKzBd4JeZDuz6B//wab7hE+PCyYPFa/3dKnqWD07xl5jE7rFt9nVQc6/5C
 XUqe2eTKZEyQkOES1FwEfQ3xF3zuE8Ioiw5kwOgbgbCXC+AZ58Q55tqSuZah4onYxJCWd5pPIlO
 SsdTJ8QFOtAnu5SJqpgqENa5/Phbri5nJhcv9sdToPzKH903mymMxecgaMhloGI=
X-Received: by 2002:a05:600c:a013:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4b6e091ed5amr31326985e9.16.1793964077287; 
 Fri, 06 Nov 2026 03:21:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5c25:f8d1:d9d7:54c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e2028d9bsm102404695e9.9.2026.11.06.03.21.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 03:21:16 -0800 (PST)
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
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v3 0/5] drm/ingenic: Add the X1600 display controller and the
 HiBy R1 panel
Date: Fri,  6 Nov 2026 12:19:55 +0100
Message-ID: <20261106112000.1612-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
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
ingenic,x1600-dpu with its clock unnamed, and the player draws.

The X1600 has no device tree upstream yet; its support is being posted
one subsystem at a time. The R1's backlight uses the X1600 PWM driver
posted separately, now at v3:
https://lore.kernel.org/r/20261102201325.29507-1-olivier@mgcrea.io

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
 drivers/gpu/drm/ingenic/ingenic-x1600-drm.c   | 744 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-hiby-lg35583.c    | 342 ++++++++
 11 files changed, 1263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
 create mode 100644 drivers/gpu/drm/ingenic/ingenic-x1600-drm.c
 create mode 100644 drivers/gpu/drm/panel/panel-hiby-lg35583.c


base-commit: 41ecf852c07391687beb129e12a231760b5d783f
-- 
2.39.5

