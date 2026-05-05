Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF327CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 15:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0286310EB14;
	Tue,  5 May 2026 15:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UUZS27Ok";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6FD10EB14
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 15:24:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DD1F641AC5;
 Tue,  5 May 2026 15:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C103CC2BCB4;
 Tue,  5 May 2026 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777994646;
 bh=kWVNL4O8pvrAqSajvaT0UZnFSKRLS+k3+idhwJCqt/c=;
 h=From:To:Cc:Subject:Date:From;
 b=UUZS27OkKjK37KL4ylVumqLrunvIyt02LdJj5CZDxTPRwT5hjmE67NrnXAIa61dFq
 0Z1dxlC3g1IhET+8CWBGqVI+CSf8vuJigWC7KX3V1tEDHSYCuP8EKKiUCk+eFMC7Mw
 v7AjcSVEdMVkO+xIs70RzZAT7fty7P56oIhztoEW95/A1TNAFuVuj2aiX4AitABwjS
 dsD0rqPxXgxnnDH74gecmdLNoQBr26O5lWbDI0iV+qicWe8i5WLX3vfdGcrYFW1rm3
 ZqnmW8KA9nlOdCtUUX2q6b22Vqv1t+zv0EOfmx/vmn/BMBGyOq9w7EUh4urEUsUfvg
 0JGR8iZmZvBOw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/3] rust: auxiliary: replace drvdata() with registration
 data
Date: Tue,  5 May 2026 17:23:06 +0200
Message-ID: <20260505152400.3905096-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
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

When drvdata() was introduced in commit 6f61a2637abe ("rust: device: introduce
Device::drvdata()"), its commit message already noted that a direct accessor to
the driver's bus device private data is not commonly required -- bus callbacks
provide access through &self, and other entry points (IRQs, workqueues, IOCTLs,
etc.) carry their own private data.

The sole motivation for drvdata() was inter-driver interaction, e.g. a parent
driver deriving its bus device private data from the child driver via the
auxiliary bus.

However, drvdata() exposes the driver's bus device private data beyond the
driver's own scope. This creates ordering constraints -- drvdata may not be set
yet when the first caller of drvdata() can appear -- and forces the driver's bus
device private data to outlive all registrations that access it; a requirement
that causes unnecessary complications.

Private data should be private to the entity that issues it; bus device private
data belongs to bus callbacks, class device private data to class callbacks, IRQ
private data to the IRQ handler, etc.

This series replaces drvdata() with a dedicated registration_data pointer on
struct auxiliary_device. The parent stores its private data explicitly during
registration; the data is private to the registration and lives as long as the
Registration object.

On teardown, Registration::drop() first triggers auxiliary_device_delete()
(unbinding the child), then frees the registration data. Ordering constraints
are structural -- the child's lifecycle is scoped to the registration by
construction, not by convention.

With no remaining use case for drvdata(), drvdata(), match_type_id(),
set_type_id() and struct driver_type are removed.

This is a prerequisite for [1], which builds on the removal of drvdata() to
enable Higher-Ranked Lifetime Types (HRT) for Rust device drivers.

[1] https://lore.kernel.org/driver-core/20260427221155.2144848-1-dakr@kernel.org/

Changes in v2:
  - Introduce Box::zeroed()
  - Add Sync bound to Registration<T> impl block
  - Use KBox::zeroed() instead of KBox::new(Opaque::zeroed(), ...)
  - Use drop() instead of let _ = { ... }
  - Fix invariant doc reference

Danilo Krummrich (3):
  rust: alloc: add Box::zeroed()
  rust: auxiliary: add registration data to auxiliary devices
  rust: driver core: remove drvdata() and driver_type

 drivers/base/base.h                   |  16 --
 drivers/gpu/nova-core/driver.rs       |  10 +-
 include/linux/auxiliary_bus.h         |   4 +
 rust/kernel/alloc/kbox.rs             |  22 +++
 rust/kernel/auxiliary.rs              | 208 ++++++++++++++++++--------
 rust/kernel/device.rs                 |  60 --------
 samples/rust/rust_driver_auxiliary.rs |  40 +++--
 7 files changed, 202 insertions(+), 158 deletions(-)


base-commit: 30c878ed169983190f77940594f8ba8948debe6b
-- 
2.54.0

