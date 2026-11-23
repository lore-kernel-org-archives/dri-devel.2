Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C7606A330
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EG246gS6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB2D10E76D;
	Mon, 23 Nov 2026 12:31:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF5710E76D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795437074; x=1826973074;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Zi2Jr8R15Cer++hvJocwT7HbnrhTKE9bZDw8hOdhdck=;
 b=EG246gS6J7RL6G6MC0EXqKz8Pp8hHYG7i56wdj9qfh6Y0IyZMEs6C8Bs
 R0+GI3lepeabwddMhaH2j5iVccaxQR1k4HL3MbBTcK4aiR/svKHvG0N19
 RcJVZEfLZVzYnfUkcnh+Iqv0y3L3103Ul+Uqsvy9jVfU/MsDc099IkC9M
 2HVJwxDOGvVKGPj7JxhvSB/t1i1Cfe2ehTJKHTI9d+HZDTnAqdR75yQK2
 EFbEO7c7TgVhcGO2C7YR9sGh0/+54hq37Hr1aWiD1DooSqmO2BQuAW7Pa
 wQGm+wNKAMShPpqbPE70qyGfGPR29LFsNS8qlRjOeGIzNihEkmBRWsF3H g==;
X-CSE-ConnectionGUID: esiXWjwZS4m6ghYkycdPzg==
X-CSE-MsgGUID: apB/rMFLS3KDty+tJQKurQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4137808"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4137808"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:31:13 -0800
X-CSE-ConnectionGUID: tYLevqRtT2qgcRX9sYOYHQ==
X-CSE-MsgGUID: 8UeKGM8gQEqSBZkUfBqmNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11620245"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:31:11 -0800
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Dawid Osuchowski as Intel VPU maintainer
Date: Mon, 23 Nov 2026 13:20:07 +0100
Message-ID: <20261123122007.2580451-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add myself as a new accel/ivpu driver maintainer.

Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcade5bfbafe..0afa391498d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8198,6 +8198,7 @@ F:	include/linux/power/smartreflex.h
 DRM ACCEL DRIVERS FOR INTEL VPU
 M:	Karol Wachowski <karol.wachowski@linux.intel.com>
 M:	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
+M:	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.43.0

