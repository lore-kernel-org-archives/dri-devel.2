Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2B6CA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 01:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1CA10E6EE;
	Tue, 13 Oct 2026 01:06:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D7B10E5EC;
 Tue, 13 Oct 2026 01:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791853597; x=1823389597;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hKUHWtuWX0t4EsYXN5iXg4yNlvHhbuUWHaJutwThhVE=;
 b=UstAKQ32Rx72+tI2UlgOJ1JX9Dr3D6KpSrhR4XETTxW/cE2zpjJ3fgxf
 ImtrDpscv2qN2sNXr1fTl4SYqTqR63r3PkjEaBH8mGr1hu58JNkLS+CH3
 zXRJqnf3UAMGDtFTI0HQznRnu5djo9B8prnwaBmolJ51xlKPbI2ns5DyR
 bPYqqxtyPtW/KsDsgSc2R6HAEa6U/ARn4HF6CmAcqA8k6kpnorGdLChen
 AdGeei8TC0g91cTUCkdXsWKYppwdwLf0IlvqeUo8/hMSgzOFdYJVlN+86
 5uH0ujC8b65CYlf/76K5NWXPMuMc0tLcJi6RJ2v/1EdAQ3LUlBS7x/eRQ Q==;
X-CSE-ConnectionGUID: g2gKaNmvRjqcwjc9vPuGFw==
X-CSE-MsgGUID: Nqd9iFfVR0ijgGM7choAew==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="557196"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="557196"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:31 -0700
X-CSE-ConnectionGUID: Vf2m5xfGSMidjnI6lzLBQA==
X-CSE-MsgGUID: JMI75JPDSy6zh0bKifbe4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1360823"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:19 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com
Subject: [PATCH v2 4/6] drm/panthor: use drm_gem_prime_self_import() helper
Date: Mon, 12 Oct 2026 18:06:16 -0700
Message-ID: <20261013010614.1516799-12-niranjana.vishwanathapura@intel.com>
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
 drivers/gpu/drm/panthor/panthor_gem.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 72908be5e144..7f713c5f19cb 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -584,15 +584,11 @@ struct drm_gem_object *
 panthor_gem_prime_import(struct drm_device *dev,
 			 struct dma_buf *dma_buf)
 {
-	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_gem_object *obj;
 
-	if (dma_buf->ops == &panthor_dma_buf_ops && obj->dev == dev) {
-		/* Importing dmabuf exported from our own gem increases
-		 * refcount on gem itself instead of f_count of dmabuf.
-		 */
-		drm_gem_object_get(obj);
+	obj = drm_gem_prime_self_import(dev, dma_buf, &panthor_dma_buf_ops);
+	if (obj)
 		return obj;
-	}
 
 	return drm_gem_prime_import(dev, dma_buf);
 }
-- 
2.43.0

