Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501B2C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B142710E9BD;
	Sun, 13 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DE/hbRmt";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C16310E38F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:12:21 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso2885255e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164739; x=1789769539; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fFA3Y9RWjyE/MfZqBJ2nbJ8LDh/EERVeVlcRxvEqcnQ=;
 b=DE/hbRmtVsZEiEoUc3BY8JemLzNOeaud/VzvQegqJ7aODAtlFOFmtDiF8Bqj52Rtbg
 e4COP7RRGREoMW1WZ2/3G5pj5m8XTQwj6dIN1/fVmzalCLrUGgkouHcFk6XgM2a5OmnN
 NmNr6WxgUuXx0X6g0TKJAgQQ1UmDh0d2Fi/XVRD6ZrkfZk5p9H/jmv1GuQCjfbBHkcmF
 ohTWF3pZrCNh9gDAuKasGF250D3xmoNFMJBrxgGXOC1+8lrujHqOdS+kIQsEcZT1bG/o
 woXgBn5PeUgEFCi0V5bbDNMYP4BdvnhLjsi1suBZ1p9SxwCNSSX5/wSslQY1Lp+5Mz4a
 wl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164739; x=1789769539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fFA3Y9RWjyE/MfZqBJ2nbJ8LDh/EERVeVlcRxvEqcnQ=;
 b=AZZgurJMnCoi0v7rrnswyaDfO3aMnK/QhwMWyprnKCVA/AH97gh0CHUjs6/VghJFtK
 YnbdUBdbiGiEdIFzEoFTJVdB7McHlX+Bvctxt++ASdjXM1AqFrVP9vmKuiclTIVluEZt
 S7bK5ZS3Y6wlAM7cYQApz6W+AcP86IjWN4QNtAIgUza5yL3RrAdy1Ipz7N+B8kKKhdZU
 mtVATzv2IZ9Ko0LLtEnOEbWj+O+dJCDcBXQRB6NCJwx3Jo6cVyOZ5QO/g0uEY0HOMpsy
 EioVxrqmXhkwCQjyPBqjkCTB2yD9gvSk0Brrk/TngMcvmIZPLXo91qafruUXIl71Ivdd
 jfNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGy4wAhxrQo6esaZMeGnIfUQ5NBJKXl5adVr7gQC9o/oR7eU2+3ZKUxBw/KYe3y6gW5PJOiN3EWzA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lXL7mObZG6pucZWLWYO097kA+QoEzGXz/7yP1/osqJoAGDfX4B
 /Ng6TRt81OSiExalNL6B7prMJ7IJZARNNj8GbGflKfhkRlZmvMlw6MF4
X-Gm-Gg: AYBFou1U7DVpEXXXqH8clYamXFaKWLVGnpepMi/ONbleiWFGCk3rwGJGyxERnI3UUqy
 7oXYMrAxkkU+CyTkFtjJU7yVv79FrpItFBIPlP5tRioLyn76BeCXB6UIItwX4TMAf6XYv2d3SkJ
 IXDIlMPAkjJY14GaMPrj+Xan49qU/e2OgzyE7NzIhwfn/kz5yHMpLAt4CSU0h964hNGHirIBDgF
 ZybIR2a09SdlANR8jHQMVknYSmgyBI9TuFMgfmlx9y9PBDglgQvo2wy8a40OmU8vx2p/evGj3Ji
 nGdPp2vCnuWxnrm+9vJQHB12wYqLrMWt6gVpJgCR+KUQ1+SYKVVsQu3K2qIwLfsgDC4QSqfvHBp
 j/lYZ9NhNPgBaLyTsSSqZnmq5v3siPyIvWLkCQZ47Z+8txsLIQyj0LoQ5ePyuwfpLRhkWZhgLw7
 KtKrtaz6a92uiHhzjsCIQ5Ex3Jlw8breW6CT7dfxpwyvf1cHCzsN7bU76+6IP253tH5emWNAbU3
 DhRfy0DsDrQJ6mJW9fhL/i08JjAPzjrOrC6mwcfroDqrqQtQtEqxBBH59WfI1caAgJqXPak+ijW
 fYMoA2lGbFc2om850ap1H/zDUvXFPbzKwwYl
X-Received: by 2002:a05:600c:1d08:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-49e619b57admr155349985e9.5.1789164739111; 
 Fri, 11 Sep 2026 15:12:19 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c300e2sm204158365e9.8.2026.09.11.15.12.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Sep 2026 15:12:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dma-fence: Fix dma_fence_enable_signaling() reference in
 kernel-doc
Date: Sat, 12 Sep 2026 00:11:00 +0200
Message-Id: <20260911221100.7079-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The kernel-doc comment of dma_fence_is_signaled_locked() refers to
dma_fence_enable_sw_signaling, which was renamed to
dma_fence_enable_signaling by commit 9370a5c664e8 ("dma-buf: rename
dma_fence_enable_sw_signaling"). Say dma_fence_enable_signaling.

Fixes: 9370a5c664e8 ("dma-buf: rename dma_fence_enable_sw_signaling")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/dma-fence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 158cd609f1036e56668867f092041213cbf30427..3aa85be43aada5a80ea2e1cecc5f76824b434d14 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -501,7 +501,7 @@ dma_fence_test_signaled_flag(struct dma_fence *fence)
  * Returns true if the fence was already signaled, false if not. Since this
  * function doesn't enable signaling, it is not guaranteed to ever return
  * true if dma_fence_add_callback(), dma_fence_wait() or
- * dma_fence_enable_sw_signaling() haven't been called before.
+ * dma_fence_enable_signaling() haven't been called before.
  *
  * This function requires &dma_fence.lock to be held.
  *
