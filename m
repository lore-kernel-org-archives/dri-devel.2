Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00167C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4259810E63C;
	Mon,  3 Aug 2026 14:41:44 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DEA10E63C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:41:43 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so18973045e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 07:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785768102; x=1786372902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gVwi5SS2DhtslphVSRNDsHwdJ8hwzelyA1BXN11cays=;
 b=eIa2d5LZ9mP37/MhQEIp/eY5l6ZbrHZ+v/g13h0BugkWke0alDnYEMIbzvgNmn61IQ
 8p4AxodtKoXq61t3yPSGflSvXSwPD4K9BdySs785llMbOFEGf9DGPpmWOc/+hOWzfYPP
 uBc7claQUR6eXVSecPpWXhC7sb9BYdH5idsaP6ydwTw/LmtuNgJc+LDsUdn6ItN8vnCq
 dSEK+/jRssM9Sx1w9lNxOaS/yDmtWJNx9DPRrn7b4JmAs5PHH4VHdESoQRLN8WfzrbKK
 ZQLNu5htuQ3qYgNfTw+rBEyqtlNZcTAWK6WgKwyaj+vQ+uxwWvkUheGXUTnfpVRFnSzF
 Ru+w==
X-Gm-Message-State: AOJu0YyU5YXFGIuTBqlwXXYGcOq8o4/0NsD12a4fKf6MJVjelbU/4rot
 CRbkmAywSg3d3TYpFNJOuTXq2JBY2CmIRtudYh2PgmzeBzLxppuB6lBQMZkhWg==
X-Gm-Gg: AR+sD127Dvid411YrRnkatC3ijil/An4UCTSdEh0qJPZa/QcF8Erc+4W2LwajrZBAYK
 Q2Ez3mJqwP7ZIiLkjB4Pnu5ZKrHJAOSN+qCNS3gRTFdFVaAQGUFTTtMpSTzkVc3YGHX5xdQdnzS
 rgXqbsByd23n9Ee+xrKnM6yKWV0KsKC3i8T+2haZ34e31WtqGhD25LM7zQSRJyJXQaTA9cXx7Jo
 t9AIgPI4cuXQ+WOFTsRr6Ae3+eAd0+9XNR8o+Hyfzg19cpqjhUM/WaK9cmZ28Dsfs0AuqocQFXe
 wBfX//dzIj0nz83mnlCOA96ClGfhCY2LKwe6aeHET4T5X61mJx927Gg6jfIr1RwLzfAEwA+1SEf
 e3juTID0EOrsWAzNAyGVlHTy518ChwO2JZUo8g+D9vs0gwdaf6dpCjSRBuF1WefIjy0RK1i2LCN
 6cQfEp/zuS8JtgHiYS87r94uC2xfOIJt9iWRkFTnC7gREJRZckpJMcnHKoxWvL+8n9BGiX0e1Kc
 5bm4wfV/8k=
X-Received: by 2002:a05:600c:1d29:b0:493:e451:a9e1 with SMTP id
 5b1f17b1804b1-4980c66c867mr238381095e9.2.1785768101578; 
 Mon, 03 Aug 2026 07:41:41 -0700 (PDT)
Received: from xavers-framework.fritz.box
 ([2a04:7d84:aacc:d760:34ad:268d:e7ae:c44f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498081a12a3sm350878155e9.8.2026.08.03.07.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 07:41:39 -0700 (PDT)
From: Xaver Hugl <xaver.hugl@kde.org>
To: dri-devel@lists.freedesktop.org
Cc: wayland-devel@lists.freedesktop.org, kraxel@redhat.com,
 Xaver Hugl <xaver.hugl@kde.org>, stable@vger.kernel.org
Subject: [PATCH] udmabuf: vastly increase the size limit per dmabuf
Date: Mon,  3 Aug 2026 16:41:20 +0200
Message-ID: <20260803144120.11524-1-xaver.hugl@kde.org>
X-Mailer: git-send-email 2.55.0
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

Buffer sizes can get big very fast, and the previous limit of 64MB
is easily hit nowadays.
I hit this problem while working on better multi-gpu copies for KWin,
where on my 5120x1440 monitor with scaling applied, some apps ended
up using a resolution of 8192x2304, resulting in buffer sizes of
roughly 75MB.

As another reference, with merely 32 bits per pixel, buffers reach
- 33MB for 4k
- 133MB for 8k
- 530MB for 16k

With 64bpp, those sizes would be doubled, and even 4k would hit the
previous 64MB limit.

Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
Cc: stable@vger.kernel.org
---
 drivers/dma-buf/udmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2f94be1df525..8cbba7ddfa00 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -20,9 +20,9 @@ static int list_limit = 1024;
 module_param(list_limit, int, 0644);
 MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
 
-static int size_limit_mb = 64;
+static int size_limit_mb = 1024;
 module_param(size_limit_mb, int, 0644);
-MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 64.");
+MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 1024.");
 
 struct udmabuf {
 	pgoff_t pagecount;
-- 
2.55.0

