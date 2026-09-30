Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1432CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F2410F402;
	Wed, 30 Sep 2026 13:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BuQrfCSB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MT8HmJD6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F78A10F40E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB7pVK3955055
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +vn8HrnSp9wF2lXt9UhWS6MvVRq28DGOOCapdNx+WUc=; b=BuQrfCSBZt4SvqDy
 a+BDpxlTxbHYuVE/PkqoKYxrX0Xf3E1gTSCs2dvXukXSYZFdx0mW1HcSdQ+lU+xq
 8pYRiGtvdHYKzqbbhEdww/Kf/NvRkOJU56SLb1uKwKza1a5iwgEdl//wBJmBgCLW
 b4mLYSThm8DFj+fwGfQmYxibHcVa1/wFYrOTtUDtKa6WeOxx3O2tkl7H2oXnMs3n
 0oGaTuylmBpYgbR93eGeCWq+3qdamTqVdZXwo6B2tJGrmEjzrj0icHRkp+kdH6VA
 OSabRVojqI9IooLdS5FkyU86C2Srntxvip1L0YU065oyHjVivbAE6pXgsp43dXPM
 9geQ5g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97vk5v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:54 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988c61af159so175508241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790775414; x=1791380214;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vn8HrnSp9wF2lXt9UhWS6MvVRq28DGOOCapdNx+WUc=;
 b=MT8HmJD6ekneO602RVUYDsEMDlS+P1LuuMnUM8CZGra2w0jD+m6xadgt0FYCgq6G70
 iuJ7yUu42SlaaLAP1dhJAoISsPR8lspizaqyzyfrAFmiKQ+hdV8CvXe9E88bCk1uumRh
 GF7CG8NotTaQwfwR178s7b7UXBsV16POsz6EZIB4Pgp6dLvEb+I+sEc3Ityk9D0BHsE9
 DaP+ZkWLGqeWcljHgLyjTdhCJCem/qxG6PiOvU9cGePQypSqOSbvwPwZEf74Tpg4rhIr
 9Dp4dPqRds4hhpuUu2HwMHlYfWJPjB+IfvrzDvaiUd6Hpgstg18jg4FrtjYbXFtjifp4
 /g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775414; x=1791380214;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+vn8HrnSp9wF2lXt9UhWS6MvVRq28DGOOCapdNx+WUc=;
 b=i0+S1JYoOazX7784002BXXlMvB76GQEExR5fNIDjGFBIVxtUmfMJz9W6A6yYvIC3nN
 vbpkGxCwmKjByP7c6+TBxgw/YwDnE4nw6IgTEwkh0qD4Q7/m7NrVsABVO+SZHtyMBWkr
 0fQ3ZSNBpohnDMfbdVhLM7IbwwPlKD1E0sQNXQw7//E8DINTj7Ps2zb17++fdr1x1nSo
 mF0anrPy9PdQauXkvn6wJQ0TyTkd/y70ZcEVScwcppoPHvYB+3r8FwjSW4BQHchDjmiz
 heea5s1AyGdwYnBqCXr0CDJb4dH6snVu39nvUtD225MtrVOH1S79b4dpcWAfzieKMzx2
 e/Ng==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwHwREYtkp0Y5drjRtz50E1jW9OZxHl7mwIgePVtxMfLkG0b8BYLPAAGl4WMFGF63Z2e9VVlYk8Cg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJu77IszdQPQaLqdfpnKeme6Cr5THK1mC7I/0tdKCXdqzE5HPr1
 T77fCth8NDIdGQhzLZwpneSWr7RwW+B5C6DoReTyYES/6UKkpv07f4KFz2wN38FBxeo8pM7H481
 iJaDw9dcF72TLkMG4y8Ywk7+M1JXMucZKr6XXUKQYJDlxM3bn8wQhkVK0qupO5Y5ckdQ9Dd0=
X-Gm-Gg: AYBFou1XXlaE/MNU7NMUUOYU8SYffEjYh7pbDTSPgu5VCtO6msrcx8vDK/tHOXba33J
 n4nx2a0iG1FGR737T69fmvgHKrZcucisO9sV0GeiFM8tteXkRtTNKeJlSJGV5cLAAd/0YSs2eci
 +PfD7IaTelD9cZ9kmER3ZdRrAQ/JuxrV9apml8GK21h9vhnOjYhLgahK/v5G/EVdkoD9szwK7Au
 vbKJIEWk1ufsI0Pk8PnjQWywxItcLn6L9CWpHvHPGXCImSSAW3DJFrtdmbpkJedN/BP9gUPXQYf
 Q6CwmJxLdG89OwD5C2Fxx8k8Kv3J0pEFQlDRqZd3V+46Av4ChG+OI7Ou3TbVkEQigaJ54FDRowA
 EPMpvWfQjJfHCbKdnfENM8SYzWH597RPYMKMIteTl2JZj1MPRhXd+wNjTdsN5/kGZAvn16winoU
 FZBBNYbSfSRuXb
X-Received: by 2002:a05:6102:26c2:b0:7af:8729:9f3d with SMTP id
 ada2fe7eead31-7be727ae2c8mr269376137.11.1790775413541; 
 Wed, 30 Sep 2026 06:36:53 -0700 (PDT)
X-Received: by 2002:a05:6102:26c2:b0:7af:8729:9f3d with SMTP id
 ada2fe7eead31-7be727ae2c8mr269352137.11.1790775412651; 
 Wed, 30 Sep 2026 06:36:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3fbfb582sm356731e87.57.2026.09.30.06.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:36:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 16:36:47 +0300
Subject: [PATCH v2 2/3] drm/msm/a3xx: Add hangcheck progress detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-adreno-progress-v2-2-3882f0fcd7b4@oss.qualcomm.com>
References: <20260930-adreno-progress-v2-0-3882f0fcd7b4@oss.qualcomm.com>
In-Reply-To: <20260930-adreno-progress-v2-0-3882f0fcd7b4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cvRrPOLxLPbCTpWLiVr6CL+JUOrTZCa+HknyxlPt9Xc=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9Zegfzupx1qVRLJW73ri2e0NLdYsa4RtehkUc/PDb9ZU
 bhGJaeT0ZiFgZGLQVZMkcWnoGVqzKbksA87ptbDDGJlApnCwMUpABOZWMTBsDptz4l9LDt9/+i2
 qDBFvUqxPl3Bo3dSQ/lxf8aka4zu6Yv3Pf/Aac892+WycBZ/mah60Ie0JSplnzQM2C9v4d0v7Db
 /oj7T25+2hpm2z43dBb42uchkp174z1pis53vz8ebq6ff27P71ouI36Gi7yT+x9279ilmhmDh11
 MMNQ1/1gVk/zeZ5hs5qcFnm8FUGVZu6erLWQbmKz/YbTrl/L3qoMaqNzbW5Rw/q4oMLnl/VmjQ1
 RRuuu81z0C+cp7Hv4sMEXqLVvD4+FqHuaUf9K66pPb0rOiruXesVmi9EC+oinJiPTpFrvZS57ZD
 fxd3Cr0KW5XkfinZyz63Zd+TCSKe7HsOzkiY3B7UWuEPAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: BF_wN3IMv1qBRr0159XPEQ-GCIrzWNJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfX+GeKXksGz98v
 d9cA32598lTle/6OHsBBSyqPKCUofla2U2SR9uVQwBA0/IuTV0d93YiLKg326mwJAdy1MG7XzkA
 A+4Eqp2SrwsACY/M31q089W2KKyfo7rkvuouWN31aoBvgjhKuS9ua44ESX+8vLgSRgC9wKJm4kL
 DZcN+7jMhu5W4AfyKBF36Pzr9Wvi3RWoLF+filJpkPXjXRVPSeXEWZL7tzovx2FkGsYg+HCKxWp
 HjbstmqsBttrmG3ujY8wt+99GVjbLBfG24tg4L2nWVhyrU1nzqA0pH6lQ7vAfo2xA1vXpl/Ohxc
 yR/wOUzSKO+HJ/v+7nRcIvbY4itfJqJVxolAS7ZlR8hVJUjSzroFSXIVKn/FVXo7kXRxt6F94EL
 AlOIHi6X184P3Bag1CXmA/flxw3nGTVSAg/m+q71NI4N07V9DaR1BtUQsa7P+qSLWs4zW/tmhuc
 rtIZlhqsf0B3FtxaekA==
X-Proofpoint-ORIG-GUID: BF_wN3IMv1qBRr0159XPEQ-GCIrzWNJB
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abd1076 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=hoswt1gEA0YReVsPuVoA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfX1J8mdkYYoKs5
 jxKRbUvcArRSWWoB2bLkw0iDjeEWHZpNh3jHzPqLLPY4ZWg07PFMAH9Yxr3AjYLMqVWR1/XJ0Ps
 TCoHOE8lBXFXYAP1Jree+73FZYm9gIo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300054
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

A3xx has no progress callback, so the hangcheck declares a lockup as soon
as a submit is still running when the timer expires, no matter whether
the CP is advancing. On A306 a piglit tex-miplevel-selection run is a
single submit of about 58k draws that takes 1.2-1.3 s to complete, and it
gets reset partway through on every run. With the hangcheck period raised
to 10 s the same runs pass without a hang.

Compare the CP IB1/IB2 base and remaining size between timer expirations,
like a6xx does. On A306 these move on every 20 ms sample while such a
submit executes and read zero when idle. The prefetch queues are small
(32 and 64 for IB1 and IB2), so buffered data does not hide progress for
long.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 0259e60b8011..c95bbb4bcf47 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -536,6 +536,23 @@ static u32 a3xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr;
 }
 
+static bool a3xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	struct msm_cp_state cp_state = {
+		.ib1_base = gpu_read(gpu, REG_AXXX_CP_IB1_BASE),
+		.ib2_base = gpu_read(gpu, REG_AXXX_CP_IB2_BASE),
+		.ib1_rem  = gpu_read(gpu, REG_AXXX_CP_IB1_BUFSZ),
+		.ib2_rem  = gpu_read(gpu, REG_AXXX_CP_IB2_BUFSZ),
+	};
+	bool progress;
+
+	progress = !!memcmp(&cp_state, &ring->last_cp_state, sizeof(cp_state));
+
+	ring->last_cp_state = cp_state;
+
+	return progress;
+}
+
 static struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
 {
 	struct a3xx_gpu *a3xx_gpu = NULL;
@@ -630,6 +647,7 @@ const struct adreno_gpu_funcs a3xx_gpu_funcs = {
 		.gpu_state_put = adreno_gpu_state_put,
 		.create_vm = adreno_create_vm,
 		.get_rptr = a3xx_get_rptr,
+		.progress = a3xx_progress,
 	},
 	.init = a3xx_gpu_init,
 };

-- 
2.47.3

