Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D94CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 15:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDDC10F5AA;
	Fri, 22 May 2026 15:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y8K+EWUe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4253E10F5A7;
 Fri, 22 May 2026 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779464651; x=1811000651;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3hPN50lE7sE9kvVCaDHALMpPcktKyFGVGRLMr9kW2GY=;
 b=Y8K+EWUeTO/Q2I8AWMY3zQ4J3HSWW70nGESJnbGpoO0/JWsedwrEiAk3
 Bke96vMeaH68COHPWcgVxCPbqqN6R7LC3hRvwfVpxb3C3vLAtjfU5a1e1
 Oj6dOLRfP00XLSO/1tev7EmRLufYI+ljTja/Cd1TUdNjkhLkHQG7QfAFk
 QHvThpYWH22VqXQFjff03zyngWFQYC2wB+4UeBNsHY8qjBemqY3TDJtHJ
 TwH+i6dp7dOUmeLPyurTebC0VHAlfoitEn5mCd3YNxX0Kw9HGoCmrh9vD
 /KbzizbIZ/SDeUQ775r+vZ/FBMmBQNKgC0rNtz49UsPN8/qDC2qZJo4Zb w==;
X-CSE-ConnectionGUID: MB6jdKmnRS2sM86WPVhKkg==
X-CSE-MsgGUID: kuOrG6JwS/2IFdYq3nA0Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="79545726"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="79545726"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:44:11 -0700
X-CSE-ConnectionGUID: T1MP5dJSTwyUCv87yk6fAw==
X-CSE-MsgGUID: ITx4K2EFQ+OM0pztxedTZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="236511547"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.34])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:44:08 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH] drm/i915: Remove drm_dev_unregister() from the error path
 during i915_driver_register()
Date: Fri, 22 May 2026 17:43:57 +0200
Message-ID: <20260522154356.47588-2-krzysztof.niemiec@intel.com>
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

During driver probe, in i915_driver_register(), if drm_dev_register()
fails, the code enters into an error path. In it, a call to
drm_dev_unregister() is made as part of cleanup in case drm_dev_register()
returns an error. However, this is unnecessary, as in case of an error
drm_dev_register() undoes its own setup in its own error path.

Calling drm_dev_unregister() after a failed drm_dev_register() also
generates a superfluous WARN_ON() from drm_client_sysrq_unregister().
drm_client_sysrq_register() is only called in drm_dev_register() if
there was no error in the latter. drm_dev_unregister() calls
drm_client_sysrq_unregister() as it expects to be called after a successful
drm_dev_register(), in which case the _sysrq_register() counterpart is
called. However, if the call to drm_dev_register() failed,
_sysrq_register() is never called; calling drm_dev_unregister() will
cause _sysrq_unregister() to be called (unconditionally) with no
corresponding _sysrq_register() call before it, which is caught in the
aforementioned WARN_ON().

Remove the redundant call to drm_dev_unregister() in case
drm_dev_register() returns an error.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index c10cab38935a..10e16002050a 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -638,7 +638,6 @@ static int i915_driver_register(struct drm_i915_private *dev_priv)
 	if (ret) {
 		i915_probe_error(dev_priv,
 				 "Failed to register driver for userspace access!\n");
-		drm_dev_unregister(&dev_priv->drm);
 		i915_pmu_unregister(dev_priv);
 		i915_gem_driver_unregister(dev_priv);
 		return ret;
-- 
2.45.2

