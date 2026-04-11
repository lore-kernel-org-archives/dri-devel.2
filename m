Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F46F3ED4F
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 15:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E02210E9F7;
	Sat, 11 Apr 2026 15:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBsE8uBl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwOHXOE3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C28F10E9F5
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 15:03:23 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B44I9Q623960
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 15:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=PHh3WXbGAb1Hiz3qnT0RDUFz5kZgQ0qJD7o
 12cchoac=; b=kBsE8uBlHXRBrLzMHZwcg7vOOG2w4CtDybx80mHiY5nAzkS/kfP
 pXEjYR7C/hro16s9b+F67by1WqLzsKB3+avbN+DLZux+oy+ImEpAwc1x2et2ONv2
 OG5t+DgfrbR1735ZG9WTZlTBKp2/XZDzjz9yttzaQ/gDIJ77qGGd3n7x4QxbK81L
 KOJ0xG/wW1YMzs/qJ4shkUs6H8L3N6guLN72PQsXHbft/oVSo47oipR3ULJJBr3u
 5hdaRvDU9L0t6xMsUOSOgJjXhfK2p0lONR3pUbwSCHd26dAjp0uwmUyJpm/qoxZO
 gfKgubk6kj0VMPWr6cIYsUrOH864dDRxqnw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfrwr5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 15:03:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35d92f8408cso3459403a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775919801; x=1776524601;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PHh3WXbGAb1Hiz3qnT0RDUFz5kZgQ0qJD7o12cchoac=;
 b=jwOHXOE3ghyEXnClN7Q6vzaxGnKzk2bHS1cIUWMozQ/y3ycqL7mZjdsyAiH/xEN+GI
 +Bx8OlNNVbc9hJA2OVhcoRFfZ7l5JAqgD04P0ibkFMd939aNjh3pUcqZts5PSZZu36d0
 PxBxPDHZDvreLEAcJIe8LWJlesb4juMvoz5CYgrd12DcYpDHRnFxo1xK4PQyfaPmhaQe
 RBHwAn43DCWPyGXPgpxrZbBCs73mW6P1cUux5K0fa3dA2ZZBMABRLVECSAsW6BvzQrMl
 Pd6ZUxOc1pII8gxJPs4ly1ugu/Hcy4iGE68F79/VrkkXx1NVGZZCfDzLZBcvHlBVGxhV
 ex8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919801; x=1776524601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHh3WXbGAb1Hiz3qnT0RDUFz5kZgQ0qJD7o12cchoac=;
 b=bKSu2eUtAd6cOVBhdd2YDJ0IRsB/ZTAtwbfltZjOugTYdmAuRtMYGs7Dk3++2ELbmv
 UvSG0FWl5SjqhRreL4k6zdAdfLJ002ar+v3x0ewXrEjjcmZPcl58GAnIJmztkXrFf5tq
 ll1MykqoDzlHh6TdAXW2UIPFGuw8Vgd1CEJhL1RO7Q4uJHJs0c/1d41vAWKr4bOQgvTs
 SdYmA5y3AVINjX4XLGpCxEuK/F+yUcQXCsmwplRRDIrb4SfTVoxZ7/iffMc3PUTwFWd+
 1e1159UdP8J0zWgwukySBMn4ljg0PLZinlF4ZtLHomPdHPFUWi8fDsm+Ke7kHHjlLOJf
 06bg==
X-Gm-Message-State: AOJu0Yw8wKvgqRQgUjf3uU9FEuG6QGzPdKk9xntfgY4Jqd5gsvyNFhaG
 WrEaLFYyAiaJuWqtEaRhgtudSt17tUjsSPLrQU9pDuLt5GVXAzob9+uQEMGKeAUskVEnkqin5wH
 ikmAHksWXaqFA0wsOinEmr2VvH6boGV5iHkPF3y+MyTSIw6jibgpsMnnvtfwTuxm7jT4lCyY5I2
 8SubY=
X-Gm-Gg: AeBDieuMkCUlDVxyEs6YutrGUkrXADWCJ17ZCh1NdvOvoLXt5IFmIJiw1kZvAzyun+c
 3QfjFih7dBrZrf8vk1wVHNlTb4MbaAVSjtxVw8kI7signfJYHArt7m98nYZolff4q6y2xCZ9kDi
 A3yFcY059OwD/h5BKoOm0+MOPNXk0MuDoweicFWrWSiyPncVjYlq2gU8n9Tu0kcFQNok/6ytRDK
 ayVwcUPD1OVajNXsHOrH6Eb2/e091DMnfaDQ9Sr3SkbFjaezNvSdbPvV67G7pzxcmT7cJaYWGAQ
 KCIUODvv1xcu6dD50A2iCrbeb5URncMEr1QOpn7tqqNv2MY7vQTjiVIEJhKHDSzh69glM1sxPmI
 P43r4tEyvUXOYTFOPnLlDZjE38kFQ7ZG7
X-Received: by 2002:a17:90b:224e:b0:35b:e591:99d1 with SMTP id
 98e67ed59e1d1-35e42867676mr7143921a91.29.1775919801005; 
 Sat, 11 Apr 2026 08:03:21 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:35b:e591:99d1 with SMTP id
 98e67ed59e1d1-35e42867676mr7143842a91.29.1775919799729; 
 Sat, 11 Apr 2026 08:03:19 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e35178460sm10101089a91.16.2026.04.11.08.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 08:03:19 -0700 (PDT)
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
Subject: [PATCH] drm/msm/a6xx: Restore sysprof_active
Date: Sat, 11 Apr 2026 08:03:12 -0700
Message-ID: <20260411150312.257937-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HYm4_R4uiGTZtGnn4jSM5T-2EOKM9sQe
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69da62ba cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=j-UvV4qsuNM6PKVMxMkA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: HYm4_R4uiGTZtGnn4jSM5T-2EOKM9sQe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEyOSBTYWx0ZWRfX9/qZ9P6TxaLL
 +miOwewNBPx+CyBdwX8RdjHztvgGT2dfK/RKZ23r1dzhv871LXAuoLyA2yjn87tNNh2y1oAnDD3
 mKf/tijVozvoxg7hqUQYMQoP8Cnk7qlDPa42Mbzdu1abzAbM5TEyNADeORA5IqQLV5I5pdTQ8td
 01INO79BFz6qnYZ5gDvE2iwqjwB0xBST7Xo7EICkL74XeJSW2Tli0e3coCNU9KhMaZh2Oy8+M8M
 UFoaSXvMa02z+WpaQiPkHlQqPcqvhzd87/+jjCUrwU5QY6lWrz6kiW7VCasEsjhgBL+zKPo1b+8
 UtZFb55Py6RNv660RU5bgs/6a+Gi65lzmog5w5rOC1vRJqSPC7KRzQ1OTmrsi8PD+WC6PwMY7mB
 vThUzP/2qzR8LDy5AUyIzgsEcLpTCzbj9ooeM5jLCreApsf+4RPY96bizYvMd79EXa4ptecvuXt
 P04j38PQy6mRwAK7wmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110129
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

This got lost in the shuffle somehow when moving the vfunc table to
catalogue.  Fixes inhibiting IFPC when userspace is collecting perfcntr
data.

Fixes: 491fadb2b818 ("drm/msm/adreno: Move adreno_gpu_func to catalogue")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 85607706779b..14b4f4921991 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2751,6 +2751,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
+		.sysprof_setup = a6xx_gmu_sysprof_setup,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
@@ -2819,6 +2820,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
+		.sysprof_setup = a6xx_gmu_sysprof_setup,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
-- 
2.53.0

