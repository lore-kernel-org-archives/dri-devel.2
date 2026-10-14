Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2AFCC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6025210EAD8;
	Wed, 14 Oct 2026 19:02:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1445110EAB5;
 Wed, 14 Oct 2026 19:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792004541; x=1823540541;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=/358Y9y13wpTg+FgeQRvuIzpjwey2dRBw09J+ykC6CE=;
 b=lBtxkLVk/UiOKtdrRtaLn7PZlymniQ8TzCQ1GN3LcuEu7pEZpCJFKFft
 kIVjuQ73GZbpvJw8teh6IYQdppOj7cQD0FZ5TrKG+mD1vjdkF2wwr7SEE
 0F4oFAJbJCYK0pBw88NhgSxQSs0EC0PVvsjEX6qsmaiGhHxDgzUmvBwF2
 1q4PQ2Hx/Mu8hKa18qXYcVNBhBlK5fNtWpGrYGigP8dHkEdimTiD6DYKC
 kN+YoeRrwIBD2DXMOXdThBluwVfLn6bF5DDu+SOV8fBElWCc+hyerl6Bz
 oNiOv2Hh0Pdh0BunRbflni8WofXkwjAD/Mq0zIr/b7X/SDS78AkagKpVH w==;
X-CSE-ConnectionGUID: rLXQgya3TGKyGjrd/rx47w==
X-CSE-MsgGUID: mhIYwZ7/T8+GbuMOyS7JNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="648026"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="648026"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:02:10 -0700
X-CSE-ConnectionGUID: oT0m+95RS2uCx5DvgYn5FA==
X-CSE-MsgGUID: aSZMaNAeSrCsvxMHjWNJuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1941298"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:02:10 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v3 5/6] drm/panfrost: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:02:05 -0700
Message-ID: <20261014190200.1700470-13-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
References: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
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

