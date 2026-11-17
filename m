Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CA606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UaaUjywK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8176C10F924;
	Tue, 17 Nov 2026 20:03:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3744C10F918;
 Tue, 17 Nov 2026 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794945785; x=1826481785;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g8ttvEjqIlYEYJct6jHGLc3jaNponNJ8LP2XBp1H440=;
 b=UaaUjywKrgEMMuZYMomk3dvoOF7ArEEIzgBmzbWEuN8F1eS1CcKBK4zF
 j2VKBYWKoizyalm8bio8H2k1LRbuLyYHInIOjueTHvUlsgUbtkBfTuV0l
 xqvKztA/4lLESY3NjwZJ+noDSVlR5P4g685S4M3nMjBhWRhcbd/by0VWy
 d8LM0C35Tmp3lVcC+Rn9En7W1ordqutHht/slGBmpvS5saNP+ADYXBANE
 a9eAnjxYvRWz0YSk/UGALbVYKxeHw5uivjhegdUio+7eDceEKaCH0Bsm1
 /d+A7cS2LJdpowlc68pOQRki1i5Qu5HodoZshWwbv68WA50W4QsWpzxmU g==;
X-CSE-ConnectionGUID: 2zwQ/45mTfWQ0Dn8HILamg==
X-CSE-MsgGUID: +/PYLxYyRdmc+pEJk7qqZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3656003"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3656003"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:05 -0800
X-CSE-ConnectionGUID: J3z5A3QkTs24bXyf1fUzWg==
X-CSE-MsgGUID: IY35vXCiQw2HgklH5YHHGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10173484"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:03 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 1/6] drm/atomic-helper: Limit run-ahead of fake commit only
 commits
Date: Tue, 17 Nov 2026 22:02:48 +0200
Message-ID: <20261117200253.27078-2-ville.syrjala@linux.intel.com>
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

Nonblocking commits that touch just CRTC-less planes and connectors
use the fake commit. Unlike CRTC commits, which stall_checks() bounds
to about triple buffering using crtc->commit_list, the fake commit is
on no list, and the only thing that limits how far userspace can run
ahead is the -EBUSY check on the previous fake commit's flip_done,
which is completed from the commit tail.

That limit is about to go away when the flip_done gets completed
earlier. Without any limit, and with drivers that call
drm_atomic_helper_swap_state() with stall=false, the work items of all
the queued commits start at once and each waits for the hw_done of its
predecessor. These waits add up, and once the backlog takes longer
than 10 s to drain the later work items hit the hw_done timeout in
drm_atomic_helper_wait_for_dependencies(), which has no way to
recover from it.

So wait (interruptibly, with the usual 10 s timeout) for the previous
fake commit's hw_done in drm_atomic_helper_setup_commit(). This limits
the depth of fake commit only commits to one, without relying on
-EBUSY. CRTC commits are left to stall_checks(). Do it in
setup_commit() rather than swap_state() so that it does not depend on
the driver's stall choice, and so that an interrupted wait is cheap to
unwind.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index ccfe3840d505..3baca28b5cb8 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2428,6 +2428,34 @@ static int stall_checks(struct drm_crtc *crtc, bool nonblock)
 	return ret < 0 ? ret : 0;
 }
 
+/*
+ * Commits that only touch planes and connectors without a CRTC use the fake
+ * commit, which has no CRTC to hang off of, and so no commit_list for
+ * stall_checks() to look at. Their flip_done is completed already in
+ * drm_atomic_helper_setup_commit(), so the -EBUSY checks do not limit how far
+ * userspace can run ahead either. Without any limit the work items of the
+ * queued nonblocking commits would all wait for each other's hw_done, and
+ * the waits would add up and eventually time out.
+ *
+ * Wait for the previous fake commit to reach hw_done instead, which limits
+ * the depth to one commit. CRTC commits are limited by stall_checks().
+ */
+static int stall_for_fake_commit(struct drm_device *dev,
+				 struct drm_crtc_commit *commit)
+{
+	long ret;
+
+	if (!commit || commit->crtc)
+		return 0;
+
+	ret = wait_for_completion_interruptible_timeout(&commit->hw_done,
+							10 * HZ);
+	if (ret == 0)
+		drm_err(dev, "fake commit hw_done timed out\n");
+
+	return ret < 0 ? ret : 0;
+}
+
 static void release_crtc_commit(struct completion *completion)
 {
 	struct drm_crtc_commit *commit = container_of(completion,
@@ -2590,6 +2618,10 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_commit *state,
 			return -EBUSY;
 		}
 
+		ret = stall_for_fake_commit(state->dev, old_conn_state->commit);
+		if (ret)
+			return ret;
+
 		/* Always track connectors explicitly for e.g. link retraining. */
 		commit = crtc_or_fake_commit(state, new_conn_state->crtc ?: old_conn_state->crtc);
 		if (!commit)
@@ -2612,6 +2644,10 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_commit *state,
 			return -EBUSY;
 		}
 
+		ret = stall_for_fake_commit(state->dev, old_plane_state->commit);
+		if (ret)
+			return ret;
+
 		/* Always track planes explicitly for async pageflip support. */
 		commit = crtc_or_fake_commit(state, new_plane_state->crtc ?: old_plane_state->crtc);
 		if (!commit)
-- 
2.56.0

