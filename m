Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738E9C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377EC10E641;
	Mon,  7 Sep 2026 07:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n9htONbg";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E6310E076
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 01:21:32 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so28784575e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788744091; x=1789348891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YmOFZGPGcCK6Y0QrzfV8plOfwnEVFP/2ncqINvatcs8=;
 b=n9htONbg8rxyl5+JLQOQBF0CzBBkqpVsEG1DL5WF1MtspWPqESPqUni4mvGxceSsrT
 QgDAoDdafrqivZissI2KaUaPu5Oi/ng5CjZsjVNNqYgmIDh0xyFT0SESKxTyCFXJ6O5f
 gbXkX1W5k0b9UtTXQ5qV4fB1yoNtap/a9rerToBj/McVBPUkEw+LODmVzbGUZ2/zbWa1
 I2L7yB8okb1rIbJi7RP64PWmEIIVTi48gICyHn2uH7O8bbya+0hYzrMTUQbj/titVSDV
 1NI1LQzenRRBuqPaYhiSQvsmisZl/P3BVzdyJoiJ3Sk6ODvWQHt3FCSSVJgDAOuhQk0D
 gilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788744091; x=1789348891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YmOFZGPGcCK6Y0QrzfV8plOfwnEVFP/2ncqINvatcs8=;
 b=dm+B4gCYKreM4jn9fwQOYyT8kEfjQ+rTt0vJ96J7gG0Ts9bifXoSfEk8B8dRVcsKhX
 0ehthM70VodNILZuuMNMwKerKwjtvXljY11sGET2HvC1R+4rAeNocgI/IpBgZS/bKIeR
 gK8MjB45D5WmTuMuVkSJuqCwKNNALu2Yxa7ZpT3vcezLpa9sBP+XhzMrE83fMcSfkiVC
 LYXtn1C8Fq1Sr88rnTAy6jQmxR42pMAA+stVmnWacpGXlMYxITzcyzB1ROY20pTmGrt8
 ulq/pGCTOANPaQSEvYXO5dSq5KJaUpSmYkiIbgxv7hnAk5C+ysHu8l63UmbrL1j07QTZ
 8j2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwr3Q/FqO2ZYL4LexZPAd+lDq/GBPv6OuteGfgZKZpA2BsxoTLcif+NVGM0Z6W0euIjuoAzdBe/Z/E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nFBv9jfAorIh99FQBPuUvIQs8cSFtrmb4u5HIu9LDlUkw2hW2L
 AknLTlmJaslnBak516LsfrrSkzfRKpjmrhz+zBZKY7DbAPHxkJcMZXX9
X-Gm-Gg: AYBFou0lV7gxX0sd7Hu8tpV4peNHExDYkh+VBFIJca4JxdMG77R+bEmoNCa2m4OJ1MK
 1lDOBxfIQ0B2m9JNDepRtM5wapP84UMxxkqfHszOL3ozLstENtJbh40LjUCSe2zKiK4IEO9e3N+
 klgIN6O2TKVSxpmNpnQa2MxpccLIfGCZ0Sa32QzLmbUp70+kEPHTgh8Bb80sfCdVf+p5J2Q3Y7X
 EHlVDyGY9fu+wc28KtAI2l4EdEr+2B8fROpJRchXkjVA9hA0qAd1+ZNNGVCFyQiUWaAp+IU82wG
 CCAZ5y/TqPsDgf/IIXclGmxCP7Uh7oebIMxuWn+QJeu7IwOtUaQazW+c4UuskdgALloZRx75Lpf
 GAK8j0c+4D6us0LngelCLztcXduZxalfGIjwThTJUFMpe7ZVMSgf8jdQc2Cl8XYQl7ycSJv8O6r
 zSS8mUlt4LJ4EQoO7k+WwAas/8KwEKXOKV4WAFheKNtxyI7WSGsjK4PVFKrfj8yMTKI64z7l8Y0
 2t6XiByEIvQMQd/9TdgQ1pYoJcnnu1FSB8zfQGc6CqHwl33tnM7H0K3RYoL2uLYyo5m+Dp0pc49
 7uv6wO3lwFDF4NhCbGPXvcnpAfT+RY43PYPpZdJcLMnhp/zX5Ys8k8VLmOJdL8uUh1U=
X-Received: by 2002:a05:600c:8b11:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49cf82417f7mr462646815e9.10.1788744090799; 
 Sun, 06 Sep 2026 18:21:30 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de.
 [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1064e52asm18604065e9.0.2026.09.06.18.21.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 06 Sep 2026 18:21:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] gpu: buddy: Drop the stale @p line from the gpu_buddy_print()
 kernel-doc
Date: Mon,  7 Sep 2026 03:21:25 +0200
Message-Id: <20260907012125.21209-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

gpu_buddy_print() takes only the allocator since commit ba110db8e1bc
("gpu: Move DRM buddy allocator one level up (part two)"), but the
kernel-doc still describes a printer argument and kernel-doc warns about
the excess parameter on every docs build.

Drop the line.

Fixes: ba110db8e1bc ("gpu: Move DRM buddy allocator one level up (part two)")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/buddy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index a5553fcec28c..cc993909b79e 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1591,7 +1591,6 @@ EXPORT_SYMBOL(gpu_buddy_block_print);
  * gpu_buddy_print - print allocator state
  *
  * @mm: GPU buddy manager
- * @p: GPU printer to use
  */
 void gpu_buddy_print(struct gpu_buddy *mm)
 {
-- 
2.53.0

