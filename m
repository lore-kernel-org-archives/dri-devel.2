Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F10CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 01:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4099A10E6F1;
	Tue, 13 Oct 2026 01:06:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8595410E6D5;
 Tue, 13 Oct 2026 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791853602; x=1823389602;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=/358Y9y13wpTg+FgeQRvuIzpjwey2dRBw09J+ykC6CE=;
 b=I9HaDdYZ45idLXXaCBk9YdDTeq01quOUGq8vxfMIjuHOfXCT8fZrIKk9
 qX9lLP7GlGHoOz56+IoWjACXlC1wA+AU9fq2LxkkVuqhokauvG5ROksl6
 Hs37CpNqj8iDs5bvGtYXZ/hEZobPBZcwr+hi+Mz7NC6hthcfc7VjK1928
 pC2g3zw5RW5ovLAfWI25VEAGKjfsA0LTfc9Jfdps+tlo5zrLrRGT63B22
 MzUO+PNoSBAJbr+tA7sqbdmqyCxbdK9hbaMowDRvwKuMjzzrytKqoj3s9
 7HBQtPxMQK+SqxNy1i9Vbh5OB9ZD/28sWHOQpKk4dyOovLcIoIzw2hHS6 Q==;
X-CSE-ConnectionGUID: /qdn9Fw/TzixRvPdVo9UcQ==
X-CSE-MsgGUID: KaoAi3JrTIKICJ5fCz0blQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="557197"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="557197"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:31 -0700
X-CSE-ConnectionGUID: w/nmScbqR8SPc0Kct/vFQw==
X-CSE-MsgGUID: KcZE67R9R8upxJ3s8BUgJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1360825"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:19 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com
Subject: [PATCH v2 5/6] drm/panfrost: use drm_gem_prime_self_import() helper
Date: Mon, 12 Oct 2026 18:06:17 -0700
Message-ID: <20261013010614.1516799-13-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
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

Replace the open-coded self-import check with the drm core
helper drm_gem_prime_self_import(), which performs the same ops and
device match and returns the backing GEM object with a reference.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 3a7fce428898..19fcbffb3e94 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -386,15 +386,11 @@ struct drm_gem_object *
 panfrost_gem_prime_import(struct drm_device *dev,
 			  struct dma_buf *dma_buf)
 {
-	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_gem_object *obj;
 
-	if (dma_buf->ops == &panfrost_dma_buf_ops && obj->dev == dev) {
-		/* Importing dmabuf exported from our own gem increases
-		 * refcount on gem itself instead of f_count of dmabuf.
-		 */
-		drm_gem_object_get(obj);
+	obj = drm_gem_prime_self_import(dev, dma_buf, &panfrost_dma_buf_ops);
+	if (obj)
 		return obj;
-	}
 
 	return drm_gem_prime_import(dev, dma_buf);
 }
-- 
2.43.0

