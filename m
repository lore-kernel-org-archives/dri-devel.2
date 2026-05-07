Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D55CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67BE10E2AF;
	Thu,  7 May 2026 14:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="YcAgK/Rm";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A795810E2AF
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:44:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6600315F;
 Thu,  7 May 2026 07:44:27 -0700 (PDT)
Received: from e142607 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CCA33F763;
 Thu,  7 May 2026 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778165073; bh=W7u9ZbhoYWRVSIPuyKVQSMD1iqSVKXpBeE6hPGq3uP0=;
 h=From:To:Cc:Subject:Date:From;
 b=YcAgK/RmI8j9H27rYEZsW2Xok+rckENA4uiwc3ytRJkG8R5fKCIWz91o0H+wNoQmp
 v4gJajz0HBKCJVTXdQiL5gwmobqogiZONCrLSkoXaNtDnRGbGN12c4FNx/56m2BGLk
 tuUDEpWuyAW9tKkaHP7RSp4+9tX2yNh+WCCmDYWo=
From: Liviu Dudau <liviu.dudau@arm.com>
To: Erik Kurzinger <ekurzinger@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simon Ser <contact@emersion.fr>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, Sam Spencer <Sam.Spencer@arm.com>
Subject: [PATCH] drm/syncobj: Fix memory leak in drm_syncobj_find_fence()
Date: Thu,  7 May 2026 15:44:25 +0100
Message-ID: <20260507144425.2488057-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Commit 18226ba52159 ("drm/syncobj: reject invalid flags in
drm_syncobj_find_fence") forgot to take into account the fact that
drm_syncobj_find() takes a reference to syncobj and returns early
without dropping the reference, leading to memory leaks.

Fixes: 18226ba52159 ("drm/syncobj: reject invalid flags in drm_syncobj_find_fence")
Reported by: Sam Spencer <sam.spencer@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/drm_syncobj.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 8d9fd1917c6e6..c9dbf64c0c9f2 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -442,13 +442,15 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 	u64 timeout = nsecs_to_jiffies64(DRM_SYNCOBJ_WAIT_FOR_SUBMIT_TIMEOUT);
 	int ret;
 
-	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
-		return -EINVAL;
-
 	if (!syncobj)
 		return -ENOENT;
 
-	/* Waiting for userspace with locks help is illegal cause that can
+	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Waiting for userspace with locks held is illegal cause that can
 	 * trivial deadlock with page faults for example. Make lockdep complain
 	 * about it early on.
 	 */
-- 
2.54.0

