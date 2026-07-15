Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C20C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 04:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC71710E10C;
	Wed, 15 Jul 2026 04:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RlM0wtQr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0908010E10C;
 Wed, 15 Jul 2026 04:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784089720; x=1815625720;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cwVXOPAdpkPreL8TtzOaX0/zP6d8ohxrVmTc1ce8a7Y=;
 b=RlM0wtQrHGwEnw0IiJ7uALKdwyFg59iZlPnTgqVbWIsJUvD7w2KyguYG
 NMpEViszJLqQxubtikrhlJhyNEeChDdjwXthgU/e3uhvmAkjo0ag3CI+z
 aYtnEbZS5wBlB+6AtF+aG2GQNUfEnHig2pGOL/jNF9P0OAgeT0eo5foiO
 +ZiR3Ly4zQF+urV+ZeUH4YXJ8+QIjNi7NAeHRXtNAgXRVXz7yyodInJNn
 WAvxJ/LhTf9ef6pD5iOvRRVQ/WXrnU68Qh5HUqfsdT4vjJrIpPwCx0BFx
 M4o//HUj91NZqk0fSjDVgS7WczAw/oWwxvXrZe4LHtJn1GXzDiSsxyoek w==;
X-CSE-ConnectionGUID: O6WPGsy1Rp2VuHpkAvCyNQ==
X-CSE-MsgGUID: WZMqDV5LQJaHvSJRwKOtOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88542510"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="88542510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 21:28:40 -0700
X-CSE-ConnectionGUID: JtxCVB1WSpS769Qohi/Z7g==
X-CSE-MsgGUID: yFvRHnJURB6UEDcd+2+VIA==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 21:28:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/4] drm/xe: Prioritize BO eviction based on VM exec queue
 priority
Date: Tue, 14 Jul 2026 21:28:28 -0700
Message-Id: <20260715042832.3625096-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

This series ties a BO's TTM LRU priority (i.e. how likely it is to be
picked for eviction/shrinking under memory pressure) to how userspace
is actually using the VM and BOs it belongs to, instead of treating
every BO the same.

The reasoning behind the heuristic:

 - Kernel BOs, and any BO not private to a single VM (no vm_id, e.g.
   shared/exported buffers), are given the highest priority so they
   are the least likely to be evicted -- these are foundational or
   shared resources.
 - BOs private to a VM are then prioritized based on the highest
   priority band userspace has assigned to any exec queue attached to
   that VM: a VM with a HIGH priority exec queue keeps its BOs at the
   highest priority (matching kernel/shared BOs), a VM with only
   NORMAL priority queues (or none yet) gets the next priority band
   down, and a VM with only LOW priority queues gets the band below
   that.
 - The lowest priority band is reserved exclusively for BOs (private
   or shared) that have no VMA mappings left anywhere. This lets
   userspace use an unbind as a signal of "drop this from my working
   set, but keep the backing store around in case I need it again" --
   the BO is retained, just made a preferred candidate for
   eviction/shrinking until it is rebound.

Patch 1 adds the accounting: a per-priority-band count of exec queues
attached to each user VM. Patch 2 introduces the actual heuristic and
uses it both to set a BO's initial priority at creation time and to
bulk re-prioritize a VM's existing private BOs when an exec queue is
added or removed. Patch 3 fixes up staleness that these earlier
mechanisms miss: BOs created before any exec queue exists, or bound
late via VM_BIND, and BOs not tied to a single VM that get demoted to
the lowest priority and then rebound. Patch 4 introduces the
lowest-priority demotion itself, applied when a BO loses its last VMA
mapping.

Matt

Matthew Brost (4):
  drm/xe: Track exec queue priority band counts for user VMs
  drm/xe: Re-prioritize VM's private BOs when adding an exec queue
  drm/xe: Fix up BO TTM priority for late VM binds
  drm/xe: Lower BO TTM priority to lowest when fully unmapped from VM

 drivers/gpu/drm/xe/xe_bo.c       |  18 ++-
 drivers/gpu/drm/xe/xe_bo.h       |   3 +-
 drivers/gpu/drm/xe/xe_bo_types.h |   3 +
 drivers/gpu/drm/xe/xe_dma_buf.c  |   2 +-
 drivers/gpu/drm/xe/xe_vm.c       | 205 +++++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_vm.h       |   1 +
 drivers/gpu/drm/xe/xe_vm_types.h |   7 ++
 7 files changed, 221 insertions(+), 18 deletions(-)

-- 
2.34.1

