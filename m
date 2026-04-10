Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9D5F44854
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6578810E130;
	Fri, 10 Apr 2026 12:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MWLffC7c";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701E610E130
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:37:17 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso1301429a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775824637; x=1776429437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ObSlHorYoFId3LOZrgQbV492ce1VusgbgOP1QwTrQ4w=;
 b=MWLffC7cqI/CUPcQrvTy1HtTneEP/1ABOy0CHZx9gfa0Zb2n+FtlG6amCI24TXHtvf
 vA0+Q5r99/UsHZxqlz3fASVx7Qk+JhJo3DTn5T93C3YX7W/FdYntsG3ZyLIpEpXOCOuW
 W0enIQqAqI/KfUKqcAdRr56ZyUkdwQ0g0gmpEDF+m8xvtbe3H/QzX2+grkLrC1AANnBj
 iwFTNfq01oZbydO2eDK7WOxXPHl6lmxRiSRgXkPYEOeSqQtMSh2P/9QFoxLC/QTppcrb
 H6KLH8quFi4luZoMPsWQQqYoKutVigNZAsn83ku51ijorbVje7pSL+YIImDNCSeLTNlL
 2VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775824637; x=1776429437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObSlHorYoFId3LOZrgQbV492ce1VusgbgOP1QwTrQ4w=;
 b=TT6Y1zXJ29HxVrCahIUE384PolEEJSF4nNEFrW3KcmNjb8zWQ9eNI6FDxoLc8t2nsO
 nadzvnQvwRxunbOApZnbzoji91d5eUCbTfG6LCqm/OaaHzQBZskb9auEKzuDDxa5lxkK
 SuLQoPGbdVUYcqOKlBUaemq83L+AA0SywjHuf2M0VwyH/XXpCd8ORsaaHL8kqPXANkDp
 PGJ2cGLioohVNZxEsG564edIRhGkx9e1qszAvZboZkuRHH024EQ+cieaqb7g/T903Xx2
 9rzSr9PmkmZf2wEAKU3YdQmPmhkx31BRHfREPeSNey5jTAr6JWfB4LKgCry4lNFJ/Q5Z
 2hBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw4k2XNNZ4CBamnxFG9vLmALxFeMV+uGqrH30EgT6n7GxOciQZ4uup11ID+eFiH35trZYVIXxsco4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDYoxSbQgw/JprnQA8Hvu6nO3aArza6B4ZHkJXcZc0SFMCf4y0
 Hr3/4FP3H4u2fww0NXO8PStTVAEUacuUsdyR4D6A00Hs+enovj4D9TNO9jm1WvOeeWU=
X-Gm-Gg: AeBDievyvPEwQC7hexZB+v1s05grbgd0uz0IvHu4LNzyLqFyVB3QYEjLGoKKEHqS8xf
 k8SkcvOO6i2j3JXeCs66dKJFRbxvMzQzXkNzLjEDqoLnv34sQBZCzjx//mAXHfykahPE7bgYkJ4
 BUkrgZ6W7u3LCfvAUzSTj+UfONNT4l36bsu3W4V4C0h+KWBD0s/qo6GwwG8VgTm1DizTPibTOqv
 iOQYQ3U5yt6QIaoRP2vgydboo4kr01LQv2RZb/24pz1eWOM2GpckfyhkwjXAlJrFDerv8bLkCmi
 1U18CZjox+pRE8qAEOaHSYNLQIVks4kuAtT7NZ7Q6zKVTHbNbIhFkHHCL64tW0DQD4FuXqLP2pq
 S49vNkkbobbkuezfu9sEk1ZDrQkZ6I8phU6Z+A5gvKEAv7lfnSQBMbSnov3bkkfP1ZOOw3LjyYv
 9nOuUV8Zn03OdoQqilykedKZd1Nmer7VmMmR/rJnZKX/pD
X-Received: by 2002:a17:90b:2ccb:b0:35d:a9bb:1e33 with SMTP id
 98e67ed59e1d1-35e427afe02mr3338087a91.11.1775824636700; 
 Fri, 10 Apr 2026 05:37:16 -0700 (PDT)
Received: from nagraj.tail8a2ac.ts.net
 ([2406:7400:98:af5f:a6a2:e126:5ae3:4132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e35155829sm6780138a91.13.2026.04.10.05.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 05:37:16 -0700 (PDT)
From: Sumit Semwal <sumit.semwal@linaro.org>
To: christian.koenig@amd.com
Cc: leon@kernel.org, broonie@kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH] dma-buf: fix htmldocs error for dma_buf_attach_revocable
Date: Fri, 10 Apr 2026 18:07:03 +0530
Message-ID: <20260410123703.937822-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
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

linux-next testing showed this htmldoc error due to a missing extra
line in the comments; add it.

Fixes: be6d4c9e9d714 ("dma-buf: Add dma_buf_attach_revocable()")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 drivers/dma-buf/dma-buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a202a308c079..532c3f14bf9d 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1353,6 +1353,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_attach_revocable, "DMA_BUF");
  * Upon return importers may continue to access the DMA-buf memory. The caller
  * must do two additional waits to ensure that the memory is no longer being
  * accessed:
+ *
  *  1) Until dma_resv_wait_timeout() retires fences the importer is allowed to
  *     fully access the memory.
  *  2) Until the importer calls unmap it is allowed to speculatively
-- 
2.51.1

