Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2D8CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 17:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530A911230E;
	Fri, 29 May 2026 17:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SAh89zqa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18B111230E
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780075929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTXkVWhfiCkPPMFCSefkBsAtfCVesv2uIIO2EqJJ/8Y=;
 b=SAh89zqaCyZmfvaO30iYtnRz5X162Jo1bIkedULMd6j3D5fHLvnRY5EqbGYKCGnMqV6meC
 jU85jjOxNzbWFLEPaJbBCvjTUA1Tp0SXYImfTOsJxNG7XZIIc0yN5JlQseBIexA9rnZsmA
 9+LxgQguZByZbMjg34EWDInvm/kgFd0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-E7vl8DQ1NBWSv445wnwexg-1; Fri,
 29 May 2026 13:32:06 -0400
X-MC-Unique: E7vl8DQ1NBWSv445wnwexg-1
X-Mimecast-MFC-AGG-ID: E7vl8DQ1NBWSv445wnwexg_1780075922
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F1791955F44; Fri, 29 May 2026 17:32:02 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.89.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D395A30001BB; Fri, 29 May 2026 17:31:59 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: "Gary Guo" <gary@garyguo.net>, "Ingo Molnar" <mingo@redhat.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Benno Lossin" <lossin@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 1/2] rust: sync: lock: Add Lock::get_mut_pinned()
Date: Fri, 29 May 2026 13:30:41 -0400
Message-ID: <20260529173137.303717-2-lyude@redhat.com>
In-Reply-To: <20260529173137.303717-1-lyude@redhat.com>
References: <20260529173137.303717-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Rt6cBizzQweJGkuPRcYK5a_1i-ZOyGKflLhV_tnXPto_1780075922
X-Mimecast-Originator: redhat.com
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

These two functions are inspired by the Rust stdlib equivalent:

  https://doc.rust-lang.org/std/sync/struct.Mutex.html#method.get_mut()

The idea here is very simple - if the user has access to a Pin<&mut
Mutex<…>>, we can guarantee that no one else can look at the data protected
by the lock. Thus in such situations, locking the mutex isn't necessary to
access its contents. This can be useful in situations like `Drop`
implementations, where we may want to access the contents of a Mutex within
a struct before dropping it.

So to do this, we add `get_mut_pinned()` to `Lock` - which provides a
function to access the inner contents of a Mutex provided a Pin<&mut …>.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 10b6b5e9b024f..5ca36baed34f5 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -190,6 +190,17 @@ pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
         // that `init` was called.
         unsafe { B::try_lock(self.state.get()).map(|state| Guard::new(self, state)) }
     }
+
+    /// Returns a pinned mutable reference to the underlying data.
+    ///
+    /// Because this borrows the lock mutably, no actual locking needs to take place - as the
+    /// mutable borrow statically guarantees no new locks can be acquired while this reference
+    /// exists.
+    #[inline(always)]
+    pub fn get_mut_pinned(self: Pin<&mut Self>) -> Pin<&mut T> {
+        // SAFETY: We return a pinned T, ensuring we don't move T.
+        unsafe { self.map_unchecked_mut(|data| data.data.get_mut()) }
+    }
 }
 
 /// A lock guard.
-- 
2.54.0

