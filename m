Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF9BCC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4958110FF09;
	Wed, 14 Oct 2026 17:31:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E20710FEE4
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EBDFA40AE8;
 Wed, 14 Oct 2026 17:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8B01F000C4;
 Wed, 14 Oct 2026 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999057;
 bh=nxU/fVgc0591RZMWuVx49WJFc16INbXtODl+oNe9tcE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jctdmN+5hBhgwRAxgU0WIXHuWw5moM6Rkz+0/B12b/OAr2H1tyOAuB7VeT9/zeAtf
 vyiVJMDJltQyuAvvTdtjhIi4QTrPZC7MMI18jgIyLf4/0dXniCqsizHhnQrsa/4ccF
 Gc2i/o98LbR0Po0ApRtdCZ+gs6b7egTT1oUHwuXLcQoiQpgqOYDORJo6He8hidyn9/
 yCwW/r8wor4clY71D4QjIiQk+Lx0zFogUB0UnQmKhTfyAZgbWRrnWmKj/td+g+jd4T
 /Xdsp1ZVmI98YSahP529qDdRvhKizKg/jmB4KMPwBJYN0adgmLBLBzcWzfXO8ScJkZ
 QgemRMke7UFIw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:25 +0200
Subject: [PATCH 62/75] drm/tests: hdmi: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-62-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WemldWYpPNF/e5KS89JaxtgWpuW1zOj7BmwHaB8O4qA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd6f+XCapMXmvR+wtoYDH5+bH/V7CXlVYvjzD9PmZL
 zyH+c/KdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJJAkzNkz+EhN/ttlLimf9
 +4Kzkz/FLb35YMfvMpYF26d3b36QnDutp9D5iuqk6shjzxTcHG9skWGss37Gp2/8+IDFq71PUlS
 2br6T/HNf49WDZ29a9rVvCcvRvFe3sOuerFJn64s4U8aFCyXCAA==
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

The test HDMI connector reset implementation creates a pristine
state and initializes the HDMI state. It does not perform any
hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index b2e347863a77..ae7b009052c2 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -197,21 +197,30 @@ static const struct drm_connector_helper_funcs dummy_connector_helper_funcs = {
 	.atomic_check	= drm_atomic_helper_connector_hdmi_check,
 	.get_modes	= dummy_connector_get_modes,
 	.mode_valid	= drm_hdmi_connector_mode_valid,
 };
 
-static void dummy_hdmi_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+dummy_hdmi_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	__drm_atomic_helper_connector_hdmi_state_init(connector,
+						      connector_state);
+
+	return connector_state;
 }
 
 static const struct drm_connector_funcs dummy_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
-	.reset			= dummy_hdmi_connector_reset,
+	.atomic_create_state	= dummy_hdmi_connector_create_state,
 };
 
 static void test_encoder_atomic_enable(struct drm_encoder *encoder,
 			      struct drm_atomic_commit *state)
 {

-- 
2.55.0

