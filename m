Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E03C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B65E10F2CE;
	Thu, 16 Jul 2026 12:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IxPvnQTt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F77910F2CD;
 Thu, 16 Jul 2026 12:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784203253; x=1815739253;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ljAqNZDkMWYboAgdYUObgJSLe5IGhTaMykdmBRGlBh0=;
 b=IxPvnQTt+gF7CiezS5riDmNsciU3Pj9k0tM9+dPFuMxM/HlSuoDBSKb2
 8MLEmkCT+gmd1pbfw5ohJIf0B5aRSHxz5BhsWgvivTpbbQSWFVYHqJBPL
 T3bD0X5oI6o/SClPlYHVtBZ88owpSZJ+ONWW0PIIExTdxLUkP2EUTupsB
 TDq4eM+ZvdkFnQH+K6lOIekJ+fVtD46f/ivdFruBkJC8mKurKBhzCaw9W
 cPxtrR3oHhLE7qTsm3n6Gh1tAXX+5B0h0c81vINzWNhWTrVNOqfUv8GR0
 GoQ7zAwtOE6upvl05lwaJirEW1QPJn+rRXBn0alXJ3H2YBHuV2tUbYGT4 Q==;
X-CSE-ConnectionGUID: 7RKP8IrFR+SIKYbTHstJDw==
X-CSE-MsgGUID: qaNRMh/uSZimYjQyE5Zwkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="85059133"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="85059133"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 05:00:53 -0700
X-CSE-ConnectionGUID: iuwFCNawS56CaosHrTD6SA==
X-CSE-MsgGUID: XcOkoAlNStqZDLb5vPTKAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="255957200"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.64])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 05:00:50 -0700
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
Subject: [PATCH v2 2/2] drm: Unwind drm device registration upon error
Date: Thu, 16 Jul 2026 14:00:19 +0200
Message-ID: <20260716120018.20406-4-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716120018.20406-2-krzysztof.niemiec@intel.com>
References: <20260716120018.20406-2-krzysztof.niemiec@intel.com>
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

From: Krzysztof Karas <krzysztof.karas@intel.com>

The drm device registration is done via drm_dev_register().
This function attempts to undo some of the initiatlization steps
under err_unload and err_minors labels, but this process is
incomplete - debugfs entries remain and the dev->registered flag
is still set to true.

On the other hand, drm_dev_unregister() tears down everything
that was initialized during registration step. This is confusing
when considering a failure in drm_dev_register(), because some
setup steps will be undone and some settings will remain, so it
is unclear whether a call to drm_dev_unregister() is a
requirement or not.

This may trigger bugs in the error paths of drivers which rely on
functions that check for the value of dev->registered flag.

What is more, commit 6915190a50e8 ("drm/client: Support
emergency restore via sysrq for all clients") introduced a new
WARN_ON and added drm_client_sysrq_register/unregister() calls
to the drm device register/unregister paths. Client sysrqs are
registered only when drm_dev_register() is sure to complete
without failures, but drm_client_sysrq_unregister() gets called
every time during drm_dev_unregister() and prints warning
messages whenever the caller tries to clean up the mess with
immediate unregistration.

Amend the problem by removing debugfs entries and marking
registered flag as false upon error in drm_dev_register().

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Co-developed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---
Changelog:

RFC -> v1:
 * addedd title of commit 6915190a50e8 to commit message;
 * rebased;

v1 -> v2:
 * updated commit log slightly to mention possible bugs;
 * updated authorship - the bug was found and fixed independently by
   Krzysztof K. and Krzysztof N.; We decided to exchange the findings
   and our comments and send the patch as co-developed-by.

An instance of a bug caused by this was uncovered in i915 with fault
injection. During driver probe in the error path, after failing
drm_dev_register() there is a reasonable expectation of a full proper
teardown of whatever drm_dev_register() has done. This is, however, not
the case, as shown in the calls below:

	i915_driver_probe()

	i915_driver_register()
		calls drm_dev_register()

	drm_dev_register()

	...

	connector .late_register() callback
		called from drm_dev_register(), and fails, leaving
		dev->registered as true, propagates the error back up

	...

	drm_dev_register()
		enters error path, but doesn't fully unwind

	i915_driver_register()
		enters error path

	i915_driver_probe()
		enters error path

	intel_display_driver_remove_noirq()
		called in _probe()'s error path

	intel_mode_config_cleanup()

	drm_mode_config_cleanup()
		this triggers a WARN_ON(), dev->registered should be false

This is a bug on drm_dev_register()'s side.

 drivers/gpu/drm/drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index e51ed959da89..b98e8af6f1c1 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1140,6 +1140,8 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
 	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
 	drm_minor_unregister(dev, DRM_MINOR_RENDER);
+	drm_debugfs_dev_fini(dev);
+	dev->registered = false;
 out_unlock:
 	if (drm_dev_needs_global_mutex(dev))
 		mutex_unlock(&drm_global_mutex);
-- 
2.55.0

