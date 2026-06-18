Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B91ACD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F7610F011;
	Thu, 18 Jun 2026 15:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KGJuMuyW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D56810F011
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781796358; x=1813332358;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=77+wQQMQWBjHw1DWKsXIkhJ2wm915s3Ac5l6PbtozWM=;
 b=KGJuMuyWCd2t853QnuJ0Bnq+G8cN2vNdZBeej/Ht72xbSgv2/nfaqFz/
 /+SAUJbV/fzkkYS/BbLsOn6139W6kFeVx8ke54Xteo0UcW29kEXSwF2hn
 NTNFCfsrT5pfshMPyQtz1Of2EF3NMA2GiCdueoQwPCKAN4PGuTCOPyUi+
 J5OeW/VIokmDvxX4OUYi0NjwN5DwTtvkPFokBJN0KdqvcTnvJLAKt1z/2
 jUvZCB/5FxuOWRjFKCSSlWB0QzUkRLAiPtyojXQkr3v9SPda4jtvxiCot
 rvRfMjJiDOhecY5lDALuAhphY3+W0hFpZeRVyelqVs1UKAIB6L668i5ZA g==;
X-CSE-ConnectionGUID: EfqU/b3kRy6PnQw0F5WiYw==
X-CSE-MsgGUID: phfwMQN6T0uoQf5+UeWR1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86314279"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="86314279"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:25:58 -0700
X-CSE-ConnectionGUID: wrDY2cxxQA2HJr6aCGn+PQ==
X-CSE-MsgGUID: 5MrmH+tVQ+K+cf7OKtxctQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="250291650"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.244.96])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:25:54 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH 2/2] gpu/tests: Add a dedicated .kunitconfig
Date: Thu, 18 Jun 2026 17:23:31 +0200
Message-ID: <20260618152331.36763-3-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
References: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
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

Add a dedicated .kunitconfig for running the GPU buddy allocator tests.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---
 drivers/gpu/tests/.kunitconfig | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 drivers/gpu/tests/.kunitconfig

diff --git a/drivers/gpu/tests/.kunitconfig b/drivers/gpu/tests/.kunitconfig
new file mode 100644
index 000000000000..fd611b3dfe09
--- /dev/null
+++ b/drivers/gpu/tests/.kunitconfig
@@ -0,0 +1,2 @@
+CONFIG_KUNIT=y
+CONFIG_GPU_BUDDY_KUNIT_TEST=y
-- 
2.45.2

