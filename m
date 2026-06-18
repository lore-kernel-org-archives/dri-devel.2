Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7603CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF03710EDEA;
	Thu, 18 Jun 2026 15:25:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QV4MekrH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1354710EDEA
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781796346; x=1813332346;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=77NJ54WFhAKFaHyjMcDAOikQzZ+okj3GveCYQGKejmU=;
 b=QV4MekrHZRJKVUhSxMFjlOo+P5HkaOCcJmHoY0vTemnP1d7cCQMCPUFp
 NU1LnQCAEIs6ncCQQYF+XZZqClHrR2ZP1FZ7hF6Ykr2WPttpCQsPMRCkB
 PDR5H9LlLeAJb9K9Gf1OxDhhITgFjJ9+rrE0tgdyQZ0omTRaZrt//p21q
 wGruXMK1xoyWiH92F9QfncEleBxOr3HP32IY7iDYKFWxjpm23UkRpOOgO
 389bgKQ6s53IQ7It3O87jaKuIhKFZ7crRPcAfDx1TfHz3sIdLg6motpH+
 RJlZkb9Ar3y9sQayR1YMB+AvHjY/xLuaSlywtCTAJQWF9rvonWTqXB2j/ A==;
X-CSE-ConnectionGUID: mJmq542OTlOLv+LDWyL2kA==
X-CSE-MsgGUID: TaYrsrOvQNOidlS5W1QyTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86314242"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="86314242"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:25:45 -0700
X-CSE-ConnectionGUID: isypFrIsSaenTOITs72cug==
X-CSE-MsgGUID: DHtzOQjBSpKDYOqvj7Ywog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="250291638"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.244.96])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:25:42 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH 0/2] GPU buddy allocator test fixes
Date: Thu, 18 Jun 2026 17:23:29 +0200
Message-ID: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.45.2
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

