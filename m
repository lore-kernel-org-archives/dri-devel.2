Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EABFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 03:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A94910E913;
	Tue,  5 May 2026 03:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S3WpD7wX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E796010E02D;
 Tue,  5 May 2026 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777951818; x=1809487818;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VLs+UnfY1inzQnEuHbP4AAscZObYAgL+FU09AZa6Duk=;
 b=S3WpD7wX+AETTGGaKQ4WMPad7PiLSZpWV2B38oi93t0/mD9spRyfrjpQ
 bekoaLt9ry0lGXf0u8j380KG7e5/2r48nL1RlmrLbzzzeb7+eg8zg77X9
 HJpJy32vYW7uq+Kfbko1wogXlVQIaxNMoCcG3Pk94cg1jzDHP3MHh9kwx
 Vcet80R7bEfiyhn4wUHqkFw+VqyLTIxoZoPMyqHqCIO1hYgZWdpJ8HlMy
 rGGUVCvcHJHwf/4EHKl9VD1lI+eWVvsaUBGeZXCD/Qdj9W3MCCUiPkurJ
 ra5/NqfRBvhoahiEeFNz9oNyY4x+G3vLvPo8Cusi+az1XVdYTZC7OYmPY A==;
X-CSE-ConnectionGUID: K/EOGPCBQvaMSF3nFEXvig==
X-CSE-MsgGUID: k+zxe3CwRq6Oldb/hpVOCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78678930"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="78678930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 20:30:17 -0700
X-CSE-ConnectionGUID: FrZ8PR9AQC+N/rUcXQKR9A==
X-CSE-MsgGUID: LXTERKywRPuVFqmldY9T8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="233031857"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 20:30:18 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/2] TTM shrinker fragmentation / partial restore fixes 
Date: Mon,  4 May 2026 20:30:11 -0700
Message-Id: <20260505033013.3266938-1-matthew.brost@intel.com>
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

Fix shrinker fragmentation / partial restore fixes. Related to [1],
continuation of [2] Patches have details.

Series working shrinker getting triggered in a loop plus the below error
injection:

cd /sys/kernel/debug/ttm/backup_fault_inject
echo 100 > probability
echo 3000 > interval
echo -1 > times
echo 0 > space
echo 0 > verbose
echo M > task-filter
cd -

Matt

[1] https://patchwork.freedesktop.org/series/165330/
[2] https://patchwork.freedesktop.org/series/165877/

v3:
 - Address sashiko concerns
v4:
 - Actual 'Save alloc in snapshot on restore failure (sashiko)' (missed
   local change)

Matthew Brost (2):
  drm/ttm: Drop tt->restore after successful restore
  drm/ttm/pool: back up at native page order

 drivers/gpu/drm/ttm/ttm_pool.c | 106 +++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 19 deletions(-)

-- 
2.34.1

