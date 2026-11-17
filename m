Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD6606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0kubYtX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7377010F923;
	Tue, 17 Nov 2026 20:03:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7F110F91B;
 Tue, 17 Nov 2026 20:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794945790; x=1826481790;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jd97OiJC1bS/Oel8VF3NxAFHcze2JWHyTRkH3pyE7mU=;
 b=F0kubYtXuSLMzO4ELX3HWjHBlcMEXRP3nKWPAxWko1W70A/8z0lj3pbp
 QH64RpaKLJEcx2bpM8zkBaQITSARk+Af83KRiZExkexODENWxTQyma3zO
 N9PHrevpqPdRwrfr7FFyVM8kitf/gm3F+EwPTpFiOWCaur/d/78wVzZQw
 DIHF+s3hdDY478lP6lA4J6ujejGTsIzVPPhZHocjLdVoyiuGKI8wwq5FB
 tNxLKHSCjsBwXAzd9dCg99dD4iIswtxYETlLRoFkiDV12PR4ImdxxWo7j
 z0OzrXNS0z8uL+GLAbWtl6KtNtONoz/dZ6A9L1kqWb4abn9wqoWIXfPUC w==;
X-CSE-ConnectionGUID: VfxYMD4vQ6evOQ5pcpJhwg==
X-CSE-MsgGUID: gpWC9uBhSvSTge3nXcB8qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3656011"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3656011"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:09 -0800
X-CSE-ConnectionGUID: CmrtDOgPQWiQm9EiVugDpw==
X-CSE-MsgGUID: LI3LXMlET1ur3TEMvGvbdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10173531"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:08 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 2/6] drm/atomic-helper: Complete fake_commit->flip_done in
 setup_commit
Date: Tue, 17 Nov 2026 22:02:49 +0200
Message-ID: <20261117200253.27078-3-ville.syrjala@linux.intel.com>
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

The fake commit is used for planes and connectors that are not bound to
any CRTC. There is no event or flip for it, so its flip_done can not
mean anything more than "hw_done is on its way". Since
commit 2de42f79bb21 ("drm/atomic-helper: Complete fake_commit->flip_done
potentially earlier") it is completed after
drm_atomic_helper_wait_for_flip_done(), but that still leaves a window
in which a nonblocking commit touching the same planes/connectors gets
a spurious -EBUSY, eg. when the previous commit was a nonblocking
modeset that has sent out its event but still has not reached hw_done,
or when multiple CRTCs' vblanks don't line up.

Close the window by completing flip_done already when the fake commit is
created in drm_atomic_helper_setup_commit(), like is done for CRTCs that
stay off. Nothing relies on the late completion:

- ordering and the lifetime of the old state are guaranteed by hw_done,
  which drm_atomic_helper_swap_state() and
  drm_atomic_helper_wait_for_dependencies() still wait for
- a nonblocking commit that touches only unbound planes/connectors now
  stalls in drm_atomic_helper_swap_state() until the previous commit
  reaches hw_done, instead of failing with -EBUSY
- commits that include a CRTC already stall there for the CRTC's commit,
  whose hw_done completes together with the fake commit's

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/13410
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 17 +++++++++++------
 include/drm/drm_atomic.h            |  6 ++++--
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 3baca28b5cb8..1ef1bc06ad5c 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1967,9 +1967,6 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
 			drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
 				crtc->base.id, crtc->name);
 	}
-
-	if (state->fake_commit)
-		complete_all(&state->fake_commit->flip_done);
 }
 EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
 
@@ -2492,6 +2489,16 @@ crtc_or_fake_commit(struct drm_atomic_commit *state, struct drm_crtc *crtc)
 			return NULL;
 
 		init_commit(state->fake_commit, NULL);
+
+		/*
+		 * There is no event nor flip for the fake commit, so
+		 * flip_done has nothing to wait for. Completing it here
+		 * avoids spurious -EBUSY from nonblocking commits that
+		 * touch the same planes/connectors while the previous commit
+		 * is still being committed. The ordering is still guaranteed
+		 * by hw_done, which the later commits wait for.
+		 */
+		complete_all(&state->fake_commit->flip_done);
 	}
 
 	return state->fake_commit;
@@ -2795,10 +2802,8 @@ void drm_atomic_helper_commit_hw_done(struct drm_atomic_commit *state)
 		complete_all(&commit->hw_done);
 	}
 
-	if (state->fake_commit) {
+	if (state->fake_commit)
 		complete_all(&state->fake_commit->hw_done);
-		complete_all(&state->fake_commit->flip_done);
-	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_hw_done);
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..5d075763c445 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -653,8 +653,10 @@ struct drm_atomic_commit {
 	 * When a connector or plane is not bound to any CRTC, it's still important
 	 * to preserve linearity to prevent the atomic states from being freed too early.
 	 *
-	 * This commit (if set) is not bound to any CRTC, but will be completed when
-	 * drm_atomic_helper_commit_hw_done() is called.
+	 * This commit (if set) is not bound to any CRTC, and there is no flip
+	 * for it to wait for, so its &drm_crtc_commit.flip_done is completed
+	 * already by drm_atomic_helper_setup_commit(). &drm_crtc_commit.hw_done
+	 * is completed when drm_atomic_helper_commit_hw_done() is called.
 	 */
 	struct drm_crtc_commit *fake_commit;
 
-- 
2.56.0

