Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F95C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BC710E12D;
	Thu, 16 Jul 2026 12:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M1OF6cPt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8BA10E12D;
 Thu, 16 Jul 2026 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784203247; x=1815739247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=myRf8Ob+J2MYjnKqF1QFxQzxTwsEglgyR/JrjIwXCDY=;
 b=M1OF6cPtrS6TU+S3F3X12AqEOoBRXwuMaSs/RjOYIRiB+3zchbr91MEF
 /KmyXj4OJ5MVyWj1PmcDl5ImHxElQ3DtynECtetpuYgd91ENUiyNrzam6
 Dsa5PaZe/Wg39z/PXRM35/KAfttmSP3ZBMQJJ1qyjJIqfaWVNvz6fWBbC
 BwU/i8miOayU49n64+4nbQ2LrWlBpYE6JJs0fsUalyXZwd63WXYEU72wC
 6sBPvzL+SeMYbBLeN3cYqjffeC5j0F2NXn4bbGr8Hyi4R8Q+eoHcyqCcw
 k+MFuy20rThfHw2fQkbGWWcuuch6quunnRXhkZwIBfxErdRYHvQFSZzF3 g==;
X-CSE-ConnectionGUID: 9kMlBMfnSiyWEkgkEjer9g==
X-CSE-MsgGUID: 49+WmeorR36KBwiB+na5rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="85059120"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="85059120"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 05:00:46 -0700
X-CSE-ConnectionGUID: VMLgZtpeTV22n6ZOlOe7aA==
X-CSE-MsgGUID: Q0mwLreCQgGJ6K8TagbMgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="255957172"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.64])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 05:00:44 -0700
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
Subject: [PATCH v2 1/2] drm/i915: Remove drm_dev_unregister() from the error
 path during i915_driver_register()
Date: Thu, 16 Jul 2026 14:00:18 +0200
Message-ID: <20260716120018.20406-3-krzysztof.niemiec@intel.com>
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
index ce6d20958320..da9be352fc90 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -617,7 +617,6 @@ static int i915_driver_register(struct drm_i915_private *dev_priv)
 	if (ret) {
 		i915_probe_error(dev_priv,
 				 "Failed to register driver for userspace access!\n");
-		drm_dev_unregister(&dev_priv->drm);
 		i915_pmu_unregister(dev_priv);
 		i915_gem_driver_unregister(dev_priv);
 		return ret;
-- 
2.55.0

