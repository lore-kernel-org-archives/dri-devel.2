Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D72F53D70
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A41110E025;
	Mon, 16 Mar 2026 16:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cA3gd/Bg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7918B10E025;
 Mon, 16 Mar 2026 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773678035; x=1805214035;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zdDadFAKEKsGBKt3/8FLGmgtX8Z8G66mf73tPxmJadk=;
 b=cA3gd/BglSC4uMBOUaGwfE+94iRDKjSnZmG6s9WkanOCAeOeO8KxszVP
 8vlk1oUwOMi8+IQ55nxTCOj459QFmNjSHFCpL36mbx4xev581gywSWLHk
 oC3jN7YpHkiuvX+eTFpe+7vqF/ritljK2Dlwf6NnQjbR6Kf7hVUTyeHJd
 RTr+VmIPuxAWvMcUuvah8ZXZvSLyFddI7DHQEXBAhayT8FJ0A41Yum+gV
 a6t7mjfKgzU9cBDDzAQ3ADH6GpKgtjdsa0Aop47bXOiNZr+EbXVnBk2kk
 c/L+tPN7XK9LED2xCDaGDUrz8E2OCou58Uf9vEF7YBbqjSg+AhZOMqkzS g==;
X-CSE-ConnectionGUID: wB2HABmdSW2brie72SD1qA==
X-CSE-MsgGUID: 6nmjwkqLQhKm0/2uTp4uwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74884812"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74884812"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:20:33 -0700
X-CSE-ConnectionGUID: lf13wFxxQveiRla+gXkyhQ==
X-CSE-MsgGUID: yCuO87GcSNuvN5fZdS+EmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="244993884"
Received: from zzombora-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.233])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:20:30 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm,drm/xe: Relax helper module reference requirement
Date: Mon, 16 Mar 2026 17:20:00 +0100
Message-ID: <20260316162002.13479-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Helper components that hold a drm device reference also need to hold
a module reference on the (sub)driver that owns the DRM device.

This can be undesirable since it's not possible to rmmod the module
without unbinding the driver first.

Provide means to relax that requirement and then relax it for the
drm/xe driver: Keep a device-count in the xe driver (Patch 2) and add a
function to drm to wait to ensure any device release callbacks are
done executing. (Patch 1).

The remaining requirement is that whatever module calls drm_dev_put()
needs to ensure it stays in memory until that function returns.
That is true also for the unload-protected driver itself
At unload time it needs to ensure that any code inside the module
itself ending up calling drm_dev_put() is waited for before
unloading the module. This change doesn't protect against that.

As an example, this series would allow dropping the module reference
held by drm_pagemap if the modules owning the drm device is
sufficently protected.

Thomas Hellström (2):
  drm: Provide a drm_dev_release_barrier() function to wait for device
    release callbacks
  drm/xe: Don't unload the driver until all drm devices are freed

 drivers/gpu/drm/drm_drv.c      | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.c | 19 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.h |  2 ++
 drivers/gpu/drm/xe/xe_module.c |  5 ++++-
 include/drm/drm_drv.h          |  1 +
 5 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.53.0

