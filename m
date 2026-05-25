Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6BFCD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 20:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969F510E3D4;
	Mon, 25 May 2026 20:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UW1tvsGt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3026510E3D4
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 20:30:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D7D6435A7;
 Mon, 25 May 2026 20:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412281F000E9;
 Mon, 25 May 2026 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779741013;
 bh=dGlGg1KPjf9GE4pvZqVXon2ZHwLzVeQvY3zCiGlsuuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UW1tvsGtlDOjd+UIaKlP96Ukh7FPeYR6mwTF7N5GK/N/ldSB3x0fmf/iay/YMAPsv
 H2ShdlrBL6nIZ/WIRngJrvAjL5Y1ds2MU68GVm4+msI+ZKWfxp46NZVPEOldnOSALp
 6kMpovj/FP0XkbSKqXyeYwqzjYRxKEu+fYQY61m8yyMUGxUfuKg0mTeQoqjfpy15W0
 JwWCT7IXNg6UAzps6buMDuAJPxLa/6tpwSOo8VZKkktdJyBEOk+aS0WaqJpqI5xzRl
 GwQqDSgfxdEfB5ahn3mEbRSPuccyW26stmfWnWsZDMIn6OqQtmQRnDsXITLfCT5zYx
 uwOyFzgtCOENg==
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
Subject: [PATCH v5 06/24] rust: pci: implement Sync for Device<Bound>
Date: Mon, 25 May 2026 22:20:53 +0200
Message-ID: <20260525202921.124698-7-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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

Implement Sync for Device<Bound> in addition to Device<Normal>.

Device<Bound> uses the same underlying struct pci_dev as Device<Normal>;
Bound is a zero-sized type-state marker that does not affect thread
safety.

This is needed for drivers to store &'bound pci::Device<Bound> in their
private data while remaining Send.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c743f2abb62f..d214a861375d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -528,3 +528,7 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` can be shared among threads because all methods of `Device`
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
+
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct pci_dev` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
-- 
2.54.0

