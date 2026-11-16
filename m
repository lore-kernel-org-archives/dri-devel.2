Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD59606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YuUt2ZXJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79EFF10F0E4;
	Mon, 16 Nov 2026 12:57:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D9E10F076;
 Mon, 16 Nov 2026 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794833820; x=1826369820;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2HFy/tII3Sp3ZP/wQ/ZBk4NUc0tS64wXw3Y1nCXq+sk=;
 b=YuUt2ZXJxzxXWwbQZHlmCCoWD5LHvp1P3va+DOEfLQePhnDffpECjRFo
 RIkgpCIKbUStgio6XLhJvb0+eaFy3szq+FpF3OyIWE57DlLTpJ7lMx0jX
 ubAwPhsQZKkb4MfiWMlN8SwSzHxJtgwvf2NJdN5QBrRYxS36xZRb+7dQf
 1T2N7WQZpRegbmPt4MKIkoCDjHZoFtuspQl39OED3hauTq2SoSSUxNVLx
 5/NK9AnEWbbCNneEL7jbjtMaW19vgNkhfE+eNKVbUi5CmoA7BmGNP61BO
 2ELaPg1CtIs07mw1cAx/Bct17ZNNmXP1OG5WU85S0gUCRKrPhtWKOdD0M A==;
X-CSE-ConnectionGUID: jH6kXL9pTjOU+AQ2U5DbNg==
X-CSE-MsgGUID: mp8ter91SaeynQmhur/mZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3421436"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3421436"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:57:00 -0800
X-CSE-ConnectionGUID: Q26ovHTlQOO/ddxMwlsS6w==
X-CSE-MsgGUID: ekN+jtpNRSeZJtBZICsWJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9378678"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:56:59 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 1/4] drm: Add drm_event_release_completion()
Date: Mon, 16 Nov 2026 14:56:46 +0200
Message-ID: <20261116125649.15742-2-ville.syrjala@linux.intel.com>
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

Split releasing the completion of a pending event out of
drm_send_event_helper(), make it safe to call more than once, and also
do it from drm_event_cancel_free(). This makes it possible to throw
away an event that was set up for a commit without having to know
whether it has a completion attached.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_file.c | 28 ++++++++++++++++++++++++++--
 include/drm/drm_file.h     |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ec820686b302..6787a4583b6d 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -729,6 +729,8 @@ void drm_event_cancel_free(struct drm_device *dev,
 {
 	unsigned long flags;
 
+	drm_event_release_completion(p);
+
 	spin_lock_irqsave(&dev->event_lock, flags);
 	if (p->file_priv) {
 		p->file_priv->event_space += p->event->length;
@@ -743,6 +745,29 @@ void drm_event_cancel_free(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_event_cancel_free);
 
+/**
+ * drm_event_release_completion - release the completion of an event
+ * @p: event whose completion should be released
+ *
+ * Calls &drm_pending_event.completion_release for @p, if it still has a
+ * completion, and forgets about the completion. This is done by
+ * drm_send_event() when the event is sent. It must also be done when an
+ * event is thrown away without having been sent, and is done by
+ * drm_event_cancel_free(). It is fine to call this more than once, and
+ * for events without a completion.
+ *
+ * The caller must make sure the event is not being sent concurrently.
+ */
+void drm_event_release_completion(struct drm_pending_event *p)
+{
+	if (!p->completion)
+		return;
+
+	p->completion_release(p->completion);
+	p->completion = NULL;
+}
+EXPORT_SYMBOL(drm_event_release_completion);
+
 static void drm_send_event_helper(struct drm_device *dev,
 			   struct drm_pending_event *e, ktime_t timestamp)
 {
@@ -750,8 +775,7 @@ static void drm_send_event_helper(struct drm_device *dev,
 
 	if (e->completion) {
 		complete_all(e->completion);
-		e->completion_release(e->completion);
-		e->completion = NULL;
+		drm_event_release_completion(e);
 	}
 
 	if (e->fence) {
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 6ee70ad65e1f..a2fa65ad6518 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -485,6 +485,7 @@ int drm_event_reserve_init(struct drm_device *dev,
 			   struct drm_file *file_priv,
 			   struct drm_pending_event *p,
 			   struct drm_event *e);
+void drm_event_release_completion(struct drm_pending_event *p);
 void drm_event_cancel_free(struct drm_device *dev,
 			   struct drm_pending_event *p);
 void drm_send_event_locked(struct drm_device *dev, struct drm_pending_event *e);
-- 
2.56.0

