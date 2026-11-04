Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E2606D805
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nSnYzusA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9071210FF9E;
	Wed,  4 Nov 2026 23:06:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D28510FFA6;
 Wed,  4 Nov 2026 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793833576; x=1825369576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=44L0IW3H+Z1Sp8mo+XKwSvtklQe87pLK6EJjCV+hr2U=;
 b=nSnYzusAKAdDfugdujCApbmU8vny4Bq/NJVBHjS8YdQ1TdUVY8QpoS22
 GLA5GyhG2Shti2oQ+9W8inMxXHdufQaFt8WNtJlxNhhumDYJL7ZNEF6TU
 gqIQTaKp/PEzs8eLIqCUKicgKGV5qZRFR6Z3ZliCnML1thx9nhU36U8Tt
 noJ12LqkpB0CTEnEDrctTjzMxwapU2kFokAgdo45Ta2R3LaxsF4bT+ja5
 8RCciMxi66uuet5hF+S0TWGq5eT6kLcUHsazm8Up2xPoMbfVeH1UkcBOI
 ZlyHrqRYk9oqoDr4VL9fDmZXgANfaLpJ7hCC4gnNo3MCf8dc0ZQOYnzLH Q==;
X-CSE-ConnectionGUID: KSj3yaPyRJuO9AYf73USJQ==
X-CSE-MsgGUID: ZYdva6PARFu00qYxwH583A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2513220"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2513220"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:06:15 -0800
X-CSE-ConnectionGUID: E/dq8ylDQA+NMc8khNCguA==
X-CSE-MsgGUID: X3GTU+g4Tuuf+cbYlQCgww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6864999"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.244.108])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:06:12 -0800
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: sima@freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH v4 1/2] drm: Set dev->registered back to false in
 drm_dev_register()'s error path
Date: Thu,  5 Nov 2026 00:05:54 +0100
Message-ID: <20261104230555.71107-2-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104230555.71107-1-krzysztof.niemiec@intel.com>
References: <20261104230555.71107-1-krzysztof.niemiec@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dev->registered variable was initially added in such a way that it
is only set after all functions that could have failed have been called
and haven't returned an error. However, since then, the function
drm_modeset_register_all() is being checked for its return value, which
opens a possibility of failing the register after setting the registered
variable anyway. drm_dev_register() cleans up after itself in case of
failure, mimicking the functions called in drm_dev_unregister(), with
the exception of drm_client_sysrq_unregister() and
drm_panic_unregister() (_register() counterparts of which are not
checked for their return values), and the dev->registered flag.

This creates a situation in which after calling drm_dev_register()
nothing is registered (as the function entered an error path and cleaned
up), but the device is reported as being registered according to the
dev->registered variable.

This, for example, confuses the WARN_ON() in drm_mode_object_register(),
which is raised if a non-dynamic mode object is attempted to be
unregistered in between the drm_dev_register() and drm_dev_unregister()
calls. If drm_dev_register() fails - meaning the device *isn't*
registered - currently it still reports dev->registered = true, which
triggers the WARN_ON(), even though the usage is correct in that instance.

What is more, commit 6915190a50e8 ("drm/client: Support emergency restore
via sysrq for all clients") introduced a new WARN_ON and added
drm_client_sysrq_register/unregister() calls to the drm device
register/unregister paths. Client sysrqs are registered only when
drm_dev_register() is sure to complete without failures, but
drm_client_sysrq_unregister() gets called every time during
drm_dev_unregister() and prints warning messages whenever the caller tries
to clean up the mess with immediate unregistration.

Set dev->registered back to false in the error path to prevent this.

Co-developed-by: Krzysztof Karas <krzysztof.karas@intel.com>
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
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

v2 -> v3:
 no functional changes

v3 -> v4:
 * rebased
 * removed the debugfs change (sashiko, Andi)
 * put the =false in different places than v2/v3 (Andi). First driver I
   sanity-checked that uses the .unload() callback calls
   drm_mode_config_cleanup(), which expects registered=false down the
   call stack, so =false needs to happen before the callback. Problem
   is, the err_minors error path also needs to have the variable unset.
   I'm not sure there's a way to do this cleanly given how the
   .(un)load callbacks operate so we might be stuck with this, and it
   smells, the way I did it smells less *to me* than what Andi suggested
   with jumping between labels in the error path, but I'm not very
   opinionated either
 * spliced the v1 and v2/v3 commit logs together a bit to account for
   the debugfs change removal

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
index a2872c69b8c6..812add80831a 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1135,9 +1135,11 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	goto out_unlock;
 
 err_unload:
+	dev->registered = false;
 	if (dev->driver->unload)
 		dev->driver->unload(dev);
 err_minors:
+	dev->registered = false; /* fallback for driver->load() error path */
 	/*
 	 * If a minor was registered before the failure, userspace could have
 	 * opened it and entered a drm_dev_enter() critical section. Ensure all
-- 
2.55.0

