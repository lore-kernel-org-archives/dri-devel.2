Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAEFC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F121210FEC4;
	Wed, 14 Oct 2026 17:28:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C017810FEBD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8E7E429FD;
 Wed, 14 Oct 2026 17:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C6D1F000C5;
 Wed, 14 Oct 2026 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998908;
 bh=OILZmv9y/fVkx2Fm9G+55bfV5ppnmSyKiLBGlvCyxcQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jH9g7WNc8DN7xnORmG9kDsVMvPvnbQ4keo6dpZwbjewtxbTgumRWPWcnkn/7Xehbk
 uPrE7BXSuN3Yhx6G0ssXBPHylDj0b/tJDIJ/dpC/c03b7zTtr21OtPEHzPPny0bJW+
 C7AWIvsthVUn4FOmTwzUi2m+59fgJ9wW/JmFpzLrexi2ZR+hEhNzs6ZO8KQA3roMFU
 osBrdvMOS+Th9EL6RWfKRFBqbk/ot4H8QlbFbI3FA9MbABow1O+J2cn4YLSmj+7cGn
 rUNhdK3hmXb10RUIuyg6b9iZT7DJnk9yG3YvqjJ6lnrOGs/j9gzt7uReo4w3eXhwsI
 jpgOLR5H+Zufw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:44 +0200
Subject: [PATCH 21/75] drm/exynos: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-21-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qn3k3FOdcpzaM6GfmVkx8rFrmH800I05g1866GM0xEA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndwf/1TU8oTlFPyLCskqyUa6L0/NpbePbPvuATIdfG
 T8bG3k6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwEReCjLW+z3Ujdetlt974GfY
 X/YrfvuNvKqzgyZcvZL6P2f7sYsu5mdfXIz+/Ep86unDFi0xe7bMYKyPevpHysa98P+UesUIb8d
 m9eXxzPU5upWKVz+l75VvXftP9HMi47bnfD2VD2/ECq3xVAQA
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

The exynos connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 74d3a2bebb74..42c48fd14050 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -54,11 +54,11 @@ static void exynos_dpi_connector_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs exynos_dpi_connector_funcs = {
 	.detect = exynos_dpi_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = exynos_dpi_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int exynos_dpi_get_modes(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 077571eae9d6..f3e8a2bc1182 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -332,11 +332,11 @@ static void vidi_connector_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs vidi_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = vidi_detect,
 	.destroy = vidi_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int vidi_get_modes(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 055dc04f9b3e..654a8b1b4afc 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -873,11 +873,11 @@ static void hdmi_connector_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs hdmi_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = hdmi_detect,
 	.destroy = hdmi_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int hdmi_get_modes(struct drm_connector *connector)

-- 
2.55.0

