Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC4FC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 05:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F3D10E287;
	Thu,  6 Aug 2026 05:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V4LCUVBl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FFB10E287;
 Thu,  6 Aug 2026 05:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785994596; x=1817530596;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6OpXYoIUpGRoW2pYlos10II/uJEoxc+979E99u6+I3M=;
 b=V4LCUVBllhJlWCZkqZXhMNTtDO9g4xNEHi/V73I/+lx67QpZ/M7MuHhU
 +DDzKh8IQb5Q4c0wmSfTm9AgwSF1uVlEMUfveR9HmzcGKgUBWKHkSgi3X
 qPMjtyJaSTFfWQFLs/76hbJPkflyKgDRMC8bO+4inT0uuxG+aeMACmd7S
 E3L2GJqR3jTxGEWOjWY0bOu3b/nRJgPGrB+lLqg3I/jj4xSAGabiIkSDH
 0CqTGUTpSZ9iE+i5ZB/0bCQxDe0JvjZblG8cIzuNJAyS8mHzqgXSdRPaY
 +yRZ7i4BVtHq5BzdPGqsAiEvOyWwDF/kkG4E7G9MyseN6V55kF/qNZJgm Q==;
X-CSE-ConnectionGUID: HNsRc+25RtKGLpTcByKTpw==
X-CSE-MsgGUID: z200a5kFTXud3ZoWeFqk9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="96928692"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="96928692"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 22:36:35 -0700
X-CSE-ConnectionGUID: jtkC8l0ER3K6mNFN+UhI+Q==
X-CSE-MsgGUID: C+BaDbnQTsitTK6vIByfSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="265487062"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 22:36:34 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH V4 0/2] Add gpu_buddy_allocated_addr_to_block helper and its
 Kunit tests
Date: Thu,  6 Aug 2026 11:06:24 +0530
Message-ID: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
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
physical memory address back to its corresponding TTM buffer object.

Also Add KUnit tests for testing it.

Tejas Upadhyay (2):
  drm/gpu: Add gpu_buddy_allocated_addr_to_block helper
  gpu/tests/gpu_buddy: Add KUnit test for
    gpu_buddy_allocated_addr_to_block

 drivers/gpu/buddy.c                | 53 ++++++++++++++++++++++++++++++
 drivers/gpu/tests/gpu_buddy_test.c | 45 +++++++++++++++++++++++++
 include/linux/gpu_buddy.h          |  2 ++
 3 files changed, 100 insertions(+)

-- 
2.52.0

