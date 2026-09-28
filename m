Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A43CC98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D9110E753;
	Mon, 28 Sep 2026 04:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="RU844wVf";
	dkim-atps=neutral
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B504D10E753
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 04:30:59 +0000 (UTC)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398dcfabbf8so7876296a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 21:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790569859; x=1791174659;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F4a/2U6MDyhfh6OctZetk7ga+hEdDkfQe/jf3hv28p0=;
 b=RU844wVfeGz1c2wg1BhbbGYpfA7UGFJYWAV7QUJ/dbVcatku5n84xm1XTn3ihF+4RD
 ED9LrjFkpz/dPJDlegEsnyG9AGkXR2UruPNjJXHvjTM4r7OQDIfW0BWHdGVe1jcrlI0n
 3GK6R1n/lvrNm9dWOdEMQJWBIeFTy7kLDXdtSIR5OiIczHOQ2Pft4KiPFebv54CybAT4
 j4jaSg/aB5SJb7qb2hLgNlKANT+2elucYHePdUyn0yFthDD2S2ZbARG0vKZuooCzwU8Q
 aBrIpcl3fbk/fkmXSloB1PfFhRxmY0y3Bx90FluW1WWipwsG+S4OfuJrNSkSQXMswWgl
 d+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790569859; x=1791174659;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F4a/2U6MDyhfh6OctZetk7ga+hEdDkfQe/jf3hv28p0=;
 b=Oke7XsJ2Vel1JXLy7Mve/eKSi7QBb0oSrdK2tn/8ThaowfVpv+I11ACVnKra68moFp
 h4pJVl9O+iplj3zUjGiKikwiKdLxydYoNFspAbrimM1zJ7a4FY9Fi5dwjA6/5252dvnT
 8aMFy4Vnyu5d6VranuXnuj908DQFhqEUMtwSyYslQbQkXSwNgTpXAgi5n/kmDTkYrEqf
 7Lfz4/o2IlBZb68SZcvoaNtCWNP1I10MS0cNaHxouAVpYcNl9YebenaFoQmQXOIF+QCa
 sDxj/oPpmNP1VmxC69660gRPEAgQAXBlaWBHNWREFjUiPl/xINNCyzX4LQL2nCcAB1Rz
 o37g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5w2SHemZp7JWbX9G+MHZZoSU2nZsMOZA18An/RiS76qhI1vIp0XP4qOMBy7Unf/H2bxKbwf4cXkk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKERSZG3sIhyXN18GCHoNTGWDSg/CSUX19sWV896ssPfvadlUsN
 tn507y+IbIQ5EGuywPZNFkT5Io9FM0lrnbsTYva0WqWM772oX4Yo753t1QT16WSel9dD6EQxNnJ
 H
X-Received: from pjqo14.prod.google.com ([2002:a17:90a:ac0e:b0:3a0:70aa:2cef])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c2cb:b0:3a4:7a96:5209
 with SMTP id 98e67ed59e1d1-3a47a966299mr377611a91.33.1790569858850; Sun, 27
 Sep 2026 21:30:58 -0700 (PDT)
Date: Mon, 28 Sep 2026 04:30:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928043056.1324568-1-morbo@google.com>
Subject: [PATCH] dma-buf/dma_fence_array: Annotate fences with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Mark Brown <broonie@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
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

The 'struct dma_fence_array' holds a pointer field 'fences' that points
to an array of 'dma_fence' pointers, and its element count is stored in
the 'num_fences' field within the same structure.

Annotate 'fences' with the '__counted_by_ptr' attribute to allow
compilers supporting this attribute to perform runtime bounds checking
via KASAN and '__builtin_dynamic_object_size'.

The structure is allocated in 'dma_fence_array_alloc()' which
initializes all fields, including 'fences' and 'num_fences', to zero.
The structure is initialized in 'dma_fence_array_init()'.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/dma-fence-array.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index 0c49d7ccefb6..85e5879e8a1e 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -39,7 +39,7 @@ struct dma_fence_array {
 
 	unsigned num_fences;
 	atomic_t num_pending;
-	struct dma_fence **fences;
+	struct dma_fence **fences __counted_by_ptr(num_fences);
 
 	struct irq_work work;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

