Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED67DCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218AD10F199;
	Thu, 18 Jun 2026 07:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sxYV8s5b";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9E710E0CD
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 18:21:15 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30bc806fcf8so100273eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781720475; x=1782325275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pYk40mpdYuWia4WWcgsPUz1So5Kdav6fDmRlP7pHt3U=;
 b=sxYV8s5bw9uT5L5wi2zoQlRXRhLXOOo17UagaXlcAZefJZep8I+kcT5F4FUWc7knL/
 M4dvWQeDViYEfreJ4GC3vvguqZJdZxGK+jblN54QxVUF06ZLlfjoSVEjHajow6Ir5kCT
 kSEKiHi7dBMWTNh1j29hxcHRCyBD5phok8ADNWTLRlLruTg/HiIGqAfkCVepJIoon0N3
 27696heBkBbFlaBTrN1beXnb8e4Mp12cMXn/QnEcfQ7AiPNfWbSNpLOZqyQA9HHq6np1
 YT3XealPb6HLYAaE7UA5jIOv8cyf71kxZp8anFFS5txBtZ74IS8x7c64BbfU49F9atBO
 LvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781720475; x=1782325275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pYk40mpdYuWia4WWcgsPUz1So5Kdav6fDmRlP7pHt3U=;
 b=MCUsHTvwDMz/J50tYmCM9SLTH5bRkqcBvky0dP3ohlko58pR6PRGvTPTNTkQucPXyQ
 nebKYxbQ1HknCQ/KWxY9FTIEXNQ/Uvp84zvDJKA7ji9mP2YzXN/6RO66xX2t5s7AwG4p
 L0IHiOWIlU+Im1zfbKJ6h2x6YT4HFTCqAB9vemjVyWRtco/BtxlSjkr0pHv6KVSFfQM6
 0cbPkhyq4X0j7KcAiH8kkJhSzy1DAKhyN/oadHdnJQ4fB4rFlpop6n9r40DC+04Dsd1R
 sxy3lLrVZRuTrS2JMHlFdUj9Y9fxWQn3NDKibh5kOCuDr1U9F3+0KJMTucsmyiMGmeCO
 m2YQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ++YzBNryDNgiZB0bLt3KynScyckM+4UonKiiTIdPDCbxvALAWDGAZ7/bn/Wnfzkv6j9PgfcFa0xck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPiL/tj3MYWRX3gMrxptvipUOrYuKrsYdzj4CE09qriix42sSR
 WIdtPgme3PE51a9ALlaWMu7yKXTq85FXazyEVC9xuumeZ0AicaoGDn1a
X-Gm-Gg: AfdE7cn2BjteGCPEsHHjjRk0Do6h8DBHvs3Vl0saD4sF6b6ry2unsjl5K7eywzF+XOg
 QSwaq3hy+y9qxJgQF9V6xMpZ4xHhGIMx7yTBi5IZLpYxSO6goQ5VSmXRcbYwaE2aefYt3BsB0S8
 PMOi++kMYPEGD4+tCImrMPGXLkdKyYeQ63lgLr4vayMWLeoUTimRXsYA/f15ahvjmSBPdH9hT2L
 7SSCWoqpDPkUQgWawE0ZjmkAvK2vM7ee08j/dOlVDlnirBO3ZyzoX2iIGhBZti+ZTW6E1o0Bt9Z
 pCEZd03/asjgdm/IYLV7QsyzMhCh7AHWu3jqrdv6KON7pjFMkJmErr5XfLHfZO0MZMCMlwgFtXZ
 bBv5i9uBTp6F+WGDHlI82AG2MYdYSO/JEbunTcJgRl2vis79g6fv2amJGqM6k3h2aT+1POGn1yN
 HsmCbV8GD7qJUcHuXd6g9QjGez2ctI3cVK
X-Received: by 2002:a05:7300:6dac:b0:304:2eb0:2726 with SMTP id
 5a478bee46e88-30bcae22973mr2899309eec.25.1781720474401; 
 Wed, 17 Jun 2026 11:21:14 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bd23401ecsm3157945eec.25.2026.06.17.11.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 11:21:14 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accel/habanalabs: publish mmap buffers after allocation
Date: Thu, 18 Jun 2026 02:21:08 +0800
Message-ID: <20260617182109.953680-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:12:07 +0000
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

hl_mmap_mem_buf_alloc() inserts a new buffer into the memory manager
IDR before initializing the descriptor and before running the behavior
allocation callback.

Handles from this IDR are used by hl_mmap_mem_buf_get() and the mmap
path. A racing lookup can therefore take the buffer kref or inspect
behavior-private state before the buffer is ready.

Initialize the descriptor, run the behavior allocation callback, and
only then publish the object in the IDR. If IDR allocation fails,
release the behavior-private resources before freeing the descriptor.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/accel/habanalabs/common/memory_mgr.c | 30 ++++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory_mgr.c b/drivers/accel/habanalabs/common/memory_mgr.c
index 9fdd34acf389f..b5b92dbbe5ddd 100644
--- a/drivers/accel/habanalabs/common/memory_mgr.c
+++ b/drivers/accel/habanalabs/common/memory_mgr.c
@@ -156,6 +156,17 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 	if (!buf)
 		return NULL;
 
+	buf->mmg = mmg;
+	buf->behavior = behavior;
+	kref_init(&buf->refcount);
+
+	rc = buf->behavior->alloc(buf, gfp, args);
+	if (rc) {
+		dev_err(mmg->dev, "%s: Failure in buffer alloc callback %d\n",
+			behavior->topic, rc);
+		goto free_buf;
+	}
+
 	spin_lock(&mmg->lock);
 	rc = idr_alloc(&mmg->handles, buf, 1, 0, GFP_ATOMIC);
 	spin_unlock(&mmg->lock);
@@ -163,27 +174,16 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 		dev_err(mmg->dev,
 			"%s: Failed to allocate IDR for a new buffer, rc=%d\n",
 			behavior->topic, rc);
-		goto free_buf;
+		goto destroy_buf;
 	}
 
-	buf->mmg = mmg;
-	buf->behavior = behavior;
 	buf->handle = (((u64)rc | buf->behavior->mem_id) << PAGE_SHIFT);
-	kref_init(&buf->refcount);
-
-	rc = buf->behavior->alloc(buf, gfp, args);
-	if (rc) {
-		dev_err(mmg->dev, "%s: Failure in buffer alloc callback %d\n",
-			behavior->topic, rc);
-		goto remove_idr;
-	}
 
 	return buf;
 
-remove_idr:
-	spin_lock(&mmg->lock);
-	idr_remove(&mmg->handles, lower_32_bits(buf->handle >> PAGE_SHIFT));
-	spin_unlock(&mmg->lock);
+destroy_buf:
+	hl_mmap_mem_buf_destroy(buf);
+	return NULL;
 free_buf:
 	kfree(buf);
 	return NULL;
-- 
2.51.0

