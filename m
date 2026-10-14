Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D0C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5906210FEB6;
	Wed, 14 Oct 2026 19:35:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 760FA10EB35;
 Wed, 14 Oct 2026 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006490; x=1823542490;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=O37UDfTLxhwwryZUoC61XEEQ3m3whms20qxsGyrfEIE=;
 b=dGnHR07RtdZiyhia96Z6rK8uahCieO8nSydQknWLC1EymmKe9g5P0wpI
 DQPAjzeed0fg+4m/MLEA8ju2tMYABYaqomdgtW0h2yC2DrxBOTskKlF6q
 O0Iqsc/0ZSV+EYdLhTYnngq1llqi+vmv2uB2/jKCrmV8Mmf1FfTSBFHOX
 0ekkh9gy4XFqfitjQ8NcGsq66tZR5dOVsWcwuqWogY9e9Gx85Jy9gSGma
 SfFtv6CcLJaC8Swh7SMWFTVJTB9xZ1soX76a2O/8NFlkl/1FtXQQETXxv
 T3KUsHtgLMjahfOUv9lzgqUYiuiR/zhgtvNURaDnczy40sCb8NyYtIIrR Q==;
X-CSE-ConnectionGUID: tPn68TYLSKOfqBjVEE7BXQ==
X-CSE-MsgGUID: Yq+rCZbeRbChWyOjpfcJ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653879"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653879"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
X-CSE-ConnectionGUID: HMD/l+qyQmyT62DC5acuWw==
X-CSE-MsgGUID: XRvLvu1nRv2W1/WxZfLgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270529"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:30 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 12/12] drm/i915: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:34:32 -0700
Message-ID: <20261014193421.1705112-26-niranjana.vishwanathapura@intel.com>
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

The force_different_devices selftest hook is preserved by dropping the
returned reference and falling through to the normal import path.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index b43d34c7d641..9a27c8c82881 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -284,20 +284,17 @@ struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
 	static struct lock_class_key lock_class;
 	struct dma_buf_attachment *attach;
 	struct drm_i915_gem_object *obj;
+	struct drm_gem_object *gem_obj;
 	int ret;
 
-	/* is this one of own objects? */
-	if (dma_buf->ops == &i915_dmabuf_ops) {
-		obj = dma_buf_to_obj(dma_buf);
-		/* is it from our device? */
-		if (obj->base.dev == dev &&
-		    !I915_SELFTEST_ONLY(force_different_devices)) {
-			/*
-			 * Importing dmabuf exported from out own gem increases
-			 * refcount on gem itself instead of f_count of dmabuf.
-			 */
-			return &i915_gem_object_get(obj)->base;
-		}
+	/* is this one of our own objects? */
+	gem_obj = drm_gem_prime_self_import(dev, dma_buf, &i915_dmabuf_ops);
+	if (gem_obj) {
+		if (!I915_SELFTEST_ONLY(force_different_devices))
+			return gem_obj;
+
+		/* Test only: drop the self-import ref and force the slow path. */
+		drm_gem_object_put(gem_obj);
 	}
 
 	if (i915_gem_object_size_2big(dma_buf->size))
-- 
2.43.0

