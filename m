Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3DE10FC462
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F77B10E6F2;
	Wed,  8 Apr 2026 23:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BWGxkori";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2675610E6FD;
 Wed,  8 Apr 2026 23:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775691315; x=1807227315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VGZaWz204kl26EqIAZRfeJlkUGFG7hhzy7nYuRxfKAY=;
 b=BWGxkoriK7ECu7/+Urhkvkilq5bwG/e3ekX4fAjqJ/rhJ1sGrRixQ4iH
 EAArB+pol2WF8z9iQ3J46v7LT8YThwTqVmG0sOJKwPynbqAio1m4enQUg
 k6xU7NvAZ1BnYru/HyrBKihJOnz9KlnjZDTt0TZPtSuOknhGIW8n6mi4P
 Zz1RNtglXgsz9/dFe6f8sXq7qfMQGzL2ZRY6TgoZ6rhj7oSp7RELdEMqq
 LT0Hvd39n5I8SI7TElVkg2GKMv7Bg42tHXYRUZ4poDfyCJWpDl6vybQ3M
 8qAh/m9UwjBVF5rWYJvt11+Dnz748XWYAEt7BQ04YhbSBB6LP/NnP2GIR w==;
X-CSE-ConnectionGUID: Xa43nNqMR7aW14Rzm/6nfQ==
X-CSE-MsgGUID: FC6qipZDQ+G+VYR6K9uciQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76705981"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="76705981"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 16:35:14 -0700
X-CSE-ConnectionGUID: JQmZss9FTu+kW+X1K5t/Bw==
X-CSE-MsgGUID: Qh+Rgw21TMSFp2ADTVFA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="230273103"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.73])
 by fmviesa004-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:35:07 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona.vetter@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 1/6] dma-buf: Remove old lies about
 dma_fence_wait_any_timeout() not accepting some fences
Date: Thu,  9 Apr 2026 02:34:53 +0300
Message-ID: <20260408233458.22666-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
References: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 796422f227ee ("dma-fence: Allow wait_any_timeout for all
fences") made dma_fence_wait_any_timeout() accept any fence, even
one with a custom .wait() implementation. Update the docs to match.

Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/dma-buf/dma-fence.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 1826ba73094c..2c623c0221e2 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -884,9 +884,8 @@ dma_fence_test_signaled_any(struct dma_fence **fences, uint32_t count,
  * @idx: used to store the first signaled fence index, meaningful only on
  *	positive return
  *
- * Returns -EINVAL on custom fence wait implementation, -ERESTARTSYS if
- * interrupted, 0 if the wait timed out, or the remaining timeout in jiffies
- * on success.
+ * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out,
+ * or the remaining timeout in jiffies on success.
  *
  * Synchronous waits for the first fence in the array to be signaled. The
  * caller needs to hold a reference to all fences in the array, otherwise a
-- 
2.52.0

