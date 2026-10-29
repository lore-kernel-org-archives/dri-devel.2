Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06530606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RUJb+C1u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b4yCm4sk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4A6112526;
	Thu, 29 Oct 2026 20:18:14 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C7B112525
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:56 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjY7x1658241
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0EyBq73M3y6
 JMi1MhPVn67wbOnPe2w7nthY8a8enDx8=; b=RUJb+C1uIXul3rvMM8q4C1F/pTw
 EcDYyvLPztQ+MGVPjVr37Pmw0wKk14hbKkIFGQbQZ5YcIApI1KGYS1dWQ0mEDqKC
 LXebNeBDrKFLuyqz/tiYZCS8irilnPkV2BWE9uXJ9unSsTg6ssJ31FTO9nw+pQuW
 sGRluaZm5qcnTMZ/qF8QAEqoZOHaVTwVRWJF9n1vC9EHHaQSv6JYf1VIdj4y2ai0
 QZyToY0lS1uMYiVjufvxf3clqaZUiKlj/Vr3ptEDu5zpSy/JEBqCLPUTBsxZVo0T
 niN5xF50JvKa7YPw2iQW+psHapqANuHmgdtKXl6UTZO2iX5pzqmrDz/NwHQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmaunhh85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so6401a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305075; x=1793909875;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0EyBq73M3y6JMi1MhPVn67wbOnPe2w7nthY8a8enDx8=;
 b=b4yCm4skEuxwFJR7K2MZaGest9Zb6AtvrRpPoNJOTDsxK8vBIr0Tq1pIwd2GwaDZsd
 WbnCY7ZlagRpsz4kOFKWrBP/GD7z3ggAxicUH0Q/CrxaXdUXN1J5Lu/8TFo+vKbzJN6t
 BqNL/ANzGMGpZ7fdkqo+GtzPq0mLABm8yEuJ/lJad5S0LjXJrHr3ba5QBGKYZi94oQIh
 SqL8G6zEyMyKmBnGnuFCalR2mBg6Kq830lQlJe8LRGnjx9Q3idwhad+VSGbNKPF6ktHR
 LeOTLdA1cyUx0HJ4YpeOsVQdhBkaXmm3qL/MyBGTLeWHA43wxoLsXB/Z7FY5Ln5GZEig
 HqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305075; x=1793909875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0EyBq73M3y6JMi1MhPVn67wbOnPe2w7nthY8a8enDx8=;
 b=tpsPdhi8VYZSEcfHjtiS/U2HepvILY3OkPKBxR5nONJo1sb4R+FFmKDvis/WmRBykq
 /L0N2/u7Rmiwd9c9jytYoUKNzEk43zvtAK0F69Sa99PTmkQGlH3pJx+WnRYM1Uk6fmsm
 szpiJAvJN08ia2fy7IrLB4IWJsRuL+6TAoH5kd5J62XfHaoVkSjR65U8wJoL/BYKEhqC
 6a8qQPMgu6nSE5S+4Q9vGNOoCaXKiydZ58yJowPF2tkg+Gx5JjLPsx2FxwcPijhRk5C9
 3kIc2zI3dPTJOksyzYklbOJBJO5yP2WfZ4BOdHSzigM16fsTHuWGVKZ/nnbr5HAk6Tca
 aFlg==
X-Gm-Message-State: AFq9FYIl/jwnbwpK12dwyVYZXqMJSkwhP/jCd1/n1a/9D5v3HUemGPCi
 I9WY0JLryrjCF9oXpqHpTPbpSBdT24AAzyNTBPOL9AbqOmQP2jCUACrcxjpTK38univ8LL70sB6
 +AkF83q3aomEXtL5Z0AdDz7IXpXCSFvPynbHir4IZ975qbQiKpSC7n8hKlia4s0G5q1mgrV2yuE
 tvKZ4=
X-Gm-Gg: AYBFou0nJZdfYshfNrSSIwzXNfCpucdYhSgJoFRnGapZcYl0a7ZBINNk8jM8xY0UE8o
 Yi9iiela6Xv3spgKqJBCX1sCOkHaS+HbrEnrIJalTjfDzyjGAVC4/T3nIfFtTt0yBudWC+SuFYi
 hqPGalbfYdBuAdcz5tR44OyUTu1ObxbxMNBnpFlxAoYdk3uvDNXHQHgG/j3aq2rFbP2YqIo/mEe
 j2PhIR6rg59gVUfW5TzyAP3DpMTnv0TzFEgeEMZw7ojd9jXZIR8cHHrFu9RXhaLmVPl1L2YaZcG
 iK9zESeDaKSrRV0hncfBfKyrXnWx73s4sYpQKHtSATfY4YlmLc+PecrIJyN6ZFzgej+oKnek0QI
 AuAe0d7nvhELsMQnLDvU9yB+7Vibu/LkFk7KTP4vRvzsWl1AjnAm+EueC3NFS3kZEVZmRT2BLo3
 Q2+EGS9R7MPIpggHLhDmhcIA==
X-Received: by 2002:a17:90b:1b08:b0:3ab:884b:65ab with SMTP id
 98e67ed59e1d1-3ae89857dadmr58260a91.55.1793305074221; 
 Thu, 29 Oct 2026 13:17:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1b08:b0:3ab:884b:65ab with SMTP id
 98e67ed59e1d1-3ae89857dadmr58235a91.55.1793305073770; 
 Thu, 29 Oct 2026 13:17:53 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae87f99899sm102052a91.2.2026.10.29.13.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:17:53 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/16] drm/msm/a8xx: Export slice helper
Date: Thu, 29 Oct 2026 13:16:14 -0700
Message-ID: <20261029201730.151754-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VQ2QT2-B7RncnFqyAWA6_Yz2Qray2zc4
X-Proofpoint-GUID: VQ2QT2-B7RncnFqyAWA6_Yz2Qray2zc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfXzSDNikyEkg+V
 LuRyQ5fzDXsn9ZozkXc76nwVI+Sgc4y3NjsihaPCFpCt3an8sJmlflAXzdHQhiEthM5msLvywPB
 AsSmp3nH+h0PPHQ5We2VUPcgdN5G2aU48kT+KyNjRGsGZ40hI1uwGHg+UHCfaceT5zm8VFAh0mq
 kvArU4F8kCCV3393/xMcIXNUGFAiC8FqCBHuH7BNBK4cQe0CAxastyT4MvW2JcIwifNpy2LMogX
 hwt1pN5Oh65yKdAfewfdef74DFv3Su5uC7NgdOpsrRcBmnSrLW+xFx5golA74EftldtdQahNXxu
 0NbiAJ+NpdHryjG4i0ut4Ok8m821MX6Q1LrdAUK6Lfnwo6BuY0pywuC9+WpIgmQ6RbGLW+3XIxL
 LIKNlzK8lbBFrqZTuuAJKfD5hioeWAU8WnW6TCFv/rlKYN9LbkzNti/w9nPvOK49bHOnKFthT33
 6oxATObdl0LgP+Ak4Sw==
X-Authority-Analysis: v=2.4 cv=It2L47/g c=1 sm=1 tr=0 ts=6ae3a9f3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=HwyinNJ2ww52bJxqQkAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX8zQIAe8hWbM4
 OngKUG0efyyEPlLt7g/kSrOfhI4rEs97OchUlbV1DZqy3ccjrfO78iOsqjfVNxwZ0b+jIKZ5avV
 YB7CnXB00C666dhte0Pvq4vWelLSxzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290079
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

Something we'll need from the gpu snapshot code.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 2a2ddba6761f..6b23d301c144 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -359,6 +359,7 @@ u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu);
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
 int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
 void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu);
 int a8xx_hw_init(struct msm_gpu *gpu);
 irqreturn_t a8xx_irq(struct msm_gpu *gpu);
 void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a0983e2ee641..8e91edf16ec2 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -127,7 +127,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	}
 }
 
-static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
 {
 	return ffs(a6xx_gpu->slice_mask) - 1;
 }
-- 
2.56.0

