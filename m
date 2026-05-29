Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436AFCD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E9510FCB9;
	Fri, 29 May 2026 10:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dp4wgzC4";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E843D10FCB9
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:31:54 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so9526644b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050714; x=1780655514; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l1VAROYwDh72WAwm7PM11vMet7R/k5gdSS8NOIjTWNg=;
 b=dp4wgzC4QpOZYe4rM3CEi8p58At0vxUf3/nGcjv8f8M2rMnXcaU7tgvvFYm3hOC+2m
 xMoqv6Jol1PHVvzrP43ifQe9lHipGRmmg7UeBLDwCi3FEsmgpTFg/XgyLk+Z0Sb+U/bd
 iJWYdCE1NJwSwkFI19AEXlsoFui93g+q4t5p8Fh2bhcyeRRqOdcgfg5It7/IAXQPnSl/
 biSS/vCkOJkf47OvI460KCnhmyLGPHhz5hIM+OXtOAh4rZtZi3WWF1hMfP2jDzUfFnwl
 giabsXyzZCOUlg3i9dJA9XNLe4diuJ5vMPmVZon4nRiR77ODZJVUN0gl0tl0tPjGak5b
 VQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050714; x=1780655514;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1VAROYwDh72WAwm7PM11vMet7R/k5gdSS8NOIjTWNg=;
 b=fH4KvJ/g5kRJuFxQX0shj31GMnednTojuPVjcHqsm8ZYbZh5i9UmjGuOelKHcdT0KH
 qY4ONTfcZmY4MY+QNSEU0UuATn1F51VwikqkVb0XrWsmMkHQSdqRaVqHkp01sKpjxqop
 Qs8jdJbqiS8yg7IYevYFgTN1x4waNGfatChMSLbhgt1rDjdQbPce9LwmKiujlWC2MHP3
 YXQAT8+s6S6tsOAuNzbDLQf6qIXH2I+zevxuC8r91Mb6qoqri/ybespJt7hbNEazY9Ba
 XPf8eha35edQ/beXHAsLP0pKEesESge7cFKNgqk2E09rxNco5ixdQ0k6C9vVNM9Dv2Ca
 7ruw==
X-Gm-Message-State: AOJu0YzQ0SlvjXYogQ/oREk3K6xZI+8bVXeLXTLjd6XAdzgLUy5SidfX
 E0kSagWMZi+lkkC9hWYCgw45SpZxCxvqsOYeWu0WcvzweHwbF0cLEKmU
X-Gm-Gg: Acq92OFG2gMbldGVrOc3c0OY0rUGhjwwbaFVVOzh+5W2D/Uq1Jp05MlZwMQBfEJLdie
 4IjId0hJKWPLRCRT1x7aDeGCYNU+KZ3iuRBSWwtoHoTpvhTFB+nTkgS0u+3KKrWI9Pv0ktfMqYN
 dJQAGaOreWsjL/nPUsS+rwZPBP+UvDV6cPoAZiBNUdxxWDlQw5G/gzjigI8hd15NH9j+Pd51IAv
 ukcR+1HSdGYZE0vNLj+Q7cPV4fFngRiFOHHzfIFIi2r2SkACD6U6YNOs8EmnZODctcQWZw2Vszn
 Wy4LsrTapyWzuL+PSXvHLQXBFDY+g9LWmZybwPGVThwsmYbdPF5/BXe+NqgKtdKch292UNuHYqg
 wilQdrj+hJcq63emgfkeoN14gy9vUVj07BIefzKjsd3wt1hkyiU4DuRoaCORvyjgEK61wDWHMRv
 Tl6h6yWYzSxW+ClqTEudhGMuN4pmEWZJo55TK+cg3FU8Frv9G3c2zwNRokI0RQ3FGgSGi6KzISQ
 8zNH2MOfcYdBEY7XaAClg==
X-Received: by 2002:a05:6a00:4399:b0:841:e7f6:3dce with SMTP id
 d2e1a72fcca58-84212be20dfmr2503527b3a.18.1780050714380; 
 Fri, 29 May 2026 03:31:54 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214b30711sm1418512b3a.16.2026.05.29.03.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:53 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH v3 0/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Fri, 29 May 2026 18:31:50 +0800
Message-Id: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZrGWoC/03MTQrCMBCG4auUWRtJJj8YV95DXMQ0aQdsK4kEp
 fTupkWhy3eY55shh0Qhw7mZIYVCmaaxhjw04Hs3doFRWxuQo+Gaa3Z3iWmUEb2MxkoL9fOZQqT
 3tnK91e4pv6b02UaLWK9/bzZfBONMoLBacRNViJducPQ4+mmA1RfcGfwZrMYb00brTop7tTfLs
 nwBClaTR8oAAAA=
X-Change-ID: 20260505-bar-523f2c3f6939
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, LiangCheng Wang <zaq14760@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780050713; l=2624;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=NMZMnqDGWWAeGlB49gFdIh93m5miziizBZr+exvXud4=;
 b=eF5ekYB/26eVXjq8fm28Y44E0HCCXZG/+RrwTDVkBQT/bau4kEtOsb/UncLu4DQo9kNHFLEgK
 IR450rxsuPLB3GKopD6D9Fjnqi28jntvs3IVfvovCxMK6VkS283VJrS
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

This patch series adds support for the Mayqueen Pixpaper 4.26
monochrome e-ink display panel, controlled via SPI.

The series includes:
- Device tree binding updates for the Pixpaper 4.26 panel
- A DRM tiny driver implementation for the Pixpaper 4.26 panel
- A MAINTAINERS update for the Pixpaper DRM drivers and binding

The panel supports 800x480 resolution with XRGB8888 framebuffer
input and uses SPI, along with GPIO lines for reset, busy, and
data/command control.

Tested on:
- Raspberry Pi 5 with Linux kernel 7.1.0-rc1

Feedback is welcome.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
Changes in v3:
- Keep Conor's Acked-by on the DT binding patch.
- Avoid passing stack and read-only buffers to spi_write().
- Use le32_to_cpu() when reading XRGB8888 pixels.
- Document the panel RAM X direction used during framebuffer conversion.
- Document why busy-wait timeouts remain warning-only.
- Rename the busy-wait helper to pixpaper_wait_for_panel().
- Drop the forward declaration of pixpaper_xrgb8888_to_bw() by moving its
  definition before its first use.
- Use a fixed display mode with drm_connector_helper_get_modes_fixed().
- Drop the redundant mode_config mode_valid callback; resolution is
  validated only by the CRTC mode_valid callback.
- Use drm_err_once() for errors in userspace-triggered update paths.
- Link to v2: https://lore.kernel.org/r/20260526-bar-v2-0-c66df9a840c4@gmail.com

Changes in v2:
- Explain why pixpaper-426m requires a distinct compatible string despite
  sharing the same SPI and GPIO properties with the existing Pixpaper panel.
- Drop the duplicated pixpaper-426m DT binding example.
- Update the binding description for multiple Pixpaper panels.
- Select DRM_GEM_SHMEM_HELPER instead of DRM_GEM_DMA_HELPER for the
  pixpaper-426m driver.
- Link to v1: https://lore.kernel.org/r/20260506-bar-v1-0-12195406f4ef@gmail.com

---
LiangCheng Wang (2):
      dt-bindings: display: mayqueen,pixpaper: add pixpaper-426m
      drm/tiny: add support for PIXPAPER 4.26 monochrome e-ink panel

 .../bindings/display/mayqueen,pixpaper.yaml        |  13 +-
 MAINTAINERS                                        |   3 +-
 drivers/gpu/drm/tiny/Kconfig                       |  16 +
 drivers/gpu/drm/tiny/Makefile                      |   1 +
 drivers/gpu/drm/tiny/pixpaper-426m.c               | 817 +++++++++++++++++++++
 5 files changed, 844 insertions(+), 6 deletions(-)
---
base-commit: a293ec25d59dd96309058c70df5a4dd0f889a1e4
change-id: 20260505-bar-523f2c3f6939

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>

