Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D7606D815
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bItlBakM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C3810FFAF;
	Wed,  4 Nov 2026 23:06:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DB110FFA0;
 Wed,  4 Nov 2026 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793833584; x=1825369584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uHBH4lSDLCuCLohm0DKRiGyDCvKJ1x3FeSqwqnRiHlA=;
 b=bItlBakME+OscswmMvXNAMkIu6i7HuMKuntEXuJ0tOFv+mVDhKEJnKxw
 XHiTAXcrvMdMsTu829twipjCEmbse0gU7saE/kXFtTxsnuMOvAUx/eKlx
 /Wl1XerBKvlZo6RqamOh1MQDnVFN294j4mtyp20K2DBbLbbeafPJTRDg8
 nYmK6CvUoT/aKh7NEpqkqWGgch6ypV6LrxbiTp6fgFagWtlhYJdVnhOXR
 +bDXQO+XztTufDG9nOOfXhRMQUsjBhgBzZ5zprN3w1s1YTdBEbwGj0rTe
 nvvlkOAhGXXtTOdq2YS1+lum9/KUu+TjKzkm9TxwuN70nmz0HyrlaBWYQ g==;
X-CSE-ConnectionGUID: MqK3Y5kzTYekEO8RxCWkyw==
X-CSE-MsgGUID: Ia8Ip4UhStasDcuWFp5PvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2507753"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2507753"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:06:24 -0800
X-CSE-ConnectionGUID: saLf9/y6SYCNRUkoRJpZig==
X-CSE-MsgGUID: BlvCr8uESdmxyGD7WTwAvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7157804"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.244.108])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:06:19 -0800
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
Subject: [PATCH v4 2/2] drm/i915: Remove drm_dev_unregister() from the error
 path during i915_driver_register()
Date: Thu,  5 Nov 2026 00:05:55 +0100
Message-ID: <20261104230555.71107-3-krzysztof.niemiec@intel.com>
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
Changelog:

RFC -> ... -> v3:
  no functional changes

v3 -> v4:
 * rebased

 drivers/gpu/drm/i915/i915_driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 5787f40ac62e..d25145b33db4 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -618,7 +618,6 @@ static int i915_driver_register(struct drm_i915_private *dev_priv)
 	if (ret) {
 		i915_probe_error(dev_priv,
 				 "Failed to register driver for userspace access!\n");
-		drm_dev_unregister(&dev_priv->drm);
 		i915_pmu_unregister(dev_priv);
 		i915_gem_driver_unregister(dev_priv);
 		return ret;
-- 
2.55.0

