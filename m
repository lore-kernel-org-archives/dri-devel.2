Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C02C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED3B10E649;
	Wed, 14 Oct 2026 19:34:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1FFC10E423;
 Wed, 14 Oct 2026 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006469; x=1823542469;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ihFCEcs0EkD5rOgYHNR20WPF3/ri2xBBmM7VLNFgsv8=;
 b=XpugXK0t8182JNbbXTQ97Ex8STvf0YPp1mItsw/2gozAbHbaD/T+nK1x
 1ZJ9CM9YUbuMPbbemPtnnR+F14eHhwtNc5JniuBNJIfRg9XYXHUAWQCbq
 bS6sroXW4gMSdLQc5tIhyQUCYc/wqRRo9Bz1kwYnhjS6GzLZNX2jZfb4T
 ddF4kL1HgHJXuoNxmauZHqKPeM5cwe8mSfAq+oPyJld+fr7y8CMQMGqn+
 CvFhdBS06GlZUMjwR9xdDECshUijh7qWFvxTRfRCxwD8fFTl3wXESw1Um
 5I1uZpYS7IMC9NqBWQvZzE0dmCcqAdOhHmk413gwf82Sq7qyiO3rxrH9L g==;
X-CSE-ConnectionGUID: /rpjDIfxReu+ajFR62CQrg==
X-CSE-MsgGUID: 06ikyU8fSAySoqzNVP02oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653854"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653854"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:28 -0700
X-CSE-ConnectionGUID: 8STeHADkQyiTBNNFldEnZg==
X-CSE-MsgGUID: C2cWW5BgTFGMKga2O/Zfpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270483"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:28 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 00/12] drm: consolidate self-imported PRIME dma-buf
 detection
Date: Wed, 14 Oct 2026 12:34:20 -0700
Message-ID: <20261014193421.1705112-14-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
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

Detecting that a PRIME dma-buf being imported was exported by the same
DRM device is a pattern currently open-coded in many drivers (compare
dma_buf->ops against the driver's own ops, check obj->dev == dev, then
return the GEM object with an extra reference). This series adds generic
helpers for it and converts several drivers to use them.

Patch 1 adds drm_gem_prime_self_import(dev, dma_buf, ops): for a dma-buf
self-exported via the given ops, it returns the backing GEM object with
a reference, letting a driver short-circuit the generic PRIME import and
skip the extra dma-buf file reference. Patch 2 converts Xe to it.

Patch 3 adds drm_gem_prime_dma_buf_to_gem(), a thin wrapper that uses the
core PRIME ops, and replaces the drm_gem_is_prime_exported_dma_buf() bool
predicate with it so the shmem importer resolves the object directly
(the sole caller already wanted the referenced object).

Patches 4-12 updates various drivers to use drm_gem_prime_self_import(),
removing the duplicated open-coded checks.

No intended functional change.

v2: Add patches 4-6
v3: Move drm_gem_prime_self_import() to drm_gem.h as a static inline
    helper routine
v4: Add patches 7-12

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

Farah Kassabri (2):
  drm/gem: add helper to detect self-imported PRIME dma-bufs
  drm/xe/dma-buf: Use drm helper to detect dma-buf self-import

Niranjana Vishwanathapura (10):
  drm/gem: add drm_gem_prime_dma_buf_to_gem() self-import helper
  drm/panthor: use drm_gem_prime_self_import() helper
  drm/panfrost: use drm_gem_prime_self_import() helper
  drm/amdgpu: use drm_gem_prime_self_import() helper
  drm/armada: use drm_gem_prime_self_import() helper
  drm/omapdrm: use drm_gem_prime_self_import() helper
  drm/tegra: use drm_gem_prime_self_import() helper
  drm/msm: use drm_gem_prime_self_import() helper
  drm/virtio: use drm_gem_prime_self_import() helper
  drm/i915: use drm_gem_prime_self_import() helper

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 ++-----
 drivers/gpu/drm/armada/armada_gem.c         | 15 ++------
 drivers/gpu/drm/drm_gem_shmem_helper.c      | 14 +++----
 drivers/gpu/drm/drm_prime.c                 | 36 +++++++++---------
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c  | 21 +++++------
 drivers/gpu/drm/msm/msm_gem_prime.c         | 16 +++-----
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c   | 14 ++-----
 drivers/gpu/drm/panfrost/panfrost_gem.c     | 10 ++---
 drivers/gpu/drm/panthor/panthor_gem.c       | 10 ++---
 drivers/gpu/drm/tegra/gem.c                 | 12 ++----
 drivers/gpu/drm/virtio/virtgpu_prime.c      | 14 ++-----
 drivers/gpu/drm/xe/xe_dma_buf.c             | 23 ++++++-----
 drivers/gpu/drm/xe/xe_dma_buf.h             |  2 +
 include/drm/drm_gem.h                       | 42 +++++++++++++++++++++
 include/drm/drm_prime.h                     |  4 +-
 15 files changed, 119 insertions(+), 128 deletions(-)

-- 
2.43.0

