Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A2CC4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E921C10E3D4;
	Wed, 22 Jul 2026 00:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="EzgTTJMr";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A1A10E385
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784681555; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JyIQI/HkaU0sdGqFR29q65+hNyzh3Y10v4kzEUekvmOQYSUViRkwFGO4PVZbEHzhgzWAUjce1M0phHIQ4CUbndFcMb4STROGgJEQCaMmCUqQkSDmbRr64azlvC9vqEOnlEo8HcCiRf7+x/icoJq5aOxsIDxYUR2UbvzoHFiQBcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784681555;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=naUZQW2mH0EQscyeeBuPle7Lpefwjkn0ALw+FzpI1iA=; 
 b=eWVBnU+0Ykg3cICt5hSNf9e1AZvfnwYxX6Wxx4iBSM9McoAO2o/ws9GwwTniTCWwIeA/5vL1hmXWOMybgwM5KoDEFfXVmhuemm48nMsgj2HNtei8uMTSOGxNREsYkY8GXzMXp7zI09phJkhkFcNBRf+x1klUyTIrWhu6TSEOIkw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784681555; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=naUZQW2mH0EQscyeeBuPle7Lpefwjkn0ALw+FzpI1iA=;
 b=EzgTTJMrW4IRhnP/JsxGJnFsJ8QGcfD4btwiZG2/V4FCoKvqcq4iJj8i49Dlf4T2
 7JATuhituawe4aXrqfJTucpdOStJzhE+tdV+zqigQ/9DnQW9oKcyCjOjBm+fqkuk6Tw
 uRW7sT+SjmLl1qGGAimctFHkXq8y86CeSXxHgTIo=
Received: by mx.zohomail.com with SMTPS id 1784681554301381.8155052339779;
 Tue, 21 Jul 2026 17:52:34 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v8 0/7] drm/tyr: firmware loading and MCU boot support
Date: Tue, 21 Jul 2026 17:52:27 -0700
Message-Id: <20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OwU7EIBSF4VdpWIu5UOCCK9/DuKBALUkthjaoa
 fru0moynXESNofk+3NXMoccw0yempXkUOIc01SHfmiIG+z0Fmj0dRMOXAGCpv0n7VJaaCdoD4i
 gLFfSIangI4c+fh2xl9e6hzgvKX8f7cL239+M4OLgf6Ui9gfUSm8YSEBt/LNL42i7lO2jS+9kr
 xV5KdwcUmTliIbbTunQSnOPqzM3V1xV7mxrWGBWMND3OJ44a6847sf3XnvHhBH+3/Hbtv0A9VB
 eQ2gBAAA=
X-Change-ID: 20260708-fw-boot-b4-f07706a265c7
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 boris.brezillon@collabora.com, work@onurozkan.dev, steven.price@arm.com, 
 alvin.sun@linux.dev, acourbot@nvidia.com, samitolvanen@google.com, 
 lyude@redhat.com, beata.michalska@arm.com, laura.nao@collabora.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7034;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=8v3NEKY3hkzBug9pZm3auiY1GuV1Hi/ev1cuGj3s9P4=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkJIoGb97R4pBVNZvf4sOR7Witzw9sdrsbcyrlzLoccD
 SxxeTWvo5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIk03WNkeJ2pNEd0pUqptZad
 qYzxoVaJDsUO9Rcb9EWVrj2o/bkxjpHha2l3cotfYKv9Rk53Md5j4coShqLl6/4cmmYXYnXkpjY
 XAA==
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

This series adds firmware loading and MCU boot support to the Tyr DRM
driver. It includes:
 - A parser for the Mali CSF firmware binary format
 - A kernel-managed BO type (KernelBo) for internal driver allocations
 - GPU virtual memory (VM) integration using drm_gpuvm
 - An MMU module and a generic slot manager
 - Loading firmware, VM activation, and MCU boot at probe()

It is based on drm-rust-next but also depends on:

1. [PATCH v3] rust: iommu: add device lifetime to IoPageTable
   https://lore.kernel.org/rust-for-linux/20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com

2. [PATCH] drm: Remove DRIVER_GEM_GPUVA feature flag
   https://lore.kernel.org/dri-devel/20260421084701.24227-1-laura.nao@collabora.com/
   This patch is in drm-misc-next for v7.3:
   https://lore.kernel.org/dri-devel/20260702-powerful-successful-raptor-eded34@houat/

A branch with all dependencies is available here:
https://gitlab.freedesktop.org/dbrouwer/linux/-/commits/fw-boot-b4

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
Changes in v8:
- kill the vm if firmware does not initialize properly
- write to JOB_IRQ_CLEAR after MCU boots
- check that a mapping request does not run past the end of the GEM buffer
- check that the SG table gave us enough backing memory for our VA
- make the KernelBo gem object field (bo) private and add an accessor
- return unused gpuva from remap()
- always provide three gpuva to unmap() instead of two
- be stricter about interpreting MAIR bits for device and non-cacheable memory
- preserve idle slot data in case subsequent activation fails
- clear evicted slot after eviction in case a subsequent activation fails
- wait for flush and lock commands to complete before proceeding
- rewrite SectionFlags with the register macro
- use the InaBits conversion provided by the register macro
- rename the slot data argument to vm_as_data for clarity
- add various checks for size, shifting, truncating, sparse values, overflow etc.
- return errors instead of panicking from unwrap()
- use dev_* macros for all logging
- Link to v7: https://lore.kernel.org/r/20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com

Changes in v7:
- slot.rs: don't print an error when all slots are busy
- change all allow(dead_code) to expect(dead_code)
- use LockedSeat type alias in VmAsData
- shift the lockaddr_base so it fits properly in LOCKADDR
- replace core::fmt with kernel::fmt
- make SAFETY comments clearer for map/unmap pages
- fix arm 32-bit build failures
- release gpuvm_unique lock before calling deferred_cleanup
- Link to v6: https://lore.kernel.org/r/20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com

Changes in v6:
- Move gpu_info from drm::Driver::Data to RegistrationData
  and remove drm::Driver::Data entirely.
- Remove the extra drm::Device ARef in TyrPlatformDriverData
  since drm::Registration already owns an ARef to the drm::Device.
- Stop storing platform::Device ARef in firmware since it is unused.
- Pass a generic kernel::Device instead of the platform::Device through
  firmware to Vm and pagetables since this is all that they need.
- Link to v5: https://lore.kernel.org/r/20260708-fw-boot-b4-v5-0-7792ab68e359@collabora.com

Changes in v5:
- Reduce the scope of this series back to just MCU booting.
- Drop the CSF global interface, job IRQ, wait, and arch timer patches
  since they will be sent as subsequent series.
- Add lifetimes to resources and store them in TyrRegistrationData.

- Link to v4: https://lore.kernel.org/r/20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com

Changes in v4:
 New commits:
  - drm/tyr: program CSF global interface
  - rust: time: add arch_timer_get_rate wrapper
  - drm/tyr: add CSF firmware interface support
  - drm/tyr: validate presence of CSF shared section
  - drm/tyr: wait for global interface readiness
  - drm/tyr: add Job IRQ handling
  - drm/tyr: add Wait type for GPU events

 The existing commits from v3 remain unchanged.
 - Link to v3: https://lore.kernel.org/r/20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com
    
Changes in v3:
 New commits:
  - drm/tyr: remove unused device from platform data
  - drm/tyr: use shmem GEM object type in TyrDrmDriver
    
 drm/tyr: select required dependencies in Kconfig
  - Rename commit since the dependencies are not limited to DRM.
  - Select new RUST_DRM_GEM_SHMEM_HELPER instead of DRM_GEM_SHMEM_HELPER.
    
 drm/tyr: set DMA mask using GPU physical address
  - Use register macro to read pa_bits instead of separate helper function.
    
 drm/tyr: add MMU module
  - Switch MMU code to typed register APIs (TRANSCFG, MEMATTR, STATUS, LOCKADDR, etc.).
  - Use MmuCommand enum for MMU commands instead of raw constants.
  - Minor cleanups and renaming (MAX_AS, AS_PRESENT handling).
    
 drm/tyr: add GPU virtual memory module
  - Extract VA/PA bits via typed MMU_FEATURES register.
  - Update the VM code to match the new GPUVM v6 and shmem GEM v10 APIs.
    
 drm/tyr: add a kernel buffer object
  - Reject zero-sized KernelBo allocations up front.
    
 drm/tyr: add firmware loading and MCU boot support
  - Use typed GPU control registers.
  - Pass iomem by Arc into Firmware::new() since we store it eventually.
    
  - Link to v2: https://lore.kernel.org/rust-for-linux/20260302232500.244489-1-deborah.brouwer@collabora.com/
    
Changes in v2:
 - The whole series is rebased on drm-rust-next including v7.0-rc1.
 - Each patch has its own changelog.
    
 Link to v1: https://lore.kernel.org/rust-for-linux/20260212013713.304343-1-deborah.brouwer@collabora.com/

---
Boris Brezillon (3):
      drm/tyr: add a generic slot manager
      drm/tyr: add Memory Management Unit (MMU) support
      drm/tyr: add GPU virtual memory (VM) support

Daniel Almeida (1):
      drm/tyr: add parser for firmware binary

Deborah Brouwer (3):
      drm/tyr: add resources to RegistrationData
      drm/tyr: add a kernel buffer object
      drm/tyr: add Microcontroller Unit (MCU) booting

 drivers/gpu/drm/tyr/Kconfig              |   5 +
 drivers/gpu/drm/tyr/driver.rs            |  64 ++-
 drivers/gpu/drm/tyr/file.rs              |  11 +-
 drivers/gpu/drm/tyr/fw.rs                | 292 ++++++++++
 drivers/gpu/drm/tyr/fw/parser.rs         | 550 ++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs               | 134 ++++-
 drivers/gpu/drm/tyr/mmu.rs               | 120 ++++
 drivers/gpu/drm/tyr/mmu/address_space.rs | 509 +++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs              | 135 ++++-
 drivers/gpu/drm/tyr/slot.rs              | 391 +++++++++++++
 drivers/gpu/drm/tyr/tyr.rs               |   4 +
 drivers/gpu/drm/tyr/vm.rs                | 931 +++++++++++++++++++++++++++++++
 12 files changed, 3114 insertions(+), 32 deletions(-)
---
base-commit: 337c44a2f50c9008273a338f518cc552f6b08567
change-id: 20260708-fw-boot-b4-f07706a265c7

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

