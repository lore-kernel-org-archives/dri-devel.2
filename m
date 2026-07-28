Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E416EC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3460D10E58C;
	Tue, 28 Jul 2026 12:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YR1pWSkt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB31E10E58C;
 Tue, 28 Jul 2026 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785242692; x=1816778692;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x9rtrycHLAhuGgveYtFi82L0vpXSapLKIa0ZY1pd6tM=;
 b=YR1pWSktB3KunJ+TbWK6ECappRNaBtxnRDftF7FOTr4zKbaIBmYKYKVS
 r5Ar+RM4stNnOvo+LZz8ardAOKzhtj9GA4WgdWQMwlcxXj6KwE4Nl2jUD
 WCNewMLxPUICz7oEEgqO4O+l6ldatfgLNcida3DVjXQXsOb7HAH05gPeX
 yWgoHAMYU/2HX4q0o2S53jNiaeBgM/6rHVx6ZxsW3D/TDKJabO93Sr64f
 z9UGA4KUK4n0tTxhrjuwRTuwjkDVnMflEuydcwBN+kGpFd/Oq7kO3ZUhZ
 DNnJfH1tp7My24WZPosafPdIYYyTaSw8j13g+PA2JImxTcEW/jNLgRSd2 g==;
X-CSE-ConnectionGUID: +Ls7bvCAR5aQ9L3JINMNtQ==
X-CSE-MsgGUID: JiBfDG6vTWmqqUF4/cDtgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85838493"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85838493"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 05:44:51 -0700
X-CSE-ConnectionGUID: TDZ1IMrnR1GIDRVpGLZLOA==
X-CSE-MsgGUID: oWC5BmY2QoWaIJHJLSWh3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="284234883"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 05:44:49 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
Subject: [PATCH V3 0/2] Add gpu_buddy_allocated_addr_to_block helper and its
 Kunit tests
Date: Tue, 28 Jul 2026 18:14:39 +0530
Message-ID: <20260728124438.2679542-4-tejas.upadhyay@intel.com>
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

v3
- Drop unused target_addr variable
v2
- Drop the mutex and lockdep annotation; standalone KUnit tests do not
  register a driver lock.

Tejas Upadhyay (2):
  drm/gpu: Add gpu_buddy_allocated_addr_to_block helper
  gpu/tests/gpu_buddy: Add KUnit test for
    gpu_buddy_allocated_addr_to_block

 drivers/gpu/buddy.c                | 53 ++++++++++++++++++++++++++++++
 drivers/gpu/tests/gpu_buddy_test.c | 41 +++++++++++++++++++++++
 include/linux/gpu_buddy.h          |  2 ++
 3 files changed, 96 insertions(+)

-- 
2.52.0

