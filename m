Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5FBC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62AC10E7B9;
	Tue, 28 Jul 2026 05:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YOp9sXBr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE5310E420;
 Tue, 28 Jul 2026 05:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785217701; x=1816753701;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8e6Gmq6hrqGY1fuaHg7m5X/YIVpNfF/AiLoa94OHx5o=;
 b=YOp9sXBrwHo4IgA7Qsj89ArvJkUXs36uHW6aYnnlR8dJV0jXib1DGw7u
 +S+rVZ01R9Jt5GIQH7CVewOan5tVNsaK4oK/w9AelC8UpyHvATIVBDMkJ
 5OhVNS0jhr0TlXQt2id/xhpRT3gqAeMq02cK8ui9z5qQI29uRfRoYy40S
 UPvQjGBr2oWj6hk/oXaFr49MS68Z6OHKEFmj0ZLJHPa20lQYXkizVdQjz
 z2atdBowL4VO/NzkShT7luTJ6DGYLmvjRU/NlMatUK6FMtUc7MJQFD1qh
 g4OVXmCkMmoXCzD3SAng92Lm1EOAv+31mpKpqNg9+os6VUkpPv+4kgQtb g==;
X-CSE-ConnectionGUID: cn/E/+XrQdK3BUuupIi+lQ==
X-CSE-MsgGUID: Ne9dn7iTSL+H+fVzSwIkjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="108592343"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="108592343"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 22:48:21 -0700
X-CSE-ConnectionGUID: BRbMYwy4QD2bjqIzTMEzKQ==
X-CSE-MsgGUID: P3rZ/w6wS6OfCZ7ovGoRPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="256263112"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 22:48:19 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH 0/2] Add gpu_buddy_allocated_addr_to_block helper and its
 Kunit tests
Date: Tue, 28 Jul 2026 11:18:09 +0530
Message-ID: <20260728054808.2664272-4-tejas.upadhyay@intel.com>
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

 drivers/gpu/buddy.c                | 53 ++++++++++++++++
 drivers/gpu/tests/gpu_buddy_test.c | 98 ++++++++++++++++++++++++++++++
 include/linux/gpu_buddy.h          |  2 +
 3 files changed, 153 insertions(+)

-- 
2.52.0

