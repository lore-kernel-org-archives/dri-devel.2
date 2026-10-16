Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB7FCCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3252A10E1CC;
	Fri, 16 Oct 2026 09:34:50 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9754010E1CC
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:34:43 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso32482275e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792143282; x=1792748082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ymRDCbkPH0L/MN0wvzTktChP65Muw3EavSGPIzFh+rc=;
 b=qf39+kKaAxCVPBbvPDoqb5fUQPJiIIF0l3tNvVbJG+zlxCxB7k0h3XOl/dnDwaoTJr
 q1O0UIvB/5F9XxdCStvxXHMZDWYvZcU2CyAy8OF0tCSv7Pom7ATU/ZbR9Ju8SpnC+X+6
 rAdx8RyG/2nbG8/5zWvWrbU/DgtfzaO8sw+GDWWovRKqDKf1ublvc1pY/iJbjX8djFs/
 8E8iHT5pg/+foMK8Ac8YDBj1zkTPwuPQh0WWQ+/SCYhjV1FLbAuAdhP4PCybpgKYl+zd
 89+Evy3PzOYFPr8r7Fz6zmFvQMLfmMI8y+TYiWE6h585xF8rKYEMvCB/38QRUZIL4zTh
 KB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792143282; x=1792748082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ymRDCbkPH0L/MN0wvzTktChP65Muw3EavSGPIzFh+rc=;
 b=egeKnAzCt0aFWDYnC4a0/IkSCCnhdS0CV2POWUTZWl0/CivoKMjPsI9QGsLtQ04dCm
 nkJAAoR2cYtDMDR4Vz4aJzaw4Dyr+VShdh8UVq1+8LrUkxU/B+Iq5P3YxlJ5bdmziW7V
 hL9EC+Cl5gZFrcTAgqXSXK18gsRwRORHXmQ2d4BvgMtReLgICDaO4ojirqGkWiO88f4j
 3tamdqgzW8GRI1PNyE+2g0Y8On4Q/gfRpKwyot9pcHQXlXX+zoRvwn4hhEbP3B/pW8Si
 4TFOVucbMof+CBk8f4uSdlSnPWajNKQZC7Jm9iIB1/L25agIRQomuiqBzRfnlmAhUrGp
 sV/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPZwK2yrradQ2lys3Ye5X+jeeFj/3WVj9t7A4t6pHy7aBCLL/QZ/J2a6tR3pYzlNgfxXcs7sMxmKw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJRG1SHHc9kF9+A5pV/QGHhz9lSL9OKHi5IvAop/IaUy1hdrMpi
 oR37ovAl2qwo6y4MSbOBuMwDMq7cOl/q2MYNQYqG4wYnezqJkOH4zSbC
X-Gm-Gg: AYBFou3uSdYi/cfhmY2M9k5vvsyf3eamBFMh42ERe28Ikg7aPufYZ6pdUTRsgCLdEaM
 qmuKGm+chHeAUsVEUqvAssNk9faToezDwQH0P5+NSwgSW4jlfuR/+dXjRDbPVO7VJa+LYLSSvIo
 EFKCk8EKDZxq1qqoXd5wvoSpfUjFgsUOrLdcUyg2hp2S+9PH46pk/wuc8qau0lNyCfK+64x6ab9
 6ghQe9eutbu3ODDi6OT/9+I2FuMiKHu4ApQX02zl21YGtWnIUVvnDBy43PKIsofw8hrgjQQg3UB
 dPZs8fBA10ZM5R79sAQJopzt9OILuYHQEcZKmPhTF1HnW6hg4pxve3KvRTsvsUQ6l7ma5JBfAPP
 gHEUNqP0J3qSXRkic1U8Kcnwr2QhFqDs3lXLR6K1KCF5CH+SN8X6KE12Y8DzKwKLoXDpbaPjBBB
 aqdZaIVPcvofIZ/P94pQYSLlOIHYxEIkiC2TLdrsBtyMkktuZtYaxGgvAUtQBTeSu6rvIrRs9Az
 pH07iutrx4bosNgJrnlVazJwKEFsoQaT/Tkx57IDY7/ydpbciuGQulfBy3ISliytQOnmqSHAhYc
X-Received: by 2002:a05:600c:3e8d:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4a18e4aecb2mr401472905e9.32.1792143281895; 
 Fri, 16 Oct 2026 02:34:41 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ad6252sm63570615e9.5.2026.10.16.02.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:34:41 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 0/2] clean up dma-buf-io kerneldocs
Date: Fri, 16 Oct 2026 10:34:35 +0100
Message-ID: <cover.1792142927.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Add a kerneldoc for dma_buf_io_init_map() and clean up it overall.
Targeting the Jens' branch where dma-buf-io sits. If preferred, it
can all be squashed into 

0d3120db2cbe0a ("dma-buf: introduce initial file I/O infrastructure")

Pavel Begunkov (2):
  dma-buf-io: fix typos in kernel docs
  dma-buf-io: document dma_buf_io_init_map

 drivers/dma-buf/dma-buf-io.c | 32 ++++++++++++++++++++++----------
 include/linux/dma-buf-io.h   |  7 ++++---
 2 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.54.0

