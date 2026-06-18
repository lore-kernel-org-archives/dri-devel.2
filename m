Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5636CD98F0
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE51D10E8C8;
	Thu, 18 Jun 2026 23:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GgDkpvVe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A0010E8C8
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 23:08:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07907601E1;
 Thu, 18 Jun 2026 23:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6201F000E9;
 Thu, 18 Jun 2026 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781824130;
 bh=IFzNgkG2m6LHm/n3B0bxBt/0Kp+5tRid/Y2vmPN6Huk=;
 h=From:To:Cc:Subject:Date;
 b=GgDkpvVe1RBzO2seIT4BcWsJJ3VDTGBlmFmkv0wvl6gwpAn2VaUfbrlZtmcP93hUr
 +D65Ip+5tDKdLWvhcgGjLur4Qik4YKohvkWYwE4WfKUbkCMRou+Vgo0WvJUPKPRF4m
 +/xjr1h/D95QngnGCr4mMHGik1F8r5zgQHM52KO7ci5EImMc3owtOEM4HeIJ1eoXKg
 IRDQApzfVIcV8mq3rN807YRvXcdY77oLVDkX2LlUBtPz4AgakAH1xQkhwhKY4CQv/6
 f8qH0vlqlt01zFCFAACJRuo/gG21gAimMGOZSC346L/c/s8FCm8QcaiuhqsWMleXq9
 ZeXUZYjMBYubw==
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
Subject: [PATCH v3 0/7] ForLt/CovariantForLt split,
 auxiliary closure API and DevresLt
Date: Fri, 19 Jun 2026 01:08:26 +0200
Message-ID: <20260618230834.812007-1-dakr@kernel.org>
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
 rust/kernel/auxiliary.rs              |  76 +++++++++++++++-----
 rust/kernel/devres.rs                 | 100 ++++++++++++++++++++++++++
 rust/kernel/io/mem.rs                 |  65 +++++++++++------
 rust/kernel/pci.rs                    |   1 +
 rust/kernel/pci/io.rs                 |  37 +++++++---
 rust/kernel/types.rs                  |   1 +
 rust/kernel/types/for_lt.rs           |  95 +++++++++++++++++-------
 rust/macros/for_lt.rs                 |  53 +++++++++++---
 rust/macros/lib.rs                    |  18 ++++-
 samples/rust/rust_driver_auxiliary.rs |  96 ++++++++++++++++++-------
 12 files changed, 432 insertions(+), 119 deletions(-)


base-commit: 83f1454877cc292b88baf13c829c16ce6937d120
-- 
2.54.0

