Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD5606A33A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JBNl4L85
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C6C10EDF5;
	Mon, 16 Nov 2026 09:12:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FA610EDD3;
 Mon, 16 Nov 2026 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794820362; x=1826356362;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pHF9xLvcG9gfH8j1zj7t3K6d+zo9EVFW76WpJp7J530=;
 b=JBNl4L85I20F8SQudVv2peiu9BmKAB1tfWBDAIcHIfQ/pDBfejUxYFD+
 jnfLZPhpfIbi9bj1IfpvAsUzldWYc1VHjlfPftmACQ+FTq+TgO0orrg/v
 j8TOzQhvvLeKZgORJIC0jh4/nNwwjBAVBsBgTjeGlKuegxui2pReTfyH4
 sBjoGt9h/u89smJAwsd72rqeyZSNoHDGK3EVe8HAdpvN4sHN85JVosjZ+
 TRbY+JUIfVvjibphJ0hXrmUdErvKqvs7YXvUfchjCrAaW5BNmqDHUJ8Cz
 NpVFms9rbcliLzJaUmDRT8cummRs2YuLhIxcG2h5F9gdAb3QU9SvbkzRf Q==;
X-CSE-ConnectionGUID: /2LCstM9T6ucDVbhHCKgTw==
X-CSE-MsgGUID: e5VnknrcSIufK9Suyb+VVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3441765"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3441765"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:12:41 -0800
X-CSE-ConnectionGUID: 6ey6gmWKTACkcx6ix9v0lA==
X-CSE-MsgGUID: RjVWHJ/4QiWEqzp0q+7kvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9636455"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:12:40 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Erwin Springer <aot.lerwin@gmail.com>
Subject: [PATCH 06/12] drm/atomic/uapi: Improve the async flip property
 rejection debugs
Date: Mon, 16 Nov 2026 11:11:24 +0200
Message-ID: <20261116091130.13950-7-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
References: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
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

The current property rejection debug claims that no properties
can be changed during async flips, which is simply not true.
Reword the message to indicate that the attempted property change
is unsupported. Also include the KMS object type/ID/name in the
debug message to help the person reading the logs.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 2ea03b4b0be9..aad71d3e2105 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1227,7 +1227,8 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 
 			if (old_val != prop_value) {
 				drm_dbg_atomic(prop->dev,
-					       "[PROP:%d:%s] No prop can be changed during async flip\n",
+					       "[CONNECTOR:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
+					       connector->base.id, connector->name,
 					       prop->base.id, prop->name);
 				ret = -EINVAL;
 				break;
@@ -1257,7 +1258,8 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 
 			if (old_val != prop_value) {
 				drm_dbg_atomic(prop->dev,
-					       "[PROP:%d:%s] No prop can be changed during async flip\n",
+					       "[CRTC:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
+					       crtc->base.id, crtc->name,
 					       prop->base.id, prop->name);
 				ret = -EINVAL;
 				break;
@@ -1293,7 +1295,8 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 			    prop != config->prop_in_fence_fd &&
 			    prop != config->prop_fb_damage_clips) {
 				drm_dbg_atomic(prop->dev,
-					       "[PROP:%d:%s] No prop can be changed during async flip\n",
+					       "[PLANE:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
+					       plane->base.id, plane->name,
 					       prop->base.id, prop->name);
 				ret = -EINVAL;
 				break;
-- 
2.56.0

