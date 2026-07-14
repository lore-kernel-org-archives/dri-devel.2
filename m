Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F274EC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AF510ED24;
	Tue, 14 Jul 2026 11:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lxqgiGQi";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8854810ED21
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:47:25 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so3802193a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784029645; x=1784634445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9XJ+pkLF/zrrWNVQ3+TJme7MRR7lpIC8LYwT0f9F3iM=;
 b=lxqgiGQi5xvrGHMhJKwv7GGueAXznhsu/oKifWPZMkeFH4NLsYGD++FoC+amlcDTo5
 fJ41Oi2eKjg/ep6p961QMspm/spTx6+JeXiBRlSZQfkvImP3yQwuluIfvpm//ks1TiiA
 XIe/D+BoLy5nWI9M0hlF2/kisc2prcm1eiKKZcv5MJO7KimqYVTvXIuIiFDroUpCVO3+
 f59uBGb66wXEujBsA0EVLfAxtOecDww/RJsF0TFHLlH+7f4/FYTCUU4oWuBx/8PIAMeh
 4/CY+ThKToTL8YkIcZK71yF1KiXUsm7U7PSG9092eBZBexKkPuSsi1O9VXRU/jhjqiNF
 Un3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784029645; x=1784634445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9XJ+pkLF/zrrWNVQ3+TJme7MRR7lpIC8LYwT0f9F3iM=;
 b=eglSbBD8tA9zoQ3HfbjPCUWzwdb6qQZKVC1ARSOH2TH7TQJkkJK3gni9bgcWvU8ZKk
 hwlV1JGCgfFOxz+oVygLfrXCGqJNmN3yuh5N6qGCX8RJxLnk5KesQRimNP/SwcvOZaj6
 MzyU5muzZefHGZ3Yf7v9xSjvcFBXqvHulitN3YuUekIV9N78hQ/+7vbDleeSm44DWnpi
 4YlnLdplCD7lD1qNKGOgQKEfXW85kF2RvRAiVF0Pa+WXuePvMWdDFSTpnVzpu25PYjvi
 mvufusNVMoiYzfomSaFbC8PJwqL5h/vVvGCIEX4pANWqf0PHHsVuVbrsPqsOh/F4c+NH
 jWLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaG+/vDo7Iwlp0IteUPVLpT+sJDFEvtmE4KgdreQAaIGL6DvGa08WZauIXcsAVXtwEU31xUqpaSlk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9VGO50iQ2deFQ6XzzBHXvRgk77Ru3yYwD4xwRPZyE9y1SMKNR
 Depg0uKcmzGVNtJNpGEBMb9H8hZ85Dje28y6e91DGwo1ttNBSHm2g27I
X-Gm-Gg: AfdE7cnJRHwxvlx++ZOWN+Q+85nujW0FH/uKxBeCHcTPLuu1WZG1C4f5F82kDV0LWbW
 8ag+Z/WI2SVkwPeHADqIo+/PXIRzKC4Ifpt/J/0V+v7y0kqj+nrlmx2f3TicgZRMTFqdvQmcQHR
 n7+3S6ev2a0js3P0/aCpJNQOCof4zgy8DIv58tOhetrsYb9zlsUnnFcgTkSv+otOyYQpa27lu8m
 SKDeD1TXTHbaHnIqq3m+TZyn2c/s7Jcj/BX63ssF8kmx/a0hVHihFpMQSXtj+ifK0v697d737bS
 Sh5l6imJIYRl+CHbRc7nR6txzD1Brjo1uUg1gXaT5XB2WRoW1L6g8eTj2nhgLBiV+nIaBYKjdGy
 842QAD48K2WVWJKw+AquwCCohOai0Xk2mzOtpeeytdciaSSMUqkI8biA2yEvlFAZJRdd9PW7ag2
 ck3jdVvSBVy2edOqya
X-Received: by 2002:a17:90b:3dcb:b0:387:e0bb:5804 with SMTP id
 98e67ed59e1d1-38dc7bc50femr12271219a91.43.1784029644922; 
 Tue, 14 Jul 2026 04:47:24 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e17470008sm1356162a91.17.2026.07.14.04.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 04:47:24 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v3 2/2] misc: fastrpc: don't publish fd before copy_to_user()
 succeeds
Date: Tue, 14 Jul 2026 19:46:54 +0800
Message-Id: <20260714114654.3885457-3-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714114654.3885457-1-shoubaineng@gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
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

fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
into the caller's fd table before copy_to_user() copies the fd number
back to userspace.  If copy_to_user() fails, the fd is already visible
to other threads in the same process but the ioctl returns -EFAULT.
The existing comment in the code even acknowledges the problem:

  "The usercopy failed, but we can't do much about it, as dma_buf_fd()
   already called fd_install()..."

Now that dma_buf_fd_install() is available (introduced to fix the same
issue in dma-heap), apply the same pattern here: reserve the fd with
get_unused_fd_flags(), attempt copy_to_user(), and only on success call
dma_buf_fd_install() to publish it atomically with the tracepoint.  On
copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
unwind without any user-visible side effects.

Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
Cc: stable@vger.kernel.org
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/misc/fastrpc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..c5143cd25767 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1709,24 +1709,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
+	bp.fd = get_unused_fd_flags(O_ACCMODE);
 	if (bp.fd < 0) {
 		dma_buf_put(buf->dmabuf);
-		return -EINVAL;
+		return bp.fd;
 	}
 
 	if (copy_to_user(argp, &bp, sizeof(bp))) {
-		/*
-		 * The usercopy failed, but we can't do much about it, as
-		 * dma_buf_fd() already called fd_install() and made the
-		 * file descriptor accessible for the current process. It
-		 * might already be closed and dmabuf no longer valid when
-		 * we reach this point. Therefore "leak" the fd and rely on
-		 * the process exit path to do any required cleanup.
-		 */
+		put_unused_fd(bp.fd);
+		dma_buf_put(buf->dmabuf);
 		return -EFAULT;
 	}
 
+	dma_buf_fd_install(buf->dmabuf, bp.fd);
+
 	return 0;
 }
 
-- 
2.34.1

