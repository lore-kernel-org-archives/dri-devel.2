Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33D610AB82D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007B110EAA8;
	Fri, 27 Mar 2026 00:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGIV1lEC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vr7lKQSn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19A910E180
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:40 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QJuS3j3075500
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nNpaMyIszKDUNSzxjOM+bcTLULmGlUr2/bZEHknjG0M=; b=dGIV1lECRpBmhhbt
 JhfR//7qxOaCLhlxF1+UCE/3RnJ0RF51wLtwfkwOqs4S+K4l7dHh0YHTmKtvWObZ
 UVEUdYEQituV/ecm3xviB0b/L1uCWAKqYP5dC3P1tge2iKgr3LqE6ujX2GZ9fkIt
 JR1rHvLPNteLXvlmeX8upEwaG5X84w2yYJd6i9UV6QYy6JJieb5+03PheObQ0R5L
 3tr/lV5GZDJ4XFJh5OAhoB/xSJUefOxSoEn4FX3IPbin3URj8/iym2ZZjpZkYxU3
 ZoerjpGcFPKVjoX9q9LXZH/xGh7EFeyIpMSGdFMvAhbngDBb0wqHuMK2blIrP+/H
 45J+HQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bd8rmx7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35c0abf427aso2101012a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570479; x=1775175279;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nNpaMyIszKDUNSzxjOM+bcTLULmGlUr2/bZEHknjG0M=;
 b=Vr7lKQSn31BDf8LVIBFC8nvARdVTVCW+ISrn4y/2Bc4T7JOBsCUJPnm47eFhAyfTCs
 KoTMjfACsNSomz//n2AEZHlTAWer17KsUoH2HtB8UlzeADC/O9eawtAGykgWWtEDpcpW
 TODrbj2g6eiEpom1GCrTY3lR2+Hrm+AEBs+PvJGGTCDzQVxn/SXy4eXZZvrJHqSnnFme
 es2sE41s53bCWD46mss8R1zsuK5ynVL+Lw04U3h9igrbq0hgM8wEOcUMDOwa48BdJ3vn
 ya/9906BTx5qRXI4P2yyEK7ZqwzqEz297RfP4xgCRSh7HC3ggBN0EJjl4ty4y5evh1HJ
 QMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570479; x=1775175279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nNpaMyIszKDUNSzxjOM+bcTLULmGlUr2/bZEHknjG0M=;
 b=avCZh+F8iLyS6zE7Qn2XLybYgDDUyYDntafngSp97Mwf2dsNdXiQGGd8DYNSXSTByt
 fgqfQc03EPuVwmaQszy+VHZ3j7GqiWmy/CZHE/Ck5rumOHTPD/YN7xK2cA7uiSjD1Tyy
 5hyF9eWMh0uLPPICpnPtR4Mcrg7dqQbhd2vjWe11Gqq9sJvvaebYPP8BAxWJRZY6l0zH
 R1hPGQJjBCDuQG0Lr++bemYNOZIf9zq2KW7cNoEQm+q04ow/JyBwc3VDknxPUHVzzoEy
 hZVbLqYaGA6cbeY/VXaTATmWlqEmSxtYjpLbPbKT79Z+TbeJm63pxogsFUEVaYqZ8b5v
 IoIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwsPo2qHGfArNbu6gburHEIPGs7vHUPMq5njzgLr9VBe4b2hbKfEyGK9nbl/Ta3KLG1cPK2Ap/kI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWSOIr+fDBEZxvpH+pqiNsapw9kGcHonKIG2jKeFWBlllyuE0H
 pm6CNgK/XOXyE2YYCdn7oZm+fYc/fqfTLj9nZ8YPzq8ZdjCy0PlfKfcDoAI8dHOpmPIl4R+99/J
 vH1cCjWwNvJfyzaMx47C7miCAJ4PtHSrofHzP8Z3aXXuThHQn/F9bq4eWefsoj7CZ1fG3CJg=
X-Gm-Gg: ATEYQzxgQe+2OFS9AoiJksRIRLs8izMsZYcxZOfVGPCcYYj0VcBVrn8vlOv+TFUXFNj
 6U/ONA9dF/ns5yGX1pOZ/Dwl8hSTfF3x6AhEy22Vgat+N7kM3AloJgOAyDQZ7JbSL+KOvsbVo/G
 Mt8x4I7L2e/LI/dgyhuhXydop0j4Aq201cjI0ExZKeOMWh+bA7wr1aTJeOA5D7kSDtbB6v2Jnf/
 K+cqc2+GX6vn8yricinHvQ3qxqvOVdJ81M27eJ2Ah8WZ06bUpq4LGOa9kFaMWFrHbxae+CYCeJf
 iOMUYBsdbvR+Oko9gkueMoAk4dP0g+N0QZTQT7bFQUmZ2Uf0n/GgdfwE+HNbA7C73zQDb/BVMaC
 pPTmxnL1DlotjU35kyhRVKdxm8odN6ADjXp56QR4K+bUd8Q==
X-Received: by 2002:a17:90b:3f8c:b0:354:a332:1a61 with SMTP id
 98e67ed59e1d1-35c2ff4ece6mr472811a91.5.1774570478699; 
 Thu, 26 Mar 2026 17:14:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8c:b0:354:a332:1a61 with SMTP id
 98e67ed59e1d1-35c2ff4ece6mr472780a91.5.1774570478208; 
 Thu, 26 Mar 2026 17:14:38 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:14:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:50 +0530
Subject: [PATCH v2 01/17] drm/msm/a6xx: Use barriers while updating HFI Q
 headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-1-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=2030;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=3pX9IrVZ6UOhwdVv+Iv1qIweZ9HEPBt226ZOY09D4OE=;
 b=JvH2dRbG4ITJpjmQolQA6NVB2qKkX1XCcEsdxfWmcYy0idlkHe4LVJE1Cb4XUmNQDXJIhZr4h
 tgCOiZextIgBeDLqloxlBE1FHss7ws1xCal/Gb1z+IGd7i9K11EObtD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX9UzGbaa3iNif
 4JOAOIyL69pOc3uXFnTl8gf+ll4Zdj8uQIi3wd06Uyx3wHomf8iwtOq64D0QUAM88e8MmHFl6Bv
 dGv58kbBV/iHapytJUgXK5AvKOMhum7INWdtYP3KJKH4CK1NdfLvr05hU+OQM1btvG/QTYbG4RZ
 BCjfQ+Cj2cebCk2lBpDeu3Db9ZeiAAXqvlbSC9ZAtJp5YBvOuM1ZYXaPufgldErEVGxw5orA9k0
 7xt1LEPHMeKH4ci7AjWGFho3wj/SmExl1DNtM35TGHZL9jcEm7OxHxw6p7//UHjfE/ado7PH48d
 bDiG0+GjXHA6/ddk4ev3cYVrVCHARSOmirZtNaDB7mrpl5fxuFA9DewijxYfGU8dAjFTTOuiEYZ
 i+stpS7ZC+d+0iu54amSMvnKX0VKb0h1EfWmSLkMC56hc/b/i/PCKLBSLxwEUjrD4jgwuGK8XJQ
 SDHRUec3zlpeJvpcAxw==
X-Proofpoint-ORIG-GUID: tHVEN9_ZOW7JcuxnnKukiphtBC8pJO4n
X-Authority-Analysis: v=2.4 cv=BZrVE7t2 c=1 sm=1 tr=0 ts=69c5cbef cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=iNLaHJ7vUJo6VPWp6gkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: tHVEN9_ZOW7JcuxnnKukiphtBC8pJO4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 53cfdf4e6c34..4f5dbf46132b 100644
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
+	/* Ensure all memory operations are complete before updating the read index */
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
+	/* Ensure all memory operations are complete before updating the write index */
+	dma_mb();
+
+	WRITE_ONCE(header->write_index, index);
 	spin_unlock(&queue->lock);
 
 	gmu_write(gmu, REG_A6XX_GMU_HOST2GMU_INTR_SET, 0x01);

-- 
2.51.0

