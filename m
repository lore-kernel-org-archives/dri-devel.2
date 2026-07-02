Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF13C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A6010F51E;
	Thu,  2 Jul 2026 17:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jgkuW8qP";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9BD10F521
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 17:12:45 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so1055545a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783012365; x=1783617165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=STd5MQvh0NQAJtVTzJOmHeJBNZHmtcn+Q1hAWhkb67w=;
 b=jgkuW8qPc3ghVqzrNXWUoKjSxMq7xjiWHw9tjH/OCUbDDy0K7EEZqX1nVAjjrcVkp7
 9ZgwuWF2vy+a4bu0TVpy5Y5bOnwCIOc11sYr7nK6Xnia/QFAbeCEPglmiARWKtPT33+U
 SlMPNDqy4/VsWd8y4llZLAJb+eys7rb2yn2PJ+OEoqKMPu0hFXV0OUvIIhxcNMwUioKP
 D3QpYe/FqX4CG+LU8l4piuPavtewoFuoYV4i5Vr3LC7WCH4D3ccfly/xT8xYiTAM/90m
 ruCgesXlLAWn6TLDHiXHk2P8q6mTIEakzvFvmH/Rsc2jiYusT/h22U6FdwKKPK+jIK3X
 T4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783012365; x=1783617165;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=STd5MQvh0NQAJtVTzJOmHeJBNZHmtcn+Q1hAWhkb67w=;
 b=qVexiDSQ1X3TFjlB4gFEVsKlet7IpekzN1Eu6JmJNudtWXdEHQe+kNMDP7/4JE/4eE
 K2GlRGqBXdJekNsG64Xk5CUM6RBvqCHooRH2ZgUpk03zhKRvZzH5FglXIwfu7wHvt3zq
 40/31vrkLYTyDBm268BHc7GpA0DAUCodvoxnvGy6pbBafLeSwEuuizM3fsvicFL9Nrx/
 aQZKEvou4g5gvDBXgQMNSD858b7qYFyKB6RhxgzbR9J0HoeEcprTOAUp7n9OiUcrwkbR
 udOoPzmtVV6R+Mawg+Eb8gdJYc9KYaQNN51g1RT1i+Q3tMyVnjV+cD3mU1keop2hZfCm
 NT/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iqryCUlVRnpetKXH4JgaYZgkhDGP4DpSfNYc0gEKQOz3gxO1g67ifVjqGWl0XoYB4uWrKwEIaA3s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yza1q1Rgiu+51yDP+J4w4fwwOdI6cRpZSstfYhsPL1un2vOEcdC
 ruJVqlApxeBMYXtY8KCg/UIDQP0LvHkD8kmippYLL5I60tMPw8BKJlA=
X-Gm-Gg: AfdE7cmruGCV3+0bWD/ctv681KeJezl9UgjWCrn15AHsTR9mWz10sMODM16kLSfb9Vt
 uiY2bc3yaZiHu8MW2p0CSQob7z1rugEGv8R/gYym28XjM+QvCkiSgCr+BqzkM8FKmEtq3p4jgyM
 Mc1GCd4yj6cd/mlJrPNdGthbY7fxjaIX4XHFwktSNbUaWrdOw+UUnKfKA8+eOFxnev0ITUYC51o
 aqvkafNaou8ekgiJGpzfV2AFnZvPVYP+Bnby4qvNb5LWTMzWZtjKK+9uTQJfz13vJ4p0wgpKgM8
 UAF6V5EqQlYskHd7fcqyQVnG0x/ebiZ5L3Bwd7EeW22x4F7HxtPZ05v9Y1jXFl+OiHdrPySLt7p
 UuBqYQT+a5xMKo2wX6tgmqiQEv1b1+tk5mGft95zupWAg8nFpLQMEUWrseUmHQg8jzFNOjJmUkD
 GvNXjOMtkqdjMRTbBZh8qsaISVnCAorMrI6n2SeP7T7Jyt++4CqmCmcp2BNiGspj3s
X-Received: by 2002:a05:6a21:d84:b0:3bf:7189:2d1f with SMTP id
 adf61e73a8af0-3bff422a1c2mr6819657637.31.1783012365278; 
 Thu, 02 Jul 2026 10:12:45 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e8eb0ef50sm1644370a12.6.2026.07.02.10.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 10:12:44 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] dma-buf: docs: remove invalid struct member
Date: Thu,  2 Jul 2026 14:12:31 -0300
Message-ID: <20260702171234.31030-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
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

In the structs dma_fence_array and dma_fence_chain, the field 'lock'
has been removed, but its documentation comment remained. Remove the
stale descriptions to clear up the following kernel-doc warnings:

WARNING: ./include/linux/dma-fence-array.h:47 Excess struct member 'lock' description in 'dma_fence_array'
WARNING: ./include/linux/dma-fence-array.h:47 Excess struct member 'lock' description in 'dma_fence_array'
WARNING: ./include/linux/dma-fence-chain.h:48 Excess struct member 'lock' description in 'dma_fence_chain'
WARNING: ./include/linux/dma-fence-chain.h:48 Excess struct member 'lock' description in 'dma_fence_chain'

Fixes: 5943243914b9 ("dma-buf: use inline lock for the dma-fence-array")
Fixes: a408c0ca0c41 ("dma-buf: use inline lock for the dma-fence-chain")
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 include/linux/dma-fence-array.h | 1 -
 include/linux/dma-fence-chain.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index 1b1d87579c38..0c49d7ccefb6 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -28,7 +28,6 @@ struct dma_fence_array_cb {
 /**
  * struct dma_fence_array - fence to represent an array of fences
  * @base: fence base class
- * @lock: spinlock for fence handling
  * @num_fences: number of fences in the array
  * @num_pending: fences in the array still pending
  * @fences: array of the fences
diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fence-chain.h
index df3beadf1515..42289f505164 100644
--- a/include/linux/dma-fence-chain.h
+++ b/include/linux/dma-fence-chain.h
@@ -20,7 +20,6 @@
  * @prev: previous fence of the chain
  * @prev_seqno: original previous seqno before garbage collection
  * @fence: encapsulated fence
- * @lock: spinlock for fence handling
  */
 struct dma_fence_chain {
 	struct dma_fence base;
--
2.47.3

