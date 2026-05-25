Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34CACD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 20:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F8D10E3DF;
	Mon, 25 May 2026 20:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ElarxhLU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BDF10E3DF
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 20:30:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90BF34065C;
 Mon, 25 May 2026 20:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40B01F000E9;
 Mon, 25 May 2026 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779741042;
 bh=3s2zR/dj1pWywn+EHbTTBpMMpSw/+K1EkrL3Cwr8X6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ElarxhLU1zbvsRiXjQE2HRAf9RzqAxiN+/aY1YzYKn0cMizSvwGYZi9PF1PpXaxBw
 GN5JcQJb13eg1Ff6z1YZ2xnNT86FQ49B1+oVS8CDfslKwOjRd9sIQ3YKVUdEx1KXrU
 pEivvJkNRHW9olkpHM84adUi00g9ZpOFGpIhCuAwd8qFCU+K6BeA5HVcVFPeF2lnK/
 6B0TQrgEeerUkPgmUXKVzdmNnkpwIni/5pD04a3pUeG2rGQcr9kVF7EZUKbXA10KwU
 tBDYO5gySLP9NC5SYrEQiWJ0w24yS74gLlLyydVIppynaFXJObHZxyRc81WQ6e2thP
 6p/P3Ttt/5ABw==
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
Subject: [PATCH v5 10/24] rust: device: implement Sync for Device<Bound>
Date: Mon, 25 May 2026 22:20:57 +0200
Message-ID: <20260525202921.124698-11-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct device as Device<Normal>;
Bound is a zero-sized type-state marker that does not affect thread
safety.

This is needed for types that hold &'bound Device<Bound>, such as
io::mem::IoMem, to be Send.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 5df8fa108a52..c4486f4b8c40 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -467,6 +467,10 @@ unsafe impl Send for Device {}
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
 
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct device` is the same; `Bound` is a
+// zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<Bound> {}
+
 /// Marker trait for the context or scope of a bus specific device.
 ///
 /// [`DeviceContext`] is a marker trait for types representing the context of a bus specific
-- 
2.54.0

