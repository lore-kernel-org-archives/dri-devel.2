Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE84C624DD
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8BA010F2C7;
	Thu,  3 Sep 2026 07:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FW1sVZ1f";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60FD710F1EA
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:59:32 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-396750cfee6so938601a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788357572; x=1788962372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hrAS7URR96Vhxqaift3zBbsgPvJL26DLyKnxdnXVft4=;
 b=FW1sVZ1fzLj17zSzGhPujSEfYcRKGrY52gRSFLZi5WX04mUqDgLyhxR4/QYouJffX2
 6yBTogiekL3c/4nACpaLG7fYs2R8fHj2bmqfYZUPnqQW/H+HESaKMXnc3fbf1jLqjlTV
 wTzb3HZJCIfmPZhWhGfCKtRDqW5Rf4noVLxrtmTo8mP0zLr1EJUKH+KZUaczm2+xhI2x
 A/JewzALfN+XwqGP+CDN0vg99H9b2nW/1yLkxJmyz/nG+BUW9PxWzAu7lSyTAEA0ttJE
 52s7X/JQi7pBJUpV/QtgHL5zgyOceTHPp9mtvX8/ns/ZEvidQxeaxu6kvG+YHgrYZWYd
 jOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788357572; x=1788962372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hrAS7URR96Vhxqaift3zBbsgPvJL26DLyKnxdnXVft4=;
 b=j8v4/VH4WsLuv3TzGBljN8uHCxYJK04665vScqb4Grfy2j9Y/IAIuwLfR3/+zIETGl
 //lnL1eaak2xKi+lc3Ku6ZYzTXqtPOZDGB1nJccHzX7OnIYYa0aP4q2rUHHkOEVs33OV
 6mxrXpDUxqAdlUG6cBc4pjCSSIxoBHNooEkIWOsk3RUNvhexs+yCkCg+8q6VnSa+Ksst
 BNMLt79fxrtUmJ2/FHz5VX/0lgyOUhw9gJeQXPMEpY61sjWfeffGycn/xW6i5MtspKNt
 GA3NTuNxkhsp40QPWf/jD23HpsoDmHTrFE7J+pUUlG4Owf1kSNxrRTymk+iC3oCbdWj1
 tzyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWP9NlkFDvszjlyqhr844IWzs0AXV/I8GdXJmvJRoK7pd4zv/eAwko3PW+493OlpRv6924PiwM2/M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++neKWUOQ5/UrnXMTJgnBoCJoBEgEVchXRBHB2dr8Xed+XiFXsKM
 yUkAw61HuKxldhuebTG+GVT69NJwtxJ1ZiDkgBDP4EglMH81kpAxRzz6
X-Gm-Gg: AYBFou31TSa7r6kd6WE2ci5HuXIbcT/vWn8JwSV8zRXbjGZ1j7Mw+vJY1m4HHcUGrjR
 IlGNReqGbYNtvPBAD/n4HsjQpXK/i4DJ3gZFfUx4Li2peWlb8EpQxFuPrnLwObnYMhj8ee1ysQP
 ROzfGANbxwM3VJc2y14GkerJIdYAZNjAneMBMYpQ3ouf8fAJHkIEkN2dJPQESmGIsv61Az/VBQ6
 WvSJG6k+WOcsY3OQDmVwrpzlYirYCuSZVK0UrGPB/v7Fe4dDSJwIDqNAMYjMn5NdICkif11EUfy
 P2l+1Wj5urzLasBmuyNdFxZg/yoS8uD0fu6DBYgTRImmTcWlc+b50xvse6aegoJyjuVAizpozkO
 J90ls8cU7OFLsWXDkgQkZo321e5ot9gJoBwnnPt4DBA4MdAbnk1r8jtTl0RkXmADgIEH6FY+0TT
 gXl9Cjxt/fKaBoRcH76QmHHTnCglnhKk/wJr7hNALQWhnT42q0GIgDFNiJjPJUU5qUzL5PSz6ws
 VarYbYi2vCrp5/LxUda9oEnmvD3Hl5arki6iiMez950rsRir744yP0NFAytnTzxkZJ5ag+VNeoI
 wsiiEbRYueFmDPh9WzYm2U7s+mxxbQGbRCAV8COOXcs=
X-Received: by 2002:a17:90a:ec8c:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-39aee04ace5mr8324115a91.16.1788357571759; 
 Wed, 02 Sep 2026 06:59:31 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990bd21e9dsm12123595a91.4.2026.09.02.06.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:59:31 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH v2] dma-buf: fix stale return value documentation for
 dma_buf_set_name()
Date: Wed,  2 Sep 2026 21:59:23 +0800
Message-ID: <20260902135923.3599022-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

The kernel-doc for dma_buf_set_name() still documents an -EBUSY return
for the case where the dma-buf is already attached to devices:

  Returns 0 on success. If the dma-buf buffer is already attached to
  devices, return -EBUSY.

That has not been true since commit e73c317efbf9 ("dma-buf: remove
restriction of IOCTL:DMA_BUF_SET_NAME"), which dropped the
dma_resv_lock() and the !list_empty(&dmabuf->attachments) check that
produced -EBUSY. That commit updated the description paragraph above,
but left the return value description behind.

The only failure the function can report now comes from strndup_user(),
propagated via PTR_ERR(); every other path returns 0. Document that
instead, using a Return: section so kernel-doc picks it up.

No functional change.

Fixes: e73c317efbf9 ("dma-buf: remove restriction of IOCTL:DMA_BUF_SET_NAME")
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
Changes in v2:
 - Use a "Return:" section so kernel-doc actually parses the return
   value description; scripts/kernel-doc -none -Wall reported "No
   description found for return value of 'dma_buf_set_name'" before
   this change and is quiet after it.
 - Reference the commit that made the -EBUSY text stale, and add a
   Fixes: tag for it.
 - Resend to the dma-buf maintainers and dri-devel; v1 only reached
   linux-media, where it was marked "Not Applicable".

v1: https://lore.kernel.org/linux-media/20260730003153.4030818-1-alan.tseng.cs@gmail.com/

 drivers/dma-buf/dma-buf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc..6ee3c254d7 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -413,9 +413,8 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
  * @buf:    [in]     A piece of userspace memory that contains the name of
  *                   the dma-buf.
  *
- * Returns 0 on success. If the dma-buf buffer is already attached to
- * devices, return -EBUSY.
- *
+ * Return: 0 on success, or a negative error code from strndup_user() on
+ * failure.
  */
 static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
 {
-- 
2.43.0

