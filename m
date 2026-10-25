Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141FA606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tHh65fKh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5B210EC88;
	Mon, 26 Oct 2026 08:37:25 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C576B10E182
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 19:16:42 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so2718885e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792955801; x=1793560601;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4nx2+DECqgeu/AGfuDB9I8gflqDb1c6vzu+N1VHtydM=;
 b=tHh65fKh8gLqHvHw2xaFrR2yi2HMMJPMK1pjI/vFSXA6zaVhO5A70LmqFVLSblTVhl
 Fuop2KYfyVKfPoQ3vR3JgwpmxzSP0rnomn1MEABYSsEy7mhjwZoTIzTdUq947hsVzevg
 NNGE0w1w02XssUzakKKX0HnWozDzP4t+SZPCoLG5bkooQDOHFj13yGh3qDmgfHRk0+S1
 p8ityHx+KUTL+XwVKuurnTC951JbHq9tJ3ZGHqRst5twcU00401vIsp2r7FtsKuvGLpx
 nx33mEQDdX7qoqfCrgUiX89ZjxZYRG/tqBa2kMxAk6z/WuRCiasxM5g2qaWdlC34i9SU
 5jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792955801; x=1793560601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4nx2+DECqgeu/AGfuDB9I8gflqDb1c6vzu+N1VHtydM=;
 b=uGAJ3mCiJumwWZibL99w4L+vL2heV26yO+2vh+pxbj1V9joDMCxhdRx9FJIVc4KNsG
 MDxOoXd0lDsCoZFdiS+kOjJEkiHffBxDBe+MruhfCvSptACYLJ20EhGRX/brUsj61Ykz
 7FWzCSs4B46p/ka59J4I8U1RcAqb2YCusDAVA8MHoUjuEkUZLQ3SWB6RBb6nj1iiTkJT
 cWcY13AEu73co0QH6q7XosfM2s4GXmq+fuxnWhF7vkQx3d52EsT/lHOVAK0Es94+HsxR
 0K3FpnThwIaWBsKEYt3BaJsDxWxXeIbUtYCngrm47RyFbvzu2BQcw6GcgKDQeas1z4VR
 9jQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrIWPRxb7vrPJArhmItdD6W0o5BHtzN1tdS9TNnIvJ6jSK06JfKWlIHCIZ5P7uSIhdGF0xHeWK9IE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3cVyOD9lglxyyVLHwtCmRSEtQe81lq/pBMIW1wPAWqC2XZB4p
 qyUjeSs+q0te9xxSq4HF9t+VvxtpNVYUt+X1TPjbngUntjqUR7sXENWVg74VBK0rmG0=
X-Gm-Gg: AYBFou3F628vulkyeIPDbg/e54jYx4x684+bblxwsR2t5x35GwfTYNUyaz8EM3FSYBO
 KBUv5Ze+wvmhEFvQApB0UA21lpirjLlVC85aedYWLYSflWPWhdgaPrU+vbVP1B1ZVuKZbedZtY+
 i4WvaqNWUVql4SQv9YW7NxgI4CChnU7Q6Sm3rkzBYnJJTPAD9hqhjMdVOUybkyyN8YZy7e9cU7s
 gcDWAaYUg/dyHwfSbqWBy0J22sAP2A8PQH9IxRyXP7ilCzGp4wSTeO+iCK52l4loEmJdVVBzRmW
 qEKgHVwaJbFv58WAjh72+1W1XnAfdSEP6+xlE1iD6iQMOr+BqkRzNxuSzBnphUSLvdK3dbezUo6
 pXeE7cL2GrOvkgLM0sQwW+04me23JctUyKEj8TAgx+OK5gxdwzZzbJInICnL4KxqfYH+uxes8vo
 k/hvHDCGNGMAl6pc3S64rk5HjsRpzc6rt2hFL1X2hJrVKflLNBMNtplP+9miU2RgGVzpQaiyQrD
 pUrC/INFNen9qzKrwx2aMqXJBgGQoOA0FgUxF8y4dA3vISGhwBQlL2ZMlzrmDUiGQLI4pp+Yn9+
 PdWFtVLqiCSRuQ==
X-Received: by 2002:a05:600c:4e87:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4a35aca7643mr101451135e9.25.1792955801092; 
 Sun, 25 Oct 2026 12:16:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5822a7sm144560865e9.11.2026.10.25.12.16.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 12:16:40 -0700 (PDT)
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
Subject: [PATCH v2 0/5] drm/ingenic: Add the X1600 LCD controller and the HiBy
 R1 panel
Date: Sun, 25 Oct 2026 20:16:35 +0100
Message-ID: <20261025191640.13592-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
timings in register blocks of their own. It is the X2000's controller
without the composer. This series adds a binding and a driver for it,
then the panel of the HiBy R1, an X1600 audio player: 480x800 parallel
RGB, set up over a 3-wire SPI bus.

The driver covers what the R1 uses and what could be tested: parallel RGB
panels on a 24-bit bus and one full-screen RGB565 plane. The composer,
smart panels and other pixel formats are left out.

Two things come from the vendor kernel rather than the manual. A flip
also writes SRD_CHAIN_START, which the manual doesn't describe for a
running controller; flips without it were not tried. The panel's set-up
sequence is the vendor's too: HiBy calls the panel LG35583, its maker and
controller are unknown, hence the hiby prefix.

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
v2 refuses with -EINVAL, while a full-screen one is still accepted.

The X1600 has no device tree upstream yet; its support is being posted
one subsystem at a time. The R1's backlight uses the X1600 PWM driver
posted separately, now at v2:
https://lore.kernel.org/r/20261025191624.9219-1-olivier@mgcrea.io

v1: https://lore.kernel.org/r/20261025085816.60405-1-olivier@mgcrea.io

Olivier Louvignes (5):
  dt-bindings: vendor-prefixes: Add HiBy
  dt-bindings: display: Add the Ingenic X1600 LCD controller
  drm/ingenic: Add a driver for the X1600 LCD controller
  dt-bindings: display: panel: Add the HiBy LG35583
  drm/panel: Add the HiBy LG35583

 .../bindings/display/ingenic,x1600-lcd.yaml   |  70 ++
 .../bindings/display/panel/hiby,lg35583.yaml  |  71 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  12 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/ingenic/Kconfig               |  22 +
 drivers/gpu/drm/ingenic/Makefile              |   1 +
 drivers/gpu/drm/ingenic/ingenic-x1600-drm.c   | 744 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-hiby-lg35583.c    | 342 ++++++++
 11 files changed, 1276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
 create mode 100644 drivers/gpu/drm/ingenic/ingenic-x1600-drm.c
 create mode 100644 drivers/gpu/drm/panel/panel-hiby-lg35583.c


base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
-- 
2.39.5

