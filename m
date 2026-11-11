Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A64606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZnulfA9B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F37D10FDBA;
	Wed, 11 Nov 2026 16:09:14 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D7010FD98;
 Wed, 11 Nov 2026 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=7iO8yRKiK2KoQa6hRzM46vYrUp4atmnTKqY7wydsfBM=;
 t=1794413340; x=2109773340; b=ZnulfA9BclFj1rztN/UgjUak9LmgNkigRlsNzhVeucMrMwL
 9/Jd5YPWukuhv0N+6+pQNRztnQjG/YVe3PSXR6NC0r4KnthWyeQJEaPm6z9hP/XVpK16oER8vXeHB
 6Bp0i4ZkivVbvYKeTiF1AgrDEEGpEMQp8dfqYs33tNgiCdrVc/3kiC8k9znOCdFv218R7dB5ggNUE
 E9JnCk8yIzFcUI2iOMxULfuucCpGoPWkQUAQggCWQCM5Dy2grpQHcKsDtRnbBJGRlBhMknyl+Jv+P
 oZHwFBWiqrjBDkbtJ0eYFKic77Lby/I6usI+T7j2h5aS94K/TTmcB1LzJcyuUIbA==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsI-008u8Y-8x; Wed, 11 Nov 2026 17:08:38 +0100
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
Subject: [PATCH v5 08/15] drm/atomic: check if an active colorop has a blob if
 its type requires one
Date: Wed, 11 Nov 2026 17:05:21 +0100
Message-ID: <20261111160814.21326-9-mwen@igalia.com>
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

If colorop TYPE requires a data blob, userspace have to set a blob
whenever enables this colorop, i.e. when setting this colorop bypass
property to false. Clarify this in the documentation and reject the
atomic commit if colorop TYPE requires a DATA but set bypass to false
and no blob submitted.

Fixes: e5719e7f1900 ("drm/colorop: Add 3x4 CTM type")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic.c  | 22 ++++++++++++++++++++--
 drivers/gpu/drm/drm_colorop.c |  5 ++++-
 include/drm/drm_colorop.h     |  6 ++++--
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 36c9550c2749..d8b56fa47d45 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -990,8 +990,13 @@ drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
  * drm_atomic_colorop_check - check new colorop state
  * @new_colorop_state: new colorop state to check
  *
- * Ensure that the colorop in @new_colorop_state belongs to an active color
- * pipeline, i.e. it's in the chain of colorops set to the color_pipeline
+ * Check that a colorop whose TYPE requires a data blob has one when it's
+ * enabled, i.e. userspace can't clear (or never set) the DATA property while
+ * taking the colorop out of bypass, since drivers would have nothing to
+ * program.
+ *
+ * Also ensure that the colorop in @new_colorop_state belongs to an active
+ * color pipeline, i.e. it's in the chain of colorops set to the color_pipeline
  * property of current, old or new plane state.
  *
  * Userspace is allowed to finalize colorop's settings in the same commit that
@@ -1015,6 +1020,19 @@ static int drm_atomic_colorop_check(const struct drm_colorop_state *new_colorop_
 	if (state->duplicated)
 		return 0;
 
+	/*
+	 * Reject if colorop TYPE requires a DATA but set bypass to false and
+	 * no blob submitted
+	 */
+	if (new_colorop_state->colorop->data_property &&
+	    !new_colorop_state->bypass && !new_colorop_state->data) {
+		drm_dbg_atomic(new_colorop_state->colorop->dev,
+			       "[COLOROP:%d:%d] enabled without a DATA blob\n",
+			       new_colorop_state->colorop->base.id,
+			       new_colorop_state->colorop->type);
+		return -EINVAL;
+	}
+
 	/* Not a plane colorop */
 	if (!plane)
 		return 0;
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 95da03d6c65c..842fd7dc31e6 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -55,7 +55,10 @@
  * enumerated 1D curves, 1D LUTs, 3D LUTs, matrices, etc. See the
  * &drm_colorop_type documentation for information on each type.
  *
- * If a colorop advertises the BYPASS property it can be bypassed.
+ * If a colorop advertises the BYPASS property it can be bypassed. If a
+ * colorop advertises DATA and BYPASS properties, BYPASS can only be set to
+ * false if DATA contains a blob. An atomic commit that leaves such a
+ * colorop enabled without a blob will fail, returning -EINVAL.
  *
  * Information about colorop and color pipeline design decisions can be
  * found at rfc/color_pipeline.rst, but note that this document will
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 11a88e9477f1..952c30b06d83 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -283,8 +283,10 @@ struct drm_colorop_state {
 	/**
 	 * @data:
 	 *
-	 * Data blob for any TYPE that requires such a blob. The
-	 * interpretation of the blob is TYPE-specific.
+	 * Data blob for any TYPE that requires such a blob. The interpretation
+	 * of the blob is TYPE-specific. Whenever @bypass is false, @data must
+	 * be provided; otherwise, the atomic check will reject an active
+	 * colorop without a blob.
 	 *
 	 * See the &drm_colorop_type documentation for how blob is laid
 	 * out.
-- 
2.53.0

