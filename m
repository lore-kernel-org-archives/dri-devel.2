Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A67CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6452112687;
	Fri, 16 Oct 2026 08:57:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA01112687
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:57:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACAD2602C3;
 Fri, 16 Oct 2026 08:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86D91F000C5;
 Fri, 16 Oct 2026 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792141071;
 bh=YvjiYYGb1HHkRI/noHetRX7tr+whhoEHSilSms9Fg8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ELOBqSB2KVz5K0YP8VRPomyj7a+8EhI/F0Mm0QOMtV3k2DXDF0S6U8UiwSaqkU+1f
 eEWPjzg18QPDpk/b+IoFG5rhFIifOfT2zmA/FMeTFLFLKmfFtDTeHiOeRd2EBK9WgW
 7VvkL4mwf+yLENwfJSI7atHhpDeGi2oiPaG8l0GRiHEWzo1yazxroKFc7cXUTfUelQ
 DA0egYCxL8SfJ24Bdy9ve3FY8B08oxEz+GEKtyp5L34DFGb8EgmXpkePzzDSfZVefa
 qpFo8dvDnyk5nafrL+8turIhpxCFQY0px+sVKIVLyzBp5tLyd4cUmVklS5p8Z4UAH9
 Knj6pNEynnWeA==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>, John.harrison@igalia.com,
 da.gomez@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v6 2/5] rust: DmaFence: Implement Deref for FenceContext
Date: Fri, 16 Oct 2026 10:57:21 +0200
Message-ID: <20261016085724.1031766-4-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016085724.1031766-2-phasta@kernel.org>
References: <20261016085724.1031766-2-phasta@kernel.org>
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

A FenceContext carries data, which the user should be able to access.

Implement Deref for FenceContext.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index eef2b9e93f35..0028124e6aa6 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -86,6 +86,14 @@ pub struct FenceContext<T: FenceContextOps + Send + Sync> {
     data: T,
 }
 
+impl<T: Send + Sync + FenceContextOps> Deref for FenceContext<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.data
+    }
+}
+
 impl<'a, T: Send + Sync + FenceContextOps> FenceContext<T> {
     // This can later be extended as a vtable in case other parties need support
     // for the more "exotic" callbacks.
-- 
2.55.0

