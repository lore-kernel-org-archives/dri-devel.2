Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917A606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEvjL9RX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB6E1125A3;
	Thu, 22 Oct 2026 12:35:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018A21125AC
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6D5843D5F;
 Thu, 22 Oct 2026 12:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F431F000C1;
 Thu, 22 Oct 2026 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672502;
 bh=sMxhOLkKLnY1Ga+SVnyZYUJPQ8k55rTB2d1bwo4vhSQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MEvjL9RXn4/P6or/0FZ+ZJ25Jy6tkIv9gXrbImsUJzWm2fGSSgcvrglQ92F9Ni5+8
 CGuojTl59jNj7VfpYFzL7IfRj4r96geNou6pvDWcErf3grpJImKExHgEY3X7T9EzLb
 ke6dxAb1Rmgp4v8tpIAMK1UfpV3t7gj8OpvhV4TKSiEDj9NzRSW+hbNSozdCCHIzHV
 SiCamg8DpHCIs/hI1Lb4UGVI1euzqOrcSpfB7lD6tKmPAu3keI7Cj5OmIhpp0F61kE
 9uST4sIK7s/4Vc4Ejr2D0cw3dzZlAVAQ1d2UJIssxrPylj8sIGBB9ol85eRISjM2Vg
 97IAbx20zsOGw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:20 +0200
Subject: [PATCH v2 21/59] drm/loongson: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-21-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mKbtmdJ98yy30Fe+zWFpa5/83h/jF6XhzljtfIjBx
 00oPr6jYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwk0pmx3rPpaP3fjV5zFQXa
 /hTL3jFzSXeYJTDp/yXBFR7z4vJFdKYqiZwttvScGbzrfyMTE/8HxoZ5qn8Fl9zzvP6wI2Ph379
 bH/8srUlJbp5oM+XOTqaH7K76E95evFP90LdGat7NI6weS88CAA==
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

