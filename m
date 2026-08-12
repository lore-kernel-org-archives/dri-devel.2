Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A5C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5403810EE8C;
	Wed, 12 Aug 2026 07:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MtoWm7Iw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5F410EE8C
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:22:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C48A160A91;
 Wed, 12 Aug 2026 07:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BECA1F000E9;
 Wed, 12 Aug 2026 07:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786519361;
 bh=BevUepA0N0WJqvBbfW3lp7xgb4TVhzEoOler2OCLh80=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MtoWm7IwvllHDbY1TsCf7fTbRx7AJ7pFl9aMEjvbmjAZK1B9IzfG+YXVTaJbzkvF5
 kUvCqYPd1wvctwqLZLR/EU3+61X1+Gvpu36xzB3AUlD9fyOrFnvanpTUuB5pjgFkQO
 rHe51BvPiXp28Lob2WcFX8nhFsSyIRYoZhxdNohWLYjOyTyRc5Ov6WbAyBkwd4GR1P
 r4wdwr/l1HmoDCiesdGGL4m0pJH3jpZmfPNYwTjkE9Su1UFm0f3dxswmEuNZitWOl5
 NnTXestHZHqlvTj+y0KYdrAmr6z6EkONsatgnwqWjLmJoy2ztNWFfFHeE33n4Md3MB
 1Mvt2Z2L+c6mQ==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <burak.emir@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v10 2/2] MAINTAINERS: Add entry for Rust dma-buf
Date: Wed, 12 Aug 2026 09:22:17 +0200
Message-ID: <20260812072217.1971807-4-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812072217.1971807-2-phasta@kernel.org>
References: <20260812072217.1971807-2-phasta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rust does now have abstractions for dma_fence. These abstractions are
quite complicated and require expertise with both the C and the Rust
side. Therefore, using the existing entry also for maintenance of the
Rust code appears reasonable.

Philipp volunteers to help maintain the dma_fence abstractions. Add a
corresponding MAINTAINERS entry.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7307..fd7689cf22ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7623,6 +7623,7 @@ F:	fs/dlm/
 DMA BUFFER SHARING FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 M:	Christian König <christian.koenig@amd.com>
+M:	Philipp Stanner <phasta@kernel.org>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -7636,6 +7637,8 @@ F:	include/linux/dma-buf.h
 F:	include/linux/dma-buf/
 F:	include/linux/dma-resv.h
 F:	rust/helpers/dma-resv.c
+F:	rust/helpers/dma_fence.c
+F:	rust/kernel/dma_buf/
 K:	\bdma_(?:buf|fence|resv)\b
 
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
@@ -8622,7 +8625,9 @@ T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
 F:	drivers/gpu/drm/nova/
 F:	drivers/gpu/drm/tyr/
 F:	drivers/gpu/nova-core/
+F:	rust/helpers/dma_fence.c
 F:	rust/helpers/gpu.c
+F:	rust/kernel/dma_buf/
 F:	rust/kernel/drm/
 F:	rust/kernel/gpu.rs
 F:	rust/kernel/gpu/
-- 
2.55.0

