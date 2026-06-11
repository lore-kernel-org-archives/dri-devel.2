Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D41CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CA410EE13;
	Thu, 11 Jun 2026 10:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kx7v1TOE";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6254B10EE23
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:27:37 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-915671abde5so685345985a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781173656; x=1781778456; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tIFb7lA47yKA03mD5eNYLcNFMgrB7SUavs+fhnXbFgg=;
 b=kx7v1TOEcEYFSAKnNN55JEP1IbJa5sh1mqC5f1gNz53BT95tJHin7i5UxWUVRIEyyl
 TqSqL8iLcTr8XWwiiz8D+FOSwISeT9GGdmlhOyvhTp/K2a0fCSUJooMErlLQdGNVTL07
 btrs/S0BF9vgXSJ42y5Do2PHHFViZ6Fm3Gb733jRha8IMQ7ExhVZlAv0g5lJVw9L5Oc9
 eEESHg68OjTDYA7iHhkytPg8tPJxeSx1OEmqHPBOeRtzReGd8jldUy0hdFk4FWpEt10V
 wM6y2u7ioPOb6TMRLfuz1i34y4vm7teQYkcNU1htw1rsU5AYe6esv6vIdhJ2kx/V8osT
 RSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781173656; x=1781778456;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tIFb7lA47yKA03mD5eNYLcNFMgrB7SUavs+fhnXbFgg=;
 b=F4bkt18ObUxNNa2V95T9q/Ej78RgDxk6ZsSjuOdGklpPRicSUigfUmXO89zfOGYSdK
 /vLtcXFLYJbAdXX+rDJRRTaYDygv4WhA1Kapd7C/CTLz0lv75Hwfk+H85mfgQ5IKMVFE
 ryqos04akyjz/Dv7z4CPv9LamOw3Mft2kWYWxVzvYcYVT5vsU9VP9wrxZrZSvOdUtoXr
 B2zB4ySqvSpG/L8nzN/NOkOhQOky5+TtRDi5lrfCtPFqjvBh/oj00TE47mjhdwiMym+O
 yoipwl5XKLbgf9ZZ2MncFENmDC928J7n7E6fKQLaoC3OUjMEyliYEje2X9UXcuL/JQx4
 0ngg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+sk+BfSR1Psm+2QYOTkop+CDM4Ej9IYLGQzPp7dWKW6/4TmuLY1qib0VIjBrzoKCRXnin6khRYa8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu68h+85CpGXo9oRBwWxS9AnuOxmwYVnqX3GvhZeV04bBhigT6
 ieZS4Cweiu2UMlx7J4x0szDrPHZuDkjtV3tLzbaIZ1q+xLuQBrzP/80V
X-Gm-Gg: Acq92OFJuBal/pTOs0RI4Z01JASyw9eaGfSHqLFFgXjGMV6I30uyXJSUFEIRknaSz47
 JvVvU47qcIu3EyRflxypbmURpcyswtralMbGln1qTHHmIoH8ruyA6aC6TuOPJgwqwIfNDMJ7nB9
 AzamDDFnFNGB8WGkIPgEklFhTqTMwezMb2LRWc0K311bU3N8QbCigU0qkbJ+0xyVTLsyJq+x4UN
 GwqnN6ftJmTCE3YzXKY0RTMgWtY2zOb98feSdutZPvEdVhQXmm3kt1i4jn8wrMoXC3Rgs7rU6RF
 FfQmuA9JDJZOwmJEEDvSvQ+r/qfBGmmTRwtu8QP2TH9yRAqONY5YXEQsQlM9kDLyJh70pWHByhH
 ZjY1PvKP4LK7wJG9AaU1uho92NxRwno40UDu73ksAS8Wr1B6I4x4WghCNY82poNuqNuGQ2iY1lv
 9UcRuXKO1w2GWGw9vogjDtfj3oSHM=
X-Received: by 2002:a05:620a:710b:b0:915:8055:3f91 with SMTP id
 af79cd13be357-9160b042de9mr330058185a.43.1781173656224; 
 Thu, 11 Jun 2026 03:27:36 -0700 (PDT)
Received: from localhost ([149.40.50.215]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9160aca325csm147320685a.11.2026.06.11.03.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:27:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:27:30 +0300
From: Dan Carpenter <error27@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH next] drm/msm/adreno: fix use after free on error path in
 a6xx_gpu_init()
Message-ID: <aiqNktNfXiaPhje3@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

The a6xx_destroy() function frees "a6xx_gpu" and so "adreno_gpu" points
to freed memory.  Preserve the error code before freeing the memory to
avoid a use after free.

Fixes: d158886cba08 ("drm/msm/adreno: Trust the SSoT UBWC config")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8b3bb2fd433b..a44380316aaa 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2770,8 +2770,9 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	adreno_gpu->ubwc_config = qcom_ubwc_config_get_data();
 	if (IS_ERR(adreno_gpu->ubwc_config)) {
+		ret = PTR_ERR(adreno_gpu->ubwc_config);
 		a6xx_destroy(&(a6xx_gpu->base.base));
-		return ERR_CAST(adreno_gpu->ubwc_config);
+		return ERR_PTR(ret);
 	}
 
 	/* Set up the preemption specific bits and pieces for each ringbuffer */
-- 
2.53.0

