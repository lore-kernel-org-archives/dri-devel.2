Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55E9CD343A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 23:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A4E10E8CC;
	Mon,  4 May 2026 23:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jvGZCYrm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED95510E8C0;
 Mon,  4 May 2026 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777937355; x=1809473355;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RAvHjsmBogTI+HCW8YZ1PYhXjsoOi1ZYl0BTabNyMlQ=;
 b=jvGZCYrma3hhIS5uBUWUgHoJMPzGYNQuJpSaDRRtLekzZyeeepLXxJTV
 E9X4lZ0k+xbTom1FgPZSRhOPs1PMZvAWfxzQ7NH8CFVu1OOuIQTJGt6Uv
 eGZk/PaZSi25uHXX5ePCjJ62sey89hva2t7RaXCUyue19SUCIXCGT4EnW
 8dvTc3BQ5FKXhJYX9CIJ+LqcxsSXVRjzWeHJ2NMmODOAXHnQCiw7u5fSy
 6bdvJjlydKkbf/rhyy4E/WOKjDBv1Y1Ey1m2EZzVALIne9hZFOe0dp4cf
 lntHZYnIaQtAHnMVoks9MkAyILV3k3hA5iDkUnEoD659pvEcgi31oyBAj A==;
X-CSE-ConnectionGUID: OGISwhzjRNOoIOVgdxAU8g==
X-CSE-MsgGUID: jHE5RhOST3KR0ZyYMOvFBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89497274"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="89497274"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 16:29:14 -0700
X-CSE-ConnectionGUID: GEiKY8+TQvmhV63irZ1gMA==
X-CSE-MsgGUID: iSfvQR17TtyGvOCTixBzog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="239626111"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 16:29:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] TTM shrinker fragmentation / partial restore fixes 
Date: Mon,  4 May 2026 16:29:08 -0700
Message-Id: <20260504232910.3249376-1-matthew.brost@intel.com>
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

Matthew Brost (2):
  drm/ttm: Drop tt->restore after successful restore
  drm/ttm/pool: back up at native page order

 drivers/gpu/drm/ttm/ttm_pool.c | 89 ++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 15 deletions(-)

-- 
2.34.1

