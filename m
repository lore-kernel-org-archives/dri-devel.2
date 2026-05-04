Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC41CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A3D10E832;
	Mon,  4 May 2026 19:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VS92g3on";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVnueXYu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9051D10E839
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644DrHEm331165
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zVhhihIWGcW
 DVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=; b=VS92g3onfef2nfVAYVBljos5ZSe
 X+uND9pTg4qVUdPXXP9ZQaKQzZgKdEhoj0IYG1kWx5JcW2KKdnV3DoLU3oJnIDo+
 D54RY+hvxrrfe3kc8dwVTigLN/oQ/LFloR/kyqFqgnMZrwIHVPPy/kIsgJuql0fc
 4QaErOamzKIaV47WQndRnZIOoWL/yKUBw9/+t4OrTXFZ+jYe6vClypzFKvBgt9MF
 yz8mfx3fPZaL3k6oTpy1WVyuGRgnUJfxA3IFoFe3sPw/bBJp+BoswdkGklgz0jdY
 zYPw6T6R2LIolDSh9Yv1clC8M1WR5PMBbur9alzShPFaBbzCgW4FWAesY2w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr198rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35e56ed5d5bso6091340a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921723; x=1778526523;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVhhihIWGcWDVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=;
 b=iVnueXYuTsUTzaaS6HYD0bkovFaD0iofZ2DH+XHjlEXJ45RlxiRAzHXWSaD8sX43+/
 UDu+0RGvclI3MWBgZ9PfNtr74ZnhWdog0+rwgCPX35Ge6omOXTGLKlTof8eIp51Od5S2
 2RarQzCzv1xLZcEq2hPTqFGBzfh2M1CNYF08edqD70wdjTVaOoveDvBEK2ZM+z2j2/Pq
 bCO6qVWXYCbK4MFwHknBrXH/Ro9RG06NTXPAsxWv4yvJ7SkAUyxf5q/UOyAJ5zq+tNmk
 GluXvxy774SuefTjTWZ697obL8dYCjqgMucM6UzEZQyiRke108tNVUAdYQHKDEJDxE6p
 2lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921723; x=1778526523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zVhhihIWGcWDVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=;
 b=dAR8O28ikOcWZfFX5TKzA6gcueCqSriRj76U4siiU+zZEw8pUawIrPal0F/3DyTwFb
 DfbuXdsy+uWw5A1J9Y4Jsxel5lEc+Ywh3I58o6RSU3wNbWLNCh5T4N2EHSzN+BYa0iFc
 P2doMVVTCXXSGNAmYAdJCjOgF2NN9u6VniXMgvR6MKwmIpL7GUndJNFEH7LNsJg951cB
 idlvFHGIK2qHM/IC1LF8ncbMu3+WtwJnlwBP4an6zrt+ziolGSUdy7xvg7h9Rf1MsqAd
 VyRlACGQln+BuQX7oWJkcpibsJEahVqW4PKaXagjwmKAKsBwGTKwitlXXMVcRw1koRSj
 qAvw==
X-Gm-Message-State: AOJu0YxuejvPm/FdBgUaXh960WbUpcZ0yP3TH20azRCJJnvz0iV/uRgN
 tMrUjxxlbRr5OO3ntw+Jj6xx5Ahp/vqXy2n6XPTZ/QyBA69FR+3zjCIsdviEhDmB6dppUeAtO53
 o7CWifKt22U5iuFPZLiGNBoYQZKRGNfKnOitdYESlQupcliuMRC6Swh5G1y2bkuJu+mSZyHXQsz
 g3idU=
X-Gm-Gg: AeBDies2cHhGfddojmP5C87rS7BnbHjg5L8ouDJda9AB0pbK4WahWPMrKN2iV8f+jCw
 5ABI5xourJH0ITBS4FTKiQ/niSSCNFc1l4bUwfqpsSe21YMxAe0aaR0OMSjUsVWtYEj/QKyYcxH
 CanjaZjsOUBUS9LviwCBypI+ig5qitBj1EHNuArNCPYvwNUV/zYZipiMT3ad0w7bI9JdGAI054w
 mJ7E3WhiU7FsewZJWSB5OOp5PRZmUkzmgvZf4ynfN1oa/rw59hu/uZzRzgvePBHLXoFjeWgfO6r
 Z1Vl4OSMUQPMY7DAXjQlomYXALsuXubcEGYP3cyGVe6Bs0Nz1wQwMws2FBJuK0PKg2yO8xvf0xw
 6ITn/fYlx9Wsa5CQEZHgjptus3ACLpGuGZwpmlNL72Zo=
X-Received: by 2002:a17:90a:d005:b0:35f:c1cc:fee0 with SMTP id
 98e67ed59e1d1-365724c1a6emr559019a91.8.1777921723104; 
 Mon, 04 May 2026 12:08:43 -0700 (PDT)
X-Received: by 2002:a17:90a:d005:b0:35f:c1cc:fee0 with SMTP id
 98e67ed59e1d1-365724c1a6emr558997a91.8.1777921722572; 
 Mon, 04 May 2026 12:08:42 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ec00ad4dsm15850171a91.11.2026.05.04.12.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:42 -0700 (PDT)
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
Subject: [PATCH v3 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Mon,  4 May 2026 12:06:55 -0700
Message-ID: <20260504190751.61052-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6E0ezavztnthzihMRScchuTYydy1VJ6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfX9AL8tRzgNEk4
 UGeq+C6o++DOcW8OwuKfCZA4rkLTwcoG/7KJxCtAzqEqcZLNyZPUBTBQcp5kIJAClK1Gefn1X5f
 4UHlx9L4qq6Wc1T+zKdTTYx/qO8l7T2PQjMivjjrPgnIY+vlGi80AXZY+zus5TPEYguDPBVmhoB
 JdXAq4VxCWRKXb/zBQjXmPlLw2UD1GUK1z1M7VDkelPfbMKtP8FPcGy14QcY0sWEy4YLgS+0Z7d
 rZQTqBSVlcEDBF5GdsGaCVVPuFpnjoc2LQivOUVJiRs3/Pg2fS5zxsWglx2Q58XknsEqlE0JHHk
 YThGLtwkT4XTzxgZGvKfOE0DFPmdhs7iem8JMU1o4abTX5rhS0EpsU2fQRoj+DITkobQMsMBNfr
 UbpvZDA+F6rkvaUsbYU12GaU9qIUw1p0waJwkRwzrt7ieB9Wzc5h4D7/ooXFXJnMlmCSqej8L2U
 /7cd+LQ7xfw+mPoQ0Ng==
X-Proofpoint-GUID: 6E0ezavztnthzihMRScchuTYydy1VJ6X
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f8eebc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=W-43u8CF5Pkpiqpb4b0A:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040175
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

With the slice architecture, we need to flush the slice and unslice
counters to perf RAM before reading counters.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 30df9bfa9ef8..a329d20033d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2921,6 +2921,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.progress = a8xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
 		.perfcntr_configure = a6xx_perfcntr_configure,
+		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a8xx_gmu_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 99c3e55f5ca8..3491a24a9320 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -334,5 +334,6 @@ void a8xx_preempt_hw_init(struct msm_gpu *gpu);
 void a8xx_preempt_trigger(struct msm_gpu *gpu);
 void a8xx_preempt_irq(struct msm_gpu *gpu);
 bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+void a8xx_perfcntr_flush(struct msm_gpu *gpu);
 void a8xx_recover(struct msm_gpu *gpu);
 #endif /* __A6XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 124d315b2469..6c040f718176 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1345,3 +1345,23 @@ bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	return true;
 }
+
+void a8xx_perfcntr_flush(struct msm_gpu *gpu)
+{
+	u32 val;
+
+	/*
+	 * Flush delta counters (both perf counters and pipe stats) present in
+	 * RBBM_S and RBBM_US to perf RAM logic to get the latest data.
+	 */
+	gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_FLUSH_HOST_CMD, BIT(0));
+	gpu_write(gpu, REG_A8XX_RBBM_SLICE_PERFCTR_FLUSH_HOST_CMD, BIT(0));
+
+	/* Ensure all writes are posted before polling status register */
+	wmb();
+
+	if (gpu_poll_timeout(gpu, REG_A8XX_RBBM_PERFCTR_FLUSH_HOST_STATUS, val,
+			     val & BIT(0), 100, 100 * 1000)) {
+		dev_err(&gpu->pdev->dev, "Perfcounter flush timed out: status=0x%08x\n", val);
+	}
+}
-- 
2.54.0

