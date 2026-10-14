Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733C1CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9A710E335;
	Wed, 14 Oct 2026 02:49:24 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DB510E335
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:49:18 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3ac397836fbso1179721a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 19:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791946158; x=1792550958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G3ebFU2EzDxFvfDoimfKN4m5wsDUUHnrmGXuZIPxGIs=;
 b=niQ8QMbUVeOYYddZAO/2uAzv7q0gCa8rMJFL/6u5ccbTh/6x+m+SOe0/SgHiLfSmPK
 wMWwcavD9n5TJY4y1M3Gyh1nvn80GB7GkywoeeZ8sB86q6TURKQsWiAcC0alqYYIGfIL
 jRjqj7Z6Ji3/oiIx8rZickBetpJ1WW40GZtH1ML231L069vgefJjTLw+m/NyxLsWZJHE
 R2GoUKw1A8xEYmUwbTJOrvne0lowJEiISKjidsga2m8K5HBQ69jaYIgo73NF/eC5aGvb
 Mr2DKqLrvkViu42Ip1IBUtcQgZoMQG2IKojxKjb/9UXgqu0kQgMOGUDYCRJ6jhvSETS/
 tqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791946158; x=1792550958;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G3ebFU2EzDxFvfDoimfKN4m5wsDUUHnrmGXuZIPxGIs=;
 b=TBY9dt+xS9RwRYXDaZbsOCAbd5CwunKHHEujtmTyqsz1NDQeSGk/KvbJwYe6FGOl2I
 S+Y0UF9Qq95c7tJJIP5wIGYbCqEs4vrngmVEfaOFDwDQa7+Iq39fO933z4WcPHNTpBuZ
 BgGkBT1NXm9yZ1YNAP1ooM02pz1CtNPANgu/2I7QvV3legHxXEh3NmS1xCO0qoHYeEjV
 tG7V71roFmpCFBm3yO3290mztuwnRamGLANnvsyQ06eizK1UkvmksBG5hKtXsDelQipt
 rVEsycXbKngZ2Y74AoY/KGc8XoDQgpo9LT7tgbYQDSkG19FyDwiX5AcGNlbdmy/rkJZJ
 C3QA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4Q9gl09axcKBRnDtvD9zt9P4bM3zc7xmt/nwxnlDGS1W7yA5FtV2cE7+fSF9MkwG2/qG2jjVmkbA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwoqkc17booOgijFrZ0e59bd4pHVnrdg5Qq+7D1Krr2Geh0Wer
 dONB3232iNM6unibyIViGdjExLxX+PPwr326Tjav6TCmr+8qlpC4qOAR
X-Gm-Gg: AYBFou22NiLWnrTleD1bOInYLhCkrfEeEiIVZRLegqRu0aKmJoEX3l9yqumNa5x2Soa
 QdA+okb2e5wjL/CheIWKl1vnF0w0dROjpzYt+CGYE+lAWaXJlzX/Gta5R+IhtEkWed/jbMUMYwp
 Bbhy1s3SCc2NumQGWQhZRU8i3nIlFZeMB70Z2ymjxU9k+M7Gk1yHFUXA15KgtU0dik0ze5XfU2J
 I+Ls1jMoO58U2kPygKORFKB9t/4yPC7tAdLQjSJYUmsEpnr/JXh/1sfXgEULx9o1nRBkkllyBql
 +rlmFCMitMwpam6Vgd0fWaIZGROiCPpONU9stgZSy0A9wvyFLR5X11+4Lo1p0NRox9cYvCpcrWV
 4I89k4Bn5IwKzfs3cT5iyYH22woxbA0bNKXyhz2SEuO58ai8s+B9xhvFJ+J4l/tHVTTpEMuzEWb
 e24Pc6O0RrWGLrs5KyoRI6gUSXXPYpNDR86epUNqH+O5omep3ugW8sOns2dWaEXSIGm7mMSNdxZ
 kCyaFmhdIBjZegO1A4rjPFDqRaU
X-Received: by 2002:a17:90b:390d:b0:3a0:9fe0:3aaf with SMTP id
 98e67ed59e1d1-3ab3a7a42bamr12455478a91.48.1791946157601; 
 Tue, 13 Oct 2026 19:49:17 -0700 (PDT)
Received: from drobotics-thinkpad-t14p-gen-1.. ([183.243.208.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac6069ca91sm2227687a91.12.2026.10.13.19.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 19:49:17 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: christian.koenig@amd.com
Cc: sumit.semwal@linaro.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v2] dma-buf/test: add KUnit case for dma_fence_dedup_array()
 empty input
Date: Wed, 14 Oct 2026 10:49:09 +0800
Message-Id: <20261014024909.1769215-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630060436.1527498-1-shoubaineng@gmail.com>
References: <20260630060436.1527498-1-shoubaineng@gmail.com>
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

Add a KUnit case verifying that dma_fence_dedup_array() returns 0,
not 1, when called with num_fences == 0. This locks down the
contract documented in the kernel-doc and prevents a regression
of commit 77a9298741f8 ("dma-fence: Make dma_fence_dedup_array()
robust against 0-count input").

Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---

Changes in v2:
- Add Reviewed-by from Christian.
- Rebase onto v7.3-rc7.

 drivers/dma-buf/st-dma-fence-unwrap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
index 4d9d313b460c..c5353b36f0e4 100644
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

