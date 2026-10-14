Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F866C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E03710FF0F;
	Wed, 14 Oct 2026 17:31:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 577AF10FF0F;
 Wed, 14 Oct 2026 17:31:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE2D86053E;
 Wed, 14 Oct 2026 17:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0589C1F000C5;
 Wed, 14 Oct 2026 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999083;
 bh=1nTZebj/18br3VixciTz/xishBdsp2hlXOIKNqMV3sE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ASSfrY7efemVsRDq7AGHnlJjMQcurETdyoKJRkCRRGayl09q4vBlQZnN8aWYiddu9
 EdO0GzhKqQ0aC15VM040X+Fsp8OErQ+DEHegh8E6c2Nju1ZsEQs6sV+etinzesWYcC
 71Jvj78Ll0w0A//vcpA875q1slPiZXmGTjXW6kWqJX7C3UiBwYTxVfrMAVCFIDSMk+
 eJG1gq0xcLElP0a23sOwqJKv8cHY2TuayUztCDOFGK6VO1wS0tiVoo50cQX6PjG2qz
 nYjHx0NuNfBNUqqVH4ykoPJef4BQrH5doI1XTAdxzv1TV6NTyxkUGwSeAZcLW8jKxN
 ySGKDkHa1Znvg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:32 +0200
Subject: [PATCH 69/75] drm/i915: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-69-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2rmOSWxLhH/98vwoJV4gIexrvUvgfNL1bumepyVc2BE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd2f0vv3+4v0TxXNh87OMQxg9tdXUL6i/OaYof1rmA
 XtHsMP5jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR+kTGhsfzs/e+rn7xp4M5
 sDHtn4DDJG7XYyefNRc1y3+I4l0oy7XgwOVr79sUrz/P+rvxIId1JWND2wrOY5cj3EwDg2M1669
 JMJ4vjDRR8JFdsVreVWJm93Hl+60Kr79P/WcVLR6dt8wnMBMA
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

The i915 connector initialization uses
__drm_atomic_helper_connector_reset() to set up the initial state
during connector allocation. However, it only needs to initialize
the state, not reset it.

Switch to __drm_atomic_helper_connector_state_init() and assign
connector->state explicitly, matching what atomic_create_state
expects.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
---
 drivers/gpu/drm/i915/display/intel_connector.c | 6 ++++--
 drivers/gpu/drm/i915/display/intel_sdvo.c      | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/drm/i915/display/intel_connector.c
index 7ef9338d67ab..ed38959b466d 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.c
+++ b/drivers/gpu/drm/i915/display/intel_connector.c
@@ -88,12 +88,14 @@ static int intel_connector_init(struct intel_connector *connector)
 	 */
 	conn_state = kzalloc_obj(*conn_state);
 	if (!conn_state)
 		return -ENOMEM;
 
-	__drm_atomic_helper_connector_reset(&connector->base,
-					    &conn_state->base);
+	__drm_atomic_helper_connector_state_init(&conn_state->base,
+						 &connector->base);
+
+	connector->base.state = &conn_state->base;
 
 	intel_panel_init_alloc(connector);
 
 	INIT_WORK(&connector->modeset_retry_work,
 		  intel_connector_modeset_retry_work_fn);
diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 3075ef04df56..7b97f531acbf 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -2788,12 +2788,14 @@ static struct intel_sdvo_connector *intel_sdvo_connector_alloc(void)
 	if (!conn_state) {
 		kfree(sdvo_connector);
 		return NULL;
 	}
 
-	__drm_atomic_helper_connector_reset(&sdvo_connector->base.base,
-					    &conn_state->base.base);
+	__drm_atomic_helper_connector_state_init(&conn_state->base.base,
+						 &sdvo_connector->base.base);
+
+	sdvo_connector->base.base.state = &conn_state->base.base;
 
 	intel_panel_init_alloc(&sdvo_connector->base);
 
 	return sdvo_connector;
 }

-- 
2.55.0

