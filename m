Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F0210854AA
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 23:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB5510E103;
	Sat, 14 Mar 2026 23:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nGI4eXpV";
	dkim-atps=neutral
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51EA10E103
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 23:28:01 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-38a01c80c34so28141761fa.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773530880; x=1774135680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jCtEmGh8LeY5ZVx8BhZuufdcg167qUrzjvmKMxMMtZ8=;
 b=nGI4eXpVmYa10ZBFpCOsUNMa7ECiV5yOWWF1f4rpWmdBy+hIXRfBp51RgViMckRcI7
 Mszr5JYQHVmgWSdLRFsgCQ4usA08K4wmqm7tJkQVfjO4msyF1+dY370g2yhF4S8fg3dD
 E0iY/3FWMfWa+IKQUJY+KRhsVoYjO2WQ69y3a1z/sLMzXj/QtymHZviSo05wkXct1kKe
 J9AuTzGlG0HFTaF1Wr9k91l8PBadKjdYYwqkg99G2nxXji87uOmJWffBDBVEdydSiEe+
 7mz7mEK0kjL5aGzxg6Nje/yU9lLUq2Oww1O/XvIpi88lAMunYCgeT8mRaS8U5IrZwuu7
 PqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773530880; x=1774135680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCtEmGh8LeY5ZVx8BhZuufdcg167qUrzjvmKMxMMtZ8=;
 b=mcNNtohXmw/XHBBCDILn/ilnbFJDre67/kvuNgfNGJ247m1ug4vHg73wm4EXeGStxZ
 utdI96VRfJUNb1LnJEAgn/MsYtD+LZlq5OoL2esd1ERrTVrrBlTxaEwEv9TtFXJy2w8A
 GGXYeD4suGzj2sG4PRmDk6yIcF7RxOUcbwZmocz5COxQmUm0VJT3LIA5HzeJoS+QGu0i
 PnWYBsDJfX4WReCugoVjEVShh+1GCxagWKzA7SoaXrmxQ4Yo6Gty0PDxtvIjhiEj68zn
 QTPeqVH8XsgTJ1lHSh60FpgXdMEM297cPk+EoSYH0Bz61xf7nRmwpU5LS0w2BgppcXZt
 WT/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdg/pdun5nslc/M5IkHQhw948woffHUq54Qmjx9BLd5VVyzswqMWr7FNQsTMxfyThnI3OxjxlYvXU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUo0HaUdLqDy6z3q6XBjq98j6K5MdcNWIqbAbxD8OKuqJPdmnC
 wZlkWIcgC8Xe5WjiV1JRqfgPTmlhi8sTPsOfMMRDnLNeY41SMB/4aki0
X-Gm-Gg: ATEYQzzSyo2ce5zbVNA7WutW/p7O6I85GMkH+57XzfypQP17wGY4F0BoxqmDLymBNH5
 NoZ6h3yjoyPY99jtfGbw7M4hiYlkY1Svwz4RbxM5ZY0kM2wDsdBAje8YpSIQLn2CByp+V5fFcHL
 tVxU27KS7O6/cNMKASCtkoaaSHUOWhC6ATUZ9DfjsLmEINWgevxiVDwI+7nz/sulEwX0wD2Zm2z
 4uTmh7tQ8y9R4eVbl8+cbs8Xjtq1TS8g7lO8AMd9oswMnn/rYGBSKVMYn41sO7J+pmn9K4z9rG3
 eFM9TwHIdq5O5JUEKs13k2v3TMO1Wd+ofSYl6bMDOrjjXzJogYQYgEgOY9S6H+L2+xD8B9ya3Xs
 36psZR2yUhbwFHXVE/krr9VCamAdkxyzzSlK9SpuvRQyAEBlFRhdodkKOgmz/qpHqU/Pyinhk3N
 D5oGqyGc9IPEbhCPiebFm6r9N25ZBFCcIdrw==
X-Received: by 2002:a05:651c:4083:b0:385:bb24:d0eb with SMTP id
 38308e7fff4ca-38a897b7410mr17019691fa.34.1773530879579; 
 Sat, 14 Mar 2026 16:27:59 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67d9a4b6sm24308881fa.12.2026.03.14.16.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 16:27:58 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: kraxel@redhat.com,
	vivek.kasireddy@intel.com
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, stable@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] udmabuf: fix DMA direction mismatch in release_udmabuf()
Date: Sun, 15 Mar 2026 04:27:22 +0500
Message-ID: <20260314232722.15555-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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

begin_cpu_udmabuf() maps the sg_table with the caller-provided direction
(e.g., DMA_TO_DEVICE for a write-only sync), and caches it in ubuf->sg
for reuse.  However, release_udmabuf() always unmaps this sg_table with
a hardcoded DMA_BIDIRECTIONAL, regardless of the direction that was
originally used for the mapping.

With CONFIG_DMA_API_DEBUG=y this produces:

  DMA-API: misc udmabuf: device driver frees DMA memory with different
  direction [device address=0x000000044a123000] [size=4096 bytes]
  [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTIONAL]

The issue was found during video playback when GStreamer performed a
write-only DMA_BUF_IOCTL_SYNC on a udmabuf.  It can be reproduced
with CONFIG_DMA_API_DEBUG=y by creating a udmabuf from a memfd,
performing a write-only sync (DMA_BUF_SYNC_WRITE without
DMA_BUF_SYNC_READ), and closing the file descriptor.

Fix this by storing the DMA direction used when the sg_table is first
created in begin_cpu_udmabuf(), and passing that same direction to
put_sg_table() in release_udmabuf().

Fixes: 284562e1f348 ("udmabuf: implement begin_cpu_access/end_cpu_access hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/dma-buf/udmabuf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b8ecb892bb..d0836febefdd 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -40,6 +40,7 @@ struct udmabuf {
 	struct folio **pinned_folios;
 
 	struct sg_table *sg;
+	enum dma_data_direction sg_dir;
 	struct miscdevice *device;
 	pgoff_t *offsets;
 };
@@ -235,7 +236,7 @@ static void release_udmabuf(struct dma_buf *buf)
 	struct device *dev = ubuf->device->this_device;
 
 	if (ubuf->sg)
-		put_sg_table(dev, ubuf->sg, DMA_BIDIRECTIONAL);
+		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
 
 	deinit_udmabuf(ubuf);
 	kfree(ubuf);
@@ -253,6 +254,8 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 		if (IS_ERR(ubuf->sg)) {
 			ret = PTR_ERR(ubuf->sg);
 			ubuf->sg = NULL;
+		} else {
+			ubuf->sg_dir = direction;
 		}
 	} else {
 		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
-- 
2.53.0

