Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2208FCD5BB5
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CFB10F789;
	Fri, 22 May 2026 13:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n4RWHRHp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E620E10F77B;
 Fri, 22 May 2026 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779458131; x=1810994131;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TeYRv6//ki3XtJSi3FCdBTQ9zri9hdzTziBNEM2uFRc=;
 b=n4RWHRHpMHBbruDWR1fUplOJwUHJkc+jUqLSYi4Fq7ZRtEy2YWFYrty3
 BKMYma2o4jcRgSKd0s0WtrJyt4FtSRlcGnMk9Ekuranfw1cLkBd4PunXN
 C+WbbGPNsGga0zNRipb8cULI7r0D4yOkhkad76r37YDyDeeHUhVCO5+hX
 AgE8xPvvNYV3HEPsWqZSUn10vS/yfHoO/gqIBV2uar0E94feL3nFSGfua
 ADD/9kiPTezRESOKJCfoaxX0WqSNn/tAO+ubsXHUYn4mMs8Jjq/FqWome
 d3E3AirIFdM2reOh6oOq30SUasun8SDLpwTapF7zHJgqSEpApIJ1PH0C9 A==;
X-CSE-ConnectionGUID: hCviZGcJSJOamnLLBYAxjQ==
X-CSE-MsgGUID: Fmn3jBP+Soi18uPJnDmUVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97809514"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97809514"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 06:55:31 -0700
X-CSE-ConnectionGUID: VYbRZRaUTdOn4VdXEug3Vw==
X-CSE-MsgGUID: WrsDxV0PR46+0rospii1bg==
X-ExtLoop1: 1
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by fmviesa003.fm.intel.com with ESMTP; 22 May 2026 06:55:29 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
Subject: [PATCH v2 2/2] drm/managed: fix drmm_add_action() kernel-doc
Date: Fri, 22 May 2026 15:55:20 +0200
Message-ID: <20260522135520.1862848-3-michal.grzelak@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260522135520.1862848-1-michal.grzelak@intel.com>
References: <20260522135520.1862848-1-michal.grzelak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
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

Kernel-doc of drmm_add_action() references @releases which is not
on argument list. Swap '@' between 'releases' and 'action' words to fix
the documentation.

Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
---
 include/drm/drm_managed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
index 72bfac002c06..72d0d68be226 100644
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -18,7 +18,7 @@ typedef void (*drmres_release_t)(struct drm_device *dev, void *res);
  * @action: function which should be called when @dev is released
  * @data: opaque pointer, passed to @action
  *
- * This function adds the @release action with optional parameter @data to the
+ * This function adds the release @action with optional parameter @data to the
  * list of cleanup actions for @dev. The cleanup actions will be run in reverse
  * order in the final drm_dev_put() call for @dev.
  */
-- 
2.45.2

