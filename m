Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B260CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE1610E192;
	Wed, 14 Oct 2026 17:27:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB20D10FE7D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B427D43668;
 Wed, 14 Oct 2026 17:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142411F000C4;
 Wed, 14 Oct 2026 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998850;
 bh=XCEs4HiwOfD+U76GjJVnbW2687wo/+K5ZM3/XEWH3c8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VIyc49ZM28DVr8QD/ojPKC35DrtiVabN8LYCffNrfyQYb2ltPILc1nE39LT7Zclsi
 E2IN8DTwHxh/OwvKl8AqavNJW3dZaY9WkT/TwnhlcMQra+m10TfzCgW+Wt5vRrdzcv
 FiRgghFQxh9Rf8VRaN84tyDO3q86BoD4jbP1Ecw1rrIs6JNynndK5b8CL1VtFdeyGH
 5kMCZN8mEw96V9axrJWSFr+0w5IeyplYC/XXNepd+6Ey9/aG9+GhtlLYNO52j+yrBP
 /U0hZKWEY58x7kM5qvtUAdyKv4pikSTSep9JahlwOsPdrJzq8EceKasq+JOmuiLDWw
 KeVI32Wp/QMvg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:28 +0200
Subject: [PATCH 05/75] drm/arm: komeda: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-5-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7++md8d5rKESR10CRVcqVLFwSqB8eTKqtFpM+QpA4O0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd/vI93+el2y8LiDrD2PO4QlrdeREDd7MedHA80HeN
 2Xz5aolHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAif18w1vvdf6d88LWm+4Wt
 i8zUr4nd0c+YcU/U0uVD2BFDbfHZa0VObxc7WB7W/CWSVTL03+ZVSYz1np8K52x02/C+TMvj5uT
 glvY/4tZ8/NMXmmzev/23XErfr/XHs7s3+IWvlp41//T6jF/FAA==
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

The arm: komeda connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 4872253a2449..f394971c0edb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -126,11 +126,11 @@ static void komeda_wb_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 	kfree(to_kconn(to_wb_conn(connector)));
 }
 
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.detect			= komeda_wb_connector_detect,
 	.fill_modes		= komeda_wb_connector_fill_modes,
 	.destroy		= komeda_wb_connector_destroy,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

