Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4FDC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 13:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A5810E44B;
	Sun, 12 Jul 2026 13:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WrypsVEZ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 68BD210E44B
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:54:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD72C1684;
 Sun, 12 Jul 2026 06:54:43 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6143F7D8;
 Sun, 12 Jul 2026 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783864487; bh=vSrIv2j9F39UXRUCXJIkutVobSrA/KqX+K/OE0mluiA=;
 h=From:To:Cc:Subject:Date:From;
 b=WrypsVEZVKD1c1cAoijPe+akHKMW8nzO6Py8oTjHZ7QXOfr6pG0c++UxVoG8gpx+8
 Bl3/xOgSvQ87KArPV/PcbV8b1LZt1qKQLWwjI8lVBLau680OC4AsSDvKNuEZZbu497
 S0jxQwbQo3DpS9+IAafI56GXQ4tHauyWlBBAwTtA=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v2 0/7] drm/panthor: Protected mode support for Mali CSF GPUs
Date: Sun, 12 Jul 2026 15:54:32 +0200
Message-ID: <20260712135439.1546950-1-ketil.johnsen@arm.com>
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

Hi,

This is a patch series covering the support for protected mode execution in
Mali Panthor CSF kernel driver.

It builds on the initial RFC posted by Florent Tomasin back in January of 2025.

The initial RFC can be found here:
https://lore.kernel.org/lkml/cover.1738228114.git.florent.tomasin@arm.com/

The Mali CSF GPUs come with the support for protected mode execution at the
HW level. This feature requires two main changes in the kernel driver:

1) Configure the GPU with a protected buffer. The system must provide a DMA
   heap from which the driver can get protected buffers.
   It can be a carved-out memory or dynamically allocated protected memory region.
   Some system includes a trusted FW which is in charge of the protected memory.
   This problem is integration specific and the responsibility to allocate the
   required protected memory from the correct and system specific DMA heap is
   left to user space (Mesa). Panthor CSF driver must be handed the needed
   buffers via new IOCTLs.

2) Handle enter and exit of the GPU HW from normal to protected mode of execution.
   FW sends a request for protected mode entry to the kernel driver.
   The acknowledgment of that request is a scheduling decision. Effectively,
   protected mode execution should not overrule normal mode of execution.
   A fair distribution of execution time will guaranty the overall performance
   of the device, including the UI (usually executing in normal mode),
   will not regress when a protected mode job is submitted by an application.


Background
----------

Current Mali Panthor CSF driver does not allow a user space application to
execute protected jobs on the GPU. This use case is quite common on end-user-device.
A user may want to watch a video or render content that is under a "Digital Right
Management" protection, or launch an application with user private data.

1) User-space:

   In order for an application to execute protected jobs on a Mali CSF GPU the
   user space application must submit jobs to the GPU within a "protected regions"
   (range of commands to execute in protected mode).

   Find here an example of a command buffer that contains protected commands:

```
          <--- Normal mode ---><--- Protected mode ---><--- Normal mode --->
   +-------------------------------------------------------------------------+
   | ... | CMD_0 | ... | CMD_N | PROT_REGION | CMD_N+1 | ... | CMD_N+M | ... |
   +-------------------------------------------------------------------------+
```

   The PROT_REGION command acts as a barrier to notify the HW of upcoming
   protected jobs. It also defines the number of commands to execute in protected
   mode.

   The Mesa definition of the opcode can be found here:

     https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/panfrost/lib/genxml/v10.xml?ref_type=heads#L763

2) Kernel-space:

   When loading the FW image, the Kernel driver must also load the data section of
   CSF FW that comes from the protected memory, in order to allow FW to execute in
   protected mode.

   Important: this memory is not owned by any process. It is a GPU device level
              protected memory.

   In addition, when a CSG (group) is created, it must have a protected suspend buffer.
   This memory is allocated within the kernel but bound to a specific CSG that belongs
   to a process. The kernel owns this allocation and does not allow user space mapping.
   The format of the data in this buffer is only known by the FW and does not need to
   be shared with other entities. The purpose of this buffer is the same as the normal
   suspend buffer but for protected mode. FW will use it to suspend the execution of
   PROT_REGION before returning to normal mode of execution.


Design decisions
----------------

The earlier versions (RFC and v1) relied on in-kernel allocation of protected
DMA-bufs, both for the required FW memory (system wide), and per group
suspend buffers (per process). This is no longer needed.
Starting with v2, this is now changed and it is user space which is responsible
for supplying these buffers.
Only a user space processes with elevated privileges (CAP_SYS_MODULE) is trusted
to provide the system wide protected FW memory. This only needs to happen once
per boot, and is needed before any non-privileged processes can make use of
protected rendering.

The Mali Panthor CSF kernel driver will handle enter/exit of protected
mode with a fair consideration of the job scheduling.

If the system integrator does not provide a protected DMA heap, the driver
will not allow any protected mode execution.

Patch series
------------

[PATCHES 1-5]:
  These are refactoring to aid the implementation of the protected rendering
  feature itself.

  * drm/panthor: De-duplicate FW memory section sync
  * drm/panthor: Minor scheduler refactoring
  * drm/panthor: Explicit expansion of locked VM region
  * drm/panthor: Pass drm_file instead of panthor_file - NEW
  * drm/panthor: Don't allocate protm_suspend_buf - NEW

[PATCH 6]:
  This patch implements the logic to handle enter/exit of the GPU protected
  mode in Panthor CSF driver.

  Note: To ease the handling of faults from protected mode, only a single CSG is
        allowed to execute while in protected mode. It must be the top priority one.

  * drm/panthor: Add support for entering and exiting protected mode

[PATCH 7]:
  The final patch exposes this feature via the uAPI and adds the necessary
  handling/use of user space provided protected memory.

  * drm/panthor: Expose protected rendering features - NEW

Testing
-------

1) Platform and development environment

   Any platform containing a Mali CSF type of GPU and a protected memory allocator
   that is based on DMA Heap can be used. For example, it can be a physical platform
   or a simulator such as Arm Total Compute FVPs platforms. Reference to the latter:

     https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms/Total%20Compute%20FVPs

2) Mesa:

PanVK support can be found here:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40044


Changes in v2:
- Patches 1-5: Refactoring/prep work patches are either new or have only minor changes.
- Patch 6: Heavily reworked, although conceptually similar to v1.
- Patch 7: New
- All old code for in-kernel allocation of protected memory has been dropped.
  There are no longer any dependencies on dma-heap changes.

Boris Brezillon (2):
  drm/panthor: Pass drm_file instead of panthor_file
  drm/panthor: Expose protected rendering features

Florent Tomasin (2):
  drm/panthor: Minor scheduler refactoring
  drm/panthor: Add support for entering and exiting protected mode

Ketil Johnsen (3):
  drm/panthor: De-duplicate FW memory section sync
  drm/panthor: Explicit expansion of locked VM region
  drm/panthor: Don't allocate protm_suspend_buf

 drivers/gpu/drm/panthor/panthor_device.c |   1 +
 drivers/gpu/drm/panthor/panthor_device.h |  36 ++
 drivers/gpu/drm/panthor/panthor_drv.c    |  59 ++-
 drivers/gpu/drm/panthor/panthor_fw.c     | 272 +++++++++--
 drivers/gpu/drm/panthor/panthor_fw.h     |   7 +
 drivers/gpu/drm/panthor/panthor_gem.c    | 102 +++--
 drivers/gpu/drm/panthor/panthor_gem.h    |   7 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  53 ++-
 drivers/gpu/drm/panthor/panthor_gpu.h    |   4 +
 drivers/gpu/drm/panthor/panthor_mmu.c    | 123 +++--
 drivers/gpu/drm/panthor/panthor_mmu.h    |   6 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 545 +++++++++++++++++++----
 drivers/gpu/drm/panthor/panthor_sched.h  |  27 +-
 include/uapi/drm/panthor_drm.h           |  85 +++-
 14 files changed, 1080 insertions(+), 247 deletions(-)

-- 
2.43.0

