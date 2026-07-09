Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E98C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B5010F6E1;
	Thu,  9 Jul 2026 21:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="ZjENd4vT";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009AE10E08F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 21:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783633014; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=k1wASANCLjJB23NZUsyl0KmV+5Fzi3cEp3eqODvop7Q0FgG6fARu0nMPsNFm/ZJzjsOArBeUGHBDf+xzQY4pSffvP4gRXFxESRRujBhaFKaqRwxuS6fqYyx+Tmg1QgWcxgCxmhAwrqSDfa4xrxBqCT36P85K6d2Ft+7Ch1O5DEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783633014;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sHvHouAGLn/9Y/0IurKnwHIZ9LyKJNVK4ACHo8Zhsxs=; 
 b=MZbEeMdhwKImcu2b3/E1TKgEGCuOJRbmeqJcwnPxBF4IQvH5v+rcuM9WHX/nCbgH6jp4lwF9LwLg9BthKIZPXGADeJ5ND+duKc2qVRQ3iRD2HO8KOPSYmAuSRX27pTgIXkTTJA89Og/Fk+m+zXxF/YnNkdPxMZEcT4BtWXViOcM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783633014; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=sHvHouAGLn/9Y/0IurKnwHIZ9LyKJNVK4ACHo8Zhsxs=;
 b=ZjENd4vThEJysfxD/NkKvp1S9xhy0lFWu3A0jfX8dBHRybCWl9nblDlcRo45H4lx
 pAlifuP0uykmjPo7Jxl5tfeLWP/8DX1Fraoa/aybyUK/Sx9h3bfjXeopgyUbljZkTP5
 ISN9+LTK+gmZRa+zwLGIViRcNxwCv9JQfLF4JNdI=
Received: by mx.zohomail.com with SMTPS id 1783633013296925.4889652460865;
 Thu, 9 Jul 2026 14:36:53 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v6 0/7] drm/tyr: firmware loading and MCU boot support
Date: Thu, 09 Jul 2026 14:36:40 -0700
Message-Id: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12OzQrCMBAGX0VyNrKN+Wk8+R7iIUlTG6hdSUpUS
 t/dtApCYS/zwQw7keRj8ImcdhOJPocUcCgg9zviOjPcPA1NYcKASVBQ0/ZJLeJILactKAXSMCm
 cIkV4RN+G1xq7XAt3IY0Y32s7V8v6zXDGV/1Xynw5oEY0ugIBqtbN2WHfG4vRHBzeyVLL4l/YP
 JJF0ZXSzFhZ+6PQW32e5w/B46Hx6gAAAA==
X-Change-ID: 20260708-fw-boot-b4-f07706a265c7
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 boris.brezillon@collabora.com, samitolvanen@google.com, acourbot@nvidia.com, 
 alvin.sun@linux.dev, laura.nao@collabora.com, work@onurozkan.dev, 
 beata.michalska@arm.com, steven.price@arm.com, lyude@redhat.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5274;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=JwvqbVDfZNz8scchJ0qh8Ic2LQQr6faTmazCaZ4EsV0=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkBIiW/OlYw5awvirG++0c+OStMeYKOToCLxeVFPf6sh
 /dsLtjUUcrCIMbFICumyHLW3qhHvOq9ke78/80wc1iZQIYwcHEKwETYrBn+Z0nqrTRdrnyk48aS
 r3u1TpadfsW6zG9Lt+CTCVlxz37v6GBkaK22XhN4fgn7gyr5vYXTozUk33jsTxPT4W5d+3HyLek
 SBgA=
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
1. [PATCH v5 00/19] rust: drm: Higher-Ranked Lifetime private data
   https://lore.kernel.org/rust-for-linux/20260628145406.2107056-1-dakr@kernel.org

2. [PATCH v3] rust: iommu: add device lifetime to IoPageTable
   https://lore.kernel.org/rust-for-linux/20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com

A branch with all dependencies is available here:
https://gitlab.freedesktop.org/dbrouwer/linux/-/commits/fw-boot-b4

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
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
 drivers/gpu/drm/tyr/mmu/address_space.rs | 484 +++++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs              | 121 +++++
 drivers/gpu/drm/tyr/slot.rs              | 384 +++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs               |   4 +
 drivers/gpu/drm/tyr/vm.rs                | 806 +++++++++++++++++++++++++++++++
 12 files changed, 2856 insertions(+), 31 deletions(-)
---
base-commit: 3dc952c70e44991277f531ff6a2b8c14bcc52112
change-id: 20260708-fw-boot-b4-f07706a265c7

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

