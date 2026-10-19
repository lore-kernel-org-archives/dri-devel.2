Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B4FCCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B53210E800;
	Mon, 19 Oct 2026 07:14:43 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4934510E805
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:14:27 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso12178205e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792394066; x=1792998866; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yk1PIjZ/V5CKGQclQeGzlozEfFu9qAElw/hhv/wGbR8=;
 b=igDgJUC/hIW3cXH0+6AOiClfznrg6hGXzGKUgmxGQVIl6KotXFHBRPMQswEQYiMKIw
 kEfGPw68we+G+GSj1B1T3dYzRqbqKEXxNOtNHH8nINt4rDuN3TRKi8vd6188dXMrVc6P
 qQZLDlXFxd+Y4/ep23t3A0vN5DKYeieQW29x64MOEFEHhSC1AL6TJEOO3CKAaS0ROypf
 9ZcwYpnR6bV6i6qJ1rvzlQeVXwkKgo8f1F3g1qCQ7xExmwDgmGy1LvuODz9AV6KbQgRb
 8mlJ2Jp/jLiJdCDNBRHyGcedX7Qc2g/BRpa2ty/fJy2uBBpkyVNp3zcPQM3c/hmcprmH
 avtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792394066; x=1792998866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yk1PIjZ/V5CKGQclQeGzlozEfFu9qAElw/hhv/wGbR8=;
 b=2QrBnDoT3dG+T2TsuqgUgm8kSq5etFrEljI6u8hdMtNX4mipmowqEXHg6Tl1/NVGxm
 0ZjZCFEck9rbXW8/xlg9HsvZPAtsO/0emfYSaC2eb5ahlj+en0OpIRqC1a4wDYub7QQ6
 AuNxyYNVVEiDr2aN26nFzpdx13HhyBRXWrw1m1RKJwA2ndDpgw2brqi2YSjh45bQaFws
 pTFruxmlIJMAgnNCdPjpmys/qHgQMneebi4uUODgxAxfSrBp3nfQU/Jt0pn52osSHoTw
 2VID5q8oGNDc73TqZd0379mP9/1km9AEK7Zw8eWlareco8mh4JRpi1KkIBa3wIr7yBLj
 ICIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBws0bH81IK+oSNEr6crH6pUdrsaro/HlJWeQ3Em4TNTmu9WfpB07AfmgK+aZ7wqhkkp2GHvHVWjjoU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYII50ns8RhWq8pdgVKqf+4ItBntaHccIRRYZLoceYeSwWku2Yup
 SmbQ5rmMgmSnsSKa9CB53Nsm5KkeTh3A3wWG9476Foqk1br/5A1cav35
X-Gm-Gg: AYBFou3D4OxwCbvwKsUy0+X64g6/yNJH+ztl71K1fMSlLn4JRqzMqV4FRPmCSQDla9V
 MHGHN83nVNm6PYbLVgYUj6Z/z2kQrFoqAa9zLjYiZ9HSEWYJ7NLapGwGF83bEZV8cKlGgzNMCWt
 TklZcW2KSRQidq4nVWWsbuoTMKxrI827wOd9VQ2sU7Km2MJEoPtDzuBbNnuBGxz/HBq9i4+bgGb
 pXG6rKYzI2nBcvkhFtX8xeIOOYeMjQvCfOPVbPETgznjT320tslf9NaqIao5P9eCjizMwDd//OG
 E4nUUCrN/i16xQrlJbfI3r0K2qTg9+kFGMvhTFWFpTMm0yImKqG2/qibRTKSdA3scVaRsk03ExO
 kMCJSRH1IQtJuNG2xHmMuCJFsNSsiG+7nEhqYVNVIRFM56LslDrnpo+jFsy8fkxtiVqZ5TW0Nhd
 XWpHPxoiVDeXcB/4aOAXnAJy/0NQJejf+wCqKVcRbhCFQmXK8GO6U/zZdhi7xjznQAvvMBBaX3X
 d4RTZ9hskcJLaN9CJN0J07SPpnPV6Ktu1dVfxZX87Jnje0jExWEWoP0Vez8UDxM9gGrtSnPRBCg
 klS9TZjETvlYmGp3pvKgl1+D4yIwXx1vCSo+FJx5NcFjguVTWkpRo0a331gYO89GnqN/y9HGsUW
 b
X-Received: by 2002:a05:600c:4f95:b0:4a1:7bae:d80a with SMTP id
 5b1f17b1804b1-4a1d75e3c9amr148966095e9.9.1792394065279; 
 Mon, 19 Oct 2026 00:14:25 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de.
 [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd540bc4sm21559338f8f.2.2026.10.19.00.14.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 00:14:24 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: linux-media@vger.kernel.org
Cc: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 3/4] media: uvcvideo: synchronize imported DMA-BUFs for CPU
 access
Date: Mon, 19 Oct 2026 09:14:10 +0200
Message-Id: <bd42fc312d9a046a9dc943bfbdd3e2b3612f8c78.1792392288.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792392288.git.kmehltretter@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
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

uvcvideo writes USB payloads into imported DMA-BUFs with the CPU without
cache synchronization, leaving physical RAM stale.

Set uses_cpu_access to bracket the driver's CPU access.

On a Pi 400, 12 eight-frame captures each had stale data before this
change. All 96 frames matched RAM with it.

Fixes: ccc4c539c05f ("[media] v4l: uvc: add support for DMABUF importing")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/media/usb/uvc/uvc_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f442fb..1f92ee96e0710 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -247,6 +247,7 @@ int uvc_queue_init(struct uvc_streaming *stream, struct uvc_video_queue *queue,
 	queue->queue.drv_priv = queue;
 	queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
 	queue->queue.mem_ops = &vb2_vmalloc_memops;
+	queue->queue.uses_cpu_access = true;
 	queue->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC
 		| V4L2_BUF_FLAG_TSTAMP_SRC_SOE;
 	queue->queue.lock = &queue->mutex;
-- 
2.47.3

