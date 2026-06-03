Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF3DCD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6D410F729;
	Wed,  3 Jun 2026 01:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bK40Chfx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675D910F729
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:10:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 94C99601F6;
 Wed,  3 Jun 2026 01:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B2A1F00893;
 Wed,  3 Jun 2026 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780449027;
 bh=vg4OT7qVOOfiZWFV5Vcsuizp9IDFD8+pqun6oZHSTcM=;
 h=From:To:Cc:Subject:Date;
 b=bK40Chfx+OYTbVFoho2VApu/zYarNWFjOtFjO7yjtr8tQILFmaHSzBTcATrsQ5lOt
 BzzDNGMelyIeLbDps5lE25YcnmL4lOYemVseUghlhimjykx9sBLUxO/LVIuSL5TfNs
 /WQnxYsAq1fscjQsNbEJcqZ0vTlc7b0aNghVgTWJLDxqJEOaw9TQDel7YZUsuO3J/U
 xsIDlEF8LylAtjBaClr+Snzq5QWNI8rrwO3FZocJauVvMtXjo/U1dOYTfN61eJf06J
 id3S68G+VgFIL2GjMBROGyqe855oW7lPLcRhPVROkwQt06aDl4mcPl/Df8zgTSm7Ry
 MwU62cK2I0z0Q==
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
Subject: [PATCH v2 0/7] ForLt/CovariantForLt split,
 auxiliary closure API and DevresLt
Date: Wed,  3 Jun 2026 03:10:11 +0200
Message-ID: <20260603011020.2073650-1-dakr@kernel.org>
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

  - ForLt: base trait providing unsafe cast_ref_unchecked() for all
    lifetime-parameterized types.

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
 rust/kernel/auxiliary.rs              |  74 +++++++++++++---
 rust/kernel/devres.rs                 | 110 +++++++++++++++++++++++
 rust/kernel/io/mem.rs                 |  65 +++++++++-----
 rust/kernel/pci.rs                    |   1 +
 rust/kernel/pci/io.rs                 |  37 +++++---
 rust/kernel/types.rs                  |   1 +
 rust/kernel/types/for_lt.rs           | 122 ++++++++++++++++++++------
 rust/macros/for_lt.rs                 |  52 ++++++++---
 rust/macros/lib.rs                    |  18 +++-
 samples/rust/rust_driver_auxiliary.rs |  96 ++++++++++++++------
 12 files changed, 472 insertions(+), 113 deletions(-)


base-commit: 0023a1e8d01a9d400257d30c851bd16a29568809
-- 
2.54.0

