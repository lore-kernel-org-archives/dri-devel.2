Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3377606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=f+Sze4Tq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A981C10FDD1;
	Wed, 11 Nov 2026 16:09:14 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2BC10FDC4;
 Wed, 11 Nov 2026 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=KzLgvnnVCJQM8XoZgFKkHIxCpzTPL6wyxLCKsZPvLxA=;
 t=1794413344; x=2109773344; b=f+Sze4TqAEEyuMQw5v6IyVNhsD2Z4B4VBWummx+2nCvhHc+
 NgFk3QvHWVSiiClIPOczDUbFoZI4G1wmAVvd8ThLsa1k5h2uv3wbXxJ1sHKhmQx8lz+zvaaGHfSqF
 N5ukeisS7XdACCgxbH6bGGqwsFdYjRJGy0GQoJeukl6hO4DQh/OOk6gvgBKAr1ava0Qp5plaW/a0q
 vd9xd1h56C7pIeXvlUFcpOPeWhKHql27Fhv+ql9lxHgYCZhQF/Nze2b1aEaufa113o3gmAP0uyGOp
 o1X5pgFr1yO3DAf0mKyVaamL7BLbv0nkk7N3G8MXoufepwOnydgkCti9u8H9FbpA==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsO-008u8Y-Q2; Wed, 11 Nov 2026 17:08:44 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 John Harrison <John.Harrison@igalia.com>
Subject: [PATCH v5 14/15] drm/atomic: make drm_atomic_add_affected_colorops()
 static
Date: Wed, 11 Nov 2026 17:05:27 +0100
Message-ID: <20261111160814.21326-15-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160814.21326-1-mwen@igalia.com>
References: <20261111160814.21326-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After refactoring the AMD colorop state lifetime,
drm_atomic_add_affected_colorops() is no longer used anywhere but
drm_atomic_duplicate_state. Move this helper to drm_atomic_helper.c,
make it static and rename to duplicate_plane_colorops for clarity.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic.c        | 46 -------------------------
 drivers/gpu/drm/drm_atomic_helper.c | 52 ++++++++++++++++++++++++++++-
 include/drm/drm_atomic.h            |  4 ---
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index d8b56fa47d45..821e05eb232a 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1888,52 +1888,6 @@ drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
 }
 EXPORT_SYMBOL(drm_atomic_add_affected_planes);
 
-/**
- * drm_atomic_add_affected_colorops - add colorops for plane
- * @state: atomic state
- * @plane: DRM plane
- *
- * This function walks the current configuration and adds all colorops
- * currently used by @plane to the atomic configuration @state. This is useful
- * when an atomic commit also needs to check all currently enabled colorop on
- * @plane, e.g. when changing the mode. It's also useful when re-enabling a plane
- * to avoid special code to force-enable all colorops.
- *
- * Since acquiring a colorop state will always also acquire the w/w mutex of the
- * current plane for that colorop (if there is any) adding all the colorop states for
- * a plane will not reduce parallelism of atomic updates.
- *
- * Returns:
- * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
- * then the w/w mutex code has detected a deadlock and the entire atomic
- * sequence must be restarted. All other errors are fatal.
- */
-int
-drm_atomic_add_affected_colorops(struct drm_atomic_commit *state,
-				 struct drm_plane *plane)
-{
-	struct drm_colorop *colorop;
-	struct drm_colorop_state *colorop_state;
-
-	WARN_ON(!drm_atomic_get_new_plane_state(state, plane));
-
-	drm_dbg_atomic(plane->dev,
-		       "Adding all current colorops for [PLANE:%d:%s] to %p\n",
-		       plane->base.id, plane->name, state);
-
-	drm_for_each_colorop(colorop, plane->dev) {
-		if (colorop->plane != plane)
-			continue;
-
-		colorop_state = drm_atomic_get_colorop_state(state, colorop);
-		if (IS_ERR(colorop_state))
-			return PTR_ERR(colorop_state);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(drm_atomic_add_affected_colorops);
-
 /**
  * drm_atomic_check_only - check whether a given config would work
  * @state: atomic configuration to check
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 60e69061faa9..358b89e93620 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3697,6 +3697,56 @@ void drm_atomic_helper_shutdown(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_atomic_helper_shutdown);
 
+/*
+ * duplicate_plane_colorops - add colorops for plane
+ * @state: atomic state
+ * @plane: DRM plane
+ *
+ * Add the state of each colorop of a given @plane to @state, including
+ * colorops from color pipelines that are not currently active. This duplicated
+ * state is used to restore the hardware state later; furthermore, the
+ * drm_atomic_helper_resume() function, for instance, resets all colorop
+ * states before committing it, and any colorop that is omitted would lose its
+ * settings.
+ *
+ * Use this only in duplicated states: the drm_atomic_check_only() function
+ * rejects colorops from a pipeline that the atomic commit is neither enabling
+ * nor disabling it; this check is only bypassed when state->duplicated is set.
+ *
+ * Since acquiring a colorop state will always also acquire the w/w mutex of the
+ * current plane for that colorop (if there is any) adding all the colorop states for
+ * a plane will not reduce parallelism of atomic updates.
+ *
+ * Returns:
+ * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
+ * then the w/w mutex code has detected a deadlock and the entire atomic
+ * sequence must be restarted. All other errors are fatal.
+ */
+static int
+duplicate_plane_colorops(struct drm_atomic_commit *state,
+			 struct drm_plane *plane)
+{
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *colorop_state;
+
+	WARN_ON(!drm_atomic_get_new_plane_state(state, plane));
+
+	drm_dbg_atomic(plane->dev,
+		       "Adding all colorops for [PLANE:%d:%s] to %p\n",
+		       plane->base.id, plane->name, state);
+
+	drm_for_each_colorop(colorop, plane->dev) {
+		if (colorop->plane != plane)
+			continue;
+
+		colorop_state = drm_atomic_get_colorop_state(state, colorop);
+		if (IS_ERR(colorop_state))
+			return PTR_ERR(colorop_state);
+	}
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_duplicate_state - duplicate an atomic state object
  * @dev: DRM device
@@ -3758,7 +3808,7 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 			goto free;
 		}
 
-		err = drm_atomic_add_affected_colorops(state, plane);
+		err = duplicate_plane_colorops(state, plane);
 		if (err)
 			goto free;
 	}
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..1ba000e392f4 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -937,10 +937,6 @@ drm_atomic_add_affected_connectors(struct drm_atomic_commit *state,
 int __must_check
 drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
 			       struct drm_crtc *crtc);
-int __must_check
-drm_atomic_add_affected_colorops(struct drm_atomic_commit *state,
-				 struct drm_plane *plane);
-
 int __must_check drm_atomic_check_only(struct drm_atomic_commit *state);
 int __must_check drm_atomic_commit(struct drm_atomic_commit *state);
 int __must_check drm_atomic_nonblocking_commit(struct drm_atomic_commit *state);
-- 
2.53.0

