Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C2DF532C1
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7E110E028;
	Tue, 24 Mar 2026 00:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="OyJJyP2A";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E161010E028
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774311492; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ioMvtFtwKKAptEddaO84MMN+CZzmAFOcnMmQDdR4qFgfzBiweu+RR4gnU9MCEqz9iGtL6FYbncHZz1GzB0m7+FpSZbYAwc99SOXxtEsjDvsOrlhsBOj/Bhn3PhZKPXE3ZHIaZPhE9jj9opAtR/bPkfahjHzkOiOZI4V5Hrx+SyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774311492;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4e8y28/K36QMdoVZh3OhO4HD1eFoiN4nAXu06OWxlK8=; 
 b=ST7m33yIPYUWxV9TmQkDaHRSdIEGRV/UjK2gamEo/BHkX8i8tBqMvOffUN8su1QbfCx+TdWAjMqG2xYhvggVSW/a53qHXjj3RHZnq/QAhRUFE3GA2n48Elsz6oEnqtf6NkTxI4br9k9IpTVlYVRhMGzpJ9j0QU9/qTwRXlF9LDU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774311492; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=4e8y28/K36QMdoVZh3OhO4HD1eFoiN4nAXu06OWxlK8=;
 b=OyJJyP2AaA2pWV+gvkPXUfj8grdBezx4P5ZhMpjjTLLILA4tR5rb0RLLTvtbRp7k
 zRIPmtEmvwgahvklnVoE/R4VMzxOlrYsWPPk6lUUzew2uTgvFQxPCwcpcBv7Lo2ezt3
 XE+Hme1ez9QlY6EcRzGQ08i2U7PCCRPMKLu8uxes=
Received: by mx.zohomail.com with SMTPS id 1774311489953164.47520327121856;
 Mon, 23 Mar 2026 17:18:09 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v3 00/12] drm/tyr: Use register! macro
Date: Mon, 23 Mar 2026 17:18:02 -0700
Message-Id: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrYwWkC/x3MQQ6CQAwF0KuQrm0ymeIQvYpxMcIHugBMC0RDu
 LsTl2/zDnKYwuleHWTY1XWZC+RSUTvmeQBrV0wxxBQkCr9qXr/Gm4MNg/oK4ym3tvAu3NWSUg4
 Rt+ZKpXgbev38+8fzPH+t72OubgAAAA==
X-Change-ID: 20260323-b4-tyr-use-register-macro-v3-d4366a02e975
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=scH9gecDDaVPRj+HI4lsSCDu+sfPo/c7UDLyzWg5qBk=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkHbzgIlca+fGIkdvVR94PWo/fnXBGVlvCQOVK/uqPm1
 VeB7W+/d5SyMIhxMciKKbKctTfqEa96b6Q7/38zzBxWJpAhDFycAjCRy6cZfjFfc3YzXmmtb8ln
 V8cx959D0Z5rcWybz97Q3SM4x3HBxwJGhiXOewxlmn5c6djqdWDfJqF33a0lbpMnfzaecMr5brl
 nMysA
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

This series applies on drm-rust-next.
base-commit: a19457958c30

Changes in v2:
- Rebase on v8 of register! macro series;
- Add documentation;
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

---
Daniel Almeida (1):
      drm/tyr: Use register! macro for GPU_CONTROL

Deborah Brouwer (11):
      drm/tyr: Print GPU_ID without filtering
      drm/tyr: Set interconnect coherency during probe
      drm/tyr: Use register! macro for JOB_CONTROL
      drm/tyr: Use register! macro for MMU_CONTROL
      drm/tyr: Remove custom register struct
      drm/tyr: Add MMU address space registers
      drm/tyr: Add fields for MEMATTR register
      drm/tyr: Add fields for COMMAND register
      drm/tyr: Add fields for FAULTSTATUS register
      drm/tyr: Add fields for TRANSCFG register
      drm/tyr: Add DOORBELL_BLOCK registers

 drivers/gpu/drm/tyr/driver.rs |   29 +-
 drivers/gpu/drm/tyr/gpu.rs    |  213 +++---
 drivers/gpu/drm/tyr/regs.rs   | 1587 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 1589 insertions(+), 240 deletions(-)
---
base-commit: a19457958c3018783881c4416f272cd594f13049
change-id: 20260323-b4-tyr-use-register-macro-v3-d4366a02e975

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

