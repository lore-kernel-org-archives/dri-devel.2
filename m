Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607C9FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73AF10E979;
	Mon, 27 Apr 2026 22:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tpxe20+p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C67D10E979
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:13:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E3CC40E0B;
 Mon, 27 Apr 2026 22:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620F6C2BCB5;
 Mon, 27 Apr 2026 22:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777327991;
 bh=auHxUUsQH6YXhhsoPM2i0zRThcG3GjhIs2ycbNDnDEE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tpxe20+pywFn3Tok0SQvaoZWh+7phDXK2kLMxayygbnAbIGpo4k5r99nyg4ok/TJ/
 SBrRKriatJkTg+0/rNlGho/QEAN0URtpVftUITiFgz2PeDEoV+PZVNxNFH1xG+PPeM
 2l938aLVge8Y5kYhVxsdNslPc7pfluaqm1oARKGxJQluXP7FWJVv8KXlEF6MARCVK0
 R03bksZMeUO14VT8jFy1rBybwQBp4DWLGX+z2POqWWcfj3J6li5f2ak6K9SenC1p3N
 7DnNU0RItI+Fs6iuvcc1ndUxyHPK59ARQzj2B906M/KbqDQOr7YNNJf236NiaDcESF
 hqZrZA6jz778g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 10/24] rust: device: implement Sync for Device<Bound>
Date: Tue, 28 Apr 2026 00:11:08 +0200
Message-ID: <20260427221155.2144848-11-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
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

The underlying `struct device` is the same for all device contexts;
`Bound` is a zero-sized type-state marker that does not affect thread
safety. Implement `Sync` for `Device<Bound>` with the same safety
argument as the existing `Device<Normal>` implementation.

This is needed for types that hold `&'a Device<Bound>`, such as
`io::mem::IoMem`, to be `Send`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 09cbe8a438a9..b330b87178d3 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -503,6 +503,10 @@ unsafe impl Send for Device {}
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

