Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD38606A335
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ1u1P1R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FD31120D3;
	Wed, 18 Nov 2026 23:38:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBBE1120CF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:38:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A627A4593A;
 Wed, 18 Nov 2026 23:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6D51F000C4;
 Wed, 18 Nov 2026 23:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045080;
 bh=qIoKrmdClUA5c865x/Ce9F4h+U2S1uTOxXSnJVpEh9U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fJ1u1P1RpUtvgnKu+y+bqQmxIFc+y5bNhaguN89w6lsnyDZHAEK2pwhniW0xxNB48
 JbQZtXdrz8bOUFnuUKN0qV8GHVSMMWjNm3fGF5X6tSHheltQWKN/BK6BV1R7pdJc+j
 8p6+yE7SX2jPU83tZm2o0prCI9MdYKminueZ3TjKg4UF16DiXqo8YwxNx5DV8EH+e+
 AnZf+HTTHK8EgJnLZ+HGbDePwUwAJ13lLeRqVmTf9kw37QtbZDK/20Cmh8FrJscw9b
 /K87E+jjH/P6efnKLw0inPaqID26Hh2EDaiq2SqPcV43Fr6slnBAlCijJXGike9hP+
 2OkobLPw2Dtmg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] rust: pin-init: internal: suppress
 multiple_bound_locations
Date: Thu, 19 Nov 2026 00:37:03 +0100
Message-ID: <20261118233727.3147222-3-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118233727.3147222-1-dakr@kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The generated __drop_order_check() combines existential lifetime bounds
with inferred field outlives bounds.

For instance, for Tyr's Firmware, this places 'res: 'fw in the generic
parameter list and 'res: 'vm in the where clause, triggering Clippy's
multiple_bound_locations lint at the struct declaration.

Allow this style lint on the generated drop-order check. This preserves
all generated bounds and leaves the lint enabled for user-written code.

Cc: Gary Guo <gary@garyguo.net>
Fixes: 73cf61724648 ("rust: pin-init: internal: pin_data: support existential lifetimes")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/pin-init/internal/src/pin_data.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/pin-init/internal/src/pin_data.rs b/rust/pin-init/internal/src/pin_data.rs
index 08e11128d353..b3c487999270 100644
--- a/rust/pin-init/internal/src/pin_data.rs
+++ b/rust/pin-init/internal/src/pin_data.rs
@@ -1246,7 +1246,8 @@ fn generate_drop_order_check(dcx: &mut DiagCtxt, info: &StructInfo) -> TokenStre
 
     let struct_span = struct_name.span().resolved_at(Span::mixed_site());
     quote_spanned! {struct_span =>
-        #[allow(non_snake_case, unused)]
+        // Generated bounds can appear both on lifetime parameters and in the where clause.
+        #[allow(non_snake_case, unused, clippy::multiple_bound_locations)]
         fn __drop_order_check #impl_generics_with_field_lt (
             // This must be present so the function can *assume* the implied bounds on the erased
             // struct. For example, if the struct has `&'a T`, Rust will infer `T: 'a`; we still
-- 
2.56.1

