Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3113AC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1824010ED2D;
	Wed, 26 Aug 2026 14:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AjykGl2d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE7B10ECF5
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55D8760A63;
 Wed, 26 Aug 2026 14:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0851F000E9;
 Wed, 26 Aug 2026 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787756214;
 bh=Lqj3WyT4uUSyg5vPTud/NlBT/9oGUsXf3w6yMFvssHk=;
 h=From:To:Cc:Subject:Date;
 b=AjykGl2d0NtadVh1HDftsuRFQVDNwr7fprTrNgVyOS38MibtI+mqw9ib00+W2F1qc
 b6mxzPeBVB4DGNlNu7Q4Wigqad605YQNYt1jJHrtz3XbVRZQ5XjYxGKr7GknQzwOGz
 +gKGJrJjb3pdqRtJOx7M0WJUoaobJoj293QNGl6oUjLWMpoIrIX1WmGBuBPrMoNydC
 T/3PfEq4gNfFLUU/4NUFKOgLuUN8aBNk1SWjm2RK4JkvhYsrSRxKobEQ6nRJ7fdkJ3
 Q+qsM4CLu83UdxBORErr3Pyk+G62haCIxFIXvDE+EEvrE6gPsJQXP8P7H6msJJc6Oe
 6S3GR5crvE3jw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>, stable@vger.kernel.org
Subject: [PATCH] drm/panic: clean new `clippy::needless_range_loop` lint for
 Rust 1.100.0
Date: Wed, 26 Aug 2026 16:56:42 +0200
Message-ID: <20260826145642.43807-1-ojeda@kernel.org>
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

Starting with Rust 1.100.0 (expected 2026-11-12), Clippy warns:

    warning: the loop variable `i` is only used to index `self.decimals`
       --> drivers/gpu/drm/drm_panic_qr.rs:410:18
        |
    410 |         for i in 0..len {
        |                  ^^^^^^
        |
    note: for this index operation
       --> drivers/gpu/drm/drm_panic_qr.rs:411:13
        |
    411 |             self.decimals[i] = (chunk % 10) as u8;
        |             ^^^^^^^^^^^^^^^^
        = help: for further information visit https://rust-lang.github.io/rust-clippy/main/index.html#needless_range_loop
        = note: `-W clippy::needless-range-loop` implied by `-W clippy::all`
        = help: to override `-W clippy::all` add `#[allow(clippy::needless_range_loop)]`
    help: consider using an iterator
        |
    410 -         for i in 0..len {
    410 +         for <item> in self.decimals.iter_mut().take(len) {
        |

The lint did not trigger here before because it could not handle arrays
behind a field access such as `self.decimals` -- Clippy was improved to
catch those cases [1][2].

Thus clean the warning by iterating over a slice rather than using
`take()` so that an out-of-range `len` still triggers the same bounds
check as the indexed loop.

Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
Link: https://github.com/rust-lang/rust-clippy/issues/16631 [1]
Link: https://github.com/rust-lang/rust-clippy/pull/16634 [2]
Assisted-by: LLM
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
One may want to keep the loop in a shape similar to e.g. the one above,
though.

 drivers/gpu/drm/drm_panic_qr.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index ac27e86c601c..4d7eb75a3afc 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -407,8 +407,8 @@ fn push(&mut self, data: u64, len: usize) {
         for i in (0..self.len).rev() {
             self.decimals[i + len] = self.decimals[i];
         }
-        for i in 0..len {
-            self.decimals[i] = (chunk % 10) as u8;
+        for decimal in &mut self.decimals[..len] {
+            *decimal = (chunk % 10) as u8;
             chunk = div10(chunk);
         }
         self.len += len;

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
--
2.55.0
