Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5759BCD4851
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 00:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78F410E5A7;
	Sun, 17 May 2026 00:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oVCmNKob";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33AC10E5A7
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:03:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DAFB040368;
 Sun, 17 May 2026 00:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AC5C19425;
 Sun, 17 May 2026 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778976226;
 bh=EwDPHU8Myu7IMLaoUR4e3fr/2SUIK+nNROOO2YAeGwI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oVCmNKobuwcUliIGfRl5b8Nb21HuZ8pM9XKrRIcjSFX67iGx6knDhW4irU4fNDZ5d
 P1QlHYrrSrhBxZufJm5CvstqLkOeuZbkrUzYE/vfUC6CmrTaoQOP4iQNrqJq0RXMyr
 40d0EU58UYitSuHQxtRy66W8IzjN03yKn6gP7b1o3u221PdLwD6bIz+38DefBdaF8v
 TuREwf2b4uo1uKB1SARFOQa6mLyD2X0BEIEgmfX13zbZkkUokajjUk/EIl1YN50dNX
 4MHwJVyOGqSUabfWUeGbSoa4eui24CEBJURq0Mpsl0/EtxGXdBPecXttAeoDwhsw59
 3Fb3PabbcCXMg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com,
 pcolberg@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 15/27] rust: driver: update module documentation for
 GAT-based Data type
Date: Sun, 17 May 2026 02:01:03 +0200
Message-ID: <20260517000149.3226762-16-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
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

Now that all bus driver traits use type Data<'bound>: 'bound, update the
illustrative driver trait in the module documentation to reflect the GAT
pattern and lifetime-parameterized callbacks.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index d8898f2115d5..0dbfbe468c94 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -18,7 +18,7 @@
 //!     type IdInfo: 'static;
 //!
 //!     /// The type of the driver's bus device private data.
-//!     type Data;
+//!     type Data<'bound>: 'bound;
 //!
 //!     /// The table of OF device ids supported by the driver.
 //!     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
@@ -27,11 +27,16 @@
 //!     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 //!
 //!     /// Driver probe.
-//!     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
-//!         -> impl PinInit<Self::Data, Error>;
+//!     fn probe<'bound>(
+//!         dev: &'bound Device<device::Core>,
+//!         id_info: &'bound Self::IdInfo,
+//!     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 //!
 //!     /// Driver unbind (optional).
-//!     fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+//!     fn unbind<'bound>(
+//!         dev: &'bound Device<device::Core>,
+//!         this: Pin<&'bound Self::Data<'bound>>,
+//!     ) {
 //!         let _ = (dev, this);
 //!     }
 //! }
@@ -46,9 +51,10 @@
 )]
 #![cfg_attr(CONFIG_PCI, doc = "* [`pci::Driver`](kernel::pci::Driver)")]
 //!
-//! The `probe()` callback should return a `impl PinInit<Self::Data, Error>`, i.e. the driver's
-//! private data. The bus abstraction should store the pointer in the corresponding bus device. The
-//! generic [`Device`] infrastructure provides common helpers for this purpose on its
+//! The `probe()` callback should return a
+//! `impl PinInit<Self::Data<'bound>, Error>`, i.e. the driver's private data. The bus
+//! abstraction should store the pointer in the corresponding bus device. The generic
+//! [`Device`] infrastructure provides common helpers for this purpose on its
 //! [`Device<CoreInternal>`] implementation.
 //!
 //! All driver callbacks should provide a reference to the driver's private data. Once the driver
-- 
2.54.0

