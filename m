Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34347C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4F410E65C;
	Wed, 29 Jul 2026 09:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OjPvzaHU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D228610E641;
 Wed, 29 Jul 2026 09:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785316783; x=1816852783;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=77NJ54WFhAKFaHyjMcDAOikQzZ+okj3GveCYQGKejmU=;
 b=OjPvzaHUpPs3Molpmlk2aJCzA+e1qIWOyT1HWDcq4lPjs84ECQk0Amd/
 9G3LOtu+2gdBPgaKNbd+jUWoI8xdAvX6kMZ94hmiAAd2B6OI+kisPdF2o
 Gz1tt/z6AIC3bfWse3a3aLbZFVO98GTuCoPMUAa7u62llVbUuNGOiZY9A
 JpeXIrq9uoW2COwJIIRPQP0BesFpnagQl648369nX5TmH1AkRrWiq20KL
 8suZKFoV75TsU3V+UetT1DQhY7w1FZFjbx/RaynTZRXPIRP63hKRB7TXn
 DD7yMunqGnFGz3NUwijp6AtKBIJGLMu4bOdJlHonkiJubfQGHG6859fkz w==;
X-CSE-ConnectionGUID: OBhDGlq7TWC0/DE+wwC7FQ==
X-CSE-MsgGUID: JLhw6CzITfSAK1L5LUcBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89805333"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="89805333"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 02:19:42 -0700
X-CSE-ConnectionGUID: Mt4FrOdHT66oV7BVDhk9Jw==
X-CSE-MsgGUID: edocE6KJSjO4B6uVIr3Mnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="260020027"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.23])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 02:19:39 -0700
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
Subject: [PATCH RESEND 0/2] GPU buddy allocator test fixes
Date: Wed, 29 Jul 2026 11:18:15 +0200
Message-ID: <20260729091816.27860-2-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.55.0
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

This series introduces small fixes to the GPU buddy allocator test
configuration. The direct purpose of these changes is to fix running the
KUnit tests via kunittool, or running the tests on systems not building
any DRM drivers.

Krzysztof Niemiec (2):
  gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST
  gpu/tests: Add a dedicated .kunitconfig

 drivers/gpu/Kconfig            | 3 ++-
 drivers/gpu/tests/.kunitconfig | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/tests/.kunitconfig

-- 
2.45.2

