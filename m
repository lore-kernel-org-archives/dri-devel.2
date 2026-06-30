Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6192C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F0910EB27;
	Tue, 30 Jun 2026 07:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="es5WTbVe";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C551810E0AD
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:04:45 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-37e11438c66so1637315a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 23:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782799485; x=1783404285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=10B4i4oL/7/zv30DqERWrYljWa6g0AJAQ99ZS+xoTjU=;
 b=es5WTbVeF+1OtLgq3NFoXpTfuwbe/VhceEMtNmtSK35j3STmrvlGCHS/1k+s55pwhf
 sKxz5hUPELNPnT+auMFATzaO5f8hl5rxdw87sP7my4U/SB6EHugoMD57RN1oxsSwTaku
 rqsRXLKTOyNTCEbNT5tclineHP6B/q+VOM11qaHph7MLa3NgAPcYBkfXuSYNcPua8LSb
 Li4xDs8Ferwmw9APSc0PuIGpTew/EV91/43sjEP2FbqVQEzrMNh+Og70/e1VF5XBZh9K
 zfuDKH7qxb7EKP1pvo/3/klHrTbonhPBNMn5psTi3CkpesqYvktUK4+OgfUnRDd96kP1
 ZkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782799485; x=1783404285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10B4i4oL/7/zv30DqERWrYljWa6g0AJAQ99ZS+xoTjU=;
 b=WGoQnA2UU/IOevIyBTjv0Z78M1lJP/xAuV3VY/U0p89bXlY//9W38EQYB8AlCKoL5U
 jnbxacVVRtWKGgEhbIHOoUw5v2mXLaX5Pg0J8znx/3VNxuUbVJrvTVh4QPQhUTLFzH2y
 4g0Lf10XaujKpbufOW64NwZNTdnu3F9pgv4MmUPa9HxirqWKOvc0cgqvcsBs3DJekU0x
 wygfz0BWcoL6tVPULCjMeoX7azoBFgQk1o+SUiuW/X7Z6+0GrQmMqcCpKl37g/jYfA1a
 j9yO6xFW3EcKQpL0uCAv0yBeWmyjGT0tIxuYGbuJKfvr7d08VLQ1pg96dUXUrOvf6Xng
 HIww==
X-Forwarded-Encrypted: i=1;
 AHgh+RopDJwbVrJYO2H/BlTuLWvwtmSVkT8yXQd/kdpWBSMHXcYqjTw3a56sGJPNZaygyF1wFK6ESBfFVpE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5UX1SFtRFluYP/RPGTughFuiuHhZXsFmOi+e7N7vWhu9l5gkK
 XOdtFI3+1j/v3BZCrpkE4DHwM73Q7Ke3oxBom08Ax5OEOxKwb1iGbKri
X-Gm-Gg: AfdE7cm4vLyeZoqMm01qvZwPmp1V479piEY3gZtDl9m52kzZzDULNlxWu6uMiDZ4JGa
 r8XtLgI50IyddKs9JjseD/119DtuJazjGuS+4NB/hPIqCTZnWXsPUHX3ao9aFUHiv8BpMC+2Jch
 aLkYB71I72RyJyO03D3dHIOkBpmuFdbN+mEFKkPp0Ih4xCWErg6H26zROMXhpipE0bYmu6Gi4e8
 +NPnSQzFE/YHBHbcYqq+zMevMHEGVNoyzpiRsMTa8fIyv3/dSaaF0lG2kMlZiXQvHBCasn0e3z2
 OnEaj6iHIqzrVVeV9Uc//ClshGcaEfkIipS0v7YMIbSYX6IJqox8Ji4GIBt4p3pVrutLvQcjgFp
 dKX8T2w/tWiVPro+ezg0eUFvTSGKA7mrVuJpUDrRkyuEHDepQmdayKFKlDInNCt9wU10C6WF9Kd
 /YLSptL30aujt6BP693w7Xy7YDtTBx0vyAgsNpEhuemHSouhvXf290Lw==
X-Received: by 2002:a17:90b:510b:b0:37f:eda5:5169 with SMTP id
 98e67ed59e1d1-380526d0477mr1902250a91.13.1782799485253; 
 Mon, 29 Jun 2026 23:04:45 -0700 (PDT)
Received: from localhost.localdomain ([45.67.201.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-380532d4563sm988387a91.6.2026.06.29.23.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 23:04:44 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 phasta@kernel.org, tursulin@ursulin.net, akash.goel@arm.com,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH] dma-buf/test: add KUnit case for dma_fence_dedup_array()
 empty input
Date: Tue, 30 Jun 2026 14:04:36 +0800
Message-Id: <20260630060436.1527498-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

Add a KUnit case verifying that dma_fence_dedup_array() returns 0,
not 1, when called with num_fences == 0. This locks down the
contract documented in the kernel-doc and prevents a regression
of commit 77a9298741f8 ("dma-fence: Make dma_fence_dedup_array()
robust against 0-count input").

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/dma-buf/st-dma-fence-unwrap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
index 4e7ee25372ba..72dea6091d58 100644
--- a/drivers/dma-buf/st-dma-fence-unwrap.c
+++ b/drivers/dma-buf/st-dma-fence-unwrap.c
@@ -370,6 +370,15 @@ static void test_unwrap_merge_seqno(struct kunit *test)
 	dma_fence_put(f1);
 }
 
+static void test_dedup_empty(struct kunit *test)
+{
+	struct dma_fence *fence[1] = { NULL };
+	int ret;
+
+	ret = dma_fence_dedup_array(fence, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
 static void test_unwrap_merge_order(struct kunit *test)
 {
 	struct dma_fence *fence, *f1, *f2, *a1, *a2, *c1, *c2;
@@ -595,6 +604,7 @@ static struct kunit_case dma_fence_unwrap_cases[] = {
 	KUNIT_CASE(test_unwrap_merge_order),
 	KUNIT_CASE(test_unwrap_merge_complex),
 	KUNIT_CASE(test_unwrap_merge_complex_seqno),
+	KUNIT_CASE(test_dedup_empty),
 	{}
 };
 
-- 
2.34.1

