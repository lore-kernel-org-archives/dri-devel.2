Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE1FC88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0534210F402;
	Tue, 15 Sep 2026 10:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EE+Fyqwa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A1110F400
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789469921;
 bh=gVA4+XqbNNN1F9sDkQOd4SN/aK3Sgp3hL/xbCmqatQc=;
 h=From:Subject:Date:To:Cc:From;
 b=EE+FyqwaR3Lk17Pd8O2X0VdbC09nCwtrdZGShfgIcNKn/U2GNP64mYRE5Kx4hI87D
 IHnF2sKTgysjng/YvvLpTttJFYCsyACiKFQqxcSm6ghj/SWC4GxghMaWyZwiK+YF1J
 ADIDQIJGkJOH7HYny4wu7eVILcywtvKbBBfH56lhyrZvUhf0NS18A4oeEzy51UyQ93
 xJUzuo5LI0ze/KjHOz3dNJlbSEm7sY4wQm1fex0DHfpVqAOoqtyEGCuRu2mTd1d+E+
 KWSubUzc/pgVcsZujzGIss4OebSs4q5SjQuflWMMfaYT0uXR3COW7aYbHApUiMcIqH
 CRkYRJ8anr5pw==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AD1F417E091A;
 Tue, 15 Sep 2026 12:58:40 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 0/9] drm/tyr: add CSF firmware interface support
Date: Tue, 15 Sep 2026 12:57:33 +0200
Message-Id: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ0kqWoC/x2NQQ6CMBAAv0L27CZtEaN+xXgo7SJ7cDW7xUAIf
 6d4nEwms4KRMhncmxWUfmz8kQr+1EAao7wIOVeG4MLF3ZzHsiiyFNIhJjJsc+68811oz1eoUR+
 NsNcoaTyyrG/UyQoKzeXwX6WB5//w8dy2HSgQfmWAAAAA
X-Change-ID: 20260901-tyr-interfaces-3dd510152348
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
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

This series follows up to [1], which adds support for firmware loading
and MCU booting to the Tyr driver. The changes included here were
originally introduced in its v4, then dropped to reduce the scope of
the series, and have been adjusted to work with the HRT (Higher-Ranked
Lifetime Types) driver architecture and I/O projections support recently 
introduced.

The series adds support for the Command Stream Frontend (CSF) firmware
interfaces, enabling communication between the Tyr driver and the MCU
through shared memory.

The firmware binary is first validated to contain the shared section
used for this communication. Firmware sections that need CPU access get
a persistent CPU mapping alongside their GPU mapping, kept for the
lifetime of the driver in the case of the shared section. This is the
foundation for resolving firmware-reported MCU virtual addresses into
validated views of the shared section: addresses are represented with a
dedicated McuVa type nd are resolved into bound-checked and
alignment-checked views. Read-only blocks (control, output) use a freely
cloneable view, while writable blocks (input) use a view that takes an
exclusive claim on its byte range, removing the need for locking around
the interface state.

The global (GLB), command stream group (CSG), and command stream (CS)
interfaces are implemented on top of this, providing access to the
firmware control, input, and output blocks and allowing discovery of the
available CSGs and CSs at runtime. The interface is versioned:
GLB_VERSION is read once at probe time to select the layout matching the
firmware's generation.

The global interface is initialized and programmed during probe and its
readiness is notified through the Job IRQ.

A safe wrapper for arch_timer_get_rate() is also added for programming
the GLB timers, and the CONFIG_64BIT restriction on system memory u64
accesses is dropped so the register bitfields used by these interfaces
work on 32-bit too.

This series is based on drm-rust-next and depends on:
- [PATCH v6 0/2] drm/tyr: add Job IRQ handling [2] and its dependencies

[1] https://lore.kernel.org/all/20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com/
[2] https://lore.kernel.org/all/20260728-tyr-irq-v2-v6-0-15c90baed949@collabora.com/

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
Daniel Almeida (2):
      drm/tyr: add MappedBo, a kernel BO with an always-valid CPU mapping
      drm/tyr: add McuVa and claim-checked MappedBo views

Deborah Brouwer (2):
      drm/tyr: validate presence of CSF shared section
      rust: time: add arch_timer_get_rate wrapper

Laura Nao (5):
      rust: io: drop the CONFIG_64BIT restriction on system memory u64 access
      drm/tyr: drop unused KernelBo::bo() function
      drm/tyr: add CSF firmware interface support
      drm/tyr: program CSF global interface
      drm/tyr: wait for global interface readiness

 drivers/gpu/drm/tyr/driver.rs               |   33 +-
 drivers/gpu/drm/tyr/fw.rs                   |  148 ++-
 drivers/gpu/drm/tyr/fw/interfaces.rs        | 1524 +++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/fw/interfaces/layout.rs |  152 +++
 drivers/gpu/drm/tyr/fw/interfaces/v1.rs     | 1230 +++++++++++++++++++++
 drivers/gpu/drm/tyr/fw/irq.rs               |    1 -
 drivers/gpu/drm/tyr/fw/parser.rs            |   14 +
 drivers/gpu/drm/tyr/gem.rs                  |  334 +++++-
 rust/helpers/time.c                         |    6 +
 rust/kernel/io.rs                           |    4 +-
 rust/kernel/time.rs                         |   30 +
 11 files changed, 3432 insertions(+), 44 deletions(-)
---
base-commit: d1aec98b17f6ee395097b08ccb03c16d725d4ed1
change-id: 20260901-tyr-interfaces-3dd510152348

Best regards,
-- 
Laura Nao <laura.nao@collabora.com>

