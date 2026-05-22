Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBAECD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E9510F53C;
	Fri, 22 May 2026 10:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVtlyU7m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NJG+wrMF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5404210F538
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M5kTqn777111
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=; b=aVtlyU7mQF+q/O1S
 1s04tHwI4DI6ylk6EAp4BO2qHva42VLz1V/Ejlq087p3/nTCbuE92byMZnA9fylV
 nu1j9+YacCsHELOvlfxUb03c44tZe4gRbhK+3oN7aTXp4hZ7itJXKvJPUWmhj3pi
 1U5QEDSzgCsWndExIMmkqkguioaXwwVJIBEvTxO5SvnUIJQJ7qKNSh2OQhYKmyNA
 24LvgUwTqVlOsGEHoLrk/dBU30/GH2XF4QHYcjE0RpgA3I6gM59AIEPo8ZglKWF5
 RaT2uikmyaW+TKHiNjBdbXS1IoyewaMCSuPar7om/Zn3fZ6fhIGyW6cptlQv3Igk
 0ZuU/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h3093-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2babbeff9e4so78254285ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444758; x=1780049558;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=;
 b=NJG+wrMF4Kx4Xk3PYFBaqO4QxITYwKqss6CpqkOdMQunBSkUr9j8RZl0T1el6U4hCh
 3z7dwIUcM4/HMe5OOxON0BvjN39zNUGjc6Z29pUBajOgDFxMBE2Vb0H40PEC45W+ktJU
 3ueExm/GdDTBAs//tCh3Zk9ByaK1IHQa8QxTuOVIhgyk6guJx3vFXJcjku0lNmC+f7ly
 083WkG4gTW9AIsUHlbjLHB0JaGbRFKoM/ReMVLJA4OXbM6fyff67RK5QYR1bqejB9Ysw
 C7ISI5G3nX3X7ow/IovkfMyRwZpPDAjBdGOIowGekkBZjwIbU0tn1ZsoGiaSDAcP3F27
 1PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444758; x=1780049558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=;
 b=nBgSy6pstpuaY8/I42Mbw/XSrJFl7Z1A1Z8tb7mhdugCwjCpnrkIQQ/Jnu7D1GSNWj
 yheXV7I5Nb5neVzdVU5wELeKhNBbCD7jstVegL2J/cXuKqMY7bmHVUaV8VgOXgeQPLHr
 hbYHVJEvsYaS//oQ1NdSsdQXsdVCgHuL9Jt9hxjsNOLnYqDXPI8xLRXRbQblhTEJtKyg
 juUIZrk0dVA8Rq/PxlgDAzyjLVKgCreXsH2LAI0l44uyHNlfAjnrOb9r30/u9jF/sv1m
 HpbgGbgKl+65urefhWXKLq3fNcrbILUOlOaQbRDxolc2Ha2lcCUBT4dKLjYyJiq5pWWG
 2haw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aJYSlLrmqbyDuA2L77vjw+37X7EEzvgsB4zlzSNRrb/RIuToi94Yl0g9oOnaVuWsTjHbl1Z3HxS0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXb5g8ZwA7nzcYNz2TPH6HbOcViB37mk/sSxYaaJRmXVQb2vnE
 lfd6pQ+u3wMhgTRg084dEy06OoIgMcevJUkehUcf4xivjCHbTz3fyOX6g1OHHyF2kgWptroxxxr
 xKyvdStdsgnDmmXMKKeODcabVkMeuRvmF45xDejiY2kDZ+a2JA+Ykj92zR5dAr8WL3ev6mg8=
X-Gm-Gg: Acq92OFQYQzx3uqB5tWknLuBAkUurmBQf6h8oIiJp8nWL0w/f4pnw3NwYGB41C/yz4Q
 3Be52nWq65v+KZ0Ku6PHQzyEuArgJg7UzMZR7a5fNao2kT0Y7N5Ff36OkgovVp7TKNfvO1FDIht
 67IYsZCxrIOJTMlcNHs6MJGdOxNpjJAz+gFc0FawT0kRH+72hS159OLpGKHHfzXMyuY9pIpyigz
 TGNuGHAReyruWN3RM2QmyJ/fUPkj6UOMR62eNscQI2vLJYoMo1xIr3M7qUuSOzfB9cfN8p4N7hg
 pgQ9lJrdCAVMwlFB1WwYPnWCNjZEgYgxPnszVeQBQud8mw63nl3YxTnjiXpD/v1zEwqo2E6mmGz
 p4cX1gorEDdEq3aOf5XXZe9E9QOQjE47p4/vscyGFSDBIEg==
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2bea22b759amr66987585ad.20.1779444758360; 
 Fri, 22 May 2026 03:12:38 -0700 (PDT)
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2bea22b759amr66987095ad.20.1779444757875; 
 Fri, 22 May 2026 03:12:37 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:12:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:41:57 +0530
Subject: [PATCH v5 1/5] drm/msm/a8xx: Fix RSCC offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-glymur-gpu-dt-v5-1-562c406b210c@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=1052;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=obY0yd9A9w1nKiCc00V/sWC5PfbbK/PzpgmtQExUcNY=;
 b=pdp64ebXg5HPwlKwhpGKdCt4wHbjegnmKMSMu4DM25HTq8+oXTKxhTVqzHseUN+lTBUiptQH4
 KmSKIH80NuvCyqgY5lRGeS7K/Ol9xitlYW+htTssbvNc4sWExXaTNX2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: SkUb52UXdczVKEEwHPBr9WFtCVtBI_T7
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a102c17 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=4MPhRinBehVJTi7DQIkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: SkUb52UXdczVKEEwHPBr9WFtCVtBI_T7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMSBTYWx0ZWRfX1bsDQIQSB4Jz
 tbENRdyhNrOZpgC+FroIUblaC4Y+eZKe6JrFa7LeVwQvq0Nc8CY23DWAhdYWmZlZ0513ldK+U00
 FQB179lxWTAZDei5ddvgHvS53fImrNSZXb1jspbPBgljJ7Yz01QcZQnsxQJhj5sMTzofQyVFWHy
 kfqgN52DSb25w/+hsA2NGWYnZ9PlRVuXDlCnIDFm/cvbd9TLLWK/bCCwy6ZO6qLdfJZI48+VaO5
 /QQLPDnGhYxYOIpgAJmr7ffTHByYNdZGokDWdX38md7f5F6SC2zElnpMSPeX+p7i+XrwS8UPi3Z
 aj+XADwZNcixwMKIiMyg3+6vSC2PZjbh431rlCtkvg8ezHrPOBrhh2m0AOwm+qOg/VoT6V5mYpU
 aYRSqrVbCSaeN3XAWN7PRfRcjMSSnGsN8V705h97FWrvftRkvweQZkz52xLj9lg0Vsnjsr+KhiC
 EegJ1BZPv5nuDlq9fuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220101
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

In A8xx, the RSCC block is part of GPU's register space. Update the
virtual base address of rscc to point to the correct address.

Fixes: 50e8a557d8d3 ("drm/msm/a8xx: Add support for A8x GMU")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1b44b9e21ad8..cab4c46c6cf2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2357,7 +2357,12 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 			goto err_mmio;
 		}
 	} else if (adreno_is_a8xx(adreno_gpu)) {
-		gmu->rscc = gmu->mmio + 0x19000;
+		/*
+		 * On a8xx , RSCC lives at GPU base + 0x50000, which falls
+		 * inside the GPU's kgsl_3d0_reg_memory range rather than the
+		 * GMU's.
+		 */
+		gmu->rscc = gpu->mmio + 0x50000;
 	} else {
 		gmu->rscc = gmu->mmio + 0x23000;
 	}

-- 
2.51.0

