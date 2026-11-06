Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F41606A336
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFDLlN4B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03682112DFA;
	Fri,  6 Nov 2026 14:09:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B3A112DFA
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:09:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD07660A63;
 Fri,  6 Nov 2026 14:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3253D1F008A1;
 Fri,  6 Nov 2026 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974174;
 bh=kFO2o9d1HuvRpw65wW5KNZGSLKA1liz6URUAihp77/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FFDLlN4BlZiTeMoIWuJrMO6dBKt1DPUypnPGbSNiulXI9JTxqOSE2qZn4VNOQQR3p
 D3uExnaXxrvwo2yFi7auHN7NJIqKvb52iFVLXHWs52LGstNoEwgLKeFodmwh/ygdQv
 2B638xYB6ATokDR2+gVtiKvZOpJDVGrYL/CYlmZJ1E4Sj+bm3iHr+5qJ1MwgeJuJ5A
 X5kVvKGhuL78ttYNMA7giLQ1Aw1bHSXJ0I5Um4mXsB1RWmqKfhC7dvOSphFaq1KimI
 W5WrNZ34Mh1j7siqToFEI8vIBQ2nsPNpAuzymLhvW584gnTrl9PD5NOO6vafDsKKMT
 2IatCtZxsZQ6A==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Matthew Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 2/8] rust: DmaFence: Add ID accessor for FenceContext
Date: Fri,  6 Nov 2026 15:07:47 +0100
Message-ID: <20261106140752.520386-4-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106140752.520386-2-phasta@kernel.org>
References: <20261106140752.520386-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A FenceContext has a fence context number, which can serve as an ID
field. This number can be useful for owners of multiple contexts to
identify them, store them in an XArray etc.

Add an accessor for fctx.nr.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 5300448882e7..897308f60dd3 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -135,6 +135,12 @@ pub fn new<E>(
         })
     }
 
+    /// Obtain the FenceContext's ID number.
+    #[inline]
+    pub fn id(&self) -> u64 {
+        self.nr
+    }
+
     fn next_seqno(&self) -> u64 {
         self.seqno.fetch_add(1, Relaxed)
     }
-- 
2.56.0

