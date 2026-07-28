Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6282CC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF70610E8C2;
	Tue, 28 Jul 2026 11:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mtJrwUKg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEFFF10E16A;
 Tue, 28 Jul 2026 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785239379; x=1816775379;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0sLUZj+GUQwWi4JKVemfIV4HSgIl+m6WLXkAkSrAcgI=;
 b=mtJrwUKgbUOwXvRdHC1c9ZF5mYn+Z+cSiyPegHWZaasHoGuiIc/ME6P8
 G+bqYLgBwj4xOeewyZ14QtifaJIjw4zCTD04AoEVuSZCAXnDkYwW6yUtz
 JVq6N0iVPR0N3kAzEK91rOkmSzuqYfoVCIEs1psR+e4GRuMn2CV/cvZEY
 dvBzg1fmHv5t3TX6D5HB6RuUFYA8rogtoejKHiL5/9h4rWN4gWIfmj2no
 FYLgwe1nNIjkw7tQbOwhI6dWPL1v96WHACSZKcVZJPdC+peRHlZCeHqwX
 L1Gm/b13e0M7ZWkV9G55+QCOASGYfnupqF9KaLr+k++tePbjL20eO+lyO w==;
X-CSE-ConnectionGUID: VB8cBIIJRkqu8qEq2kKz/g==
X-CSE-MsgGUID: T3l3eE06RaupYd6MDsk45w==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84798290"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="84798290"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 04:49:38 -0700
X-CSE-ConnectionGUID: q6vlnquDT9G4rmE5V4uWxA==
X-CSE-MsgGUID: AkQxvuRXTDmUsejYgC07vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="257875869"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 04:49:37 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH V2 0/2] Add gpu_buddy_allocated_addr_to_block helper and its
 Kunit tests
Date: Tue, 28 Jul 2026 17:19:24 +0530
Message-ID: <20260728114923.2675866-4-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
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

Add helper with primary purpose is to efficiently trace a specific
memory address back to its corresponding TTM buffer object.

Also Add KUnit tests for testing it.

v2
- Drop the mutex and lockdep annotation; standalone KUnit tests do not
  register a driver lock.

Tejas Upadhyay (2):
  drm/gpu: Add gpu_buddy_allocated_addr_to_block helper
  gpu/tests/gpu_buddy: Add KUnit test for
    gpu_buddy_allocated_addr_to_block

 drivers/gpu/buddy.c                | 53 ++++++++++++++++++++++++++++++
 drivers/gpu/tests/gpu_buddy_test.c | 43 ++++++++++++++++++++++++
 include/linux/gpu_buddy.h          |  2 ++
 3 files changed, 98 insertions(+)

-- 
2.52.0

