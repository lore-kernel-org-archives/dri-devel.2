Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5998BCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31CE10E2F8;
	Tue, 12 May 2026 11:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y2WobDpG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 102B710E2F8;
 Tue, 12 May 2026 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778583846; x=1810119846;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7KOlaCmQVQ38tmd3TXFpuRwgbIM2E/PLAoYmYrZ5mX0=;
 b=Y2WobDpG4CSJaZu/BJcSyrd10/KV34QMv9u2l2Bim+jcXdSXQ2vN2vpw
 nz+kD232gm55SjDVAAtrrJH901NEDxpGSoNOup3bKaVorNpIJEgSfqA+0
 eItWJvQhe31FrL/Pw3xYZa7vAdgvR1HSwQr0PGKXCrye1MgHrqITK9gzN
 XuhDHEKRd6BsyJDqWyOBy3rWudf31M8a6z5TFSBMhui9JndP7cTyd3Kkz
 cLjdV5s2t+1gQNQtybhDOhIT6op5j9hI2s7xwK6TsSGN3Uj2aQAeAicmB
 5+gRn8tmyJYen9lgvmNNtJ8iPFUR2LtX0rQn28my6s78bv9CK+G2ml5Mp Q==;
X-CSE-ConnectionGUID: ykih6GgER3uWmSOD8tZMMw==
X-CSE-MsgGUID: 1G5qVnmkRAuyGZMPSlO8EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="104944450"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="104944450"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 04:04:05 -0700
X-CSE-ConnectionGUID: TOA3ylJtRESQSd0LzmadNg==
X-CSE-MsgGUID: XsVunJPJTWeK9QXHKv0OgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="231339480"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.245.172])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 04:04:00 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Insert instead of copy pages into shmem when shrinking
Date: Tue, 12 May 2026 13:03:37 +0200
Message-ID: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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

To be able to easily maintain pools of pages mapped uncached or
write-combined, TTM doesn't use shmem directly for buffer object memory,
but on shrinking, page contents are backed up to shmem objects so that
the content later can be swapped out.

At shrink time that puts some strain on the memory reserves. To copy
a high-order page, one either has to dip far into the kernel
reserves (one high-order page size) before any memory can be released,
or one can chose to split the high-order page into order 0 pages and
free them as soon as they are copied. The latter approach is used
by TTM but that tends to fragment higher-order pages.

One approach to get around this is to insert the higher-order pages
directly into shmem objects, so that if CONFIG_THP_SWAP is enabled,
they can be swapped out without splitting. And at shrink time there
will be no additional memory allocation save for the shmem radix tree
allocations.

Add a shmem interface to insert isolated pages, with enough
asserts to avoid a user of the interface inserting pages
confusing shmem. Then make TTM use that interface.

As an alternative, one could add an interface to insert pages
directly into the swap cache, but since the swap cache doesn't seem
intended for inserting pages for which we don't immediately
schedule a writeout, the shmem approach was chosen.

Thomas Hellström (2):
  mm/shmem: add shmem_insert_folio()
  drm/ttm: Use ttm_backup_insert_folio() for zero-copy swapout

 drivers/gpu/drm/ttm/ttm_backup.c |  92 ++++++++++-----------------
 drivers/gpu/drm/ttm/ttm_pool.c   |  67 ++++++++++++++------
 include/drm/ttm/ttm_backup.h     |  11 ++--
 include/linux/mm.h               |   1 +
 include/linux/shmem_fs.h         |   2 +
 mm/page_alloc.c                  |  21 +++++++
 mm/shmem.c                       | 105 +++++++++++++++++++++++++++++++
 7 files changed, 216 insertions(+), 83 deletions(-)

-- 
2.54.0

