Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750AFC54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD6910E9BB;
	Tue, 28 Jul 2026 18:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="d0z7T6dC";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA6710E9B9
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785263972; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L5ZgXJtCLNKtoRprt9eH37oyEdr9F8aNPd+7rgpy+5k4vr2pSZOAFHzfB3HZuv9j/5W2vlwPjCrqD2+oLlzgb/RsKlNBWeMu8G5ajST6REFnEKQG64dTi3h5rsMG3yvfH3OEomnbHVGqqdWEFr68z/FEz2NraR2RAXRdyNRaulU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785263972;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AXoijwc0HzAByrh9/ZGCSKkn4X2C9X0iaIKI34AIdjw=; 
 b=QXf4YKWrlUcy2Feaw9N1h1M/8VX1m812ZHMVBebHvvgAvBlF7pqNatJyhGhDvW+ecPK7VjFNd3JgEMpOIPZm3UhHEnRFxJ8PIVJKYtzNkfC24OYJ0APrSul7N88DOjMIAD6qOSjxA+HXwZ91uOpouRXK/q6CU4BpHQiCnW6ibyE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785263972; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=AXoijwc0HzAByrh9/ZGCSKkn4X2C9X0iaIKI34AIdjw=;
 b=d0z7T6dCfwscJMHwItEC1ZiO3ZfSml6AIXwKZWz+OkxYaIBDNjrgDes//QEt97BS
 6o0SrQk+CJ+lYR+NUH/oWfd82Qs/QZgbXq2xgGl7YAwUoCkofwN5G0scGoprSMYzdTF
 +Vd0FQP9HmD3mhBNf2QlytATr6i4XyHIObHyqTc0=
Received: by mx.zohomail.com with SMTPS id 1785263969998795.0968557796881;
 Tue, 28 Jul 2026 11:39:29 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v10 0/7] drm/tyr: firmware loading and MCU boot support
Date: Tue, 28 Jul 2026 11:39:22 -0700
Message-Id: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Oy2rDMBCF4VcJWldlJOs2XfU9She6NoI0KnJQU
 oLfvbJbqB0M2ozg+zl3Msaa40heDndSY8tjLud+MHg6EH+0549Ic+gfhANXoMHQdKWulAt1gib
 QGpTlSnpNOviqMeXbUnt77/cxj5dSv5d4Y/Pvb0ZwsfC/UhPzA2plQAYStMHw6svpZF2p9tmXT
 zLXmvwvPAxpsnOtkVunTBwk7nG15rjhqnNvB2SRWcHA7HG94mzYcD2PT8EEzwSKsDverDhnG24
 6d9wkLYQ0zO+OxzXnG46dG6UwcAtcIjzyaZp+AOX3vs/nAQAA
X-Change-ID: 20260708-fw-boot-b4-f07706a265c7
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, laura.nao@collabora.com, 
 samitolvanen@google.com, lyude@redhat.com, beata.michalska@arm.com, 
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7606;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=UG0ZH7aVDpWs960Q1wGmCLVxeAv5x/wzBLwYUqvLtDg=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkZ3xPmxLyb9Dl3/oMll4LaX1fO+XzrytWArRd1qsO9k
 hb3719yv6OUhUGMi0FWTJHlrL1Rj3jVeyPd+f+bYeawMoEMYeDiFICJlEsyMizatde/ae/Os/aO
 mzJWZKULvNBmz5Nodt+0Y+aO9gAR/ziGfzZL/hirva+N0FcMOthrckTcONM8kKl3Z6jXkfncV/5
 pcAAA
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

It is based on drm-rust-next and also depends on:

[PATCH v3] rust: iommu: add device lifetime to IoPageTable
   https://lore.kernel.org/rust-for-linux/20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
Changes in v10:
- rename 'bound to 'drm when not used for bus device private data
- check that mapping/unmapping parameters are page aligned
- Link to v9: https://lore.kernel.org/r/20260722-fw-boot-b4-v9-0-8669d2a02590@collabora.com

Changes in v9:
- reuse SlotData when reactivating a slot
- add fn seat to SlotOperations
- don't allocate gpuva for full unmap_range
- add small sleeps instead of busy-wait for hw
- move sparse address space test to constructor
- use infallible pin_init! for registration data
- add fw stop() to disable MCU and call it from drop()
- check page alignment in parser
- validate firmware header and entry bounds
- allow firmware sections with no VM mapping footprint
- clear stale MCU interrupts before boot
- handle various errors and clean up
- remove various unreachable code
- remove trailing newlines from dev_ prints
- Link to v8: https://lore.kernel.org/r/20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com

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
 drivers/gpu/drm/tyr/driver.rs            |  68 ++-
 drivers/gpu/drm/tyr/file.rs              |  11 +-
 drivers/gpu/drm/tyr/fw.rs                | 321 +++++++++++
 drivers/gpu/drm/tyr/fw/parser.rs         | 588 +++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs               | 134 ++++-
 drivers/gpu/drm/tyr/mmu.rs               | 120 ++++
 drivers/gpu/drm/tyr/mmu/address_space.rs | 511 +++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs              | 135 ++++-
 drivers/gpu/drm/tyr/slot.rs              | 404 +++++++++++++
 drivers/gpu/drm/tyr/tyr.rs               |   4 +
 drivers/gpu/drm/tyr/vm.rs                | 949 +++++++++++++++++++++++++++++++
 12 files changed, 3215 insertions(+), 35 deletions(-)
---
base-commit: 951aa1f4952cbb4e30ace86c99f248f968d56705
change-id: 20260708-fw-boot-b4-f07706a265c7

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

