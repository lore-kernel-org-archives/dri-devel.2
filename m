Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E49CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC11110E214;
	Wed,  6 May 2026 22:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="r7ZPn4Zu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C9710E214
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 22:00:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D31F36013B;
 Wed,  6 May 2026 22:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5551DC2BCB2;
 Wed,  6 May 2026 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778104833;
 bh=nCyApNb8RKn1veEhbH+LihTl9SHcYNeSopAO0tq8/OA=;
 h=From:To:Cc:Subject:Date:From;
 b=r7ZPn4ZuEfXPGPabAtTXrwgZPsqXmXckRw4t6mO2USweTSvl2RUftL8wUqYiaHVc6
 F/74M2nXgVwWrb4IB2kr1wJJsahWu+Ra4QxGTmk+dtcJrNUKk26S7ai3T5XMW4QO0e
 /jmtBfR4JNscZOtjsINOTk345VDwTVWgpTzwrbAFE29tbdw9uLDIThLfSGSDGJx3pY
 aOCD+Klzh2O7/VerE10AIB/YF/JAJSMjbRfhLQDnq1AR9Hw/utzMFw+u+w998uKBS+
 0FbEMPMpM346TySODIGrcOnm+hDCujKBflOD/B+Vkwqp83Nh1h48gH7aSEOIvVJf68
 c/8Ui70hgF0KQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/3] rust: devres: add DevresLt for ForLt-aware device
 resource access
Date: Wed,  6 May 2026 23:58:32 +0200
Message-ID: <20260506220012.855173-1-dakr@kernel.org>
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

Devres<T> stores resources as T and hands out &'bound T from its access
methods. For lifetime-parameterized types like Bar<'bound, SIZE> that
are transmuted to 'static for storage, the synthetic 'static leaks to
callers -- any method on the stored type that surfaces its lifetime
parameter would yield a &'static reference, which is unsound.

This series adds DevresLt<F: ForLt>, a thin wrapper around
Devres<F::Of<'static>> that applies ForLt::cast_ref in all access paths
to shorten the stored 'static back to the caller's borrow lifetime.
Devres<T: Send> remains unchanged for static resource types.

Also implement ForLt for Bar, IoMem and ExclusiveIoMem, and their
into_devres() methods to return DevresLt instead of plain Devres.
Provide convenience type aliases DevresBar, DevresIoMem and
DevresExclusiveIoMem.

This series depends on [1].

[1] https://lore.kernel.org/driver-core/20260506215113.851360-1-dakr@kernel.org/

Danilo Krummrich (3):
  rust: devres: add DevresLt for ForLt-aware device resource access
  rust: pci: return DevresLt from Bar::into_devres()
  rust: io: mem: return DevresLt from
    IoMem/ExclusiveIoMem::into_devres()

 drivers/pwm/pwm_th1520.rs |  5 +-
 rust/kernel/devres.rs     | 97 ++++++++++++++++++++++++++++++++++++---
 rust/kernel/io/mem.rs     | 55 ++++++++++++++++------
 rust/kernel/pci.rs        |  1 +
 rust/kernel/pci/io.rs     | 30 ++++++++----
 5 files changed, 155 insertions(+), 33 deletions(-)

-- 
2.54.0

