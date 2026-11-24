Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M56sDzk5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DD810F2C1;
	Tue, 24 Nov 2026 08:22:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF88B10F2C1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795508544; x=1827044544;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gqKiPUbmXJdm37kl4ea33ZbcylgdNnLfBx/KhDNnKGc=;
 b=M56sDzk51YpXt0L7gUkHbrPhXt4YHMOQY9+AdXvtiZ5yY6TIB6U+YGJG
 8ppntt+oYlunl7ZaRWukOIq/LSF8ass5wSgfe/LnmpEOC7ECWTgrGRjvm
 XaASotNoXxi33HAtWpbPkup0sUHVlIJG1MHU+MfzaZ9SpxXlEAZGESQbK
 oOs+FBwh8PlqwU2I5hBgpB1BtozmdGn5INnod60uNGRgp0t3Z3L515W3B
 E2f5ZLPxpHsr7Y+VpWeQa3COjYW4cY0TXJHtKUFCMZgm0rfG/w8py9wsU
 /TZ7g1WVqMFkNFgJJ5Y0i4i73J5KNHgo+WIRTCfIyIxvxTtMZtOoZrfsn g==;
X-CSE-ConnectionGUID: 0ljigXEGQzOBS1+ov8xPWw==
X-CSE-MsgGUID: GgLsCNgxQyGoeKYW3bnq5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4440688"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4440688"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 00:09:58 -0800
X-CSE-ConnectionGUID: OBMhvz/2RZeIgM8WNptscw==
X-CSE-MsgGUID: y8jYUQKyQyGf7cOjDenMCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11835160"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 00:09:55 -0800
From: Fei Yu <fei.yu@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: christian.koenig@amd.com, tursulin@ursulin.net,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 fei.yu@intel.com
Subject: [PATCH] drm/syncobj: Document the handle limit in the uAPI headers
Date: Tue, 24 Nov 2026 16:15:36 +0800
Message-ID: <20261124081536.4048657-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 6ca87397aeeb ("drm/syncobj: Limit the number of handles and use
kvmalloc for user-sized arrays") rejects more than 1M (1 << 20) handles
with -EINVAL in all syncobj ioctls that take an array of handles: wait,
timeline_wait, reset, signal, query and timeline_signal.

Document the limit next to count_handles in the four uAPI structs those
ioctls use, so that userspace knows about it. The define itself stays
kernel internal.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Fei Yu <fei.yu@intel.com>
---
This documents the limit added by the fix below, which is in mainline
since v7.4-rc4 (6ca87397aeeb) but not yet in drm-misc-next. The patch
only touches comments, so it applies and builds on drm-misc-next as is:
https://lore.kernel.org/all/20261109014852.2127723-1-fei.yu@intel.com/

As discussed in the v2 thread, the define stays kernel internal and the
limit is only documented here:
https://lore.kernel.org/all/20261104030930.3852781-1-fei.yu@intel.com/

 include/uapi/drm/drm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index bc7ef7684099..59b6e2558d82 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -963,6 +963,7 @@ struct drm_syncobj_wait {
 	__u64 handles;
 	/* absolute timeout */
 	__s64 timeout_nsec;
+	/* at most 1M (1 << 20) handles, more return -EINVAL */
 	__u32 count_handles;
 	__u32 flags;
 	__u32 first_signaled; /* only valid when not waiting all */
@@ -983,6 +984,7 @@ struct drm_syncobj_timeline_wait {
 	__u64 points;
 	/* absolute timeout */
 	__s64 timeout_nsec;
+	/* at most 1M (1 << 20) handles, more return -EINVAL */
 	__u32 count_handles;
 	__u32 flags;
 	__u32 first_signaled; /* only valid when not waiting all */
@@ -1021,6 +1023,7 @@ struct drm_syncobj_eventfd {
 
 struct drm_syncobj_array {
 	__u64 handles;
+	/* at most 1M (1 << 20) handles, more return -EINVAL */
 	__u32 count_handles;
 	__u32 pad;
 };
@@ -1029,6 +1032,7 @@ struct drm_syncobj_array {
 struct drm_syncobj_timeline_array {
 	__u64 handles;
 	__u64 points;
+	/* at most 1M (1 << 20) handles, more return -EINVAL */
 	__u32 count_handles;
 	__u32 flags;
 };

base-commit: 2f50e0a0f9d319678a67715d4160ee890f5ee6f6
-- 
2.53.0

