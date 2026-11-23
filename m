Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C2606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PXmRdqzK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iM6a7YYp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A99510F020;
	Mon, 23 Nov 2026 17:20:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8026C10F0A1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:20:33 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGHBhT1094045
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=GhMv3tUfF0X0waf9LUoKmzlbGF572ZAv+Ki
 gzstD1XQ=; b=PXmRdqzKV2K7IDecis6FOQVkzj+jWxMrlsvLrfp2aP6AKzH+0xM
 GXRNJ5Z/Ei4ogq6XF+V2FFseBcnaDFHSQmpa3ZpCwtLKtAPGKJ7pEpLPi1CjBWnT
 NhFHFyuiHLIED/PI5wEwF9s1dRQaB6v4fWhhxYVGi7wmQqXPhes1vhfFPi+mO4Pg
 lgxx7MOW8WOKa8p+x/tA99QHR0Ajg5nRQFAfRPUM/52bxoFYwIM/czwVzaX9ifcG
 hDoaxFE1z4VVXL5H2gddpSxeUWFLV0CnpTNo/skMMl32D1kcVNgmhTcZ0K6zZwhw
 Onc3LPf+dAaBLsApVsxU2S5lqdKInPtcQRQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0sgd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:20:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b42c3dba96so4103247a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795454431; x=1796059231;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GhMv3tUfF0X0waf9LUoKmzlbGF572ZAv+KigzstD1XQ=;
 b=iM6a7YYpcCR6+4vsakTCZfF5P0RTG4UIl0ncy3NhCYWQsHDACFabFLtneTxFVFUG/Z
 tFoRfVxD2Tb2lDI6J0A8oTilbyuGxUZ/+Pbilfvj4TpuKs+ioo36y21d9fe4a7RnRfPx
 J29Fts4lLGOTqQ77WEr/gTThfccDi7hYRgD2pz17joB+k48nTciC3JGa08uxvQe+vhN8
 HQiZdBZPY/26698pHKotsXmO6z96Yl7p2yQIRi+SKBLeBCyqwaMEy8btOxNMAGyXB39u
 5lATXS7URiyfWFZaS05dLID3WOjRQ/J4Mx8vL7pM2j4wJoiQJ0oi1sX/lbn4JSCHrzUj
 YnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795454431; x=1796059231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GhMv3tUfF0X0waf9LUoKmzlbGF572ZAv+KigzstD1XQ=;
 b=zGwTc3e843buyZWcoMUJiFtRVdz49PmxD0/shyfdTwajPKLowKM5qyNW4KZxhJuZDZ
 gM17j2iD2LPZx5xuQpDcQ1yEgnjxfYMrjFF0vad2vcESTF+p64bB7iuWF4mxgO+qdLL9
 M8IJUE/gmA4VnM7c1aJCOUKEKErwHQEsau4mgs0H1PeAjF7NUoSNXpdsaqgKKFIJYtmO
 IiHB7qC2WBPzEqL9lKXo0OYVRfPaYrfUJwDkeXMdGpFrwkYcF20O1gIGB7fL1XiYcNMf
 id0akwszxDzlSy1SquzSaEWoXjzLXmCzw72fDWwSP7j2NV9P7ZHflx/SMcxlaH1Rgn8o
 sSUg==
X-Gm-Message-State: APuU4Z9vNW8sDXdZfMkyNvolRGW2b/wNmSLTjVrBmsJXXFKYBjDxMlvq
 F262CFC638zrxyTQgGm7e5D3HPQtSHMa8qvzigzP4DJuGcA78MRXBc82bLqlv9zhdl9SJTV/syw
 q6No0ytgnG958KRwtIoWB7+Z1wBSrq3X2+S8uOZegMwOxSWv03e2LBuM94WW8ox3eMHH6lKZTVZ
 owYTM=
X-Gm-Gg: AZFdTZfhkuaepfcM3SvhN4eaVnDhwzukymjFErMR9HW6VWw5qbeqRMEB0MeMeXZOxv4
 UMMPXDptpIKgiwM2g28oM8gy8inohGBWtybj7GtrHbJ7RXR9q8py4LnE0v+POQ4cxyM1Eh1cpOq
 k9IG4HkZy/U6lAkKXpYInTnH+ZpDzdHk+/Bq8XOFjm4ABfp9sh9OHettsueaTCcW3KPWe+Eh+B9
 d48EWnD75p+vkfPsSp29o2kJ+Sp4bOiT9x3s+S0G4SVl8dwjCEBaJoGLUKunbmCq/t5D5EROgpz
 BDdbF03hFMvj4dX6bpWKOW4OJp2vnu2AjVDRaAS+ADuT8TvM30w9Neo4DBHXZbjqO8zFzwf7ZvS
 rTcMYsP0DKWWZUM3pnRIAsOIRjK+ESougdzpunSB3geyhAcu9RcJ2F+7G1C3+MItH6Vh/zjV3dM
 cB8OSKU+Zh8HTi51EKlNdrV3AYo9CXbXVsVYcFuVKkpe1qGNak9Pz9CcI/8DaL2w==
X-Received: by 2002:a17:90b:3d4d:b0:3b4:402:b3f5 with SMTP id
 98e67ed59e1d1-3b41c8fe48amr12378518a91.22.1795454431107; 
 Mon, 23 Nov 2026 09:20:31 -0800 (PST)
X-Received: by 2002:a17:90b:3d4d:b0:3b4:402:b3f5 with SMTP id
 98e67ed59e1d1-3b41c8fe48amr12378477a91.22.1795454430383; 
 Mon, 23 Nov 2026 09:20:30 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b704cfesm6565632a91.1.2026.11.23.09.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:20:29 -0800 (PST)
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
Subject: [PATCH] drm/msm/a8xx: Add missing preempt_record_size
Date: Mon, 23 Nov 2026 09:20:24 -0800
Message-ID: <20261123172025.402295-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hx9IAJlug3qX9JRqYc8naGsYGqKbRIqR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2OCBTYWx0ZWRfX/au55mKPF9/H
 ATlnJBvjDZ7xWw+HRRCTSJJPdoZj3qvaFAXNZ93hlr4ggNT6c7UGjFCK8wV5qB8Et1hkt1K5u15
 NjYuAjA9Gl+OEDBzzZLkNw+RjNRG0RU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2OCBTYWx0ZWRfX5WzJenNPGxV+
 /noFS35PDPm1xUcTZjnBfvnBVVpmryl8sWZFoP+5zMoEZ4Z0c0060z2NO7F7mhdvY/uyj8wTuhp
 XOMwMJp8aH2Oya5ZPduMdCp8aWkEn2IsAexs1roKk+rk8PG+hpZMaL+UKYPkHRPaxv04+HdqiPz
 7t7YRdn6Og7x5SL4++Y33tSgqUyh4niOPpTe2UQi3xiw/+sH9rT79NKQHx90fQsjk4VpUe2Vosy
 08GA9A9rfNbfqa1Tf9SjiDDSJymJePS0x59ChJD34LPhEJTqe+VUpRDA3jMw2Gfo0p20Whfb2V3
 /DbinMDAOLQhmiqQcr+FaWQRa79squ2H6o3t5bocvQnhb4xyw2tzXNT4UxUYKDyJtVB/B5Iceea
 lUDjyE2iOyxHIcK/K6tCoOJP74b6SVjfi1uEe2q0+AHpQCXaPmvs3+i7p7XsnsC+ic10Y1JdWvf
 +IB8fNHsNdM+Y39AceQ==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b0475e0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=2OSpH8Mq0sc3u4_c0_oA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: hx9IAJlug3qX9JRqYc8naGsYGqKbRIqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230068
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

Somehow this got overlooked, and Glymur/Mahua were falling back to the
default 4MB.  Which is way too small for the amount of GMEM on these
devices, causing faults in cases where preemption needs to same GMEM
contents.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Fixes: 7fad33097e67 ("drm/msm/a6xx: Enable Preemption on X2-85")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 0c6dde3cbea9..20fe93b83c0b 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1337,6 +1337,7 @@ static const struct adreno_info a8xx_gpus[] = {
 				{ /* sentinel */ },
 			},
 		},
+		.preempt_record_size = 23088 * SZ_1K,
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 388, 1 },
@@ -1469,6 +1470,7 @@ static const struct adreno_info a8xx_gpus[] = {
 				{ /* sentinel */ },
 			},
 		},
+		.preempt_record_size = 17712 * SZ_1K,
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 388, 1 },
-- 
2.56.1

