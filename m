Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8780FC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8285210E696;
	Mon, 10 Aug 2026 06:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FAbd/z6E";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEAC10E148
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:25:43 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cace91f112so9878115ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786281943; x=1786886743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kfmNB6Xrai7eTejryQxi97VAY3eGViiWgp3/xoXdPsU=;
 b=FAbd/z6E/9qw4VgBDoLrLZf7xhHLidHHrExsReqEbXESuO/+1bki8b/JFIA/JAd0D7
 zypAlr2aJqyYRlRQR9vrj2FdKWNF/1m854yD4GUOOz7r/eW8xy5cYH0EaXylhjnTyic4
 MVHpqrwXzv5PnwsXEE3LEKGqRjPNaPvHsKnXW+EH4iPQpI+WvUd73Krasq+2JJbtCR+s
 QXk7++lreYOGjM8LHDmgiFnSp4zooragJ7vzpyKU07Brg2BFbFqGAeZ7vjAh8IqXUWx2
 YuYMSpd5rnDUsvHuuOgxh0Y88X0ph8S+SPabt1RDaRKPQWpP6o8x/fc/ufG+ZVXM8gV4
 8Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786281943; x=1786886743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kfmNB6Xrai7eTejryQxi97VAY3eGViiWgp3/xoXdPsU=;
 b=P/Mjshp7KtjCOqUY3lRG9Tpj0ST5K7K3nQHa+pngCNQPix681aGFl6qPIbk0e7hIcu
 gYcB1wcWGsJgY8d/cCm/4m929iKjGAsUNm6I0nO5AIkrW5P586fy+zTFowlObPRPBWF7
 mMWp81SUOtzV6cjZ63JefEwFjYanUe+fqhBKhaKWeoL/P6FNZbZhnZJIJyds9GJID75j
 s8OAUpymWrxBfmDbx59Ozns7xt6VDHsYoCthWU8Ot2vOeafyBgtBE0DPI93ukN1pu53t
 0h0ckEvoKXC350xGpuB1INtcOtEhwvLVjVRKCB0UgKVjERgaKir2MI45/irSBHtZN9nH
 u8Dg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRbrHfh/wcoY5U91bTNIoSJAlUNKIluk1wbVpY9stQovi5GqrkrHwL5I3R0/tIYScJ3ZPMtK7WkjU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxitq9xiukltv3eoDvAsft+3EsMLnP9DWFNl4vEwfntcIc6mYxn
 h9qAQEHRmIqzRVr4vt+qSEM9otDlhSchNRhDWpySPo0oBT82Ax/OEMHV
X-Gm-Gg: AR+sD13B6ceSdp/f4Jw9oDuepaTYns+bua4zHQBSM8201AaAULA2BruoxDagwwe/wJc
 y7PGB0Z7JWYjCQXrh0tgJnq39Cf6lZU02QywUSWyySeiTJAxHQnksM6PLyPGMkbG5jIQmwNo/RW
 39bX1/z6PzMb4xdZEZccTRv628i6ue9wdb4DDM3GOYxdO3qG7+BNCx+aVM4KioYXq1ZUR78Dwue
 A/O5fgCCVaQT212Y89QjtYLm4QfaPOKu4ByXcRdQ0jQmr7KMfVNUf6z5oBOq+pHgTXLWM/wXsXZ
 Mqp9d5f8zXk7KnApcEBIu5ALnglV5EYroMljEMzgOml4OdTvGwJPdDkPldd27YDTF+1gL8gbMGs
 ZGGeiNk5W+lFiDxhXDzcWpHYiapximVoLibjgeZYhVNZmq5Qe3dcY5B3vJHizZy9v8boMmxGPbI
 D9sV5FTjkzH3dviEvdGzQwCiFkCujma1gFhoot/UjAsQ31sIZU7cDx
X-Received: by 2002:a05:6a20:a114:b0:3c3:7cfe:b337 with SMTP id
 adf61e73a8af0-3cb85f88bf2mr37654661637.30.1786281942902; 
 Sun, 09 Aug 2026 06:25:42 -0700 (PDT)
Received: from beelink.. ([186.22.57.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm31512690eec.1.2026.08.09.06.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 06:25:41 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] drm/vmwgfx: reject SURFACE_DMA commands smaller than body +
 suffix
Date: Sun,  9 Aug 2026 10:25:14 -0300
Message-ID: <20260809132514.421679-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

vmw_cmd_dma() locates the SVGA3dCmdSurfaceDMASuffix at the end of the
command and dereferences it:

	suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
					       header->size - sizeof(*suffix));
	if (unlikely(suffix->suffixSize != sizeof(*suffix))) {

header->size comes straight from userspace through DRM_IOCTL_VMW_EXECBUF
(DRM_RENDER_ALLOW) and is only bounded from above: vmw_cmd_check()
rejects header->size > SVGA_CMD_MAX_DATASIZE and commands that do not fit
the buffer, and struct vmw_cmd_entry carries no per-command minimum size.
There is no lower bound. When header->size is smaller than sizeof(*suffix)
the pointer arithmetic underflows and the read of suffix->suffixSize is an
out-of-bounds read ahead of the command; when it is smaller than the body
plus the suffix, the body accesses that follow are out of bounds as well.

Reject the command before computing the suffix pointer when header->size
cannot hold both the fixed body and the trailing suffix.

Found by a syzkaller instance fuzzing the vmwgfx command stream:

  BUG: KASAN: vmalloc-out-of-bounds in vmw_cmd_dma+0x508/0x5b0
  Read of size 4 ...
   vmw_cmd_dma+0x508/0x5b0 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
   vmw_execbuf_process+0xd06/0x35f0
   vmw_execbuf_ioctl+0x1cc/0x5a0

Fixes: cbd75e97a525 ("drm/vmwgfx: Make sure user-space can't DMA across buffer object boundaries v2")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 6b921db2dcd2..02eb383f91b5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1524,6 +1524,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 	bool dirty;
 
 	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
+		VMW_DEBUG_USER("Invalid SURFACE_DMA command size.\n");
+		return -EINVAL;
+	}
+
 	suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
 					       header->size - sizeof(*suffix));
 
-- 
2.43.0

