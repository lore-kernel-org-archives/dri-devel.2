Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28D7FB44C8
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C7F10E065;
	Fri, 24 Apr 2026 07:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ll3oAqat";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95CB710F285
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:48:52 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso5954057a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777009732; x=1777614532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jOMf9sHPOP+Fk6bUCc/tdd0deN6bifNBcXjhksEyrM=;
 b=ll3oAqatrrnnrKqFdXFzVggFOp5j1rKoZyXhEOgbB9tekJjvzkHNUOmcgAapeUm/vB
 5+rvayjTdbDn7dK3MGJyMLkT+sBmW+TXoVbLljashv+8e6nvALTFMsrn51CdqwssBNcs
 Ee8n+U7dY4r/LoIcE3PIfrL+OJhjFkJAq4JEiPujuDkj2CEY2xaX17Zdum/zGLK2PVBV
 gOKyq+c6adUTbQniM0amD7TKj0bTCCWGf45odtCvCBZGImRA21pChms1OqssoeDwGndC
 T39L5o69XnuCujuWmZ3grhn8lnpgyU2QYr5z0iwiQtGmk+O2YnK2RU1k2BYQnvDj9oJ6
 Yjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777009732; x=1777614532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/jOMf9sHPOP+Fk6bUCc/tdd0deN6bifNBcXjhksEyrM=;
 b=K0wjXah1w+vXc04DxXtIkcNe/btTziUTMLu0DURM6BORPtYCDBrRVgJ5d15K31I6F9
 b4jkz/DzeTVt8R9PM1BYDVfU3FRttUvfw99fIVBVvZFDMky+UExWtn/RB7/X9vyi8Uw4
 GQKCDHZxG7iPDlvh6Pm72KxXNvKTUVafejro4+aVv+mavXD18L6uoI5YUUvb+LzccT48
 PdTQGXFzbR4rzH7rFG+6RroNvGJwm6W3YDOvPxchQHL8f4mlGzwms/n3SHfDya7k4Gec
 PvfIY/o8109bhKj31i9HQ+kCo1ZVj43Jus9ZVGDXZLQItW7q/xCvkAhPJECGlixo8BvM
 /aQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QrnZYlyDwIcHZkVbgTzJtrgpEtZFfsQ+h9vhayOFL0RjPVYd/8fGJDEF97wwQdxwInW8PTKrfcOQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcrfEs574ZuwtYzFCuqRGKranhun0zR/H4108lUu8mD/Rg3o+b
 eb/Eut3LbAWkeexFkIcIXPR0r/ET3vrQxWiRkrpFBUk1UK5qrGV/Ndc1
X-Gm-Gg: AeBDieskHrpu/NJZNKRch88EHWCMJAJaSKTt/nYcdIQ1CXgHUzZ/2yhDcLlVA2wyYv3
 mR1mSWk2I6bhENqONymOSADaDRsJQw3HKzVtvNAdLVgDB3QbHxyBzuFfd9lHW7T7s122OqPUcZJ
 mAX7aSLEGPF3yc6Gq6iTrNrbe6U5tc6+310v/4dhH0XGwI6oFVK5XlgYyDkDHBs/QSeGEYZV5hY
 fihGZt3qoXFx8RF7Fnbt2zBuhr0qV6o0NRBWH2Icnp6xYnNBU22c3B+hOeaa5nORravnusfBiE3
 ybOU55+hPm+nXMQGhwZ9lPsImo9q41nCplshzeCXfnmEQwxLpunzpigD1YWKvWI/mJo0oCVcoLq
 uTu3WyPgs16jytuncLXBFHc5d6tcIEkWnEBdITV9iKkjIsr7DLZIeSxITU4bEcWof6lHTjJy6AI
 ey+EL+63YENUOtxc0F8DX9DjqZFepOG2zXv2o7tyH+59lu1xjbBt/z7RTSi8bVtohL4JWVP1LP6
 VQeWyIMK6hTcwo=
X-Received: by 2002:a17:90b:5185:b0:35c:29ba:bf92 with SMTP id
 98e67ed59e1d1-361403d5988mr33141482a91.5.1777009732009; 
 Thu, 23 Apr 2026 22:48:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com
 ([129.41.58.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 22:48:51 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, mkchauras@gmail.com,
 simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Date: Fri, 24 Apr 2026 11:17:40 +0530
Message-ID: <20260424054742.45832-6-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424054742.45832-1-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

From: Link Mauve <linkmauve@linkmauve.fr>

The core crate currently depends on these two functions for i64/u64/
i128/u128/core::time::Duration formatting, but we shouldn’t use that in
the kernel so let’s panic if they are ever called.

This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
build on PPC32.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/Makefile             | 4 ++++
 rust/compiler_builtins.rs | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index 2a5428a5503d..ee11fba7a03d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -616,6 +616,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
 		__ashrti3 \
 		__ashlti3 __lshrti3
 endif
+ifdef CONFIG_PPC32
+	redirect-intrinsics += \
+		__udivdi3 __umoddi3
+endif
 
 ifdef CONFIG_MODVERSIONS
 cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index dd16c1dc899c..fc6b54636dd5 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -97,5 +97,11 @@ pub extern "C" fn $ident() {
     __aeabi_uldivmod,
 });
 
+#[cfg(target_arch = "powerpc")]
+define_panicking_intrinsics!("`u64` division/modulo should not be used", {
+    __udivdi3,
+    __umoddi3,
+});
+
 // NOTE: if you are adding a new intrinsic here, you should also add it to
 // `redirect-intrinsics` in `rust/Makefile`.
-- 
2.53.0

