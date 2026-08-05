Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA215C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F3710EDFF;
	Wed,  5 Aug 2026 11:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dc6Jhpbl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3309D10EDFF;
 Wed,  5 Aug 2026 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785929625; x=1817465625;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XFroAvYH17C1kIbfMY9Te9f7dnenPbxnYxawMiiS4nk=;
 b=dc6Jhpbl2iAAZu2SIWJBKpo8/9aOj41IJHnQmfYMcIY9owlYCuilq6Ix
 RlS/Ilf9kazOOTjxPrpF+G8zAMNTVD1PAFwZODUZ5UG5d4SKCxuq1jAxN
 B7TEXRfmouGDc9TTxPzjRrlQvXbWKScxrxlellwK/3vLHC6Km4oyJNqy4
 RLpQQ33qPgZf/geVTt6BtEqXLJsDObDyNBKrHBQKogvGeRKAlMvYZPLR8
 U5r2rcZ5Lh5D1kJLklXfYaatbOfOHehyG91e9oaHWxRDhSHQEqdDxcBcy
 a9+ubwzmv9BwhW8HExfL6JHT8+qAKwvEmn1B+FeLkwW9TCxi0AQe9S9Rr w==;
X-CSE-ConnectionGUID: R/PLs/xrQpiZDInRCdhlkA==
X-CSE-MsgGUID: 7eriFDEyTIqA/PxGWiTl3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86358159"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86358159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:33:44 -0700
X-CSE-ConnectionGUID: yffXgL7qQ8GKqJjwPIMxtg==
X-CSE-MsgGUID: WKTCoPiMSbiE5AxVR+5rQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="265289741"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:33:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH 0/4] Fix device page migration in low memory fallback
Date: Wed,  5 Aug 2026 04:33:34 -0700
Message-Id: <20260805113338.3742178-1-matthew.brost@intel.com>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Matthew Brost (4):
  mm/migrate_device: Fix THP splitting of a CPU faulted device private
    folio
  mm/migrate_device: Apply the fault reference to the correct folio
  drm/pagemap: Fix folio allocation fallback and use-after-put
  drm/pagemap: Add fault injection for higher-order RAM folio allocation

 drivers/gpu/drm/drm_pagemap.c | 150 ++++++++++++++++++++++++++++------
 mm/migrate_device.c           | 120 +++++++++++++++++++++++----
 2 files changed, 230 insertions(+), 40 deletions(-)

-- 
2.34.1

