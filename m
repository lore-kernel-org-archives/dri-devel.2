Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB368FC72DF
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 00:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF6010E679;
	Wed, 25 Mar 2026 00:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lmTCDmKJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA5E10E679;
 Wed, 25 Mar 2026 00:39:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E4AAB43AB2;
 Wed, 25 Mar 2026 00:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3374AC2BCB1;
 Wed, 25 Mar 2026 00:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774399176;
 bh=gbwC0bUs3ACbCLJCFMmEYT75zj/GDqXq5ckIamVbOTI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lmTCDmKJjwrYNTrIvkdfRz+Vi8m1T5GX7Fm9FQVG120/OAH2UsT58emkqcoGxATvc
 SoezpcnwzOYkuh5E4AZrxQTQs5fQKOihBdrMtP/G+V/bTKonC7f3GY9CWyuH56y8+5
 EIT9rhfmdfj7minUXffoTQLmLHUu5jHpz/ddQplsItuHOIWk9OH9KVSg5/yIqsKi80
 IniZLJhDq/PxqkpsIsMV1hGc59Blgt//WHyAGRBW2FJ/vwQMBrcr5vLNBh8xzJxIXh
 IlbYCoGsP78VMw2pqcfgJAWTHAqH2P0ofl0kofpN2rGKqX/bhouqzDDqFvIl/gDMVX
 Gi30lYVOQq4BQ==
From: Danilo Krummrich <dakr@kernel.org>
To: acourbot@nvidia.com, aliceryhl@google.com, abdiel.janulgue@gmail.com,
 daniel.almeida@collabora.com, robin.murphy@arm.com, a.hindborg@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 ttabi@nvidia.com
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/3] rust: dma: generalize BinaryWriter impl for Coherent<T>
Date: Wed, 25 Mar 2026 01:39:16 +0100
Message-ID: <20260325003921.3420-2-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325003921.3420-1-dakr@kernel.org>
References: <20260325003921.3420-1-dakr@kernel.org>
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

Generalize the BinaryWriter implementation from Coherent<[u8]> to
Coherent<T> where T: KnownSize + AsBytes + ?Sized. The implementation
only uses size() and write_dma(), neither of which depends on the
inner type being a byte slice.

This allows any Coherent allocation with an AsBytes inner type to be
exposed as a debugfs binary file.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/dma.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 3eef7c2396bb..7bc97f9f83fd 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -885,7 +885,7 @@ unsafe impl<T: KnownSize + Send + ?Sized> Send for Coherent<T> {}
 // The safe methods only return metadata or raw pointers whose use requires `unsafe`.
 unsafe impl<T: KnownSize + ?Sized + AsBytes + FromBytes + Sync> Sync for Coherent<T> {}
 
-impl debugfs::BinaryWriter for Coherent<[u8]> {
+impl<T: KnownSize + AsBytes + ?Sized> debugfs::BinaryWriter for Coherent<T> {
     fn write_to_slice(
         &self,
         writer: &mut UserSliceWriter,
-- 
2.53.0

