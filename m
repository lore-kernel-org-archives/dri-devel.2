Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73374F3380C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77AA10E34D;
	Tue, 17 Mar 2026 08:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DI2v04Rf";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1224810E501
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 12:08:43 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-35a132767c3so1826532a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773662922; x=1774267722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcMCN4hBDLIQ/4UX2mdBSL3FjHJfxnbR1E7YALxJuSk=;
 b=DI2v04Rf7f7vsEvT4wCVlUzJsLzXv5s3RocCu0091YZK7v+WIkAJ82Ae5PrVm14HCt
 aWXJEr8OMm15hGy0AYr1/N+tBFbxsOcChYQO2ko5P24C6/2Ywk35gJBLn2ZvAdVk5hsR
 mJC6+jnbbc2/CmatQHRhfOyUtWoZhN2I+kMvf2B2BWYBmYpfN4xNyUKz0tfmTegQ5rnH
 /6cvW+VZtSd1Gxm8Mumj0CbhvMsqlNhOsnS4XOO0XLpyXHWCqXFSOcXeQsRux+3Ctl4E
 K+ysheW+T94jRh0R2Ukno5vaxJCtXbx4NIbtFeRGB4M8U6B119gxXb8Aa9qiPu8OkSnp
 p9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773662922; x=1774267722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vcMCN4hBDLIQ/4UX2mdBSL3FjHJfxnbR1E7YALxJuSk=;
 b=LjsJ5zWzMjSTccH7f1Y88ZXRfqHh5NVRVMSXybXVWbDyATOi1QJBeFMiA2nNJUtMDP
 OlsgCwyucY4bsGZ279sItxZBaOSPhLUy8psflP/8lANke4K4UfZBUIKsUuNQ6RPAyG1/
 Puu/KUGEOEhmRMDr+BcQj9ravCFJrlc+SAMXSZs3lRNpfsMRG0Gr3FhuJO14owfcZ25V
 9OMSZ1HkmLN+J7q1VoLDHzjbv6lCtBk4lBaCesOtx9iyK/ObubbOkswrdlMW6Cz8T035
 bu5O6CHfiniNYrqQj3VJ+lXLL1Ac44a6AtsOdRylSylc3zAJK3Xg0eCsMKDBIXQto00h
 JAPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEkpDYqc2DodztW3wCTqoC5OWgHkNBZdtvWKeR95aIwlu1LxyWCejqrL/x/zRI9qlJEOYwR4EgS/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7P7sFky17khXg4D4D+AGWIlChAhWOXkAZXio3WNAz3W/y/pMY
 VyyBzC6l2L0n1cQo+USHcdyduZPHlkPxnUuBhT1+xNdDP+Tp8jyhcOxg
X-Gm-Gg: ATEYQzxJcG4WAU3iN+VgC4yKdmFADv+bOUgDagb2X60Fs0AymFMQrwN19EK+WtY9BvY
 Ve+hDyeSo9myzCW9iAB6Gn1xLmI54++qcOlf4KVSCOoUS2gNkHBlAFn+4oc/GVzlsR0/xBF8px1
 tlq8b4IiT7BUFCSdlzxGMnO3tUkC3uP3jQ04iWFznjFyzXLjevInuT5cnf0egmuaH5p4uuAHXTq
 vQm0IdK5s6+Z/RtUbI6WZDYSiu9FV7pi3W69nsKJ4REVgF60FhNiZGCicPbcWeYFq6L1DWWpA8M
 gHWu6O5P9B96F7lBGSG/dv0nKu7U4m+p8ag5/v5pOO+ZdDanUiF6Nb6kCliEdehboxJBFWhDgRU
 yHX4uqd7Y/4EKnu2XW9Luk4hJ1YNiPZN3edQ1wjRw/BPelnXWVZXwO3uwqUEw9/qc/l10pXJ75E
 38t+J6tcxB7CJZGPhFll3huGS+Dze9NJP4BUurrNUzpRhri1C57khK
X-Received: by 2002:a17:90b:2496:b0:35a:275c:4c27 with SMTP id
 98e67ed59e1d1-35a275c501bmr6504117a91.2.1773662922410; 
 Mon, 16 Mar 2026 05:08:42 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net
 ([2001:288:7001:1099:c21f:f7d6:f4bc:6198])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35b9e36f45asm3240083a91.3.2026.03.16.05.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 05:08:42 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>,
 John Hubbard <jhubbard@nvidia.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH v2 2/2] gpu: nova-drm: rename nova/ directory to nova-drm/
Date: Mon, 16 Mar 2026 20:08:20 +0800
Message-ID: <20260316120820.2117081-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260316120820.2117081-1-yphbchou0911@gmail.com>
References: <20260316120820.2117081-1-yphbchou0911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

Rename the nova-drm driver directory from drivers/gpu/drm/nova/ to
drivers/gpu/drm/nova-drm/ and the top-level source file from nova.rs
to nova_drm.rs (matching the object name nova_drm.o) to follow the
kebab-case naming convention already used by the auxiliary device name.

Update MAINTAINERS, Kconfig, and Makefile references accordingly.
Update the Kconfig help text to reflect the new module name nova-drm.

Link: https://github.com/Rust-for-Linux/linux/issues/1228
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 MAINTAINERS                                            | 6 +++---
 drivers/gpu/drm/Kconfig                                | 2 +-
 drivers/gpu/drm/Makefile                               | 2 +-
 drivers/gpu/drm/{nova => nova-drm}/Kconfig             | 2 +-
 drivers/gpu/drm/nova-drm/Makefile                      | 3 +++
 drivers/gpu/drm/{nova => nova-drm}/driver.rs           | 0
 drivers/gpu/drm/{nova => nova-drm}/file.rs             | 0
 drivers/gpu/drm/{nova => nova-drm}/gem.rs              | 0
 drivers/gpu/drm/{nova/nova.rs => nova-drm/nova_drm.rs} | 0
 drivers/gpu/drm/nova/Makefile                          | 3 ---
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/gpu/drm/{nova => nova-drm}/Kconfig (84%)
 create mode 100644 drivers/gpu/drm/nova-drm/Makefile
 rename drivers/gpu/drm/{nova => nova-drm}/driver.rs (100%)
 rename drivers/gpu/drm/{nova => nova-drm}/file.rs (100%)
 rename drivers/gpu/drm/{nova => nova-drm}/gem.rs (100%)
 rename drivers/gpu/drm/{nova/nova.rs => nova-drm/nova_drm.rs} (100%)
 delete mode 100644 drivers/gpu/drm/nova/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b277d5bf3d1..7ee486627420 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8201,7 +8201,7 @@ B:	https://gitlab.freedesktop.org/drm/nova/-/issues
 C:	irc://irc.oftc.net/nouveau
 T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git drm-rust-next
 F:	Documentation/gpu/nova/
-F:	drivers/gpu/drm/nova/
+F:	drivers/gpu/drm/nova-drm/
 F:	include/uapi/drm/nova_drm.h
 
 DRM DRIVER FOR OLIMEX LCD-OLINUXINO PANELS
@@ -8484,7 +8484,7 @@ X:	drivers/gpu/drm/i915/
 X:	drivers/gpu/drm/kmb/
 X:	drivers/gpu/drm/mediatek/
 X:	drivers/gpu/drm/msm/
-X:	drivers/gpu/drm/nova/
+X:	drivers/gpu/drm/nova-drm/
 X:	drivers/gpu/drm/radeon/
 X:	drivers/gpu/drm/tegra/
 X:	drivers/gpu/drm/tyr/
@@ -8496,7 +8496,7 @@ M:	Alice Ryhl <aliceryhl@google.com>
 S:	Supported
 W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-rust.html
 T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
-F:	drivers/gpu/drm/nova/
+F:	drivers/gpu/drm/nova-drm/
 F:	drivers/gpu/drm/tyr/
 F:	drivers/gpu/nova-core/
 F:	rust/kernel/drm/
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index d3d52310c9cc..958fa142b6cd 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -308,7 +308,7 @@ source "drivers/gpu/drm/mgag200/Kconfig"
 source "drivers/gpu/drm/msm/Kconfig"
 source "drivers/gpu/drm/mxsfb/Kconfig"
 source "drivers/gpu/drm/nouveau/Kconfig"
-source "drivers/gpu/drm/nova/Kconfig"
+source "drivers/gpu/drm/nova-drm/Kconfig"
 source "drivers/gpu/drm/omapdrm/Kconfig"
 source "drivers/gpu/drm/panel/Kconfig"
 source "drivers/gpu/drm/panfrost/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index ec2c5ff82382..acdec9e30a27 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -186,7 +186,7 @@ obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
 obj-$(CONFIG_DRM_VGEM)	+= vgem/
 obj-$(CONFIG_DRM_VKMS)	+= vkms/
 obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
-obj-$(CONFIG_DRM_NOVA) += nova/
+obj-$(CONFIG_DRM_NOVA) += nova-drm/
 obj-$(CONFIG_DRM_EXYNOS) +=exynos/
 obj-$(CONFIG_DRM_ROCKCHIP) +=rockchip/
 obj-$(CONFIG_DRM_GMA500) += gma500/
diff --git a/drivers/gpu/drm/nova/Kconfig b/drivers/gpu/drm/nova-drm/Kconfig
similarity index 84%
rename from drivers/gpu/drm/nova/Kconfig
rename to drivers/gpu/drm/nova-drm/Kconfig
index 3e637ad7b5ba..48a731bff9b1 100644
--- a/drivers/gpu/drm/nova/Kconfig
+++ b/drivers/gpu/drm/nova-drm/Kconfig
@@ -13,4 +13,4 @@ config DRM_NOVA
 
 	  This driver is work in progress and may not be functional.
 
-	  If M is selected, the module will be called nova.
+	  If M is selected, the module will be called nova-drm.
diff --git a/drivers/gpu/drm/nova-drm/Makefile b/drivers/gpu/drm/nova-drm/Makefile
new file mode 100644
index 000000000000..bd3a5e703742
--- /dev/null
+++ b/drivers/gpu/drm/nova-drm/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DRM_NOVA) += nova_drm.o
diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova-drm/driver.rs
similarity index 100%
rename from drivers/gpu/drm/nova/driver.rs
rename to drivers/gpu/drm/nova-drm/driver.rs
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova-drm/file.rs
similarity index 100%
rename from drivers/gpu/drm/nova/file.rs
rename to drivers/gpu/drm/nova-drm/file.rs
diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova-drm/gem.rs
similarity index 100%
rename from drivers/gpu/drm/nova/gem.rs
rename to drivers/gpu/drm/nova-drm/gem.rs
diff --git a/drivers/gpu/drm/nova/nova.rs b/drivers/gpu/drm/nova-drm/nova_drm.rs
similarity index 100%
rename from drivers/gpu/drm/nova/nova.rs
rename to drivers/gpu/drm/nova-drm/nova_drm.rs
diff --git a/drivers/gpu/drm/nova/Makefile b/drivers/gpu/drm/nova/Makefile
deleted file mode 100644
index 42019bff3173..000000000000
--- a/drivers/gpu/drm/nova/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_DRM_NOVA) += nova.o
-- 
2.48.1

