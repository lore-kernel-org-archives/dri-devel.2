Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ABBF8E49D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE68910E96B;
	Fri, 17 Apr 2026 07:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onatbaker.dev header.i=@onatbaker.dev header.b="bduiJvPe";
	dkim-atps=neutral
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F2910E24F
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:48:16 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso1632795e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 16:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onatbaker.dev; s=google; t=1776383295; x=1776988095;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cqr7D/SMiGCFOcynGjh+DQXRaU3Cg9DvCAA8s/ypA+o=;
 b=bduiJvPeHbAMwz7AcZQNowjPdWpYURIl0mpRN9H+qWSBXHNC745CJ67Xmxjg8at6wD
 eZEUY8UDcGrDN4mSwLxKGgLMXSrt6TQhMvwN2VaNBOnMmdU1wt6NY0UTRsjXEf90J0w9
 eaR+qw5Gh5TXQoHKno7001NoHc0Ugx4szRnBi1nMqDv+HsuUtyeWORCQziad5VAANOla
 p3gHeGxk5hJi94jVLXVdOnRqf9DudIvVdNkDeN163diuIU4405RXIq2Wtq2yHPOOoipC
 aS07PtF+6tTlcyRwHg+k8Y5emnY/vNh19D5ZdhPHsN8v2UOAf4ar2Y3E2XbSRMDjQLbI
 0iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776383295; x=1776988095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqr7D/SMiGCFOcynGjh+DQXRaU3Cg9DvCAA8s/ypA+o=;
 b=HVtmQoqT8vO3XqyUhLyp2FnNCjolYOkA9+DVhPluVWNWtuQ+t09EfwVhH/yfdBD/hF
 H1CQe+De3GK3k/Xm1ck5V4rWLTwPJjhckYdELKqtZA3VxGS+AqkbQvACOgpESd53nQSL
 vmmcRChNfLLk9FWiEBGFS4loYZW4UNUng/RQEIGHIn9t4iqpKY4jqFwIzbIM6a3tE5rA
 +67CStD7NR/TbGLH17tWvEzYw3FWmHwA3Dk1V/mdcfjq50zfu2I6tggQtukQJKBVY2YZ
 RlnOy3fQhUlLL/i6fip1XT1Gnp7FFCgh1mpkpjw48kH1tjadW4so0vpARhPBTSvS87qy
 kj4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nM9KWMBo1axAlmtTAmYddMpaYOh/m6XzOVSEghJuYg2PiM5OEfAK9mPXcDX0Hi64QYMfRAp7S8Qg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJ8PhfSdEwHjUV6ibKtFWexCT8pbfRJdENzn9TdX43zjYRVhjf
 ewkAyRWWM+uFZFFaPBDYpc1jCNY393i2iFJGu65DM2h3aVkgFPJaCUOmRtSOmESIlPW/
X-Gm-Gg: AeBDieto1vc8/PgsjfzPqAYKbLbzU5f3Gga+cX6+5fBaAid/iqOaCq5s59Mmr8jcYhF
 zrbtRHi6vjQ+LQLkDbVd5FTcU6m1ENbKL+RKJ0if9B8ucBKKVoZ3/D8/wdTrTgAmvOEWQAZswUd
 7KUAijPN6LWKX46DelcNIgoSoKNbXVYt5/QJ2b9MFenelZMVJaiqTn+f/u6NUYz7XKfh6EhS06D
 gj4UVluySkM+vJKSVzkXWhyjUtpU55Nec5oXARzGVJCvYchOLoB//1VGNkaZ+Bjp7Hobta7TRIt
 CvIuE7jBy70tadeca3bUQvf9NeGR8Xempx4t1f4zJBoMscceDo20El9hEIJak7N48WMCp8idZI4
 O4DRZRya7AAOGSo7RRct93tkSyMJR9jYtMWUXILh9Csw8/CKtkfhi5A/GJo5sNQrpNtd185rTjm
 ULd+AWxs9WmCiBY9xekqk63t8PDAxVSW0iE9GmNx2z4yUpOjtV3ngY052cnkjBNVSbWk5Ke2o3L
 onvxw==
X-Received: by 2002:a05:600c:45d1:b0:488:c14b:201b with SMTP id
 5b1f17b1804b1-488fb74fcd5mr7797565e9.10.1776383294314; 
 Thu, 16 Apr 2026 16:48:14 -0700 (PDT)
Received: from localhost.localdomain ([88.233.160.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb794d2esm6142705e9.6.2026.04.16.16.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 16:48:13 -0700 (PDT)
From: Onat Baker <onat@onatbaker.dev>
To: ogabbay@kernel.org
Cc: koby.elbaz@intel.com, konstantin.sinyuk@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accel/habanalabs: simplify function pointer checks in mmu.c
Date: Fri, 17 Apr 2026 02:47:14 +0300
Message-ID: <20260416234714.8143-1-onat@onatbaker.dev>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:15 +0000
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

Function pointers can be tested directly without an explicit
comparison to NULL. Simplify the repeated checks in mmu.c by using
direct pointer truth tests.

No functional change intended.

Signed-off-by: Onat Baker <onat@onatbaker.dev>
---
 drivers/accel/habanalabs/common/mmu/mmu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index 6c7c4ff8a8a9..222cd6b77891 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -50,13 +50,13 @@ int hl_mmu_init(struct hl_device *hdev)
 
 	mutex_init(&hdev->mmu_lock);
 
-	if (hdev->mmu_func[MMU_DR_PGT].init != NULL) {
+	if (hdev->mmu_func[MMU_DR_PGT].init) {
 		rc = hdev->mmu_func[MMU_DR_PGT].init(hdev);
 		if (rc)
 			return rc;
 	}
 
-	if (hdev->mmu_func[MMU_HR_PGT].init != NULL) {
+	if (hdev->mmu_func[MMU_HR_PGT].init) {
 		rc = hdev->mmu_func[MMU_HR_PGT].init(hdev);
 		if (rc)
 			goto fini_dr_mmu;
@@ -65,7 +65,7 @@ int hl_mmu_init(struct hl_device *hdev)
 	return 0;
 
 fini_dr_mmu:
-	if (hdev->mmu_func[MMU_DR_PGT].fini != NULL)
+	if (hdev->mmu_func[MMU_DR_PGT].fini)
 		hdev->mmu_func[MMU_DR_PGT].fini(hdev);
 
 	return rc;
@@ -86,10 +86,10 @@ void hl_mmu_fini(struct hl_device *hdev)
 	if (hdev->mmu_disable)
 		return;
 
-	if (hdev->mmu_func[MMU_DR_PGT].fini != NULL)
+	if (hdev->mmu_func[MMU_DR_PGT].fini)
 		hdev->mmu_func[MMU_DR_PGT].fini(hdev);
 
-	if (hdev->mmu_func[MMU_HR_PGT].fini != NULL)
+	if (hdev->mmu_func[MMU_HR_PGT].fini)
 		hdev->mmu_func[MMU_HR_PGT].fini(hdev);
 
 	mutex_destroy(&hdev->mmu_lock);
@@ -111,13 +111,13 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 	if (hdev->mmu_disable)
 		return 0;
 
-	if (hdev->mmu_func[MMU_DR_PGT].ctx_init != NULL) {
+	if (hdev->mmu_func[MMU_DR_PGT].ctx_init) {
 		rc = hdev->mmu_func[MMU_DR_PGT].ctx_init(ctx);
 		if (rc)
 			return rc;
 	}
 
-	if (hdev->mmu_func[MMU_HR_PGT].ctx_init != NULL) {
+	if (hdev->mmu_func[MMU_HR_PGT].ctx_init) {
 		rc = hdev->mmu_func[MMU_HR_PGT].ctx_init(ctx);
 		if (rc)
 			goto fini_dr_ctx;
@@ -126,7 +126,7 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 	return 0;
 
 fini_dr_ctx:
-	if (hdev->mmu_func[MMU_DR_PGT].fini != NULL)
+	if (hdev->mmu_func[MMU_DR_PGT].fini)
 		hdev->mmu_func[MMU_DR_PGT].fini(hdev);
 
 	return rc;
@@ -149,10 +149,10 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 	if (hdev->mmu_disable)
 		return;
 
-	if (hdev->mmu_func[MMU_DR_PGT].ctx_fini != NULL)
+	if (hdev->mmu_func[MMU_DR_PGT].ctx_fini)
 		hdev->mmu_func[MMU_DR_PGT].ctx_fini(ctx);
 
-	if (hdev->mmu_func[MMU_HR_PGT].ctx_fini != NULL)
+	if (hdev->mmu_func[MMU_HR_PGT].ctx_fini)
 		hdev->mmu_func[MMU_HR_PGT].ctx_fini(ctx);
 }
 
-- 
2.47.3

