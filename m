Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9DECD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 11:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8597C10E352;
	Sun, 21 Jun 2026 11:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aitks8Ps";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972CF10E214
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 06:30:11 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84231305a80so2045262b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782023411; x=1782628211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W6tpylLWP859Y5GaGz8xWvHuAS1IpP/+yGasAke1UnQ=;
 b=aitks8PsZVd8q7Xm+vb39+YkKjbcxjRia6bg5w5uqmGvddniRGcN9to4k3gFB4Kg/M
 SPnlJOkeuYWg0tYpw4K7u3XHJJgICrYY75h5clfWtpTfJEH6jlLCQvwFA+invSwjYymZ
 gVgPgSRMLcUka3IEZX6S8r7x4JzlBAqkkLOUJbPspRiQBobGzddcLqGdOtCj85vYRplw
 jMOcuFpkeZW07Ed9ljjvCJM9TeXRMdwKFSAAr20bmewiVpmp5/19jKVYTJhn5exrqd2X
 BX5U/ao0lhwDsj1OHujDVpSZGIAgttAy8ED0IlSb7EKI6aNmWyKH3yAxTmOu+ExUWQi2
 edXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782023411; x=1782628211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6tpylLWP859Y5GaGz8xWvHuAS1IpP/+yGasAke1UnQ=;
 b=ZgortvM1KirrJ38E9QKR6ibc7hI7W2iw0gRup/0lU0X7qF1q94bVe9wPw2hDo8IWLS
 r08pA8pxZSs6Cc/AgsiSDGLGKT8acDOeNwnAsQ2eDCawkri5OAmz+sQsQKC26wFU0QIa
 uwfRQ0asCQoFUFAEplyFi2nRKuV3gLNd6YxSsqf0dpuBe7+RCUXfG/iBsDylDNxi+zRb
 xM4NOZu8avTQ6YPz2tmBYIKkLvCffS/kEfJn+l9D7RF/QVACTp3dVA858C5Nena0Um+s
 UC7+Do4zY9W8yJu09LgNHuq9WPJGD9yr+7yQHdDmq4z/1xRBD6yg536vKS2RKw2IDu9K
 iq8A==
X-Gm-Message-State: AOJu0Yx19K+1aY9DAOGpMBeGSYiQnUrqPhdf1wCsSSsAdpCEnlKZpkig
 hviQ64YknqkgXpTsfJq0hpGKlzjrQlYX/1sv4ycTNGjLylPTDzTD9pg3
X-Gm-Gg: AfdE7cmjN+anMdXlenlkE8NnsVsRXypEVTfEV/ZYB1v4lgK/r76BOjgDQXfZ6rsWBn1
 Drj2+xbZAZr0NKAq8Mp0xdLxfTTmyVrfo2BDQknv14G8hKXlWQz333kni670c+ezjnFUd767VCC
 eL0TXn8X2ea5JgFBI1GFEj0EyAAVF0PEovvDPlH7xUe9EQoPnYXgcYLCICgLbIqtqAvQU9tGDUg
 ZyNB5va4Ol4ehj5Xnh8rxfJKrn6BNLTeMuPh7v4s2x3cjh5tRmEyjPd0lg3VtE6BVwP6PVNTzsW
 zFYgnilLsQTpzHaz48756zpyu/dqSSgy6prm74ts6dJ5EB3ZNB7JlrkmX2G44YzpM2jUrkDHETK
 iy5dcvf1cSxR/Vehj7B95dUjc4WpcPvxdseXgfubLnhemwANYDLOsnfrOuKNnP0iZpUEkbuYPxQ
 QXMkzg7azVIwY4MLWrL9nCYPYSl5NgTc6X7Vw1l9tVZA==
X-Received: by 2002:a05:6a00:2a0c:b0:842:5d9b:d590 with SMTP id
 d2e1a72fcca58-84550887d3cmr11687574b3a.30.1782023411053; 
 Sat, 20 Jun 2026 23:30:11 -0700 (PDT)
Received: from kernel-dev ([49.36.101.14]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564e76d3csm3812486b3a.30.2026.06.20.23.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 23:30:10 -0700 (PDT)
From: Aditya Chari <adi25charis@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Aditya Chari <adi25charis@gmail.com>
Subject: [PATCH] staging: fbtft: fix parenthesis alignment in fb_tinylcd.c
Date: Sun, 21 Jun 2026 11:59:45 +0530
Message-ID: <20260621062945.42519-1-adi25charis@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jun 2026 11:39:32 +0000
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

Fix a checkpatch.pl
CHECK:PARENTHESIS_ALIGNMENT warning by aligning the wrapped
argument list of write_reg() with the line above it.

Signed-off-by: Aditya Chari <adi25charis@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c74..d58b12472 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);
-- 
2.53.0

