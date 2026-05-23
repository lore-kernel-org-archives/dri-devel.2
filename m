Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBDDCD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 18:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B1810E0D5;
	Sat, 23 May 2026 18:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pWQhCCzq";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDB610E0D5
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 18:14:51 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so6253799f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779560090; x=1780164890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PKrZA3SQ6hneCPeQUwipbEL8KL38eo+epb8OIzHcMbI=;
 b=pWQhCCzqmgqPuK6Wu1fHsw/V1bh0W1YxOETOHEbOKQDnA1JNyPsr++1CK8XciSLYM5
 EmCzfkXBVTJMSAB9jgUmD6yX+Bk4Gp3mEfnoBG2oWt+2hN2dUNTDjm86VFjQrsifamRR
 bwd3WM144I9MiStx5ELBQFlBdlg/4Z0xDS67wCp7uExuoVaNOPcm3qAEXynId9chUltJ
 OuJvOIqEaZJntlDY4YBXY2gKHSBC/5joKR/U6IZ7YiXGnc0coeqwR4P8M3vxC2/JxPXW
 ZIfNtmRW1kS6+w498ZJKDgCsoZYRFGwPo58gbnQQLVVlvC7IZ9x7Dy2frykAlExx+X3u
 pMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779560090; x=1780164890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKrZA3SQ6hneCPeQUwipbEL8KL38eo+epb8OIzHcMbI=;
 b=pqkKNCIPt2gocnYGHQbpnTzl92uBPpQU8NEFXRj0VD4B/BWYC4JDIFJQjJgpZgoju7
 ROm/jsxu3L+UbfgoIuIRoWYce89/kJqiS3ByQW2MoScOOBaP6utPSJPAZhT6kS+kEHgH
 YSH25bZC8P6Q7KouDwfCvG+FPuiqShaIEgpEh6ya5AOIV7Xr2+iqaTrctMFgj486/4yj
 boPhPny1HJ25DGy/pwYlYmYOnYhEEfw5BE0K+ajIeJFlktPHCZ8QuuVdu3svnvGfbsCC
 e1WuUJrZ1lmvPDfxjq/Fyysho+iZOMpzT3SxsK5OLtuILt7Ikowo0MMwhQQq01FAYsDw
 De+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/efsUjNpJRtJ0W80hjpjkyIRpDnMNTU6ZaOwVGq4yAWM730aP1KLNTBrmbFNk+balrjMdMjY66TZQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSUY5df01PO7lUmrs2jjHpad+CJ/w0x4NO5yOcVGeQRSSKqe1O
 8rSDXnCh1a+BK9KtVHrIdFZhap5uQr92pqD/O34sR0xIGqaXCcGaQHCE
X-Gm-Gg: Acq92OGlppsoJkyql5E6gyGjlfyTEJTDe4wDvkSVtUP1F0jbS+HvF0xB9/u2Rk71tAw
 b6hVDGejlXqZt21vFB2JsJxsCvaftJW/TEEDqaF3q0IvEGY07rj5HiLC7oC6vT8k4gX+aWM96rk
 /lrZjZu+IxsOjWEVpazPm7nTGjMT7049p/rldk6k++DafnOR47FBEN8/OkgD4XHRqNwUzdP/MlU
 c7qMSso6stJ3lDh7GvF5Lj1vVVgtrFGWW6tK/D1HCHM2O8nJ7tXOI9SduJPN9iCWnOJBRBGpVUc
 jSwEFn8OhktEmOKFgztDXmKKwxaN4Mlc+B2xWrb5Dnlcv41Oq5p3xLgB+qAJWZFS2r4AEIczK44
 UVuAoxp4A+z9igFuGWQkUj6ruDpaHydf1AMNp9tQ8Up6o38fCWigBOtTqCrkEnKVyG9uOvOAScG
 tNsn1qoqA2SyRT5igwweNhfzr9LjQ9naJ+tHIRvNZIW5j4rqu5DhBhGBQ3I9veHmRCIBk3mfvON
 DZBXCKuZBg=
X-Received: by 2002:a05:6000:41fa:b0:45a:c0e1:37b with SMTP id
 ffacd0b85a97d-45eb389fdedmr13444344f8f.32.1779560089580; 
 Sat, 23 May 2026 11:14:49 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4850dsm13042447f8f.17.2026.05.23.11.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 11:14:49 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: gaoxiang17@xiaomi.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org,
 syzbot+7f4987d0afb97dd090cb@syzkaller.appspotmail.com,
 David Carlier <devnexen@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] dma-buf: fix UAF in dma_buf_fd() tracepoint
Date: Sat, 23 May 2026 19:14:46 +0100
Message-ID: <20260523181446.69525-1-devnexen@gmail.com>
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

Once FD_ADD() returns, the fd is live in the file descriptor table
and a thread sharing that table can close() it before DMA_BUF_TRACE()
runs. The close drops the last reference, __fput() frees the dma_buf,
and the tracepoint then dereferences dmabuf to take dmabuf->name_lock
-- slab-use-after-free.

Split FD_ADD() back into get_unused_fd_flags() + fd_install() and
emit the tracepoint between them. While the fdtable slot is reserved
with a NULL file pointer, a racing close() returns -EBADF without
entering __fput(), so the dma_buf stays alive across the trace. Same
approach as commit 2d76319c4cbb ("dma-buf: fix UAF in dma_buf_put()
tracepoint").

This undoes the FD_ADD() conversion done in commit 34dfce523c90
("dma: convert dma_buf_fd() to FD_ADD()"); FD_ADD() has no place to
hook the tracepoint safely.

Reported-by: syzbot+7f4987d0afb97dd090cb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f4987d0afb97dd090cb
Fixes: 281a22631423 ("dma-buf: add some tracepoints to debug.")
Cc: stable@vger.kernel.org # 7.0.x
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/dma-buf/dma-buf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 71f37544a5c6..d504c636dc29 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -792,9 +792,13 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
 
-	fd = FD_ADD(flags, dmabuf->file);
+	fd = get_unused_fd_flags(flags);
+	if (fd < 0)
+		return fd;
+
 	DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
 
+	fd_install(fd, dmabuf->file);
 	return fd;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
-- 
2.53.0

