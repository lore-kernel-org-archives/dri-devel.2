Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0F606A337
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=ZelDTsnh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F114210E7AF;
	Sun, 22 Nov 2026 13:02:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467CC10E597
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:02:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02A68611A1;
 Sun, 22 Nov 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795352558;
 b=OQXtrvLV/Aadczg3MmMHlzkPGWHsVT1j6kg48SN4fBClXecMNrSPk9pyKoQdBgQZEOyi
 COQaGDY1uwL/Pr21ZGR0I+MxbPsaT8oA1qeWwdM6Q+Efiq4WY+hZICJZRFtR5zpoQ5aRN
 Z/dftzx8kUVeZb+/pCTKKnPBHhLeHETX7NdLv9BhV0qeUUKmSREM6RicdmapVQ9gOoHJW
 bUfJsxGKFE8gZnRN1wXv/RcOrkTVW6kVNn4yGRjEJoKYcd6ze3cfAHXjZFE06W3kYz/Ia
 cCUgYqB5OJbUXreDsS1xA66V9dXDWIO60ggeOusIFukmHPCiiyRnb8QvZuZck5vsMgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795352558;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
 bh=fLY13jsDHwyISc0dUN6ky1XIrU70a0A/B3o74OtR93o=;
 b=iTZq73lBHxIwosi3zfYS6s0es5JBhKXf9XjEHIHyEkFXP27mPt/bBqw/j07EtL8T/4L1
 iA6mWHiVXvrR4vaLngvTojAzqMFRNoP2Z0bXgr5wOBaF5xwsx3mNrr9zoLZsXwSd5qU9H
 QadInIy+k/UF33G7h3VjVFHv7L1O1pT8Lxma0NEewITgvmiys3fScqWOuvLUjb8Xea84/
 DLI3sO5z4wVYB/0HEHh6zbiXNU1ZnU1u5EdSNl9zCMgGNde9Af8aqdv4szaBwZjqD/kR2
 hCnbb9ogvJMdFIL69K2fVmnnnGGK2UcYkSojrLQHomojKRfC4Az7V19XKJy8OsmlzIg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 478121F000CA;
 Sun, 22 Nov 2026 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
 t=1795352558; bh=fLY13jsDHwyISc0dUN6ky1XIrU70a0A/B3o74OtR93o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZelDTsnh0jTVITwkwTRcnMUYrgAMoJ2bw2JOdmrS4rUr5iGAXdCWZdqHNcu1cgyLI
 qpf5ZS7Cg445g7lwjj02kmVPR+Lddwa3uH1ojfNanB54sJJcyJL6Vp1tGNF22rKD08
 Qk0PTQVWENCZ88sXHkhFfstM5YrY2/IkJkPG1aSU=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BAD634C04C;
 Sun, 22 Nov 2026 13:02:33 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Sun, 22 Nov 2026 20:50:20 +0800
Subject: [PATCH v7 01/10] rust: sizes: add SZ_4G constant
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-tyr-ioctls-v7-1-3a2af624b992@linux.dev>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
In-Reply-To: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795352551; l=1808;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=RC5TQEMWPe7CGSe6NzYoBKUAxyypO/SjxFkEThrMEs0=;
 b=oGHlUQ2rqNH/9SAV3u9g5qPE39Tt2xAEycsWcCAcejYwOq0VP1Tj/mkBTW4U/7VibI911425I
 Lx2FOfl/Oo0CzSZQ6pzAeeyfDfByZSK9RK1x0ua4I6cbNXWcB6Lfk9h
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SZ_4G is used by Tyr when splitting the GPU VA range into
user and kernel regions. Add a LargeSizeConstants trait, implemented
for u64 since SizeConstants only covers sizes that fit in a u32.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/sizes.rs            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc73..fd39cc954eaba 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -116,6 +116,7 @@ const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
 const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
+const unsigned long long RUST_CONST_HELPER_SZ_4G = SZ_4G;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
index 188e00c2b8b46..760d26ebe6ff6 100644
--- a/rust/kernel/sizes.rs
+++ b/rust/kernel/sizes.rs
@@ -177,3 +177,15 @@ impl SizeConstants for $first {
 }
 
 define_sizes!(u32, u64, usize);
+
+/// Large size constants (≥ 4 GiB).
+///
+/// Only implemented for [`u64`].
+pub trait LargeSizeConstants {
+    /// `0x1_0000_0000`.
+    const SZ_4G: Self;
+}
+
+impl LargeSizeConstants for u64 {
+    const SZ_4G: Self = bindings::SZ_4G;
+}

-- 
2.43.0


