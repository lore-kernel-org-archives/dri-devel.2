Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB24CC6B2F
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2FD10EB39;
	Wed, 14 Oct 2026 19:34:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D63110EAEA;
 Wed, 14 Oct 2026 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006485; x=1823542485;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mG1U3ad02vDEJOL4quvBZjn4Hp9htxj45amkMlK/LLE=;
 b=lY+SmyCHPTIH9s6ndAy86sV9fUPeGQ1LmhSDSbTpxj4z55jXk/9G/28y
 3tI3ENbn05hItQ8gWj9sxlgYeYVUYr3fXqckZdiasXCUTnRtuD8hynQzZ
 cm+tjH3lmBa6OM41w18GpDz23+1fp/q/c7Z3ViFx1Ya08HDiz1uXRuymk
 eRT0eOTDPSCpELw8Y8a6E9WoOsO2cNKyQa4QQXt2kP9ecwx2EGNX2mLdj
 a3Wsf8rRiUs54n/UDo5vxtqE6RnaEkbSK1CCk0EG7K6BDe4eOesTQ/xY5
 vId7fdxpmBvHRNz+3kMmcHg5X5B+LhXhfL395MRlpkQirUNraM4DHWgKz w==;
X-CSE-ConnectionGUID: Ls9UmlnrSkKg5Z0+c9+kJw==
X-CSE-MsgGUID: 5hvme/U+RYGwsG4SoisJVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653875"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653875"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
X-CSE-ConnectionGUID: caJ9h2a6Rqyg21sra1Rt6w==
X-CSE-MsgGUID: PM5527boQZGFJy39YvVzrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270517"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 09/12] drm/tegra: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:34:29 -0700
Message-ID: <20261014193421.1705112-23-niranjana.vishwanathapura@intel.com>
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
 drivers/gpu/drm/tegra/gem.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index f76af733ea79..fa724dcb459d 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -768,16 +768,12 @@ struct dma_buf *tegra_gem_prime_export(struct drm_gem_object *gem,
 struct drm_gem_object *tegra_gem_prime_import(struct drm_device *drm,
 					      struct dma_buf *buf)
 {
+	struct drm_gem_object *gem;
 	struct tegra_bo *bo;
 
-	if (buf->ops == &tegra_gem_prime_dmabuf_ops) {
-		struct drm_gem_object *gem = buf->priv;
-
-		if (gem->dev == drm) {
-			drm_gem_object_get(gem);
-			return gem;
-		}
-	}
+	gem = drm_gem_prime_self_import(drm, buf, &tegra_gem_prime_dmabuf_ops);
+	if (gem)
+		return gem;
 
 	bo = tegra_bo_import(drm, buf);
 	if (IS_ERR(bo))
-- 
2.43.0

