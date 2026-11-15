Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A56606A31E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHsK4jZD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C340810E1AB;
	Sun, 15 Nov 2026 10:23:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1AF10E067;
 Sun, 15 Nov 2026 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794738216; x=1826274216;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=syet5wcMIGwIGHW5F1/cLb/PQJScyEISRQN71Urn1Ro=;
 b=nHsK4jZDEZwX3B7JNz+eXQq+2jVS5WajILpb2c7Q+P8qSA5MZeMQM45Z
 XEDZFl/9ASCI0nJ7EBShyMBi2VOovc8LAl4Mrx3Xynj+/PnQoXPPEYeId
 8MZdhQxdoRyIdBnlLD4X7Gp0y/xxCS6PIeQTTK3P42IR1zYkvkJA94m/V
 iqOLNlFudO1CEQjiXPZOol1MZy6kpVPh9J7deiRbmX6LWMmcHXdjmtg1+
 T7/Zu3L62zegjxiUCYP3DlpBmXZYqk8Tyj7ebzHddb+MHwun9N1pCR35Z
 f/rWHuKLYjt1t4+P1YsLdUOe6kMRn6ZUCyj0BTl5J6JME21iYG760Xj1Z g==;
X-CSE-ConnectionGUID: /1LGYi9GQPWC9S2RCVCscw==
X-CSE-MsgGUID: LN2/1a9kRT2bVtZVaOdYBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3531463"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3531463"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 02:23:36 -0800
X-CSE-ConnectionGUID: ord+KUoBQWmogFpMVN5ZuA==
X-CSE-MsgGUID: ZOHDZVBBRQK0PikqXW4CIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9468596"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 02:23:34 -0800
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
Subject: [PATCH v2 0/1] drm/ttm: minor cleanup
Date: Sun, 15 Nov 2026 11:22:36 +0100
Message-ID: <20261115102237.3091682-1-michal.grzelak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
X-Archived-By: <archiver.kernel.org>
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

Next version of [1]. Included ttm's maintainers into Cc: list.

BR,
Michał

[1] https://lore.kernel.org/dri-devel/20261002224521.781690-1-michal.grzelak@linux.intel.com/

---
Changelog:
v1->v2
- include ttm maintainers in Cc: list

Michał Grzelak (1):
  drm/ttm: remove unused num_pages

 drivers/gpu/drm/ttm/ttm_device.c | 2 +-
 drivers/gpu/drm/ttm/ttm_pool.c   | 4 +---
 include/drm/ttm/ttm_pool.h       | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.45.2

