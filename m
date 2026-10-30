Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F760A2634
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B3W/fV2G;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tve8NdDm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6474E1129ED;
	Fri, 30 Oct 2026 21:20:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FFB1129F3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAldO236394
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=en+kx17O9Hv
 lGJdYkQ6xEsXJtVuKpJWhTDhQIUh13CE=; b=B3W/fV2G7l5Xpz5s/J9CRKwoDYM
 2OQXLI3NKQAcqjTP/IG6Hop7NkiNCVzAIPoOKQTGXiH06qONoAKiYya6IIeYZrQe
 mYMM3YrmjwoWASiwXQPg/3L5+7A2QkYDmKevtOXnJR675wHYWWd6Yno95K51Ye5G
 /08UoTQxKgUV5/IhnhUgsQZQDYQ9YqDOp+Bw3/WQOxQj8FCuU1OYisNUhUhLsGom
 ufFOrDU+JgVyoDdhFWvvITgQd8eeK4OL3pGnFgLvW3FfbxF8NWsa4/LQErgIeEWl
 sq7gVnZooWCcR2rRtKbS/bgCMtUGfaw2HgLA0Qn1iUu2qkjI/KhiP5P8eaw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x001b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad7030e886so1227850a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395185; x=1793999985;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=en+kx17O9HvlGJdYkQ6xEsXJtVuKpJWhTDhQIUh13CE=;
 b=Tve8NdDms7hlJupjgA2Jld5TqufEu5YcQgaVp9eQUbimPojtuRIiFznXW6avF/nn+t
 8DmOcyfHgOJNBeSJ/Q/EQI2O06SLa4ATYLRfLfmx30R1ES2cYJZe0aXXgUQkg3f1ecNw
 TgxglVnFb99d45nqJrGdhoCbD80aSpHb2UoK2KEiUkvAmqlcoLnEHGnJtIzQuZ5q/f1E
 psjFeMCL98yTeNkvFJyCncV8DYve81IGrQGRFv2OtM4JCM/NJyN/R9E16QDrNIGQlXKC
 FQriZYU8IT1hTSRMrE9FmpWJ8Pb5nEQPsrhvQw/7Z6SnBcAHoXlGazYvmHq4s09qUbTY
 dDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395185; x=1793999985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=en+kx17O9HvlGJdYkQ6xEsXJtVuKpJWhTDhQIUh13CE=;
 b=lG0w9axlO34GfwGtJm+qRnzth24GivnLlYVECmVcmyooRFvDIKa6qsN2PNElbfAm7u
 i/NaL3kbl5GQBOuD0CN4GMglNByyIeNz7LX/wEBUDuanc4Bpr+4qv7RCTjEMAFJZAG4d
 kbEt8YLooCNpE0a9OcQapyhR7XYiQy+j9LuHzA8D2lwEBHQCo+CtQrFrG9AjM3Uwaw22
 TgzCAWY94mznCtcgs1CrUSL4AbVXXj4GQXE/+SV23lwk/j44m76/ywKaqlmIWWg3fINQ
 +wuhPNMyob/xku10pDXHspnyeDNY7+2/t2oabVzLVmGQ0B0Zq3soshhe4Zq/8Inn4uWp
 YV3w==
X-Gm-Message-State: AFq9FYLumqfBV5gXaXB6OdOcOcCiEI+Ra35yZNcJl8M6ggfH0SzQXRgb
 anyh7pF2ECNUffwkkmUy3+mYS0icMIjqX4QfbPaS0WCoRWaJhlIBXypYWksypBi/P78mNwgyFZL
 EGuZBz5Vd75mjobxX65RHHrnusrZt+dBWv4zf3295bVMt+FJ7qcyJfR16/xTSYiPI4/6gZBoiF+
 PnJ9k=
X-Gm-Gg: AYBFou1e2tNizXIFtSMqIH817yCNyiSCeWlHQwcuhsqEV17Ph9OegKTa+M04DCkKpaa
 9MFMRGrCGxfaEdXuRBerFWKjYm0W8vHYKgKyxd7USxmOQlAL+6haNSXAt1mE7EujsXZKgkuGif+
 YLLEK2q2NKGgpQR94Bt0ItJWWv2C0zMnWeJ1BOTIqsZW3Wx1boC63Py0nT0f10uYOHHwffSjjGW
 T8QuS9rlyiBcTA1OFfaczyHqdYfug6E41M+5px0VDjQoKIrAmxyN1R+V/Wtiq7a3pAB0RUlCQAO
 WyEMTGHrMrTmq43pa5LxTjnzl/3KyxEhW1bWLAWXS2VqtzJLAS5kpY5gvLC/q6B0pCs9sf8M/fq
 GbrCUoSgUL4vL/rkbaLloGQJJNhZ9mHE0UJvOiB8+KEdyK98mfpBTy9KGI9CwYxDAXgquqQbWXY
 yMrQGnw4jWPsgzZ0VM6jkfHxU=
X-Received: by 2002:a17:90b:57c5:b0:3ac:a139:1b14 with SMTP id
 98e67ed59e1d1-3ae8984acc9mr3134527a91.57.1793395184735; 
 Fri, 30 Oct 2026 14:19:44 -0700 (PDT)
X-Received: by 2002:a17:90b:57c5:b0:3ac:a139:1b14 with SMTP id
 98e67ed59e1d1-3ae8984acc9mr3134512a91.57.1793395184364; 
 Fri, 30 Oct 2026 14:19:44 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8803a80asm2434346a91.3.2026.10.30.14.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:44 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/19] drm/msm/a8xx: Add missing a850 ifpc reglist entries
Date: Fri, 30 Oct 2026 14:18:07 -0700
Message-ID: <20261030211928.45761-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfXxByAZcc86+pP
 jZ1/WTjkMdbVyi+MiJDmpYvDXQu3p79iyK3pr3L8ZLdW35Agyb6iuwjZskK0pYU+xLIw7t8jWJd
 h6uqZNZuVqSUge/h50GqHu56U+0cccM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfX3JXO366fUjmY
 FZvtFnT2qgVUGtcq8v2j3LBHYI00ZX+Pi5K/Dbgzh8KPA71foyybgM6g760oqjYounHZsKjjFPA
 DX+0EkIwES43QXjynfI9t+L5KlYR42nVSWwNDswP4rvMh4tECIUNM8NVXPh7hz2JEAZp+efevBd
 mqv9yHgXJx3ja1NI/WIxRiqBuJz3QWE+5M4Mf6EJd4jag+nMpJrK/AnhPjhqNNGbUCllBxZQ8Zu
 J2wMu1ysDp15zrA10HUZjoT/4tMlel08RYGGe1p+oSxJow7I+q+FJr91X5In6HMzQa5EauQcXcM
 IRH1I6rTHXepNVIcbjjieN7XAEnVnDLchMEyaKQPvhxSrL2MQ6KZpaJ0/vlTvi3DBcR1a7+dhQW
 8260I3MJbGYLetGYxTwctWv4K2rqPw==
X-Proofpoint-GUID: mk_XPUma0_KvjFyssypiGwWN42qGpG3U
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae509f1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=vdKEjRuvQ9rlgTdWijoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: mk_XPUma0_KvjFyssypiGwWN42qGpG3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2610300084
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We want to save/restore all of the CP_PROTECT regs across IFPC.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 55a805ab438c..45cd986ad4b5 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1477,6 +1477,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
 	REG_A8XX_CP_PROTECT_GLOBAL(53),
 	REG_A8XX_CP_PROTECT_GLOBAL(54),
 	REG_A8XX_CP_PROTECT_GLOBAL(55),
+	REG_A8XX_CP_PROTECT_GLOBAL(56),
+	REG_A8XX_CP_PROTECT_GLOBAL(57),
+	REG_A8XX_CP_PROTECT_GLOBAL(58),
+	REG_A8XX_CP_PROTECT_GLOBAL(59),
+	REG_A8XX_CP_PROTECT_GLOBAL(60),
+	REG_A8XX_CP_PROTECT_GLOBAL(61),
+	REG_A8XX_CP_PROTECT_GLOBAL(62),
 	REG_A8XX_CP_PROTECT_GLOBAL(63),
 };
 DECLARE_ADRENO_REGLIST_LIST(a850_ifpc_reglist);
-- 
2.56.0

