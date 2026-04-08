Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8991073CA5
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482AE10E3C4;
	Wed,  8 Apr 2026 12:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c6UIdL+r";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC9610E356
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:24:40 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so27531605e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775651079; x=1776255879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hcT0qoIH7xmelj+rFhrvLZcEz9q7W2TTx0LM03Unuj8=;
 b=c6UIdL+rTuuot7TCHaOGO9aDpyLDlD61mJBkn/PGXU+POouznAM0Nqrp6wLg3Td4Q0
 ZG2J5NXiALLWhwhzQA+GCH+f1gFWaa59llr559c1n3e2LhMi5O8y4nExjOW+aForwssQ
 5Lxme7XCrbbLJWq3zzNYjCmP3tHvJS2LyNMUIDxhJU73X9qSwopBGsCYwWiePSLyr80j
 pc8I+G9y9qkt+jdkZVpgXtrytFSyYXaSnquli/m4qWGN8rfuHXJLlAtIT7SeZ79F4a22
 aYSVb8FNQtkztDRUNXiCC9T4lXugb9S4pFwOgTvV8HJbvVD+DmfpFKYIwpsBWR6fg2pK
 lISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775651079; x=1776255879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcT0qoIH7xmelj+rFhrvLZcEz9q7W2TTx0LM03Unuj8=;
 b=mmoE6cjwwevSEjO7iiyjmTYfSX3P4FczcZQQ+F7rtEAhrx+QPCtmIS8vXT9m9UBcAi
 Ywq2/Pv8J7kTriUxtqIrkABFewdCJjINERWb8XTPJbJhxYeUBxdnYkAcojF9pId873Mq
 hp1PU+0bcVGfiGJYztu9tsGots+yJojp5QfBfdhp+jVPa4mLU196X1n1YQqtSoFlXC36
 Y+FIc8bJhofo1RSFAFdchgUyLiTJHgSVdrd30e6NgSW3F8LeO5roKJ3CXs5KeEkIJ11c
 VqGXTal2zgGJQ8DOuxCURIlYwFZgp5FuMAgZf9SKe7JKXnCtHSKaBLolLHbZrtgCrHXW
 NNqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa+pDdrKfdiJNUs4Unvz42/M5W6d+1TZpujjb9g3lso8XEfAOBpBVnZ/3bV18urvR9oQiULvQ2k2U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDrQh0BXouYuCTLaG82HA0YBGFfReWyvFESH3CS8KuXlbjwx0c
 QngNIWcWj/BoPfE4A1WqfXUCACmA7626e2VZ7u3S4LWi9szQ0/4TIESn
X-Gm-Gg: AeBDieu5Z25iibQeiedN7c+uEOB0OOcZ0KYAuZ3ojg0ROCCg85RG8Z3lXNFqv5spJSb
 Rl43VW9Ptm00L/nuIOrfMb49Jpo3LebaD3j/7ZjILJCqFlWf0kHZp1/B4MFUOYFQG8xoQOKiZ+j
 iPHq6EDI6Ep6jocUQHdcBzBLyp+7quVCkPMp9KRjISqU6ZA7mWZAJcVxU3KO4JKIs+qarZZaRWy
 7Ib2G7qns7oca590kHF5sZ+aJj7w8Uhp6iacTYLTXUFxeWe5sWUFN8fnzbHl/xfXkOO8YeKRuXV
 DNN7TF9YQzieJfKJ6lK4OhXlbHOIXPo4fjRUdvgg5Sd+FEZu7Zyudk0Pj4VpkZ2ZFx3fYxY2An4
 Che1nYaKvYutIuKWpCSug/DOvYJPcPE7aNhvm48xIGq0zpOMlPAhpPYWMXfA2w7Ti+sCUVmxy/0
 7tCwfYlOocovxorqm/VY7wSkczZbxq4jouMz4=
X-Received: by 2002:a05:6000:1446:b0:439:dfae:8083 with SMTP id
 ffacd0b85a97d-43d292dbc56mr31451445f8f.38.1775651078507; 
 Wed, 08 Apr 2026 05:24:38 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1423:3300:ad43:2520:7f6:56d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e5890sm57197590f8f.31.2026.04.08.05.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:24:38 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: janusz.krzysztofik@intel.com, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 gaoxiang17@xiaomi.com
Cc: sumit.semwal@linaro.org
Subject: [PATCH] dma-buf: fix order of trace and fput
Date: Wed,  8 Apr 2026 14:24:37 +0200
Message-ID: <20260408122437.1364-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Dropping the last reference to the DMA-buf and then accessing the name
for tracing can't work correctly.

Only compile tested!

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixed: 281a22631423 ("dma-buf: add some tracepoints to debug.")
---
 drivers/dma-buf/dma-buf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 11711874a325..3a9d5113b98c 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -845,9 +845,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
 	if (WARN_ON(!dmabuf || !dmabuf->file))
 		return;
 
-	fput(dmabuf->file);
-
 	DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
+	fput(dmabuf->file);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
-- 
2.43.0

