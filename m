Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05051CA5FE6
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E2110E6D7;
	Fri,  2 Oct 2026 22:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gPbTzROa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C230910E00C;
 Fri,  2 Oct 2026 22:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790981140; x=1822517140;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PAgQ3UtAxEf1pXAs0ECPfgEWhC4Oys1LLV/ZpGW3L10=;
 b=gPbTzROavkjJRJzUaVrFU4CAMyZAHSs0GsFbW4GRWv7d59BRyNyMYMvs
 W896QVlc+wyOhKX7TA9BxCUrkPtWsFFfTL41B3NT12S7fPKu+Z8rUTp7K
 5T7VyoWiefdBSJ5bf3xfvGEvTv5cVC2VBLjmDZGtsyqqTZLqNCq1cg+jx
 gxdKOrPQRMF4Bzb4AcRI4g1X9os7IGdWCFYkMQCRf24taqVU8gxhDRDY5
 TFDk1Eumtn91AWHBDbs1SvHmQT197psA3YkvwO3mHRmQ5zWyzaPAX/AIf
 oCbkEhUbmqCJBWQRP/f06+3/hNoPT+bbsBKcPn3S9ePIFF8kFoNg4YH8E g==;
X-CSE-ConnectionGUID: vODhbujER2C+H2kimY5Jgg==
X-CSE-MsgGUID: 2XYNNUMGSUCfWQGSZqKbmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="102273171"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="102273171"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 15:45:39 -0700
X-CSE-ConnectionGUID: ZwbYk6I9RYqkMlCZjK+W0A==
X-CSE-MsgGUID: VW8sDuj7QEWGI4mjOizEVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="274996776"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 15:45:38 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
Subject: [PATCH v1 0/1] drm/ttm: minor cleanup
Date: Sat,  3 Oct 2026 00:45:20 +0200
Message-ID: <20261002224521.781690-1-michal.grzelak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
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

Michał Grzelak (1):
  drm/ttm: remove num_pages from arguments' list

 drivers/gpu/drm/ttm/ttm_device.c | 2 +-
 drivers/gpu/drm/ttm/ttm_pool.c   | 4 +---
 include/drm/ttm/ttm_pool.h       | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.45.2

