Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31093606A322
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xs1HTniV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D1E10F048;
	Mon, 26 Oct 2026 16:41:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB3F10F021
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:41:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 892FA43734;
 Mon, 26 Oct 2026 16:41:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793032873;
 b=cArWtRwHhB15EMkjHJNjqh3f3H2IQPZ+UM6RrSa8YQlU4/ybDvhEh4JaivUQU2udfI48
 jHMKSFngBbaHel9RZTHG7cksuo/+DeSC4R/Qj3Q2SjtJ9tlma5P/7xu/sltYnpKVfnhdh
 LjxZ//YsRcWrkdKgCeFM5JayXY+56B/7s1FhgkVcvWVJRWdgTbtd/5b7KSHFubiDgzVM5
 LQ3yn4Zquxdrmt810U/ByhNzUQ6ZvXzcExNidIRxsNKwU5HTishhzMUCX7rms7xm2Wnzi
 XUkcIaGukbQx+FWqdPYzn/ykHiPIRLGjF7BSVrHmE//gOmfLXngBAjUHKXuTqracJjw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032873;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=8M0oh2AqgxAI6ZpQRJJhghp96GjY8sQQ1ghn1+UQZnU=;
 b=Q/Z29Idh4d0TmZVBoNrRV1/TSqY6SHK7orn88Trq0797VSMWT9WQG3T/4P7C3cK4qWNO
 EJ9fqPjkcPcGaxzgO4SzM0e8p38sVreb/jfTNGGR8lx6z8Mijj8d9pik65GCBlfebS+44
 8ZPaDSNa4fiJPt0eQFx4doUlsCFF3bgWM5pTKmLKHkApYix5zAIjQiRIsADimzczLIuKc
 CUfQeVrBkB6nfYwifQJFiH9ZmZO/oYsgRB1wg2ehbAgNx6IiPQ45DriUCGBi9zDQ4aJrC
 qEFIkG6Bn1h+UXwZL9oCz63XVntNaw2gh+kpfF9t51RK/+innPuijZGscrLFnRGVpLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CF6A91F01829;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793032873;
 bh=8M0oh2AqgxAI6ZpQRJJhghp96GjY8sQQ1ghn1+UQZnU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Xs1HTniVmSXsyDaRDI4h9R/EilRgZDTNyw0A5n+Njl2o8cx4B3ngK6UMwIxaHOmzh
 HOMZfoN+HQvp7JLFpTkWQavaBgh1iOFhZCVc7UxrBGknvod2aoiuTvjBMe9MNElLyt
 flEzrCVSW+SUqY/scmy9EpLKU56TkojfVElosALZhLCCe3xQsXHslelySSo3+f1skd
 q05+2lccY2ELUU7f+G4XzMdyarZgoqKcRw6weZv8EMr/doOwEzx0UAMje3ZYpCv686
 sTapBr2/q/hHY6/1+HgznMakkWIQTRDDO4x2bMxu+Vl2rZYYqOCXd4HF5s8Pn6UdcZ
 o3Ki+S5I518tg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4CD6F44DC6;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 27 Oct 2026 00:40:54 +0800
Subject: [PATCH v5 01/11] rust: sizes: add SZ_4G constant
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-tyr-ioctls-v5-1-59dfe98cb003@kylinos.cn>
References: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
In-Reply-To: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
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
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793032870; l=1808;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=5K5ZDtbb0No9pS3iRwCaB/ZkoyNuv4RA97gE66KsHmQ=;
 b=3xbf/Ui9pjN4/qzsbUlA392NPtGKkMDXcuaouEQqRyRyagAyDKTbCKWEjzhrj8CcnYpOpMqNs
 Q5cwKjb1MULCcgOqn1keN7x8FTAVjwijV21to9361zXabag+zsWjG0t
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Sun <alvin.sun@linux.dev>

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
index 930e63290cdd4..ee99f470ae5f4 100644
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
index 521b2b38bfe77..0acc8733d2368 100644
--- a/rust/kernel/sizes.rs
+++ b/rust/kernel/sizes.rs
@@ -132,3 +132,15 @@ impl SizeConstants for $first {
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


