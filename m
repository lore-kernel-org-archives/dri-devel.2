Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D8DCD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AA110EC0A;
	Tue, 12 May 2026 19:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQ1PfBqW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PAPek1L7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D75110EC0A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:21:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CFLGle3421761
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=; b=fQ1PfBqWK4vDsgBm
 ASJFjwaLyIafukD8fECkcArllj+7wqOucIOdTZ9SaHXQVZhlxRgPKS3VZPkjdY13
 TieageF+GcI+pm7PH9pyulrrEyjtlzGB8hR9kb2lFK/WT0cvDoL4oi+zFvfXI6x1
 nr9HF9FtBP/q2pS8EMRbRCY8n2mqRj7FspPVyu8CdA9ONWKr+C2VBYTAxA9VCAvm
 hKNfIx5wS5SM2nqdpXQYGxviuDrsq8DNd/szkUj7vF/YgFavfaiPn/YVswi6vS/f
 e2kIR3rbu675gKQ4zKSwNp4NuRItafeSs4id9H9HXWoskC7B+BOKE4vitb9rWyWx
 0JTlKA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e46s9ryc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:21:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba3245a43dso50890015ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778613717; x=1779218517;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=;
 b=PAPek1L7H8sevBrhx/yMhzHfX3ac6NsIzVISnmvJ9fAZ0qrkbrfrpglMiRL/VHWUOY
 utXbxpmTqhurKxc21tguhWm3E0o5JZv1Mu+9dsN0T1XJHAZspud0uPhviKV57amS8nFl
 4JtUfFIcei/qO/8bxIr4eUnbZqszDjKHRsUV+1CHdNmWDGO8irtMZ4g2MOwW96oY4apD
 T96lxyVYO5efBQuJG9lUIQhkBMR06i24dcKBkxGMYLUBxKimX0YZeiwhukBOtzlXwRzb
 DkSvqX5Hkx0yGHRSHZJDuZPHympe0Xsd7cvGBqmfSuMIqBodT5WnfcG0h+OVXi9w77xp
 4OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613717; x=1779218517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=;
 b=G5PWtjP5IAsz7dlfsxMhTBd5Dpj6JDwEez7X2MTs7gKqDZhqTW3S7SpQolDBsbx7PG
 1+0S+mS/WIjYXeombQZq1p07UeG+5dG3OQWdAjDsFKsfqU1Jpgw4X2sRzS8zwfZ7prfh
 M8hSWLkS7X4ij3Q7Sxmc0djzRGHBclCGD6e3nYKP6CzoNIAzCWJ0VoQY0LHHpNDnX5E1
 3XqnuIJGv8CexSbN4fJhtmBDCs/CTjoW5+fJTybshzVxhU6epwTwmDmrLrFNtXEpPrj3
 FJJZZ7v5TozCl11z907nHkVYPhBhJ3N8vX6k+txqEgdKvLT+2AHvoMcLjBLwkQEc6pyl
 iq0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1PqfJazQxcHUAzyRzn/euFzmDxm0nehVNwFJpnoEmgToj4CJazb3EL+YB72CcpK0yK7h0ECrr/kQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5Dletyc0mArcsRKum6bQXhPRVwv4LW9dcg/bYEX8cnQ3MokCy
 o2BSuvaY/pHCbworQOWIVFgfeK4fHYjn7NNLgnW2kuMFrUgO0yKSRKIdSy+vV0b8h8yphbbNCiQ
 jVXoT5GO+prmFm1vnSj5Oog62N5zDmn6YBoUu9JASDqFH5/I3HjgGBVbyUNM7day0xtVKGk4=
X-Gm-Gg: Acq92OGtxkj7UaS5LAiJW+RuUQf6TbiwntOpmpT4ufdRPmrOwM+fGAFLKX6+t3eNa2y
 xFxsmfyeoJ+CNmUPWHGREuy01qddzR1MNGY/LO78aVZd3tPCMBIlhiIpCdwhmnopkXIgsFH9pyE
 1DX1vXbSBLVmrO2pHgpAoeSCPW6ihkMBeqEV/PSYNriFqOD5a2VJWzlHY3ajhpqIgnKfIVSxXYJ
 9/tHYD4NgWIxj1gFUdbozHwzmX+UlBNCDqQAaKFq1fU+CG9Du8poFUNUPkZP7Fn5is2x4MrCGIp
 j0clSrkOp78MX+Nu7PKU9Q00rXu+BKZJ9RZU1N1OqWsFMYTeSU+RTRmvCy5hhS8I8bGno3QwHvO
 I04LfGs2LWZDdiySGqxj+h0A6WNcIRX5PYeT+DVQFyZ1Sww==
X-Received: by 2002:a17:902:768c:b0:2ae:cb0e:fd59 with SMTP id
 d9443c01a7336-2bd27133a91mr2513975ad.8.1778613717318; 
 Tue, 12 May 2026 12:21:57 -0700 (PDT)
X-Received: by 2002:a17:902:768c:b0:2ae:cb0e:fd59 with SMTP id
 d9443c01a7336-2bd27133a91mr2513465ad.8.1778613716644; 
 Tue, 12 May 2026 12:21:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:21:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:18 +0530
Subject: [PATCH v4 1/6] drm/msm/a8xx: Fix RSCC offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-1-f83832c3bc9a@oss.qualcomm.com>
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
In-Reply-To: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=1052;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=obY0yd9A9w1nKiCc00V/sWC5PfbbK/PzpgmtQExUcNY=;
 b=WFrdXoJxRMyXFTXXynT+vDwKDHONIdU5yJw6WcZBGk2wkEkuw18xTJtD0Ah268ZR+tV/3Pzjv
 W3m23loJVEvBmUzKN29QDTNc5Dv9Uv0e4liGaVXV1DuPDjaagm7KW4i
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfXykCjzG7wTyPO
 l77HVce48q3fIucYBCwLA8VAX4CE1QOCm4upvPn0GAlJO0W1EcwLB96yN3PhiwNZDdiUbTvtIyu
 O0Q5QfbYWRey2TKpGs+NjNe45KtkIY0wb3/RXPPLa9dD0hRThBek9ckkP+YOh0eHDYl+L9T13nE
 Kexx2mF+BCRvN/RgWm+B8QXjEXnuNZCaLQiLa6oBtKfEufx+3KLG/YVMFony16pGWHGGTz+QeX2
 Ed4xVMMlzQFdq7z0DADWW9vOG0nMKo878AbzQ6KEBpg5XZkFHRV/A2a5yDPXguuiJBcuJNj/Ij/
 SyeLrgvLDkwCrrjQEFlDatsrCleHG0YJAerrJhcin2drk0zoj+wtlzgZstv1XZz8NxjkvnAQKDo
 0bIb4mLScA23BkvSLgdbHy8QCLtCUzDcdoL5cGMAo8NcsaNHkcXbCt6nEONjhfh5lJzmGZ6XZgJ
 SVaEsOR+SVT4sPRnuBQ==
X-Proofpoint-GUID: V0ycQY0gEh8iB5JBvGuHgfRsWAWsw9Nc
X-Authority-Analysis: v=2.4 cv=L68theT8 c=1 sm=1 tr=0 ts=6a037dd6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=4MPhRinBehVJTi7DQIkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: V0ycQY0gEh8iB5JBvGuHgfRsWAWsw9Nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120200
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

