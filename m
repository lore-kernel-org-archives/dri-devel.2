Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064A0C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A1410E6D0;
	Tue, 22 Sep 2026 15:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L87tZLu3";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804C010ED78
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 15:38:56 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so29765755e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790091535; x=1790696335; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F5jxz2R7aklALF1c07VlaANJo82uSjv4mznBGg6lztU=;
 b=L87tZLu3ZYlqt4tEAkAXNgnaM4AUUqvzjfnJSHnw+84IzWskxIm10bzJxsGnuuAXbD
 AoDFGDGaB5eX603sNycEvZ0vJKekCfHt15TspRnHo39r99dy6brc6ab9dchmiehO7nkf
 JI1ud3iU50XGVQV3fjlE1Eh6aDdXx6HIUa8QBssAlY7pT1TTeJ2YikQ3oD3Go84q27iq
 CB/JR+LkPSQUIRwIf5OpuXL23a/j4auZ3AZuACNkQ8nLCoqHh/oIBy2KYa8P32Mm1lCF
 23mXPXikyLzg7CE78QzOPm5gZOPwMOL+C7Tt59XyP40L48bXzZfo7bNdVi+rNRiEvzdu
 vUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790091535; x=1790696335;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F5jxz2R7aklALF1c07VlaANJo82uSjv4mznBGg6lztU=;
 b=jH5ZZrkZbY/by8Ql73rrPOTMRDNHcFr6RysIM4p+xG38kK9x49eIV4eCfy3iDxSqTl
 4JzAc1zHxHGpQgZW5t06n/BgBDXz0A4gfZVFgjKkIHpxS/ttJO+SMOSU2vGvdDpkzT6/
 /RYLr65BkM4Yzr5HbekBXvaQLaaBR7llYIfaKzc/z2xlUp5hWDJvxeuTkgDyTpSI5qlB
 ZgFj1bS20Qv2vI2TZtVS3rGmhtqZxunTn9rKaLR9oUVgoEiG2NHj4THaqw+5Tb9aragx
 LZAdJBm4D8ALH/P9diragB3QGMSeSRPaooFJPTKLVjIA/5UOLS9k7k5HhxCd3SgbQzH3
 H8QQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3UEHp/vEHVYFI+vKqzk2zPkyn9MBo5fAPa6K3hyRYwspB9nWoyaXKaiSnd1M2qA3k7nAaxhLftj0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kud3lNLg+Cuc6S1ZOaMeNln4gzTpebZFz8OanBDWw3WpJWJ5+t
 Ql7/6fm+X6L/UmuNjGPNEwUxgJ4RlyMq5RwqVvyOcAa5mImLQtqlbZ9o
X-Gm-Gg: AYBFou2A8yJz4C7K0SxqHIMXqqtbBD2ydynvuIeCYszypd7RFzHq1SveDgIWlRHMIOc
 y7V5B3c7lHDvULKlgUMWX9DDHv38G3pMtlkZLNF8uYwoK/cs3y3V8wwkd4Yem/S4ScG4OXdnDjT
 8r1orm7yezDz/Uamh+QmTdMisbpbDk0pWaVrlflmBXtnRp7dlZR9iEXko8IKe8WbnC5sO8+6CmK
 Fv6HR5CYXP5/aXXAp4UjQcjD1ZQ0s2iP3+sOghcBeWh3zHB61MMCFGU25ub2uRsodyS7U/qgFb8
 jW6SWNR6PPzfOdm4wxCVwMxrigK3UWPTQz1wvOR1oB5NHeBnQ5kC10lAePPKHmMnKs+Xqg69867
 gQsWIlvKG+y884wj3p7q3duFBa+KozDHbQPon6bAUFb370bcEygDvA3YvcFq1NzkEfMQNdOhMI0
 9c+A3HK8UiIVXR/sPk6w74BG5zgRFOsqPC+NuIa2rc8S3asTVotyIA+6VoTWAhA/3/kuctCojRY
 lumoQDJuU9lSO7i2Bmxh71rEvUQXkKXbZ83gWMB0WcQPoc=
X-Received: by 2002:a05:600c:468c:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49fc56811dcmr212862655e9.4.1790091534593; 
 Tue, 22 Sep 2026 08:38:54 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862786f40sm5410966f8f.27.2026.09.22.08.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:38:53 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:38:52 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: unmap GART dma pages before free
Message-ID: <arKhDFCSoPDNYaxX@michalis-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

amdgpu_gart_table_ram_alloc() maps the GART dma pages
and neither the error path nor amdgpu_gart_table_ram_free()
unmaps those pages before freeing them, which could leave
the device writing to freed memory.

Fix by unmapping the GART dma pages before freeing them.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf..780fb01530e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -209,6 +209,8 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
 error_resv:
 	amdgpu_bo_unreserve(bo);
 error:
+	dma_unmap_page(&adev->pdev->dev, sg_dma_address(sg->sgl), adev->gart.table_size,
+		       DMA_BIDIRECTIONAL);
 	amdgpu_bo_unref(&bo);
 	if (sg) {
 		sg_free_table(sg);
@@ -240,6 +242,8 @@ void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
 		amdgpu_bo_unreserve(adev->gart.bo);
 	}
 	amdgpu_bo_unref(&adev->gart.bo);
+	dma_unmap_page(&adev->pdev->dev, sg_dma_address(sg->sgl), adev->gart.table_size,
+		       DMA_BIDIRECTIONAL);
 	sg_free_table(sg);
 	kfree(sg);
 	p = virt_to_page(adev->gart.ptr);
-- 
2.43.0

