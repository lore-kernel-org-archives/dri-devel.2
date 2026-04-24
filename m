Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B51FED3E2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C8510F5F5;
	Fri, 24 Apr 2026 15:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gPgu5Hdw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qid2TuPy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352FB10F5F5
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:11:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O9G7T9518552
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lcPhu9r6gLN
 Un/M0FOO+8vu6c2tQ6RhDeBZbp1avftg=; b=gPgu5HdwyKtcYYBAr726GWrr65T
 FSrHH2sMTX9yA6xeW18FV+hz+y3yvdmRgAO/0D9HC4X0JDvcwKSeTtzkVBNdMF+u
 Xul+dd6YUjOZpzee2xookpDRdKlQpjoOBOp4qt62sCyp0tXEjDsLNyphU8p9r6fV
 qSgwCdYsn/emo2yobQTl46FRbKL3k/+1ftc4jLP6PieXmhM8+KGyfRisbRqbEMrG
 Wr6EvLE3XvoXkQlrczTX5uUnUDEVJGAjs0bWLWtCNdYB1ocZbrIHuTcPtiSLSfgH
 3TLAfuAcrq2CpGbwsQtCDGFQz+llD9WBffsHUd8iqsefSDTo9AfEiqSiMdw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr0fnjrxt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:11:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b79f4b35b7so20233715ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043511; x=1777648311;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcPhu9r6gLNUn/M0FOO+8vu6c2tQ6RhDeBZbp1avftg=;
 b=Qid2TuPyiOIYYTJbWFI0MlskpoZkGlp0qSxZdLqvNHAGvY47vx5RE/85l0Dfj3+art
 jPctSv090Gkyue1c7i/cM5scxbo+NpHiM1CWpBFOMItycM4PgpSU+lHGLtWqgPFg1wYc
 T4nPYJTx7Lj/CCErGj9hhlzlwY06JTpwCWrpCXgu50vTB7A49XL61mru1CjOLxXOgkBM
 EZ3xvjstbwszUetfRiljlYR1ze5GCdGxwOUQ+BiMQbwiEXzNrK3548/GZWoZdrkIyT7j
 kcxG5AOSLow8WKgwyzNszwqWPyCqRTv0rq/8cMZo+2JmzYwY9xtTuUdQIBv/6p7kScac
 LgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043511; x=1777648311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcPhu9r6gLNUn/M0FOO+8vu6c2tQ6RhDeBZbp1avftg=;
 b=g3DzRZ1kzq6Nlyqcc3ay3OdOawmbvotizkLBGu4e0fquVDlkVqyS7TkVTPa7CE5grO
 tqwmjE6RW4T+JfCB2pZMHu1vyeVKKmb/QNNoo+or9NirokPTisK6Tra51q9uTftwa3m/
 QeCpYwfuZCMB4JYzwHXOylXAPhygyL0yYbSd16AMVCYbE1AYOd+B4d2wfmvxnGSaMmHu
 1km6zX1PTAGRR5OKNsOhrATuTP17s8+SWt/pH/+ARjYA0bE8yo6QfnBKH88LsU7EeiTT
 ysajRtEXfSIjEZsV4GCUwRtxlmFNwrY/qHv6AitX249K0xasBf0j7dPGIGHAXf6fsA53
 4hCw==
X-Gm-Message-State: AOJu0YwzD50AEGNtjW5XZVFOaMZI4XN5Uy/MhsIEgXsPL7aNKY/LMcNm
 rGiQF1kJ5w51WY+ipq0IHChZfhDFoYaY7wyzSf5EuJQdl5b/rEB40QXe0cZIwOFNfF2fRaM8g4B
 zWhwabsAtCQBMW/3tJVRNHSelMfvkOaIWUz7kWM5vI0hzlNmvbm3LMHRxnVwr5v1d3iZrD0OYuO
 8+GuM=
X-Gm-Gg: AeBDietdqZX0qo/kaorSK5YWsmxBHY3vR1R5wnUwJkHD8gn60T7/l9BD2one8yIrWfW
 d/ZNATKMq1WVkjAG3biI4B8qPTyAznmN1ZoB1obIqYS6X+Dal2WkwIctDYKS/3mcS6QTyHPLLYB
 RZbBWbOEG3+BTIuSTjcLRJjmrx+tW8pp0f1GygikvY1j4pNr7jfViIDvnjQX0FsI+ceKnfb7q5V
 UpQD6IcEGx2qpkvmycyQLxERFUluU3vY1ss+sQiZXZhXXcyPhj8o35ZpR4R4Ba4cFIuq9lka/D1
 Ze0ixuAiQhSIjJDMkaTXI3tcqNEFmupSrwHs8kqDYRsPoH1JiUIrxKjNF9XOvCI5Jcti1c6m7FF
 qhAZnK9h8l+BZFUGWQWCR/QlkQtJRuvsoLhh8Kf+EQ9Q=
X-Received: by 2002:a17:902:bd8c:b0:2b2:50f6:cdd9 with SMTP id
 d9443c01a7336-2b5f9ecb818mr216666895ad.8.1777043510599; 
 Fri, 24 Apr 2026 08:11:50 -0700 (PDT)
X-Received: by 2002:a17:902:bd8c:b0:2b2:50f6:cdd9 with SMTP id
 d9443c01a7336-2b5f9ecb818mr216666745ad.8.1777043510082; 
 Fri, 24 Apr 2026 08:11:50 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0caa9sm225689865ad.40.2026.04.24.08.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:11:49 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Fri, 24 Apr 2026 08:10:37 -0700
Message-ID: <20260424151140.104093-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LfYMLDfi c=1 sm=1 tr=0 ts=69eb8837 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=ZRXlmS4ShPoOlOK7p90A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfXy37YN8lcKw8P
 lkvAb0TXfvDrHBBZYeIczN8nwKhfW2VEQtu7t9MjcV3PuH1zD+nDgwOvfYTqx+oP2c8cCE98CMZ
 cZMZ4nLhV1Cu0b/plghMa2QjocOOkw6PZm4MVie/0lGkn8xU4nr5X85VF5ra6kGeVaYKhC5fe8Z
 u7juZKAfO5yrWVFG3zA8kbutsvTmdOObGvfzPcZH04yeBC7L1YZqi03iTxYPRCPYKDKQtB5pBqI
 pGCvTdlOsHsaDmxnxqFszyqRy/vRsN20dkjaq8QkMwXQlG1MjT3nwZXMSuyhFzeru0dHQHivN3c
 ejAjAitmwAL46UbVfZUvvZpFC6rs5D8G0k8mdqyeEEedBYyahQsUs3iKIWjabh7XMjb7ccYQTxS
 jVlKl9Niz9leXpZ0sWW7TorY16G8qW6OgpOGQF1skdqpaEFfrtq+v/oaOR9AJCKs7/ikiTXTUSq
 QsYHb64RV5f4/YNO+QA==
X-Proofpoint-ORIG-GUID: 3fFuQCpyoPWGBm1Z1OKYYX_wo05VyO-T
X-Proofpoint-GUID: 3fFuQCpyoPWGBm1Z1OKYYX_wo05VyO-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240147
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

Use perfmon_capable() which checks both CAP_SYS_ADMIN and CAP_PERFMON.
This matches what i915 and xe do, and seems more appropriate.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..72b71e9e44f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -494,7 +494,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
-- 
2.53.0

