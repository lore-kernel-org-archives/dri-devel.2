Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4A606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KV+MgvvP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1794711212B;
	Thu, 12 Nov 2026 15:03:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8327C10FE08;
 Thu, 12 Nov 2026 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794495801; x=1826031801;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=j7aW9pdjaqDYD8mwx0HYAZobtRTbWpzQvX5YIGD0rSI=;
 b=KV+MgvvPzKayfyFNLJ5f/orqbAOQXDaGmx6QlLMJeQD7Vk+teAQvLQdF
 4cYf+bBfdmInTtt8PxII+O8jZPSjOnUZx+GYGRc4HqzBXYRtg//+Ls0pu
 jh2WuZ8VcqmJbjLAiU7BiHGqLO9AwcHmPVQTHrso3lBX6WQfHsD/gLcsq
 xGt9718nFBzynqDXDOYX+ceSd4vFRLi3aN7tfNJflax5TzDWEwUEvP5fT
 wzSFaBLt/o3cBJIDzfFSRgdE0Gr4s6hY6RU0+6Y25xe02qxq65WcaNhiq
 F8WZBgHAFJ5SqLFhGqHLNF8qK1RC0p2EYOcTLYo8kOhSiCHLMhBHjz5wK Q==;
X-CSE-ConnectionGUID: qXtDviGfR9mjO6937cRR3g==
X-CSE-MsgGUID: Pnj9MnTbRxCkJ62zM12eIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3308437"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3308437"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 07:03:13 -0800
X-CSE-ConnectionGUID: 6AeGlC7DQASHSjcECPwa3g==
X-CSE-MsgGUID: vBCpCLIxTtCXtFfZiBqBnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8766911"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 07:03:10 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] CI-ONLY Fix VM teardown and migration queue recovery 
Date: Thu, 12 Nov 2026 20:32:59 +0530
Message-ID: <20261112150302.3837896-1-arvind.yadav@intel.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Arvind Yadav (3):
  drm/xe: Hold a device reference across deferred VM destruction
  drm/xe: Mark VMs as closing before queue cleanup
  [CI-ONLY]: Defer VM teardown until exec queue cleanup

 drivers/gpu/drm/xe/xe_device.c     |  23 +++-
 drivers/gpu/drm/xe/xe_exec_queue.c |  22 ++--
 drivers/gpu/drm/xe/xe_pagefault.c  |  33 ++++-
 drivers/gpu/drm/xe/xe_svm.c        |   3 +-
 drivers/gpu/drm/xe/xe_vm.c         | 191 ++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_vm.h         |  14 ++-
 drivers/gpu/drm/xe/xe_vm_types.h   |  16 +++
 7 files changed, 272 insertions(+), 30 deletions(-)

-- 
2.43.0

