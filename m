Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A42C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 21:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3126A10E258;
	Tue, 30 Jun 2026 21:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="REkTOOmL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F3910E258
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 21:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782856202; x=1814392202;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qLfOYcmcLo2kaYbXrwUssewGxfp5PDviBq5Pbno+seM=;
 b=REkTOOmLvMmNFpslfO0i7vSX1qp8J6hFv02JP6ElgW13gyBXpFGU9/xU
 4V+gzF6TALv7yV1lrrKCExtNSKnnExNcsHdG3LRVdC2PYkgvmjn+dTSn8
 F5886G91zBZXlhGq80T0wjT6w8hK2B8En5ePkW6WHHUjR39KMuT8KSlSS
 i/6dB7Virx+f9eDVS/u1XTwHKabCIOwBqf3bMwQL9gIrRBUIgqIIjvibw
 7hWuEQ/AxTdQ4WF3kKJ9zQ2IC5IwxqART0s1VybwXyqfl/qBqoal63Mqe
 SlgwQc9ittIPh9+x6umXR+9Uxz4QNaXR7LOZ0W0FApirsV6DN6rl7v9hc w==;
X-CSE-ConnectionGUID: aJ6LU/lIStWtKD3M9jelRA==
X-CSE-MsgGUID: RKi9y/TgRwiwxh+86xi9UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="71104115"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="71104115"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 14:50:01 -0700
X-CSE-ConnectionGUID: /yM0pKr9TeWNVnuUZChVlQ==
X-CSE-MsgGUID: cK7heMICRYuOypHmb7UWZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="252498253"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 14:49:58 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, jonathan.cavitt@intel.com, tobias.hector@amd.com,
 jason@jlekstrand.net, airlied@redhat.com, chris@chris-wilson.co.uk,
 christian.koenig@amd.com, david1.zhou@amd.com,
 lionel.g.landwerlin@intel.com
Subject: [PATCH] drm/syncobj: Reformat kmalloc for chains
Date: Wed,  1 Jul 2026 05:49:54 +0800
Message-ID: <20260630214954.1406447-1-jonathan.cavitt@intel.com>
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

We should use sizeof(*chains) instead of sizeof(void *) when performing
the kmalloc for chains in drm_syncobj_timeline_signal_ioctl,
stylistically speaking.  Also, wrap the line to match how the variable
points is allocated.

Concern caught by static analysis.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Tobias Hector <Tobias.Hector@amd.com>
Cc: Jason Ekstrand <jason@jlekstrand.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Christian König <christian.koenig@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
---
 drivers/gpu/drm/drm_syncobj.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index c9dbf64c0c9f..d4c5b97403ee 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1619,7 +1619,8 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 		goto err_points;
 	}
 
-	chains = kmalloc_array(args->count_handles, sizeof(void *), GFP_KERNEL);
+	chains = kmalloc_array(args->count_handles, sizeof(*chains),
+			       GFP_KERNEL);
 	if (!chains) {
 		ret = -ENOMEM;
 		goto err_points;
-- 
2.53.0

