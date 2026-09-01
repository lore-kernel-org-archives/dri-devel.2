Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22340C624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3139810E7EF;
	Thu,  3 Sep 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iEN6JY+u";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAAD10E3A5
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 07:26:24 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so441025a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788247584; x=1788852384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N0EL/pf1f3ThtoFU4Hf1cFodrWTG5punvyNZKF7Nskc=;
 b=iEN6JY+uVI0kYwd7u8NaKUokprgzC2z8KdGvSumyryWiMaKw3TY/45slpCb27iiB+n
 SGZOqTBHll1eEl/EKOxaeEzbv+iM+cK2cxf6/elOX0TvIK3ZQIJLufBcYoYgMBcAcsT4
 idazcmbM6aL5WH7gquHo9qvHwq5UXkV+xwqB3h5cQgbj7qcgrIow60qmto/cXxZnEY0l
 rUr8THwirpU2cNQO7ytTU8E/uSdoYDkJiSkH2Pc2hcKzX+P0xsQp1DrzBhJwSaFZABEa
 t/NP4JFbpS928e0AW39BzYPT9fzpDlWwQwGr+9ce42hQzUqe9uIy/N0dDd8Lkyn6WjlA
 zRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788247584; x=1788852384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N0EL/pf1f3ThtoFU4Hf1cFodrWTG5punvyNZKF7Nskc=;
 b=nDUWgLM3s2/aXtw1z57ZyIar5IDBUPF9CPkFyjkkFgTCfPFskVF8GG0Enp4PJNx4Fn
 Bclp2o1k2AxeDma51OlAQW+eC2BpmbqYnIT1PTyo+dEvU6OsmmWzhENtckOjQMMjPSiJ
 mIzi8wG0h0AdmXNSdFZ4gbchG0hSBvBNIWlWSuCVhRHm7NSXqG4y+pAlVvCrxSI4sayR
 jEvMZU1OgVrspNyUMbyKkXOamW+o9tEL1OcY5XOm7AuaTEJ2xWjnFGgM7Lcs14uWdJ25
 orz3O56snC1LccPqnG9rq+7Td4gxbOCUOJQPwhmWGSRZDbcZHbny8VCv5Z6sCYnX4/3L
 XO9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOa5pv9Ar/2zUnStaxVu4X+CO13mIKunVDn4FWeuIStDORy4Cn4EdSGOAYaCWDK28aAsKJG9JEusw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlUPM1AGu6dTyim4wjnSnLsCEaB+PhExzPLuHGPXi1El3ZKWgX
 NxUW0T0PNEUHDMM0D7USUq+oyADawylAr8ELp9+UxT8xQs0WokIlbZzx
X-Gm-Gg: AYBFou2iwRqhr8F54iKLgtw3v3h50zU9Lxm5cx+AarjHGCEc5zWNXpJ1cVbLkcvicqz
 Ycgf27mcDN1puzo2PDqmY6Ug021WHPVDY77qKsiDCYMM3tlg8a/nywMgc8tGUAFgoUl/zuzgPMv
 NARW5Xfl+hXhu2WyNDKYAFJefKeb+mhaa18Tn6otNOBhbiwNDglDosC3Atvm4YmmjKL43ponlnY
 oEgpmXLQ56aXpnKVB3RDUJt/chRxnU1GrcNHPyfj2XkYNVCmfr+rtiqLpJCo19DK7fF00Jq1mFy
 chiiJ+g1VQ2g+o9OCshjOZUZKO9Y2ifGO0tVyRHWNjt4+fgPoucZrh1d8vpubCssD2rrtlHoqoH
 SXBw6I+Bc8HJC8LStffyV8ZqW1h3+7bc1gHHN/Zc8CKI11dFmWYCoFKS+rJVLdw4wyjVwzf3qiG
 fpVtY7rIx0OuGzdd7LynpSnmmrObQqMM2ASzuURPCrA1u28RisOseMmMqtVbp2zhaYiy4a
X-Received: by 2002:a17:90b:2c88:b0:396:b98b:a3c2 with SMTP id
 98e67ed59e1d1-396d0f52a0amr51476456a91.8.1788247583735; 
 Tue, 01 Sep 2026 00:26:23 -0700 (PDT)
Received: from i386.168.1.127 ([2402:a00:163:2ce9:6882:91b7:8e79:7958])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0dc898dsm32895480c88.9.2026.09.01.00.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 00:26:23 -0700 (PDT)
From: Hrushiraj Gandhi <hrushirajg23@gmail.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Hrushiraj Gandhi <hrushirajg23@gmail.com>
Subject: [PATCH] drm/amdkfd: use kzalloc_objs() instead of kzalloc() with
 multiply
Date: Tue,  1 Sep 2026 12:56:14 +0530
Message-ID: <20260901072615.522925-1-hrushirajg23@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

dqm->detect_hang_info, dqm->hung_db_array and dqm->hqd_info are all
allocated with a hand-computed count * sizeof(TYPE) size. If count
were ever attacker- or firmware-influenced and large enough, the
multiply could wrap size_t and produce a too-small allocation that
the code then writes count-many elements into.

kzalloc_objs() computes the same size via size_mul(), which saturates
to SIZE_MAX on overflow instead of wrapping, so the allocation itself
fails cleanly (already handled here via the existing NULL checks)
rather than silently succeeding undersized.

dqm->detect_hang_info_size is left as-is since it is also used later
for a memset() call; only the allocation itself is converted.

No functional change in the non-overflowing case.

Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 67137679a901..5aa42fd5bb49 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2013,17 +2013,15 @@ static int start_cpsch(struct device_queue_manager *dqm)
 			      NUM_XCC(dqm->dev->xcc_mask);
 
 	dqm->detect_hang_info_size = num_hw_queue_slots * sizeof(struct dqm_detect_hang_info);
-	dqm->detect_hang_info = kzalloc(dqm->detect_hang_info_size, GFP_KERNEL);
+	dqm->detect_hang_info = kzalloc_objs(*dqm->detect_hang_info, num_hw_queue_slots);
 
 	if (!dqm->detect_hang_info) {
 		retval = -ENOMEM;
 		goto fail_detect_hang_buffer;
 	}
 
-	dqm->hung_db_array = kzalloc(hung_array_size * sizeof(u32), GFP_KERNEL);
-	dqm->hqd_info = kzalloc(
-		hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info),
-		GFP_KERNEL);
+	dqm->hung_db_array = kzalloc_objs(*dqm->hung_db_array, hung_array_size);
+	dqm->hqd_info = kzalloc_objs(*dqm->hqd_info, hqd_info_size);
 
 	dqm_unlock(dqm);
 
