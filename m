Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF50FFF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AC110E040;
	Mon, 27 Apr 2026 22:10:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hEl5bVKN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105EB10E040
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:10:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2364660139;
 Mon, 27 Apr 2026 22:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89BFC19425;
 Mon, 27 Apr 2026 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777327809;
 bh=RhmjGyyC7zIoDOwBCTiwM6xx+/W2gzJoXMpyzbXHsLE=;
 h=From:To:Cc:Subject:Date:From;
 b=hEl5bVKN4WCrK3inmbbdsojOPaPGka3q3/12uffAJq7M2Pj+MmebOoqXkcL/apLEQ
 wHyY/d1q951HKJB+NzvBZ9sgoj50gtGZbpdm2mLeAvyFILb03mPXDZaOP2K8kACRA3
 Hdm93IQdoi0lTExG6kBbd2CVa2wGZleTFe++y5RqxGZ70zCdO+uqmdfMAbvmzVt4SL
 eWHCHD4LM4IX8htp8lCaFmm0WCBOHvCKbdBeryZW3xd36LTn+iwQ9Ew2O0KJzh0qBl
 WwBt4G0dEasoMgdHDDzuxMKzt6C7nP5CkF/2VP5ctScmfFl1QRc0ENvizO0S7Re+Dx
 CrggkhI3g0VLQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/2] rust: auxiliary: replace drvdata() with registration data
Date: Tue, 28 Apr 2026 00:09:39 +0200
Message-ID: <20260427221002.2143861-1-dakr@kernel.org>
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

[1] Posted as a reply to this series.

Danilo Krummrich (2):
  rust: auxiliary: add registration data to auxiliary devices
  rust: driver core: remove drvdata() and driver_type

 drivers/base/base.h                   |  16 --
 drivers/gpu/nova-core/driver.rs       |  10 +-
 include/linux/auxiliary_bus.h         |   4 +
 rust/kernel/auxiliary.rs              | 208 ++++++++++++++++++--------
 rust/kernel/device.rs                 |  60 --------
 samples/rust/rust_driver_auxiliary.rs |  40 +++--
 6 files changed, 180 insertions(+), 158 deletions(-)


base-commit: a7cc262a11354ab104b8e55c21200d099d141bc7
-- 
2.54.0

