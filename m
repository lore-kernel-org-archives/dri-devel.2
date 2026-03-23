Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FBBF483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B4310E3D2;
	Mon, 23 Mar 2026 20:13:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aOXMgnna";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i95QwYUm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9516F10E3D2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqliG3634578
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iFi8aoHCvHDcD5YBbZdBFmik9S7MrX8p/en9vgMxupI=; b=aOXMgnnaMW2rfqSm
 wf62voJmAEkx/vKDnitU4Jh6I+Jx9zjys+3vRU5b6OOGPsOe+N7aF15Klx1HQe0j
 VgFTzhqWfc1X3Cq/hARFhbp5MkrRthSJ1ksvZD6XHyJIqFXbFtRfXgpNIEny9zUy
 C6ik7xWFs8OomYncVeiUK1WIyzYiIXaR6fdC0yE2VqAQyZBm4W1VGouUFsnBeuVH
 wI+RAIicJKiwElL+y07nTDqRJMqgNruncASULMUkJyWmOLgw3zdGPG1RYC4Zp0yw
 zK0Zqo2xSSoO2V6GDjufxkp7rfU6R6Ka0gAbnebsXOybe9KfLJIy5YwXdzWwTZMe
 Fe9KIQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4hwht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-829b7ed8964so3165634b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296793; x=1774901593;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iFi8aoHCvHDcD5YBbZdBFmik9S7MrX8p/en9vgMxupI=;
 b=i95QwYUmtrYILa4YkCV4HAV10DmG31n1h16Aa8x72b8TAXT62ufsSRmADUQpfo/iCR
 5WgMEbdnP5mr/h3iQhEQJcxm4qHxp/eBKAjYiQJ1Am0wrsdtUfBWijj0vME+5qgdzo0F
 wVKgY7mla3QOq7Oq8+CswirbRy36BhW+yWveK0emSg6k9dyVs7iAWDp2/DFql0D9oqbL
 xILXsQC+GzwICT2wuIQom3zbY//7oCD3V2GcDZvCDANpSFKUQUVYT+EEVZer6ZS7/PyQ
 5/22pNPwzoai52aV3rg8VTI6TWldzgCZyioa3FqwXFtL0GJLI6PXJL2rpUf/0AD2VJA3
 T/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296793; x=1774901593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iFi8aoHCvHDcD5YBbZdBFmik9S7MrX8p/en9vgMxupI=;
 b=Vx1i2oZEdms3f8IgOmbIXzzV7V9SLycH+dbqtTvoe16IvER1Bf3Ax38b5A/QmVL+3O
 qxJh2D2FyVPqXxPByzuL1VKjhRs1MDu2nwdLPGSiHGlXtVE0FfvgJjH5Y2ES+ds8Ks7l
 d74ME2XC5im3heskFzDWHmrt5UjMBGAkSo+55+iHSydehvV2+qEB8wO58tl0sBwabxUI
 kq2zAj4tI1OdVx9J/XRmbbfwsbxwdiJbEn2d2CQ062abljfiQuTa4uvGdCR6y64ARjpE
 ozL2/QtPYSINNj/SyNR6CNeBhU9yy+r2kAGgTis3hixFScj61XBofn4ARxFMKAMAs+cm
 ZZnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh8DHLkgVxxhgX8jR86L6mPrjHJxWT/1BRJooaAEsez2EtB7TszaFZxoYlWV7/B9U+1+fmZ55y81Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5OqzCY2O79AxNgZ+k4nMkHP7MmHkx87raXjuPAJOLaJ+mLQ/y
 FKXIGbKTTJ1AlnAtLN73uWI8wo4XqiMp0D1A0vyQUz1UqEy69wb+6djk4ruKy9fw4AsOPpjeWAO
 sWqtEeNxLs0GEbyHKFxD2PjMFIAmtinJ/nkchpEyiN+tZDPB86QMzxR/YX/UGw+wXOX0ddR8=
X-Gm-Gg: ATEYQzxsCAOjjsa3UtQqg73/6eIHwgUj0shJcPmX2E2BRJadSNWQOA2itb4D9blsUQw
 jOkFaJqxC+g8f0Lul9L8Mm68FwXHRfgLLaWEjYo81xCY46HDcuNtNS84stjXUkn8YYOZrK0vhte
 PelkW9tJKAnSlt+Unpr+jtZVkuPNuJlJdQTfoXpfxecQY4MDo/GFWMw8/5+8DTHZF2yEkhVrRKZ
 RB20vOStFd57Mn6WBtlMzeuEEgn4VL8eA+bSRegaGNYpijb0FqClr/3n8QyAweYdXqnLrj6d0TB
 cCY8kXPIpGgj2Awkg6s6bHzVt1gmKp3YdPBPagdVJmuMAfSw98I2UXSAJgV6Ka7+5/98iwcHakH
 b7FTarzhs4XdOvhI0j5REhNyuhY5PTXzscVgCeSYP7wqtdw==
X-Received: by 2002:aa7:8ed2:0:b0:82a:1529:2b4f with SMTP id
 d2e1a72fcca58-82a8c35758cmr8866492b3a.44.1774296793144; 
 Mon, 23 Mar 2026 13:13:13 -0700 (PDT)
X-Received: by 2002:aa7:8ed2:0:b0:82a:1529:2b4f with SMTP id
 d2e1a72fcca58-82a8c35758cmr8866464b3a.44.1774296792639; 
 Mon, 23 Mar 2026 13:13:12 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:12 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:18 +0530
Subject: [PATCH 06/16] drm/msm/a6xx: Use barriers while updating HFI Q headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-6-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=1974;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=1ajLVoslkBTv41Sp8G4luxsz7Te6eYrrZtKsz0zxR/0=;
 b=fMD8o5dT8SsxOVs4k4rWFPgLkKIR8YU77uqDQ0DMUTmim9gm/FgM8cMODWImekNXWofrA88+w
 e0f5Cwsu1g7BsVGQC1TXcmqh/guEntf0zGyTwt2ln78P0OQd5K3Jkww
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: vd33i6AfdxUk4znaCfbpIh-GvH7k5Q2V
X-Proofpoint-ORIG-GUID: vd33i6AfdxUk4znaCfbpIh-GvH7k5Q2V
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c19ed9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=h6CQE6Wve-Y6OpkwRbYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX21VF6+MyqfPe
 3zWaYokHSOyu2DtIo+rzBxFl5IAZj94/2tbS4TdHZwHwf4bCt+VBVd338NEJeeBS1tUPZ1TIG0y
 Kf4120dITmsYvoXupz/Wg/sxvLqZc0GLAM/6qLhpa+MkOlRZ8BTK0wAmKP7u9ZDheD2E2uYtahQ
 OH8umY+PRm/EhXZNjusheQgcYfHK5cnxdMAE1YOYKwCmkfbbJ1IR54SkxebnBxhfyWiBowJ+DW3
 oKFXaSk4wMCfPlZ0zFE8RfYU2c+p7hjm+Vz+fFVKkoJ4DC+N/hanQwTI+NSqVFmrfPDv5G33mSR
 Y+WrTV6EDGBJiuW7ab+vzRlxTbRRl3s6OuPih3fzuXXCeb7v0uim8eNlZGIbhpqYdFoal2t76M4
 0AB5ce5m1FR4oWagRNcyRCpf8ucjLP9x3s3WfX67h1FeJW5QfPp+eAHsehsNbtyH6CGzFFgndTk
 T8cRNUvI4FJQ9x8sKdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230149
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

To avoid harmful compiler optimizations and IO reordering in the HW, use
barriers and READ/WRITE_ONCE helpers as necessary while accessing the HFI
queue index variables.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 2daaa340366d..aef00c2dd137 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -34,7 +34,7 @@ static int a6xx_hfi_queue_read(struct a6xx_gmu *gmu,
 	struct a6xx_hfi_queue_header *header = queue->header;
 	u32 i, hdr, index = header->read_index;
 
-	if (header->read_index == header->write_index) {
+	if (header->read_index == READ_ONCE(header->write_index)) {
 		header->rx_request = 1;
 		return 0;
 	}
@@ -62,7 +62,10 @@ static int a6xx_hfi_queue_read(struct a6xx_gmu *gmu,
 	if (!gmu->legacy)
 		index = ALIGN(index, 4) % header->size;
 
-	header->read_index = index;
+	/*  Ensure all memory operations are complete before updating the read index */
+	dma_mb();
+
+	WRITE_ONCE(header->read_index, index);
 	return HFI_HEADER_SIZE(hdr);
 }
 
@@ -74,7 +77,7 @@ static int a6xx_hfi_queue_write(struct a6xx_gmu *gmu,
 
 	spin_lock(&queue->lock);
 
-	space = CIRC_SPACE(header->write_index, header->read_index,
+	space = CIRC_SPACE(header->write_index, READ_ONCE(header->read_index),
 		header->size);
 	if (space < dwords) {
 		header->dropped++;
@@ -95,7 +98,10 @@ static int a6xx_hfi_queue_write(struct a6xx_gmu *gmu,
 			queue->data[index] = 0xfafafafa;
 	}
 
-	header->write_index = index;
+	/*  Ensure all memory operations are complete before updating the write index */
+	dma_mb();
+
+	WRITE_ONCE(header->write_index, index);
 	spin_unlock(&queue->lock);
 
 	gmu_write(gmu, REG_A6XX_GMU_HOST2GMU_INTR_SET, 0x01);

-- 
2.51.0

