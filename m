Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9353C5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3843A10E1B5;
	Thu, 30 Jul 2026 17:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtPF0P5p";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F7610E1B5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:38:29 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495590dde14so467165e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785433108; x=1786037908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7OoqYtdO+0fOmVWiZOoM5gwTne70jDLTok+A94SX0IU=;
 b=RtPF0P5pzY6q/uLFJn19JRzFmzY1AX9z2Z6WNDbQ6er14vc2goNQGBeph2F8oVfqyM
 NxLWu4ovO6dRfAYeAJlbaQ27OVZa4m1xDV7/Zd6hwN2ZyET8kn986H8Dd+40nRJHreap
 OfNCXWrtnXTd0iGyj5PxOLWbS1Aeb95JRrmv8DrnPNylwNZNH6lbdTzabRD0xRuto/a0
 tU3/BveIqHkdTddcaeSMYicwGnRbWrWAyU1k6PuzvPz0zlszhVJMiXhfxxASOjcQ1EF8
 9t5AGqp2RhcdhR9uyJXlg+2ANgW0VVdEspYMCK2a3dBzmFr6r3UeeWt01KCBQ8N6nrmC
 IbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785433108; x=1786037908;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7OoqYtdO+0fOmVWiZOoM5gwTne70jDLTok+A94SX0IU=;
 b=ALE73IygyQBXDTLx02xtvuet7WCfMxVlxNYOfsws1C2Np46uhwaQolTw+Mt+ZDtSRk
 x+TcpVcmUdVwh4KLmynqMSKSFXxqU89sjJf4UKNUnpoNlIkQtSlCacO9z15pXWxHdDsT
 hlHjbNPCbB6vcntUuwPpAGpyQvOSHPMGfyyq1dlxGS6i/11GEmFnXQGApUglBPfd0Amk
 tFByUq+ZG9Er8BuIRC9wJuKAUwtuWmFcD4WuFh+arhQ18nuMeH51clgJw096Afi/gxvR
 AlBMvVg82fa1UMF8241JDvfHMa3f7mQEo3SthEuLnxjS/aVDtaEGlKvzEiZyyRLKzupU
 tBVA==
X-Gm-Message-State: AOJu0YzvciYDabB+uuVXnYc1e0jBhg+X4BRAmcP+ckeKGtm/g6QJDWul
 BbOY+kIaP4wGZMZ0CsUN7ohLzhp1asIjRCQ1Ms2PCkiQ2mcQvvVrhoPZAk71OTWbWWQ=
X-Gm-Gg: AR+sD11rY6Us1kPC6EZnDE97nyYXz4m1oMgZvA1q/pQWRENzoQaI43ZXAirbO9Agwqf
 BxhtQZpk1jgYqM9/qUC07fUz7aY/W9YQboYo3frUPuMTTzobPOwXyZxRN/nNSIgedDiABYIKpIa
 jy0zDqq5eTiGCNy65ePweAQIk8rBnDpgZtJGv7RkFr1We5tkzpmjW23WToaIPsioXnzPxkzDygl
 fa9riKIrn7ztG5sLFYpG138BnfgoHCrMldmxs2XeAKt/yeOtA25DIethnZCt21+MWJB4SoezFua
 A3OXH4KnMlXOFoOjrYKhtf/Avd6oNiu//+c3dqjfPWhrtV40Pxnjzu99oXAMT3yTKpfvg1hg+OR
 CcWcNVEA633TSV1EerHvP0NJ+/qVhMNu7WOmxkIK3W4u4jmXrdcpZh6psx3PlsGr/1L6Bd8Ppmy
 nkk/aaJF+SxAZ5pUd/r5l0fjSeIvmVqLt1olO2dLUx4gIgiMgf4FAqnJsCf6fz0K8CSFUFwwKwK
 n93AWCCeCrvIXu2us1WRMfGt29jiijCyJ1P1CHRYLyAEHhrzjwTrW8vFdVdVpEhuidWmf4pPnNX
 PXXZD826tA/i0EmV/5L71tFL7FNi0hAQaSsBWQ==
X-Received: by 2002:a05:600c:8b43:b0:495:4a34:16e1 with SMTP id
 5b1f17b1804b1-49804c531d2mr21225095e9.23.1785433107750; 
 Thu, 30 Jul 2026 10:38:27 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f0ecd4sm71603455e9.1.2026.07.30.10.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:38:27 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v2 0/2] drm: Add DRM driver for GlandaGPU (VHDL soft-IP GPU)
Date: Thu, 30 Jul 2026 19:36:40 +0200
Message-ID: <20260730173643.256052-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is v2 of the GlandaGPU DRM driver series [1], addressing review
feedback from Thomas Zimmermann, Conor Dooley, Uwe Kleine-König, and
the automated review bot on v1.

GlandaGPU is a small VHDL soft-IP 2D display controller, currently
targeting a Terasic DE10-Standard (Cyclone V SoC). This series has
been tested both against a QEMU digital twin and on real hardware.

Hardware/VHDL:    https://github.com/stiangglanda/GlandaGPU
QEMU fork:        https://github.com/stiangglanda/qemu-glandagpu
Userspace tests:  https://github.com/stiangglanda/GlandaGPU-userspace-tests

Changes since v1:

dt-bindings:
- add a link to the GlandaGPU project in the binding description
- add clocks to the required properties
- fix the example to use interrupt-parent and the GIC_SPI/
  IRQ_TYPE_LEVEL_HIGH macros instead of raw numbers
- fix missing trailing newline

driver core:
- drop the struct device *dev field, use drm_device.dev instead
- open-code drm_encoder_init() instead of drm_simple_encoder_init(),
  which is being phased out
- switch the plane update path from manual dma_resv_lock()/
  drm_gem_shmem_vmap_locked() to DRM_GEM_SHADOW_PLANE_HELPER_FUNCS/
  DRM_GEM_SHADOW_PLANE_FUNCS. This also fixes sleeping calls being
  made from atomic-commit context and a raw map.vaddr dereference,
  both flagged by automated review
- use drm_gem_fb_create_with_dirty() instead of a custom fb_create
  implementation
- remove the redundant new_state == NULL check in the CRTC flush
  helper
- remove the ioctl-based UAPI (CLEAR/RECT/LINE) entirely. As Thomas
  pointed out in v1, fixed-function 2D ioctls aren't a good fit for
  mainline DRM, and userspace rendering into the shadow-plane
  framebuffer covers the same functionality
- fix a double drm_mode_config_cleanup() call in the probe and
  remove error paths (devres already handles this)
- call drm_atomic_helper_shutdown() on remove
- fix a teardown race where in-flight work could touch already
  unmapped MMIO, using drm_dev_unplug()/drm_dev_enter()/
  drm_dev_exit()
- move IRQ registration to after CRTC initialization, avoiding a
  potential NULL pointer dereference from an early-firing shared IRQ
- fix platform_get_irq() error handling. Negative error codes such
  as -EPROBE_DEFER were previously misread as "no IRQ available"

new in v2:
- add PCI probe support alongside the existing platform_driver/
  devicetree path, backed by a matching QEMU device model, so the
  driver can be tested against a virtual device without needing
  devicetree or real hardware. Real hardware continues to use the
  platform_driver path unchanged. This replaces the old x86 test
  device patch 3/3, reducing the series from 3 to 2 patches.

Known open item: the QEMU test device currently uses a placeholder
ID from the range QEMU reserves for experimental, unregistered use
(1af4:10f0, see [2]). I've requested a permanent
ID from Gerd Hoffmann and will post a follow-up once it's assigned.

[1] https://lore.kernel.org/dri-devel/20260714101146.200416-1-kieweg.leander@gmail.com/T/#t
[2] https://www.qemu.org/docs/master/specs/pci-ids.html

Leander Kieweg (2):
  dt-bindings: display: Add GlandaGPU binding
  drm/glanda: Add initial DRM driver for GlandaGPU

 .../bindings/display/glanda,gpu.yaml          |  55 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  11 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/glandagpu.c              | 579 ++++++++++++++++++
 6 files changed, 654 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/glanda,gpu.yaml
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c

-- 
2.43.0

