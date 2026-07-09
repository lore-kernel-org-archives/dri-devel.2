Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27457C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6462B10E4F3;
	Thu,  9 Jul 2026 00:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="CqenvVqU";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B5610E4F3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783558049; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XAeRz8RgN2BSFEW+fMDdPJlz3hu5NTJhAd6Y1LTWflxWUlS+D3f/pFg3xwDrjUs2YE3KgvkP6b0vfNTZMcAI5rQcl1H8J3eNfVkWmFIUApSMT+gZKKwm74gLDpJWuoA1Jxa7qaofFf17MFwtB2WSozajZj7Ap5o8GY04EYw2Pkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783558049;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ykSv/MCDw0AUCDHIQSLalIer3TYZIzn/9drxaUvJIfI=; 
 b=b9NbIVgPHS6/5IaF0Xrn3zqDryEX8AYAyvUgqdtiHsBVoUQ0dq4yrxvgR9MMK9xmZElsu6InTp5NGwSgslhlsLDA+Qfwi6ebMYXgPybcWyhlcttKgiy0X/muxN1woHl/lm8pObvBqGVa7eFk4I8JeLwA54oMADCq17tex0tYHko=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783558049; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=ykSv/MCDw0AUCDHIQSLalIer3TYZIzn/9drxaUvJIfI=;
 b=CqenvVqUBs59LVj8M8uFVF6NoZdNJOIO4MoXTuO/NKTRD9GrZ+SLNAGlJTjwqTmu
 jnBCX/PAvO6hQ+lK41xCzSHiP6/jOj3x9PpIHy/w/geao7WThgPujUMskuZeV25HpuH
 1PrgN9CeeHG/i5VScApJd5WL6NpczVyRAHZrCcew=
Received: by mx.zohomail.com with SMTPS id 1783558048282301.9802146137505;
 Wed, 8 Jul 2026 17:47:28 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v5 0/7] drm/tyr: firmware loading and MCU boot support
Date: Wed, 08 Jul 2026 17:47:06 -0700
Message-Id: <20260708-fw-boot-b4-v5-0-7792ab68e359@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MwQ6DIBAFf8XsuTQrAdGe+h+NB0SsJNZtwNA2h
 n8v0ibvMi+Z2SFY72yAS7WDt9EFR2sGearAzHq9W+bGzMCRN6iwZdOLDUQbGwSbUClsNG+kUZC
 Fp7eTe5fYrc88u7CR/5R2rI/3lxFcFP1fiuIYMi3HrkaJqu3Gq6Fl0QN5fTb0gD6l9AW/W8MFq
 wAAAA==
X-Change-ID: 20260708-fw-boot-b4-f07706a265c7
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
 steven.price@arm.com, laura.nao@collabora.com, alvin.sun@linux.dev, 
 beata.michalska@arm.com, acourbot@nvidia.com, lyude@redhat.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4720;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=Aqq/nVdS1+z65UwFi5aBwT7YEt1OXhuTGxItG4KcO/c=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFl+7+f/rYq7bpEV/+AMy+yW2Su5WBX80iL7Jt6NUz/tv
 KQ2Y5pnRykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABOJLWP475Bq/+zfBcVpaiLC
 K5LrSy17o9ocle9W3nR9F38nWyhkFcM/y16JOdabOT8djAy9WaPIc3V5qcz3DVxMihtPVnb9Dvd
 hAQA=
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
 drivers/gpu/drm/tyr/file.rs              |   5 +-
 drivers/gpu/drm/tyr/fw.rs                | 266 ++++++++++
 drivers/gpu/drm/tyr/fw/parser.rs         | 521 ++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs               | 122 ++++-
 drivers/gpu/drm/tyr/mmu.rs               | 102 ++++
 drivers/gpu/drm/tyr/mmu/address_space.rs | 482 ++++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs              | 121 +++++
 drivers/gpu/drm/tyr/slot.rs              | 384 +++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs               |   4 +
 drivers/gpu/drm/tyr/vm.rs                | 810 +++++++++++++++++++++++++++++++
 12 files changed, 2864 insertions(+), 22 deletions(-)
---
base-commit: 3dc952c70e44991277f531ff6a2b8c14bcc52112
change-id: 20260708-fw-boot-b4-f07706a265c7

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

