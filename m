Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108D606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S7ml5cgO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NTbdi35j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5439A10FC46;
	Wed, 18 Nov 2026 13:09:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9862E10FC4D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AICLGRP236009
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lwWJzT+CNGMBrEdoIlyyR+008uz6+/iyQlSYxDP77N4=; b=S7ml5cgOh9eF92oT
 0Yyfzgj3aiPQPac/eoCJF0EBk8w5c/rdajTuskJIq7gFY/0Sb1+KQCh2O6zXVCQ4
 NJTGtwF5i+/KyQRT9H1jfk3SU0XprPJ7C5Y+g/rOpfjQA0lu2bXFMemvtgb6glWi
 jrxKfS/aW32fleXr0O2Gr3O7Ceam4iACzWEYJk0OSgB0Mlm3N9RTd2GZ6aRZBKPW
 P4BZD5XjS5gNOz8zOLd2jD5AfIY2ZZZyQuA/eNEZCa9BjZE4SIGg/91oqrWIS1bd
 a1Er3HaEMhZFwnMAyQn0eMTFJGYuSao0m0npokSpMhtHrgtb3jJMaNtezPAS78w4
 oVzF/g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9k2nh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3b3b5f4c4a1so95189a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795007332; x=1795612132;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lwWJzT+CNGMBrEdoIlyyR+008uz6+/iyQlSYxDP77N4=;
 b=NTbdi35jFsSSBX2sXv8N7PbEZNelIGmYHUaceJVQZBySJohSY+acA+7taNuKAbNXho
 BhNJTOBN8A7XA8HvqurDCSKTioxikQjtEt+9o6Iq61ZFjURY+nqZCdMOeZIfffhQibz3
 8emGUBL8P0HT+nMamyDZYV/YlH7RJjA7Os3yvWaOQZQHwCKCDE9KpAhWhCyMAXWmDu2b
 n3o18Dc9yFC1r6lYx1qsETpK3WmKHibSnUhmvlDdNspC4V2K3CM6hRAOsG4pfScLxuSB
 Ic0j1Jw5ypqMEuBKJ2ruV2f5/i7ymXQXy7yJMkxnqGvug18uQT+JfvW28C6SIYoHgQTy
 SObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007332; x=1795612132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lwWJzT+CNGMBrEdoIlyyR+008uz6+/iyQlSYxDP77N4=;
 b=0cUuATUv54JI1chvLjjabRrjz05gr5TJu3dvpQ7Jpp8cfhLg74JY3j44Frd/1oInJy
 b0mNF7XhMfvoXRpWM6+m1c0FK9gAxEdNWfCFXaT2pWnUq9FjL4TSytbUlb8mbo5pD1Od
 AYDmx+I/GY+ltnHNgsi2zh3MrMTJL2FX2rlW66T5kWSeIWsjd1eFZSI8+1GTcuNRF2nl
 CCjwVNzKtTc3sudKu5rvT0TfGjuNNNUqCU1mnQCxOS41BCvSMhCh5rT5zl+OcjjYEc9V
 xA1ACNtd6p1lB6S0nGc1cYIL7iHihL7JTWzUrvP17d01OreoR0mhCeX0x2uIZ6HuYpNW
 HBdA==
X-Forwarded-Encrypted: i=1;
 AL+hErFlCEwWeuxPCPlZRhbbloOX4XC+ZUP9bTUAWz56qqu5cPnvVpYkNYStNIU15Z4MtknvCR0QABkf7+k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+5Xru/rBxSv4S48XqIVOWOxUv7xQGyvBJ3w04cTIyzzDWRZFUm
 o9IxN1+TpGCaP9Z8E2caH129Ypvi4zSE8elEwpmAUZ/dovI1uG3TvQnenXMWOTys/m2WcPVSqak
 QONxVi0eJr7ZPi81WlF9N3iKjRP0cA17q6XateAOgngIy8R8CO87fSBp90QEMX0vtdAGvMgc=
X-Gm-Gg: AZFdTZcIWiIWTuoXS1AjA/EdpCQ8UlEk3mW4VR2uONcLVFOlaTiDQ/apz8n+SiIrihJ
 xPStrfKu4n5wLu5LkHdujuQcopkHHmW8jytrnSaxdih7z2a+C96KLRQBzj8SxN9BH9Hgz4ekshX
 VmU8fk6jBW6lFUe9HSfLaet6fbpdgT+gQB80Z05VhR1IK2blbYjWhWVqE1Uv1BdMI3nQ9IOXtOL
 qH+14rdJGdDnTqjmayz73B1r8QIUt1hcs9/s2yx/jOu72a/yYzAfr8l3t561R6cqnc0OOISOzEM
 Y1P37xn+1jbY+NnisyVKjqvp58zOCpcFvgjgdgn/lhYoW5vtc1Mprcr5pXSmbnhtMbWWbRMtSOM
 GxfHvEXwqNOqm0Oj0Ncvu8kyw3Z5xHIQjmBirVEYZ4fkPwNyst1nH72QpNqGuxNtH1GJYZatSYd
 scoto/RnU8
X-Received: by 2002:a17:90b:4c90:b0:3b0:9984:18c6 with SMTP id
 98e67ed59e1d1-3b3d07a0068mr4500191a91.3.1795007332237; 
 Wed, 18 Nov 2026 05:08:52 -0800 (PST)
X-Received: by 2002:a17:90b:4c90:b0:3b0:9984:18c6 with SMTP id
 98e67ed59e1d1-3b3d07a0068mr4500143a91.3.1795007331730; 
 Wed, 18 Nov 2026 05:08:51 -0800 (PST)
Received: from hu-pvgtejas-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187dc82sm4909533a91.6.2026.11.18.05.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:08:51 -0800 (PST)
From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 18:38:26 +0530
Subject: [PATCH 2/6] drm/msm/a6xx: Don't fail GMU resume if the GPU init
 regs SCM call is absent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-adreno-scm-fallback-v1-2-e99cdbf3121d@oss.qualcomm.com>
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007310; l=2583;
 i=puranam.tejaswi@oss.qualcomm.com; s=20261118; h=from:subject:message-id;
 bh=Ikh8Jp25ybn28MQXj+X5KpMXylrXqgcLJNRSS0C2Amw=;
 b=qgO2mCSHBkMT2IZBJ4y6YVMtedj4fnlA8tElxBtxvVLp6Reyfv/TVy5jdV0nrJFJfV1l6IXlk
 uBOXs6Y5cABBO5P042Bqye2Ak3nnTt2nodrQ/XoHE775VoQY9kO0i1q
X-Developer-Key: i=puranam.tejaswi@oss.qualcomm.com; a=ed25519;
 pk=I7kFxZ7dcroo7ZWUatk8fR/J/KVbRzZq4ZBLhRRGpJo=
X-Proofpoint-GUID: VknlzWwwXzBbz0pIzJFQvdZmfDRpokWc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX1n6fI4jb8d7U
 I3E8H3k53UOVpLucx9u4WamtpMQ8/U6OXtpZKoQHAAiRsagrOHE/c+PYbglJ10cIpoKEf9V2Jj7
 2OeLn16abYGEnu87n29PxgcoCgkL498=
X-Proofpoint-ORIG-GUID: VknlzWwwXzBbz0pIzJFQvdZmfDRpokWc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX7be/q2NmXg2l
 JPMMHz4vC+zim4nNmdlzo5MNj6NNcCk+Y0DAfil2aYo5Rynea95V8De35flGxZwsakV+Bk9UdRb
 kHnahNTT4iTPCLRS03240qXDwU0pXzs2Osr2enqVQTmLouNxvBusaesvjtyJqv2VGd4HTPsP0GO
 QFJ1TUUGciSdacnmoznnaRfcwC6aUcF7RW1kzq/ba+dygtg6TuFauK9BTt9lfX6EEoUDuLrX1di
 1CfYKXbrEekjdUaO/fyMkQ/YcA5sVPzKHBMi5PDfI+LFa3FP2qDdZkzeYXWw50qVrhpy4mgkVt0
 R6+8ye512xMDnA3hU5ib4yOaJ1GtkdEqBJxioyKZsFXb5IhdDducqpvcbZKHzDKCJO7dXLK3TjW
 YiViBk6UgttjO5z5Wgk1lcB0PSArePBhmVcSDjduHXZzvmtm27CPZJn0I2Pti7KI9XkRdoGAyz6
 fmZXBllE89X/RnrFlEQ==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afda365 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=cHdlivVmVl0iieOMt08A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180052
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

On A750, A753 and A8xx, a6xx_gmu_secure_init() asks the secure world to
program CX_MISC_SW_FUSE_VALUE through qcom_scm_gpu_init_regs(), and
aborts the GMU resume if that call fails.

Some platforms have a secure world that does not implement this call.
The call fails every time and the GPU never powers up. The fuse
register is still protected from the kernel, so the driver cannot
program it directly either.

If the secure world does not support the call, skip it, but still read
the fuse register back. An earlier boot stage may have programmed it,
and the features it enables, such as raytracing, are then reported
correctly. If nothing programmed it, they stay disabled. Log once when
the call is skipped.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 0fa2d2091f3e..95636dabee38 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1249,22 +1249,31 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
 			goto done;
 		}
 
-		u32 gpu_req = QCOM_SCM_GPU_ALWAYS_EN_REQ | QCOM_SCM_GPU_TSENSE_EN_REQ;
+		/*
+		 * Some secure world implementations do not provide this call.
+		 * Skip it then. An earlier boot stage may still have
+		 * programmed the fuse register, so read it back either way.
+		 */
+		if (qcom_scm_gpu_init_regs_is_available()) {
+			u32 gpu_req = QCOM_SCM_GPU_ALWAYS_EN_REQ |
+				      QCOM_SCM_GPU_TSENSE_EN_REQ;
 
-		if (adreno_gpu->info->a6xx->clx_tbl)
-			gpu_req |= QCOM_SCM_GPU_CLX_EN_REQ;
+			if (adreno_gpu->info->a6xx->clx_tbl)
+				gpu_req |= QCOM_SCM_GPU_CLX_EN_REQ;
 
-		ret = qcom_scm_gpu_init_regs(gpu_req);
-		if (ret) {
-			dev_warn_once(gpu->dev->dev,
-				"SCM call failed\n");
-			return ret;
+			ret = qcom_scm_gpu_init_regs(gpu_req);
+			if (ret) {
+				dev_warn_once(gpu->dev->dev, "SCM call failed\n");
+				return ret;
+			}
+		} else {
+			dev_info_once(gpu->dev->dev, "GPU init regs SCM call not available, skipping\n");
 		}
 
 		/*
 		 * On A7XX_GEN3 and newer, raytracing may be disabled by the
 		 * firmware, find out whether that's the case. The scm call
-		 * above sets the fuse register.
+		 * above, or an earlier boot stage, sets the fuse register.
 		 */
 		fuse_val = a6xx_cx_misc_read(a6xx_gpu,
 					 REG_A7XX_CX_MISC_SW_FUSE_VALUE);

-- 
2.34.1

