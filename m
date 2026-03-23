Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E280FD58CBF
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E45C10E44A;
	Mon, 23 Mar 2026 22:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YkCS/Gxp";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C43210E474
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:45:14 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-486fe2024a9so25449145e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774305913; x=1774910713; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=66u/VBwHFIYtSS0ffR+AH+e9AgRhJBGf6jfFuy18y7Q=;
 b=YkCS/GxpJnEVTlKO8ztWdRV/vsXQijEsAeLqnwpRy4km3OQFNU4NjRO2TPxzYL9Wt3
 +9Ax3czyyxWjJFy1m9LRd77Vx7jhzxoLtG7JtxrOCgv5D4uRXZx8mHPlHqkZ04iDWyQ5
 YheUFrgk0F0a2hM/LQuCqLZrMVKfa2h6c8oot5BM65nTJpN0zuCsPfoJxVrQjnRDwAGb
 5sGv9vytO1PgZTFYMxWjNIkAHPi5LZJEoYtPy68SY7yKq0+He8wJzSMVc8ufxacuK9Ft
 tegRgYY7eAJxEbn6YbJaeN85IQZvbIfbvp+UP1O/FS++e1EkLNsP3Db2vUgiVaA83O1w
 uFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774305913; x=1774910713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66u/VBwHFIYtSS0ffR+AH+e9AgRhJBGf6jfFuy18y7Q=;
 b=AyHD1x1zcJFKvtFL1XRJQFzMB7tgkypUmUOVxA+IHUn4UZV5naYNv8iarexFXb+ge7
 UHNwddlFPCkHBQGOFjGOf+hEtiBzwnlJQNzEdb5Sq/jcTouZybSoJmInvSe2gMXcVn/T
 EbgaSV/oOFihlJRAP9IPTwfbEWagFEV5niI/C7wzBOKvAjMi81sdktvpyJPf/Vd/OrOT
 iwxNGmq9M9MLgrNKwzwqk59YaI24tQ5KMYrQZEUt1uu1c1nPLQq8K8qtTFX1Ly9dVHHQ
 WBM5PM7UYdlDauxqAyorGGwUJVUeVixgeV0i4X7UqV3N6UFK7IfG+KiDxol+aDakjusA
 0LxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtasH9QSrmcPPGY0orrYf1LkNb3y/kDoKNmk+oVBNmAEfVmYSJ2zcl2Gd26539o64V+YWh5HLnLQ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxsa4GlfXfRmutUsxXvex9e3N6NDP4/FNp8k0X9k5i7MYEKC1fk
 lKp2hm7fukVDRmSm5RVanvgNgMUhAdkvukPt9BMfyuv2h+cpJY5h/Q/A
X-Gm-Gg: ATEYQzydwLENPgRl+dOwlvNRdbWX1w9emYOzmo4Di+7Ituh8A6W1pU4anZpuctPpY6u
 bfdoSzfMtuOirzGTKqjRA6imtBaR2IpVFxEReR1Uun7wT3XIH7pNBZLRgpqmy1N0dM15kZojInQ
 vkN3OGjoOApVuEgpaawMQHbpB/HhjJskf6/8rB4FcEPDonNFMH0WLWzF964ZJLyPPN3KtHPEtrY
 5KQyR13FNpz8CETjU1fE3/CPuw/okPG3gOQvNmLtXOmjmp96Qwuz7+g57n/v+nBtuD2t3QV6fZq
 +facz1VAklrkvMf/u2yjHdsxS39CQ82sFk1SRkNrGk77GORhle2Drx/XQtqACrYi/cCh9CV+Sy3
 vSsR8d9cOsJuHEKDsdFVuRrRkRoCkmW0T5TK5xhUa9aWPYGA8tM3CcoeEoXKTIVdZnrq6KtbSut
 AN216FFXsFRqaXi55zY7Gx5A==
X-Received: by 2002:a05:600c:1d15:b0:485:2ce2:4c75 with SMTP id
 5b1f17b1804b1-486febbc648mr193158595e9.1.1774305912768; 
 Mon, 23 Mar 2026 15:45:12 -0700 (PDT)
Received: from localhost ([87.254.0.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4870f6d5fd9sm4775495e9.4.2026.03.23.15.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 15:45:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][nexr] drm/amdgpu/mes12_1: emove extra ;
 from declaration statement
Date: Mon, 23 Mar 2026 22:43:48 +0000
Message-ID: <20260323224348.343495-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a declaration statement that has a ;; at the end, remove the
extraneous ;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5dcc2c32644a..0e9089544769 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -2227,7 +2227,7 @@ static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_bo *meta_bo = NULL, *ctx_bo = NULL;
 	void *meta_ptr = NULL, *ctx_ptr = NULL;
 	u64 meta_gpu_addr, ctx_gpu_addr;
-	int size, i, r, pasid;;
+	int size, i, r, pasid;
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0)
-- 
2.53.0

