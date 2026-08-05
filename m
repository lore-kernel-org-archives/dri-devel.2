Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA2BC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8576510EFA5;
	Wed,  5 Aug 2026 19:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fupgxOJR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B693A10E0FB;
 Wed,  5 Aug 2026 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785958542; x=1817494542;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sDSmB04u7511d8QYCqjiDsa689yH07QzsyscRbCuKVs=;
 b=fupgxOJRHAD1lFn07u4Fi94mgIQaX3lrisibBkfbT1+Id1H09x/v7Nl7
 M55SFScyXWvfS1OTQb966Rk/hrfMZf7k9QPiLXzn2uz+cRBgsfyws/UJn
 3lFwvHZueadKVOPVMWdFyLEouFsOj8dTr8ArnrhLqivzLSa5kUboXD3vP
 QTtzbrCNzFrc5V//WOr7garb1xjLcUJDxm3/PKX+14Jonxb6AaubvHJaS
 CzqCTy8zaQvltAT2PAgV9FqbF6vDjBYywzw7EBaLy1t/3l7Z/gA9R4Rbs
 Caf70NN10NxcFmg5yEfmY74mBwMZ/p9Mt4jyxb3Kkj6wYvy4vEBznCM23 Q==;
X-CSE-ConnectionGUID: Pt0xfMuATP69oH9Gp2LdrA==
X-CSE-MsgGUID: q2lDlR3HT9u6i4N7zG6zHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109332915"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="109332915"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:35:42 -0700
X-CSE-ConnectionGUID: wi5TCODVRw2LpdBi1XBMNA==
X-CSE-MsgGUID: iFC1GBGTRZ6KFQ5eCCRW/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="285263511"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:35:42 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Fix device page migration in low memory fallback
Date: Wed,  5 Aug 2026 12:35:31 -0700
Message-Id: <20260805193536.3756457-1-matthew.brost@intel.com>
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

[1] https://sashiko.dev/#/patchset/20260805113338.3742178-1-matthew.brost%40intel.com

Matthew Brost (5):
  mm/migrate_device: Clear MIGRATE_PFN_MIGRATE on all sub-folios of a
    split THP
  mm/migrate_device: Fix THP splitting of a CPU faulted device private
    folio
  mm/migrate_device: Apply the fault reference to the correct folio
  drm/pagemap: Fix folio allocation fallback and use-after-put
  drm/pagemap: Add fault injection for higher-order RAM folio allocation

 drivers/gpu/drm/drm_pagemap.c | 164 ++++++++++++++++++++++++++++------
 mm/migrate_device.c           | 129 ++++++++++++++++++++++----
 2 files changed, 251 insertions(+), 42 deletions(-)

-- 
2.34.1

