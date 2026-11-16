Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E49606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lFg9VMjg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9089710F0F5;
	Mon, 16 Nov 2026 12:57:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6359110F0E3;
 Mon, 16 Nov 2026 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794833825; x=1826369825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vwc68yoJSO9gbBS8l3wnUaYoOCTDLr4gmjtnVPUxEhg=;
 b=lFg9VMjgV1NlcGgZA+m4mKNHHoR0QGMDGvlrTatyW1YtLwJBfjAODBFs
 djmYsveseFJgF11ZsJkfVV8Up9l+c7ksqSmtZuZSrcuBKR/Mv+sAnZocl
 vJojQBYdVfeqy64Z9BmiuyhhYXVMsL4mD7wXUCrOD+2TVa5dUb64PE6mS
 nQ2FinmmYDpuOBco4AI6kSyuSYBHiz9gWb2qxK61zXQlmydFgDCie3baA
 6XFX51jMb8+Y0QiHM/LZYX4fakLolRfdoW1zMpPyYRmWA/r9ymJDJKxoQ
 ckppwDeBMNoZ9JDeXh8mhveV1yElsRsMI9XLe0JfuwILM8SKIPkYV3kjU A==;
X-CSE-ConnectionGUID: 2+P7sUGDTqO5Nwi1G76xWA==
X-CSE-MsgGUID: OBeqf7qRRzaycwduTPkKPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3421444"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3421444"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:57:05 -0800
X-CSE-ConnectionGUID: Z95xlA1fQRqP0+2qb0/EqA==
X-CSE-MsgGUID: AGpwOCpzTW+pARfVEu+j9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9378680"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:57:04 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 2/4] drm/atomic-helper: Detach the caller's event on page flip
 failure
Date: Mon, 16 Nov 2026 14:56:47 +0200
Message-ID: <20261116125649.15742-3-ville.syrjala@linux.intel.com>
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

The event passed to drm_atomic_helper_page_flip() and
drm_atomic_helper_page_flip_target() belongs to the caller, who frees it
when the flip fails. Make sure the atomic state no longer refers to it
in that case, by clearing it from the CRTC state, instead of relying on
the state destruction to unwind it.

This is a preparation for having the state destruction free any event
that was not consumed. Without the detach the event would then be freed
both by the state destruction and by the caller.

Also release the event's completion at the same time. The usual caller,
drm_mode_page_flip_ioctl(), frees the event with drm_event_cancel_free(),
which would do that anyway. But other callers may just kfree() the event,
and then the reference the completion holds on the commit would leak.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index ccfe3840d505..31e46f6ccd22 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3972,6 +3972,33 @@ static int page_flip_common(struct drm_atomic_commit *state,
 	return ret;
 }
 
+/*
+ * The event belongs to the caller, so if the flip fails the state must not
+ * hold on to it. Detach it from the state, or the state destruction would
+ * free it as well as the caller.
+ *
+ * Also release the event's completion here. The usual caller,
+ * drm_mode_page_flip_ioctl(), frees the event with drm_event_cancel_free(),
+ * which would do that anyway. But other callers may just kfree() the event,
+ * and then the reference the completion holds on the commit would leak.
+ */
+static void page_flip_detach_event(struct drm_atomic_commit *state,
+				   struct drm_crtc *crtc,
+				   struct drm_pending_vblank_event *event)
+{
+	struct drm_crtc_state *crtc_state;
+
+	if (!event)
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	if (!crtc_state || crtc_state->event != event)
+		return;
+
+	drm_event_release_completion(&event->base);
+	crtc_state->event = NULL;
+}
+
 /**
  * drm_atomic_helper_page_flip - execute a legacy page flip
  * @crtc: DRM CRTC
@@ -4011,6 +4038,8 @@ int drm_atomic_helper_page_flip(struct drm_crtc *crtc,
 
 	ret = drm_atomic_nonblocking_commit(state);
 fail:
+	if (ret)
+		page_flip_detach_event(state, crtc, event);
 	drm_atomic_commit_put(state);
 	return ret;
 }
@@ -4063,6 +4092,8 @@ int drm_atomic_helper_page_flip_target(struct drm_crtc *crtc,
 
 	ret = drm_atomic_nonblocking_commit(state);
 fail:
+	if (ret)
+		page_flip_detach_event(state, crtc, event);
 	drm_atomic_commit_put(state);
 	return ret;
 }
-- 
2.56.0

