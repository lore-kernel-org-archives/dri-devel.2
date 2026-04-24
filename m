Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024EFFB44CA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640C910F386;
	Fri, 24 Apr 2026 07:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ndDyehQ6";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168CC10E118
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:48:31 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2b788a98557so28454425ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777009710; x=1777614510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
 b=ndDyehQ6WZSYgcwbB2JjZR9yEq0HOU/Ed3bnDJwaO7LGN1LPbknmutHf8WbAbJ/bwp
 p5ICWuJB1a30shBs80Wa1mHyEqFA1IDf4PPMV2XBOvv0nvbUD4xYOs6eAPLr1BmZk6WA
 IYTda9rzL5uEpa2Vgh83czsQssALk5TAcKjyrYWTNfX04tMMZY4ImfNxE5kbWPGhAB1T
 /EG2orf+iHnDUZo/bf5jt5oIAV7u3+etfsLGVOo5Qh17PSiO3NrwYHnrTJU+B/zrJs4p
 3lFbJe7iAN0J7YeJzbjzcO8Yle9DHEr+UqNUCl/2R+EhDHfmCeCi8B7C7NMuGg38wwuh
 3Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777009710; x=1777614510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
 b=T1yikZztK+Y5KGnUkmdKxFyrnGgxMnDvGDtqtFgp04S9J2CeW10oux/Y0E+N1+epbk
 yuXoDq0OmOe6xWJ4HNcta7ky2G7kYUWg5VUaZPpvzTQRTbPnhkAfi7/UpU5lMKsPnfq5
 w3ECaWPa9FOvGBE8Yj09F9sl//ju6+KnmMFr5zSsT5y7VTYcIWgRWTcRJHlx9SS1JmTo
 7TOknllPbL9XbVadIiFMLEr6Pdtyv39JfEOptl9DgrNI1DsVqIjOfPa0YXIwPhsQ4Y5F
 SaCCMYVYdo8wX2M5PotILeF5ady4ON2FWOekYg7pFIfiRcw4sbrOzRvkq5u1dyTqcJ69
 PKIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ85v0LGcXQAKCBzIMOpoKAD3PgB2Y2k3JUraUtp0VSfN9Jj37yd+JUgG2VetT6S0EA0YcTZeOuNB/s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLor55SCcfAnr6+4MlUl6PUBLeffebUfyl9oYA/Oa0gRrB/xFz
 PWdNZ5GNrqOujSgNpvE2IJ6BfL/PpXGAMkZTIjjqcryHpyTZOHE3ZHsm
X-Gm-Gg: AeBDiesu4DvEfYlWi4+x3ghgblNuU0EDuGIyE9To01jmNaEwfXMOVu9WtD030mNi3cW
 95Uosy4KS6GOLZyzQYc1FSrUodNX48p6h14wz+PxiggVQr8eXUoOUSj4qn+K9EN4l93CFZUvHU8
 DzUdiuHiqPJSH4gxxpz2LQ3LvqRv8Fvuyrj4v6g/VsjKyq8qsw/Fn7ZeajOWGmuyD2axX5tfdiF
 3DjPOzqO9tZKps4eYD3KqSTFBjTonpGHZcgx+gSrFeQ5JdINO2dYU7Ut5qGzAIOlfwcbVh15TRP
 w4fFZLQGtzO5pQvrK6EuMCw4jf3ikeZfisUt/3WAu1m4lUAdNnBvn28lsHiYRdwB50nWONzHkuP
 G5/8p9l4tskhQwzdmPP17nx3Na4p488l0MgX0Iil7FQCX0vyhPMbXtqFN1W7qKdiXa8eFuWHhRu
 4S9qVqbPdNbd4KdJJz/acQXqqSmv190c+t+rIWFWFtrOy2nnRo/PHRvMYBPxafyAnLKpuSbu/Hl
 I5eTvTDLBDbq/4=
X-Received: by 2002:a17:903:1a88:b0:2b2:5ec6:dcf6 with SMTP id
 d9443c01a7336-2b5f9e85f20mr310774475ad.8.1777009710516; 
 Thu, 23 Apr 2026 22:48:30 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com
 ([129.41.58.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 22:48:30 -0700 (PDT)
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
Subject: [PATCH V13 3/7] powerpc/jump_label: adjust inline asm to be consistent
Date: Fri, 24 Apr 2026 11:17:38 +0530
Message-ID: <20260424054742.45832-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424054742.45832-1-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
MIME-Version: 1.0
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

Added support for a new macro ARCH_STATIC_BRANCH_ASM in powerpc
to avoid duplication of inline asm between C and Rust. This is
inline with 'commit aecaf181651c ("jump_label: adjust inline asm to be consistent")'

Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index d4eaba459a0e..3016e9c8d6bc 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -15,14 +15,20 @@
 #define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
 #define JUMP_LABEL_NOP_SIZE	4
 
+#define JUMP_TABLE_ENTRY(key, label)			\
+	".pushsection __jump_table,  \"aw\"	\n\t"	\
+	".long 1b - ., " label " - .		\n\t"	\
+	JUMP_ENTRY_TYPE key " - .		\n\t"	\
+	".popsection 				\n\t"
+
+#define ARCH_STATIC_BRANCH_ASM(key, label)		\
+	"1:	nop				\n\t"	\
+	JUMP_TABLE_ENTRY(key, label)
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm goto("1:\n\t"
-		 "nop # arch_static_branch\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".long 1b - ., %l[l_yes] - .\n\t"
-		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
-		 ".popsection \n\t"
+	asm goto(
+		 ARCH_STATIC_BRANCH_ASM("%c0", "%l[l_yes]")
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
@@ -34,10 +40,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".long 1b - ., %l[l_yes] - .\n\t"
-		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
-		 ".popsection \n\t"
+		 JUMP_TABLE_ENTRY("%c0", "%l[l_yes]")
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
-- 
2.53.0

