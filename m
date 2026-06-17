Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D529ACD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB61B10F1B2;
	Thu, 18 Jun 2026 07:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cFkfjMml";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5692210F0F7
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 19:33:41 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2c6d31bfc70so1080015ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781724821; x=1782329621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iQZtMnehaDPaW/1htcuGu1b4iDiFaXM/HgU9tJx9XaY=;
 b=cFkfjMmlX5TmPxmOR6QDqmiShCqSi4gxgvRkMatokxOS0xvDeKgAjHvPvjb+5CvW5U
 NI2iBMG5fP+8ZjWjie3Yc98yHI19At9/Kl0obWt+bVtmJCSgv8xKvTUhleoQFki1sAqZ
 X5pPebezk8vOAEESoWs9XfyaOLUtWy2/8I4ZzwkGW5IQfBqRmqr/drJF2CH23nchvFhk
 YPLu1S2aF3p63FW+Aki/bTHEX1fulARCCMYN6gX4aoEc9B/C66jOueAwEf0F/fD6Rqr1
 tK2dZbef+jSWXUwDUcam1OnMrM45yTc2wRr1IwLbSbHOzpx3ua1mSnw7kDIdm1Px9GhD
 LS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781724821; x=1782329621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQZtMnehaDPaW/1htcuGu1b4iDiFaXM/HgU9tJx9XaY=;
 b=SFKFCpAqWsDmFKHnuJpUX7GM9eiIFnVfkJt1E1teAXhHb//XXvbjL6yy6U/TCIMkcS
 de3/X2RKdRFueDHQu9hU2TCg4XycCIY9iEHBiYyFgfFPH+JD2h6YBHNiFX9qq6F0DPda
 AyJA1TPrYaGG3b5lXhKb9FSOE40qD6QhD4Ry6TY4Ea1gzB6d1+oCVeWgbX8KYqDqc+fG
 Yaii//uu0f4AWNQV2qRhdtOeRsLvDq+lvm1keH7/sOxTX7BJldhC2QY1cZwizrMsYsU9
 usAW3MfVSrLqqjzLdpW3gRsMB74TKAVneLrlMn85EgjrYkSkG6OtgJRfDRAq2yRFS6aZ
 zwmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Oy7ibWDOJ1FWDDCnZXXEq2HDw3eRoP66lzKNm9zw9qaZT5RPB2DYGhJb9jikOYnv/N5Sjn5Vn5J0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2LzGM0Vqtx43EpG6bHo4A10a8F74VwwK7d8/r73xIXUceIwdI
 S8a2nGwl+gJtTW26Kn6I67D17SasUHoFY6v+1uVVdqdeXWx9lxlBR6/G
X-Gm-Gg: AfdE7cknkuOigoXuLv0cEb033PcYfibhZO6CUvwPOg6ZGqlRILfBfeBYMjj6S0aqOwJ
 lBPH50CJeTlug63NUoM6TTopaHZL07HRurEJNKvIs/qZQk1axQayOZ2/MFoZLngSfaYcQx6XgZ8
 YSK5tidJ8+DQkfZo0SkL866GJYxv2o017m6nooj+FhqRf3Vz6h3ILGly/hEk9kRXXdQa94NDgqA
 UXvDKjnsz62qa7JCRrdP+8oHtMBizYVxCU2WmbHEIdlnfjMOefPMKZyNO0H4pS9j8mzXj6VijQu
 QDYYL7/sBfnTXrKLIm+2VUnDxkDRpp9Y4Jlwgtvi4uxMUBSrOMnpuF+uoDqFUvRC3a8wKaEr1zr
 EsVobsoaiGHGOuFGyus1m1zUDDt6Xx1qZbsWBPQUeNqRsbyRPvIWTzpClDLYB5szB4KzzbT8bpg
 wQ/V9yMD126gDxeddcKPDGP+3SKLqsqMud
X-Received: by 2002:a17:902:e892:b0:2c2:bd7f:ccd4 with SMTP id
 d9443c01a7336-2c6bc20a970mr50252375ad.21.1781724820880; 
 Wed, 17 Jun 2026 12:33:40 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327aca78sm182035555ad.54.2026.06.17.12.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:33:40 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: initialize ret before UMC error record loop
Date: Thu, 18 Jun 2026 03:33:35 +0800
Message-ID: <20260617193335.1662613-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:12:07 +0000
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

umc_v12_0_fill_error_record() returns ret after walking the pages
reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper can
return zero entries, leaving the loop skipped and ret uninitialized.

Set ret to 0 immediately before the loop so the zero-page path reports a
deterministic status instead of returning stack data.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Set ret immediately before the loop instead of initializing it in the
  declaration, as suggested by Christian.
- Avoid describing the zero-entry case as an allocation-failure fix.

 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 14092150336a5..4842340d9d65f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -690,6 +690,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
 				page_pfn, ARRAY_SIZE(page_pfn));
+	ret = 0;
 
 	for (i = 0; i < count; i++) {
 		ret = amdgpu_umc_fill_error_record(err_data,
-- 
2.51.0
