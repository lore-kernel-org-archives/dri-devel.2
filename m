Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CF210A88D4
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0267610EAA9;
	Thu, 26 Mar 2026 15:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ta/cwOXN";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF4110EAA9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:25:59 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-486fe3b9441so7294735e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774538758; x=1775143558;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=TRXLr70RAXo8+FHVmEWs8dV7AbwQLcCfIvxFvJII8hM=;
 b=ta/cwOXNOrHlaQzjrTB8IPlDgbnvS8fMHkTzeTp7gqk6hAB0oPn8Tv4flcmqFfCzjv
 YrLMPmFNNGVPgHLM4rdCX4dykzOLffvuwwzuvO5GJKRE0g8mMvTUkuRvRiGCe4OJVOP3
 oo3Y+mBg1p54lYLVorYpo/3JnK4IHaMNDEs7tRA5ZShNNjpgPLAQCHfsW7txjep/RkQS
 zsfHfFzy5Z6VSB9ygvbiZgeJKYnKE4x0nEVnfdZFMKl/JWq1HWJfKdGS8BDXyFky+O3A
 qW5Su7lQNIFS/0KZZUgiHMsLKznyDFgkLyhJPhurG80Hg2IfrpICcB17Vhr7eGL3W7g9
 4S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538758; x=1775143558;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TRXLr70RAXo8+FHVmEWs8dV7AbwQLcCfIvxFvJII8hM=;
 b=N3dTbJo5fHtI4XHKpijcXTpDICkPnnQ6VD/y8CMloKng+2Xc1/mNPaEwJMq2NXR7LA
 wPfYwiyotb20QI7GL07fyhM5yItb97HpwSVuArNn30qj3VbIolR0Ns1l8B/HFhoHE1Mv
 8ZbY/KmHkvjtcrSRV+Ht1CKom2ebW4kKy5TTnby02ivddzpsihoCBYgP6YpQSZb/AMjg
 zViZDP4dRv0TfBild8J/gna9AmIcePFqgWj7XRf3bzGlYakTo4zjvRDSjFCEIGKBn2AY
 mfYO5G1TAwXnSRyhFKNYWOtvsEy6FmjuBDLkPRkGyno5vcuEEFucYDeQCvJeU1fXhX4A
 WaGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj/7/T9FQ8kv3tEu1swEOzxqiyRLdjE3MPoFxNj34tAqGD3ZDKJ7RYxLC7idg24Ai5Gdtb5rNu77E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLDSX4vPjQe+R7YexC2As4Zk+58Y4avjZxRjeEWQkEXn9fNUhb
 sGNUf4oAfSdS+1adQaTumkMv8kwWUQxAu4iRw1wLG5+KL2XvvdjAUMrORkMTWIgLhk7Ev0Rg4VN
 8EqONc1mqVh2tYXc8+Q==
X-Received: from wmsm1.prod.google.com ([2002:a05:600c:3b01:b0:485:3ddc:f26b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4447:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-48715fd4d49mr114709525e9.10.1774538757875; 
 Thu, 26 Mar 2026 08:25:57 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:25:37 +0000
In-Reply-To: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
Mime-Version: 1.0
References: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Rb0d3fYWBYxwCsdL+j4AgDBDt8IDEmmK+PtAHQnzXpY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpxVABQ1MmnaCWpuFCvOkNuFq+qCh9E7lIwBmNP
 JarkZt90v6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCacVQAQAKCRAEWL7uWMY5
 Rlt9D/9k9LaV5DFCqqiG4HkStm6j4twKZVLeDzd0bK4acQYAmPrWmkjqPZzPL3Z5Djiu5isTBbD
 bLdGtnQDTvjp/oN+Tw+dc3itubFtz+dNuKNok6PobPQ/mNP0em+nNiUDOa2cjKJJvhyMovZA7U3
 CBsYathr5yE97MOMGRFvabZQD+tNxz/Ti6OiIa2YHhQuS6iweHEMp7Kx8vRbA2Gc/A5kg4zpp8z
 mYVzfb40KzV8a9TJDltGS9dcx8G8ywyhEZ4tOlqLZTXCYhTZDpd0iBP3wcclxyBQfGNJcXUEpjQ
 pWZFbyC2uePK4pTunArp+Ic2Xylq4dryaOHDPjE/AelaSzI5a6AWChAigUcNPuQes8h224sC8LT
 +s/N2B2/ludIZY1o6SnHza+0+p9Q6cEM7ard3HRlKjqOI3U13eK1flleXp+P970GizRVGReIMDM
 cb1klOPijoKVkmyRlGK2H9k4OCcwYKtCp4Cb6ewmG9MrwpbJ/XFC4iZUYO7Gb2+A7DYyOwv4fOm
 xQMt2+i6KfSrdNSnv8yJvubredUIcNayNDug6t9FUa49OcZjCrp7BXdtlGhTW0xIhT4JXRXtxvD
 nWBAVuWc88w4XrBaChU3CoFC6YqUBnJEDZbYhbAUor9vn4F7VCJ51LjTXGswhRaYM6vMb7fKT7R
 35WpQC3rhP3wxIQ==
X-Mailer: b4 0.14.3
Message-ID: <20260326-drm-rust-next-fix-aref-v1-2-7f6f58d2828a@google.com>
Subject: [PATCH drm-rust-next 2/2] rust: drm: use new sync::aref path for
 imports
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

ARef and AlwaysRefCounted are being moved to sync::aref, and the
re-exports under types are planned to be removed. Thus, update imports
to the new path.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/drm/gem/mod.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index ed974bfdc861..6cc441ee5b63 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -39,7 +39,7 @@ impl $( <$( $tparam_id:ident ),+> )? for $type:ty
         )?
     ) => {
         // SAFETY: All GEM objects are refcounted.
-        unsafe impl $( <$( $tparam_id ),+> )? $crate::types::AlwaysRefCounted for $type
+        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::AlwaysRefCounted for $type
         where
             Self: IntoGEMObject,
             $( $( $bind_param : $bind_trait ),+ )?

-- 
2.53.0.1018.g2bb0e51243-goog

