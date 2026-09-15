Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD470C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E4510F411;
	Tue, 15 Sep 2026 10:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WxtgckeJ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E5A810F400
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789469923;
 bh=dY0q2inShOf1iFynSL7QntpUqtr/LiL5XlMbuV1S8Mo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WxtgckeJhvCgXFGvJfSYT3jGdEnLSYaMoIrkJ5L2WBeZlBA+c+eAVMcbSxWNdB6MJ
 sbdKcx6bBOAuPLzaux0qSbUsPwJ1ILU68WcqLbk+IdTZ50oI30JNMQh+3vybSFp1Oe
 tMLs/OjPhfMg4FABc2v4xs2ta8MzN54obg6Ly9dvLvruEtgSkazWNmeNP7b8MAucBj
 gN0EFCdncviE0OKTdNGXUD4EATyJLt8UK5s4KXF01zEoeF/hmWMITezoqpgi3ozNWD
 Ep3EGhq/Db+iaTdK3LZ9XL0vVA4lt/J8WLP1wWa5bIu1DuovxNzWllhqcBEBOnD6AP
 nc4mC376zLbRg==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E5B0917E09B5;
 Tue, 15 Sep 2026 12:58:42 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Tue, 15 Sep 2026 12:57:35 +0200
Subject: [PATCH 2/9] rust: io: drop the CONFIG_64BIT restriction on system
 memory u64 access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-tyr-interfaces-v1-2-5d28f1f75aca@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.14.3
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

SysMemBackend's IoCapable<u64> impl is currently gated on CONFIG_64BIT,
copying the MMIO backend's restriction. MMIO needs that gate because
readq() is not available on 32bit. System memory has no such dependency:
a u64 volatile load/store compiles on any architecture, it's just not
single-copy atomic on 32bit.

Drop the gate so u64-backed types, such as bitfields, work on 32bit too.
Document the non-atomicity at the impl instead of enforcing it at build
time.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 rust/kernel/io.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index de8ef8e2aec4..a85ddd07cb7f 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1428,7 +1428,9 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
 impl_sysmem_io_capable!(u8);
 impl_sysmem_io_capable!(u16);
 impl_sysmem_io_capable!(u32);
-#[cfg(CONFIG_64BIT)]
+// Unlike MMIO, that needs `readq` which is not available on 32-bit, a
+// system-memory `u64` access compiles on any target. It is just not
+// single-copy atomic on 32-bit.
 impl_sysmem_io_capable!(u64);
 
 impl IoCopyable for SysMemBackend {

-- 
2.39.5

