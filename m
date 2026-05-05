Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049EECD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE3310E13C;
	Tue,  5 May 2026 18:21:56 +0000 (UTC)
X-Greylist: delayed 510 seconds by postgrey-1.36 at gabe;
 Tue, 05 May 2026 18:21:55 UTC
Received: from MTA-15-3.privateemail.com (MTA-15-3.privateemail.com
 [198.54.122.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B94B10E13C;
 Tue,  5 May 2026 18:21:55 +0000 (UTC)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
 by mta-15.privateemail.com (Postfix) with ESMTP id 4g96Kt5f6Mz3hhTm;
 Tue,  5 May 2026 14:21:54 -0400 (EDT)
Received: from localhost.localdomain
 (bras-base-toroon4332w-grc-26-174-91-51-28.dsl.bell.ca [174.91.51.28])
 by mta-15.privateemail.com (Postfix) with ESMTPA;
 Tue,  5 May 2026 14:21:20 -0400 (EDT)
From: Hamza Mahfooz <someguy@effective-light.com>
To: dri-devel@lists.freedesktop.org
Cc: Hamza Mahfooz <someguy@effective-light.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Takashi Iwai <tiwai@suse.de>, Colin Ian King <colin.i.king@gmail.com>,
 Charlene Liu <charlene.liu@amd.com>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] drm/atomic: attempt full modeset on page flip timeout
Date: Tue,  5 May 2026 14:20:57 -0400
Message-ID: <20260505182105.420525-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

We should try to recover from page flip timeouts. Forcing
a full modeset should be generic across all atomic KMS drivers,
so try that first.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 49 +++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index a768398a1884..7ee9d52f63c5 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1926,6 +1926,43 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
 
+static int force_full_modeset(struct drm_crtc *crtc)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_state *state;
+	int ret;
+	int err;
+
+	if (drm_atomic_crtc_needs_modeset(crtc->state))
+		return -EBUSY;
+
+	DRM_MODESET_LOCK_ALL_BEGIN(crtc->dev, ctx, 0, err);
+	state = drm_atomic_state_alloc(crtc->dev);
+	if (!state)
+		return -ENOMEM;
+
+	state->acquire_ctx = &ctx;
+
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state)) {
+		ret = PTR_ERR(crtc_state);
+		goto out;
+	}
+
+	crtc_state->mode_changed = true;
+
+	drm_info(crtc->dev,
+		 "[CRTC:%d:%s] Attempting force full modeset...\n",
+		 crtc->base.id, crtc->name);
+
+	ret = drm_atomic_commit(state);
+out:
+	drm_atomic_state_put(state);
+	DRM_MODESET_LOCK_ALL_END(crtc->dev, ctx, err);
+	return ret;
+}
+
 /**
  * drm_atomic_helper_wait_for_flip_done - wait for all page flips to be done
  * @dev: DRM device
@@ -1949,17 +1986,23 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
 
 	for (i = 0; i < dev->mode_config.num_crtc; i++) {
 		struct drm_crtc_commit *commit = state->crtcs[i].commit;
-		int ret;
 
 		crtc = state->crtcs[i].ptr;
 
 		if (!crtc || !commit)
 			continue;
 
-		ret = wait_for_completion_timeout(&commit->flip_done, 10 * HZ);
-		if (ret == 0)
+		if (!wait_for_completion_timeout(&commit->flip_done, 10 * HZ)) {
+			int ret;
 			drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
 				crtc->base.id, crtc->name);
+
+			ret = force_full_modeset(crtc);
+			if (ret)
+				drm_err(dev,
+					"[CRTC:%d:%s] force full modeset failed! ret=%d\n",
+					crtc->base.id, crtc->name, ret);
+		}
 	}
 
 	if (state->fake_commit)
-- 
2.54.0

