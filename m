Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCCC561E6
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5037F10E244;
	Wed,  5 Aug 2026 23:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JkNwL9WW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4131510E042;
 Wed,  5 Aug 2026 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785971449; x=1817507449;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wcrrRa+4I//FxNzlk8YFHVMlyypMuuBxwcQUh0A+gu8=;
 b=JkNwL9WWvQwmnNSzfc3IudCXyhzVWtYryKJ3s68IretCUxpKSdr4XrHb
 lvEIM3HjwtnzS/vm7AK2TSxWo9uJI8verOnVLeZdo6uT2KMtylSPfiawP
 4mxDM5oJYVRMSv6TCXXjRy17gEN1A0Uaw4H6y51tde2TRFlhdHTuNG7Cz
 dS44p75Z5X9PIAfplKcY07db4L2g9q+glLLufEeAdkt4NwJBQE/bpEFDK
 uGBKsbs6ziVdVRZS5E7T/giSkIt/I2/g8Ol5oHTfqi1oIAqk56k/87TiZ
 LUpB8jS8sBbDzUqtNJRRoFhqv9+F03hPcRgbiqy3fjiXdBNkmH0PRXjCD g==;
X-CSE-ConnectionGUID: UQxE9usIR62xIUrW5muvsw==
X-CSE-MsgGUID: WntvkMqaSiuWl3Fgkhf5gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90376829"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="90376829"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 16:10:48 -0700
X-CSE-ConnectionGUID: 3FGNTL4dTl+jHwbqofn0pA==
X-CSE-MsgGUID: Wyo0mZ6BQbGq1+nnfgAAiw==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 16:10:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Fix device page migration in low memory fallback
Date: Wed,  5 Aug 2026 16:10:35 -0700
Message-Id: <20260805231041.3791771-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

LLMs made my breakfast, lunch, and dinner. Not really. They served as an
assistive tool while I performed the debugging, testing, and analysis
needed to isolate the root cause in core MM while fixing a known DRM SVM
issue involving THP allocation failures in the CPU fault-to-device page
migration path.

When a CPU faults on a device private PMD and the driver cannot allocate
a compound destination folio, the source THP has to be split. That path
is broken: the CPU fault reference makes the split always fail, and it
demotes the PMD only in the faulting VMA, leaving any other VMA mapping
the folio pointing a huge PMD at an order-0 page.
The latter is memory corruption, previously masked by the former.

The DRM side had its own problems in the same fallback: there was no
order-0 fallback at all despite a TODO saying one was needed, the error
path computed folio_order() after put_page(), and once the destination
is demoted to order-0 the source page array has to be populated per
page rather than per folio head, or the copy stops after one page.

Validation was performed using xe_exec_system_allocator. The issue was
initially discovered on systems configured with an artificially
constrained memory footprint (mem=8G), where failures occurred
intermittently. Error injection was then introduced to reliably
reproduce the failure condition, enabling thorough validation of the
fix. Results were confirmed through pass/fail A/B testing.

Matt

v2::
 - Add assert in 'Fix folio allocation fallback and use-after-put' for
   THP placement invariant which Sashiko hallucinated as a bug [1]
 - Add 'Clear MIGRATE_PFN_MIGRATE on all sub-folios of a split THP'
   (Sashiko)
 - Fix checkpatch issues (CI)
 - Swap cache issue flagged by Sashiko [1] not fixed as this code doesn't
   appear reachable (i.e., dead code). Can address in a follow up if
   needed
v3:
 - Noticed Arvind's patch [2] fixes some of core issues attempting to be
   fixed to in v1, v2. Verified Arvind's patch works as expected and
   including it in this rev for Intel's CI which is based on drm-tip and
   does not have Arvind's patch. Dropping unnecessary fixes from v1, v2
   as a result.
 - Include 'mm/migrate_device: Do not write past the end of the src_pfns
   array' unrelated fix flagged by Sashiko in v2
 - Include 'dma-unmap pages before handling migration errors'
   unreleated fix flagged by Sashiko in v2

[1] https://sashiko.dev/#/patchset/20260805113338.3742178-1-matthew.brost%40intel.com
[2] https://patchew.org/linux/20260728062832.1107127-1-arvind.yadav@intel.com/

Arvind Yadav (1):
  mm/migrate_device: Clear stale mapping after freeing swapcache

Matthew Brost (5):
  mm/migrate_device: Do not write past the end of the src_pfns array
  mm/migrate_device: Fix THP splitting of a CPU faulted device private
    folio
  drm/pagemap: dma-unmap pages before handling migration errors
  drm/pagemap: Fix folio allocation fallback and use-after-put
  drm/pagemap: Add fault injection for higher-order RAM folio allocation

 drivers/gpu/drm/drm_pagemap.c | 176 +++++++++++++++++++++++++++-------
 mm/migrate_device.c           | 115 +++++++++++++++++++---
 2 files changed, 248 insertions(+), 43 deletions(-)

-- 
2.34.1

