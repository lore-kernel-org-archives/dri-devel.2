Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8916CF589CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09BC10F11C;
	Thu, 23 Apr 2026 13:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="inrUE1eF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fxZWG/pJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C426B10F11C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8uJQo3413398
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=; b=inrUE1eFryx5382j
 3x7rs59o2EAw0GE7yiTLTv6vxcNjIksca0eovJL55QwMmtmF0ghirHogM4Ku6YGY
 bLCa8odqqLPmBKzzeNDMepoaZaXk8ieuZYRiBHdEWeX5q4ApQBx+p8E7i2r3zqRN
 hm6AApefZAMvcbqH0VoQ4vLcsd+n6kdWs9UhsXDfN3FwN1KxcDl0qS0O74W2XAa0
 wBVmQX1BLh196ISWpAFrH6rYA+Y8xRxVksDSOcw+XLKIAICQYDCzAYACXF5l4vzG
 aI9/WqTstkkEgqEvQVfYA1ljH9cb8f7kjOCvWb/wxda5/10m+yYcBurx4gmsRovt
 zBJ8bA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h6c5gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b241be0126so130903245ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951006; x=1777555806;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
 b=fxZWG/pJ8/ZtHJ8HwFjr8RE3/YgfIiW0DV7WRYnJfAo8IoTpD1gaYJse0ajOJaHmqa
 0HckOwnv6FJSqoaocZro4fCJjiN/rj4MGu3YZnRaYAGMrFiqHMLeiBgOxPw8/KKf9pQ9
 kwfbBZuWqM9lq66jg5xr2IzB65uN8e2LvKgiwWZ3u5gaUvLSyH2QrWdhUsoCUAupvgZw
 agFRCrCKUfB60H5eMyXg39RZQRVh+ZjiJZlFM6QkJFurpGfkZEMN6rUXOqtojZ3DARWz
 VZCyiVX2B/XYNkx2iO13WGYr/2x1ZFQr+yQ8l4/ZDAOmDOnIUaMzLDI81D6DEUQsi7Vf
 tGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951006; x=1777555806;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
 b=Hna8XyHbchRYmrU9zujt3UCOjHKE82WbZvw+tL3QdlORdrhKTl6quCIlwQyA/F/IWH
 9NeKpStMJg0XX/iCjY4b5DDY7oX3Oeynguf7h4ZDZBNjmQDDTOm8WrbVeRcsx0GJrvci
 Qx3mklxMrbZFQb1aehwYjzgONU4uwdhgIH4b4/O7hMJMQbRK2U1zJQOgWagAme8XbiNQ
 cdEhyG4JWCZkFcZUgoGrojJ8WNssD8G7gR0QQg2PvNm16aurxtUC0axjDB63QxRVNyM0
 gvPCDiKmk7g32DO3hJCe47jFM9sl6uxaYPVIIyCYmJG3ptksLPHlAboUBmmv7qvW5DDz
 8zaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ87DdPnEn3dK0Ey6nicEEXy2F64SAs+0aQlpC12fn9L8QhOdEZaP7ztElwk8DM/ADf8o1NR+Lc6YJQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNXRKeC9HYiWnRuVo+CNhiUe2WHMokOuSENM294HBa3z8aig2v
 rc95VJVCKDi9GrbTSuzA4vPkav2u+9y0EKTZ25pIo1Xyn4FlT2z1Doih7sqMx/uisHDS90it52H
 Ww3+F4cfbRO6zg9ysNJc8H2u9LerQzhqn04XQxcJufQI6qdOcCyN/dus4JxvsAVSbdztQ8t4=
X-Gm-Gg: AeBDieuaU6dkSA7zuy1cziFJOBmmeTBG8U8vErobJUsx5qslILDZPUCnWEv2hqZSh8+
 HrO8kWohXOciplAyjo9mZBE7CxWO07nidC+coZIT7krEvq+hMedOVaWrZQOcKj8PzcVgM0s/qv0
 WWiTDLHRT0YRSmdJvplUElFeIfI9qoy2OuoEqbHl8hlfiGLWAzPerxycp4qUELsycY8e7e+d7/t
 Xa3jcnSrygvYQOOPWTQ1YFSX/Xu3DwO/FKNdzGWdkhQ6XISdkFuifuMS97DD6AUa4lChgNtDaPU
 GBsRtw12YyrHmDfhR0lVCTr3XEoPMhowBwqlWEG3E7vvr5vu5oRaNfmMAP+rKhaQe3CMGfX0c15
 8GBVMnG9fVQzH0zyXY4bspplcqWWlajFVRa4p9pkQdicpp/D99BdPP5y7bxylKoh5LQ==
X-Received: by 2002:a17:902:f551:b0:2b7:9ed0:4f92 with SMTP id
 d9443c01a7336-2b79ed0505amr34984225ad.32.1776951005405; 
 Thu, 23 Apr 2026 06:30:05 -0700 (PDT)
X-Received: by 2002:a17:902:f551:b0:2b7:9ed0:4f92 with SMTP id
 d9443c01a7336-2b79ed0505amr34983465ad.32.1776951004706; 
 Thu, 23 Apr 2026 06:30:04 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:30:04 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:30 +0530
Subject: [PATCH v2 01/13] media: iris: Fix VM count passed to firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-1-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=1361;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
 b=kLZ5VkIwiLF40laB5sma2d3q4alpT4zAEZptqRbq23De2A/jVlXuy2rCJ87n8t/knrGPt5QnQ
 BQ50ze3n+5yDir6GHjn/LjLJmJfxx/KjeK3oF0PhnKyu8vo9IOmZtqI
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69ea1ede cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX25vaVUcIiUrt
 OGUnGc5i4ITycrcWNmkpcITV+6yauWsnPgJ1x+xBL4bb90KLMmjcl34mBvHQ+IIh1bHceqLKqyP
 uytRTtVKah1YKVBsG4nNnFW9SSP61NJ3p8ahLHM2Mt4JQNZqh1Gn0WaCNuDsmthP5XcoWaYe9Ne
 us4I2clchepR1s5pS9LZ8DuQH1u3BWtfWb/Z2y/J1BKUo8z0rOpJvc7mXekkwyAI9LHoz4nePOj
 o2xZ6o5wkqnqJK1AnNsbgcFZaqmbkm74u81Kj9386LtGEXn0NlkBl0HUgbqZSbafcjNTJHtAcEa
 ThjLfxV8Z4zMPgCkOzypf1LYXxVU7xS0/W5gKwZ9rRKTtG/XUmWcyhs27sDFzdJigrLZiIBqnWZ
 CNnpG2lUuO1bL50S8SEGUHHS4YRqMTo/E2w60+KgEgRVIQl1Ylg/s4l5eX/dV/SwM59kWJNeikl
 UjGcefmgT3aoSq0TGlA==
X-Proofpoint-GUID: PUZO8NjmWpk2V0YngascO8CBck2oYUh4
X-Proofpoint-ORIG-GUID: PUZO8NjmWpk2V0YngascO8CBck2oYUh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134
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

On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
the number of virtual machines (VMs) and internally adds 1 to it. Writing
1 causes firmware to treat it as 2 VMs. Since only one VM is required,
remove this write to leave the register at its reset value of 0. This does
not affect other platforms as only Glymur firmware uses this register,
earlier platform firmwares ignore it.

Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 548e5f1727fd..bfd1e762c38e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
 	iris_vpu_setup_ucregion_memory_map(core);
 
 	writel(ctrl_init, core->reg_base + CTRL_INIT);
-	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(core->reg_base + CTRL_STATUS);

-- 
2.34.1

