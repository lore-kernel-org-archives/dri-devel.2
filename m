Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BC0CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D48510FEEA;
	Wed, 14 Oct 2026 17:28:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0B310FEB0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81C47429FD;
 Wed, 14 Oct 2026 17:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86D11F000C4;
 Wed, 14 Oct 2026 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998930;
 bh=Akz6hQN2YUvZYPvBNmTl5I05omypO/8ZYEMyxpHlk80=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZfUIDP9uKMYhSqkQPJL9bWu85UHh0HMWzVismQgbZTnZkdJJOjdklAL5i0OnD67EX
 UVmkwhfVLK2Q9POcVwXPPPgChBNdny3Vikbb6OHD9CawnEXcrCR0pGUqZBGPxIcULa
 faT9Eez0Dplt/BfwuSD35DRRp3LtuWlM6ZIotMB3o4g0Kmx9XfS/lysDxA/ucwz08N
 UGZGYizqSQSrXeQihIGSygyCrUvM1IQeZ69vMGFoc8af2OeDsxQM7Dbwgp/tKXxxVw
 r6M3Wv8pWin1HHLpHlPxTBfw5chk77oNtCRp7JxjvwNpuIhGJa0ffBbgWMyojZeS1+
 03dNwB+wZDxLg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:50 +0200
Subject: [PATCH 27/75] drm/loongson: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-27-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PjwcdImhI2udw2OmxYe2lfChhx96/z2YuD8VFay82rM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4f9ftdR+DbrZGGEaN+iNyfuLJ9Qs2KZR3zJ35s+6
 3LClv4v6pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATWanE2LBNmC99m3CWtyH3
 q6tGMSKHrkRFPHmUFbLw1cIgBZmG60yymxPYdu3erXg1dfqqdwHBRxgb3gak/k96Y/jIRb6EVT7
 ifdv559umf7fZ/+snl6KopooIa4bYze8RLEuCCgxvqC2xu6IHAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The loongson connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>
Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: Qianhai Wu <wuqianhai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c | 2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a1000.c b/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
index 5c483baa3762..3d4562353578 100644
--- a/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
+++ b/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
@@ -93,11 +93,11 @@ ls7a1000_dpi_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs ls7a1000_dpi_connector_funcs = {
 	.detect = ls7a1000_dpi_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state
 };
 
 static void ls7a1000_pipe0_encoder_reset(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
index a9798b3dadee..e2255e6a0d32 100644
--- a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
+++ b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
@@ -201,20 +201,20 @@ ls7a2000_hdmi1_connector_detect(struct drm_connector *connector, bool force)
 static const struct drm_connector_funcs ls7a2000_hdmi_connector_funcs[2] = {
 	{
 		.detect = ls7a2000_hdmi0_vga_connector_detect,
 		.fill_modes = drm_helper_probe_single_connector_modes,
 		.destroy = drm_connector_cleanup,
-		.reset = drm_atomic_helper_connector_reset,
+		.atomic_create_state = drm_atomic_helper_connector_create_state,
 		.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 		.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 		.debugfs_init = ls7a2000_hdmi0_late_register,
 	},
 	{
 		.detect = ls7a2000_hdmi1_connector_detect,
 		.fill_modes = drm_helper_probe_single_connector_modes,
 		.destroy = drm_connector_cleanup,
-		.reset = drm_atomic_helper_connector_reset,
+		.atomic_create_state = drm_atomic_helper_connector_create_state,
 		.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 		.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 		.debugfs_init = ls7a2000_hdmi1_late_register,
 	},
 };

-- 
2.55.0

