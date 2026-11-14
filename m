Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4053606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EkMs4p0G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04A710EC53;
	Mon, 16 Nov 2026 08:58:47 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA80810E05E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 20:07:38 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3adff684a52so25841941fa.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794686857; x=1795291657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R7dtlKbfcr0G/r1hntPJsms+e0JAvg0N9xC2Og7VBO4=;
 b=EkMs4p0GL6nqryF7fc6uP1F8CLtby4TCV000Ca2bo93BBfXzEs+rdsFjj0aLC7Yw5v
 eR1VQX9jh/wGDObA6v4Ytk0kwZIjg68AElWSG8T/Qac4jMlHF6J1bJMdJI5gw4mtauLw
 hpp5kZVRYVt/TcAWWvEbytCrcSkN6JkKjsSrZcsdZPCDIZ26qCuwrg5KifRJdszOwGXu
 aCGt9pTed7+Gsq37rETOrpZE0vnoupWGvU9zAElPXvnkTeqIaJ0398Va3UPx6kEjVaKQ
 pEZxTMkHyuEr6IyJgrMj+SBlK3WZvGsIshGU19GyOXbSUhNzH73MHOnTmuTZ3FLpI94L
 WNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794686857; x=1795291657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R7dtlKbfcr0G/r1hntPJsms+e0JAvg0N9xC2Og7VBO4=;
 b=tiB3coHe8/95LKkSB2KT8qKew2ehWvEGgR81QcHnkkdz5qVgl2mnwsoT15NQpu9mJr
 Np2v+BiBz5QK9wwszkE/jSGz4v2keeoWsz+TY1OxwvnAKxzS4Fj/Kz+koyfGt+ti16QF
 Mnjo7YdDP2FKAQ1JiTznCc/2WUg3fCz8y/0LYuE8nijP4S1NoK6N7wsGxzP3RWxQKIkt
 BjgwPO7gBtz/ivReaoEtQnH78xMpYRHbuAdrnir5dX99bBzzbdg9O7JUZaZHzmEvMA9b
 oC7IoDKxneaXlwNgBX9pMOryXCHi4bDDCTdRE2Ni1CU3sprB0GZfq9g8XjX57i40GK1o
 s1pw==
X-Forwarded-Encrypted: i=1;
 AL+hErFzQHeOzRbZ8MMbqU1E05jXXMZ12BMIwbFickDLZYiIwxclp0sCkuLKCGbz+2IkZcmC0ACaOd1bGlU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9GC2U+IY/WMC2m1wPL0vRwqPZoRpFWZ1fWn+ZXxRokKGsBwKIO
 fzVDz7lIemgSEGLQcRhCBHRwhFw4mb+WmF4RaI4+qhddVDDoCvA8tVU8
X-Gm-Gg: AYBFou13y8SwTlqBLXpGsfMdTKcJVW+2TBH+TLVP3yx0pEkhg7QDizL2Ch0ZsVlbI7F
 EGcD+c1VSSDRdMTOLsDL4NQbRR3eqf8IhArP06If1of7HPGIdQtrFWr90Eq9walcIFsxDkFZpgb
 uxXyZKC9baFyn7HtxfR6Rs8yYLqZEtQl0qtQKKI9LQaPItygdiir54Uou13PNVa6/Wx01QXZfR2
 OM2emN77P1BUe5yVJ3+Iq9gz9QgkxUWGgzMdx1aQ9R6A3yeu9T9hM3YySaoiS9IzplrZJVOO2Zh
 0aNxPEan3HINqYwsSiwX+hDCkQz164/AesZdiHFzOCccY7BS7QLmhEpktAOQB2h0JJVHLWmzGYW
 xw9/VzLplCtCJm06gfuI7jpAGjJhy+brvgP2po6JUDxATjEI0iSyKsyXG5lQOADzGxbKqZWRMml
 /SA/uP9X409c+t1fkCKtFs4VKzh66AdODWJL5wqoeXMhF98pe5JiUWAZBAyxmpO4qtNJ2X7RNGs
 Am6b9qR21384dYnBtpW1ik0OoMIL34mZgBVLyFedKS9SLbz8nFzefVRqtLVq+9R3pdhAVxRFlEt
 xYQQs4dnFQHPxDT0Awbyikt81Gcl1lI4pdRgp4A=
X-Received: by 2002:a2e:be24:0:b0:3ab:4e70:6959 with SMTP id
 38308e7fff4ca-3ae1c0008bdmr24199811fa.19.1794686857016; 
 Sat, 14 Nov 2026 12:07:37 -0800 (PST)
Received: from IuseArchBTW ([194.28.181.64]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1712da125sm1891070e87.1.2026.11.14.12.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 12:07:36 -0800 (PST)
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: sync: lock: allow fallible initializers in Lock::new
Date: Sat, 14 Nov 2026 22:07:00 +0200
Message-ID: <20261114200703.33229-2-mbkchelofficialdev@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114200703.33229-1-mbkchelofficialdev@gmail.com>
References: <20261114200703.33229-1-mbkchelofficialdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently Lock::new() only accepts an infallible initializer for the
protected data, because impl PinInit<T> defaults the error type to
Infallible. This prevents wrapping a fallible initializer, such as
Opaque::try_ffi_init(), in a Mutex or SpinLock.

Make Lock::new() generic over the error type E, so that it accepts any
impl PinInit<T, E> and returns impl PinInit<Self, E>. E must implement
From<Infallible>, since initializing the lock state itself cannot fail.

This is needed, for example, by the GPU buddy allocator, which has a
TODO to move its gpu_buddy structure inside the mutex.

Signed-off-by: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
---
 rust/kernel/sync/lock.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 10b6b5e9b024..26c071088b02 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -128,11 +128,11 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    pub fn new(
-        t: impl PinInit<T>,
+    pub fn new<E: core::convert::From<core::convert::Infallible>>(
+        t: impl PinInit<T, E>,
         name: &'static CStr,
         key: Pin<&'static LockClassKey>,
-    ) -> impl PinInit<Self> {
+    ) -> impl PinInit<Self, E> {
         pin_init!(Self {
             data <- UnsafeCell::pin_init(t),
             _pin: PhantomPinned,
@@ -141,7 +141,7 @@ pub fn new(
             state <- Opaque::ffi_init(|slot| unsafe {
                 B::init(slot, name.as_char_ptr(), key.as_ptr())
             }),
-        })
+        }? E)
     }
 }
 
-- 
2.56.1

