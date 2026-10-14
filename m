Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2C8CC6B2C
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A2910EB1F;
	Wed, 14 Oct 2026 19:34:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6910810E423;
 Wed, 14 Oct 2026 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006480; x=1823542480;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2BrGDNOadPt5M3mPRXLp/mU/i5ez+vw26ABYR+zzVio=;
 b=B0DAffEXqIfaqIddib5+ALkytD3U1+C1blXFdRDvV8PhTt0TlCwUwXr+
 Bx8avY4v7Pb+333LFhwHOiaZ7yUyG5jKv0YmNbEvTs6oLIgNWiye0dTkX
 MPC7OGDrWeF8rE4C2x0t9B8Y/paZPbuOgR2ghzW4dU5y+wH2UDXJ39MeO
 QaWjPBwbXy1YqfWDkjkupqNbdZO5C1DFMPR7OhGlkayeus15jIui5Ii5D
 a0aonhz83dwoC8AlQv5pqyA08N2CFU5IS9gqFE5aIfZEJuECUr54Cv0Nw
 0E1cBeTAQuovuVSV5iFgTD/QWlLVSqbKCEVKWsPqoUert+6C7ycOEeYM0 Q==;
X-CSE-ConnectionGUID: 4qghrIgQQZ+59ME6yAgcGQ==
X-CSE-MsgGUID: t8rhGyqATcS/Dg83t1ZOVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653870"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653870"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
X-CSE-ConnectionGUID: T1fa8fswTH2iD6cW4IL6dQ==
X-CSE-MsgGUID: yVGQ5ZGWQE+pm1XHuxFnjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270508"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 07/12] drm/armada: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:34:27 -0700
Message-ID: <20261014193421.1705112-21-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014193421.1705112-14-niranjana.vishwanathapura@intel.com>
References: <20261014193421.1705112-14-niranjana.vishwanathapura@intel.com>
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

Replace the open-coded self-import check with the drm core helper
drm_gem_prime_self_import(), which performs the same ops and device
match and returns the backing GEM object with a reference.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
---
 drivers/gpu/drm/armada/armada_gem.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index da7335cbe82d..19f0ed6164c5 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -502,18 +502,11 @@ armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
 {
 	struct dma_buf_attachment *attach;
 	struct armada_gem_object *dobj;
+	struct drm_gem_object *obj;
 
-	if (buf->ops == &armada_gem_prime_dmabuf_ops) {
-		struct drm_gem_object *obj = buf->priv;
-		if (obj->dev == dev) {
-			/*
-			 * Importing our own dmabuf(s) increases the
-			 * refcount on the gem object itself.
-			 */
-			drm_gem_object_get(obj);
-			return obj;
-		}
-	}
+	obj = drm_gem_prime_self_import(dev, buf, &armada_gem_prime_dmabuf_ops);
+	if (obj)
+		return obj;
 
 	attach = dma_buf_attach(buf, dev->dev);
 	if (IS_ERR(attach))
-- 
2.43.0

