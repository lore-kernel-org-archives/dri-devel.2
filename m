Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F322CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DED210E190;
	Tue,  5 May 2026 14:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="AVP8sPCI";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9260710E190
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:05:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B2F024C0;
 Tue,  5 May 2026 07:05:20 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156CC3F763;
 Tue,  5 May 2026 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777989925; bh=iyP/JaXBkTbwZEXjAStW8lEzoZNntiUAc3QwhcHeM3o=;
 h=From:To:Cc:Subject:Date:From;
 b=AVP8sPCIrwkEWGrTaXpA6Im1VQWWw+uTbtbX3XiVBAup4tMMeO/iLw+A42dT7Be0o
 xe14tg17ZPx3Z59IFP6ah6B6XQAl77krNHSOGynpJGa66Ok8S/I/VgyJ2dsP6L8bM4
 fEcayPwk9oJayp5u9OMQctpwEtK6q9PyIfSSIUug=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH 0/8] drm/panthor: Protected mode support for Mali CSF GPUs
Date: Tue,  5 May 2026 16:05:06 +0200
Message-ID: <20260505140516.1372388-1-ketil.johnsen@arm.com>
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
   heap from which the driver can allocate a protected buffer.
   It can be a carved-out memory or dynamically allocated protected memory region.
   Some system includes a trusted FW which is in charge of the protected memory.
   Since this problem is integration specific, the Mali Panthor CSF kernel
   driver must import the protected memory from a device specific exporter.

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

The Mali Panthor CSF kernel driver will allocate protected DMA buffers
using a global protected DMA heap. The name of the heap can vary on
the system and is integration specific. Therefore, the kernel driver
will retrieve it using the DTB entry: "protected-heap-name".

The Mali Panthor CSF kernel driver will handle enter/exit of protected
mode with a fair consideration of the job scheduling.

If the system integrator does not provide a protected DMA heap, the driver
will not allow any protected mode execution.


Patch series
------------

[PATCHES 1-2]:
  Thees patches comes from the following patch series:
  https://lore.kernel.org/lkml/20240720071606.27930-1-yunfei.dong@mediatek.com/

  These extend the DMA-buf heap API to allow other kernel drivers to Find
  and allocate memory from dma heaps.

  Note: This patch series do not include a protected DMA heap, as this is
  platform specific.

  * dma-heap: Add proper kref handling on dma-buf heaps
  * dma-heap: Provide accessors so that in-kernel drivers can allocate dmabufs from specific heaps

[PATCHES 3, 5 and 6]:
  These are refactoring to aid the implementation of the protected rendering
  feature itself.

* drm/panthor: De-duplicate FW memory section sync
* drm/panthor: Minor scheduler refactoring
* drm/panthor: Explicit expansion of locked VM region

[Patch 4]:
  This introduces allocation of protected memory inside the Panthor driver.
  It also ensures the protected FW sections are loaded.

  * drm/panthor: Add support for protected memory allocation in panthor

[PATCH 7]:
  This patch implements the logic to handle enter/exit of the GPU protected
  mode in Panthor CSF driver.

  Note: to prevent scheduler priority inversion, only a single CSG is allowed
        to execute while in protected mode. It must be the top priority one.

  * drm/panthor: Add support for entering and exiting protected mode

[PATCH 8]:
  The final patch exposes this feature via the uAPI.

  * drm/panthor: Expose protected rendering features

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

This is still work in progress.

Constraints
-----------

At the time of developing the feature, Linux kernel does not have a generic
way of implementing protected DMA heaps. The patch series relies on previous
work to expose the DMA heap API to the kernel drivers.

The Mali CSF GPU requires device level allocated protected memory, which do
not belong to a process. The current Linux implementation of DMA heap only
allows a user space program to allocate from such heap. Having the ability
to allocate this memory at the kernel level via the DMA heap API would allow
support for protected mode on Mali CSF GPUs.



Florent Tomasin (3):
  drm/panthor: Add support for protected memory allocation in panthor
  drm/panthor: Minor scheduler refactoring
  drm/panthor: Add support for entering and exiting protected mode

John Stultz (2):
  dma-heap: Add proper kref handling on dma-buf heaps
  dma-heap: Provide accessors so that in-kernel drivers can allocate dmabufs from specific heaps

Ketil Johnsen (3):
  drm/panthor: De-duplicate FW memory section sync
  drm/panthor: Explicit expansion of locked VM region
  drm/panthor: Expose protected rendering features

 Documentation/gpu/panthor.rst            |  47 +++
 drivers/dma-buf/dma-heap.c               | 109 ++++++-
 drivers/gpu/drm/panthor/Kconfig          |   1 +
 drivers/gpu/drm/panthor/panthor_device.c |  29 +-
 drivers/gpu/drm/panthor/panthor_device.h |  15 +
 drivers/gpu/drm/panthor/panthor_drv.c    |  21 +-
 drivers/gpu/drm/panthor/panthor_fw.c     | 137 ++++++--
 drivers/gpu/drm/panthor/panthor_fw.h     |   7 +
 drivers/gpu/drm/panthor/panthor_gem.c    |  77 ++++-
 drivers/gpu/drm/panthor/panthor_gem.h    |  16 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  14 +-
 drivers/gpu/drm/panthor/panthor_gpu.h    |   6 +
 drivers/gpu/drm/panthor/panthor_heap.c   |   2 +
 drivers/gpu/drm/panthor/panthor_mmu.c    |  79 +++--
 drivers/gpu/drm/panthor/panthor_sched.c  | 387 ++++++++++++++++++-----
 include/linux/dma-heap.h                 |   8 +
 include/uapi/drm/panthor_drm.h           |  45 ++-
 17 files changed, 864 insertions(+), 136 deletions(-)

-- 
2.43.0

