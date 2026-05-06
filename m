Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C90BCD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 21:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990AF10EEB8;
	Wed,  6 May 2026 21:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="alPIjzJn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53EC10EEB8
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 21:52:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 49C0F6013B;
 Wed,  6 May 2026 21:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44E5C2BCB0;
 Wed,  6 May 2026 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778104329;
 bh=65oXQ5dRDyn6R/I5J2GVV5AhZXrpJwtI039sm97wFnA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=alPIjzJnnLxZxj29Xga2dbUcgu56hG9l4FCeYpl8Ai4wUAhOFarKeAjgmmClxyFr+
 VtoV7qhGLx0FZdixxfQjyJws6nXYDi+fIEPBypTPna7ivMpUAjNKHyd3ryIbuGI0ET
 0WJml/BikgrO3E7NqldEv28tWSQKAQomjP4Yfth2KBv0FGujgh+fcmV47AKCKF1xIK
 5283l6TDvLMZ1vumA8RIZl4jzPA93uK4t5Zo7ENV3dkU62VuMNJAHjNXSl+11ET5ZQ
 kINuExF25ZhakSKXNQTNNXnZtowYciFPTe3//hjD1w73IN54i8JT8v84ooqtN9ss4D
 B7HGlJPOQeJvQ==
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
Subject: [PATCH v2 07/25] rust: auxiliary: implement Sync for Device<Bound>
Date: Wed,  6 May 2026 23:50:43 +0200
Message-ID: <20260506215113.851360-8-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct auxiliary_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound auxiliary::Device<Bound> in
their HRT private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 37690fa14891..e193ba5b7167 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -366,6 +366,10 @@ unsafe impl Send for Device {}
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
 
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct auxiliary_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
+
 /// Wrapper that stores a [`TypeId`] alongside the registration data for runtime type checking.
 #[repr(C)]
 #[pin_data]
-- 
2.54.0

