Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE38F364A3
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C113D10E089;
	Thu,  9 Apr 2026 17:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="aVOjcR2q";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3299110E089
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775757123; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fl3aWVPzaAhHTFnZD/VfKfC0FTNFM0BhmIHW/tzn6xrt9AidG8qSNCZ8A08r5nxD5tjYD8DDL+9x7uG4uJuahYikTGq/FD3W8/L/F3KzDiISUfOuVv0s0IVFGvWDl7G/wVedVJmhMHr44Zn7H3qmVsGXzjv9urIs8rzec34Eq9s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775757123;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fa4z3SI+tspRUGsZVXwsye+edIsVZI+yLEN4HCu0WDM=; 
 b=lNDF8yWHDq4IWegxrGR+jty2RdPTh1JrrBPhGs/0AvBb2bCfs2aW/qKwb3bB2DSqXBleEcVDwtEK+2uzJ5VrcQtEylnMuAE6Z8ZJChpgv6iwkhtjYZxVxuwfW/7sgIhsLy5oEc5TlnH0+SMG0azHpafGUCMwqM3QJVBevkwilSU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775757123; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=fa4z3SI+tspRUGsZVXwsye+edIsVZI+yLEN4HCu0WDM=;
 b=aVOjcR2qlQYHQXASOBLIDmU9bhC2qNOZysWABnKIAc3gwZLTADMkYXk8J3oEQm5I
 b4aADwI+/xyqmhmflcRCYlIfMyu+cxpV010Q8kVYAVw7wjhtA1zTWat52GSViNDH4RL
 fPKI1fibY+bjVJn9lGN+m5OTvtn5bbmUolQN8gdA=
Received: by mx.zohomail.com with SMTPS id 1775757121080757.8719388888437;
 Thu, 9 Apr 2026 10:52:01 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v5 0/6] drm/tyr: Use register! macro
Date: Thu, 09 Apr 2026 10:51:23 -0700
Message-Id: <20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqEMAwA0KtI1gY6fkpnriIuqk01C3VIVBTx7
 haXb/MuUBImhV92gdDOysucUOcZ9KOfB0IOyVCYwprKfLGrcD0FNyUUGlhXEpx8LwvuNUZX2hg
 +wXnrIBV/ocjH2zftfT+6iu2JbgAAAA==
X-Change-ID: 20260409-b4-tyr-use-register-macro-v5-f836fd1d8a68
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=KdxG1iLbwg0HKaGE0texBSoMH/EAOphLCYcxUdCcBPM=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJnXnzssDVyS2aD9brJEwN7f69guaeYmXPq67gBH8Tr26
 Onnb6za2VHKwiDGxSArpshy1t6oR7zqvZHu/P/NMHNYmUCGMHBxCsBE5H8xMmyMfTfd2/uR6YX/
 6p6n1Rc8tn3TH9bmcvSOgq30wmMe394w/K97a1932izf3/9+Sb3BomMnX4R//nfmT8IPvZn/7ym
 33ecAAA==
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

This series changes the Tyr driver to use the kernel's register! macro
for hardware register access, replacing manual bit manipulation and custom
register structures with a more type-safe and maintainable approach.

---
Changes in v5:
- All 1-bit glb fields use => bool.
- Convert gpu_info_log to a method of GpuInfo to avoid redundant MMIO reads.
- Fix typo in the field name for SHADER_PWRTRANS_HI.
- Add details to all commit messages.

- Link to v4: https://lore.kernel.org/r/20260402-tyr-use-register-macro-v4-v4-0-96a8d42f8bd1@collabora.com

This series applies on drm-rust-next
tag: drm-rust-next-2026-04-06
base commit: a7a080bb4236

Changes in v4:
 - Add PartialEq to all enums so they can be used in comparisons.
 - Replace u64 registers with u32 LO/HI pairs and helper functions to read them.
 - Combine all MMU register definitions into one patch.
 - Drop [PATCH v3 03/12] drm/tyr: Set interconnect coherency during probe
   to avoid possible leaks/data corruption.
 - Pick up Ab, Rb tags

 - Link to v3: https://lore.kernel.org/r/20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com

Changes in v3:
 - Update write_val() with write_reg() from API change.
 - Replace const values with enums and use => ?=> syntax.
 - Convert 1-bit fields to bool.
 - Change module visibility from pub(super) to pub(crate).
 - Add new commits to define mmu address registers.
 - Add new commit exposing hardware DOORBELLS.
 - Pick up Reviewed-by tags.

 There are also change logs per patch.

 - Link to v2: https://lore.kernel.org/r/20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com

Changes in v2:
 - Rebase on v8 of register! macro series;
 - Add documentation;
 - Remove manual functions to get address bits;
 - Revise gpu_info() to use macro;
 - Remove manual functions to get address bits;
 - Revise gpu_info() to use macro;
 - Revise l2_power_on() to use macro;
 - Set interconnect coherency protocol with macro;
 - Separate commits for each register page;
 - Replace HI/LO pairs with 64bit registers
 - Order registers by address;
 - Remove doorbell clear field from GPU_IRQ_CLEAR;
 - GPU command is redesigned to accommodate multiple layouts;
 - MMU register bits corrected;
 - Use UPPERCASE for register names;
 - Move the consts to impl block for registers;

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

---
Daniel Almeida (1):
      drm/tyr: Use register! macro for GPU_CONTROL

Deborah Brouwer (5):
      drm/tyr: Print GPU_ID without filtering
      drm/tyr: Use register! macro for JOB_CONTROL
      drm/tyr: Use register! macro for MMU_CONTROL
      drm/tyr: Remove custom register struct
      drm/tyr: Add DOORBELL_BLOCK registers

 drivers/gpu/drm/tyr/driver.rs |   19 +-
 drivers/gpu/drm/tyr/gpu.rs    |  175 ++---
 drivers/gpu/drm/tyr/regs.rs   | 1744 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 1723 insertions(+), 215 deletions(-)
---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260409-b4-tyr-use-register-macro-v5-f836fd1d8a68

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

