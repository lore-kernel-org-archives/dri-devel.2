Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757ECC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6FE10E028;
	Wed, 29 Jul 2026 09:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ENLkoEsd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D1D10E028;
 Wed, 29 Jul 2026 09:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785316798; x=1816852798;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C7rb8FTFsoinrzscbdqtrV/V6OCDZtEVNoPJOahNsS8=;
 b=ENLkoEsdCf52AYaACuzy71vZWV7xqSMVRc3iYzk5BDKDvBGlOXMcgx3a
 cQJqhllOzpiv4aqnssKc0GvqEY8vSyMyZ8a5w/wCMXPjQRvZYT27yDfUC
 uuUo9kyUXg4GsCwDeiHO8hDd1d4viXaPK9fN2vB/CEF+0fsMb20Xt9F7J
 L2cPAY9KsQbwO9xr53B77UR9idlYXCwVMw1gX0/g7ET2/S/Ujc2ZqDQMU
 tekQX9qsEYzDDedRjf2fhZaFyzydTCfrEux8zHvchrLCCIDyBlP8Zgp2s
 bHKZrTjkQUQTDakyS7xvx6WOxemLPDF0e4OilOondt92Btxwro5PUINiJ A==;
X-CSE-ConnectionGUID: vb7fclDYRcuF8cZlf8NIBw==
X-CSE-MsgGUID: /a9iT4tGQpqTWYGjzr56zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89805352"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="89805352"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 02:19:58 -0700
X-CSE-ConnectionGUID: TKBtRxmlTO+Iv9gpfz4SIQ==
X-CSE-MsgGUID: Y3BKb6LfSjmCCFaXDdQItw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="260020085"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.23])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 02:19:54 -0700
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
Subject: [PATCH RESEND 2/2] gpu/tests: Add a dedicated .kunitconfig
Date: Wed, 29 Jul 2026 11:18:17 +0200
Message-ID: <20260729091816.27860-4-krzysztof.niemiec@intel.com>
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

Add a dedicated .kunitconfig for running the GPU buddy allocator tests.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
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

