Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788CA106B534
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A254E10E873;
	Wed, 25 Mar 2026 20:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OFpmgVDY";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5785310E873
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 20:59:12 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8cfcf770117so2881985a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774472351; x=1775077151; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UcxN1+YGyk5SOfq/pCcmueMhLewrBa4a5Npnjyh8K/o=;
 b=OFpmgVDYgTZLFPvMS6FYWpG6jX0o3LKC22wIC5uLf9l8rDBCSlMqR9PKV6Il5YOxxm
 n4O8Fvn2rDZ1eEIpgLDGEnsjW3GxJpizTa2lI4HiDln7c9q1HpxMim/g0p558LiUjGJC
 2jgzH7EewBNqb7HML4FykSbKk7D0WeZ2pviH3yS3q4ONhLG1HNzy0vG7PviD7BhyWyEz
 rgdV9jgMmrc65+g1gcmnheXAY/I2Qho+ZGtx6lcPp7DYjeMNJUG8gfkbfOB/L++2I7LL
 1ayhYifVwe6xyleKVP7OYncyyf64EbA4AoihL3ORDQPISTFRlPohl5bWtt+Jb0MppDYq
 aJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774472351; x=1775077151;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UcxN1+YGyk5SOfq/pCcmueMhLewrBa4a5Npnjyh8K/o=;
 b=BYfiL34fYEV+UG3JD67r8U9n/Smnpdnhvrz2MT2IvZp26OItl6mUqLOgGCWcz8NBDI
 kRJ9+yVD2KNeElpFsPdc01w1qE7JQnLXOZuxsb1QHOXpOtRB8m5lKcEQHu+hVYvyyfc7
 cwi4pjX267lBt5xkAoR0APSshfMEVoLpUFtQNP/rGzEkhoxdHBpYwftzW9JVFSC106DK
 sDIQHY7e5dDmy6NrIxxVGPcJbmyI+xikeX46M06skVD/M+kb/ev0zh5+SUe9USy7r5GF
 bowwvCanofbZ3yIc+0Wf2CHSbgL3zGcug7fRWIxWVv9l0V9ghbIhh39zpTP7/qybO6xN
 ngQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6CRgfiTLEcMtbMQlSvwdSjTahYx+HLk5K/BoSbKN7WmX9J1ccCl668sRHzwwt7bVUA4xEpdHMVv0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmrJL+UmHJzMthCrievKrnLtvaQR26V0a3IfFu0BD/4rcZuJrU
 V3fXchqRdVwGPF2qxSvaFkZlDBvfP6fdSgF1/Z9o8oMk9JI4aLZVdoxw
X-Gm-Gg: ATEYQzwZeWep3vTkgCndHdOffewTRq6X4TSAudrrh8Wz0H7M+t02WS2XjPPby8c7Z/Y
 zf+mhuYArWhqHPt2DrV6QdpynNRDdTTEFBrBZaXQzHRoverFcB1bxLY4uJBNnoT1AyY5yrZXGl3
 I034ElD44q7jExCNG8BpacuOoTaUvsM2+dXUTxgm22Des98nPDgYkCsXRQtOhhoZJui9Y23ywSb
 EPwSOhC/VA0/NQgberlpybHItuB5KDcUaPz3qouW37Ug+IIc9sVbRmo78b+UuvewR3N1l7GY8JD
 qHzWYEvB7s0w+L86z7ZXk/zPQfnEaQDlFeNJkqERt0C7pCNY4KkTrrULJUHwk2afpqf4xYKLCbS
 MQ3jqIPvyZs/85ClgUdo7+UlTbNjZK9qn+FYj4onN8Z+aKYDam9gpqtjqgUme6j8sTnds9vwaYJ
 Ci4SAi2tQllwKKdJVOP7oYDesJkA==
X-Received: by 2002:a05:620a:4706:b0:8cf:df37:4f97 with SMTP id
 af79cd13be357-8d0010fadc5mr560312885a.7.1774472351093; 
 Wed, 25 Mar 2026 13:59:11 -0700 (PDT)
Received: from [192.168.50.55] ([67.243.142.39])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e532cfasm79548085a.44.2026.03.25.13.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:59:10 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 25 Mar 2026 16:58:37 -0400
Subject: [PATCH] drm/msm/a6xx: Fix dumping A650+ debugbus blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-msm-a650-debugbus-v1-1-dfbf358890a7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHxMxGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNT3ZSiXN3c4lzdRDNTA92U1KTS9KTSYl0LA0NDyyQzEwNTs0QloN6
 CotS0zAqwudGxtbUAQnMc92cAAAA=
X-Change-ID: 20260325-drm-msm-a650-debugbus-80119b64056a
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774472349; l=2027;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=OMqepNNi4k2gJtZUunl0zH6/viqlOmaZWVSdvq6mCaI=;
 b=20aMOCBhd3e0A8fwyna49ooZKCvRRkrMUNZ83wKTEQvpYYviGaFCZjOgRwkwXolqTYjTisao+
 cehsZ9r3Z6oAxRt9ROK1IjVSM6jycDwu5WKbM7cBSd/VfMiTcna6SQA
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=
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

These should be appended after the existing debugbus blocks, instead of
replacing them.

Fixes: 1e05bba5e2b8 ("drm/msm/a6xx: Update a6xx gpu coredump")
Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index d2d6b2fd3cba303959bd037b60796341315079a1..9699a5b4754628023b67f0eecafcda728953e8d2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -361,7 +361,7 @@ static void a6xx_get_debugbus_blocks(struct msm_gpu *gpu,
 			sizeof(*a6xx_state->debugbus));
 
 	if (a6xx_state->debugbus) {
-		int i;
+		int i, j;
 
 		for (i = 0; i < ARRAY_SIZE(a6xx_debugbus_blocks); i++)
 			a6xx_get_debugbus_block(gpu,
@@ -369,8 +369,6 @@ static void a6xx_get_debugbus_blocks(struct msm_gpu *gpu,
 				&a6xx_debugbus_blocks[i],
 				&a6xx_state->debugbus[i]);
 
-		a6xx_state->nr_debugbus = ARRAY_SIZE(a6xx_debugbus_blocks);
-
 		/*
 		 * GBIF has same debugbus as of other GPU blocks, fall back to
 		 * default path if GPU uses GBIF, also GBIF uses exactly same
@@ -381,17 +379,19 @@ static void a6xx_get_debugbus_blocks(struct msm_gpu *gpu,
 				&a6xx_gbif_debugbus_block,
 				&a6xx_state->debugbus[i]);
 
-			a6xx_state->nr_debugbus += 1;
+			i++;
 		}
 
 
 		if (adreno_is_a650_family(to_adreno_gpu(gpu))) {
-			for (i = 0; i < ARRAY_SIZE(a650_debugbus_blocks); i++)
+			for (j = 0; j < ARRAY_SIZE(a650_debugbus_blocks); i++, j++)
 				a6xx_get_debugbus_block(gpu,
 					a6xx_state,
-					&a650_debugbus_blocks[i],
+					&a650_debugbus_blocks[j],
 					&a6xx_state->debugbus[i]);
 		}
+
+		a6xx_state->nr_debugbus = i;
 	}
 }
 

---
base-commit: e4eb11b34d6c84f398d8f08d7cb4d6c38e739dd2
change-id: 20260325-drm-msm-a650-debugbus-80119b64056a

Best regards,
-- 
Connor Abbott <cwabbott0@gmail.com>

