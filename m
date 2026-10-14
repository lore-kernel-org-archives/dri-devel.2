Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B39CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2C610FF0B;
	Wed, 14 Oct 2026 17:31:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5091310FF0B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:31:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38CCC40AE8;
 Wed, 14 Oct 2026 17:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967AD1F000C4;
 Wed, 14 Oct 2026 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999065;
 bh=OzbDlC6w3TjvdrQIwaQfjgT/r6gF5nuTjwfaTQMGr8w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Z/hWaErIzH+bYjzKoowucsBD+CUdA4lLSN8ltZ/BApLTyWa8Pa4cBmQW7Yxng9uLW
 xvvxpDEpuZzAS6y2R+XkaVvuQhyjrXqeeSko9WZIsNR1NtpmyTq9mXIKK1MsSSVbX+
 w2jO+T4rGm3MYQyn6CQ8htC5xu9/QWJ/lRzlg74ouSzh0Yxgn/UincemXUOB2arAkS
 rZPMQuRW1NdYuQJIilxq6zgRspHnNrgCr7V1zE19w4XVWhFv2OsP934jKSpp5xYexy
 RiaFbUtGF7eo8R16+mcazWXCaBa5r2AX+SPUCNT5WgTZBvUll3bhHPQNzZTqesYRk9
 1Nmdv12Y1ETfg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:27 +0200
Subject: [PATCH 64/75] drm/vc4: vec: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-64-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2374; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UnCSKaKjLoA4uCc/dww9q2wqc3YQE6AYQQy9GrvHo4M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd6c9eZvzW1/NMbRtAeOB6aYtex14Su3fF5r9ffVuk
 +JKXoknHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAivX6MDTs8g+e7+09n/rn7
 o6DSoRb2ho0OsxmfnOrsndTSqLf20/uWaKvQ6/rSnQbdk5J/TjpXw9hwx3HJmSt3M7t27bvF/GJ
 SWvjHV6zVYjyi75/VF5edX6hwq+R+yCf3FSvLf+u15HzzTSkDAA==
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

The vc4 VEC connector reset implementation creates a pristine state
and initializes the analog TV properties. It does not perform any
hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_vec.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index 98cece1e48d8..43124ffc7349 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -376,14 +376,22 @@ static enum drm_connector_status
 vc4_vec_connector_detect(struct drm_connector *connector, bool force)
 {
 	return connector_status_unknown;
 }
 
-static void vc4_vec_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+vc4_vec_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	drm_atomic_helper_connector_tv_state_init(connector->state, connector);
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	drm_atomic_helper_connector_tv_state_init(connector_state, connector);
+
+	return connector_state;
 }
 
 static int
 vc4_vec_connector_set_property(struct drm_connector *connector,
 			       struct drm_connector_state *state,
@@ -488,11 +496,11 @@ vc4_vec_connector_get_property(struct drm_connector *connector,
 }
 
 static const struct drm_connector_funcs vc4_vec_connector_funcs = {
 	.detect = vc4_vec_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = vc4_vec_connector_reset,
+	.atomic_create_state = vc4_vec_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_get_property = vc4_vec_connector_get_property,
 	.atomic_set_property = vc4_vec_connector_set_property,
 };

-- 
2.55.0

