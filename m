Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99625CC6B30
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE2D10EB0C;
	Wed, 14 Oct 2026 19:34:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0417A10EABD;
 Wed, 14 Oct 2026 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006475; x=1823542475;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hKUHWtuWX0t4EsYXN5iXg4yNlvHhbuUWHaJutwThhVE=;
 b=m4KHDPi2lNPUi6uJyi3m7mIxDkTAqU7U1r0SCsM/Tum6XalVmUaFBnYA
 QDVfPqmCx9WHb9PIvErZIxVSYixSuVW1+mfuHGrvKQZlVQ2MG1BUYXQXX
 zzHYI0PxSINQayEEVNTbKzxxHduGB/NQ0DLzAxeI5hPR7F1hmTyRnY3ZB
 dvs/llgqF6nyJKhkV9M2yTkT/lh3o4H8+5bYdeXIvgQiJbLND5XRzLIkI
 anPNxkKk+YpGTivVMQuQR3/gWA8a1oOANhLqfuiMOMKPozHXGqwfktK9F
 C/5sI+PnTAdQAQzNGcm/mt9f+HIkI7HssJj5EdvxsD0ZJwqc2I+0MBxvz A==;
X-CSE-ConnectionGUID: OjWzCnlDSTm1RM9wnaaHuQ==
X-CSE-MsgGUID: RCv64BUZTL6bZ83/PZBtGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653864"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653864"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
X-CSE-ConnectionGUID: Vf73ej3YQ/uqK+YSdtWJZQ==
X-CSE-MsgGUID: 8idepjU9RPys9BznwpQHkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270498"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 04/12] drm/panthor: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:34:24 -0700
Message-ID: <20261014193421.1705112-18-niranjana.vishwanathapura@intel.com>
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

