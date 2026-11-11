Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571D606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XInsIKDv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QUhL3mdK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBF710FCDC;
	Wed, 11 Nov 2026 17:14:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2EB10FCD8
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:14:22 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF04vr3597124
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/wofSj9aHPA9D3MGeEg1Jb27L1jT6JF34ZU
 9QKgLdoM=; b=XInsIKDv6Kvmyy59js7k0guJDqGZv/3GaSfRNpGavdN5zPn9yD2
 3ryesp77XMZIxNa2Y8RezwFpV/Vt5M8xAvZ8DPE/X0YyWNwEhd5SSCuo9hHhW0NC
 t8Q6pML2a3Npno4kOQkdMxwyNIku8jXnnaGQS8dyQhooU81cIRd8rxUvvcUL8eeQ
 DVE1zNrWWqT8N9tHebPBclWgx/Ar9hDm1jtFYVzuNc3P2yQxkmf+4mw5LxQ47Nla
 w7gnQbr4s+rA6k+pw8dn/aLJc1aT3mJf51zjFlfV7F/0s0ACmuPMNMvibu94qaJx
 5fpKthivPUpmvrLHEILwCXu02inuRtReMDQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1u8rfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:14:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e8dd9b9743so38369855ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794417261; x=1795022061;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/wofSj9aHPA9D3MGeEg1Jb27L1jT6JF34ZU9QKgLdoM=;
 b=QUhL3mdKn/YGzRxQ3td73gZqwhtaUQ6hqaIw657QJuKCoyUlEFBdAw1ic3wIXqdFvR
 9j43BxzkCNIPlQErsUA412xiyRCrp3SxNWX8CQtq56e9ri6t5h3YAJHzrzH+syQQH2ZB
 8x0KEwYGCm6CcgXiCKUBLVQ5+AQpQQCfOKfskm7VVMHKIgcJKUonKB7da3q14bljXZr9
 EBLIsTw39smT5qCWuRHFmVlwOIHUHKzPbUmAgfY7RPOqfR3kVD7950wOrwh9gDXhQI5C
 SdgfffIds+qwm4byKZn1dQy5wtJLkYgG8MAosCjToJPwszC6a4SrLWVu9ywZpXo/klvU
 uXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417261; x=1795022061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/wofSj9aHPA9D3MGeEg1Jb27L1jT6JF34ZU9QKgLdoM=;
 b=RuFT1667IdLIA2tuUyVvEcVnGO/FILwmMXLDdG7tB5fOgrfnb3gNhwcM+DNgUTCKRe
 Xnr49iAmD//HGzh/mhAO5p7YBXr+7mqj+vhn+oXNkI9AFUPri1/gO4Ai14YZxmW5aUvP
 Z/sIqOq6l9cEBuaIraE+J2BNb/y/MFuPrlHBzC8Cn1MZ1J4ei1R1PfHdwPDsbVjKDsli
 b4wtaQ9xNUkjQhXo7WSPDV2Ic8EfdsZgMpJwy5JfUmeP5MA5Hxz2amvREZrV0v1UCrl6
 RvfIEMUPJ7z7mvLGdIj6DljYS/2OOGYXWgX6dcCpWrjg/fOJPSE6fYvhfIs+YnlclhCl
 76dg==
X-Gm-Message-State: APuU4Z+uNybQgSDSlsShIrTVbmAs39IR9FGS+ixaUA/0d+L2pVS7/Tj/
 JQZMTEYaXmg1usrXP5cRIEj0WwfsYjMT4X34mAiCg1GefMaYA5atBmquHsuTBfl2lwq+XzmsRNV
 PTt4gl05FUjJ0R5YmJJO1wbu0eLZT+GuEeLapYweJ0Uzg8cwzeYbulpQ6ot6yliJpUh9Wl6F9xI
 qbMHAhYQ==
X-Gm-Gg: AYBFou3dc9fPrIjO1GUyWF5TQCCQE6DNDJB7j2sPjwXRv5rJ1JQYnuEXrTcEiMHQAEm
 VNKkMB1vqdIg2hCSlZgcXnnPFS+4xblAS028S8LC0F3eK1gxgU1ts9UcOa7Z9FwE+b3X4GU9cNk
 fs3tTxwA3CXMh+b8hO+V7T3tLl1iVX8A6BoNUHA+5Zdvgp2mHW0RZYzfxrXnDYxXuVjYGg5euO4
 LmnJYajAsUa+yDdA18mq/ud3IGv0JTduyH2dr5c/h0pSxr/WU29pRNaOTNHdImEv+aLQ4/aGA9y
 GyGFWAJVsnGpCSjsJN1zP55i/7S/VJvY0hG+/MHH9neDCFT95ricXlQLMdlchMIj1rSOeG+O+3t
 /bK8mNvPN8ZKgTyXQr9Y139B15fLsCU2c4heYoQKyZDJ4pG1UNv3Qz/7AuUDGWmj9AOjM0+4BUd
 Rv5qvUj965wlzCyjoyaiHkYA04pMYO4hOV+Ayt80pSuGHmE1p2tlSHtvr8SBDgQQ==
X-Received: by 2002:a17:903:17c6:b0:2ed:379:158d with SMTP id
 d9443c01a7336-2edd76d251amr34944445ad.9.1794417260878; 
 Wed, 11 Nov 2026 09:14:20 -0800 (PST)
X-Received: by 2002:a17:903:17c6:b0:2ed:379:158d with SMTP id
 d9443c01a7336-2edd76d251amr34944115ad.9.1794417260379; 
 Wed, 11 Nov 2026 09:14:20 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d4d78bsm23272985ad.24.2026.11.11.09.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:14:20 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/adreno: Improve AHB error messages
Date: Wed, 11 Nov 2026 09:14:16 -0800
Message-ID: <20261111171417.249152-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX53b7VYPDbLUi
 Zsfh0n9Mo1aM7DHdKhL+u67HsrKxX9NWIXhf/CxJCTSQlYAj6j3IPXR/P6zwSF4XadveTKj2CTc
 Mmja/3PfCLObTuczCOBrFZzMsTjrs1I=
X-Proofpoint-GUID: NxX2tl0afyd2B2Pm2hwGAzN5nqGM_eBy
X-Proofpoint-ORIG-GUID: NxX2tl0afyd2B2Pm2hwGAzN5nqGM_eBy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX8aejWEzWoTUS
 CWGxI8qmWR0jgN1gDmxQk/AQkt7IAkl78oBPhYYCZHrCvkSAYCorFjrMW17DUthx9FzJSWrAn2G
 eygrpE1GR5CY276ydypxm9qtdrjJZSWHMdy4mpL5CgbglWZiPkMFNQRA9oiSY/fqPx+6jfIWA0E
 sk8VfNlMxlL78DaUXHUj9WPEacTS/2b+tlIlk5qocW9Scv83qlutPBcBy2XSqw6KYlLcv4KDso9
 W0v054+f3GOImy8BhdWgdzbPjJqpB+sN+cWNNwNSRqVuYj69r7MSEYTOMVHotUn3Yhw/EaJIXZx
 IIyaGDK6HjALT+acXtxbyg1D9p4WnMtLsc2hdQFfN4weLRCPKLDln45bpMVPbNvCY8822kFvVi4
 EA+fLBqcuEW6H6daFJoQc/uVLWoWfAunVxUuNhovrvbnn4Vaf6H1HB2+6bhwLx8k9fRrNoZqgMz
 dIWTjchcNsBBPA1V9Cw==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af4a26d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=WBtBlQOfHxcDcTM_9MQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110068
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

On a7xx/a8xx we can get some details out of the CP_RL_ERROR_DETAILS
registers.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 20 +++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         | 10 ++++++++--
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 11 +++++++++-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a93e9c960d88..484a78dbc804 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1957,8 +1957,24 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 	if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
 		a6xx_fault_detect_irq(gpu);
 
-	if (status & A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR)
-		dev_err_ratelimited(&gpu->pdev->dev, "CP | AHB bus error\n");
+	if (status & A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR) {
+		if (adreno_is_a7xx(to_adreno_gpu(gpu))) {
+			u32 rl0, rl1, addr;
+			const char *mode;
+
+			rl0 = gpu_read(gpu, REG_A7XX_CP_RL_ERROR_DETAILS_0);
+			rl1 = gpu_read(gpu, REG_A7XX_CP_RL_ERROR_DETAILS_1);
+
+			addr = FIELD(rl0, A7XX_CP_RL_ERROR_DETAILS_0_ADDR);
+			mode = (rl0 & A7XX_CP_RL_ERROR_DETAILS_0_WRITE) ? "write" : "read";
+
+			dev_err_ratelimited(&gpu->pdev->dev,
+				"CP | AHB bus error RL_ERROR_0: %x (addr: 0x%05x, %s), RL_ERROR_1: %x\n",
+				rl0, addr, mode, rl1);
+		} else {
+			dev_err_ratelimited(&gpu->pdev->dev, "CP | AHB bus error\n");
+		}
+	}
 
 	if (status & A6XX_RBBM_INT_0_MASK_CP_HW_ERROR)
 		a6xx_cp_hw_err_irq(gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index f6afa5b3b0bb..bbf5ca4fb6fc 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1248,12 +1248,18 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
 		a8xx_fault_detect_irq(gpu);
 
 	if (status & A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR) {
-		u32 rl0, rl1;
+		u32 rl0, rl1, addr;
+		const char *mode;
 
 		rl0 = gpu_read(gpu, REG_A8XX_CP_RL_ERROR_DETAILS_0);
 		rl1 = gpu_read(gpu, REG_A8XX_CP_RL_ERROR_DETAILS_1);
+
+		addr = FIELD(rl0, A8XX_CP_RL_ERROR_DETAILS_0_ADDR);
+		mode = (rl0 & A8XX_CP_RL_ERROR_DETAILS_0_WRITE) ? "write" : "read";
+
 		dev_err_ratelimited(&gpu->pdev->dev,
-				"CP | AHB bus error RL_ERROR_0: %x, RL_ERROR_1: %x\n", rl0, rl1);
+			"CP | AHB bus error RL_ERROR_0: %x (addr: 0x%05x, %s), RL_ERROR_1: %x\n",
+			rl0, addr, mode, rl1);
 	}
 
 	if (status & A6XX_RBBM_INT_0_MASK_CP_HW_ERROR)
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index b1e7dd26e98a..8d33d9285007 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -193,7 +193,16 @@ by a particular renderpass/blit.
 		<reg32 offset="0x0" name="REG"/>
 	</array>
 
-	<reg32 offset="0x0840" name="CP_RL_ERROR_DETAILS_0" variants="A8XX-"/>
+	<reg32 offset="0x09b4" name="CP_RL_ERROR_DETAILS_0" variants="A7XX">
+		<bitfield name="ADDR" low="0" high="19"/>
+		<bitfield name="WRITE" pos="28" type="boolean"/>
+	</reg32>
+	<reg32 offset="0x09cf" name="CP_RL_ERROR_DETAILS_1" variants="A7XX"/>
+
+	<reg32 offset="0x0840" name="CP_RL_ERROR_DETAILS_0" variants="A8XX-">
+		<bitfield name="ADDR" low="0" high="19"/>
+		<bitfield name="WRITE" pos="28" type="boolean"/>
+	</reg32>
 	<reg32 offset="0x0841" name="CP_RL_ERROR_DETAILS_1" variants="A8XX-"/>
 
 	<reg64 offset="0x0830" name="CP_SQE_INSTR_BASE" variants="A6XX-A7XX"/>
-- 
2.56.0

