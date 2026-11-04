Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31977606D82F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=yfvGoJeb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CE110FF7F;
	Wed,  4 Nov 2026 23:06:03 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2634E10E8D4
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:05:53 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKgz22hCmzMlHg;
 Thu, 05 Nov 2026 00:05:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793833550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYLA0Ke+3sJbrc3iCXNlYk5gEYQZ5rzbc6XZp7sWvhk=;
 b=yfvGoJebH28JKMPMQsVH/JCiEMhyoqtPvAY8Gbt8Ga9CNwEzJZKu+MNmnKQj5G4Uz02xJG
 JjacD4dcIHG5ug7EwdPjkeYTkDYGVRyA/DUzNZg9nvFsaW1Fti2XpJeFXfeYqomMIAefiC
 sW8ONDdaKtUExhpynpoV1229aprJMmbwzWQW8OtV1zcZcDa1rOo1WGb56zKC+kzp+Z9uRn
 qqGwYwvHnHavhLPiajHu1iYci6ED1lnPxV5RMJluuyKem57bzWFWjjqK70/tf5Mre5hG1r
 IZr18GIHxSuJT6yr7IbkffK5IWvm7/H2kdp5W/K7Wyc+elakkZ22ZgZKj7kh0g==
From: Maurice Hieronymus <mhi@mailbox.org>
Date: Thu, 05 Nov 2026 00:05:37 +0100
Subject: [PATCH v4 6/7] rust: completion: add complete()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-6-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=2193;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=MmZZ4ucMvHvyA1WZaAxJGpnj2dLJzfqKfaM3nwSeBm8=;
 b=pyP/P9+jq21Mv0otrhPZ0DPz3MFyNxl9Rh6bFJWXXhoVdMrdZKY/kGOoGzZo0ZaKrY0g6khwT
 sVdnHOvErzsCXGCrbB+iv7N6UQIVJXcwWrZ4Azh3Qa4ghCqCHt4f/O0
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: uaaqrdsaeogp4g9cfjedjanh4h8yuiq3
X-MBO-RS-ID: 133adf3694a61661133
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The initial completion abstraction only added `complete_all()` and
`wait_for_completion()`. `complete_all()` marks the completion permanently
done, which makes a single `Completion` unsuitable for signalling the same
event repeatedly: once `complete_all()` has run, every subsequent
`wait_for_completion()` returns immediately without waiting.

Add `complete()`, which wakes a single waiter and increments the internal
counter by one. Paired one-to-one with `wait_for_completion()`, it allows
the same completion to be reused across multiple cycles, e.g. to wait for
consecutive DMA transfers to finish.

Acked-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/sync/completion.rs | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index 1771bfc0ade2..d8150b7b0acb 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -90,6 +90,17 @@ fn as_raw(&self) -> *mut bindings::completion {
         self.inner.get()
     }
 
+    /// Signal a single task waiting on this completion.
+    ///
+    /// This method wakes up a single task waiting on this completion.
+    /// If no task is currently waiting, the next
+    /// [`Completion::wait_for_completion`] returns immediately.
+    #[inline]
+    pub fn complete(&self) {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        unsafe { bindings::complete(self.as_raw()) };
+    }
+
     /// Signal all tasks waiting on this completion.
     ///
     /// This method wakes up all tasks waiting on this completion; after this operation the
@@ -105,7 +116,7 @@ pub fn complete_all(&self) {
     /// This method waits for the completion of a task; it is not interruptible and there is no
     /// timeout.
     ///
-    /// See also [`Completion::complete_all`].
+    /// See also [`Completion::complete`] and [`Completion::complete_all`].
     #[inline]
     pub fn wait_for_completion(&self) {
         // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.

-- 
2.54.0

