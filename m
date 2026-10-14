Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D074CC6B2C
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A0010EB3E;
	Wed, 14 Oct 2026 19:34:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDC410EB34;
 Wed, 14 Oct 2026 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006489; x=1823542489;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cLTnFKbQ1TSKNAg2q+miW9hzXoZR2SNBIoneXezgdy8=;
 b=LOhll3pMn597Vxvh5f+x63vqTPw57CDjrOx9zFOI6/yk7YX6hftG0YsH
 2L8YvtDA2mdHlMaSmQpq4b7/aawKQx9ngR+bqdQpgZ4+mJbnzD+uN3OI8
 rsxmmRSn1i5VMYHaNGoYHftMvVYn1jLD+1u3GZAaC85etaepje/AbSv6e
 7WlFYtbh0tyySzPdOsEE1R/vOAXZ8mtaTOqB4j48GonhTUFDLAMK43e9c
 NwglauMI3f2f7JmLiC9yFphaQqm/hRDQ6yALtLPHTEuQ0rD7g+kYcSiiP
 +X+luMF/szwwmqQEme9M+GZDjNGzJh57oG5lMQclQ0dl4yrRHou7v7p48 w==;
X-CSE-ConnectionGUID: Zzr5jUnTQSONyolZnJ9CRQ==
X-CSE-MsgGUID: 4p76uKGnTHuvb1b1l2qu7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653878"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653878"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
X-CSE-ConnectionGUID: m3LnEbH9RvqA7AMTF5ITYw==
X-CSE-MsgGUID: kKyEwijGQ8WqjSykySE++w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270524"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 11/12] drm/virtio: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:34:31 -0700
Message-ID: <20261014193421.1705112-25-niranjana.vishwanathapura@intel.com>
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
 drivers/gpu/drm/virtio/virtgpu_prime.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 216c77cd0d21..6c337ff94f2e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -339,17 +339,9 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	int ret;
 
-	if (buf->ops == &virtgpu_dmabuf_ops.ops) {
-		obj = buf->priv;
-		if (obj->dev == dev) {
-			/*
-			 * Importing dmabuf exported from our own gem increases
-			 * refcount on gem itself instead of f_count of dmabuf.
-			 */
-			drm_gem_object_get(obj);
-			return obj;
-		}
-	}
+	obj = drm_gem_prime_self_import(dev, buf, &virtgpu_dmabuf_ops.ops);
+	if (obj)
+		return obj;
 
 	if (!vgdev->has_resource_blob)
 		return drm_gem_prime_import(dev, buf);
-- 
2.43.0

