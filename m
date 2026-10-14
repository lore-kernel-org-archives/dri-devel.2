Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22F5C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF8C10EAC4;
	Wed, 14 Oct 2026 19:02:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4ED10E156;
 Wed, 14 Oct 2026 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792004530; x=1823540530;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WVA/2yfeqOlCibgdYNpW3YjDL5NsaMALXdsJNVhl++Y=;
 b=mEQEFxlk8k1cgichwg/bn51YqHIGepQldfLWgioUJW62Z2DWtx31dYcq
 etynNI5P2JI04dw4bidw24seuCjuvgXrbSAhlavSyfGJd2Ss5o5OYIkd4
 80xj1YTW2//ZPboIaBW54OjJTYoiN0O5oU8RMwvgizyONP6OMDtIrjxJa
 e7fE2j7SO4HlxV+MCl0CMsQGGE3hWVPtUiopro5Qm5GfiL2tTl/BtYOYM
 D5mAuQz2XRadEKBfdQfbo27l7PcAoyJT8M3jFddUN3qzXRclxUvRNImNu
 uV4C8ZSOTColLwNzaIbKas9b6ZzRSUQlza75C+QbPF0sgzpHic+RifUK7 w==;
X-CSE-ConnectionGUID: cifYTnMYSRKTGs8maQLx8A==
X-CSE-MsgGUID: 8wjJ5UU5Sqmjvu8wMlAF/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="648016"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="648016"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:02:09 -0700
X-CSE-ConnectionGUID: EyZ6/pp0QyinVT8Qy1K1Yw==
X-CSE-MsgGUID: cSloaMueTfGKUeGk6FcgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1941281"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:02:10 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v3 0/6] drm: consolidate self-imported PRIME dma-buf detection
Date: Wed, 14 Oct 2026 12:02:00 -0700
Message-ID: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
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

v2: Add patches 4-6
v2: Move drm_gem_prime_self_import() to drm_gem.h as a static inline
    helper routine

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

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 ++-----
 drivers/gpu/drm/drm_gem_shmem_helper.c      | 14 +++----
 drivers/gpu/drm/drm_prime.c                 | 36 +++++++++---------
 drivers/gpu/drm/panfrost/panfrost_gem.c     | 10 ++---
 drivers/gpu/drm/panthor/panthor_gem.c       | 10 ++---
 drivers/gpu/drm/xe/xe_dma_buf.c             | 23 ++++++-----
 drivers/gpu/drm/xe/xe_dma_buf.h             |  2 +
 include/drm/drm_gem.h                       | 42 +++++++++++++++++++++
 include/drm/drm_prime.h                     |  4 +-
 9 files changed, 91 insertions(+), 64 deletions(-)

-- 
2.43.0

