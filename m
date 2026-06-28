Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D84C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 17:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B4B10E64B;
	Sun, 28 Jun 2026 17:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tmw4YGfK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB39610E64B
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 17:10:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C8D846001D;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E77BC2BCF4;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782666616;
 bh=6nYMvga0ssJWKkQxp4aI+MtYqo4PX5MQ/2PIAN01I0Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tmw4YGfK0gqhXA5rtgOEyieO/LDY0+H707OOdYE11C/ojkyYTyTL3nrDouMx4lPhS
 fLJENKEGIQUWaKPG7CVtrwhElikdaTkYJSd5RoEeUA23bWqitwfmfhf88GkWQa0TS5
 Rf1jrNWh5SJqRPaNaUQpwE5FzIfKTo2K1FNCnvSmPqvpxlc5l6ydb1ElGxZMNbPr4s
 akAKPTkFu7wo6Q+sXvZn+rL8GdqEoRMt5+BiMteQ/w0VLd+3RXdoyGA+BgAucGlFDK
 hSS+n969ap6H4BnlzVHqitgf9NfbH5TtjLKOwBxzzUvPlah+lXSnciRKi7F0vfKq5Y
 a6JiAeMBHZT0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA14C43638;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
From: SeungJong Ha via B4 Relay <devnull+engineer.jjhama.gmail.com@kernel.org>
Date: Sun, 28 Jun 2026 17:10:15 +0000
Subject: [PATCH RFC 2/4] rust: prelude: re-export `zerocopy::Immutable`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-dma-zerocopy-bridge-v1-2-9a2895ebe30d@gmail.com>
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
In-Reply-To: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 SeungJong Ha <engineer.jjhama@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782666615; l=753;
 i=engineer.jjhama@gmail.com; s=20260103; h=from:subject:message-id;
 bh=0Joli7btSCpMuF0CGmnSjjLbowNlizxBxdLc5J1Eq4M=;
 b=f2bwTmIStE9+jdLSuE6+34IUR9IVAiS5LuzvRuZ9oslpEwm8G7tsJ9qs1YBkr1SYlJqDirm90
 +PqvX+Dh3/CBx0rJrm0SCj7Sa/l0b9LoCNuwdntS95Box1o9sZz6ntZ
X-Developer-Key: i=engineer.jjhama@gmail.com; a=ed25519;
 pk=G5nmjm+RTiWBpyCvc5xjR1b3li/2zipLSMyz+T4fj5E=
X-Endpoint-Received: by B4 Relay for engineer.jjhama@gmail.com/20260103
 with auth_id=590
X-Original-From: SeungJong Ha <engineer.jjhama@gmail.com>
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
Reply-To: engineer.jjhama@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: SeungJong Ha <engineer.jjhama@gmail.com>

`impl_transmute_via_zerocopy!` requires `Immutable` (no interior
mutability) alongside `FromBytes`/`IntoBytes`. Re-export it from the
prelude like the other two.

Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
---
 rust/kernel/prelude.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ca396f1f78a6..3db51c972bde 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -63,12 +63,14 @@
 #[doc(no_inline)]
 pub use zerocopy::{
     FromBytes,
+    Immutable,
     IntoBytes, //
 };
 
 #[doc(no_inline)]
 pub use zerocopy_derive::{
     FromBytes,
+    Immutable,
     IntoBytes, //
 };
 

-- 
2.54.0


