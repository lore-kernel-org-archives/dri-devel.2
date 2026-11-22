Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA66606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=biAwb145
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE2610E28E;
	Sun, 22 Nov 2026 15:47:45 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B7010E2E0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=47gc10QpJhC8rGNpdwal7/YEWt01gl49f4wsMv2jm6g=; t=1795362457; x=2110722457; 
 b=biAwb145tWXUMHqn9WSwz8oynBf1+s+T3RIxfH53jeGByVpmY6V4fGJS9ghp2bTrUib2XvjAjVc
 el0KINWPj74HX7soh7cZ6RYfF7lc0vlei7jkCA8g5/6YTqhe2eNP1BRqghOrbwbq8fli5vi0BPNIu
 ctCJlztMXWOT91WGB+tkXs37/AXn9z3XhQVY2/YTtEdHd10LLUiUpAjDKQs4Qc00tdqlMCRceQPnw
 XdPG0I4WXBk7ZgH1Vh9I8VuaAZliR9r06ivvpTGpZSYaLJ0dbVS4ZDUm3mSva1/KSUpT0HZEg/cpB
 E3lrV/soIzc7Rohc3kgGk0x4Eao1nYYGwfjw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xV9mx-00000002er2-3vCh; Sun, 22 Nov 2026 16:47:36 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 22 Nov 2026 12:47:24 -0300
Subject: [PATCH 2/2] drm/v3d: Remove V3D 3.3 and 4.1 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-v3d-remove-33-41-v1-2-52152b454ad8@igalia.com>
References: <20261122-v3d-remove-33-41-v1-0-52152b454ad8@igalia.com>
In-Reply-To: <20261122-v3d-remove-33-41-v1-0-52152b454ad8@igalia.com>
To: Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=30726; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=y8RZ4AeOxemeA5jx5sHSmdqUzx31okX+qn9wPMJjlzA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBrAw6O8BQDU1Ac69kPc+NhrAaKJ8Iacak+14npW
 87dS6AutD+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCawMOjgAKCRA/8w6Kdoj6
 qkUGB/4l1TgE5vq7Osytm64UWl6qka4HzHm4pLZH/r571VkA5ldJzE97TMWRpQtJasV8ITKZC+w
 bnl0UD3UJyD3lVoSBZKUAjPySSkisbnBWpVV3qMaS1fqbsE6ee/LKl6efxPJlRU5iVZu2utAylB
 UTqh8LzMWGFEtDO0iq3jp7uhXP/WzAltG6kt1ZdbKVQ3cz1RTOEmyvaVUFjXx+5Jxmr49zOMerg
 K99pcAlav0GpD9kAo4U/2ApabOvWmdNMgPJDmzRFi0CtwiT5gAjHrLFlE4hcmpRF2/Z9hwTTzf7
 8sskKGLLyrVFqhf0cVlYGCZr9umEDYyMNqcB2zsqRrENNBqa
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Support for V3D 3.3 (BCM7268) and V3D 4.1 (BCM7278) was deprecated in
commit 7ffcc4fffb45 ("drm/v3d: Deprecate V3D 3.3 and 4.1 support") and
scheduled for removal. No user has come forward ever since.

Therefore, drop their compatibles and the code only they used, such as
the GCA registers, the bridge reset path, and the V3D 3.x performance
counters.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/Kconfig       |   6 +-
 drivers/gpu/drm/v3d/v3d_debugfs.c | 150 ++++++++++++++++----------------------
 drivers/gpu/drm/v3d/v3d_drv.c     |  43 +----------
 drivers/gpu/drm/v3d/v3d_drv.h     |  17 -----
 drivers/gpu/drm/v3d/v3d_gem.c     | 120 +++---------------------------
 drivers/gpu/drm/v3d/v3d_irq.c     |  17 ++---
 drivers/gpu/drm/v3d/v3d_perfmon.c |  10 +--
 drivers/gpu/drm/v3d/v3d_power.c   |   1 -
 drivers/gpu/drm/v3d/v3d_regs.h    |  43 ++---------
 drivers/gpu/drm/v3d/v3d_sched.c   |  18 ++---
 drivers/gpu/drm/v3d/v3d_submit.c  |  13 ----
 11 files changed, 100 insertions(+), 338 deletions(-)

diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
index 6a33e0ab30de..864bedfd1ce2 100644
--- a/drivers/gpu/drm/v3d/Kconfig
+++ b/drivers/gpu/drm/v3d/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_V3D
-	tristate "Broadcom V3D 3.x and newer"
+	tristate "Broadcom V3D 4.2 and newer"
 	depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
 	depends on DRM
 	depends on COMMON_CLK
@@ -10,5 +10,5 @@ config DRM_V3D
 	select DRM_GEM_SHMEM_HELPER
 	help
 	  Choose this option if you have a system that has a Broadcom
-	  V3D 3.x or newer GPUs. SoCs supported include the BCM2711,
-	  BCM7268 and BCM7278.
+	  V3D 4.2 or newer GPU. SoCs supported include the BCM2711
+	  and BCM2712.
diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index 634cc796ba23..938622c730d0 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright (C) 2014-2018 Broadcom */
 
-#include <linux/circ_buf.h>
-#include <linux/ctype.h>
-#include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/seq_file.h>
-#include <linux/string_helpers.h>
+#include <linux/string_choices.h>
 
 #include <drm/drm_debugfs.h>
 #include <drm/drm_print.h>
@@ -22,73 +20,68 @@ struct v3d_reg_def {
 };
 
 static const struct v3d_reg_def v3d_hub_reg_defs[] = {
-	REGDEF(V3D_GEN_33, V3D_GEN_42, V3D_HUB_AXICFG),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_HUB_UIFCFG),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_HUB_IDENT0),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_HUB_IDENT1),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_HUB_IDENT2),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_HUB_IDENT3),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_HUB_INT_STS),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_HUB_INT_MSK_STS),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_HUB_AXICFG),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_HUB_UIFCFG),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_HUB_IDENT0),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_HUB_IDENT1),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_HUB_IDENT2),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_HUB_IDENT3),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_HUB_INT_STS),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_HUB_INT_MSK_STS),
 
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_MMU_CTL),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_MMU_VIO_ADDR),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_MMU_VIO_ID),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_MMU_DEBUG_INFO),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_MMU_CTL),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_MMU_VIO_ADDR),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_MMU_VIO_ID),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_MMU_DEBUG_INFO),
 
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_GMP_STATUS(71)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_GMP_CFG(71)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_GMP_VIO_ADDR(71)),
-};
-
-static const struct v3d_reg_def v3d_gca_reg_defs[] = {
-	REGDEF(V3D_GEN_33, V3D_GEN_33, V3D_GCA_SAFE_SHUTDOWN),
-	REGDEF(V3D_GEN_33, V3D_GEN_33, V3D_GCA_SAFE_SHUTDOWN_ACK),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_GMP_STATUS(V3D_GEN_71)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_GMP_CFG(V3D_GEN_71)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_GMP_VIO_ADDR(V3D_GEN_71)),
 };
 
 static const struct v3d_reg_def v3d_core_reg_defs[] = {
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CTL_IDENT0),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CTL_IDENT1),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CTL_IDENT2),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CTL_MISCCFG),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CTL_INT_STS),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CTL_INT_MSK_STS),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CLE_CT0CS),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CLE_CT0CA),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CLE_CT0EA),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CLE_CT1CS),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CLE_CT1CA),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_CLE_CT1EA),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CTL_IDENT0),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CTL_IDENT1),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CTL_IDENT2),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CTL_MISCCFG),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CTL_INT_STS),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CTL_INT_MSK_STS),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CLE_CT0CS),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CLE_CT0CA),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CLE_CT0EA),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CLE_CT1CS),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CLE_CT1CA),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CLE_CT1EA),
 
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_PTB_BPCA),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_PTB_BPCS),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_PTB_BPCA),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_PTB_BPCS),
 
-	REGDEF(V3D_GEN_33, V3D_GEN_42, V3D_GMP_STATUS(33)),
-	REGDEF(V3D_GEN_33, V3D_GEN_42, V3D_GMP_CFG(33)),
-	REGDEF(V3D_GEN_33, V3D_GEN_42, V3D_GMP_VIO_ADDR(33)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_GMP_STATUS(V3D_GEN_42)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_GMP_CFG(V3D_GEN_42)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_GMP_VIO_ADDR(V3D_GEN_42)),
 
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_ERR_FDBGO),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_ERR_FDBGB),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_ERR_FDBGS),
-	REGDEF(V3D_GEN_33, V3D_GEN_71, V3D_ERR_STAT),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_ERR_FDBGO),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_ERR_FDBGB),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_ERR_FDBGS),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_ERR_STAT),
 };
 
 static const struct v3d_reg_def v3d_csd_reg_defs[] = {
-	REGDEF(V3D_GEN_41, V3D_GEN_71, V3D_CSD_STATUS),
-	REGDEF(V3D_GEN_41, V3D_GEN_42, V3D_CSD_CURRENT_CFG0(41)),
-	REGDEF(V3D_GEN_41, V3D_GEN_42, V3D_CSD_CURRENT_CFG1(41)),
-	REGDEF(V3D_GEN_41, V3D_GEN_42, V3D_CSD_CURRENT_CFG2(41)),
-	REGDEF(V3D_GEN_41, V3D_GEN_42, V3D_CSD_CURRENT_CFG3(41)),
-	REGDEF(V3D_GEN_41, V3D_GEN_42, V3D_CSD_CURRENT_CFG4(41)),
-	REGDEF(V3D_GEN_41, V3D_GEN_42, V3D_CSD_CURRENT_CFG5(41)),
-	REGDEF(V3D_GEN_41, V3D_GEN_42, V3D_CSD_CURRENT_CFG6(41)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG0(71)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG1(71)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG2(71)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG3(71)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG4(71)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG5(71)),
-	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG6(71)),
+	REGDEF(V3D_GEN_42, V3D_GEN_71, V3D_CSD_STATUS),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_CSD_CURRENT_CFG0(V3D_GEN_42)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_CSD_CURRENT_CFG1(V3D_GEN_42)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_CSD_CURRENT_CFG2(V3D_GEN_42)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_CSD_CURRENT_CFG3(V3D_GEN_42)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_CSD_CURRENT_CFG4(V3D_GEN_42)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_CSD_CURRENT_CFG5(V3D_GEN_42)),
+	REGDEF(V3D_GEN_42, V3D_GEN_42, V3D_CSD_CURRENT_CFG6(V3D_GEN_42)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG0(V3D_GEN_71)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG1(V3D_GEN_71)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG2(V3D_GEN_71)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG3(V3D_GEN_71)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG4(V3D_GEN_71)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG5(V3D_GEN_71)),
+	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_CSD_CURRENT_CFG6(V3D_GEN_71)),
 	REGDEF(V3D_GEN_71, V3D_GEN_71, V3D_V7_CSD_CURRENT_CFG7),
 };
 
@@ -112,15 +105,6 @@ static int v3d_v3d_debugfs_regs(struct seq_file *m, void *unused)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(v3d_gca_reg_defs); i++) {
-		const struct v3d_reg_def *def = &v3d_gca_reg_defs[i];
-
-		if (v3d->ver >= def->min_ver && v3d->ver <= def->max_ver) {
-			seq_printf(m, "%s (0x%04x): 0x%08x\n",
-				   def->name, def->reg, V3D_GCA_READ(def->reg));
-		}
-	}
-
 	for (core = 0; core < v3d->cores; core++) {
 		for (i = 0; i < ARRAY_SIZE(v3d_core_reg_defs); i++) {
 			const struct v3d_reg_def *def = &v3d_core_reg_defs[i];
@@ -210,8 +194,6 @@ static int v3d_v3d_debugfs_ident(struct seq_file *m, void *unused)
 		if (v3d->ver <= V3D_GEN_42) {
 			seq_printf(m, "  BCG int:      %d\n",
 				   (ident2 & V3D_IDENT2_BCG_INT) != 0);
-		}
-		if (v3d->ver < V3D_GEN_41) {
 			seq_printf(m, "  Override TMU: %d\n",
 				   (misccfg & V3D_MISCCFG_OVRTMUOUT) != 0);
 		}
@@ -244,29 +226,21 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 	struct drm_device *dev = entry->dev;
 	struct v3d_dev *v3d = to_v3d_dev(dev);
 	uint32_t cycles;
-	int core = 0;
-	int measure_ms = 1000;
+	const int measure_ms = 1000;
+	int core = 0, cycle_count_src;
 	int ret;
 
 	ret = v3d_pm_runtime_get(v3d);
 	if (ret)
 		return ret;
 
-	if (v3d->ver >= V3D_GEN_41) {
-		int cycle_count_reg = V3D_PCTR_CYCLE_COUNT(v3d->ver);
-		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_SRC_0_3,
-			       V3D_SET_FIELD_VER(cycle_count_reg,
-						 V3D_PCTR_S0, v3d->ver));
-		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_CLR, 1);
-		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_EN, 1);
-	} else {
-		V3D_CORE_WRITE(core, V3D_V3_PCTR_0_PCTRS0,
-			       V3D_PCTR_CYCLE_COUNT(v3d->ver));
-		V3D_CORE_WRITE(core, V3D_V3_PCTR_0_CLR, 1);
-		V3D_CORE_WRITE(core, V3D_V3_PCTR_0_EN,
-			       V3D_V3_PCTR_0_EN_ENABLE |
-			       1);
-	}
+	/* Check v3d_perfmon.c to see all possible data sources. */
+	cycle_count_src = v3d->ver >= V3D_GEN_71 ? 0 : 0x20;
+	V3D_CORE_WRITE(core, V3D_PCTR_0_SRC_0_3,
+		       V3D_SET_FIELD_VER(cycle_count_src, V3D_PCTR_S0, v3d->ver));
+	V3D_CORE_WRITE(core, V3D_PCTR_0_CLR, 1);
+	V3D_CORE_WRITE(core, V3D_PCTR_0_EN, 1);
+
 	msleep(measure_ms);
 	cycles = V3D_CORE_READ(core, V3D_PCTR_0_PCTR0);
 
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index b790be8a7fac..0551e9abf17e 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -22,15 +22,12 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sched/clock.h>
 #include <linux/reset.h>
 
 #include <drm/drm_drv.h>
-#include <drm/drm_managed.h>
 #include <drm/drm_print.h>
-#include <uapi/drm/v3d_drm.h>
 
 #include "v3d_drv.h"
 #include "v3d_regs.h"
@@ -98,20 +95,10 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->param) {
 	case DRM_V3D_PARAM_SUPPORTS_TFU:
-		args->value = 1;
-		return 0;
 	case DRM_V3D_PARAM_SUPPORTS_CSD:
-		args->value = v3d_has_csd(v3d);
-		return 0;
 	case DRM_V3D_PARAM_SUPPORTS_CACHE_FLUSH:
-		args->value = 1;
-		return 0;
 	case DRM_V3D_PARAM_SUPPORTS_PERFMON:
-		args->value = (v3d->ver >= V3D_GEN_41);
-		return 0;
 	case DRM_V3D_PARAM_SUPPORTS_MULTISYNC_EXT:
-		args->value = 1;
-		return 0;
 	case DRM_V3D_PARAM_SUPPORTS_CPU_QUEUE:
 		args->value = 1;
 		return 0;
@@ -299,8 +286,6 @@ static const struct drm_driver v3d_drm_driver = {
 static const struct of_device_id v3d_of_match[] = {
 	{ .compatible = "brcm,2711-v3d", .data = (void *)V3D_GEN_42 },
 	{ .compatible = "brcm,2712-v3d", .data = (void *)V3D_GEN_71 },
-	{ .compatible = "brcm,7268-v3d", .data = (void *)V3D_GEN_33 },
-	{ .compatible = "brcm,7278-v3d", .data = (void *)V3D_GEN_41 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, v3d_of_match);
@@ -348,25 +333,11 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (v3d->ver < V3D_GEN_41) {
-		ret = map_regs(v3d, &v3d->gca_regs, "gca");
-		if (ret)
-			return ret;
-	}
-
-	v3d->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	v3d->reset = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(v3d->reset))
 		return dev_err_probe(dev, PTR_ERR(v3d->reset),
 				     "Failed to get reset control\n");
 
-	if (!v3d->reset) {
-		ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
-		if (ret) {
-			dev_err(dev, "Failed to get bridge registers\n");
-			return ret;
-		}
-	}
-
 	v3d->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(v3d->clk))
 		return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n");
@@ -421,18 +392,6 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	 */
 	WARN_ON(v3d->ver != gen);
 
-	/* V3D 3.3 and V3D 4.1 has had no in-tree userspace since Mesa
-	 * dropped support in 2024 (MR#25851) and they have no known users.
-	 * Due to that, support is scheduled for removal in the next release.
-	 */
-	if (v3d->ver <= V3D_GEN_41) {
-		dev_warn(dev,
-			 "V3D %u.%u support is deprecated and will be removed "
-			 "in the next kernel release. If you rely on this hardware, "
-			 "please report it to dri-devel@lists.freedesktop.org.\n",
-			 v3d->ver / 10, v3d->ver % 10);
-	}
-
 	v3d->cores = V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_NCORES);
 	WARN_ON(v3d->cores > 1); /* multicore not yet implemented */
 
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 3bccb35eda25..522b43caef72 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -111,8 +111,6 @@ struct v3d_perfmon {
 };
 
 enum v3d_gen {
-	V3D_GEN_33 = 33,
-	V3D_GEN_41 = 41,
 	V3D_GEN_42 = 42,
 	V3D_GEN_71 = 71,
 };
@@ -140,8 +138,6 @@ struct v3d_dev {
 
 	void __iomem *hub_regs;
 	void __iomem *core_regs[3];
-	void __iomem *bridge_regs;
-	void __iomem *gca_regs;
 	void __iomem *sms_regs;
 	struct clk *clk;
 	struct reset_control *reset;
@@ -248,12 +244,6 @@ to_v3d_dev(struct drm_device *dev)
 	return container_of(dev, struct v3d_dev, drm);
 }
 
-static inline bool
-v3d_has_csd(struct v3d_dev *v3d)
-{
-	return v3d->ver >= V3D_GEN_41;
-}
-
 #define v3d_to_pdev(v3d) to_platform_device((v3d)->drm.dev)
 
 /* The per-fd struct, which tracks the MMU mappings. */
@@ -304,12 +294,6 @@ to_v3d_fence(struct dma_fence *fence)
 #define V3D_READ(offset) readl(v3d->hub_regs + offset)
 #define V3D_WRITE(offset, val) writel(val, v3d->hub_regs + offset)
 
-#define V3D_BRIDGE_READ(offset) readl(v3d->bridge_regs + offset)
-#define V3D_BRIDGE_WRITE(offset, val) writel(val, v3d->bridge_regs + offset)
-
-#define V3D_GCA_READ(offset) readl(v3d->gca_regs + offset)
-#define V3D_GCA_WRITE(offset, val) writel(val, v3d->gca_regs + offset)
-
 #define V3D_SMS_IDLE				0x0
 #define V3D_SMS_ISOLATING_FOR_RESET		0xa
 #define V3D_SMS_RESETTING			0xb
@@ -624,7 +608,6 @@ void v3d_init_hw_state(struct v3d_dev *v3d);
 int v3d_gem_init(struct drm_device *dev);
 void v3d_gem_destroy(struct drm_device *dev);
 void v3d_idle_axi(struct v3d_dev *v3d, int core);
-void v3d_idle_gca(struct v3d_dev *v3d);
 void v3d_reset_sms(struct v3d_dev *v3d);
 void v3d_reset(struct v3d_dev *v3d);
 void v3d_invalidate_caches(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 04ff073cc0d4..3d35d1fa6732 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -4,11 +4,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/reset.h>
-#include <linux/sched/signal.h>
-#include <linux/uaccess.h>
 
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
@@ -17,25 +13,6 @@
 #include "v3d_regs.h"
 #include "v3d_trace.h"
 
-static void
-v3d_init_core(struct v3d_dev *v3d, int core)
-{
-	/* Set OVRTMUOUT, which means that the texture sampler uniform
-	 * configuration's tmu output type field is used, instead of
-	 * using the hardware default behavior based on the texture
-	 * type.  If you want the default behavior, you can still put
-	 * "2" in the indirect texture state's output_type field.
-	 */
-	if (v3d->ver < V3D_GEN_41)
-		V3D_CORE_WRITE(core, V3D_CTL_MISCCFG, V3D_MISCCFG_OVRTMUOUT);
-
-	/* Whenever we flush the L2T cache, we always want to flush
-	 * the whole thing.
-	 */
-	V3D_CORE_WRITE(core, V3D_CTL_L2TFLSTA, 0);
-	V3D_CORE_WRITE(core, V3D_CTL_L2TFLEND, ~0);
-}
-
 void
 v3d_idle_axi(struct v3d_dev *v3d, int core)
 {
@@ -61,55 +38,6 @@ v3d_idle_axi(struct v3d_dev *v3d, int core)
 	}
 }
 
-void
-v3d_idle_gca(struct v3d_dev *v3d)
-{
-	if (v3d->ver >= V3D_GEN_41)
-		return;
-
-	V3D_GCA_WRITE(V3D_GCA_SAFE_SHUTDOWN, V3D_GCA_SAFE_SHUTDOWN_EN);
-
-	if (wait_for((V3D_GCA_READ(V3D_GCA_SAFE_SHUTDOWN_ACK) &
-		      V3D_GCA_SAFE_SHUTDOWN_ACK_ACKED) ==
-		     V3D_GCA_SAFE_SHUTDOWN_ACK_ACKED, 100)) {
-		drm_err(&v3d->drm, "Failed to wait for safe GCA shutdown\n");
-	}
-}
-
-static void
-v3d_reset_by_bridge(struct v3d_dev *v3d)
-{
-	int version = V3D_BRIDGE_READ(V3D_TOP_GR_BRIDGE_REVISION);
-
-	if (V3D_GET_FIELD(version, V3D_TOP_GR_BRIDGE_MAJOR) == 2) {
-		V3D_BRIDGE_WRITE(V3D_TOP_GR_BRIDGE_SW_INIT_0,
-				 V3D_TOP_GR_BRIDGE_SW_INIT_0_V3D_CLK_108_SW_INIT);
-		V3D_BRIDGE_WRITE(V3D_TOP_GR_BRIDGE_SW_INIT_0, 0);
-
-		/* GFXH-1383: The SW_INIT may cause a stray write to address 0
-		 * of the unit, so reset it to its power-on value here.
-		 */
-		V3D_WRITE(V3D_HUB_AXICFG, V3D_HUB_AXICFG_MAX_LEN_MASK);
-	} else {
-		WARN_ON_ONCE(V3D_GET_FIELD(version,
-					   V3D_TOP_GR_BRIDGE_MAJOR) != 7);
-		V3D_BRIDGE_WRITE(V3D_TOP_GR_BRIDGE_SW_INIT_1,
-				 V3D_TOP_GR_BRIDGE_SW_INIT_1_V3D_CLK_108_SW_INIT);
-		V3D_BRIDGE_WRITE(V3D_TOP_GR_BRIDGE_SW_INIT_1, 0);
-	}
-}
-
-static void
-v3d_reset_v3d(struct v3d_dev *v3d)
-{
-	if (v3d->reset)
-		reset_control_reset(v3d->reset);
-	else
-		v3d_reset_by_bridge(v3d);
-
-	v3d_init_hw_state(v3d);
-}
-
 void
 v3d_reset_sms(struct v3d_dev *v3d)
 {
@@ -136,17 +64,15 @@ v3d_reset(struct v3d_dev *v3d)
 
 	trace_v3d_reset_begin(dev);
 
-	/* XXX: only needed for safe powerdown, not reset. */
-	if (false)
-		v3d_idle_axi(v3d, 0);
-
 	v3d_irq_disable(v3d);
 
-	v3d_idle_gca(v3d);
 	v3d_reset_sms(v3d);
-	v3d_reset_v3d(v3d);
 
+	reset_control_reset(v3d->reset);
+
+	v3d_init_hw_state(v3d);
 	v3d_mmu_set_page_table(v3d);
+
 	v3d_irq_reset(v3d);
 
 	/* Re-arm the global perfmon HW counters that the reset zeroed. */
@@ -155,36 +81,6 @@ v3d_reset(struct v3d_dev *v3d)
 	trace_v3d_reset_end(dev);
 }
 
-static void
-v3d_flush_l3(struct v3d_dev *v3d)
-{
-	if (v3d->ver < V3D_GEN_41) {
-		u32 gca_ctrl = V3D_GCA_READ(V3D_GCA_CACHE_CTRL);
-
-		V3D_GCA_WRITE(V3D_GCA_CACHE_CTRL,
-			      gca_ctrl | V3D_GCA_CACHE_CTRL_FLUSH);
-
-		if (v3d->ver < V3D_GEN_33) {
-			V3D_GCA_WRITE(V3D_GCA_CACHE_CTRL,
-				      gca_ctrl & ~V3D_GCA_CACHE_CTRL_FLUSH);
-		}
-	}
-}
-
-/* Invalidates the (read-only) L2C cache.  This was the L2 cache for
- * uniforms and instructions on V3D 3.2.
- */
-static void
-v3d_invalidate_l2c(struct v3d_dev *v3d, int core)
-{
-	if (v3d->ver >= V3D_GEN_33)
-		return;
-
-	V3D_CORE_WRITE(core, V3D_CTL_L2CACTL,
-		       V3D_L2CACTL_L2CCLR |
-		       V3D_L2CACTL_L2CENA);
-}
-
 /* Invalidates texture L2 cachelines */
 static void
 v3d_flush_l2t(struct v3d_dev *v3d, int core)
@@ -266,8 +162,6 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
 	 * an invalidated cacheline back in, we wouldn't leave stale
 	 * data in the inner cache.
 	 */
-	v3d_flush_l3(v3d);
-	v3d_invalidate_l2c(v3d, 0);
 	v3d_flush_l2t(v3d, 0);
 	v3d_invalidate_slices(v3d, 0);
 }
@@ -276,7 +170,11 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
 void
 v3d_init_hw_state(struct v3d_dev *v3d)
 {
-	v3d_init_core(v3d, 0);
+	/* Whenever we flush the L2T cache, we always want to flush
+	 * the whole thing.
+	 */
+	V3D_CORE_WRITE(0, V3D_CTL_L2TFLSTA, 0);
+	V3D_CORE_WRITE(0, V3D_CTL_L2TFLEND, ~0);
 }
 
 static void
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 963d711dc16b..b0752988c63d 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -181,7 +181,7 @@ v3d_hub_irq(int irq, void *arg)
 			u32 begin;
 			u32 end;
 			const char *client;
-		} v3d41_axi_ids[] = {
+		} v3d42_axi_ids[] = {
 			{0x00, 0x20, "L2T"},
 			{0x20, 0x21, "PTB"},
 			{0x40, 0x41, "PSE"},
@@ -202,12 +202,11 @@ v3d_hub_irq(int irq, void *arg)
 			{0x7F, 0x80, "GMP"},
 		};
 		const char *client = "?";
+		size_t i;
 
 		V3D_WRITE(V3D_MMU_CTL, V3D_READ(V3D_MMU_CTL));
 
 		if (v3d->ver >= V3D_GEN_71) {
-			size_t i;
-
 			axi_id = axi_id & 0x7F;
 			for (i = 0; i < ARRAY_SIZE(v3d71_axi_ids); i++) {
 				if (axi_id >= v3d71_axi_ids[i].begin &&
@@ -216,14 +215,12 @@ v3d_hub_irq(int irq, void *arg)
 					break;
 				}
 			}
-		} else if (v3d->ver >= V3D_GEN_41) {
-			size_t i;
-
+		} else {
 			axi_id = axi_id & 0xFF;
-			for (i = 0; i < ARRAY_SIZE(v3d41_axi_ids); i++) {
-				if (axi_id >= v3d41_axi_ids[i].begin &&
-				    axi_id < v3d41_axi_ids[i].end) {
-					client = v3d41_axi_ids[i].client;
+			for (i = 0; i < ARRAY_SIZE(v3d42_axi_ids); i++) {
+				if (axi_id >= v3d42_axi_ids[i].begin &&
+				    axi_id < v3d42_axi_ids[i].end) {
+					client = v3d42_axi_ids[i].client;
 					break;
 				}
 			}
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index c00f18d4a425..8e21ce9a639f 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -243,11 +243,11 @@ static void v3d_perfmon_hw_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmo
 		i++;
 		channel |= V3D_SET_FIELD_VER(i < ncounters ? perfmon->counters[i] : 0,
 					     V3D_PCTR_S3, v3d->ver);
-		V3D_CORE_WRITE(0, V3D_V4_PCTR_0_SRC_X(source), channel);
+		V3D_CORE_WRITE(0, V3D_PCTR_0_SRC_X(source), channel);
 	}
 
-	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, mask);
-	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_CLR, mask);
+	V3D_CORE_WRITE(0, V3D_PCTR_0_EN, mask);
+	V3D_CORE_WRITE(0, V3D_PCTR_0_CLR, mask);
 	V3D_CORE_WRITE(0, V3D_PCTR_0_OVERFLOW, mask);
 }
 
@@ -258,7 +258,7 @@ static void v3d_perfmon_hw_capture(struct v3d_dev *v3d, struct v3d_perfmon *perf
 	for (int i = 0; i < perfmon->ncounters; i++)
 		perfmon->values[i] += V3D_CORE_READ(0, V3D_PCTR_0_PCTRX(i));
 
-	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_CLR, mask);
+	V3D_CORE_WRITE(0, V3D_PCTR_0_CLR, mask);
 }
 
 static void v3d_perfmon_hw_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
@@ -267,7 +267,7 @@ static void v3d_perfmon_hw_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon
 	if (capture)
 		v3d_perfmon_hw_capture(v3d, perfmon);
 
-	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, 0);
+	V3D_CORE_WRITE(0, V3D_PCTR_0_EN, 0);
 }
 
 void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
diff --git a/drivers/gpu/drm/v3d/v3d_power.c b/drivers/gpu/drm/v3d/v3d_power.c
index f608e6d5516a..da071958a68c 100644
--- a/drivers/gpu/drm/v3d/v3d_power.c
+++ b/drivers/gpu/drm/v3d/v3d_power.c
@@ -58,7 +58,6 @@ int v3d_power_suspend(struct device *dev)
 
 	/* Wait until V3D has no active or pending AXI transactions. */
 	v3d_idle_axi(v3d, 0);
-	v3d_idle_gca(v3d);
 
 	ret = v3d_suspend_sms(v3d);
 	if (ret) {
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index cb37270964b8..ab3f12779dd0 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -73,29 +73,6 @@
 # define V3D_HUB_INT_TFUC                              BIT(1)
 # define V3D_HUB_INT_TFUF                              BIT(0)
 
-/* GCA registers only exist in V3D < 41 */
-#define V3D_GCA_CACHE_CTRL                             0x0000c
-# define V3D_GCA_CACHE_CTRL_FLUSH                      BIT(0)
-
-#define V3D_GCA_SAFE_SHUTDOWN                          0x000b0
-# define V3D_GCA_SAFE_SHUTDOWN_EN                      BIT(0)
-
-#define V3D_GCA_SAFE_SHUTDOWN_ACK                      0x000b4
-# define V3D_GCA_SAFE_SHUTDOWN_ACK_ACKED               3
-
-# define V3D_TOP_GR_BRIDGE_REVISION                    0x00000
-# define V3D_TOP_GR_BRIDGE_MAJOR_MASK                  V3D_MASK(15, 8)
-# define V3D_TOP_GR_BRIDGE_MAJOR_SHIFT                 8
-# define V3D_TOP_GR_BRIDGE_MINOR_MASK                  V3D_MASK(7, 0)
-# define V3D_TOP_GR_BRIDGE_MINOR_SHIFT                 0
-
-/* 7268 reset reg */
-# define V3D_TOP_GR_BRIDGE_SW_INIT_0                   0x00008
-# define V3D_TOP_GR_BRIDGE_SW_INIT_0_V3D_CLK_108_SW_INIT BIT(0)
-/* 7278 reset reg */
-# define V3D_TOP_GR_BRIDGE_SW_INIT_1                   0x0000c
-# define V3D_TOP_GR_BRIDGE_SW_INIT_1_V3D_CLK_108_SW_INIT BIT(0)
-
 #define V3D_TFU_CS(ver) ((ver >= 71) ? 0x00700 : 0x00400)
 
 /* Stops current job, empties input fifo. */
@@ -258,6 +235,7 @@
 #define V3D_CTL_MISCCFG                                0x00018
 # define V3D_CTL_MISCCFG_QRMAXCNT_MASK                 V3D_MASK(3, 1)
 # define V3D_CTL_MISCCFG_QRMAXCNT_SHIFT                1
+/* Only V3D 4.x */
 # define V3D_MISCCFG_OVRTMUOUT                         BIT(0)
 
 #define V3D_CTL_L2CACTL                                0x00020
@@ -362,22 +340,15 @@
 # define V3D_PTB_BXCF_RWORDERDISA                      BIT(1)
 # define V3D_PTB_BXCF_CLIPDISA                         BIT(0)
 
-#define V3D_V3_PCTR_0_EN                               0x00674
-#define V3D_V3_PCTR_0_EN_ENABLE                        BIT(31)
-#define V3D_V4_PCTR_0_EN                               0x00650
+#define V3D_PCTR_0_EN                                  0x00650
 /* When a bit is set, resets the counter to 0. */
-#define V3D_V3_PCTR_0_CLR                              0x00670
-#define V3D_V4_PCTR_0_CLR                              0x00654
+#define V3D_PCTR_0_CLR                                 0x00654
 #define V3D_PCTR_0_OVERFLOW                            0x00658
 
-#define V3D_V3_PCTR_0_PCTRS0                           0x00684
-#define V3D_V3_PCTR_0_PCTRS15                          0x00660
-#define V3D_V3_PCTR_0_PCTRSX(x)                        (V3D_V3_PCTR_0_PCTRS0 + \
-							4 * (x))
 /* Each src reg muxes four counters each. */
-#define V3D_V4_PCTR_0_SRC_0_3                          0x00660
-#define V3D_V4_PCTR_0_SRC_28_31                        0x0067c
-#define V3D_V4_PCTR_0_SRC_X(x)                         (V3D_V4_PCTR_0_SRC_0_3 + \
+#define V3D_PCTR_0_SRC_0_3                             0x00660
+#define V3D_PCTR_0_SRC_28_31                           0x0067c
+#define V3D_PCTR_0_SRC_X(x)                            (V3D_PCTR_0_SRC_0_3 + \
 							4 * (x))
 # define V3D_PCTR_S0_MASK(ver) (((ver) >= 71) ? V3D_MASK(7, 0) : V3D_MASK(6, 0))
 # define V3D_PCTR_S0_SHIFT(ver)                        0
@@ -388,8 +359,6 @@
 # define V3D_PCTR_S3_MASK(ver) (((ver) >= 71) ? V3D_MASK(31, 24) : V3D_MASK(30, 24))
 # define V3D_PCTR_S3_SHIFT(ver)                        24
 
-#define V3D_PCTR_CYCLE_COUNT(ver) ((ver >= 71) ? 0 : 32)
-
 /* Output values of the counters. */
 #define V3D_PCTR_0_PCTR0                               0x00680
 #define V3D_PCTR_0_PCTR31                              0x006fc
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index f29d79b15be3..f915052c63d8 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -19,7 +19,6 @@
  */
 
 #include <linux/sched/clock.h>
-#include <linux/kthread.h>
 
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
@@ -887,17 +886,14 @@ v3d_sched_init(struct v3d_dev *v3d)
 	if (ret)
 		goto fail;
 
-	if (v3d_has_csd(v3d)) {
-		ret = v3d_queue_sched_init(v3d, &v3d_csd_sched_ops, V3D_CSD,
-					   "v3d_csd");
-		if (ret)
-			goto fail;
+	ret = v3d_queue_sched_init(v3d, &v3d_csd_sched_ops, V3D_CSD, "v3d_csd");
+	if (ret)
+		goto fail;
 
-		ret = v3d_queue_sched_init(v3d, &v3d_cache_clean_sched_ops,
-					   V3D_CACHE_CLEAN, "v3d_cache_clean");
-		if (ret)
-			goto fail;
-	}
+	ret = v3d_queue_sched_init(v3d, &v3d_cache_clean_sched_ops,
+				   V3D_CACHE_CLEAN, "v3d_cache_clean");
+	if (ret)
+		goto fail;
 
 	ret = v3d_queue_sched_init(v3d, &v3d_cpu_sched_ops, V3D_CPU, "v3d_cpu");
 	if (ret)
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index eada30a31701..101bd2880fcb 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -11,7 +11,6 @@
 #include <drm/drm_syncobj.h>
 
 #include "v3d_drv.h"
-#include "v3d_regs.h"
 #include "v3d_trace.h"
 
 /* Takes the reservation lock on all the BOs being referenced, so that
@@ -694,8 +693,6 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 				struct drm_v3d_extension __user *ext,
 				struct v3d_cpu_job *job)
 {
-	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
-	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct drm_v3d_indirect_csd indirect_csd;
 	struct v3d_indirect_csd_info *info = &job->indirect_csd;
 
@@ -705,11 +702,6 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	if (copy_from_user(&indirect_csd, ext, sizeof(indirect_csd)))
 		return -EFAULT;
 
-	if (!v3d_has_csd(v3d)) {
-		drm_warn(&v3d->drm, "Attempting CSD submit on non-CSD hardware.\n");
-		return -EINVAL;
-	}
-
 	job->job_type = V3D_CPU_JOB_TYPE_INDIRECT_CSD;
 	info->args = indirect_csd.submit;
 	info->offset = indirect_csd.offset;
@@ -1375,11 +1367,6 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	if (args->pad)
 		return -EINVAL;
 
-	if (!v3d_has_csd(submit.v3d)) {
-		drm_warn(dev, "Attempting CSD submit on non-CSD hardware\n");
-		return -EINVAL;
-	}
-
 	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
 		drm_dbg(dev, "invalid flags: %d\n", args->flags);
 		return -EINVAL;

-- 
2.56.0

