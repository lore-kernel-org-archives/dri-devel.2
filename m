Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF26606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xeh59mDk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB6010F92F;
	Tue, 17 Nov 2026 20:03:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607E410F92D;
 Tue, 17 Nov 2026 20:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794945800; x=1826481800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NgjjT+4GI5Vd+T2mjSD6OnKg9oK/aNcxarP8Qg0FtaI=;
 b=Xeh59mDkAf8gvzB4rxzQUqxq8qG0hyxXk6/f4BcuOqMBW2GrZ3AlOkOW
 XGZVdxxcTy2RU/7n70j9EmbTi6jBPflzmMd6tgPKeeBa8bFc+VIwMjz7Y
 SctBUxBHpPkbz5n38BlxbyN2YMp+ypWFBd3ZPqvOp5rnffbT+feikfaRT
 h05FkxI0/DG3RqaphkFv7ZXfuP3U6ZD/Dam3sm7i9rdhQrJkSQG+rrB9j
 FhLFlU+4n8OeQ8WEkdHT0tj/CkuCTptAeEL1xmeWt3QrnhzcdSP0BH0sY
 ryuq+6ZtokV6f8cH9cK2zjMFcOn2xRFxTPMc4hscrifZxe/KNz6V5Mm2l Q==;
X-CSE-ConnectionGUID: l9rAwVQ+Sn2icboSGIMFVw==
X-CSE-MsgGUID: SXD05B+lSY6Rf+zPBhPG7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3724355"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3724355"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:20 -0800
X-CSE-ConnectionGUID: jDx2UbEjSACBmIEaFFQorQ==
X-CSE-MsgGUID: rCKHq4WsTYu1/YxczjInvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10002021"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:18 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 4/6] drm/atomic: Store the device in drm_crtc_commit
Date: Tue, 17 Nov 2026 22:02:51 +0200
Message-ID: <20261117200253.27078-5-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117200253.27078-1-ville.syrjala@linux.intel.com>
References: <20261117200253.27078-1-ville.syrjala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

drm_crtc_commit_wait() gets the device for its timeout messages from
commit->crtc, which is NULL for the fake commit that tracks unbound
planes and connectors. If waiting for the fake commit's hw_done ever
times out we oops instead of printing the message.

Store the device in the commit and use it for the messages instead,
and also print the CRTC when there is one so the messages say which
commit timed out. Document that drm_crtc_commit.crtc is NULL for the
fake commit.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic.c        | 14 ++++++++++++--
 drivers/gpu/drm/drm_atomic_helper.c |  8 +++++---
 include/drm/drm_atomic.h            |  9 ++++++++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 81591173265d..ec5a8f32a0b0 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -136,6 +136,16 @@ void __drm_crtc_commit_free(struct kref *kref)
 }
 EXPORT_SYMBOL(__drm_crtc_commit_free);
 
+static void drm_crtc_commit_wait_timeout(struct drm_crtc_commit *commit,
+					 const char *what)
+{
+	if (commit->crtc)
+		drm_err(commit->dev, "[CRTC:%d:%s] %s timed out\n",
+			commit->crtc->base.id, commit->crtc->name, what);
+	else
+		drm_err(commit->dev, "fake commit %s timed out\n", what);
+}
+
 /**
  * drm_crtc_commit_wait - Waits for a commit to complete
  * @commit: &drm_crtc_commit to wait for
@@ -156,7 +166,7 @@ int drm_crtc_commit_wait(struct drm_crtc_commit *commit)
 
 	ret = wait_for_completion_timeout(&commit->hw_done, timeout);
 	if (!ret) {
-		drm_err(commit->crtc->dev, "hw_done timed out\n");
+		drm_crtc_commit_wait_timeout(commit, "hw_done");
 		return -ETIMEDOUT;
 	}
 
@@ -166,7 +176,7 @@ int drm_crtc_commit_wait(struct drm_crtc_commit *commit)
 	 */
 	ret = wait_for_completion_timeout(&commit->flip_done, timeout);
 	if (!ret) {
-		drm_err(commit->crtc->dev, "flip_done timed out\n");
+		drm_crtc_commit_wait_timeout(commit, "flip_done");
 		return -ETIMEDOUT;
 	}
 
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 1ef1bc06ad5c..72aa0be5622c 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2462,13 +2462,15 @@ static void release_crtc_commit(struct completion *completion)
 	drm_crtc_commit_put(commit);
 }
 
-static void init_commit(struct drm_crtc_commit *commit, struct drm_crtc *crtc)
+static void init_commit(struct drm_crtc_commit *commit, struct drm_device *dev,
+			struct drm_crtc *crtc)
 {
 	init_completion(&commit->flip_done);
 	init_completion(&commit->hw_done);
 	init_completion(&commit->cleanup_done);
 	INIT_LIST_HEAD(&commit->commit_entry);
 	kref_init(&commit->ref);
+	commit->dev = dev;
 	commit->crtc = crtc;
 }
 
@@ -2488,7 +2490,7 @@ crtc_or_fake_commit(struct drm_atomic_commit *state, struct drm_crtc *crtc)
 		if (!state->fake_commit)
 			return NULL;
 
-		init_commit(state->fake_commit, NULL);
+		init_commit(state->fake_commit, state->dev, NULL);
 
 		/*
 		 * There is no event nor flip for the fake commit, so
@@ -2569,7 +2571,7 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_commit *state,
 		if (!commit)
 			return -ENOMEM;
 
-		init_commit(commit, crtc);
+		init_commit(commit, state->dev, crtc);
 
 		new_crtc_state->commit = commit;
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 5d075763c445..b5bd7d75bc82 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -70,10 +70,17 @@
  * See also drm_crtc_commit_wait().
  */
 struct drm_crtc_commit {
+	/**
+	 * @dev:
+	 *
+	 * DRM device for this commit.
+	 */
+	struct drm_device *dev;
+
 	/**
 	 * @crtc:
 	 *
-	 * DRM CRTC for this commit.
+	 * DRM CRTC for this commit. NULL for &drm_atomic_commit.fake_commit.
 	 */
 	struct drm_crtc *crtc;
 
-- 
2.56.0

