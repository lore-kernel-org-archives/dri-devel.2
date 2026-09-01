Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9309AC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE7910F3D5;
	Thu,  3 Sep 2026 07:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ASNYJgSu";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C02B10EF2B
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:19:54 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8485b358552so251287b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788293993; x=1788898793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0PiVP95ao7yXW/OZhxmQ9Mbj44WmjmsyxLnkqleNrz8=;
 b=ASNYJgSuneDr/P42OnU+V7Y4QzDi8Xk4wRqwtpJhliSiHiyPYSU/4WkA+Awq0MB3sm
 M58zAlyQziL1jU/skziyDazjJWZ/1iyRa1x+Smu4R3fiKv7rMry2E+PMMZQwCgclRgSv
 90r76miFBPi1Bfr/NqiwX/qnr+wNXQXbgMw1sb2i9/Ph3I32gtwJ8wnA2pDXAxnKF5tQ
 CLo8acKn7Hc27fckFOS3fHkeQB3FNWPV6cyyvGWaUIltDyIcd2jAzzydoP5n7OE8g5qZ
 4kEKCltHYvF+nN2jsRl7YT/+j2Zh9q+eDgDUsdYpzcLGd4rFfWE9s1Q3JyEvLQvp5XXI
 4Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788293993; x=1788898793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0PiVP95ao7yXW/OZhxmQ9Mbj44WmjmsyxLnkqleNrz8=;
 b=q5X1pklYXMVF+WH6dAkf0vxFdJMCX8YaI615Fo58k0YSQemi1iIWk1xK/HEGlq4+Bi
 AXCiG2WNLE2+YStZxZmlFLANmfmn4QVHBIqP8CNTyoR3CbXspabqUMs4JECHOv0qrGIC
 CipTydOPyjNxi/sx+alfi1pm3n92dFtbXwHVA1t/vCdhHYzPgnWnB1Wc2LNV3IndobSR
 APvS5bkOVUSr2ZsDdF7qgrEfD0cXnnMXyHEBvvXdOCq+CfJhT9vtO8lyBgyn4ivj4RYs
 JrGj4IK6hv5s8gV7PrEnrlTX4DC43pSLDPmq+AG5l9IyxPFl2mp3a+Wbt0hUgQVDfvly
 2sxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoV+PJz50l1Z8f9ROYDysUyt52Mvp+43crpQENiWBsZZLihj73/6DzkXJCsTocf29JzA4hnKgRPEIg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpGgrrlHsLCiFcBlgf2TiVqdnkJtG/ChuUq7QP5GUzJLlnBB+o
 9NHbv3VWBaEX1RV+WKGShOgsKueixPTQY1WeT7XwcVyysBobhvHMF592
X-Gm-Gg: AR+sD12MS5dO1zFMUgFX2DdMixi7oGQp/KGTPrIaTnkrKX5pNZgAOqOqVz/qGF1Zkin
 dXKc1OTB5ZEYYhJM23kKr4n/X63pfywfmAjwr30c+o8iuhX6gBI5BvZf66Z0QTHTwQZoyphv/gq
 atq5JRWZF+fgSXFijxPTAP/T9wOOPXAuAixA2t6D4TsDdH8JehIHgrnb4bYpRnHCKl/NkDmMJUt
 P3lss6Cqs+jcYoHtDCA5JYd3PdbHyuzsEj0XZuA2ApD/BCJbqNnQ8a4x6qpE4lCK8zuITYK1f0O
 pov8iAOEiF6fCqr2wIVAT8USTXJbIwXaTK7jPNliCUU4YNXBp2/tOFUxOaHNv1XpSciqxNtM88H
 gzdGTN9mvsWb8kTxgXOrH1onxbNtJblaXW0wg6ryDsnP/d3I8gcGZu683CtfRwEgmZAlEKnT89B
 6D91sitUNjVHDhjFIn2g1c3us3hgR/p1MhWpk2yPAxufvevgYwmumezjQVxZ3qGLsNQesWLr/Xb
 1A5pWKj8md0cWSvIsp+VcuHtuQFYDeuk9y0lSUgEn2m9EHn+j6Dt5cYmoOjmJjiIM/gA6ThoTqJ
 lU7q0QDMoIAzzGarterQxMI0sulETkkMmMs6Mq4Mgvw=
X-Received: by 2002:a05:6a00:a25c:b0:855:1590:ba2b with SMTP id
 d2e1a72fcca58-85ed1d076bamr647630b3a.5.1788293993438; 
 Tue, 01 Sep 2026 13:19:53 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc003aee2sm331139b3a.30.2026.09.01.13.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:19:53 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH v2] dma-buf: fix stale return value documentation for
 dma_buf_set_name()
Date: Wed,  2 Sep 2026 04:19:49 +0800
Message-ID: <20260901201950.3503739-1-alan.tseng.cs@gmail.com>
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

The kernel-doc for dma_buf_set_name() still promises that the function
returns -EBUSY when the dma-buf is already attached to devices:

  Returns 0 on success. If the dma-buf buffer is already attached to
  devices, return -EBUSY.

That has not been true since commit e73c317efbf9 ("dma-buf: remove
restriction of IOCTL:DMA_BUF_SET_NAME"), which dropped the
dma_resv_lock() and the !list_empty(&dmabuf->attachments) check that
produced -EBUSY. That commit rewrote the first paragraph of the comment
to match, but left the return value description behind.

The only failure the function can report now comes from strndup_user(),
which is propagated via PTR_ERR(); every other path returns 0. Describe
that instead, using a Return: section so kernel-doc picks it up:
scripts/kernel-doc -none -Wall drivers/dma-buf/dma-buf.c reports "No
description found for return value of 'dma_buf_set_name'" before this
change and is quiet after it.

No functional change.

Fixes: e73c317efbf9 ("dma-buf: remove restriction of IOCTL:DMA_BUF_SET_NAME")
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
v1 was sent on 2026-07-29 and did not get any review comments.

v1 -> v2:
 - Use a "Return:" section instead of a plain "Returns ..." sentence, so
   kernel-doc actually parses the description (fixes a -Wall warning).
 - Add a Fixes: tag pointing at the commit that removed the -EBUSY path.
 - Widen the Cc list to the dma-buf maintainers, linux-media and
   dri-devel; v1 only went to LKML, which is most likely why it was
   missed.

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

