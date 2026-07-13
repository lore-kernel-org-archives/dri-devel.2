Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CB1C44509
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D3C010EB59;
	Mon, 13 Jul 2026 22:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=0sec.ai header.i=@0sec.ai header.b="zl6FzLMk";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC64E10E32A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 17:30:33 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493f140ca8eso21420295e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0sec.ai; s=google; t=1783963832; x=1784568632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lYut2P9aL0SG5+YzD0gog4SCKmU/B02j9PR7RohOFfE=;
 b=zl6FzLMkhA49vHBzXN0JDhgmL/9yphf3pWG1HNijj09OlIPnAH4wnqAPOtdjVpA/uS
 UDYt8hhdsatOUqZD0rH4XQpFoPqHP5AbBjigqO1gj+qBJlHZ3ZZmne/kZgO2dcak179b
 R6wUbqiHiS8sE3HLC6kCWCOYOsa9DBRF53y7kQ4EV9JhoYS3R8uYJ1mcmfMfr+Lo5Lkq
 ntHFCs5hl5PQ3BJC6xNaf4mzGx4IIsRyFFSJXBgVqr2fzCJVc3R3DcX1+0YRTxAD/fKz
 labUs3DQzK2Ev5vX9hB0APk3x47+/qM9TtWtnl4kGNH9Y8aiF/n+6cQmf6MzN80868MN
 vfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783963832; x=1784568632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYut2P9aL0SG5+YzD0gog4SCKmU/B02j9PR7RohOFfE=;
 b=btjrKYruF34Vn9ukKmT/mosrA8Uy/io9eTkh4O2gasjkBHTim1hwrOfQSrcB2NGxhH
 Rcvnw6qffelvJYep9f1eDLmd5nG1CGASO3dFHXvAXQp2w4YhE4yknWYZBU4uHdRtbZxA
 +JJiqWrLzbYcW6nu/kb2KnfoxDoA1PUo/vPCHabPNrHaOJhSXwVwN/oH9PPd4ilulUNw
 gYfdUCv765W2MVvqV7lbely0luyN1PMjJXXGhCf5oDPOnaBxFgmLUAl99isdwSV3/4R/
 n+lRayhhIAgwBAX8Ccw4KE/fMSp9FvcfpEexhu8s4J8i5QV60RSVKXNbONyOiKhezDl5
 g06w==
X-Gm-Message-State: AOJu0YzZfVq/13r2jsbUZ3AxHCfPzqx124lIPni5kM1aSmS3Il77Xu2G
 bxcmfRsx8/v2L7RTiRk7+CEMCAKyinveegXh0n28Z0a1e/LlrUl67+iJNI9DgNcNhEUN
X-Gm-Gg: AfdE7cnRFkxLZp+fdkZTazxnEE0OgWFjJ6HAJcl/7NQP6EVdKLbedQF7vlBcdpxJhgr
 NqYOEhlV/fjPXKO3Zuef5Hl0AFp/lJz+HDJkTmTVJFLVNhbvhsCz4iDhrFkJW+l9nuJgDWrWW5X
 FeGJ/u2sOFghDkKnUYaxIotZwi9RjUcaMh4uNyq+8e3k63oxiIT70e9XYs6hTqwI8ja+BzTXyXl
 nR0YUqm+XI76MDHJQSOJ4CWgrKAVH+3uVMn+knZGXkk/+G+LEmiIv5qHT9IiSgXWJePFqYyCPkY
 xYd76PQltlWNCP7XyhUSe3B9BaXLPm09l6hY5UK8dQ35bVhmawinzO0sq3Or5JL/w3DDvRDuJKJ
 JOGWd6w1ajUDZI7Ft+hPcSdtEdvMU3AfwlRHsYXd0lVuhquXZ/16AwYQsy7YF3dpgd/MnKguPO5
 5DZJ7YRtSxgGwwAjvSKxMKazkojHJJdUJlrfv65uvz4iAEtMYRDU/d0K8EpCxqCEstf7aBG404R
 plAcr4nwsFqNxWaS48gia9dScFL3J8JHvc=
X-Received: by 2002:a05:600c:6048:b0:493:e97d:97e3 with SMTP id
 5b1f17b1804b1-493f883e9aamr78602105e9.39.1783963832090; 
 Mon, 13 Jul 2026 10:30:32 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f3a60404sm260075855e9.1.2026.07.13.10.30.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jul 2026 10:30:31 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH 0/2] accel/amdxdna: fix two NULL-deref DoS paths reachable via
 AMDXDNA_EXEC_CMD
Date: Mon, 13 Jul 2026 19:30:27 +0200
Message-ID: <20260713173030.87541-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

An unprivileged process with access to an AMD NPU accel node can oops the
kernel with a single AMDXDNA_EXEC_CMD ioctl. Two distinct NULL dereferences
are reachable on the command-submit path, both since the driver first gained
command execution:

  1. cmd_handles = 0 (AMDXDNA_INVALID_BO_HANDLE) leaves job->cmd_bo NULL,
     dereferenced later by the DRM scheduler.
  2. On an AIE4 device (no .cmd_submit op) the ioctl calls a NULL function
     pointer.

Both are availability-only (local DoS), no memory corruption. Found by static
analysis; verified against source, not runtime-reproduced (no NPU on hand).


Doruk Tan Ozturk (2):
  accel/amdxdna: reject user command submission without a command BO
  accel/amdxdna: reject command submission on devices without a submit
    op

 drivers/accel/amdxdna/amdxdna_ctx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.43.0

