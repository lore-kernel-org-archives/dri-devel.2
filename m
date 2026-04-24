Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69235FB44CA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBE210F38E;
	Fri, 24 Apr 2026 07:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UNzIsHYu";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D9F10E118
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:48:20 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2b2d3a9e149so39983205ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777009700; x=1777614500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ox8HNk2ehgX4u9MIzrQAUilnp/6GJtQsHeC9tfe3Lv8=;
 b=UNzIsHYuVpiSp1NyGlGzDJpP6pWQZJehQIrsdrjlyCeCEylnUoOXKt2bVr+nyg2goC
 mnFcJkricbiMi4v0gYAv0s6WyXElZm8bPY0h5SWmNsCC3so6RWz7S9rtBvOOaBtmcq2O
 IdpyMhFA+U82LEnjY/FQul3ePIxgKbrmU68v46oSEloxauIO7K/2YdBauteO0ZDRvmZn
 qljodTWBs0Nv2hAoGC70weA76QnHiutLdi7EmP6vTFRuFaOlP8742tUOgNDCN/AbTHda
 W6RJUm6ssYtA3D3fBNaolKd+byVSb9kS1X2jQZzPmj7f1M1uTtB8jMcSGG+Z7up4dtfU
 Wj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777009700; x=1777614500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ox8HNk2ehgX4u9MIzrQAUilnp/6GJtQsHeC9tfe3Lv8=;
 b=lyqJiXg8xHYL+moj2J9rOi5FhlufKtBQ814qIktHIMKIxs8yGMIa8whuJ9pjiow00I
 Y21/45s4ZSc7cR61/jiRJmju6mrdtRC5xBAmuAXoLjcl8U3pFl0zVbyguTSfJSQ+P5ZO
 a0e3lFz6yD3C4ZjBkeB0RDsX9T7brRg5H1tV5YDFdR2VGtEYHn76t8715/TjCIeh6V0f
 zC/HXLyJhw6nqOMDloI0M9wrHfEdiDGRwLYX79gLHslzZRXnCr+TDyKCP93vy+3LeF2h
 KcwoRgUGSETQMlTMCAnWRon2yPgtXY9TIVC/4dIN1PS50+QNBNs52KVvsPkFV7W3Uj0F
 66YQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HnoHYA//is9/S/EqrDODBvEZWO9pbCkrYkA57le3wCQqGz2EEzyrDeMBgfrhoWcUYc8lHk26y838=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi2peln+PUXVtg6uIYcgsaf1uWq4pKlaUyCph77TOgsJOg0y5m
 ywZ7SdcxwjazdwspIOgFt/oYSvQmt1JFCJxb7BEc1QsSavSXf6l7pnnG
X-Gm-Gg: AeBDievXYQlGhNVAzd3qwspv+Ke8qk2yA9UjqMhY2AEH0leuenLYfcosSV/iQFNVU5X
 N7j1lPsnEJk38WYN4MN4zRpqqZXlehzoNUIpddqDtoQCmqRgF24Fz9/p12g1v/nXk4u0BSAGVTA
 f9nxuU0hhYtsftroiNusieMkiNSgeyyK0HzaZjsVrRuogla4EsXg6YzWyRbHMipNIg/RUbwH93u
 dR9ajvyd4RTtSe+6VxhbTLnx7XiSiM0B01uunz3nOjASZFlINp73VMb539LWNSCkIzk2cZswOJz
 4kkT/bovcGG7enmvsHv1gvlxWIlkhLOetYJe7EarTy7KxJUrIL5bgC0g2qyCVHWWJM85oRgwpy3
 r9nUdF2DDnuBaNDoZvk8Joybf1ZpYqvHZHjhaTd59KRUvl3N36lV3FeBwHg1xpoy9YQBI0Q5itd
 Ngr8BvOpcE9FcWxLb6DoDEuRgNLf0aLuB530PPaY2AbjqPrN3vWUXm7Pt4nVVJa1qfGeWmM0WdJ
 Q75i44UOA/Vxyo=
X-Received: by 2002:a17:902:d591:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2b5f9e18812mr226513645ad.13.1777009699637; 
 Thu, 23 Apr 2026 22:48:19 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com
 ([129.41.58.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 22:48:19 -0700 (PDT)
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
Subject: [PATCH V13 2/7] dma-resv: Fix undefined symbol when
 CONFIG_DMA_SHARED_BUFFER is disabled
Date: Fri, 24 Apr 2026 11:17:37 +0530
Message-ID: <20260424054742.45832-3-mkchauras@gmail.com>
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

When building with LLVM=1 for architectures like powerpc where
CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:

  ld.lld: error: undefined symbol: dma_resv_reset_max_fences
  >>> referenced by helpers.c
  >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)

The issue occurs because:
1. CONFIG_DEBUG_MUTEXES=y is enabled
2. CONFIG_DMA_SHARED_BUFFER is not enabled
3. dma_resv_reset_max_fences() is declared in the header when
   CONFIG_DEBUG_MUTEXES is set
4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
   which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
5. Rust helpers call dma_resv_unlock() which calls
   dma_resv_reset_max_fences(), causing an undefined symbol

Fix this by making the function declaration conditional on both
CONFIG_DEBUG_MUTEXES and CONFIG_DMA_SHARED_BUFFER. When either is
disabled, use a static inline stub instead.

Fixes: 0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 include/linux/dma-resv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index c5ab6fd9ebe8..23c8db0b5214 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -311,7 +311,7 @@ static inline bool dma_resv_iter_is_restarted(struct dma_resv_iter *cursor)
 #define dma_resv_held(obj) lockdep_is_held(&(obj)->lock.base)
 #define dma_resv_assert_held(obj) lockdep_assert_held(&(obj)->lock.base)
 
-#ifdef CONFIG_DEBUG_MUTEXES
+#if IS_ENABLED(CONFIG_DEBUG_MUTEXES) && IS_ENABLED(CONFIG_DMA_SHARED_BUFFER)
 void dma_resv_reset_max_fences(struct dma_resv *obj);
 #else
 static inline void dma_resv_reset_max_fences(struct dma_resv *obj) {}
-- 
2.53.0

