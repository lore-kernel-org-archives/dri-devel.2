Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBB5CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5ABB10FEA9;
	Wed, 14 Oct 2026 17:28:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E60710FEC2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1290760229;
 Wed, 14 Oct 2026 17:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFA11F000C4;
 Wed, 14 Oct 2026 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998915;
 bh=5+RnXRfH4Exzq3rrliAZzUB20lj4/vqS8DjKvoH98y8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=INGJ2dHvWxnNWt2Te5RpOFiKPWNpUlNqZ+FS+020OzsByesfch0qib/RzqxwKHay4
 JK9AcguLtagoXA5t4AlTAeCf3dd1+qK/DzukSvgJ7d12yLa9u0p8c9rWZJX5zhD8W/
 lNeutafG0tyBi6UUcXgv+8QNIGbyqpsHRgdiUvlCxrGdL+abDBZx9NA/ndsplhKTii
 r+9iWQgM1edDt/NrzG9MXk/B+lZ8t+qptkeY6A4HZvl4KAP8vMqQylKvOafhJNsi2z
 bMhS79CY2wqlkCQISaDDyYwQFx4leElKsSEufVHudMcDbWqynq+vUB7nMTKzbZLVcf
 i78r+7KYHpWHQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:46 +0200
Subject: [PATCH 23/75] drm/hisilicon: hibmc: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-23-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Yongbang Shi <shiyongbang@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=mripard@kernel.org;
 h=from:subject:message-id; bh=S0OhEwuDKBIldeiTZvq1Jc03bBHjKGNId5Cyh2N+3gk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4dEuZSta42ItV/7tDpCuPrz/YV7I1e5h7Ev/xHc8
 2nft2XhHVNYGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiLL6M9YHfvzLb7ko78vvq
 p7At7Z9XJMuKN4rVx60x+5vd9P3mluNneaZLtW97O9m05/OC6a93xTCWcN2cf0bgVMq5jVweuif
 eaLa9ffhh+4LmRUw5jywm9U0KlNKQ/nyBJ8pPQcKM9eGaqs8A
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

The hisilicon: hibmc connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Yongbang Shi <shiyongbang@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c   | 2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 2e9403b8bf3c..06624ea1fb4c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -135,11 +135,11 @@ static void hibmc_dp_early_unregister(struct drm_connector *connector)
 
 	hibmc_dp_disable_int(dp);
 }
 
 static const struct drm_connector_funcs hibmc_dp_conn_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.late_register = hibmc_dp_late_register,
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index b9bd6d33fb0f..fac0ce32c190 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -81,11 +81,11 @@ static const struct drm_connector_helper_funcs
 };
 
 static const struct drm_connector_funcs hibmc_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = hibmc_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 int hibmc_vdac_init(struct hibmc_drm_private *priv)

-- 
2.55.0

