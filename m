Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E6BC4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD5C10E329;
	Thu, 16 Jul 2026 12:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P5FESNct";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF25110E329;
 Thu, 16 Jul 2026 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784203241; x=1815739241;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NGES45XvK1Odkr2DEvjdJxj2zR7xuLUX9Edbgog83VM=;
 b=P5FESNctz431QEoVfQDRz7kXoYa2MwqVhVC2dK3x1F6eQ5kK9k38Nj02
 1dgVmfeUI/+Bx/Wjg1BIg7gMLfQYIEbjYSYylStEL1KITh0kPTkqG+QR1
 7ssOcyF6KM+zFuZHUdczAgSduPXJmBdBQvj35NBgqwDiyq3rZdeOwuytK
 c8JOyrdI16F5s7/bPOhSRVJmWW3jfqKha7boggTyfub6DFgxf8YAjNrb1
 ZCyoQU/NvicZRWhAroY8uR3VaGFO9MlvHoOV22KtARoc04IzeTgNYkAr0
 RfYIH5iy1PeodCo8ziUNWQuyrmYWDA6oksKRqxeTdErTIK8uQOg4sLlHa A==;
X-CSE-ConnectionGUID: +ykUZMsOSIe+09UxU4RhvQ==
X-CSE-MsgGUID: y99Ml38bTWGXLVNFAOGphA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="85059107"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="85059107"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 05:00:40 -0700
X-CSE-ConnectionGUID: xwxQnZEHR1Cx33NS0zm4zw==
X-CSE-MsgGUID: LI92/MPKSJmWLnwPrO7QYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="255957157"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.64])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 05:00:37 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH v2 0/2] DRM device registration fixes
Date: Thu, 16 Jul 2026 14:00:17 +0200
Message-ID: <20260716120018.20406-2-krzysztof.niemiec@intel.com>
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

This series contains patches pertaining the drm_dev_register() and
drm_dev_unregister() functions. Turns out drm_dev_register() doesn't
properly unwind its effects in the error path, causing confusion and
bugs.

Additionally, a related patch for i915 is bundled, as i915 mistakenly
calls drm_dev_unregister() in the error path triggered by failing
drm_dev_register(), which on one hand introduced a WARN_ON() in
drm_client_sysrq_unregister(), caused by calling it without a previous
_register() (as it was skipped in drm_dev_register()); but on the other
hand silenced yet another WARN_ON() later on in the error path in
drm_mode_config_cleanup(). With the other patch, the driver can just
handle the error from drm_dev_register() cleanly without calling
drm_dev_unregister(). This is explained in detail in both the patches.

Krzysztof Karas (1):
  drm: Unwind drm device registration upon error

Krzysztof Niemiec (1):
  drm/i915: Remove drm_dev_unregister() from the error path during
    i915_driver_register()

 drivers/gpu/drm/drm_drv.c          | 2 ++
 drivers/gpu/drm/i915/i915_driver.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.55.0

