Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBD7CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CDD110EF19;
	Thu, 18 Jun 2026 15:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T2aBjDLH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0214C10F333
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781796351; x=1813332351;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WDz2ha6tKNTUlpODR5evJoUcZ4GLg7rxEhs2UgEq/BU=;
 b=T2aBjDLH1S9m45WiZnk8d24rB6tAMKwT/ES3eN9MJvbrEVH3KR8EH75u
 yStNu+Qfv1XjLvEFbY7NqWqfYF0epVQU/QMnbwMe1xVpAxo470nvK7qy2
 MlCcZh0dGnRjyMIzaR4FzrLXJzMm4W0K8s85aEJT5shzg3G43nCTL0iAX
 tHMLP6mjV1YogSE064mrRijcWOuTkeFWhM16/p9fUhtm2qq93oKdYYshi
 n4TgwoC+Mdm7Xn/oJaRfX3p4T7rDOKLvPmdp22gIsfYEEQO3AepphVUqz
 VLeoLBhPQKw7GgJnCdFkWAN8rzAKPrDj3TOHR17MFldx1yzULxowViwhL w==;
X-CSE-ConnectionGUID: 0apiSdy5Tt2/ZCpxa+03LQ==
X-CSE-MsgGUID: mDx+gLtDR/+gcllxeKI2Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86314265"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="86314265"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:25:50 -0700
X-CSE-ConnectionGUID: I67UsnQfQhaOkwEy0ydPDw==
X-CSE-MsgGUID: cYvleTUyT4GZEbIX52bYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="250291645"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.244.96])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:25:48 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH 1/2] gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST
Date: Thu, 18 Jun 2026 17:23:30 +0200
Message-ID: <20260618152331.36763-2-krzysztof.niemiec@intel.com>
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

CONFIG_GPU_BUDDY is currently not selectable by the user, mirroring
how CONFIG_DRM_BUDDY does it - the idea is for a driver that makes use
of it to include a "select GPU_BUDDY" line in its kconfig.
CONFIG_DRM_BUDDY is also selected when building with
CONFIG_DRM_KUNIT_TEST, as it can be thought of as building a mock
"driver" running the tests, that makes use of the buddy functionality.

CONFIG_GPU_BUDDY_KUNIT_TEST doesn't follow that logic, requiring
GPU_BUDDY to be selected already instead of selecting it itself. This
requires building the test kernel with another driver that uses
DRM_BUDDY, as this is currently the only kconfig option that selects
GPU_BUDDY. That shouldn't be required to run unit tests for a module
now completely independent from DRM, let alone any specific driver.

Fix the dependency declaration in CONFIG_GPU_BUDDY_KUNIT_TEST to make it
work as intended, mirroring the setup in CONFIG_DRM_KUNIT_TEST.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---
 drivers/gpu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
index ebb2ad4b7ea0..3bcf08260d73 100644
--- a/drivers/gpu/Kconfig
+++ b/drivers/gpu/Kconfig
@@ -7,7 +7,8 @@ config GPU_BUDDY
 
 config GPU_BUDDY_KUNIT_TEST
        tristate "KUnit tests for GPU buddy allocator" if !KUNIT_ALL_TESTS
-       depends on GPU_BUDDY && KUNIT
+       depends on KUNIT
+       select GPU_BUDDY
        default KUNIT_ALL_TESTS
        help
          KUnit tests for the GPU buddy allocator.
-- 
2.45.2

