Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B6606A327
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CDlIj5cn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4707810F33D;
	Tue,  3 Nov 2026 03:34:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A904D10E11F;
 Tue,  3 Nov 2026 03:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793676856; x=1825212856;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=542XoxkYrTGwr4XYb6PejvvnkDtwoRYMhJuHoaiJH28=;
 b=CDlIj5cnBNOdn3IBy3VW6VZd0liJWjANhfLK3XNgjaNEcFl9qjUNQtiW
 MrzqzVJ9SE7c7ezc6FHyKcUswecYCEvoaofilBsdtiSYXzOfb6mcQtDh0
 boY9F7zUkGVtIJ3FYd2CNpK9LEROuDpi/ioKEv2GC9KZYFenFpZB/nfRU
 VhukHebGhcGJAEC7sTL5qb1bdsXrG73jk1ogB3ANKhEblHhC8yvlgtvqb
 6awMGvAjF8QRylisADEM1ukjRDmBQfUCnDxDKxuVmfcG9bC0OmrKqBvcW
 X1cRZWl7/QuOt/olwSXgrYG7WTJO7zr+abQuW6x64owRTyGco6Mv9A0p6 A==;
X-CSE-ConnectionGUID: 1V+ZVHj9Spejyj0R0VpYBQ==
X-CSE-MsgGUID: 0mAhWc0tSoCx8lWTmsbD4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2380783"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2380783"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 19:34:16 -0800
X-CSE-ConnectionGUID: NMDZ4cjjS1a3bf0mLYUIkA==
X-CSE-MsgGUID: 5vNC+z7FT4KaU15RpzoLOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6159817"
Received: from junxiao.bj.intel.com ([10.238.152.95])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 19:34:12 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: dev@lankhorst.se,
	junxiao.chang@intel.com
Subject: [PATCH 0/2] drm/xe: drm/xe: Improve real-time performance by limiting
 stolen memory usage
Date: Wed,  4 Nov 2026 11:27:30 +0800
Message-ID: <20261104032732.30681-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_12_24,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stolen memory access and allocation overhead can introduce latency spikes
and jitter, which negatively impacts real-time performance on PREEMPT_RT
kernels.

To improve real-time determinism, this series minimizes stolen memory usage
when running on an RT-enabled kernel:
1. It bypasses initial plane allocation from stolen memory to avoid hardware
   access latency, falling back to standard allocations.
2. It warns the user if the GSC microcontroller is active (which relies on
   stolen memory) and provides instructions on how to disable it.

Junxiao Chang (2):
  drm/xe/display: Skip initial plane allocation from stolen memory on RT
  drm/xe/gsc: warn about GSC stolen memory usage on RT kernels

 drivers/gpu/drm/xe/display/xe_initial_plane.c | 6 ++++++
 drivers/gpu/drm/xe/xe_gsc.c                   | 5 +++++
 2 files changed, 11 insertions(+)

-- 
2.43.0

