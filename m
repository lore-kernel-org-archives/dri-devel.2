Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D054C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FEA10EB31;
	Wed, 29 Jul 2026 09:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D7h1/Zuk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F2C10E028;
 Wed, 29 Jul 2026 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785316790; x=1816852790;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=toMW/9OUIf9k0TwN0uyibzC5riBhEZXIPdpiDl7iafk=;
 b=D7h1/ZukdYbx+Y0euSRafGXJKTLYBf4LwsIIB15Zm5TKLiX42ADYn4pV
 OEY0By7j6S6lIiY3pYgDOKyE/1yywn4d95EJHEqZ2bWzX3og4YV+7ejEe
 OLecQFhx9skGJq2+Sph3u9Db9At4o+DHt9unrrqZtOFmPjwCzGrW2nim/
 JmYs1Qqyd4iLBk6IlXXieabKJuP7s9aOzaoPiryp7sytNe5KwQuXBUHWK
 MJ0xCr6Kwp6OeBaTll0HjKOj2mRt9L5IX4FVzrsidzOkmbOfYijNcQu9w
 2dtUWLyeLxhTjXhR7v2PTQ9g12s9zCvCVLTBEKUprLDX2MH8HdmEJbB1l A==;
X-CSE-ConnectionGUID: y8nuudlvSn6AdKp+/tNdpw==
X-CSE-MsgGUID: LHiPWkUXQLmgRuAao8m/3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89805344"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="89805344"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 02:19:50 -0700
X-CSE-ConnectionGUID: v6ro+plQSU2nCNys1LS+6g==
X-CSE-MsgGUID: l9gmuZSuRAm+GZYlJwuGsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="260020051"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.23])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 02:19:46 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
 Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH RESEND 1/2] gpu: Fix dependencies in
 CONFIG_GPU_BUDDY_KUNIT_TEST
Date: Wed, 29 Jul 2026 11:18:16 +0200
Message-ID: <20260729091816.27860-3-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729091816.27860-2-krzysztof.niemiec@intel.com>
References: <20260729091816.27860-2-krzysztof.niemiec@intel.com>
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
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
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

