Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE55CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC1310EAE6;
	Thu,  1 Oct 2026 22:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b8+mBsti";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9AF10E261;
 Thu,  1 Oct 2026 22:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790892399; x=1822428399;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=b028Sla/ILrQ+qBhjCupRSKf07oWLAqEX/nGYHy17R4=;
 b=b8+mBstiQ2LzSm3TyH7G5Rk05qHcPxWyAwDMyuDHK8MIMUy/1DWh3x8n
 Ea8rg3V0twFNQ/IOyero0XSO7+WQm3gNYSUvGSpngvSqZLdKVoAO0Efdk
 vuNOQFsZqgHrsTW3GF06WFLpCdXDT1fjc+Vu94OLcJs8kz3CSBSw7VpOC
 48k7Qq4Tm//nc4SMl5FURdZLfhFDzFwKEnuvZIZrgapgYFn40WuOwLjP9
 IXBxsgnmtM82f+OEpM0k0KqTEUEZhrfU5Oc3yfTuMmsdsuOjR6DZvHi+3
 nRUFAmUPdHop0GLbUrC7DlrwN0SlEw8m+oVuozloNtZgyhmR4tIDBxj6h A==;
X-CSE-ConnectionGUID: NcfWwnklStGKtvhJlkiRNw==
X-CSE-MsgGUID: WkYUa5I0T32tKKRY/Dlm+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91526762"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="91526762"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:37 -0700
X-CSE-ConnectionGUID: O6YWZVGITlW5BX0sPv0DRQ==
X-CSE-MsgGUID: TaYFCr/ISZSPVtVVRhwSdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="274190009"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:38 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/8] drm/gpuvm: two pass locking for exec
Date: Thu,  1 Oct 2026 15:06:24 -0700
Message-Id: <20261001220632.3190896-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

Two processes share a set of buffers, and each has buffers of its own
which the other never sees. Say process A has mapped

  S        the shared buffers, also mapped by B
  P        buffers private to A

and B has mapped S plus private buffers of its own. The overlap is
exactly S, and the work each process wants to do on its own buffers is
independent of the other.

A submits. Its exec locks the dma-resv of everything it has mapped, S
and P both, then finds something in P has been evicted and migrates it
back in. B submits, and blocks on S for as long as that migration takes,
even though the migration is of a buffer belonging to A which B has
never seen.

So the stall does not come from the overlapping set. The buffers in S
are resident, and neither exec has anything to do to them beyond
attaching a fence. They are held only because an exec locks everything
it has mapped in one go, and they stay held until the slowest unrelated
thing in that transaction is done.

Which buffers get evicted is a separate matter, and one which already
has answers: eviction heuristics which leave shared buffers alone, or
one process' allocations outranking another's. This is what is left once
those work.

Where this tends to show up is compositors and presentation, which is
also where userspace has worked hardest to avoid it. Wayland explicit
sync exists so that a compositor is not latched onto its clients'
rendering, waiting on fences it never asked for. The locking above
reintroduces that coupling anyway, in the kernel, and does it under
memory pressure, which is where a missed frame is least welcome and the
cause is hardest to see.

The fix is to stop coupling "lock the VM" to "validate it". Instead of
locking everything and then validating, lock the private buffers and the
evicted external ones, validate those, and only then lock the rest, all
within the same drm_exec transaction.

Patch 1 lets a driver split the locking of an exec that way, patches 2
and 3 use it in Xe and Panthor, whose panthor_vm_bo_validate() swaps
pages back in under those same shared locks. It is opt-in, and drivers
which do not ask for it are unaffected.

Patches 5 and 6 do the same for MSM. Its VM_BIND submit path locks every
BO mapped in the VM and then validates the evicted ones, which means
getting their pages and mapping them again, with the shared BOs locked
throughout. Patch 4 switches VM_BIND VMs to DRM_GPUVM_RESV_PROTECTED,
which two pass locking requires, and patch 5 splits the submit's locking
into the two passes. Kernel managed VMs and the legacy submit path are
left alone.

The MSM part should resolve exactly the problem Anna Maniscalco
presented at XDC, render jobs stalling the compositor on shared buffers,
which is currently worked around with a downstream hack in MSM for
SteamOS [1][2] (the talk starts at 5:30).

Nouveau support for DRM_GPUVM_RESV_PROTECTED and two pass locking added
in patches 7 and 8.

All driver updated side from Xe untested.

[1] https://indico.freedesktop.org/event/12/contributions/627/
[2] https://www.youtube.com/watch?v=j5W5ErEMnvM&t=330s

Matt

Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Antonino Maniscalco <antomani103@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Steven Price <steven.price@arm.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: LLM

---
v3:
 - Address Danilo's comments of GPUVM patch
 - Update MSM to reject submit_bo on VM_BIND context (Sashiko)
 - Also update Nouevau

Matthew Brost (8):
  drm/gpuvm: allow locking external objects in two passes
  drm/xe: lock the resident BOs of an exec last
  drm/panthor: lock the resident BOs of a submit last
  drm/msm: reject a submit_bo table on VM_BIND contexts
  drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs
  drm/msm: lock the resident BOs of a VM_BIND submit last
  drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
  drm/nouveau: lock the resident BOs of an exec last

 Documentation/gpu/drm-mm.rst           |   6 +
 drivers/gpu/drm/drm_gpuvm.c            | 505 ++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c   |  90 ++++-
 drivers/gpu/drm/msm/msm_gem_vma.c      |  16 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c |  27 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  49 ++-
 drivers/gpu/drm/panthor/panthor_mmu.c  |  55 ++-
 drivers/gpu/drm/xe/xe_exec.c           |  23 +-
 drivers/gpu/drm/xe/xe_vm.c             |  43 ++-
 drivers/gpu/drm/xe/xe_vm.h             |   3 +-
 include/drm/drm_gpuvm.h                | 139 ++++++-
 11 files changed, 882 insertions(+), 74 deletions(-)

-- 
2.34.1

