Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F2606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=A44NmbwD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B654112CF2;
	Fri, 27 Nov 2026 18:31:21 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D319112CDE
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795804259; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cwpj7eAt1TcEP6Cl9neCjZiFf+UfUtb61w3x/XCZMvKdaPnrQ2paKX3rgy1ZiNe2aSE3wJ9l08SuwD7LBNZ03st39RNr1kwR7p4R+XK56pV6mEmRsjjHcjdHCYdp0YlwfecehSPZ+q/k0y632Ce4l6vzuDms/e52J/tjNv5XxQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795804259;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bhmBavxBDu7oBvEaPUxGwfDqUyaXtuf03Km8pH8uDSA=; 
 b=Ga+BVaHevH5wXtQpJ2u79J7dTjqYZ6Q0ZSczLEy+3QphgzCEyuv/pZ7/Vb5s1uRdoA7gAVC/ITj3YUAUiSDx749es/dr0GKh7m1lmJo9g9HJUOHnXb0yuLZhqJObM0zQfU9nCm9cYParE7xv5Hxz/b88+0/y3ETw3KCy/XhWUnY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=A44NmbwDn61EUeS8XE/ZYmrckPVuocb3GpD8pCXQMgRO0p9xddP0Gfk+v4z2+RNZEk5iFBtbAB249fJdZLZWJli5nkutGWg/BcByzeO1WfdM9UVuFgjrRyJHn5CFZ/L2X5eMwBcCWy2f/eAvE5tdgQGxHhPLgE8H6hMdTRFqj78=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=bhmBavxBDu7oBvEaPUxGwfDqUyaXtuf03Km8pH8uDSA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795804258302402.81084280671587; 
 Fri, 27 Nov 2026 10:30:58 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 15:30:38 -0300
Subject: [PATCH 2/2] rust: dma_buf: dma_fence: require a SignallingSection
 in signal()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-dma-fence-signalling-v1-2-c44e8f4910ca@collabora.com>
References: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
In-Reply-To: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DriverFence::signal() is where a fence's signalling path ends. The
dma-fence rules require the whole path, from the point where the fence
becomes visible to other threads up to the signal, to run in a
signalling section. A caller of signal() has most likely been running
on that path before the call.

Make DriverFence::signal() take a &SignallingSection, so that callers
have to open a section. This does not ensure that the section covers
the whole signalling path, as drivers can simply do:

    fence.signal(res, &SignallingSection::begin());

But at least it nudges drivers in the right direction and forces them
to consider signalling sections instead of ignoring them.

Update the DriverFence example accordingly.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/dma_buf/dma_fence.rs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 7ee87935d3be..39f9bb9d1be3 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -773,7 +773,7 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///
 /// let section = SignallingSection::begin();
 /// assert_eq!(waiting_fence.is_signaled(), false);
-/// fence.signal(Ok(()));
+/// fence.signal(Ok(()), &section);
 /// drop(section);
 /// assert_eq!(waiting_fence.is_signaled(), true);
 ///
@@ -873,7 +873,10 @@ pub fn as_fence(&self) -> &Fence {
     }
 
     /// Signal the fence. This will invoke all registered callbacks.
-    pub fn signal(self, res: Result) {
+    ///
+    /// Takes a [`SignallingSection`] because all code needed to signal the
+    /// fence must run in one.
+    pub fn signal(self, res: Result, _section: &SignallingSection) {
         let fence = self.as_fence().lock();
 
         // SAFETY: `fence` is valid because `self` is valid. The lock must be

-- 
2.56.0

