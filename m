Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF3310775E4
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B348510E04C;
	Wed, 18 Mar 2026 16:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="L6lDMJDe";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EC710E047;
 Wed, 18 Mar 2026 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VRjBxEfA94hgkY31ePZpayLg0V25SVeJZleCG6D+bSU=; b=L6lDMJDeZoRcI4uAKsuskRdCWh
 k8E2/oTIJEeGmm0uhSGmy1It+zpgKwjRiK7uykYS1x81Gs9PI3Sj+v+ffqtQJApyKl6t3l/QHaQnf
 8ttIGHGvXnuhsZagBISeWcvvoPg/xS2nHjwhz+PdrzRWCjM8QI5KHN8WAH8T8opnypAt8miWS4711
 EEyQsNFJc5SHZdXuxPHmb+MVW5yF6ar66JWMLaW4YFv39QjecpJCjq+0ty760wTjwvdpiamvFKUwk
 yHKJRUJPVWw4UREeNMItRYcYfpaao3468Uy0VlUOrYhEeat2Lu2dW9BKmb7FXoTVtmsrBsqM3ySxd
 /oWLPXyw==;
Received: from [186.208.74.38] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w2tsq-002t89-Tt; Wed, 18 Mar 2026 17:36:37 +0100
From: Melissa Wen <mwen@igalia.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, contact@emersion.fr,
 sebastian.wick@redhat.com, harry.wentland@amd.com, mwen@igalia.com,
 daniels@collabora.com
Cc: Alex Hung <alex.hung@amd.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, Xaver Hugl <xaver.hugl@kde.org>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/drm_atomic: duplicate colorop states if plane color
 pipeline in use
Date: Wed, 18 Mar 2026 13:27:11 -0300
Message-ID: <20260318163629.300627-1-mwen@igalia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For suspend/resume to work correctly, do for colorop state the same we
do for plane/crtc/connector states: duplicate the state of colorops in a
color pipeline if it's in use by a given plane when suspending and
restore cached colorop states when resuming.

Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---

Changes from v1 (https://lore.kernel.org/dri-devel/20260316210055.234498-1-mwen@igalia.com/):
- keep the object hierarchy (Chaitanya)
- add r-b from Harry, Alex H. and Chaitanya (pending to confirm)

Chaitanya,

I kept the fix for unused-variable warning together because the warning
only appears with this new usage of for_each_new_colorop_in_state() in
drm_atomic_helper_commit_duplicated_state() here. Let me know if you
don't agree with this approach.

Melissa 

---
 drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
 include/drm/drm_atomic.h            |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 26953ed6b53e..481f92a03683 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3751,6 +3751,13 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 			err = PTR_ERR(plane_state);
 			goto free;
 		}
+
+		if (plane_state->color_pipeline) {
+			err = drm_atomic_add_affected_colorops(state, plane);
+			if (err)
+				goto free;
+		}
+
 	}
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
@@ -3856,6 +3863,8 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 	int i, ret;
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	struct drm_connector *connector;
 	struct drm_connector_state *new_conn_state;
 	struct drm_crtc *crtc;
@@ -3863,6 +3872,9 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 
 	state->acquire_ctx = ctx;
 
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i)
+		state->colorops[i].old_state = colorop->state;
+
 	for_each_new_plane_in_state(state, plane, new_plane_state, i)
 		state->planes[i].old_state = plane->state;
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 0b1b32bcd2bd..96fd32a3e92c 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1102,7 +1102,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 		for_each_if ((__state)->colorops[__i].ptr &&		\
 			     ((colorop) = (__state)->colorops[__i].ptr,	\
 			      (void)(colorop) /* Only to avoid unused-but-set-variable warning */, \
-			      (new_colorop_state) = (__state)->colorops[__i].new_state, 1))
+			      (new_colorop_state) = (__state)->colorops[__i].new_state,\
+			      (void)(new_colorop_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update
-- 
2.51.0

