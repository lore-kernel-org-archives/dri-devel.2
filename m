Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B235FC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE8D10F081;
	Wed, 23 Sep 2026 14:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YU0rgcFE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34B610F07D;
 Wed, 23 Sep 2026 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790172564; x=1821708564;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Q1S7+cKk4ECChJe3nTyndKkZQa5GysPZqvRokpkUitE=;
 b=YU0rgcFE8W/WiW5/mYYx0VE56Lj99peSpUoGcOPdyBQb9D+N3PkhHe4Q
 q5YnVsx8sMerwZy1JRegPy1Zi+Li9I0RqjtHMCEFJbVlprwRISkPjVfm8
 bmJWlsmbUI+p877o6UjNJsjC5sc7a64hm+sYfWvIEcyqYxgo/SU3wPGhA
 I2KnQ+7PrmIE8NMQChwjGiUs4OtX2ynG5peTtjGPUs3rNqK3C2+jhPKOT
 ZdSvYREduTwc1j6djeeyH3yxPsf5FyI/rzOG+EeXs6eOLMsMAYbu/sGev
 bkWhg94A2NOcpI8EqkmX//hALb4h1YSrU9ISOUoxp5Vzs58YLp/M4yzIf A==;
X-CSE-ConnectionGUID: EP+kvzO8S66ASvBj2DxF2g==
X-CSE-MsgGUID: zrfI4HRRSb+Ii3cPhCAjsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101535306"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="101535306"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:09:23 -0700
X-CSE-ConnectionGUID: k7k8Mx06STSrGawUxikrfw==
X-CSE-MsgGUID: dkomU1arQ3KUce5S47p1SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4885810"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.245.245])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:09:21 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 0/3] drm, drm/xe: Protect against premature module unloads
Date: Wed, 23 Sep 2026 16:08:41 +0200
Message-ID: <20260923140844.390822-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
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

Driver and shared DRM helper code is increasingly relying on bare
drm_device references (drm_dev_get()/drm_dev_put()) to keep a device's
software state around, without also pairing that with a reference on
the owning kernel module. Xe itself does this in several places, and
so does drm_gpuvm for the lifetime of a GPU VM. None of these
references currently prevent the owning module from being unloaded
while they, or the teardown work they can still trigger, are
outstanding, meaning driver code can end up executing after its own
module's text has already been freed.

This series closes that gap for xe:

- Patch 1 adds core DRM infrastructure allowing a driver to wait for
  its outstanding device-release callbacks to finish before
  proceeding with module unload.

- Patch 2 makes xe use this infrastructure to hold up module unload
  until every xe_device instance has actually been released, rather
  than only until the module's own refcount happens to reach zero,
  with a diagnostic if this ends up taking an unexpectedly long time.

- Patch 3 fixes a related, previously unprotected case where the
  teardown of a GPU VM or its address space mappings can be deferred
  to run at an arbitrary later time, including after module unload has
  already completed.

Together, these changes ensure `rmmod xe` cannot free the module's
memory while any of its devices, or asynchronous work stemming from
them, might still be executing.

Thomas Hellström (3):
  drm: Provide a drm_dev_release_barrier() function to wait for device
    release callbacks
  drm/xe: Don't unload the driver until all drm devices are freed
  drm/xe: Route deferred xe_vma/xe_vm teardown off system_dfl_wq

 drivers/gpu/drm/drm_drv.c      | 56 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.h |  2 ++
 drivers/gpu/drm/xe/xe_module.c | 24 +++++++++++++--
 drivers/gpu/drm/xe/xe_vm.c     |  5 +--
 include/drm/drm_drv.h          | 24 +++++++++++++++
 6 files changed, 148 insertions(+), 5 deletions(-)

-- 
2.55.0

