Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B1606A693
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=CfAe3cwF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E2D10F081;
	Tue, 24 Nov 2026 18:18:41 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D958610F4C1;
 Tue, 24 Nov 2026 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=D7JA+BoRaYJZx0QyhqSrwwX2UENwQBXvChgno1UYrqI=;
 t=1795544311; x=2110904311; b=CfAe3cwFT9rk4L90kxA9SYCysoY80S8hMrGILT3eR9+NnoP
 6PB33GSApoM39hNGG5o9l2GYVT1C+UcGu9h6Hro6eE2k8cM+07HC3UWUmBYP52nEAmBcqjMoReV0X
 m9DY4ShLueG0+InPmiRb9E3SKJKKK72YCpXaUkinOKrUlT8QwGWyfOvvG9PN1BpFdtwU9MuFrKFxy
 Jra8h2PHWD6jJNlQ/MedFLrxTlydu8rwWc6HKCzOWup/XGdX2evBqdoOgxp1kTL1iiNc/lPm4zqlH
 1eGQ9+JYCz+WfqkywS6XQCi1ca4FCnhKxESaptOCN0QAHnwwHshSGupLvyj6vbVQ==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5x-00000003axM-1Su3; Tue, 24 Nov 2026 19:18:21 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 nfraprado@collabora.com, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Daniel Stone <daniels@collabora.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 14/19] drm/atomic: set hidden CRTC color mgmt model to
 default values
Date: Tue, 24 Nov 2026 19:03:31 +0100
Message-ID: <20261124181652.1333986-15-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Userspace sees a single CRTC color management model: the colorop
pipeline if DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE is set, or CRTC color
properties otherwise. When the other model is hidden, CRTC still holds
its previous property settings and, without visibility, the userspace
cannot clear it anymore.

Reset the hidden model to its default value on every CRTC included in an
atomic commit: clear blobs if colorop pipeline, and set COLOR_PIPELINE
to Bypass if CRTC color properties are in place. Colorop values aren't
touched, so re-selecting a pipeline later restores them. Only set
color_mgmt_changed flag when something was actually reset.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- new patch, as for planes, drivers now decide from
  crtc_state->color_pipeline between colorop or CRTC color properties
  and the core sets the properties of the model hidden from the client to
  their defaults.
---
 drivers/gpu/drm/drm_atomic_uapi.c | 28 ++++++++++++++++++++++++++++
 include/drm/drm_crtc.h            |  6 ++++--
 include/uapi/drm/drm.h            |  4 ++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 0a597b9e8005..ca711353fc48 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1695,6 +1695,32 @@ static void complete_signaling(struct drm_device *dev,
 	kfree(fence_state);
 }
 
+static void
+reset_crtc_color_mgmt_props(struct drm_atomic_commit *state,
+			    struct drm_file *file_priv,
+			    bool async_flip)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	bool changed;
+	int i;
+
+	/* Async page flip doesn't change properties */
+	if (async_flip)
+		return;
+
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		if (file_priv->crtc_color_pipeline) {
+			changed = drm_property_replace_blob(&crtc_state->degamma_lut, NULL);
+			changed |= drm_property_replace_blob(&crtc_state->ctm, NULL);
+			changed |= drm_property_replace_blob(&crtc_state->gamma_lut, NULL);
+		} else {
+			changed = drm_atomic_set_colorop_for_crtc(crtc_state, NULL);
+		}
+		crtc_state->color_mgmt_changed |= changed;
+	}
+}
+
 static void
 set_async_flip(struct drm_atomic_commit *state)
 {
@@ -1853,6 +1879,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 		drm_mode_object_put(obj);
 	}
 
+	reset_crtc_color_mgmt_props(state, file_priv, async_flip);
+
 	ret = prepare_signaling(dev, state, arg, file_priv, &fence_state,
 				&num_fences);
 	if (ret)
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index aba579cef6b6..166e80284bdf 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -277,8 +277,10 @@ struct drm_crtc_state {
 	/**
 	 * @color_pipeline:
 	 *
-	 * The first colorop of the active color pipeline, or NULL, if no
-	 * color pipeline is active.
+	 * The first colorop of the active color pipeline, or NULL, if no color
+	 * pipeline is active. Drivers program CRTC color management from this
+	 * pipeline when it is set, and from @degamma_lut, @ctm and @gamma_lut
+	 * properties otherwise.
 	 */
 	struct drm_colorop *color_pipeline;
 
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 514c8f4b3aaf..08bd616774a4 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -915,6 +915,10 @@ struct drm_get_cap {
  * - DEGAMMA_LUT
  * - CTM
  *
+ * Userspace can only see one CRTC color management model. On every CRTC
+ * included in an atomic commit, the DRM core resets CRTC color properties of
+ * the hidden model to default values.
+ *
  * The client must enable &DRM_CLIENT_CAP_ATOMIC first.
  *
  * This client cap can only be set if the driver sets the corresponding driver
-- 
2.53.0

