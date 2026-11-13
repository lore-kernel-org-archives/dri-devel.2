Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B868606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZoOiIjHB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF7D10E684;
	Fri, 13 Nov 2026 06:54:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC5210E684;
 Fri, 13 Nov 2026 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794552893; x=1826088893;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YhZIx4+TStBWENdW7UV3g1GubW7dZlq2LaYghzSaL9M=;
 b=ZoOiIjHBgFoG5priVfnRsiyOVcmWmxuLTaSJsWpg+1opN5mXHBweZWbD
 FOtRwiTWnxC7yoDaVqViImnJhPL9Zo7IZfb8gP/9qjEo1nO0N5jS4NDwG
 n7GsYgjrt1AplHVdJtU09PrNvb8lyglVJwrWH41nu7UHbfGcfgbZDOe36
 uNmtx0BV0qKI1orr36eRI0J8p++pUe7sUyB+kSyaYyQv6oXQ5m8tStTyN
 tPoI0Y3EH9VikghWPcrmhw3tTUeYn0+YZoQsBLY1HnK9GOCQRyW4Gnf87
 DfXDfnTvMvzCzhWK66mXBJQTQ24NzWIXsXcm3/rUohEA1SQK09emdMwj0 Q==;
X-CSE-ConnectionGUID: SVDtVvZaRzOnORdK694wsw==
X-CSE-MsgGUID: Hr4SMs4XSb2VmYSBklfD0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3220780"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3220780"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 22:54:52 -0800
X-CSE-ConnectionGUID: +WnrWhnCTDWNCnStM3n6bA==
X-CSE-MsgGUID: pjCSXfiFTpGzxT+LNFgG8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; d="scan'208";a="10573793"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 22:54:50 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 tejas.upadhyay@intel.com
Subject: [PATCH] drm/xe: Account for exec queue cleanup after handle
 allocation fails
Date: Fri, 13 Nov 2026 12:24:36 +0530
Message-ID: <20261113065437.249640-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe_exec_queue_create_ioctl() assigns q->xef before allocating the
userspace handle. If xa_alloc() fails, queue finalization decrements
pending_removal even though the queue was never removed from the
xarray and the counter was never incremented.

This can leave pending_removal negative and block fdinfo readers
waiting for it to reach zero.

Increment pending_removal before unwinding the failed allocation.
The existing finalization path balances the increment.

Fixes: 0fd4380c050d ("drm/xe: Wait on killed exec queues")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Assisted-by: LLM
Closes: https://sashiko.dev/#/bug/linux-0e3ad548-c571-43d0-bf6b-00ed4771bd7a
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 7ade915c59a8..39d99d6d418c 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -1471,8 +1471,14 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 
 	/* user id alloc must always be last in ioctl to prevent UAF */
 	err = xa_alloc(&xef->exec_queue.xa, &id, q, xa_limit_32b, GFP_KERNEL);
-	if (err)
+	if (err) {
+		/*
+		 * q->xef is already set, so xe_exec_queue_fini() will
+		 * decrement pending_removal even without an xarray entry.
+		 */
+		atomic_inc(&xef->exec_queue.pending_removal);
 		goto del_hw_engine_group;
+	}
 
 	args->exec_queue_id = id;
 
-- 
2.43.0

