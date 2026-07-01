Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56519C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B792710E5CD;
	Wed,  1 Jul 2026 14:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jIq/Onj+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FF110E4C1
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782916277; x=1814452277;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Hz1Mgg9oMRCWopbV+9hgoxGte1BihnXtyhFtydMHWVk=;
 b=jIq/Onj+kALBS5I6yu1IjoutsiWsza3Y6JR5+HniI+6nFApzJj1ssW7L
 tpiJnUKPAYS417GJxQzyN1oFs7E8MLEgaGjh8NwPXG2bQHk51LBrCoglM
 bAc5SjU0Zzxb5O7r80HcjVuBI/X/D1oAdtknLticjxNMl7sJXBsY3W2iT
 ZvN9ofc+9Q9Zkxf2aWZid/WTyQDMYA1ZZod6R8Wi6JlatZesN06A7dVX/
 Ao4WfMBAuLz15q5VtbQp5xP2EY4ptkB7EF/saUZA+5V5uZeDamwBPc9W+
 CdxqR/PEqw12vXYiM5fvzumA7wSkhQLGNCePOyj9E0+FZ88bl1W484VTx w==;
X-CSE-ConnectionGUID: bAzTYvxOTWyD32sDw/SH0Q==
X-CSE-MsgGUID: NQaS0jSFSEK07//5pi8XTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94249933"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="94249933"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 07:31:17 -0700
X-CSE-ConnectionGUID: us/NUwmhT2ukmNr9+9KisA==
X-CSE-MsgGUID: 3Y25KWDWRpu/BiwrCGmvdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="253233806"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 07:31:15 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, jonathan.cavitt@intel.com, tobias.hector@amd.com,
 jason@jlekstrand.net, airlied@redhat.com, chris@chris-wilson.co.uk,
 christian.koenig@amd.com, david1.zhou@amd.com,
 lionel.g.landwerlin@intel.com
Subject: [PATCH] drm/syncobj: Use kmalloc_objs for chains
Date: Wed,  1 Jul 2026 22:31:11 +0800
Message-ID: <20260701143111.1410442-1-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use kmalloc_objs instead of kmalloc_array when initializing chains in
drm_syncobj_timeline_signal_ioctl.

Concern caught by static analysis.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Tobias Hector <Tobias.Hector@amd.com>
Cc: Jason Ekstrand <jason@jlekstrand.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
---
 drivers/gpu/drm/drm_syncobj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index c9dbf64c0c9f..2fa170a29a62 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1619,7 +1619,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 		goto err_points;
 	}
 
-	chains = kmalloc_array(args->count_handles, sizeof(void *), GFP_KERNEL);
+	chains = kmalloc_objs(*chains, args->count_handles, GFP_KERNEL);
 	if (!chains) {
 		ret = -ENOMEM;
 		goto err_points;
-- 
2.53.0

