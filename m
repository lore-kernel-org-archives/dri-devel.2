Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630B2CA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 01:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8638410E17E;
	Tue, 13 Oct 2026 01:06:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DFC10E17E;
 Tue, 13 Oct 2026 01:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791853591; x=1823389591;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5OTVq/e6cZx3eSi8qqSCW6RVSULZUBR8ayE9iR5mw14=;
 b=Exa7fvW+sRB6yZJ0OCV9tcoaPpFJ6qfA+1Isit1gWR8nopyshcr6l7zn
 fgLc700qXki9dpjRr9RECuiNIUAkg25rcldlXuZWtQ5hfIGlGvGbvOf8f
 2xwlzdNwvpn7netJ03bPumOWUvvSHhopNBXOLtF8dUONmYYkmj6vV09AH
 97owAuVzXIsMzVADJ9cE3d1y593Z5CgDNrEtVut9IvZxcgjO+LJWyVei0
 E5xdVH+16cgMjI8uKaJQzBUBEG848/Db3Me9NoVoSZYIjI3YoqR1pVyg9
 LNM5Nmp//MN93GN7m2/wE8DOcQOY6DTQ1mELB/zZaZjRnhF4netHL2/ST g==;
X-CSE-ConnectionGUID: cYzUtT6oSeuNqu64AIrp+g==
X-CSE-MsgGUID: Y+Y/ESZeRvWBICfG+R2Wmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="557194"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="557194"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:31 -0700
X-CSE-ConnectionGUID: T8ERY1rDRQ6d9aKv0/Q7bQ==
X-CSE-MsgGUID: Ul8tkpz6ROydrUA2ePkVqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1360815"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:19 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com
Subject: [PATCH v2 0/6] drm: consolidate self-imported PRIME dma-buf detection
Date: Mon, 12 Oct 2026 18:06:12 -0700
Message-ID: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
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

Patches 4-6 convert panthor, panfrost and amdgpu to
drm_gem_prime_self_import(), removing the duplicated open-coded checks.

No intended functional change.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

Farah Kassabri (2):
  drm/gem: add helper to detect self-imported PRIME dma-bufs
  drm/xe/dma-buf: Use drm helper to detect dma-buf self-import

Niranjana Vishwanathapura (4):
  drm/gem: add drm_gem_prime_dma_buf_to_gem() self-import helper
  drm/panthor: use drm_gem_prime_self_import() helper
  drm/panfrost: use drm_gem_prime_self_import() helper
  drm/amdgpu: use drm_gem_prime_self_import() helper

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 +---
 drivers/gpu/drm/drm_gem_shmem_helper.c      | 14 ++--
 drivers/gpu/drm/drm_prime.c                 | 74 +++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_gem.c     | 10 +--
 drivers/gpu/drm/panthor/panthor_gem.c       | 10 +--
 drivers/gpu/drm/xe/xe_dma_buf.c             | 23 ++++---
 drivers/gpu/drm/xe/xe_dma_buf.h             |  2 +
 include/drm/drm_prime.h                     |  8 ++-
 8 files changed, 91 insertions(+), 64 deletions(-)

-- 
2.43.0

