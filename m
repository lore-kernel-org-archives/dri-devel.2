Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D84C43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4301D10E3D9;
	Fri, 26 Jun 2026 18:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Aw4Gu7aO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5376410E3D9
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 18:36:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0974342A0A;
 Fri, 26 Jun 2026 18:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20321F000E9;
 Fri, 26 Jun 2026 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782498999;
 bh=4ohhSdR4uLkHiWRbMexAantHFBpBzZI6WmGjwL2KC3o=;
 h=From:To:Cc:Subject:Date;
 b=Aw4Gu7aOmaqbgsNADbHax24oeNXpOSXZx5SXpUdMyrGGeFHsWamP319IlTBhIGhJM
 cQOPs1aZriEKiCWZK+GufH1B9zF0XZDJXqg66mNdeWTpNtHQupGiP+98JQjBldBlWy
 LO7JMcjFU6VB1M3uyQvm0GzYFkYt8oqx3fDAjnIJG5N2JaIWy+JMH7Lq+RWsvUx+cR
 BfhqTJjLqL6FQd82v/zWPLZuEJQ+j2AU6/IwX2j8Aff3thBoLOWrm4pCDW5er7/1Ao
 pZFB69zwhfoVWmDtQZDhZUWGoriTiNJKzPAFB+AdHcDDjJruFkOuX/1XpAofcE+mhz
 t8M93MWjffiVg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com,
 ecourtney@nvidia.com, m.wilczynski@samsung.com, david.m.ertman@intel.com,
 ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com,
 bhelgaas@google.com, kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 0/7] ForLt/CovariantForLt split,
 auxiliary closure API and DevresLt
Date: Fri, 26 Jun 2026 20:36:07 +0200
Message-ID: <20260626183630.2585057-1-dakr@kernel.org>
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

The ForLt trait currently guarantees covariance, which allows safe
lifetime shortening via cast_ref(). However, some types (e.g. those
containing Mutex<&'bound T>) are invariant over their lifetime parameter
and cannot safely use cast_ref().

This series splits ForLt into two traits:

  - ForLt: base trait for all lifetime-parameterized types, providing
    only the Of<'a> GAT.

  - CovariantForLt: unsafe subtrait that guarantees covariance,
    providing a safe cast_ref() method.

For invariant types, a closure-based API (registration_data_with()) is
added to the auxiliary subsystem. The closure's HRTB prevents the caller
from choosing a concrete lifetime, which would be unsound for invariant
types.

On top of that, this series adds DevresLt<F: ForLt>, a thin wrapper
around Devres<F::Of<'static>> that shortens the stored 'static lifetime
back to the caller's borrow scope. DevresLt provides both closure-based
access (access_with/try_access_with for ForLt types) and direct
reference access (access/try_access for CovariantForLt types).

Also implement ForLt and CovariantForLt for Bar, IoMem and
ExclusiveIoMem, and update their into_devres() methods to return
DevresLt. Provide convenience type aliases DevresBar, DevresIoMem and
DevresExclusiveIoMem.

Changes in v4:
- ForLt! macro: run the Prover and emit ProveWf structs for
  well-formedness checks
- DevresLt: change Send bound from F::Of<'static>: Send to the
  correct for<'a> F::Of<'a>: Send
- Add #[inline] to forwarding functions in registration_data_with,
  registration_data, and all DevresLt accessors

Changes in v3:
- Keep UnsafeForLtImpl as the shared helper for both ForLt! and
  CovariantForLt!, distinguished by const generic N
- Remove cast_ref_unchecked() from ForLt; lifetime shortening is
  handled by borrowing with the target lifetime directly or by
  decoupling the HRTB from the outer reference lifetime

Changes in v2:
- Fold the ForLt -> CovariantForLt rename and the new ForLt base trait
  into this series
- Add closure-based registration_data_with() for auxiliary ForLt types
- Add auxiliary sample demonstrating ForLt with an invariant Mutex type
- DevresLt: add closure-based access_with()/try_access_with() for ForLt
  types alongside direct access()/try_access() for CovariantForLt types
- Make DevresLt::new() unsafe; callers must guarantee the data outlives
  the device binding
- Implement both ForLt and CovariantForLt (previously just ForLt) for
  Bar, IoMem, ExclusiveIoMem
- Various safety comment and documentation improvements

Danilo Krummrich (7):
  rust: types: rename ForLt to CovariantForLt
  rust: types: introduce ForLt base trait for CovariantForLt
  rust: auxiliary: add registration_data_with() for ForLt types
  rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type
  rust: devres: add DevresLt for ForLt-aware device resource access
  rust: pci: return DevresLt from Bar::into_devres()
  rust: io: mem: return DevresLt from
    IoMem/ExclusiveIoMem::into_devres()

 drivers/gpu/nova-core/driver.rs       |   4 +-
 drivers/pwm/pwm_th1520.rs             |   5 +-
 rust/kernel/auxiliary.rs              |  78 ++++++++++++++-----
 rust/kernel/devres.rs                 | 106 ++++++++++++++++++++++++++
 rust/kernel/io/mem.rs                 |  65 +++++++++++-----
 rust/kernel/pci.rs                    |   1 +
 rust/kernel/pci/io.rs                 |  37 ++++++---
 rust/kernel/types.rs                  |   1 +
 rust/kernel/types/for_lt.rs           |  95 ++++++++++++++++-------
 rust/macros/for_lt.rs                 |  72 +++++++++++------
 rust/macros/lib.rs                    |  18 ++++-
 samples/rust/rust_driver_auxiliary.rs |  96 ++++++++++++++++-------
 12 files changed, 447 insertions(+), 131 deletions(-)


base-commit: 51cb1aa1250c36269474b8b6ca6b6319e170f5a5
-- 
2.54.0

