Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B811FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D34810F17A;
	Wed, 29 Apr 2026 20:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CZzuTJVd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF2510E061
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 20:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777495967; x=1809031967;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WEYJXOL6HD6IBhyWCFHwXqxhixAmMAmAXgZyPcoZs00=;
 b=CZzuTJVdEbyVx89BwlthQYUmj6YSNQTAdHqmqxhek625QjnJ3/FcV/o3
 v0XEVg/Vfj1uhm720aqjH0mXZ0TUY13xevU8xr/ei60S+hCXOH1vVh2WL
 S4Jvi4jG0z0//GquLRkL6FwMrCpvCvWJoh7Gbd9U0Vmz0eEPmvuqjuphk
 bkK28fY2hWRIhLeVWBhMDh477r0wh1XcF/1BS4niHe5VLfs+oXoaIwBVC
 HgZdQ15k80k2G/9ftNgKF89LIsVauZsE9/D4ch9Kk+TBuY6Mx1GD//MhY
 jbJeM3Q8mMELpTGrMnUfjOfBAdBsHHuObk2nvaqUeEMjslrRn/xQcBAGp g==;
X-CSE-ConnectionGUID: f2ECKCn5RQ+O2xKxpXQN3A==
X-CSE-MsgGUID: V2Lj9RInRoifzxZktIk27w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78490689"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="78490689"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 13:52:46 -0700
X-CSE-ConnectionGUID: /CdYE+/dQeCjmEiESRD82Q==
X-CSE-MsgGUID: Mrq8t0tyQDiT7fuOm/lZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="272499911"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.158.5])
 by orviesa001.jf.intel.com with ESMTP; 29 Apr 2026 13:52:46 -0700
From: dongwon.kim@intel.com
To: dri-devel@lists.freedesktop.org, airlied@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com
Subject: [PATCH v8 0/3] Virtio-GPU S4 (hibernation) support
Date: Wed, 29 Apr 2026 13:47:26 -0700
Message-Id: <20260429204729.993669-1-dongwon.kim@intel.com>
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

From: Dongwon Kim <dongwon.kim@intel.com>

This patch series implements the .freeze and .restore hooks for the virtio-gpu 
driver, alongside a PM notifier to manage object restoration during S4 
(hibernation) cycles.

The series is structured as follows:

1. The first patch introduces `virtgpu_freeze` and `virtgpu_restore`. These
   functions handle the teardown of virtio queues before suspension and their
   subsequent recreation during the resume process.

2. The second patch implements a tracking and restoration mechanism for
   `virtio_gpu_object` instances. This is essential because the host (e.g., QEMU)
   destroys all associated graphics resources during the virtio-gpu reset
   triggered by the hibernation/resume cycle.

3. The third patch adds a PM notifier to handle the resubmission of these
   tracked virtio-gpu objects to the host once the guest restores its
   virtqueues.

Together, these changes ensure that the virtio-gpu driver can survive 
hibernation without resource loss or invalid resource errors.

v2: - Added 10ms sleep in virtgpu_freeze to prevent lockups during resumption.

v3: - Replaced the fixed 10ms delay with wait calls that trigger once the 
      virtio queue is empty.
      (Dmitry Osipenko)

v4: - Limited the scope to S4 (hibernation). S3 resource loss can be avoided 
      via QEMU configurations (e.g., x-pcie-pm-no-soft-reset=true).

v5: - Implemented removal of objects from the restore list before freeing to 
      prevent a use-after-free situation.
      (Nirmoy Das)

    - Protected restore list operations with a spinlock.
      (Nirmoy Das)

    - Moved the restore list node into the virtio_gpu_bo struct to optimize 
      memory usage.
      (Dmitry Osipenko)

    - Removed unused header: drm_atomic_helper.h.
      (Dmitry Osipenko)

v6: - Added support for objects backed by imported dma-bufs.
      (Dmitry Osipenko)

    - Excluded virgl 3D objects from the restore list as they are currently 
      non-recoverable.
      (Dmitry Osipenko)

    - Renamed the list node to 'restore_node'.
      (Nirmoy Das)

    - Switched from spinlock to mutex for restore list updates.
      (Nirmoy Das)

    - Initialized restore_node at creation to allow safe 'list_empty' checks.

    - Introduced a 'hibernation' flag in the PM notifier to trigger restoration 
      at the correct stage in `virtgpu_restore`.

v7: - Added helper: virtio_gpu_add_object_to_restore_list.
      (Dmitry Osipenko)

    - Implemented unreferencing of all host-side objects before hibernation 
      to ensure a clean state upon resume.
      (Dmitry Osipenko)

v8: - Introduced virtio_gpu_remove_from_restore_list helper and ensured it is 
      called across all object destruction paths (General, Prime, and VRAM) 
      to prevent use-after-free.
      (Dmitry Osipenko)

    - Relocated restore list removal logic from the final cleanup stage to 
      the initial free stage for improved synchronization.
      (Dmitry Osipenko)

    - Added missing drm_print.h header.

Dongwon Kim (3):
  drm/virtio: Freeze and restore hooks to support suspend and resume
  drm/virtio: Add support for saving and restoring virtio_gpu_objects
  drm/virtio: Add PM notifier to restore objects after hibernation

 drivers/gpu/drm/virtio/virtgpu_drv.c    | 74 ++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h    | 24 ++++++-
 drivers/gpu/drm/virtio/virtgpu_kms.c    | 54 +++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_object.c | 88 ++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_prime.c  | 45 ++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 13 +++-
 drivers/gpu/drm/virtio/virtgpu_vram.c   |  5 +-
 7 files changed, 289 insertions(+), 14 deletions(-)

-- 
2.34.1

