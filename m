Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6B606A337
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dps2u7tP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8773910E56C;
	Sat,  7 Nov 2026 10:47:47 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4047510E56C
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 10:47:41 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so15005685e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 02:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794048460; x=1794653260; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rW6VoKT52yP08kYUcZyVOPG+H41QN9/GqRijZgl3S1g=;
 b=dps2u7tP7ZSZQGW3sJIMKhMNFSXYolpnL7FsQzxdwfn2kU6Sy2G61+X+w01QWBO81U
 AbOTbSpXTAMBnLPhr6HURfTkFFumtZUuMlmWH4zu6aaNrFyb1wUB37IVN/AUjvWyHcHL
 Sk+Ml/vlgfaq864YFshysRX0aEAKA2+A07+/a3Q0UdbjpqeP/cJZ121H9dGpy41K4+zH
 CYwZTqT6ygCMeXXlV+Beg/1sOZhu+KTc3rKvDH1iuBA1AbCZmuVuD6XssQfC+U/NPJIc
 IMh9/Kqe0wcoIalFEvk1wryJ47XZyUqpxSoDvVV4z/7lrbGLxq4PTLIPCVMf2ssUdHIJ
 AMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794048460; x=1794653260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rW6VoKT52yP08kYUcZyVOPG+H41QN9/GqRijZgl3S1g=;
 b=zK+OdUWipa+M6bx4UrghxmC4PiiG955HXv1hbc6aj8qPwHug5SGpEbgsnRUBhP6qod
 sdiFV0R5sAI3QMH/lTYUuqm5deHdkD+Rly4v2SAdOketPLA91keCBADnNZR79bVVX9Ar
 m/9l+qpaL3s4fwm5d+JaWhWBgVmi7707Utrd69nim5HGsvxhH+nPOFZTBAKZI+36cJEr
 28IeTdyR/lFJuytQXJqpklM0Fqa/+nncXVDzb0gwdemFXsStANuFl93vuNMSbHjqSC6O
 0LdTEWQrRs1GGlSkva0mCs66OI4odi6se+Asz3wf0tY+sJnv0aDddRHPl7Uf4J9DTJpt
 7iQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPPdFMjJGwJ/Fq81CTZ/v+/z8aGmsAKbut03m8VfRWh9XUiJh1CwY8re3CGxZXGWfdH4sAYVgbmQk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Zvcr4fRkTIDL7GtVg07xZDZ7jzCUvkHaZgQGyLdU76TRpdlkh
 foweV7uY755QgWTRuf5/TbJsJQRHVUK5vzkkRX+aV9Z6qszePSM43otV
X-Gm-Gg: AYBFou1fjCAN6CvYRFYuMgh6P3HtK1mIOZN2iJpVdRkxUPmxkw+zT/RNHvmRiRXG3TV
 HivNcLf1eMU05/+mIOyw1347/y6cot+hTEW7q4X/4MfrONYBpB6Rz3yctPUmbSBDKlJxGphyKxD
 sOpzOR/wi2UgEcYY9iUuBBquoIVYs9W/bNmJbfPETWg+nNu4UHuZyEogkdkp0soxF/6ix5KfCWb
 iNWWf/A4JaYpZwZJYnwipvJEr7AJFTKNwGKK2arQLoTz//gMo99RKwTy9fdTcSNGV4z4dBnCCrm
 B7QomcjG3NoNFV0rhUma1EfB0vl/PZ6uxw0GGHE187LDyX+X4t6AfGgvGIwhFEGK+3PEn8zGf/M
 PXFB1nCVYWjOJH38ylYf8QRv2dYBirzQj3AtUcvTeZW7lmJx25uyws0RmP81P1zTRFQZVbgiNwi
 vsfPU1MT2IELOI8Xr8jeZQIY6EjVW6mcUbCRhSwZ1H5uUlIuahAAb+FInQUWBoYdfWlRSS67xFw
 c3vwKFUpq3PmW6QEcMZzu9H8yzeNIR6W7pzrXw3UoaUBV4qQTc7ZW4+ykDeB/MdrqEHwWrQu47O
 MC4xm2z7iw7DiQoGm4kswChijg9yLHsdRwIGpJk51OHtWzKmZf2MBa9WrI5Bmj1LK5p8sfZb/HF
 EFyzBiNIl5KDdJ62HoSV5KcJiN5p2P7BabUVLDowwusrfAXqLUX+XTj3vuAKxJzvoSebK0BESl1
 V00ZnwUZDyyLl9yaHJ+UBz1Cs0wqGLXO7wxsvX
X-Received: by 2002:a05:600c:3104:b0:4a1:fe26:24f0 with SMTP id
 5b1f17b1804b1-4b6df7d4119mr94096405e9.20.1794048459465; 
 Sat, 07 Nov 2026 02:47:39 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de.
 [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795024730sm47935635e9.4.2026.11.07.02.47.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Nov 2026 02:47:39 -0800 (PST)
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
Subject: [PATCH v2 2/3] media: uvcvideo: synchronize imported DMA-BUFs for CPU
 access
Date: Sat,  7 Nov 2026 11:47:02 +0100
Message-Id: <20261107104703.44111-3-kmehltretter@gmail.com>
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

uvcvideo writes USB payloads into imported DMA-BUFs with the CPU without
cache synchronization, leaving physical RAM stale for non-coherent DMA
importers.

Set uses_cpu_access to bracket the driver's CPU access.

Fixes: ccc4c539c05f ("[media] v4l: uvc: add support for DMABUF importing")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/media/usb/uvc/uvc_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f442f..1f92ee96e071 100644
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
2.39.5 (Apple Git-154)

