Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEE606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tYsq9oqL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F54310ECBA;
	Mon,  2 Nov 2026 10:46:57 +0000 (UTC)
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com
 [111.22.67.137])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3FCE210ECD5
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=tYsq9oqLM+7lQixDkQIKNZ9ALsqlBAjVve+XIkTCo+JGrX3FUzK6n+179pwhUDdGT0oMGSFz4bLc4
 bovP/6OxE8/bxIetjBHmPVji0o5ySYe9wzVHd2lON7qoLwd+CJlgzJ5vkpOtP2snhJyj7sLFjOnDBD
 zz2MW7hnTuYO2W5I=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86ae86a15aba-29663;
 Mon, 02 Nov 2026 18:46:45 +0800 (CST)
X-RM-TRANSID: 2ee86ae86a15aba-29663
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
 by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6ae86a14bfd-7b547;
 Mon, 02 Nov 2026 18:46:45 +0800 (CST)
X-RM-TRANSID: 2eea6ae86a14bfd-7b547
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] drm/exynos: scaler: Fix runtime PM reference leak in
 scaler_commit
Date: Mon,  2 Nov 2026 18:46:42 +0800
Message-ID: <20261102104642.925-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

scaler_commit() calls pm_runtime_resume_and_get(), but when the
scaler_reset() soft reset does not complete it returns -EIO directly
without dropping the reference.  On the success path the reference is
only dropped from the frame-end interrupt handler, and scaler->task
is not yet assigned on the error path, so the interrupt handler will
not drop it either.

Each failed scaler commit therefore leaks one runtime PM reference and
the scaler can never runtime suspend afterwards.

This restores the pm_runtime_put() call that was already present in
the error path before the conversion to
pm_runtime_resume_and_get().

Fixes: 445d3bed75de ("drm/exynos: use pm_runtime_resume_and_get()")
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index c8a1b6b0a..dc8189685 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -372,8 +372,10 @@ static int scaler_commit(struct exynos_drm_ipp *ipp,
 	if (ret < 0)
 		return ret;
 
-	if (scaler_reset(scaler))
+	if (scaler_reset(scaler)) {
+		pm_runtime_put(scaler->dev);
 		return -EIO;
+	}
 
 	scaler->task = task;
 


