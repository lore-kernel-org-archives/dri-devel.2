Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B24C55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF8110EDDF;
	Thu, 30 Jul 2026 07:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQMC8QUs";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569D810E0CB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 00:50:27 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so1017891b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 17:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785372627; x=1785977427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tTcejbfPpIi7RoF28k6VKpbyOUJ6ogQJG6qo6DRmZEc=;
 b=HQMC8QUs/6mU4XeKVW2mv4t7ENqQo1k11G+mXGxSd1SxwpYp3f4Jpk+RNJDL1jzYcX
 SEQcu+v7Mowv0hAvwjImRh80521eprQyNCwP4nEFulSxhk5A7FaSu+rgdV9YWl8f1cBr
 PXUu0TpEANqKjqzPT3rW0lZN5mit1ucVA7yiWEXbU4v6DHrEUF3p3roqFRmLYxoOy7hK
 UbCq9WQ7DqxCKF+qESoKaThNqPcpXp8zWbtGUqRH6nz6NnXCS6sm1GPepB8Bwa4q5iTb
 goYgVoSVnBSEYz9sB3KnBuO7vlDNK7K9uWYXlp7K5mQ4438HTM/RePiA1R/EGfGE9EDY
 1FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785372627; x=1785977427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tTcejbfPpIi7RoF28k6VKpbyOUJ6ogQJG6qo6DRmZEc=;
 b=UgjYNvFbdR4WK5TZJEc0aklygNIOQyr++LpXwXPvJhHKiaybWBL+ogbp/fDZm0I+KZ
 oETK57ENk9sB0Yewnm93SeYYGOfff+V7ewWMtArFKy3rvbnJF2kcan0N7KaouRQE3R1S
 s/H+iSmN+49z0G4aNF5jxF9yDNMlN0E5WT0uU41jVCpSY/UjsH5ZhI6PJMF3+FboJaVK
 z4CJMgxytnfXAPaWu2GylIorT0/ym7Y+OM7Ia2p+I4uyig8AcRHK+4ZyvAZm/8bwqR6T
 y2/u1h0qFPLu1zYaJQ8rGtWgK0n3PngQhZO/DM86bg17zkvt8fGWsh3H4d46KTyqHro3
 0mWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roz6EFyaA+72zlZXKQNSB1+nfCoGa8N6uFBVvngXvpcpl7q+SaKoSRt290sdyREADcscEiwbpbkxSE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDfseZksiwfDeCD+tOmogjsCFft+jzDgMUrLtkDeKpvzp7uZ/q
 e01wUg29cJlYzsGPAOshlhDfmWh/DXToO4tj5a2zZcPtVv23+fgw/CyP
X-Gm-Gg: AR+sD11JP1vhFixGca+CKvivOPT5Ql1mfwK4ba1ha8KXNur24ZdcUOCV3KMt3QSvHor
 UxKWHICrEwlq+KZUmlGLRU8qn1YY/WBV6v5n3xIzLJVvH+QdUDuAffO0dVUB8TE7x/EmMh+AWqs
 Nja4amLrLqJC8Pm++Uzll63Dk2nzD+2KIyG0Aa5RWQiag9V44RgG+ZAnPQiElL5aqA3BuoQeJOB
 ZnMjhrMASDiI+ghEoQlycXmM/gydqmr181vbiA3qyZYLY7pM8SeyBKOSMLlFwA9I0OQ4tmYQLui
 NkkBFGw/s32EuOHLmPvD7c01UfmbPAFUzU7L7fDtXZeV8aYfi6kf/M/FybsTly5isfvJlPdd7R+
 njREW3Yk2VL8K9Y3gIM5Xg2BXbNIjTAN93Chf+hrvovHzYbBLxWZ74YATViF/0a10AiV/n5oIqw
 84GrOoIFYr5s+h22f6SEnX7ofjCkU4oXC8Ee+qc2rkpXSaqTu+RTuP+BK8aCiRIFCIwXrnJG8+Y
 d3nGvP1+4wTgLESX1tDAOWzf+lv95sSXjbiDyZakX+8R12qm6NSULRdLhGFMS1zRDz19+Ba6q6Q
 vU3vVpKG
X-Received: by 2002:a05:6a00:2e1e:b0:846:a26:8e0b with SMTP id
 d2e1a72fcca58-84ebc20ff60mr599833b3a.18.1785372626776; 
 Wed, 29 Jul 2026 17:50:26 -0700 (PDT)
Received: from alanhc-ROG-Strix-G16-G614PR-G614PR.tailb22ec2.ts.net
 (1-161-137-250.dynamic-ip.hinet.net. [1.161.137.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e9fe240acsm2088390b3a.7.2026.07.29.17.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 17:50:26 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH v2] dma-buf: fix stale return value documentation for
 dma_buf_set_name()
Date: Thu, 30 Jul 2026 08:50:21 +0800
Message-ID: <20260730005021.4032907-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730003153.4030818-1-alan.tseng.cs@gmail.com>
References: <20260730003153.4030818-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:56 +0000
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

Commit e73c317efbf9 ("dma-buf: remove restriction of
IOCTL:DMA_BUF_SET_NAME") removed the dma_resv_lock() and the check on
dmabuf->attachments that returned -EBUSY. It updated the description above
the function accordingly, but left the return value description untouched.

dma_buf_set_name() now returns 0 on success, or the error from
strndup_user(); there is no -EBUSY path left. Update the description to
match the code.

kernel-doc does not validate prose, so scripts/kernel-doc does not report
this.

Fixes: e73c317efbf9 ("dma-buf: remove restriction of IOCTL:DMA_BUF_SET_NAME")
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
v2: Add a Fixes: tag identifying the commit that left the return value
    description stale. No change to the diff.

 drivers/dma-buf/dma-buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636d..324f4f0c8 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -413,8 +413,8 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
  * @buf:    [in]     A piece of userspace memory that contains the name of
  *                   the dma-buf.
  *
- * Returns 0 on success. If the dma-buf buffer is already attached to
- * devices, return -EBUSY.
+ * Returns 0 on success, or a negative error code from strndup_user() if the
+ * name cannot be copied in.
  *
  */
 static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
-- 
2.43.0

