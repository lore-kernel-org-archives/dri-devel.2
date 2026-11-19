Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88448606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N1QPIKHg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002721127EF;
	Thu, 19 Nov 2026 23:44:50 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4524A1127EF;
 Thu, 19 Nov 2026 23:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795131886; x=1826667886;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ld7fiPYN1Wy1vb2ijLUDZVrER4eq/U6P/98fhJSBncU=;
 b=N1QPIKHg0L/Znhh2T4knSbIzrS0++R96QQehCeMFYWqm7ZnFfkMqvzQx
 /MXipClXMtzY4z4qFlKKQHGqEse39cMv48T9/PxvOszyXRJ9Axw605WYi
 n1TgC8RAshTvJ1X01IxlnmPa6MoH/VLm7WFXI6XOvhpxUpaXNzbjKUwl7
 qgiMfMb37DL3BTeJ1PtLgwWZYI3plxdQj5n34D8jCh2FbJnBdnaymzbtK
 V4Es+2WDsHG1DSiEtsGzkSpmEDOWi9VAgWclW3QDpGVbKO2s1j84BSZRk
 wmxki0UNbXOGmh42ZKpLHqRQ1PpIPEaI4uIzuIDdfl87Ur+AieutHjcwM g==;
X-CSE-ConnectionGUID: CR5yLAMxSl6X9O3Ka39oMg==
X-CSE-MsgGUID: 8ObBe2weQb6QRMZ0SqVSvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3923960"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3923960"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 15:44:34 -0800
X-CSE-ConnectionGUID: KcxaTHm+SQuVKrcVc/WyYQ==
X-CSE-MsgGUID: Wwt6ZtijSMauYQKS6Gob6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10788951"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.202])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 15:44:31 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 2/2] drm/atomic: Prefer drm_WARN_ON() over WARN_ON() in
 drm_atomic_get_*_state()
Date: Fri, 20 Nov 2026 01:44:23 +0200
Message-ID: <20261119234423.11666-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119234423.11666-1-ville.syrjala@linux.intel.com>
References: <20261119234423.11666-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Change all the get_state() acquire_ctx WARNs to use drm_WARN_ON()
instead of WARN_ON() so we get to know which device triggered it.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index b0843e5a9e4d..324e79152e17 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -473,7 +473,7 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
 	int ret;
 	struct drm_crtc_state *crtc_state;
 
-	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, !state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
@@ -666,7 +666,7 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 	int ret;
 	struct drm_plane_state *plane_state;
 
-	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, !state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
 	/* the legacy pointers should never be set */
@@ -741,7 +741,7 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
 	int ret;
 	struct drm_colorop_state *colorop_state;
 
-	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, !state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
 	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
@@ -1144,7 +1144,7 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 	int ret;
 	struct drm_private_state *obj_state;
 
-	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, !state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
 	obj_state = drm_atomic_get_new_private_obj_state(state, obj);
@@ -1459,7 +1459,7 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 	struct drm_mode_config *config = &connector->dev->mode_config;
 	struct drm_connector_state *connector_state;
 
-	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, !state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
 	ret = drm_modeset_lock(&config->connection_mutex, state->acquire_ctx);
-- 
2.56.0

