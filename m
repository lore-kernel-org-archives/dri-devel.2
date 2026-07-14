Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB90C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13C410EBA8;
	Tue, 14 Jul 2026 03:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="eV4j5SG8";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E1110E0AE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783999138; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=byvetco8qi7CiJUhJQzFGVO6TH8GeMLxazyceny52YxSwDH5yGVLzk0PsuvtL+kdwYMsFFIC58RpT7zVOxOFdXC3vKHOmQ1dIX7dkS6FI2qb+u9pHmaQEZORhPhsV3JZ62y1Y1sEScQqSc/E0WPETw4qrnGsOgZg3VtB6CoysuU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783999138;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Rv7OUTiUkuVMgVM7v+6qo0GShNvkJAcTOE3YgtjTRH0=; 
 b=JEh5kqFtGtlvR96xurKyT85DAw/kA1y2z0GhR2tMgHfM4CL0Gm8NJlTutwgtAGEXcnhigTQ2sDfp1BCevNxZ6MTMiJENSU7EapzHBlyVPqo70y5TmlobVtShA0+0ihtoCoTUHo0hNrzktb3DKiYuTWKrvCwkQlwU0++GbADZGM4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783999138; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=Rv7OUTiUkuVMgVM7v+6qo0GShNvkJAcTOE3YgtjTRH0=;
 b=eV4j5SG8nshUNLrGLstU34/oK9jGUC8f9yqKwOGN7VxZgls1Hjx9YRyNKqR3eiFQ
 J4IctfszRGzwZOnyqVPf4Vf+EMCn9tT3kiOuqoYH5oxkIk5ALkZwKC0zXmZ+MVvFOG2
 HXdg5ZWzUuR4EIeQKj9cBazDLCmIYhu3awNOcNGc=
Received: by mx.zohomail.com with SMTPS id 1783999136859124.5213531717726;
 Mon, 13 Jul 2026 20:18:56 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v7 0/7] drm/tyr: firmware loading and MCU boot support
Date: Mon, 13 Jul 2026 20:18:44 -0700
Message-Id: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23O3wrCIBiH4VsJjzM+nX9mR91HdOCca8KaocOKs
 XvPraAagSe/D54XRxRtcDai/WZEwSYXne/zkNsNMq3uzxa7Om9EgQqQUOLmhivvB1wx3ICUIDQ
 V3EiUwTXYxt2X2PGUd+vi4MNjaScyX18ZRtnC36XE5gdY81oR4CBLVR+M7zpd+aB3xl/QXEv8U
 1h9JPHMpVRUV6K0BVf/uPjm6oeLzI0uFLFEMwLlmk/T9AR+zsbVKQEAAA==
X-Change-ID: 20260708-fw-boot-b4-f07706a265c7
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 boris.brezillon@collabora.com, samitolvanen@google.com, work@onurozkan.dev, 
 acourbot@nvidia.com, lyude@redhat.com, laura.nao@collabora.com, 
 beata.michalska@arm.com, alvin.sun@linux.dev, steven.price@arm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5900;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=96fgh1jBo63JWVTUnNnKqniWb7MFpaQ73x8i18SysxI=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmhq+Y/bj665ZWEoBrPzfe3/13Jm3py9ym+4+eyNDhUD
 ma5Vvg2d5SyMIhxMciKKbKctTfqEa96b6Q7/38zzBxWJpAhDFycAjCRPHeG/641a5Y/qOtTfHbF
 fvLy2vqzt+Wmqf+Zt3hfTVCqcNUGaw1Ghv1q4jHF87hia8IfzJv5eJXnHZei9zU58VPe3g8Kqm7
 JYgMA
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
 drivers/gpu/drm/tyr/fw.rs                | 263 ++++++++++
 drivers/gpu/drm/tyr/fw/parser.rs         | 521 ++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs               | 122 ++++-
 drivers/gpu/drm/tyr/mmu.rs               | 102 ++++
 drivers/gpu/drm/tyr/mmu/address_space.rs | 490 +++++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs              | 123 ++++-
 drivers/gpu/drm/tyr/slot.rs              | 377 ++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs               |   4 +
 drivers/gpu/drm/tyr/vm.rs                | 810 +++++++++++++++++++++++++++++++
 12 files changed, 2860 insertions(+), 32 deletions(-)
---
base-commit: c8482fab3418955dcd322bea615857adf8c47caa
change-id: 20260708-fw-boot-b4-f07706a265c7

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

