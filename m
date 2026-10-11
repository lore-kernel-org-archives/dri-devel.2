Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBC5CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 15:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CB610E295;
	Sun, 11 Oct 2026 15:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KLPHDZr2";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09BB10E295
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 15:46:03 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso11552835e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791733562; x=1792338362; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KWtk7M4DwRl8OFBblism+Ji7aIBUvvGL32g8hLsp5pU=;
 b=KLPHDZr21SZ+K9jhZvRlQj+yOy6ZM9888VigwTdzSeDC/kcVNPmcuMWgLlsljPKFAe
 y3ahlMfmwuFJUDS3qKRN1o9tv1mmgz86tzx9TXV1wU3tqFrd3vzGOwObUunYGfA7gJcP
 gktj1a7Seuq2zqSGpo1S8RpfNRLya7SVfZ6YsnkHtf7fo3JaiXezhJp/lIFyvZWOwVFZ
 Jj/qnbhy6QIGK6ugaOWmhBzcvEiTyBA2fvgFy/dpGbXfxTOGhdixXIegGqLOtkuGR2ck
 K3JyD0ttL5WHZKtddaXNB8F5rJqjqH/hbt3EGpGK7hMm2LQlwU4edKrwwJsVXNvUfqWQ
 p/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791733562; x=1792338362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KWtk7M4DwRl8OFBblism+Ji7aIBUvvGL32g8hLsp5pU=;
 b=pWI3GEW3IjMzJalqdX4FT7wi2/mgth+2P0ifhdqN+8r7+7HI/HLGHoAhbEAWF3A9OD
 a41nODyBRDlL1JpOrXOWrr7i/H4Uu2EqodCyGODZjcpEegKyS+PW9nP1LnUeOxGbb664
 FjhH98v3vv79DzgD5UpnFPyvt4gGFSe1qSIevPI+6vviSAQ3wkoGzVxQslvMuji2Z8OO
 lInliJKtnmLpBKwes0F52ha5g0tj3AijgNMoH5ow/FzpVFK7czF9dQ11bp+7TMXVUjuB
 Pm4SGkU/jKEkkaRDiQ0CmUUIt0UFbAOiawDVWe3oFdSLbzVKLDrP5VEBxZlGoijm6ekm
 pUqg==
X-Gm-Message-State: AFq9FYJBGUYqcJQLMeIVDhoIbfCLCvqGGm6/EPgFZaO8tb4neCW3Dq7L
 Jz9LkFU8wNmODwwOzOB3sX/4gBhn8KlM1c1o98ySnPH4sdOX2v4YLq60S8Uzjk90
X-Gm-Gg: AYBFou0h/X1grNWQPFBWufwl2f9CM5OONkYyEcFvmfxBMA7x7z40IMRrGe7DmKXjR3s
 Dh/N6vVx1SBoYBSfhTOt1VGJTXH6RiUi74JBf3mIHz+4EPo2ARBjJkPLxuL8IuqLJK//pfC8VL5
 /6FLk/7i2q/QvPc8K42RkxRY8PlR8t3ExgMkRgLJwI2ahO4QV4zVeMIZnG2w3nPlx5CTz/G2g4i
 /CBdc21WpAUlQrNOHvGkhcfv89YLIAB76FqrsrPBochJ7BZtm0l6tS5e6m6e8PSx6xwTu+aNsFd
 puTDfQz32Y5zhmG1LfQ0xKuPEdGSmNgfv0OPUPYcwhjkFfO5jouq+KGbU1k9ozlm3smUIofktcu
 Yio9WYKTRlhsP5mcPXpsI/xl6FaH4+jO7Ve/bBBXwsbmm/FDS7ji0wwg1i4qGSO39KWGbSSR8u6
 QqO42VrzJfC7y1m4RNp3lC0ys/3nUEO5oFVSErDFVcPmEchvZytAjX1+E3OYE5A31d3HA6fmczb
 7uR/LyDh3y7W/ZnmkTS89a4mIbMLixe2MsRL/f+chGJaGv8n7BhG70s/aKSX9IA1ByFAA4C3BOm
 SPWaWwvqpcuInavPsPUhxBdMHUAOlxqLORRbjw6w0Xrm75jz+A==
X-Received: by 2002:a05:600c:19ca:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-4a18e4487b5mr137032985e9.1.1791733561853; 
 Sun, 11 Oct 2026 08:46:01 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:3341:ed52:5c10:2778:2fcf:de1f:bc08])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db93d6069sm13996176f8f.0.2026.10.11.08.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:46:01 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v6 0/2] drm: Add DRM driver for GlandaGPU (VHDL soft-IP GPU)
Date: Sun, 11 Oct 2026 17:45:54 +0200
Message-ID: <20261011154556.155831-1-kieweg.leander@gmail.com>
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

This is v6 of the GlandaGPU DRM driver series [1][2][3][4][5]. It
addresses review feedback from Thomas Zimmermann on v5.

GlandaGPU is a small VHDL soft-IP 2D display controller, currently
targeting a Terasic DE10-Standard (Cyclone V SoC). This series has
been tested against a QEMU digital twin and on real hardware.

Hardware/VHDL:   https://github.com/stiangglanda/GlandaGPU
QEMU fork:       https://github.com/stiangglanda/qemu-glandagpu
Userspace tests: https://github.com/stiangglanda/GlandaGPU-userspace-tests

Changes since v5:

driver core:
- Replace the custom glanda_crtc_atomic_flush() with
  drm_crtc_vblank_atomic_flush() (Thomas Zimmermann).

On the QEMU device ID: it's currently a placeholder from the
experimental range, since I haven't submitted the QEMU patch to get
an official one yet. Is that fine to merge as is, with a follow-up
kernel patch once the official ID is assigned?

[1] v1: https://lore.kernel.org/dri-devel/20260714101146.200416-1-kieweg.leander@gmail.com/T/#t
[2] v2: https://lore.kernel.org/dri-devel/20260730173643.256052-1-kieweg.leander@gmail.com/T/#t
[3] v3: https://lore.kernel.org/dri-devel/20260824195418.17707-1-kieweg.leander@gmail.com/T/#t
[4] v4: https://lore.kernel.org/dri-devel/20260913205007.118552-1-kieweg.leander@gmail.com/T/#t
[5] v5: https://lore.kernel.org/dri-devel/20260920193944.110983-1-kieweg.leander@gmail.com/T/#t

Leander Kieweg (2):
  dt-bindings: display: Add GlandaGPU binding
  drm/glanda: Add initial DRM driver for GlandaGPU

 .../bindings/display/kieweg,gpu.yaml          |  56 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  11 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/glandagpu.c              | 634 ++++++++++++++++++
 6 files changed, 710 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c

-- 
2.43.0

