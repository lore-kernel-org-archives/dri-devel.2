Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D6DC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBB010E1DD;
	Wed,  5 Aug 2026 21:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lSlQpyqF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="si/ptcw7";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B73E10F00D
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:54:55 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hFkj93QfjzMlLG;
 Wed, 05 Aug 2026 23:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1785966893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AWrGq5FfGPbk5wRVIp/rVvdqvVViGUev2j+DZUX901Q=;
 b=lSlQpyqF+rYbCS4YYb2y2tgCFfkELlPu/lqY/GkBdaEbsiquLv2ZplFRmn7eOUPDbkPO+M
 wyNgveF8NgRQCgIVgcgsndew0oW7AY8ubyHBQKQRVx2XhkVw7XfcFbiPEFdcoevJ9PyVuG
 5mVTHKSZVJSKCWV2uQvRU/CPHuDoPg5UXcZHrG7rY6Rk3nr/1nQ2pOAESTq4ntgNl7RBXo
 tIZbD6sqQouThKpvpBPGF2TNSnGhMFz8Q7S0zYd5LzVBP2FZXJ+ILHAkskoIKYbrUeD57D
 U65O9nohqVv+yYj4jEr3qX5Ged+xxZiyRhKXfk+cHudh0mhxsCRl4hwqb/KZ3g==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1785966891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AWrGq5FfGPbk5wRVIp/rVvdqvVViGUev2j+DZUX901Q=;
 b=si/ptcw7yk16FbgPem2WsZsvaMCS++UVHjAPJytxfvYMM3+w7LJgTvuNeGQGfyb7GFPG3y
 vLeCVV0wz93XCEjm908WYOCVqb2TPaTCxarVOLw80djaEP/8ZdFMVvdLitnrcPbwWUBeVN
 p1MJq37Mjh9cGX2L+GmaEBqBKv6J8mBtBU6qSR8RXVNMnZM7PfDEOUc1ApJVGfaLcvj4k1
 AKClRAnOK9LJVhO6JbthiEX+2spFFppicJry4yRWMc4kYOSYmOCYF2ZNtRWutzgXdXCrqY
 8i0JeN+W/mUABSD+fjMJA7r/tm/c751eoZU/QmnNsJTp+MqsoSPjRPv534KYJw==
Subject: [PATCH 0/3] rust: dma: add the single-buffer streaming DMA API
Date: Wed, 05 Aug 2026 23:54:40 +0200
Message-Id: <20260805-dma-streaming-v1-0-03974c86b141@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0NL3ZTcRN3ikqLUxNzMvHRdy2RTA9NEC3Mzg+QkJaCegqLUtMwKsHn
 RsbW1ANqZdctfAAAA
X-Change-ID: 20260719-dma-streaming-9c505a8760cb
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785966885; l=3776;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=2dVycLvsf+ablzwvD6gYJ1AxRh3CCOReiMMp8dDPkvA=;
 b=IkmI1CbZHU9BDY0LgkkEoqTa4zXwkM7qMxjtvNezzD4XpuqtG8bG0zYo+UZbpxv9vrnSJ6bXV
 TtNTLKZ9xOxBnMHnIoxWdJO4u20+0biD9YbzlvKsSoBctKFv0s5Qau+
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: tki8wurrqdkoh99emg51fadxw9djpcn3
X-MBO-RS-ID: c2b6dd4a96dfe6fded4
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

The Rust DMA abstraction covers `dma_alloc_coherent()` only. The streaming
half (`dma_map_single()`) is missing.

A streaming mapping is a temporary lease on memory the caller already owns:
between map and unmap the buffer belongs to the device, and the CPU may only
touch it in between a `dma_sync_single_for_cpu()` /
`dma_sync_single_for_device()` pair. In C that protocol is left to the driver
author, and getting it wrong is silent data corruption on non-coherent
platforms. It is a borrow handover, so it can be expressed in the type
system:

    let mut dma = Streaming::new(dev, buf, DataDirection::Bidirectional)?;

    *dma.for_cpu() = 42;

    let dma = dma.submit();

    // Program `dma.dma_handle()` into the device and wait for the transfer.

    // SAFETY: the transfer has been waited for.
    let mut dma = unsafe { dma.complete() };

    assert_eq!(*dma.for_cpu(), 42);

`submit()` consumes the `Streaming` and returns a `StreamingInFlight`, the
only source of the `DmaAddress`. It owns the buffer, so the contents are
unreachable while a transfer may be in flight, no matter where the driver
stores the address. That is what makes `for_cpu()` safe. Whether the device
has finished cannot be checked by any abstraction, so `complete()` is the
single `unsafe` operation. Dropping a `StreamingInFlight` without
`complete()` leaks the mapping and the storage, with a warning: safe code
cannot prove the device is done, so it is not allowed to unmap or free
memory the device may still be using.

Patch 1 adds `ContiguousBuffer`, describing storage `dma_map_single()`
accepts: a single physically contiguous region in the kernel's linear
mapping. Patch 2 adds the mapping itself. Patch 3 converts nova-core's
`GspFwWprMeta`, a streaming workload written against the coherent API.

One thing to note
=================

`Streaming` borrows a `&'a Device<Bound>` where `Coherent` and
`SGTable<Owned<P>>` both hold an `ARef<Device>`. The DMA API may only be
called while a driver is bound, and `Drop` unmaps, so a refcount does not
express what the mapping needs [1]. The two existing types predate the
`'bound` driver-core infrastructure; converting them is not part of this
series.

Testing
=======

Build-tested on x86_64 with `CLIPPY=1` and `rustfmtcheck`; the kernel crate
doctests, including the new `Streaming` ones, pass under virtme-ng.

Patch 3 is compile-tested only, I have no NVIDIA hardware; it touches the
GSP boot path on all supported chipsets, so a Tested-by would be very
welcome. However, I've tested it on my Rust EDU Driver locally [2] while
using swiotlb=force to emulate bounce buffers on x86.

[1] https://lore.kernel.org/all/20250306160907.GF354511@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org/

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Maurice Hieronymus (3):
      rust: dma: add ContiguousBuffer trait for streaming DMA storage
      rust: dma: add abstraction for the single-buffer streaming DMA API
      gpu: nova-core: gsp: map the WPR meta for streaming DMA

 drivers/gpu/nova-core/firmware/booter.rs |  11 +-
 drivers/gpu/nova-core/gsp/boot.rs        |  20 +-
 drivers/gpu/nova-core/gsp/hal.rs         |   4 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs   |   4 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs   |   4 +-
 rust/helpers/dma.c                       |  35 +++
 rust/kernel/dma.rs                       | 449 +++++++++++++++++++++++++++++++
 7 files changed, 515 insertions(+), 12 deletions(-)
---
base-commit: dc01dfb37b34beeefcfe1c3055364d41a4070c7e
change-id: 20260719-dma-streaming-9c505a8760cb

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>

