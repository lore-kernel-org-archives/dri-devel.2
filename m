Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C2CCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A6110FEE1;
	Wed, 14 Oct 2026 17:29:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC7810FEE4
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6360860229;
 Wed, 14 Oct 2026 17:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEF91F000C5;
 Wed, 14 Oct 2026 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998981;
 bh=sy9flvNnrcv8BFedHItQhDhxuYujmjn8cLW751fYdzs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EBqXc9ZQ2O6lYZan7+euGZeh0+BeK4e2MP+6CQ6baLW8ol6sZl3CK2djY14V3WhXh
 fpxhoYDinGCyf6irJTxcCQpAaMM1+N65QbqMf/t0i5dvF0BjJg/+TUbQiHLbvdT5TG
 aVaRy+cKk3vT6PuZVaEOpNGKwnRJiqbVpBrxohJX5r5NRxZtCbMSnMFrXgiYAavauf
 jeSNmeKRcyXGEt66SJHYyqmNiLNLR3yRf9veiJBhlsLpZ6N7SRzYol3edeVT3WRR58
 PyblvWmvyQ6MZlqA3+TAc2nzQ5bn6rQTUCTtnzZL4Ttt4YXNar7B5dW8yZaDUVLbl/
 ngcN1t44S0jIw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:04 +0200
Subject: [PATCH 41/75] drm/tests: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-41-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4311; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0G6vU9DaVG3VCJawtanZSsSMubg5dubF8ZaI71hl1B4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8cwZPF2aOk8ZD/ozGImOYl7ZorR2ZzkFc9/qDNNs
 I1dIqXZMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDaEi1MAJnJtD2N9LesnhkvbIgRVmVQN
 l98vEshWTmt/caZB8tcMNx6Nq33bF6/mWzeD/2JfYVbZn0tT/55krBVvPsSz9KLDm+PpJ5sOG+p
 292z3sVmo0/jYqb3216nVt4+vrvwctmXqvcSl2rODs13zOwA=
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

The tests connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_atomic_commit_test.c | 2 +-
 drivers/gpu/drm/tests/drm_atomic_test.c        | 2 +-
 drivers/gpu/drm/tests/drm_connector_test.c     | 4 ++--
 drivers/gpu/drm/tests/drm_probe_helper_test.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index ff69bade19b8..1121246dbb9f 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -51,11 +51,11 @@ static const struct drm_encoder_helper_funcs drm_atomic_test_encoder_funcs = {
 };
 
 static const struct drm_connector_funcs dummy_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 };
 
 static int drm_atomic_test_dummy_get_modes(struct drm_connector *connector)
 {
 	return drm_connector_helper_get_modes_fixed(connector,
diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/tests/drm_atomic_test.c
index ea91bec6569e..e9f8f4fbdc4b 100644
--- a/drivers/gpu/drm/tests/drm_atomic_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_test.c
@@ -23,11 +23,11 @@ static const struct drm_connector_helper_funcs drm_atomic_init_connector_helper_
 };
 
 static const struct drm_connector_funcs drm_atomic_init_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 };
 
 static struct drm_atomic_test_priv *create_device(struct kunit *test)
 {
 	struct drm_atomic_test_priv *priv;
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 3368aedd4e66..0d8d3462d024 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -48,11 +48,11 @@ static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs = {
 };
 
 static const struct drm_connector_funcs dummy_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 };
 
 static int dummy_ddc_xfer(struct i2c_adapter *adapter,
 			  struct i2c_msg *msgs, int num)
 {
@@ -202,11 +202,11 @@ static struct kunit_suite drmm_connector_init_test_suite = {
 };
 
 static const struct drm_connector_funcs dummy_dynamic_init_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.destroy		= drm_connector_cleanup,
 };
 
 /*
  * Test that the initialization of a bog standard dynamic connector works
diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/drm/tests/drm_probe_helper_test.c
index db0e4f5df275..38485d42dddb 100644
--- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
@@ -25,11 +25,11 @@ static const struct drm_connector_helper_funcs drm_probe_helper_connector_helper
 };
 
 static const struct drm_connector_funcs drm_probe_helper_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 };
 
 static int drm_probe_helper_test_init(struct kunit *test)
 {
 	struct drm_probe_helper_test_priv *priv;

-- 
2.55.0

