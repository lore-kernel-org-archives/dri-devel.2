Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B37C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B011B10E582;
	Mon, 24 Aug 2026 19:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mX5zDEzW";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846DC10E57F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 19:54:33 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso6688810a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787601272; x=1788206072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ClvPQwmI5ogELhuUGgFzTR1/DyqJ1MIgEVXTTEXX9Z4=;
 b=mX5zDEzWEq9HJgv88C6Eb5F2JJ+JdGXYpEus5rw9MIGOMWQo8Dus0h7Pgg5sZAOzOd
 UcDyOWS28hRbqxlJjO1wcpopGL5Efs031xQLrhsxx6CBdOEMz0gNCOZWsO4dbNBLzz8w
 1+7hIJl0yZ+7XLPXrBn4BgTEc7MCD3XdI7PD7IfPyYZhP5TaFRKkHblbo0EMchOH9QL3
 85P2TMwW2PRGuJnlk2MLnGMoxJ/VIgaqVcb0eeM35HDe08oUQUfmi2BMRD7oIZYqcwSu
 zKv2mBzqEUf82kKLY/adK0K5yyfJmRaPhGWjnYT3xQLn1jtdLiTsKfaA8am+fktdG4Ey
 aDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601272; x=1788206072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ClvPQwmI5ogELhuUGgFzTR1/DyqJ1MIgEVXTTEXX9Z4=;
 b=CkLeuA1juUHct3rWEO5gi0aavY1VRk1r03Ln8iziqNBpjszeujKH7faW/WA2OLzRH+
 V2n6RJGJUlBLxZEByWYgF5Y6BcdgbDypzqSPf9i7oiBBTMCgDRLXKt4nTg+w/EZ/Oz19
 PJ26TTu8P165DOyx6yjsmSddMWdVaJeGveLleTOpS862V+zQSfsQtENN/hAyUo1fmKLX
 qeuH6NlOSr1J6dBy6OiLb//VcJyvWCvHSNlNmKbNpIVn8IgCjKV1N2lRfu0V3bHKN/lm
 o8SLL0Pvph+e/P3ixd56Gx56Tc3Ks9eKzXxN7gDGwkycBtOrDgebzBI5tvqZ27bcBD96
 w2bA==
X-Gm-Message-State: AFuF++nZP6Mhvfm4w3V3j60uGo9z+HW3ZnncC1b+Cq/ZcCw05NWiltic
 nOkKisqfuQnOY9G1sn8gfCEzNfbrWQOHYKrT1qbBjncH+EXD+MJOOKBX/ap++rYE
X-Gm-Gg: AR+sD11NvY9AtiCf+RRDjEtT+W+nJEslvOCA9RErhr4yBIe+XbYeG2orY67aDguilf5
 uHua13tMHJ2jJbmWN9Ygt1W+Zf+ruuvr7uPXl+E1hhcnQ8ZIxtxj9TktAIyrQES5wY+2NvYkPNW
 NR83E/BhWe0VtKZ3RbYjKbVIrLuR/Z1KC2NGaXI6q2pgDTUpcSHgf4PCu0rXpKCwbUVM5mg6TqA
 OVovZOG2q+wQtdM9KkoJp81zN6Cpb7/WTRr/BxXJGWwc3Rb+NLtew3Rvw0r4eo3h9nkBelX0waZ
 g6+3iJ8CtN1qYDkABd3siNqu1DnLg16J6v6jjU/Wnyr2UOavfxtGfIuPIB2cBIxew7Oqk+Oree5
 +DMLv+NIRyUthgrGjpMv1dkWmolkWWuNIStf2LTBN0k4+Df045+CFTY9bcTd1pa/VmSw2Ajsb2R
 J5wNRT02WGrIOnYL4w8HD1AKLvhnWv2Q/m9H9qIwsw6gFBxTdotL7U+x+yiVzlfhMreyU0yf813
 E1AsHeYhyQ/I2XAt3iVl3Kx2GNMLgDMkiYxuhOgRXaZfWA0hvZCh06SLXtOQbzKcLUHdoXu5bOK
 TnC8XXafJ8K/DFwtIdQR7z1py80=
X-Received: by 2002:a05:6402:2411:b0:6a3:fee5:adcf with SMTP id
 4fb4d7f45d1cf-6a5c409f463mr1169715a12.1.1787601271724; 
 Mon, 24 Aug 2026 12:54:31 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e025158sm11410217a12.11.2026.08.24.12.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:54:31 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v3 0/2] drm: Add DRM driver for GlandaGPU (VHDL soft-IP GPU)
Date: Mon, 24 Aug 2026 21:54:16 +0200
Message-ID: <20260824195418.17707-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is v3 of the GlandaGPU DRM driver series [1][2]. It addresses
review feedback from Krzysztof Kozlowski and the automated review
bot on v2.

GlandaGPU is a small VHDL soft-IP 2D display controller, currently
targeting a Terasic DE10-Standard (Cyclone V SoC). This series has
been tested against a QEMU digital twin and on real hardware.

Hardware/VHDL:   https://github.com/stiangglanda/GlandaGPU
QEMU fork:       https://github.com/stiangglanda/qemu-glandagpu
Userspace tests: https://github.com/stiangglanda/GlandaGPU-userspace-tests

Changes since v2:

dt-bindings:
- Switch from the "glanda," vendor prefix to a personal prefix,
  "kieweg," since this is a personal hobby project, not backed by an
  organization. Update vendor-prefixes.yaml, the binding
  file name, and $id accordingly (Krzysztof Kozlowski).

driver core:
- Fix ignored return value of drm_mode_config_init().
- Fix hardware interrupts being left enabled if drm_dev_register()
  fails, which could lead to an unhandled interrupt storm.
- Add resource size validation before I/O memory mapping, closing
  an out-of-bounds mapping/write.
- Fix userspace atomic commits hanging when the driver falls back
  to polling mode (no IRQ), because vblank events were armed but
  never signaled.
- Enable only the INT_VSYNC interrupt. INT_DONE had been enabled
  unnecessarily which could cause an interrupt storm.
- Fix pixel readback to treat framebuffer data as little-endian
  explicitly, which broke color conversion on big-endian hosts.
- Add missing Kconfig dependencies for DRM_GLANDA.
- Use platform_get_irq_optional() instead of platform_get_irq()
  for the optional IRQ, avoiding log spam.
- Drop drm_info()/drm_warn() messages on success paths, drop
  redundant "end of table" comments, and fix the of_match_table
  indentation (Krzysztof Kozlowski).

On the question of what this brings to the community beyond myself:
I don't have an existing user base, and I want to be upfront about
that. I built this to learn how a DRM/KMS driver is put together
end to end, from VHDL soft-IP to kernel driver. What it does provide
is a small, complete reference for exactly that path, plus a QEMU
digital twin that lets anyone poke at a GlandaGPU-compatible device
without owning the physical board. I raised this same concern during
the RFC review, and Thomas Zimmermann's answer at the time was that
we already carry a driver for a hobbyist-built RasPi USB display, so
being a hobby project is not a blocker in itself. I'd rather have
this maintained in-tree, with review, than as an out-of-tree module
nobody ever looks at.

[1] v1: https://lore.kernel.org/dri-devel/20260714101146.200416-1-kieweg.leander@gmail.com/T/#t
[2] v2: https://lore.kernel.org/dri-devel/20260730173643.256052-1-kieweg.leander@gmail.com/T/#t

Leander Kieweg (2):
  dt-bindings: display: Add GlandaGPU binding
  drm/glanda: Add initial DRM driver for GlandaGPU

 .../bindings/display/kieweg,gpu.yaml          |  55 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  11 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/glandagpu.c              | 587 ++++++++++++++++++
 6 files changed, 662 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c

-- 
2.43.0

