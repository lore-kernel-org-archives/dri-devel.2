Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108EBCCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 602CD10E7FE;
	Mon, 19 Oct 2026 07:14:34 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D9510E3F5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:14:24 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1011535f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792394062; x=1792998862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZvdzAe+ZkLnBBtbCTReTMkAoyI9rj6E82u0uZ+VglJ8=;
 b=nXcmFfZzEgdu2PK5UkPxjIPModW7sY3IFtG8oTg2Tzid8ODGtH6oX2oXelgaxOTVPM
 vRaVOrIb6xDOE0tVeAE/LhOVdv5XRr4/d8MNUyawpPs8bAXrWcZGTII0ig+DPQ4Xgu29
 dd+fcb2rRJpwC2ClP2b8dkBdBTcpRk3J8Ke+0DvDfQEdVvB+wfLHPycLP/jsOt7iY3G7
 HgWDL14sGZRB50pMJQ6+yE9OOxMFevAhVJ/m+FCjw+AOfNoZ+Cju6He7+rCSkQdDhz1T
 1yCt4MIbCMd+6eb4ROvupzy/JHcx880TKSViw/XEVgSfAJAQtZQsi2rAFWxdqF34sCfF
 PdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792394062; x=1792998862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZvdzAe+ZkLnBBtbCTReTMkAoyI9rj6E82u0uZ+VglJ8=;
 b=BSiGvS5v/KdQHkPpVnMw3V4smB3SZXArFMYBCxLbWOvB+Ot9iQLuVsjBNx3Wdsf6UR
 vgp0EGtPiCA0NxKj5L/u4k65B3hxS6bF5T5+EXo7ugAyUpO9h0SJ/KYefA3kxZIjD/xW
 4zpsy0UQy5MRqx9GqKKjCpEMEH17HvS/e8lFH9hgDdm0FaJOe1hWytSvChpWcq76Swgq
 1C/BF//QVrMNko0Fyrlozt8FD6TpOsx5RFGmdlsY8DA6EE3yaZh8lPHngyjMRssPiIpX
 npRI9A/R1+LxyY69mY7dCI1FMhDesSeiht941XiRjQ74HDQcFatafHDzZdYCnIakNcfe
 UWZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFu3+EamqWI5pqybV9lxosohODSK3IhgxvlnuNG1VGLKdmlSYXIePKDnBorPW8c/DdlYmbeW6txxY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJj1JR8OffcCkQLGFdaX+JFSnie00giSnG/NXRjSyhDWydTSR95
 3gua4qo5n7KxoKMzuywU3iXPk5/4mCK2EkHVlTtgjUocwUPjb1Ephs0V
X-Gm-Gg: AYBFou0q/yz2P+EfKT0iqmbjf8jhE/frNMT6M0S98PEu21Q4+RHoWAZPcouzVb1O4cV
 /B38qHHYPUBo4LrzyNxWbNGRJIMkT6hWFuGhozKyZel4FW2qi1Vt7no8jDTQVp62/RTU7dKeHIx
 7GjtZjWe3E6U1SBssbGMcy4I0rewkz6OrQ0S8yaSKNr1u47ZlfbYM5zz6B6H0VzYoTa2n+1okvz
 sIoEq7LoSufwaBWzQAztVupLHF0b2rh3OyRdkxJCYYsEp8YvTqrLuVTcRl3zRjqGcBil1dZ2ckU
 GIB9YUdJbgIBbgqx+pmheGfFNVCkYr+AWG+0Gbf2kcNzj3mrZZTXyo32PJANN80hnKUHi8QltET
 QRFVlEY48yJrfFlOcbyYdpvvygLDuId79ZK2ynFcyNFMF+Qfg1A13i0GJeSvVxPNmBcKnKYXq73
 pvjk8EDRFHqFv9fjWtvRnzMTTDJbH1F4Cj5XtSSJplZRG2WtGrFvBK4K+lPBTszeQMk4vYznh1M
 mP1i6r08tmHcyPXSU0L5m69b/SHfCY+ivzzkgXsbiiO3r/+t0h9ror6r/t4cRV9WrPd7yyqwzIg
 S2URLCVaiJPz8M6CgcRwDtKAhAkyKrDX3Ofz77kN+6Pi7mmIRuZ24RoYPY//KDfo3D7ONr4qB6y
 3
X-Received: by 2002:adf:e28f:0:b0:48d:f7f0:327d with SMTP id
 ffacd0b85a97d-48e07fc3ac2mr9376404f8f.29.1792394062160; 
 Mon, 19 Oct 2026 00:14:22 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de.
 [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd540bc4sm21559338f8f.2.2026.10.19.00.14.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 00:14:21 -0700 (PDT)
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
Subject: [PATCH 1/4] media: videobuf2: finish prepared buffers in
 VIDIOC_REMOVE_BUFS
Date: Mon, 19 Oct 2026 09:14:08 +0200
Message-Id: <f2258d73562e0ebf2efd793b646706ba0dacb2c7.1792392288.git.kmehltretter@gmail.com>
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

VIDIOC_PREPARE_BUF leaves a buffer DEQUEUED after calling buf_prepare()
and the prepare() memory operation. VIDIOC_REMOVE_BUFS accepts that state
but frees the buffer without calling the matching finish operations.

With VIDEO_ADV_DEBUG, vivid reports:

  unbalanced counters for queue 000000009fa716f8, buffer 0:
       buf_prepare: 1 buf_finish: 0
       prepare: 1 finish: 0

Finish prepared buffers before freeing them, as queue cancellation does.

Fixes: a3293a85381e ("media: v4l2: Add REMOVE_BUFS ioctl")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b0a6084f17573..460eaf4e82f78 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1746,6 +1746,19 @@ int vb2_core_remove_bufs(struct vb2_queue *q, unsigned int start, unsigned int c
 			goto unlock;
 		}
 	}
+
+	/* A buffer can be prepared without being queued. Finish it first. */
+	for (i = start; i < start + count; i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
+
+		if (!vb->prepared)
+			continue;
+
+		__vb2_buf_mem_finish(vb);
+		call_void_vb_qop(vb, buf_finish, vb);
+		vb->prepared = 0;
+	}
+
 	__vb2_queue_free(q, start, count);
 	dprintk(q, 2, "%u buffers removed\n", count);
 
-- 
2.47.3

