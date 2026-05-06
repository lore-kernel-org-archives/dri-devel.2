Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A8BCD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 21:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8814110EEA1;
	Wed,  6 May 2026 21:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NsPl84A+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54B910EEB7
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 21:51:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AC1B94383F;
 Wed,  6 May 2026 21:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD3C2BCB0;
 Wed,  6 May 2026 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778104315;
 bh=OBpeRj6FSTcG0AEEiVV2B733gMqON0DFwTtw26epeTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NsPl84A+sPG+5pSao2NU0zfqqTmAskgxFwvco5wPX8g1hdsrAIhdIZFydxZvzbmXp
 PPR/X1+L5kw+P3BUTYfTQTRdeEsGV7thr/LDuOvuuZtBhKdLXWUea5JE+sUBzM8fKW
 2oLOFbwA6aXmjbwvP826WGjsTx1xCW6RyVGqa3gIUJI7pKQkGhiApGu7eRWm8JfGdz
 P7VxvjUPlZqISuuIP+AL/4diFomVLO+Kgw2z4QKIq7sw1HTuwQtbfBzvwEKOu5ix7n
 nZZf8ccb3hLa9fVEXXUPZTWR4EBspkD49TbXMTlwqau3SCEQxl1GSxLQZZY1zM/5z5
 tNu6QgCmlqRPA==
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
Subject: [PATCH v2 05/25] rust: pci: implement Sync for Device<Bound>
Date: Wed,  6 May 2026 23:50:41 +0200
Message-ID: <20260506215113.851360-6-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
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

Implement Sync for Device<Bound> in addition to Device<Normal>. The
underlying struct pci_dev is the same; Bound is a zero-sized type-state
marker that does not affect thread safety.

This is needed for pci::Bar to hold &'bound Device<Bound> (required for
Bar::into_devres()) while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index fe5148f41d8b..6f82f2e6c74f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -526,3 +526,7 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` can be shared among threads because all methods of `Device`
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
+
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct pci_dev` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
-- 
2.54.0

