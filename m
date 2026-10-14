Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF95CC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933C410FAFC;
	Wed, 14 Oct 2026 06:05:46 +0000 (UTC)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204C710FAFC
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:05:40 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id
 2adb3069b0e04-5bcb440d1cbso336561e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791957938; x=1792562738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZKHQJZbsU0Ua86VI1CZpz7LRBcGg7w/QDW/s3ZvmOOs=;
 b=efuoBxypoIG+cnLDfp5bYMvRGKERnYiJVxtLvOtH2R3oCDqAXkzMQyrjQ38hY60mE3
 YQvqwoOQGtXYmV89VS/4yvTbvjEnlQ1NhCoFn8Qr71hxK1luigW6lgE8rVsMH4EkfFdo
 jw8EppYDWMNpl5esZvZMEJLDBy8Q0xUtKMcb89ufYTm/mgvzaB3ph1HZqSbmX6i+CxHq
 O1Lk7OC1noHW+qlvWLA3IZAWCV1W+stvJNAjuDmWAwsRZj2R4ULcnjrR8xJtzccE7auN
 BYYnIx4SIwDuAoF0yKZhsmZVvj24bMP36l6uuCddMTPuKpFm7O5fkyEgkgkRqgXI6/qu
 S5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791957938; x=1792562738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZKHQJZbsU0Ua86VI1CZpz7LRBcGg7w/QDW/s3ZvmOOs=;
 b=b0+c6Mdtu14sTNzwNQOnnxjV0iAuuuxu2x7GncsmDpQOLy/oJZEkp4RZhy9KVwqcfo
 lXvERyAcKrtzoGPJr4KSWZO+tmOWJQILXYf7ViVOnPEUISqboy/VQ4T54CZTmWUzaANv
 Y0/efC4H+9NTKssFo8LuroswS+Mhv5p/aptwDBrYSNztVEbTwvvdUc3Xb70G0kEq3bwZ
 Rw91NL0/RL7gcRZ6DkUoLzEfXzbFLhW6A5CLY8fruT9G3nR5R/iKplR/YkoqCrD1AXvG
 bC7qbpybFjquXJA2DaymnqONvaNFC4l5dnuwQi/kIrZaPayZhOLc1u+vD0BJqQeV124Q
 J0/w==
X-Forwarded-Encrypted: i=1;
 AKwUvByX0+DNctgzRmtiC2vhVbbWLJyva2otMplAEBinAOvIhfwRsNcsFPoT5fMZCsYD3wh8AL/Gj4og0vM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJPe0wkkHA/2Jr8ioblrEYLmY0315UJwMClKKwoi3pmVyuAlejH
 6LMgTrhw/AU0P/uI9Teh+xmRzc0AZOvYn3T6JuP9uDSS2gcciDlNh0jK
X-Gm-Gg: AYBFou372tGWnLQmctPXyzA9CTH+N/7gI+vxFt5eEfeVJW5iEhPCqAsXNiy9m8KweOD
 KSIr3r3GcdanrgOioTxPqw27PEuvxC7qRyf6dCxtqxRSXRL4GQt1PAHcLFonciVoSafIEo1ovAa
 S3LbV/vVyOg4JmkNOFKRkEAQatmiv4ErEGEEX/U0W5MG4IJpWrmIWu9Y37e9EW0M63bmX/XnK2o
 MYl4+TTCJKHuKDO4EjafUhyKihFbQp+gcTXI8UQg0dC/s3Ud/R4+TTz9j6VsiPcVYHi9wy1v1uD
 USJEU/HGZtu0L1PYY8NimubFtTe3IY50afCKCoEx45PTKfRQeFlHw8xIQPiAwecVAn7uFGJKJ+P
 yGLg64n6evy0IxLflyhcpXRzFCOUzavpnq4IRPxNLrQqADEVu+PLPVD9qhzeBCVxjW0Cis0zlfD
 uB+0x/2yRKhxce2nUXuxC0RyQwOQ8m8jvm0wIODOa7l8QuFeylSyUb+t644j+jh6AbhCua9ImRx
 RiGNxKQ/t0mFJ9o
X-Received: by 2002:a05:6512:3f08:b0:5bc:cbe1:571d with SMTP id
 2adb3069b0e04-5bcdd559e1emr4705089e87.44.1791957937938; 
 Tue, 13 Oct 2026 23:05:37 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be34c726casm235360e87.46.2026.10.13.23.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:05:37 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Benjamin Cheng <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] drm/amdgpu/vce: Prevent partial address patches
Date: Wed, 14 Oct 2026 09:05:19 +0300
Message-ID: <20261014060523.4685-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

From: Benjamin Cheng <benjamin.cheng@amd.com>

commit de2a02cc28d6d5d37db07d00a9a684c754a5fd74 upstream.

In the case that only one of lo/hi is valid, the patching could result
in a bad address written to in FW.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Roman: In 5.10/5.15, amdgpu_vce_cs_reloc() does not take a struct
amdgpu_ib *ib argument. The conversion was carried out by commit
cdc7893fc93f ("drm/amdgpu: use job and ib structures directly in CS
parsers"). Instead, the IB is obtained via p->job->ibs[ib_idx] ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53375

 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 0a28daa14fb1..9b0efddd145b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -634,11 +634,15 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 			       int lo, int hi, unsigned size, uint32_t index)
 {
+	struct amdgpu_ib *ib = &p->job->ibs[ib_idx];
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_bo *bo;
 	uint64_t addr;
 	int r;
 
+	if (lo >= ib->length_dw || hi >= ib->length_dw)
+		return -EINVAL;
+
 	if (index == 0xffffffff)
 		index = 0;
 
-- 
2.53.0

