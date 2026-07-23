Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BFEC4453D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2571210EEEC;
	Thu, 23 Jul 2026 00:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="W/sPK8+e";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB6C10EEEC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=wNmmFNAwI9FcQSiSm7+xoqkJ4Ka7jjK3NBV2GA8RMvY=; b=
 W/sPK8+exJCZnknCq4lnq8qGSll8TBmgvJzDVyddtkhvGmghksjMedrJgovXXlyhOE2bQC2EfYuBu
 Qiu6sxKgqcG03hDFrRBbMH6lEgYPEM+ZycOETMQMQ/xNcmc0qICDAXXwCs2Sm2sLIeHMzcLfPN81N
 ljkZDutiq/oSpiwmSR1yz10Wb5+nZc1i6MOtcbUuHrj1qqKgCXqNspS3MER7tGR/3m9uZEKF9ECAa
 nAneLSZ/CjlP0BS/S+1Jd6Uog5exVwuFdchXFDYQFNlozi4GPi1nDK+MELyxSRgjRj0DhsdeU1N3b
 SLk5Ac5AEBJ55vmB+Hnamr06Bah3bn+daw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wmhNE-003EEc-Cb; Thu, 23 Jul 2026 02:33:16 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v8 1/8] drm/managed: implement managed versions of
 kzalloc_obj/objs()
Date: Wed, 22 Jul 2026 17:31:56 -0700
Message-ID: <20260723003205.330362-2-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723003205.330362-1-John.Harrison@Igalia.com>
References: <20260723003205.330362-1-John.Harrison@Igalia.com>
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

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

The kzalloc_obj() and kzalloc_objs() functions have proven to be
useful and are widely used by the reset of the kernel. Implement
drm_device-managed versions of those macros to mix the nice interface
with the automatic freeing of the pointers.

Note: the original macros accept optional GFP_foo arguments. They are
skipped for now, making all allocations use GFP_KERNEL. If necessary,
support for overriding the GFP type can be introduced later.

v2: Made use of 'p' vs 'P' consistent, add typecast of returned pointer.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
Reviewed-by: John Harrison <John.Harrison@Igalia.com>
---
 include/drm/drm_managed.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
index 72d0d68be226..4614d49748cf 100644
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -105,6 +105,29 @@ static inline void *drmm_kcalloc(struct drm_device *dev,
 	return drmm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
 
+/**
+ * drmm_kzalloc_objs - &drm_device-managed kzalloc_objs()
+ * @dev: DRM device
+ * @P: Variable or type to allocate an array of
+ * @count: How many elements in the array
+ *
+ * Returns: newly allocated pointer to the zeroed array of @P on success, or
+ * NULL on failure.
+ */
+#define drmm_kzalloc_objs(dev, P, count) \
+	((typeof(P) *) drmm_kcalloc(dev, count, sizeof(typeof(P)), GFP_KERNEL))
+
+/**
+ * drmm_kzalloc_obj - &drm_device-managed kzalloc_obj()
+ * @dev: DRM device
+ * @P: Variable or type to allocate
+ *
+ * Returns: newly allocated pointer to zeroed instance of @P on success,
+ * or NULL on failure.
+ */
+#define drmm_kzalloc_obj(dev, P) \
+	drmm_kzalloc_objs(dev, P, 1)
+
 char *drmm_kstrdup(struct drm_device *dev, const char *s, gfp_t gfp);
 
 void drmm_kfree(struct drm_device *dev, void *data);
-- 
2.43.0

