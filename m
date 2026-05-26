Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4189CCD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 19:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAA910E1C9;
	Tue, 26 May 2026 19:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IKTKRiev";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7178E10E1C9
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779823733; x=1811359733;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=f99xfPOKY0Clvj0JEJInaSU/gOZipDJ+t86ZLTuIuW8=;
 b=IKTKRievs3PLxYwwBpPwG65nGdM6UwQolFruq09ZT+XBikrZx//YuOD4
 K25+37dOWrScFqYrvQv32SAGmUJxG++3NpFQi2TUJR1qbLFB/Onq4vcdK
 BTGJa4X5mQmhcv2VOSxi6w6lwXUzQZ4/Sot8wFbsWUfseyAZKM8Aya7gD
 FnWcgWzM7tlzBS+bff1vLQxW84I1fPEctMU6es3JeJegOVI/9i9UTMS6/
 90xjKmbLE3Mi1EK5itTwpmsawvcuxp5VRm6g0MREpVbHM/YG7/er5lrtS
 faQA/D0tMcBoJ6AFLj7LECbwRNdv4bPu5LjPIWtejETOetbhhMYS0Obgn Q==;
X-CSE-ConnectionGUID: z4Y3Wf4CRGejTKTBS81y5g==
X-CSE-MsgGUID: npd6zgCqQ8Sv1PypSNLZTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91219165"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="91219165"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 12:28:53 -0700
X-CSE-ConnectionGUID: um8HlKU5RtGnKzksDInoRQ==
X-CSE-MsgGUID: my+TkOLCSb2zarHsFayGDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241172576"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.158.5])
 by orviesa010.jf.intel.com with ESMTP; 26 May 2026 12:28:53 -0700
From: dongwon.kim@intel.com
To: dri-devel@lists.freedesktop.org, airlied@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com
Subject: [PATCH v9 0/3] Virtio-GPU S4 support
Date: Tue, 26 May 2026 12:28:11 -0700
Message-Id: <20260526192814.179673-1-dongwon.kim@intel.com>
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
driver, alongside a PM notifier to properly handle object tracking and 
restoration for S4 (hibernation) scenarios.

The first patch adds the `virtgpu_freeze` and `virtgpu_restore` functions. 
These functions orchestrate flushing pending work, safely deleting virtio 
queues before suspension once they are empty, and recreating them during 
the restoration process.

The second patch implements a tracking and recreation mechanism for active 
`virtio_gpu_object` instances. This is necessary because the host hypervisor 
(e.g., QEMU) terminates or resets the backend during a full hibernation cycle, 
wiping out all previously established graphics resources and causing post-resume 
errors in the guest.

The third patch integrates a PM notifier block into the driver. It captures 
the PM_HIBERNATION_PREPARE phase to check compatibility (blocking S4 if Virgl 
3D is active) and sets a state flag. This flag instructs `virtgpu_restore` to 
fully re-submit and restore active GPU objects immediately after the fresh 
virtqueues are reconfigured.

These changes ensure that the virtio-gpu driver can cleanly survive guest 
hibernation without experiencing host-side resource loss.

v2: 10ms sleep is added in virtgpu_freeze to avoid the situation
    the driver is locked up during resumption.

v3: Plain 10ms delay (v2) is replaced with wait calls which wait until
    the virtio queue is empty.
    (Dmitry Osipenko)

v4: New version of patchset only covers S4 case because loss of resources in S3
    case can be avoided by skipping virtio-gpu-reset in QEMU (hw/display/virtio-gpu.c).
    To skip virtio-gpu-reset (soft-reset), virtio-gpu-pci device should be attached to
    PCIE bus AND a PCIE option, 'x-pcie-pm-no-soft-reset' should added and set to 'true'.
    (e.g. -device virtio-gpu-pci,bus=port,x-pcie-pm-no-soft-reset=true)

v5: Remove virtio_gpu_object from the restore list before freeing the object
    to prevent an use-after-free situation.
    (Nirmoy Das)

    Protect restore list operations with a spinlock
    (Nirmoy Das)

    Move restore list node into virtio_gpu_bo struct to reduce memory usage
    (Dmitry Osipenko)

    Remove unused header - drm_atomic_helper.h
    (Dmitry Osipenko)

v6: Include object backed by imported dmabuf
    (Dmitry Osipenko)

    Not storing virgl objects in the restore_list as virgl 3D objects are not
    recoverable.
    (Dmitry Osipenko)

    Change the name 'list',a node in restore_list to 'restore_node'
    (Nirmoy Das)

    Use mutex instead of spinlock when updating restore_list
    (Nirmoy Das)

    Initialize restore_node when virtio_gpu_object is created - this is to
    check if the node is in the list with 'list_empty' before removing it.

    Restoring objects in the PM notifier is too late, as virtio-gpu
    message communication begins in virtgpu_restore once virtqueues
    are re-established. To address this, a 'hibernation' flag is set
    during the PM_HIBERNATION_PREPARE phase in the notifier. This flag
    is then used in virtgpu_restore to detect if the system is resuming
    from S4, allowing objects to be recovered immediately after virtqueues
    are reconfigured.

v7: Add a helper, virtio_gpu_add_object_to_restore_list
    (Dmitry Osipenko)

    Unreference all objects before hibernation so they can be removed
    on the host side, since they will be fully restored anyway. This
    prevents the situation where host-side hibernation fails (leaving
    all associated resources still alive) while the virtio-gpu driver
    still attempts to restore those objects.
    (Dmitry Osipenko)

v8: Add drm_print.h to virtgpu_prime.c

v9: Move duplicate wait_event_timeout blocks into a single
    virtio_gpu_wait_queue helper function.
    (Dmitry Osipenko)

    Handle timeouts gracefully by returning -ETIMEDOUT to abort
    the freeze operation if the host hangs.
    (Dmitry Osipenko)

Dongwon Kim (3):
  drm/virtio: Freeze and restore hooks to support suspend and resume
  drm/virtio: Add support for saving and restoring virtio_gpu_objects
  drm/virtio: Add PM notifier to restore objects after hibernation

 drivers/gpu/drm/virtio/virtgpu_drv.c    | 80 ++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h    | 25 ++++++-
 drivers/gpu/drm/virtio/virtgpu_kms.c    | 54 +++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_object.c | 87 ++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_prime.c  | 45 ++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 30 ++++++++-
 drivers/gpu/drm/virtio/virtgpu_vram.c   |  5 +-
 7 files changed, 312 insertions(+), 14 deletions(-)

-- 
2.34.1

