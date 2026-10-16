Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14060CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E083112745;
	Fri, 16 Oct 2026 09:58:51 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B280E10E26E
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:58:44 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so20147685e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792144723; x=1792749523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ymRDCbkPH0L/MN0wvzTktChP65Muw3EavSGPIzFh+rc=;
 b=aZ3K6pENltjvtUB4YcXrlHKn7cRufgCKMBD/sWq/XET4IiRYkXhFMd9UCpomcryT5Z
 zzfdNIoX+3ps/PoA62SAtKi0ASssg0uoIjHDxD6HEEk9R/aY7jsYLPcxK4jn2Jf+KbeN
 u9aJ16qHe9s58lX2y8rYJR4hQFnQSsZt+UEE4buc8kQ9cqwacgjYlWVSjeGwdux0bg2u
 LYfur4oeM5l8/Untl79/KJUV4kNMzhsAzTqUtZjVpa/+Qw51n5LNW1UzzyQ7M+nfnrnF
 l9TDTqsE680AfYLbr/es8DD78SZ5yapOR6tYFqj8Xuj0seX83YleFnBKLmYzKhW1E9ug
 3ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792144723; x=1792749523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ymRDCbkPH0L/MN0wvzTktChP65Muw3EavSGPIzFh+rc=;
 b=U6AOPd1g2zg3cEPRVgH5cnc+4M+hkJeywmZde0ta5/O/fzmotlwJzcgvObKzXoIrhZ
 bdX/P62qSZ/YixROkcv7nroG46rackXrbpMYF/lT7eyhburHCOfmQwHnk8aRoOsXTiy2
 bKIeYYpOLQsGlIZjKJIyCs1ewRP+FVP9QbcSnqYwl7pMhxK+O+oDB+qI43iTpYZJUsQd
 I7fjGoqeY03ZB2ANMiUCIeVub3CosYyZbTafWaMHRiv5sCPJLIU4pmcjFT554dn5cGEO
 UFfnE+ZqPWiMmtZmtIUNncv6O3J+Ts+Up4X0L4FP4cNT7kWm8qt9sGwmykCoqxtIF//T
 KFJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWj7pyY3tNJHJsZulQeCGaM5k3VNQ24G0sglR/OnlCNOOU9HEeQcAVvUBbHxc+GFJx+dLHHGRUYaY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJKBD2tyH2WRNiP/VSNSan1jLf0ReLFXzZ0Me57YgTVbAWJjRFA
 T53t50q+T5uxf2flq3R8j12hkDvx6hzm6bT6QVoxdhS9J7pjDmmNysQG
X-Gm-Gg: AYBFou0j7rdg1cnApj05gsrWkQZLgDGEuzzKKevTIvRnU+dbEULyK88J4UMAefC49ti
 fWTsLJFh/jRgioGXRZAUal7mU4LuCsxlSkurXlFuBO83ShdL77VSzGop626OSCGLO0oRsO/fK+3
 hfFgu6S1tJ2Zl+MpF5WKwW9oJjRB4vY73vxwGnTwNscXOHbj2/5U4inzGCZfh1wku9fnDd8k8K0
 ojCwi3SbAqvivs9L8Ds5hlIol2JvmAum2mhywvenBBaYTSzpoRsURXf3XYW9CQqWpcFwZRMtCfd
 KmTpJkE9s7J9FAN1ZldNSNEKwu3xANYJaPwmAICvtRuc15l0OKU8lp042xaCjwtVXyxat5OWRjZ
 bIkduKtWsqlqrNJA/wmgmEOtVyDDn/hPL8D5QS3OS19qL60iwPQFOJn/DFy9X5c224GOG0D6E7o
 A7maQ1JaBqv738fA6Fnm0x1rkrllp6KXvpkzUlEheVobpxrWMMzz0Qm1TqnZmI/w8iGKB+wmr4l
 aLmWzfcUkRaaBHpJ27BKAjYiQrfGCBNcAHqsBSX8+7KDYJJaqTdddVPMqCMjvrtaV7Fb0hezROe
 MQ==
X-Received: by 2002:a05:600c:8105:b0:4a1:714d:eed with SMTP id
 5b1f17b1804b1-4a18e4841c1mr461974895e9.14.1792144723043; 
 Fri, 16 Oct 2026 02:58:43 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5033a2sm4133033f8f.45.2026.10.16.02.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:58:42 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2 0/2] clean up dma-buf-io kerneldocs
Date: Fri, 16 Oct 2026 10:58:29 +0100
Message-ID: <cover.1792144609.git.asml.silence@gmail.com>
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

