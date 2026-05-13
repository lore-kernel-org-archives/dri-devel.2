Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6376DCD4F3E
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F0E10EF84;
	Wed, 13 May 2026 16:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Dxb+IAhb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A711D10EF7E
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778691541;
 bh=0OQwKbihhL4l6Gg92F+5W95NMeySKGXxSegqXoUTufA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Dxb+IAhbRGLXHKb4n8nGIjtrDyltHEIvjekTkPRW86Z2GKA6RUaJE3QQw2AwE/sQi
 3uZO7efstdUfSccotCcO0DfZ90V6iOZydjg+LtYNWSNqtMIUrxf1dw1WYBshQZq5Px
 8WJUNaVyBBOQhbKl5RUF+zXbARJddyhSD2QaPvwG+LeKuPrHm8HKnWwKrknPI0GWUq
 cHFZG71xu8OM6aS/XvEcoUPjthwj7mYtsDYI2ekYrJ9TR8/9cYUony3b/gV1f5/FAw
 sj5RRjH/6c3nYQb9JEw4D5+FLYZqOs0TqRecReGVNvVpc6fO6KAoAJhoWjRxZtyPKs
 UcEh0Iz3Vx6iA==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D5E4A17E156E;
 Wed, 13 May 2026 18:59:00 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 13 May 2026 18:58:50 +0200
Subject: [PATCH 2/6] dma-resv: Define guards for context-less dma_resv
 locks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
In-Reply-To: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778691539; l=1220;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=0OQwKbihhL4l6Gg92F+5W95NMeySKGXxSegqXoUTufA=;
 b=xilM6lR+4IMUjFkcXTn/tPBSzFs1xaXCDrF+j1zMUf4DsDX6g+1XB2TSR14o+EYGkRBtR2yLZ
 sjpVbTeL/v2DMevUfB8qax4xB2AJGbFboAA/mLo/VyBwtQssRUIMkDe
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

When used without a context, dma_resv are no different from regular
locks. Define guards so we can use the guard-syntactic sugars for
explicit/implicit scoped locks.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 include/linux/dma-resv.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index c5ab6fd9ebe8..e559b1811ca3 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -40,6 +40,7 @@
 #define _LINUX_RESERVATION_H
 
 #include <linux/ww_mutex.h>
+#include <linux/cleanup.h>
 #include <linux/dma-fence.h>
 #include <linux/slab.h>
 #include <linux/seqlock.h>
@@ -484,4 +485,8 @@ void dma_resv_set_deadline(struct dma_resv *obj, enum dma_resv_usage usage,
 bool dma_resv_test_signaled(struct dma_resv *obj, enum dma_resv_usage usage);
 void dma_resv_describe(struct dma_resv *obj, struct seq_file *seq);
 
+DEFINE_GUARD(dma_resv, struct dma_resv *, dma_resv_lock(_T, NULL), dma_resv_unlock(_T));
+DEFINE_GUARD_COND(dma_resv, _intr, dma_resv_lock_interruptible(_T, NULL), !_RET);
+DEFINE_GUARD_COND(dma_resv, _try, dma_resv_trylock(_T));
+
 #endif /* _LINUX_RESERVATION_H */

-- 
2.54.0

