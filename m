Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C3606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fo/4Ylm1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4213D10F91A;
	Tue, 17 Nov 2026 20:03:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C6B10F915;
 Tue, 17 Nov 2026 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794945780; x=1826481780;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ayfZer0RTa7ZA/R6ccAMP7KlfoIBJeI9rndz4vTLaOA=;
 b=Fo/4Ylm1EklPAVq/qv91/YVVmVF0oGKroYs1nStiPTYaMhXnr7q7l/Cs
 cWQ2vY7lDC4NUuSMWNKB2fWf8JMxJFFvdVT+Iw3DqtiSdIXO6xWnh8Tqh
 eDNYAt+YmBSmW9uC1HGHrT0vBc90pzd3pQbVFv7k0sf3bpWelHjkr4sF0
 32mVnaNGULzHPVi9XAVWW7HDIF+/yznAF0aY2TMXrGBcw7F5tX7j+5pHT
 dVDOKryJPREkJFBjCjVudTNjK7L62sw338S0LRUg0xjQBb3MIrwNEHwSk
 g3oCMHPLCQeVaHdON0a4P1bmnsuRGWHxIGA4r24PXbONd76Lmooqu+YGd Q==;
X-CSE-ConnectionGUID: yFUSnqYrStScc+UdEf6oIA==
X-CSE-MsgGUID: LPjUL/lxR5GJhNyayTynAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3655986"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3655986"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:00 -0800
X-CSE-ConnectionGUID: Sq8jdKQTR0Wz3EdCDl5Xxw==
X-CSE-MsgGUID: 3lU1O+RRR9us8FWZ5igfMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10173448"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:02:58 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 0/6] drm/atomic-helper: Eliminate the fake_commit spurious
 -EBUSYs
Date: Tue, 17 Nov 2026 22:02:47 +0200
Message-ID: <20261117200253.27078-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Eliminate the spurious -EBUSYs caused by the fake_commit
used on CRTC-less planes/connectors. The -EBUSY also
acted to limit the queue depth, and with the -EBUSY
gone that now needs its own stall handling to avoid
oopsing the kernel.

Assisted by Claude Sonnet 5.5

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Ville Syrjälä (6):
  drm/atomic-helper: Limit run-ahead of fake commit only commits
  drm/atomic-helper: Complete fake_commit->flip_done in setup_commit
  drm/tests: Test fake_commit->flip_done completion
  drm/atomic: Store the device in drm_crtc_commit
  drm/tests: Test the device stored in drm_crtc_commit
  drm/tests: Test limiting the run-ahead of fake commit only commits

 drivers/gpu/drm/drm_atomic.c                  |  14 +-
 drivers/gpu/drm/drm_atomic_helper.c           |  61 ++++-
 .../gpu/drm/tests/drm_atomic_commit_test.c    | 238 +++++++++++++++++-
 include/drm/drm_atomic.h                      |  15 +-
 4 files changed, 313 insertions(+), 15 deletions(-)

-- 
2.56.0

