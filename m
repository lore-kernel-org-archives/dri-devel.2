Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAACCD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 20:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9452810E8B5;
	Mon, 11 May 2026 20:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKyYQtGB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fOJ15lK4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC44710E8B5
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6cG23444270
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JSlJpF3zqQ6EX6MthcusBte5cTy2JBqQ6FB62ENsUYA=; b=CKyYQtGBrNpBzHbB
 Pr1tDg3r8W+ukfZnUCifZXZwPodmwGIxQzCu9kFm7cLttT+DEb2ndHFmadt6oSXG
 2nqMCeAo6yHGIG4exNchmrUlUsfniH0YAVU8HJdjiD7Ac5HnvEJxzS895qme+NDM
 xrs0zWhNu2PsEHDa6m3kCfQcA1zmfZIZ+Qc953sq0iBylPXRXFhkMT0f7kC0Cskr
 QNo4iwcY/MXDqESYFr5ToC/wtoz/7nQMLqFoRHbOLqkbfgTmbKrqzQgdRyApVO9v
 Re2xGnehXeSl4pTP+nJOPOz8XsjWyQ3tiZSe64cf/738yhFREf3kndHcxx6hQ57T
 QH7l4g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0g03m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-365fc4636bbso9216629a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778530052; x=1779134852;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JSlJpF3zqQ6EX6MthcusBte5cTy2JBqQ6FB62ENsUYA=;
 b=fOJ15lK4RAJzZt15ZWGutW6UfNyF89OL9S+2hsR7NWfvAUga92A/38QuBfXdroF7Ju
 w4cKkMKjOe79GBF13Rx+u0nwxZ9Q+Z6nvTtTvw/j0hvSrNQGbxIB/pGgeBy3AOlpaZxu
 gS54jFsJu4N5syjFKRf4AwZZaAh2JOy5V/hMl6y4tKkRpFQPlJYYAs5oC5vxQn78G6J+
 NGerMZbf5gyUYnMPQc86Dgzemu1e+dV8KBQDc8ZbI8gg7WIovtTHCulZpuON8IJBj142
 x8IKtHjXeIIS8jZOMBha9pXsBH6XHjUP6uk43daWo2arhQmKVTP+UY7QXpdb2ui1L8BM
 2s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530052; x=1779134852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JSlJpF3zqQ6EX6MthcusBte5cTy2JBqQ6FB62ENsUYA=;
 b=GydlCxixEIUFhgZW6F5Zu/IclE57jkXxgAUMK6LteFCpmig9ac3y5uLjAVjlPdvu+e
 wYewl+0Vn6secL8GHQQceL919j2y50wYd11FPVqE3ogXkJ9qlxbsS5MdREzMxfmt+GAp
 szfWyPCpV2MDn4/maaK/xKIkN2b7tDK3dZuHcmrHkl6iDGHbmm6TqzxZ246mFdvtXx8o
 eyVWqe/pAecawjJzL3iN+oDvwAlk90ds3hvlce6KZX+36jODg/9sa965Kiwzk33CBQME
 ll4bOwi41WFAA9uZSb0HBZgM6PsXO+xaIC1S855xCDEsrJvEJUrWSgDtTaQMEguQ+3M4
 OFuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JpeVo2j+vE5+QuNkEiZ/YOpQApbYKL7/ZuQxdZN0ROet4N/3EUz5FW6k+6LUymlY6oqSdiVfsEkU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnPq4EJDaB1L4fkYf1b9sP4l+tT3gzUHXrUUqDAidojy4b5HQb
 E9Rx2RGT6DTh+zTCncnO0i7clYfi9CB//dLX1U/biLs86bGBQBDD1V2CNIz2X2Xag4QLTfinxKd
 o323NyTOacSrGSJEnrMD8NsirqxpCGx3A03yd4HHsI2oOomS2HFZHOpsrd4PGOOCxmnDM2Ys=
X-Gm-Gg: Acq92OFPVswVCx4+pn48jhcif0i2rkDEuwyGMEN7dXvXvtzAtrJ7rv8mjtGQdZt/Vd5
 nXNvAAi38HtfCCGbpl0Tk/mDa5009JnFEF+cuSmoict1kyOm0BVmbN8T6MF9SJgKPP/6gP2RljF
 scClN5+aoX7YblQJHzs6SaP4WXrOex2RBQqX1QRNVl/v7ZYryDTnzUpnmDwMi6Ld1vkN5xFYOLL
 EfwXbBrxuEWBN8WSxME4evJKM0qvC2wCOB2lJkWv4Xq4mD9V4AYHL4r3/mSZHuw5uP+KsYNDuct
 LyHhTNOZ2bOOAHc33N3Kdct4P/blAUO7ergRYzrdndqvKeVuBmgvRS7QxQG3QpzrWuNlxJVrPEi
 P6Yw841TA9FCj1E59Hsx9o5NuzRW/xtgtAQMh4THg4vfgKA==
X-Received: by 2002:a17:90b:38d2:b0:35f:b987:4dac with SMTP id
 98e67ed59e1d1-368b24e8313mr139608a91.12.1778530051598; 
 Mon, 11 May 2026 13:07:31 -0700 (PDT)
X-Received: by 2002:a17:90b:38d2:b0:35f:b987:4dac with SMTP id
 98e67ed59e1d1-368b24e8313mr139568a91.12.1778530051161; 
 Mon, 11 May 2026 13:07:31 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368b01ef884sm64911a91.5.2026.05.11.13.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:07:30 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 01:36:59 +0530
Subject: [PATCH v3 1/5] drm/msm/a8xx: Fix RSCC offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-glymur-gpu-dt-v3-1-84232dc21c03@oss.qualcomm.com>
References: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
In-Reply-To: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
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
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778530037; l=989;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=FpnL0ZPLEVfOL/cMC4YLbx3ytUnBQe7qykC1VIfe0qk=;
 b=QdSbnekUBS/LNdQNaOhTFAvnz8CUychpp7TsnPVbnU3E0tAx7xrKbjAw1q3LZguhQu2xQv+So
 jJ5MPnbbq6nAVhE15oQs+lqCPXeZGEKr/bgRN+W719SvQaNhxZiHVW9
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a023704 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=MejHOrmRh8FCsYeZqM0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: KoJRXHObgMkHp5AuHheBpvixOGBetUPi
X-Proofpoint-ORIG-GUID: KoJRXHObgMkHp5AuHheBpvixOGBetUPi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIxMyBTYWx0ZWRfX9BXemNvLRsqk
 AXU2i7hz2+cSycey/4Zgx4QBQKH/ayxZN99jt506MS6++b6N71jQtlbQpzkwUhObmQmL6uuUMcp
 lj62NWhBuZzC+4Zy8Aq/RKk5pQKbB6PNq4p3VEwW4f/jCrc2csFlTMzzJOUnGg9/WZGyc03AWZ2
 F0ZcvBaMWbqAJN7dNo8YNUubzqCD7WiidfRX8ebl4THVR+dJyqjmAiQsOo2jbEXNAz5C46w3m8e
 WayAasGsNARJvYClw7YA5VfTU2V/X8FCT4YFqiWRmUYcy3/sylap4cvll3e1/TB15fXPJgPQOkK
 HLzvQnvf/1iLBgOJGqs4C1el94dOTk23tlPgPHOR7iluj8ueWN9H2qbbtgRq6/NxTRUbGpmka0B
 kr/IRQMMCucjeddJqkbKmlXU0Qok4oTjcE/pg+L7on0/2F2kz4BdMlpikOAL92z+5MhxW/KZJE5
 TBk0IPPqeJI651ibKiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605110213
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

