Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C6B109C059
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1ED510E900;
	Wed, 25 Mar 2026 18:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="alB8XlKp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q2iY3huJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3A310E900
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:40:51 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFH9lt3532408
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mvdkUSKRAO5A5qk1dmV1+LN6vXJ34iPcEA/
 OJJ+Ig1M=; b=alB8XlKpiWAXN7LlE++Jw/vtqeVlgKNabedRgJSzMbrw9weiY+0
 pFhM4qnkvY7YkAITdIWAaJEJJMBhH4goIivhBCWU/NmedpPjl/KYIVDcKthRoXak
 fG3SNQA0d8tfma0H4qbTz4tf3Ly8Q9THXD1KhLX5Tqr9AyeOQJU04EAz+FtuhLL3
 ydf7fhs2RMlB+FE8VU/PchGISiynzi4tKD36mru5QwhPdo3H5vrM7Krp/c7G9oX7
 6sAHwcHOEP78AKDfrf+zXLFSLc9a26OIqyI21+OcoZYLp+NSx4n9IhU4twQdiTJq
 /tvvOCC4m0XwFS05lvrdVe0z5gqRRFALk+g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dy4hudt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:40:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35b8f351debso349719a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774464049; x=1775068849;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mvdkUSKRAO5A5qk1dmV1+LN6vXJ34iPcEA/OJJ+Ig1M=;
 b=Q2iY3huJN4G5aBIk+1KlDxYNULjc4q1BuzjSAsYZR65KqqTbAfbkGMyCNDMhc6IZ1V
 fnQEegtSC77S7hNfoi6KJMRTtkxIRXsevYMO13KwkIeW47BXVh2wKtaN6v2hlT7GykmR
 S+BYGPJA1mda0j4bWwh9zMdQutYWDSEQS5QEFNesBwuqJu6f1GWS6FCi+HM3IJoyeC/N
 n8FbOrqV8T6LL6j+w/afhUhWnbMJXC8mOwkUGrwpPTpCJim8w8BPMuYbcubPiHUrZH+k
 7VEiaOovRDhqWAy3kvAYBXRQerMzu0cCkichLfPPRtspU4eQPn3JmYwpyaovbpuQNE53
 VYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774464049; x=1775068849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvdkUSKRAO5A5qk1dmV1+LN6vXJ34iPcEA/OJJ+Ig1M=;
 b=hHzSSgEk9RqQyAcaMdZFeuywQUBGy5LWC+U5BcJXGOSyRBveZZtdlzzAjGkIqQr83m
 w0t467Hs2o/UACmlYH1ZAd+UDbq9Rqpyy07IriV73Jo2M9LkOP73qikaHdlJ591o9eqi
 3gyeNlfjGihr4MhPt8SO+P105MiIQCkmDDKHE8iimilIURq6v1XfrvNAcYgE6SvzCdqI
 9pblv0zxoO/Jhm0CRaipUiPGTKX1MymUFVuDtt4UgZsqN0RDEAGdMuapcsMahVPjCTNJ
 6B1SFOEyHnpdwaF3s0YkRhJfj6WvTj903jZ5K+2bRudydQm8IDXd+uVRQCW83kVxnoqB
 hpMw==
X-Gm-Message-State: AOJu0YyrIp2gKT/iyjudDt2rwCCtOIo52jK+ruaA5XJ3DF3HpW83dYUP
 aASpXU95SIhEliQSsiXVa1EYPP3KkfOB+y3unsRkNIm+Huc9l9jNcaGImJec8u0jmMgh5m2vTvS
 ZUh+IF9e3kjpVAuTleSx7nU0wBLlvBD6GQnmQ0XGupnuupxebmdm34o6wkWt2hL6Bm0AJvKpBis
 SATPE=
X-Gm-Gg: ATEYQzwS162a8hi6m06JL3fPHSHSs5MuSDp47fE5PJnBeB5Gxg02tGY6MSn/iKdE+rN
 2yCv9QYMvjxyrgaEO4O+CP/QdvF26fxmaFUCOvxn9EoftrJKZeVnIlvRLt8QMg+dgd1p/rJGaJS
 xeKQIn8rxe5Xfs9HJDcFnmn74wY6ys9HhfQnfdrqB/sMTfE4S/pJJ1DJlX6CynLlC1nIvuIoAdJ
 EKnuFc9v4RTNyxuiiDhzYzMFtyQVSywglyTh6Iaaujp4qI0vC3mcpzT1KDtP98hxcJKDoxvk2Rv
 y+WYS4E/LMewFBRr0cuugl+ToPbeLB0ougjRMqmf+C1+1FGwIzFvGZPgWJ8G4JpKrPFMghbDxHD
 DRS5gwNRzj5Er3VCWvpzsiZybATomjBBe
X-Received: by 2002:a17:90b:6c3:b0:35a:1762:92ed with SMTP id
 98e67ed59e1d1-35c0ddc589bmr3883536a91.24.1774464049578; 
 Wed, 25 Mar 2026 11:40:49 -0700 (PDT)
X-Received: by 2002:a17:90b:6c3:b0:35a:1762:92ed with SMTP id
 98e67ed59e1d1-35c0ddc589bmr3883507a91.24.1774464049121; 
 Wed, 25 Mar 2026 11:40:49 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0e7452d8sm3198165a91.11.2026.03.25.11.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 11:40:48 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Connor Abbott <cwabbott0@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: Fix HLSQ register dumpping
Date: Wed, 25 Mar 2026 11:40:42 -0700
Message-ID: <20260325184043.1259312-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzNiBTYWx0ZWRfX3B36hMm382gy
 h6XqNf6dOaff4w2loIDPUyQ9m4VMuCmdWS+GcqCJghZGmJ6fXHN1m6klFVXTQMoZyfFJbqB9MBs
 72THzZYyeaalZM8gVBLe8PntWDmAC3bNJwP778hB93U0+pN5e5qbMn+x06GfWwIw1arv/EUc3yB
 B9iXoff+QsbovivhZkqq1GccvkrOpDCtTQxhtsGQEU3gm0jDgrygdmTpW7FD9CteIPwJ008322O
 mJLyoeXHVoctLnvWAeTCy39SYAEbxYc8/vfZt1xZzlx3vEijT8MMLgjmNgV/YAMmV0wan15wLZX
 9ZzgezbItBmwvcv2rVS57JO940DAzIJ5SE3bwy72l3bhpt7RU23PJpOBeZmEoxcgJ0gLX04ZroU
 LM7gbJK9Tu6WK3tD1YHB8U3ColjzOz70WQqfc5p7OyCl6y+gtBqM3JUubC06W91cgxgP1Eft2vC
 T/+ISyiGISkzvyqHyPg==
X-Proofpoint-ORIG-GUID: hTqblc4eddhRBeZHcjfzUOkeHHzfQWO3
X-Proofpoint-GUID: hTqblc4eddhRBeZHcjfzUOkeHHzfQWO3
X-Authority-Analysis: v=2.4 cv=eeUwvrEH c=1 sm=1 tr=0 ts=69c42c32 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=AYjmxK_A9T-BKwGzHN8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250136
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

Fix the bitfield offset of HLSQ_READ_SEL state-type bitfield.  Otherwise
we are always reading TP state when we wanted SP or HLSQ state.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Suggested-by: Connor Abbott <cwabbott0@gmail.com>
Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index d2d6b2fd3cba..f7598d0c3975 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1013,7 +1013,7 @@ static void a6xx_get_crashdumper_hlsq_registers(struct msm_gpu *gpu,
 	u64 out = dumper->iova + A6XX_CD_DATA_OFFSET;
 	int i, regcount = 0;
 
-	in += CRASHDUMP_WRITE(in, REG_A6XX_HLSQ_DBG_READ_SEL, regs->val1);
+	in += CRASHDUMP_WRITE(in, REG_A6XX_HLSQ_DBG_READ_SEL, (regs->val1 & 0xff) << 8);
 
 	for (i = 0; i < regs->count; i += 2) {
 		u32 count = RANGE(regs->registers, i);
-- 
2.53.0

