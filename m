Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C32C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C7A10E636;
	Mon, 17 Aug 2026 05:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oVDaGfCM";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13D010E636
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:05:18 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso2923219b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 22:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786943118; x=1787547918; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wA2XmPl+hovwGxL3ai/U+yA7AWOU/owR4IcUEcMXDYY=;
 b=oVDaGfCM0TMRAf0VVVohUElAYwQGGYRS52xN36xfOiHPpviqIHuC4dMwB6VmqPuPUM
 L7W+GM8b1Skcg6a/cTeFUfiFAP8pp5jED8/gecDG4XQzk3aMCXUdVLjZHINYS3A4csrx
 ExAkTm1McZFiAyGvrPEfPmM5SMSGkFjbof+ppcGTf1b5PBeGJ9Q73rqYKBi/2wo892sR
 yl0pGMvVFuFG8GrLfhwDHm8fEUhqQExpQ/DbpbrehpqIy3KG+XPEdOdPKcAMje2K6iDy
 2/c/BVJJ3WZsiFiKtQHu7PrXxUVPhRRELzJts/7EyJnMQfWikM+tMrsuVBolM7u6vhrh
 GpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786943118; x=1787547918;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wA2XmPl+hovwGxL3ai/U+yA7AWOU/owR4IcUEcMXDYY=;
 b=UEHAfUSRr8c+RJA3KbTuWfl8iW5Yh/xxIxw0nADu/hRepWd944+QPJrWTjVTDiYt7a
 XP0QVPs0XT7lpYG0MpstS3Ql25luUpON2hlWgc7QUDH+wcvwS+7FdOQ/ACVSe2IxB3qE
 +z1n9TF8LlLED7n5wPpuKLfDbSY1B4mUwTWt2yds+Bd1K3/pUyQ0XolfFPyrqCEJZibn
 N+gtJeCjdTOvtFh8zSjj6T+a69NxCLPmKahS8C3Va7NUWTZRfa6CRvQ5LN3hEaaf1sbA
 9XVgbbW0qaZ/lkCqP+pKrJUiIDft5ggFXi3ClxKNRt/lkyXEbvPEzcBhnHIptVW+ZZXk
 RdRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNttXqZhtqrUjAfNqu40EBiddDFcQlMRcS9XkA+wrlTIHcuOwVY6+5s8q5/CZyAHZqdTGEFuD1wZs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFyovdIFyrdLDdfdz3HOyVuMF0U2s4Ltss8c2oaiy+JTvi3WBZ
 +71JkIGuKZIBjpHunYoLvG/MHpnkN/hs78BTg0Gla7jZzorE2EgHxG1a
X-Gm-Gg: AR+sD13szacWizkUcrJ5NMdL5WvXAaYhmSYSZd7YeiT8u4mco/EApwZhvEV3fN0e/Bm
 NRKFOhlTWrTMm76DK1LI7BSWVG1qs9Err3ui2is+CR6r2RjIyzHJIzCcf9rV60q8EXTP6OYCRoK
 6z5RSMe8bA4NDGZsrG5FoeJ8EDx86289fQsuFBebM2gSA8qpx2MkkhB/EjOsSYxEPGjpsG8JL7V
 KD/i7DPJQvLyJV2NShVUqcyIdJciGCaOoXC8SPZeW7QkXi9lKcEsYjjDBcWYyEiobCk/s3kEKRq
 QraudZyidgQb92fxED5I9evCz+6X01IxadAKGYupIEZEujWp4BauYZ3fFaNghruI2Rp4JtB4peq
 h1Aj5mISRE+NOI51g2bR6XUo3ulmz70bu1ilwcKV91lbOhmVLY2orAgyxTsSQ0kibpb2Mrlr1eF
 jXUxiZKb+ykx2RM0LINV0MiEbtIAW5wN9CH6mZ0sHunFkOnxQuZQaQ61GIx0fRNGFa
X-Received: by 2002:a05:6a00:94fb:b0:842:5da3:9b89 with SMTP id
 d2e1a72fcca58-84fde3e397cmr21923062b3a.38.1786943118310; 
 Sun, 16 Aug 2026 22:05:18 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d267310sm2131036b3a.53.2026.08.16.22.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 22:05:18 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v7 2/4] misc: fastrpc: don't publish fd before copy_to_user()
 succeeds
Date: Mon, 17 Aug 2026 13:04:55 +0800
Message-Id: <20260817050457.1005285-3-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817050457.1005285-1-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260817050457.1005285-1-shoubaineng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
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

