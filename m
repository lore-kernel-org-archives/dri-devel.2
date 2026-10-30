Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A2606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rv5qMPcX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6EC1128B8;
	Fri, 30 Oct 2026 15:14:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB84411288C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2582419BE;
 Fri, 30 Oct 2026 15:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3794C1F0093A;
 Fri, 30 Oct 2026 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373273;
 bh=2dnnP8Wa81IdUFmqyrsgZbYDGrVfTtadJ9nTlfniJCY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Rv5qMPcXOcIBXSHr8zDwlj+8Zabmn8Bg3IuDpUWASFcLu+huwca8unWbsn0xVs+yH
 2k6RdYLv3fRqFT/RoP9OP4ZakyuyaJsj88cIsy3TF361gUmJ4IymLEyWaX42djIrKu
 AnVJRRcttLZ8xeou4JlTQ0hPjYxgqS8z+k8hYtgjnqI0AQe8vMt2niqIm+z5z49NWf
 fNmW8tq+xKqIjpimfSeXdP48wsEBhILh5mR0u2Dtfjd7dPOAuPTbzq8SN3JSZGwTd3
 93TJ0esyoNcK8yAQBkN73SxMxGf53YrJxM7oD0bcrufULzEJksPdQrq3lFVcDME978
 AykhgtLCJv0cg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:41 +0100
Subject: [PATCH v3 11/37] drm/exynos: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-11-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gmbVcyopCfjI4fWSLHz7Zy9KT93vZwch19EfPTd1/Lc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtij9O3slq+yO6v4nvdpTZDkYtgfKfLBSZjmylE/1j
 7JKzYwTHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiIiGM9Rn3s/S2/e+oWhAt
 YNZ8e39mxcvrjVrld40jedlU9DdvLr3y7c31nZE211K8A0IZzhd5MNbXJxT4GgYcs5K6dKJqX5a
 1HPPFefEs7qd2Z+z+Ni1uvqB4ieIxZS+9lVsKF3LrZwou+wYA
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
@@ -57,5 +57,5 @@ static const struct drm_connector_funcs exynos_dpi_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = exynos_dpi_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 077571eae9d6..f3e8a2bc1182 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -335,5 +335,5 @@ static const struct drm_connector_funcs vidi_connector_funcs = {
 	.detect = vidi_detect,
 	.destroy = vidi_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 055dc04f9b3e..654a8b1b4afc 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -876,5 +876,5 @@ static const struct drm_connector_funcs hdmi_connector_funcs = {
 	.detect = hdmi_detect,
 	.destroy = hdmi_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

