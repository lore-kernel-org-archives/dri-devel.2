Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF608606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NAFhL6ar
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2026810E57A;
	Sat,  7 Nov 2026 10:47:51 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040DC10E330
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 10:47:44 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so9714135e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 02:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794048462; x=1794653262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lE3xmFujzdL9mAxvq99OHiv8yHFQXZ5P/LTujcPa22k=;
 b=NAFhL6ardh3dscNAyQbH9SY5ko/EDZnKBtlbd7gyd6GbDi8n1TnrbLWC8A3gPb366C
 zy2Fi6l9wJcUTnjQii6wd5jyngyDT35KDY/6S08h9IyjwatD9xoLg6BaBZuQbwrPMiZ4
 xSRNvM/Z+RT4K2TK7JqOdjUlXuptxTWB7c5jqIH9Jl7B1tw3Zndk/bqJ6ji2075TfZ6h
 L2GCMTYJpRqjgAjmRaxmA7Q3BxQEj6RFGOod1XUu6IsSYA8sRhEptAg/PH/s4DEirWs+
 gXTejPtHcnBNyrmT2o7qyV7tTrwLF5Pg/8FCTo0eFnHk1SZMFuxuAtiFbYraQwPA00nF
 9JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794048462; x=1794653262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lE3xmFujzdL9mAxvq99OHiv8yHFQXZ5P/LTujcPa22k=;
 b=PCsJz5t/SbbsVM4qq2nzbZcFrdhmz5gqc2a9z/yiVPnI4Ii2FkuJvYL6UskGSv2YBA
 fupHFMtjx/bkcnL02Q4SjIvI1HQ0fpa0cE/R6yHnX+sidgx9SG9p3AHLlCu5N0DWJb5o
 ckJJt3XCRj0d2o0DCqZIZEG/GuG0kDs2QtkdQNxL2tRRyBcii1/n1y+UW4m9V1boHMUl
 Bb/fRVEZwFBd+zVyMM+Iku5pqSDdo9aEammktcKukgGqv/vfOE241us50c2J/iihMXxd
 B+a2yuPhD29FKdSYQotp5hEv8IcL+KPjJX4shkxU3Iyiu1YsvHkwxVqCOprqH5O66INK
 64fw==
X-Forwarded-Encrypted: i=1;
 AKwUvByde/Tw5UtD4vZ5B+dbcKmvPeHGPs79TXzdRBCryutHup3r4tBRH7KYI2+hutncDasWcBMqaCQT4Ow=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Tv6Hi71bxwuHRbGot99WlSSGDSztz4TeSaSGg/7Kny2EjZsQ2
 7eAV8mrOaFK8oLHzK3RDeZoXKqB8jvYF0AvP154ZT4cuZ1u7pODhYEiI
X-Gm-Gg: AYBFou1MFrEigzwuYP1CdunIg7euF0/1xcQBLKQ1OU5cqgyW77bZ1F2Hu8PRwRqecQ5
 AxNflQFEeD8qYmwddJctXwJ18nN57zxrBJthZGcFfBgKZoP6uBmN9weIAAvWoHgJludIDoWKnrx
 0sXIzJbqNrUIdzpdHrVGvh1SlYpd6nPukGHtkgg9n5eJaJNpa7LwfhevsURK1eWFnS4RhK0Ri/f
 BaIqRSHdyPxpkPbBq3bPCPQQWdYIKPWSiTfZ0LN6iAE2n3uECG8zoAbjIdoud5USkSjf4XhA9AW
 iVGqEn+Zu7PXs/1CxkqdWHXyHCBVt4MB7FYD8MCjXLrWWx5z6ey2ZNc7jdsLWaCLUAfzO7nBqM1
 NEbNpaR5G+MbpY/R18RKDtfVP7XI6tei4WiNzC+S6zkcLdJLPt12n6F/yc4SFF0jAiErVwFVSxn
 T3Ud8Unifr9vil5I+DnCxc1+2nG5NyI3Pkko2IyJ2OiRX7hvmIiHuD4PIPrfRiMVfvClhR0mVA/
 1trDRgPkn/px1w4o4+VYYQN1jjKUOzFSkUxxtvZ1DSOzzTyHtizdsfBewvASdWEqQAYNrXqW6Kw
 EKMeQU9cUBCRaqTm9vNTDya9JtkTSbW+qylvvXLyHVFoeHtLVATKBF3YxJBNJ8RdtVl0et7PKI8
 KfY0pcCvVrlQCdJKRiswhtaICkcK8Tho8yDhm51qFq7KDGuoK10c79vQw8NNRF8Z2uYGg1FjMnR
 y9madnR7ffH0coF9lrTr5XPUExziynsFuUiJ4a
X-Received: by 2002:a05:600c:3f12:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4b6d82b2c91mr92859825e9.0.1794048462222; 
 Sat, 07 Nov 2026 02:47:42 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de.
 [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795024730sm47935635e9.4.2026.11.07.02.47.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Nov 2026 02:47:41 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] media: vivid: synchronize imported DMA-BUFs for CPU
 access
Date: Sat,  7 Nov 2026 11:47:03 +0100
Message-Id: <20261107104703.44111-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107104703.44111-1-kmehltretter@gmail.com>
References: <20261107104703.44111-1-kmehltretter@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When configured to use vb2-vmalloc, vivid accesses imported DMA-BUFs with
the CPU without cache synchronization, leaving physical RAM stale after
capture.

Set uses_cpu_access on vb2-vmalloc queues to bracket the driver's CPU
access.

Fixes: c88a96b023d8 ("[media] vivid: add core driver code")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
- Set uses_cpu_access only when vivid uses vb2_vmalloc_memops
  (allocators[dev->inst] != 1) instead of unconditionally (Tomasz Figa).

 drivers/media/test-drivers/vivid/vivid-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index c042d92db175..f6c7460cdba7 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -919,8 +919,10 @@ static int vivid_create_queue(struct vivid_dev *dev,
 	if (buf_type == V4L2_BUF_TYPE_VBI_CAPTURE)
 		q->max_num_buffers = 32768;
 
-	if (allocators[dev->inst] != 1)
+	if (allocators[dev->inst] != 1) {
 		q->io_modes |= VB2_USERPTR;
+		q->uses_cpu_access = true;
+	}
 	q->drv_priv = dev;
 	q->buf_struct_size = sizeof(struct vivid_buffer);
 	q->ops = ops;
-- 
2.39.5 (Apple Git-154)

