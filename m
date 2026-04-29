Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC6EFF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B9110F050;
	Wed, 29 Apr 2026 15:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9IzWz+P";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466D010F050
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:26:24 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so167925925e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476383; x=1778081183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bz5U140iikgjy9qkhQv9ANNAasoYi2fY/CedhAQlGZc=;
 b=O9IzWz+P1JaizPtFQk/Kf8UpOF26KjtIq+81FjVsEAk1w1GtwAQBIDPiQxhVcUVcb0
 PipbHE+j/0nnxUnlpWuA5b2OPapDjzKqFT8EoE9RbUreqbKdZBoGVnkF0CvC9W8dA5w4
 7O0jqLIERTX0tMAwiA5x2xRYmVDLiwDHZhyLq0Hrzj+wnSXOmVCICLQ+LUpzs9zKOIjw
 +zHtuuvbVh21BYJmE29kHAR5vQg7s9AXVGDONUJNS2OmpAF8LOR86ARWT48mvkKjERqg
 l26Hw9/2VCiHXo80DxijDQCMfa5CoDr8mFUnP8POCFb/C1cx2UXg75lPSwUJhzw0lmCn
 MU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476383; x=1778081183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bz5U140iikgjy9qkhQv9ANNAasoYi2fY/CedhAQlGZc=;
 b=FhlAKBOKiexMpOqFPw+lbK/CXU8s21Gf59tIBVljIqU5NV/isteo/oNQGhlBf5V0+A
 TfvT1wLxorThQ/mi0BpviQkdAjERYnT+ijofmJeqAZhoatEEsEQZ9E57F+ycjjqaIsH+
 79/ZRo82B+Bln3LOn2DrV5568vJjaeDQqhXOLCwsd9LnMQ5JYen3XUQmPHVDL1eBKSPG
 6yM8w/PEKvwKi5ao6dseN0lAgKhak9dkx2gkKl1E8F9VKJpg/VsOjbthB6A5hordHeUg
 NyuJGGZ8ceW2RHMSfE+eV0E7d+1+7gITyEcHhFUM7exGiJpKKIPq1lDm8H/mDmVIb3Gh
 KSpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wTtQZC3T9KEE0onT/QGn7t1MD3cpRTkCMk5OP3hynr1ahrmS7McG3wuvFZLwDVNgkPqXpULBBA9o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFXE8VsOphJSPYb6A90S+h/IbwaL10ICeEZIhQFSpwr2kbC9Wt
 K4ob1o6VXQeKUZwew+vqvGFQWBtcZXPrsqYjFohvN5tYoKHoe4jOvRbm
X-Gm-Gg: AeBDieuvwoKBTwEmZRxmWOVqGwNAWhCFv4J/7YV3gjTUCzu8jdWnmeYJGR3r9y3PATY
 Xtc14cJ4iJt0VV71CNKP3AGoULGARhRgptzAt17mJH+N9hjpgxJJRPtYyp/w0jAaD60IodNcCh3
 aPoOWNxk/jSWmMFodErEkKzkV9pcixc+prjMYWDM85YixcsA+vkPRq0j7A8GyzlqFYesQnXrFSn
 1DMoaUWIh9DM9Yn8a694QBZeu4tAA1zcSAJJeBbQ+ClBm9uQDARn6g2Rbcw1m+i5SKLLrKcTKEI
 HA93+f0JMdcpzmSx1jTZShM+O1HnfYLMmBrBDSI7Pi72sgrH9Wz6MObt9sXSzgja8/iKjWkRnl0
 Urn7hTElJUHI0M/k5baoF1sIYzaWjXiSaE0rcH1eJoEhUfZRxzMH4Puc8l97afOQfpvU9Udru1H
 +Av7jTpeJsBXJWrnflzI/HXiWaKiMA2cS5AZJMcxgnFKR/89jljhWXI+NK/4dLKLCW4ufIEehi6
 /Qm7OT1Yj1Iv3kXo8v3d9a+RnpmQxYC/I62YnA8v3vm
X-Received: by 2002:a05:600c:3b13:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48a77ae049fmr129049305e9.11.1777476382406; 
 Wed, 29 Apr 2026 08:26:22 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:26:21 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 01/10] file: add callback for creating long-term dmabuf maps
Date: Wed, 29 Apr 2026 16:25:47 +0100
Message-ID: <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
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

Introduce a new file callback that allows creating long-term dma
mapping. All necessary information together with a dmabuf will be passed
in the second argument of type struct io_dmabuf_token, which will be
defined in following patches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b5b01bb22d12..c5558aab4628 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1920,6 +1920,7 @@ struct dir_context {
 
 struct io_uring_cmd;
 struct offset_ctx;
+struct io_dmabuf_token;
 
 typedef unsigned int __bitwise fop_flags_t;
 
@@ -1967,6 +1968,7 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	int (*create_dmabuf_token)(struct file *, struct io_dmabuf_token *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.53.0

