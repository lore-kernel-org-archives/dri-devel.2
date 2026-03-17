Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E03FD876A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B8310E628;
	Tue, 17 Mar 2026 13:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ACKkII1k";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB3910E139
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 09:23:19 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c739d32b72cso3862691a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773739399; x=1774344199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nct4kNqnGcAYlXVnZ1lrP6jb9x/1/lWYKGUKVTO0MqM=;
 b=ACKkII1katibKgrPwhQ+Yq2neW4/wuDbgHQXi5sgdzuCS87lvR2CytyYsq34Dc5JOP
 4KBetMsOQqRKxpsmZ3Md8sfK80grWRhlfY1wmsPm+h+aoR/okY6R41FHOq2WzwQfnzp0
 G7FNo1jW+rU7oKy0io+xbV6G4Gs4eUKfba+U+1voO2W2XwgyZzO/RI2nhSXzX1X2gBA2
 EkjSG5D7WRfRF8KnmOMLEuxkv8I60Unc+sVMbTqrVQS48nxjCwnJN7HJn4lrhwu9hFgn
 3ApRhIPMeXL31fmuGaGD+pmeaJ4tlrh4CILoEcyBfYleqjPzpvnxww81KhDE3tDLav39
 WPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773739399; x=1774344199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nct4kNqnGcAYlXVnZ1lrP6jb9x/1/lWYKGUKVTO0MqM=;
 b=E7BeWdQezfcQZuo1eDXiqgAWKyHurNdzskQ8y4qKF0UkUsI7xGB0COmGptw5wAy6w3
 FneH9K6J7238aWuLuC4QE9k2hoAFwsRu87nRPBdl88yT5mHHfMMvSwG1zA7ChVGoOj6q
 6RN47BeDx2qdHRf7Z14DvM9T4LaR3z/LBJMfVYjHSDT/LLIT89u8C0+jc8F9naKunFjr
 YhEoL9X3/OugFPHh1teYibNHN3wnYsm7LQRh37oMTyvg1eCL0YT5lbU5smm7QcVmw8KC
 1yFKljT7HBRHTmumzqDMhdrjiVxK3sSB8AQR4Joj0mG3mG+3SBOO2bb3YBKSlZI/TTJ2
 YOJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJrhfTNT4wFGl+4GEx7a8eOvZT7a4mfm7BUkT14NO0cGhhuhAsBs9EQanJ6vE45dFLIU7lwoAYJug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOkOegNefZkBH7ASfaOyJ3l0c+0mitAhQJLHRvtkri/dIopT33
 3DhjBxOrW2uT8+4EsKZTSwuOlWSfWGEl0N8rZTWDcnke1SAXNja9vS+J
X-Gm-Gg: ATEYQzyUL3cnNXt7ttBu3FRjXDbBlKtjVkUgpV0lwaaTJcmwEk7v2hqs/DEr5VPQiiv
 Sp8mAAtBM0qnpKMCOd0J0O4DSZScQ451wB1VWsGXxq+O/oHtbXf8f75nKTfCiti2WP+z4ebGqne
 PSAnuaVngovbwERztbbcvcDier4N1sb3s7YH+9ggWnmoTN0rwMFkYvWWm56hIU6wJyKNljIm59a
 BzVkT7axust7ES1dzD6KkkX1CiwSvumA/P/cYsLKv+DmaH8pzSoS0u+8HjLyGLbTAStHUb0LKGT
 dgZoKBx1DXKzbdzet2N1E1Ll0WURLswykjhjv1El43kqa8ikzRPJ2GfRJ20FdxYnAXo2BB9qLEu
 hBW6AbDq5HObFR2Bo9Kqq8X/y3BjDJwTQ26VActdAmM2N3TFrxuC/S8XV6hs6VykVHZRDQmr3Da
 TRZozlrCaPPBnTY8g/VVyJIEu7BZ3NLlpdazlBkxVAshbviqVz9tZv
X-Received: by 2002:a17:903:19c8:b0:2b0:68d1:2538 with SMTP id
 d9443c01a7336-2b068d12618mr10289815ad.51.1773739399222; 
 Tue, 17 Mar 2026 02:23:19 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net
 ([2001:288:7001:1099:6521:1510:d053:7359])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece81dc18sm137065385ad.69.2026.03.17.02.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:23:18 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: jhubbard@nvidia.com
Cc: acourbot@nvidia.com, airlied@gmail.com, aliceryhl@google.com,
 chia7712@gmail.com, dakr@kernel.org, dri-devel@lists.freedesktop.org,
 gary@garyguo.net, jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, simona@ffwll.ch, yphbchou0911@gmail.com
Subject: [PATCH v3 2/2] gpu: nova-drm: rename nova to nova-drm
Date: Tue, 17 Mar 2026 17:23:04 +0800
Message-ID: <20260317092304.424377-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <e7539fd5-9a0d-4a06-aa02-ec3dcd235926@nvidia.com>
References: <e7539fd5-9a0d-4a06-aa02-ec3dcd235926@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 13:49:27 +0000
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
Changes in v3:
- Rename subject line (John Hubbard)

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

