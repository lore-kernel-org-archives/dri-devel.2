Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37346606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dz9MTy4J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87C51128A9;
	Fri, 30 Oct 2026 15:14:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2783711288C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33CFF609D1;
 Fri, 30 Oct 2026 15:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC511F000C1;
 Fri, 30 Oct 2026 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373280;
 bh=sMxhOLkKLnY1Ga+SVnyZYUJPQ8k55rTB2d1bwo4vhSQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dz9MTy4JwMUaJ90vXaMnhx1PMG8uG039Rma2UhHidDMxqNYFCDjjeAZM8Ko65aono
 dUyBAazDL5qxzkaCCvfJN2Cu8VViVgVhJv9tw9/zlOU5kG/ls6rBXn0UibzcAP4PzX
 rVbk3lHXG59sG6VdIQu573T5P5LleMRyY7rVy5uYeWxTPfJz1wPOF6oM/duvao3t20
 KufAbIgZucbYrWZ5CnfUPteb6KU79qNIIw2cznP6dagHWgGaaIGA8fsJVOZRKGIvGo
 y6H79bxVuFULfqFYZiLl/T9e4jTV8AAnfJiSKZdG2AF/Nd4fOXDR2NbLmAtc72txFl
 9uq3Qce4wh0XQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:43 +0100
Subject: [PATCH v3 13/37] drm/loongson: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-13-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=mripard@kernel.org;
 h=from:subject:message-id; bh=04CnTFdbAmu3kbMylezDm9dqVzIsxoGisMyF/K2EURA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtih/XyzwmmGLsZSh/NuVaufzEpUeZvlU9rIwbb3Vr
 LkjO0y5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkigFjfcqEOe4b11tbMq85
 xhVfUtp+apJZmyvnlccWaz4ttyjOkHL5sv2Q7eQayR0/Ly2y1lhtxtjwd27N3WrFml1Cmq/K+s2
 fVSisP3TYO6x4/qam86evbeeoYUh/zb7sD4vdnY9Fhy6KLfQHAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
@@ -96,5 +96,5 @@ static const struct drm_connector_funcs ls7a1000_dpi_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state
diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
index a9798b3dadee..e2255e6a0d32 100644
--- a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
+++ b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
@@ -204,5 +204,5 @@ static const struct drm_connector_funcs ls7a2000_hdmi_connector_funcs[2] = {
 		.fill_modes = drm_helper_probe_single_connector_modes,
 		.destroy = drm_connector_cleanup,
-		.reset = drm_atomic_helper_connector_reset,
+		.atomic_create_state = drm_atomic_helper_connector_create_state,
 		.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 		.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -213,5 +213,5 @@ static const struct drm_connector_funcs ls7a2000_hdmi_connector_funcs[2] = {
 		.fill_modes = drm_helper_probe_single_connector_modes,
 		.destroy = drm_connector_cleanup,
-		.reset = drm_atomic_helper_connector_reset,
+		.atomic_create_state = drm_atomic_helper_connector_create_state,
 		.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 		.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

