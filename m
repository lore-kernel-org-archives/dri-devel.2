Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2E9CD4F3C
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 20:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3458B10E19F;
	Fri, 15 May 2026 20:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GqFP4vvL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X0ipHa+B";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C620610E24B
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FJexv52247346
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=YswUKeQuCvZnfFCGVsUxz3
 zRKWU8pCLFZV6WgjaX9B0=; b=GqFP4vvLOAHnHRZmh0ZsHLi2IqgpNw3izM2+WS
 L3HGcqQuKgtgrfcPwwwwdsNGaNCG3nHRjBuQI/LiYn1H5iRQaOCXcp8fGhAtm9l0
 GgYa6seJCXF7p+t6z/S7tBI62/CoOa2nemrAxLHqxK/FfG56QLqDnWr7wWaKcGIS
 6UxulFKG7dv4+aKeVGAbsDDubvWTW7l/5ixGmlQyow2C2/Y6aUqUeSN92EkvI3Dc
 PgvTTiSaPzDSqSbpPMBihzxPIOh7DasMK+oFqkOoyeL/KkSYy4yZFqa7s07/EZOW
 y6SCknABrXcQF8BE4jSrypI6nCpKs/8lpK3byUypJcmYBkUw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qcrb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-368f2d76b04so108481a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778875691; x=1779480491;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YswUKeQuCvZnfFCGVsUxz3zRKWU8pCLFZV6WgjaX9B0=;
 b=X0ipHa+BAq61gk3OOS6go6UoA+mbn0h/IJaqMEFw8HLU9sG8FZCDCBwPmnSNLwTRQB
 keyA1EVB7FvZrv823yWnWsfMK/NRXdzmmSN1KKDfK/eswiA/LzzrSBE48vI1hWH8cwqU
 12w3R1xkh2ZnBvArKSDvRDq2xeZ9fDaIlElrsrfcAGQb7UAd3s8QL3MPHG0LHo1Tnn8x
 leQ35y3NAQTYWjyNcEeprfbtOCyWi6rhd6Xrfcc4ZNj5RJdRWnMCZ0FsX6wkDzcN6lXc
 DeerWT5yNHcimC2ElgSzk9OKZgWQge5vlYdK/CqHiBxpJbv8oCk+6QR4Jn51w7YKk/nU
 qdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778875691; x=1779480491;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YswUKeQuCvZnfFCGVsUxz3zRKWU8pCLFZV6WgjaX9B0=;
 b=WZD9PM4ECWN12xIm985sF4CEDfqQnYohQf0IpvdBMkWKoyutxuyGJ8w7ZUdVums9hv
 TJK5+K09tlJBe+9sPvLT5Qu79++9lE7hsOl+pq2NN1oIEpglDsuW77FoDrugOSPDntjP
 Deb838VV459MF+K1G9bJKUjmNwQkFobI0fnIUxYau/j/mLkcuktGRfstqX2FkNBm81KT
 KvGWFfKiEschgi4t3FDdE5fkcUifBOLI2i+ndhehXsA9ZpLMFRTXGJz2pexw30ek4UYg
 D/snEiFXiuntsnQLE4xzqOlgfWWWfshWAS9CN9vh3oTYgsubWAPyftxT2Xcpo2yrTH4J
 jYYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wd7jflyeD23ldDDJR7mNjxDyUO1vNGnzRyinvGo0B6HTajl0VXRTXizPgzxSJIYquuCn3CbsXQzg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGDos7TQ9aQSQeicXP8Y+t8JK8LxnYWl0KSQCAWRQsTR8fg07z
 0DD1z6p/s5Vr2LxG9aodkRr2jz1PrdZOwxf8pfhult0zZFdgdJuJGZLjrQrJpvrIezuZpPKygHi
 sVxvRR1yUPD0Fe+4z3arZn9iuNRK9vX3c8qIzk+kPJwmSRm3F0qMprQ2U2Va9YWNu1Tuq8Pc=
X-Gm-Gg: Acq92OG85TxbxlhMr++Yr31KhchQS9+G8RY/M/dYSBAaA159iVMYuFVYL81HFazU9iH
 mIqnmi4GbW/Mw+MuT4tlafYzLrXJQ1lylRNLe6U8TSXPZOEbMie2p2c2aG088MndweG1xD22u63
 m4l2JNll6Fk9mgcWJBbNAVsmfOIWnjTSWQGohiacBoIplrYFN4kQXXUiTTePvcvCo6SxIIeGzkh
 kC35vVy9dV9HY0G2cuZ/kyJm7p2sui+a/a1i60ydfr7azzwY8cdT2OSqHVUKvSzAGkZq7afnBYS
 gcSUvneX5BmSbQ9ShhxjcbeO949NAfVmM3OyN/DdJfbw1+2E2TA5Ab5BsXHm1U7TyGWUyY1ZJHe
 KHc3hqBuBftgskG0JTtPCRYp/koWz2qgJuXmVwM9j+d3hmA==
X-Received: by 2002:a17:90b:4e86:b0:366:527:3c9a with SMTP id
 98e67ed59e1d1-36951b70055mr6064006a91.15.1778875691561; 
 Fri, 15 May 2026 13:08:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4e86:b0:366:527:3c9a with SMTP id
 98e67ed59e1d1-36951b70055mr6063977a91.15.1778875691102; 
 Fri, 15 May 2026 13:08:11 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517a820fsm3518309a91.10.2026.05.15.13.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:08:10 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/3] drm/msm/adreno: Support for CLX feature on A8xx
Date: Sat, 16 May 2026 01:37:48 +0530
Message-Id: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABR9B2oC/2WOQQ6DIBBFr2JmXYwQq9hV79G4QBwriYoCGhrj3
 YvYXTeT/J+892cHi0ahhUeyg8FNWaWnEOgtAdmL6Y1EtSEDy1iR3WlOBPeeyMETu86zNo4wxLx
 igvNWUAjYbLBTPipf9ZUNLmswu6uERlgkUo+jco9kQh8c0Z5xOIFeWafNJ7600Uj81ov/9Y2Sj
 HQl5oVsWVXK5qmtTZdVDOdAGg7Ux3F8AQHrmyHoAAAA
X-Change-ID: 20260514-a8xx-clx-support-2ee492a88da1
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778875686; l=1070;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=o9kV/6Us7rXJNj4ajF3ZJu/EnSjV+apOEXIsG2Dy4BU=;
 b=+YbltNlKR4NJRnDT4wNqIX62otAiM9ohYXWcOrK/lqGI/vBRWUcG7lUIVYzWoMYzTkQeJ/C9a
 FhroBDfZhVhConhu0DLLo22HL958oUQWjE1WrZwdVv0/WxT/UP2KYic
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: Iy0R3cLKm550VcVqJYEz6tRUbiCEqXrp
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a077d2c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eLcWdt1m_oQY90vHum4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIwMyBTYWx0ZWRfX3R3+KYGDXCT9
 /OuykmxN2LMyi/HK2p1Ezysbuq39fvpsBfgZVkyKsur8gJcjdpJv7nGs0gRAtj0BGTZ8xSxNDdg
 yMluHHqt9ent1jqchx4JoP6yamMl8G6fUubTp7bwPUFMHXLAtT2HINN9Jy5wZCcaNFdm+dM04TR
 ro7VYR+CrLJEMiYLSpaA+g+x1gmx5afZ35k+MYvjX/NYa/+stAIZEd8sal2P5Gu26xCiG78S9en
 28OZqvhvuZjLh38orZTphH593FFlygn0f/e+6zTQudPM/7T6GERzdXcO24OLVX5qIl28V0f68Pc
 QJOJUQeFiR5ZBXq6+BVF6fcu/9U5sxLSSfNeNdWCGWfTJGzrh5wXcpgvDLqlseHO7Q7u2IhPbKv
 lzK66u7fPS4fn42p1GeCUh2B/qOn0qZpV/9V5v11/3AiI1sw/T5VvX+j/IkhUUUhS/NoHe60YMr
 e4/XxtnwdlweFdEW50A==
X-Proofpoint-ORIG-GUID: Iy0R3cLKm550VcVqJYEz6tRUbiCEqXrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150203
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

Add support for Current Limit Extension (CLX) feature found on a few A8x
GPUs. This feature is required to limit the peak current consumption to
avoid HW spec violation on GX/MX rails.

Add the necessary HFI interface support to pass the recommended CLX and
IFF/PCLX limits tables to the GMU. And enable this feature on both A840
and X285 GPU by adding the repective configurations to the gpu catalog.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
---
Akhil P Oommen (3):
      drm/msm/a6xx: Add HFI support for CLX feature
      drm/msm/a6xx: Enable CLX feature on A840
      drm/msm/a8xx: Enable CLX feature on Adreno X2-85

 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 172 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  15 +++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c     |  71 ++++++++++++
 3 files changed, 258 insertions(+)
---
base-commit: b462608de92a7cac450781f9d8d4c7cf3ccf82db
change-id: 20260514-a8xx-clx-support-2ee492a88da1

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

