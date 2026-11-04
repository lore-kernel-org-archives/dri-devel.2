Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34D60A2613
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YzAg3nQt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3EC710FEDE;
	Wed,  4 Nov 2026 20:14:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF0210FED4;
 Wed,  4 Nov 2026 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823243; x=1825359243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hrPR+6dem/A7hrPs8e7kQHfmjxGu56hxnkdpVDsxrh4=;
 b=YzAg3nQtWVOBIoEHHH4o2moALKRat11XAKYz2paSQ6/5+MkExXBvso+O
 s9BRWsuW9pTQ4OLmpe1BdXlDmSR50OPFCnpqoQs5f3qtiSFRcXWcqClyP
 OKQ0Fmyi1XnssVkwRSOkaOx0RkTRx2rw7l5Uo3eJ4CMLw+vPWLrhu0pq2
 1yUDh5nS/CkManQwV8F+RCHdi+yjtJ9STNtUTnifm9AAgxTGqW7elGNsQ
 Ur+uBoNO1ZtEysbEP45IZy/JRHep3jcBexCtf6Z+1dT2Bp/R5vZZZegfq
 mGKSXzAkUnW0eLlB7wurt+muiqQ3D2YbQRjDHz1mAGy/1LlrXjRRegRdq A==;
X-CSE-ConnectionGUID: lLAKtu9+RVSgF2IjAY2BMg==
X-CSE-MsgGUID: IBt/3pHDSdS9DrGZ25ZX8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589059"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589059"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:02 -0800
X-CSE-ConnectionGUID: 7FTw/QHVSXuH5QzneTGYWw==
X-CSE-MsgGUID: oR7n2/K4Si69cWkMXLv3yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6868454"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.20])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:00 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] drm/ttm: Don't mark backed-up shmem folios accessed
Date: Wed,  4 Nov 2026 21:13:28 +0100
Message-ID: <20261104201331.2462-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
References: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ttm_backup_backup_folio() unconditionally called folio_mark_accessed()
on the freshly populated shmem folio before copying the BO's data into
it. This path is only reached from a shrinker, i.e. precisely when the
system has already decided it needs memory back, and the whole point
of backing a page up into shmem is to let core mm reclaim it through
the normal swap/writeback path instead of keeping it pinned as TTM
memory.

Marking the folio accessed works against that: it sets the referenced
bit / promotes the folio on the LRU, so a later reclaim scan gives it
a second chance (or skips it) instead of reclaiming it on sight. This
is actively counter-productive even when the writeback backup flag is
set to synchronously flush the folio's content via shmem_write_folio():
writeback only clears the dirty bit, it does not free the page, so an
accessed folio just sits there, clean and resident, protected from the
very reclaim pass it was written back for.

Drop the folio_mark_accessed() call so these folios decay through
normal LRU aging and become immediate reclaim candidates once written
back (or once picked up by the system's own asynchronous laundering),
instead of being artificially kept warm.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_backup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 0c2d53a13b2a..9589067ad8cf 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -149,7 +149,6 @@ ttm_backup_backup_folio(struct file *backup, struct folio *folio,
 		to_nr = min_t(int, nr_pages - i,
 			      folio_next_index(to_folio) - (idx + i));
 
-		folio_mark_accessed(to_folio);
 		folio_lock(to_folio);
 		folio_mark_dirty(to_folio);
 
-- 
2.56.0

