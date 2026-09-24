Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E3FC98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3037C10F38E;
	Thu, 24 Sep 2026 08:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pf5X++57";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C5010F385;
 Thu, 24 Sep 2026 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790237132; x=1821773132;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QlIsKnSAs9MAJuIyqrN1IvSSklRVaB5DgEcAtk8/94Q=;
 b=Pf5X++57qZAagKYlPvB15sjhAIaufE0rCqaCijlhASN8e2nIaV7dJpnQ
 cUCtMCOHHgKdPN4mFOdY5PS1oRrXqbrDq/I1EhrBqeLwMqP5su+iUp3B2
 +GWalbZgwdSjWZMg7jCByfalLQoy/gXR/WJnui/O3RVFrmpLZMbIk7/zw
 uW5Yyey0ZzFItLb4S5LfMXIzq4FgPlxQ/Ss6JDSt1KgJaViLkJNE1z0Oy
 fhcvAGw4ldq6v/vOWhu+SafuCN+I88nJGNKpNhgU2oGQGC8i3e8EbnGTV
 4X7Sjt9SZSDEj+BA02aYsd1RqgZAob4calZaiGTmFsbc7tWX9f3gPPiJ8 Q==;
X-CSE-ConnectionGUID: MNV6vCTPRQK5CTXGq8ZM4A==
X-CSE-MsgGUID: a5rnZYRDTxCpjlhGSRrE3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89771236"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="89771236"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 01:05:31 -0700
X-CSE-ConnectionGUID: 9nKzdIN0R8aXBiR7z46ygQ==
X-CSE-MsgGUID: GAB3Xe75RnKc1sE1HtzM9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277702706"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.129])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 01:05:28 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 0/3] drm, drm/xe: Protect against premature module unloads
Date: Thu, 24 Sep 2026 10:04:52 +0200
Message-ID: <20260924080455.25458-1-thomas.hellstrom@linux.intel.com>
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

v2:
- Use plain WARN_ON_ONCE() instead of drm_WARN_ON_ONCE(NULL, ...) in
  drm_dev_release_barrier(), fixing a NULL pointer dereference on the
  warning path itself (patch 1, sashiko)
- Updated the commit message of patch 2 to describe the actual
  implementation (a single 20s wait_var_event_timeout() followed by
  one pr_warn() and an unbounded wait_var_event(), rather than a loop
  retrying with a diagnostic every 10s) and its uninterruptible-sleep
  tradeoff (sashiko)

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

