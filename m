Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A307CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 15:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5056010E890;
	Fri, 22 May 2026 15:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FHaYYuHq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B51910E890
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779464487; x=1811000487;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Er4X9oim5fIrfNUBOlMFDSiGlyMv2BH8MyhwFUk3uWI=;
 b=FHaYYuHqgU6FYZj7zN0rGDtYQ5sBtbHAYlDLkaOQssf0hcO2DVjktMdc
 2DpgqSy1LluncP29e/0jS6uC0VRuj6us//D7YtxSiolPmWSLNBo4OHzS5
 rIVsGsKlfhTJYy9LpQ7R3Mn/Ip78KcqiCOnyvGl9+IG72AFgKRMw2dI2q
 yD8BJAEYOg/YWq4a8oNbT094c6UmTij5rQCRlZKYVL4Z42RKri3PwAeYE
 j0d9Niui2i9gM4Io//vWGBocEY5XM7ZkZG37ASI9t86CdOdJXcrqTaZ3A
 655DCC0YABQOM6rmGxnjeHo/bRsrn7tI84EEUqTWjHpXK064ey1fmpFCV A==;
X-CSE-ConnectionGUID: L4i0NbyfQUWudrFR6Drr6A==
X-CSE-MsgGUID: 0ucUQKhuSOa4mGxuvcj22Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="90696256"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="90696256"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:41:26 -0700
X-CSE-ConnectionGUID: vfEVj4lQTLm69fxx58wY8w==
X-CSE-MsgGUID: ZxcwncV4QFWJRcOyiqcoYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="240814358"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.34])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:41:23 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH] drm: Set dev->registered back to false in case of register
 failure
Date: Fri, 22 May 2026 17:40:39 +0200
Message-ID: <20260522154037.46892-3-krzysztof.niemiec@intel.com>
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

This, for example, confuses the WARN_ON() in drm_mode_object_register(), which
is raised if a non-dynamic mode object is attempted to be unregistered
in between the drm_dev_register() and drm_dev_unregister() calls. If
drm_dev_register() fails - meaning the device *isn't* registered -
currently it still reports dev->registered = true, which triggers the
WARN_ON(), even though the usage is correct in that instance.

Set dev->registered back to false in the error path to prevent this.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 985c283cf59f..92403d79bb64 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1116,6 +1116,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	if (dev->driver->unload)
 		dev->driver->unload(dev);
 err_minors:
+	dev->registered = false;
 	remove_compat_control_link(dev);
 	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
 	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
-- 
2.45.2

