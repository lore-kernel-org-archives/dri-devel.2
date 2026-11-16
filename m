Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4A606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iXpcPjgW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904CF10F106;
	Mon, 16 Nov 2026 12:57:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC1F10F0E3;
 Mon, 16 Nov 2026 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794833831; x=1826369831;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+hUgFPRsWFfAxX+Kejrp12AwPEOCv5HBeQvi4ZNFPAA=;
 b=iXpcPjgWXxBt38/urX0rrpc6mKf/J+GoNI+bvC8/6SOa9nIMr39tzydY
 Rykcs7zhdiS0c7wHtZNwVfQke0obo0YCWz4Y+0+CcJq8E9/plqgFFvBw8
 ymKYVAHSYUmrph0xDNepmyd5hw06tuXJV8HyEUtFH2zmMjS8SUJbUELOn
 ZQqJ/9GQktyrrWFSURbgtlr2lp9+FNphw2mFt8yIQ97pmSsfbWeYxOQJ2
 caWEu5przDa0ltf2tNVqj4M+p18VAXso1dtjEQC08IIr8ypVEKTpwXizx
 cUHETtagu1s0RVkhGa/3updqxGpy5+QLSKispYds5XRxEE6588UbY49xi A==;
X-CSE-ConnectionGUID: OJIcSx49Sge8KES6uocB3A==
X-CSE-MsgGUID: XusR/OaJRKGqyJzn6DPgbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3557849"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3557849"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:57:11 -0800
X-CSE-ConnectionGUID: 4A06LWQNR6KRWbYuw2c0NA==
X-CSE-MsgGUID: e4ymLo/sQ+yud6wZNeHx3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9439963"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:57:09 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 3/4] drm/atomic: Free unconsumed events in the CRTC state
 destructor
Date: Mon, 16 Nov 2026 14:56:48 +0200
Message-ID: <20261116125649.15742-4-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116125649.15742-1-ville.syrjala@linux.intel.com>
References: <20261116125649.15742-1-ville.syrjala@linux.intel.com>
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

The ownership of an event attached to a CRTC state is currently split
three ways: drm_atomic_helper_setup_commit() allocated events are freed
through drm_crtc_commit::event, events from the atomic uapi are freed by
complete_signaling(), and a flag (drm_crtc_commit::abort_completion) is
needed so the right party drops the reference the event holds on the
commit.

Simplify this by having __drm_atomic_helper_crtc_destroy_state() throw
away any event that is still in the state, since an event that was not
consumed by the driver can only be there because the commit did not
happen. drm_event_cancel_free() takes care of the file and fence
bookkeeping, and of releasing the event's completion. This allows
drm_crtc_commit::event, drm_crtc_commit::abort_completion and the
cancelling in complete_signaling() to go away.

All drivers clear the event from the CRTC state when they consume it,
and drm_atomic_helper_commit_hw_done() already warns if they do not.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic_helper.c       | 10 ++------
 drivers/gpu/drm/drm_atomic_state_helper.c | 29 ++++++++++-------------
 drivers/gpu/drm/drm_atomic_uapi.c         | 24 ++++---------------
 include/drm/drm_atomic.h                  | 15 ------------
 4 files changed, 19 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 31e46f6ccd22..23b24d633f2e 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2559,19 +2559,15 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_commit *state,
 		}
 
 		if (!new_crtc_state->event) {
-			commit->event = kzalloc_obj(*commit->event);
-			if (!commit->event)
+			new_crtc_state->event = kzalloc_obj(*new_crtc_state->event);
+			if (!new_crtc_state->event)
 				return -ENOMEM;
-
-			new_crtc_state->event = commit->event;
 		}
 
 		new_crtc_state->event->base.completion = &commit->flip_done;
 		new_crtc_state->event->base.completion_release = release_crtc_commit;
 		drm_crtc_commit_get(commit);
 
-		commit->abort_completion = true;
-
 		state->crtcs[i].commit = commit;
 		drm_crtc_commit_get(commit);
 	}
@@ -3340,8 +3336,6 @@ int drm_atomic_helper_swap_state(struct drm_atomic_commit *state,
 			list_add(&new_crtc_state->commit->commit_entry,
 				 &crtc->commit_list);
 			spin_unlock(&crtc->commit_lock);
-
-			new_crtc_state->commit->event = NULL;
 		}
 	}
 
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 267f44330629..8ddf03cf521e 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -174,25 +174,20 @@ EXPORT_SYMBOL(drm_atomic_helper_crtc_duplicate_state);
  */
 void __drm_atomic_helper_crtc_destroy_state(struct drm_crtc_state *state)
 {
-	if (state->commit) {
-		/*
-		 * In the event that a non-blocking commit returns
-		 * -ERESTARTSYS before the commit_tail work is queued, we will
-		 * have an extra reference to the commit object. Release it, if
-		 * the event has not been consumed by the worker.
-		 *
-		 * state->event may be freed, so we can't directly look at
-		 * state->event->base.completion.
-		 */
-		if (state->event && state->commit->abort_completion)
-			drm_crtc_commit_put(state->commit);
-
-		kfree(state->commit->event);
-		state->commit->event = NULL;
-
-		drm_crtc_commit_put(state->commit);
+	/*
+	 * An event that is still here was never consumed, eg. because a
+	 * non-blocking commit returned -ERESTARTSYS before the commit_tail
+	 * work was queued. Throw it away, which also releases the extra
+	 * reference to the commit that the event holds for its completion.
+	 */
+	if (state->event) {
+		drm_event_cancel_free(state->crtc->dev, &state->event->base);
+		state->event = NULL;
 	}
 
+	if (state->commit)
+		drm_crtc_commit_put(state->commit);
+
 	drm_property_blob_put(state->mode_blob);
 	drm_property_blob_put(state->degamma_lut);
 	drm_property_blob_put(state->ctm);
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..2884063513ad 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1552,13 +1552,10 @@ static int prepare_signaling(struct drm_device *dev,
 }
 
 static void complete_signaling(struct drm_device *dev,
-			       struct drm_atomic_commit *state,
 			       struct drm_out_fence_state *fence_state,
 			       unsigned int num_fences,
 			       bool install_fds)
 {
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *crtc_state;
 	int i;
 
 	if (install_fds) {
@@ -1570,21 +1567,10 @@ static void complete_signaling(struct drm_device *dev,
 		return;
 	}
 
-	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
-		struct drm_pending_vblank_event *event = crtc_state->event;
-		/*
-		 * Free the allocated event. drm_atomic_helper_setup_commit
-		 * can allocate an event too, so only free it if it's ours
-		 * to prevent a double free in drm_atomic_commit_clear.
-		 */
-		if (event && (event->base.fence || event->base.file_priv)) {
-			if (crtc_state->commit && crtc_state->commit->abort_completion)
-				drm_crtc_commit_put(crtc_state->commit);
-			drm_event_cancel_free(dev, &event->base);
-			crtc_state->event = NULL;
-		}
-	}
-
+	/*
+	 * Any events that were not consumed are thrown away when the state
+	 * is destroyed.
+	 */
 	if (!fence_state)
 		return;
 
@@ -1778,7 +1764,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	}
 
 out:
-	complete_signaling(dev, state, fence_state, num_fences, !ret);
+	complete_signaling(dev, fence_state, num_fences, !ret);
 
 	if (ret == -EDEADLK) {
 		drm_atomic_commit_clear(state);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..33d21ffdfc68 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -140,21 +140,6 @@ struct drm_crtc_commit {
 	 */
 	struct list_head commit_entry;
 
-	/**
-	 * @event:
-	 *
-	 * &drm_pending_vblank_event pointer to clean up private events.
-	 */
-	struct drm_pending_vblank_event *event;
-
-	/**
-	 * @abort_completion:
-	 *
-	 * A flag that's set after drm_atomic_helper_setup_commit() takes a
-	 * second reference for the completion of $drm_crtc_state.event. It's
-	 * used by the free code to remove the second reference if commit fails.
-	 */
-	bool abort_completion;
 };
 
 struct __drm_colorops_state {
-- 
2.56.0

