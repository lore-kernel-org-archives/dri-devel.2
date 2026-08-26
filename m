Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9048C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F9F10ED8B;
	Wed, 26 Aug 2026 16:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="ALpjRSYv";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3078910ED87
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:41:26 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47db714766aso67240f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762484; x=1788367284;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64TYoztfjTxz6bZJgz8b/VUNCXdb2tzD8EdoWyK7qS4=;
 b=ALpjRSYvSLQQndIx0ir5wSn5HMLFq4UhmFcPiTeCUnEhpR29t/Uc4tANKQSF9fZP0o
 8D8sCfsha9QV9SHMnBfR7nUJ6D6q/rESznXQy+9vvnMuAbfBPLUBhZYVKibCaAoKGpAI
 7uGbnXYVPSGfpYxN8WlLYN/MVTRFMN9mUcbay0Xk5krdhHad4hgERF8yGBeKkDTfVtDr
 HKnu8+4JwMHK5sP8NlX33Kf3LCUAzCgJvMgbqKJ0YHe6lZSw8jxMHAM53HRBBRB54wPI
 RplN3RKzWqjyk72pu5H3S3vx4Hc3/6M6THYHhKL/gBQLOqnBx3ShOzTDqni/T03f0ton
 cHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762484; x=1788367284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=64TYoztfjTxz6bZJgz8b/VUNCXdb2tzD8EdoWyK7qS4=;
 b=e8kNVU/MErreSr0RDVtNhxaMt7HZV3I5tNVb0WbVAUr0EgvKphBh+XzKZx1407DlIQ
 U2cOpyIwAhb1dnFxQm/yYiDo3tMs5piA7OPSQC33j5D5xOumkV7s6mIqocJAKSNYrLpz
 j5eF+JC0Qc5h3sl1uQN9GQ1SLN3rDmPoHq4xJ3sBCvA3Ityoe6tX2mK50afWdIP1sXxQ
 ibYqx87z6C1tsRvd52yDI/2V49qaU97sF27Qkuzt3IJlv9VNIUCVF28g8iNKBjfWtmOQ
 bxJOt/Nhv6rmK+J2p3YRxkwVIo/jAkjorPneIvCAFTYgnRFAJ5sl3/8m/kbo2F7KFjxX
 loXw==
X-Gm-Message-State: AFuF++kX6jAD8voDsSDYYFG9eBqwPkxfzumL+LC5uKwuk+ddeSpo91yQ
 L95Z8hZs6Pl0SUAvk78Djxj9j7lnWXSBd710kS7obQxGSiNmL5pwCHuOhwtQIRjWUKHJHxcrPTH
 ITF9jlKdt
X-Gm-Gg: AR+sD13U0lhKMwyMj2Y0z4TBlPHUTjgZEsI4L8awwcBBbNdY6NEhH5iub2vkhKK6FRM
 +A/a4/4NwpJl8V2muthsy14E4dN9esuWDzKfTYCY1177ZOZn2FX460ER+8vgwdUlnuDWQIVYOhy
 8H0uL3hpypseOrBzhSeuDeGk1FjiPtOrAJj69sbUOxNwu2heZHB1h/QKSQ9VkYZZ2KMSSqFVQEM
 ijUnl2DV2QGWbevO2t2X4obDuvs6+ZS98CxSNU96Em8uOhwiTJ6sHNr8jLgZs5pkOs/rJ3mkijc
 WyGUV3N4z12ACFBr0nlbeKK7mDihYjI4hNtcbWXH8aF8qinoR1ghfJIRqM+AlHLDom0gAbgWwFf
 oRv+/LxQPaPxb6UZgvEvMfJEb6Atipb5EY4wwtEwZuNoV+C1/HwRR6KFQcmuLvWqFI4/j+dsprA
 BC+zdmlzM5jFWTissengqKSzz4sPJOjvDpWvuLpnyFI81PYGLC+ccv0yzmjXuu8RXAt7B1I2N9c
 Ns5zxcyLSjIRkKUiJb0d9bYhESNFgblM49WkqOlzhon9V0=
X-Received: by 2002:a05:600c:3e8e:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-49b0dfd7d2cmr5041365e9.7.1787762484634; 
 Wed, 26 Aug 2026 09:41:24 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5721a0sm21769715e9.4.2026.08.26.09.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:41:22 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 12/13] drm/vino: allow the driver to be built
Date: Wed, 26 Aug 2026 17:37:37 +0100
Message-ID: <20260826163913.7052-13-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826163913.7052-1-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
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

Add the Kconfig entry, the Makefile rule and the MAINTAINERS record, so the
preceding commits become a module.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 MAINTAINERS                   |  6 +++++
 drivers/gpu/drm/Kconfig       |  1 +
 drivers/gpu/drm/Makefile      |  1 +
 drivers/gpu/drm/vino/Kconfig  | 42 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vino/Makefile |  2 ++
 5 files changed, 52 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/Kconfig
 create mode 100644 drivers/gpu/drm/vino/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b548bba6525..79ccf112fabd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8537,6 +8537,12 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/udl/
 
+DRM DRIVER FOR VINO DISPLAYLINK DL3 DEVICES
+M:	Mike Lothian <mike@fireburn.co.uk>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	drivers/gpu/drm/vino/
+
 DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
 M:	Louis Chauvet <louis.chauvet@bootlin.com>
 R:	Haneen Mohammed <hamohammed.sa@gmail.com>
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f..ac73fc425c59 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -358,6 +358,7 @@ source "drivers/gpu/drm/vboxvideo/Kconfig"
 source "drivers/gpu/drm/vc4/Kconfig"
 source "drivers/gpu/drm/verisilicon/Kconfig"
 source "drivers/gpu/drm/vgem/Kconfig"
+source "drivers/gpu/drm/vino/Kconfig"
 source "drivers/gpu/drm/virtio/Kconfig"
 source "drivers/gpu/drm/vkms/Kconfig"
 source "drivers/gpu/drm/vmwgfx/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e635fcffd379..29ab96f6e8de 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -185,6 +185,7 @@ obj-$(CONFIG_DRM_VC4)  += vc4/
 obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
 obj-$(CONFIG_DRM_VGEM)	+= vgem/
 obj-$(CONFIG_DRM_VKMS)	+= vkms/
+obj-$(CONFIG_DRM_VINO)	+= vino/
 obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
 # nova-drm is built from drivers/gpu/Makefile together with nova-core.
 obj-$(CONFIG_DRM_EXYNOS) +=exynos/
diff --git a/drivers/gpu/drm/vino/Kconfig b/drivers/gpu/drm/vino/Kconfig
new file mode 100644
index 000000000000..fcc761b4654b
--- /dev/null
+++ b/drivers/gpu/drm/vino/Kconfig
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+config DRM_VINO
+	tristate "DisplayLink DL3 (Vino) open driver"
+	depends on USB
+	depends on DRM
+	depends on RUST
+	# RUST_DRM_GEM_SHMEM_HELPER depends on MMU; inherit that dependency here so the
+	# select below cannot generate an unmet-direct-dependency warning on nommu.
+	depends on MMU
+	select DRM_KMS_HELPER
+	select RUST_DRM_GEM_SHMEM_HELPER
+	select CRYPTO_RSA
+	select RUST_CRYPTO_AKCIPHER
+	select RUST_CRYPTO_LIB_AES
+	select RUST_CRYPTO_LIB_SHA256
+	select FW_LOADER
+	select RUST_FW_LOADER_ABSTRACTIONS
+	select FW_UPLOAD
+	help
+	  Open in-kernel Rust driver for DisplayLink DL3 docks: the DL-3x00
+	  port replicators, the Dell Universal Dock D6000 and other DL-6xxx
+	  docks, and the DL-7400 quad-display docks. A dock is matched on its
+	  USB function rather than on a product id, and identified from the
+	  vendor descriptor it carries.
+
+	  It binds the dock over USB, runs the HDCP 2.2 control plane, mode-set
+	  and the Vino codec, and registers a DRM/KMS sink that scans out to the
+	  dock's video endpoints.
+
+	  To compile this as a module, choose M here: the module is called vino.
+
+	  If unsure, say N.
+
+config DRM_VINO_KUNIT_TEST
+	bool "KUnit tests for the Vino driver"
+	depends on DRM_VINO && KUNIT
+	help
+	  Build Vino's protocol, crypto and codec unit tests into the driver.
+	  The tests run when the driver is loaded, so this option is intended
+	  for driver development and test kernels rather than normal use.
+
+	  If in doubt, say N.
diff --git a/drivers/gpu/drm/vino/Makefile b/drivers/gpu/drm/vino/Makefile
new file mode 100644
index 000000000000..6e39668040f3
--- /dev/null
+++ b/drivers/gpu/drm/vino/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_DRM_VINO) += vino.o
