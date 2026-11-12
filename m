Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D2606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDLDYrm1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C5510E43A;
	Thu, 12 Nov 2026 16:17:42 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F90E10E653
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:17:35 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-36e2b1db9bfso4310eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794500254; x=1795105054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mhDKZlMmEHbGmu6pIHBH40sOK6sOrzWpjW9y7ZH4h68=;
 b=iDLDYrm10gzxiJZYiFFkzUqhPceivm8rE4Ry8JKlJVlUAJueDdMxBljUJQoMohmYJj
 wTjjspnD5nGpimb1g8UnZQMUan7ZNm60cCUSikiT+btgjKx8hF8jQ7/QuOauBGJ9zASF
 3jEggjUr94fasryRaRXdb7atbAIUYnXSKZ2TSwg1/hByjyQ0ng6tdNftCOOBoTqpCbL1
 GxI+lKO/ebM/mpyrFz1m384nuC+mL3V4SeLk7NfSPckigk/PorZxkq4ymkuyCr0bQhIR
 /SR4JSHQvQkRDGHTPf1flG66iTzxSo587geeStNiT3DG+II+n9gKdvEnZNCukhSX8u1G
 cIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500254; x=1795105054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mhDKZlMmEHbGmu6pIHBH40sOK6sOrzWpjW9y7ZH4h68=;
 b=0V3y+1o/EgEfpKWWLhB0HGYiUZIdb8EaxIV5cxGUGBAMIu6uaGXsioy0lm4ZRf1DQ9
 qUaWo9plQUZNv9dfR2uDhUK1AS5oSbGIoZ18O1ZZoupoh3quJJh1p1j1EFR3A0/Bqe3g
 H7KZ/C/IIX52HXgZFE3X1dNFG0xliWIHRJUAfqgCKKrOc43XMpoxFaRe38/QVwuokr1u
 UU1oo5GMfPstoi5LroDs0qyFgr+UPV1R/w4S0Cc1XCSM5MK2/SWgvY98RRi3iDAsYnNd
 NziqBo5ktrn/somkCvE+jDSDesHUfspYI03ubm9njaf/eK6q5XH8Ec0IrLlSfu7t6GCD
 z5jg==
X-Gm-Message-State: APuU4Z8AWUMPsV8TeRla1v+cc0SxbItIPLLQ/vXsHf9ETKT78+o4VB3w
 1wZk5m3FT2Ee4leFGN6EBuddELS/F67TIssMG2XiqXh2MTH0L2wXfJuy50KVjvAQBWk=
X-Gm-Gg: AYBFou1xWjFplPYNJkB2Xi9wJd0Aa20xMrnGzFD5KLSuYUgkGa7C3BUkgcBMGUfnDew
 DdCMZR+V7OrqPOMMGcnzxyIDdY7guuhrZ56d0WO7OYspiCGACrZSSBeUMDvyPu1diYCg90bK8Uv
 kzwRrYHh6bSF6XclDjFwQIyTXqDLp9olCS7qA4rddxh0DYeVbuPI45gP8WW/npN5U+dC95FNhvE
 I6Gux13gcRUhiofZcVGx1wLNJvg0gIdP+2MOI3oO6aqm/x9VxhdfIhfTb0n5KsG+n1k+mIT878l
 dfjPUR5yoMUeikDEOI0Jvql6qvyDhaY5V/3LZVcFXjywlgySafb2oY80fs9aG82Cj4jZknQNLFk
 fjC7SHsL/riSdNfNBvwq392n6wQEPJ7b0ZhQ30oyHtbBVLXg9mW+lilFyUoS3bm5QnyermlZPnM
 5XxFLCEbzL6YZ7yaQsIMUejW1k8uQj868JXCMbns5RJN8PaYnK1gkXVOe17gf1xlwiPcjOjAjEh
 OEZ9j41x2keyd9JhPgyiiCDAJHY4ViBs9IgygeeHKT4uOzTNQJktcSBCg/12JJv91W0n4DtWpjT
 44hrlo7VpTHuhdrXbYrM/8PXdcQO3HRDTzEgLY6xzA==
X-Received: by 2002:a05:701b:2810:b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1b502f8bcd7mr134216c88.0.1794500254118; 
 Thu, 12 Nov 2026 08:17:34 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b2519sm22781c88.13.2026.11.12.08.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:17:33 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2] drm/gem-atomic-helper: fix fence leak on
 dma_fence_chain_alloc() failure
Date: Fri, 13 Nov 2026 00:17:25 +0800
Message-Id: <20261112161725.41955-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In drm_gem_plane_helper_prepare_fb(), when both "new" (the plane's GEM
singleton fence) and "fence" (explicit or previous plane's) exist, they
are wrapped in a freshly allocated chain.  If dma_fence_chain_alloc()
fails, the error path runs before dma_fence_chain_init() adopts "new",
and error: only puts "fence" - leaking one fence reference per failure.

Put "new" in the allocation-failure branch.

Found by static analysis.

Fixes: 1ea28bc5542d ("drm: handle kernel fences in drm_gem_plane_helper_prepare_fb v2")
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v2: add the Fixes trailer for 1ea28bc5542d

v1: https://lore.kernel.org/dri-devel/20261107165303.13508-1-lui2012qwq@gmail.com/

Build-tested on x86_64: drm_gem_atomic_helper.o compiles clean.  Fix
written with AI assistance.

 drivers/gpu/drm/drm_gem_atomic_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index abef865c5f2c..1e484f26ab31 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -153,6 +153,7 @@
 		if (new && fence) {
 			struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
 			if (!chain) {
+				dma_fence_put(new);
 				ret = -ENOMEM;
 				goto error;
 			}
-- 
2.25.1
