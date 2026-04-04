Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09EFE63FF9
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 21:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488C810E0A0;
	Sat,  4 Apr 2026 21:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PKJkB52c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXNMK3Yg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E7110E0CE
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 21:04:12 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6343YkKU1871077
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 21:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VWvdxIpjkxEIHhKLqLaBgrD3bE9pPar0wdDrSjVEcHw=; b=PKJkB52c9Ekl/ZH3
 NFBOCFN8T+AnVLbCDTRW8P0Mt+5GGtnj9oRjB3SF0IGmBT4JHHITlwZp2yNzpk4w
 wWe/8lJC1crs3WxgudB3JP0ghtKv0B0xRCZzpxzluZryd3+qFDTsyg7dEelUsy7N
 qxqKKfU2PlDashhyB0Fkt1GDadgD3oGu0QQIlCxJ6v0cTvW4m49IRwKDuUheYxMt
 MXA+3kyB0NFT5Z+jHT985MeLxJlWmRrwrSlCgccMVFH7pke2k9uWstrNiJGHTWcn
 dfboBl21HLHh33mXvsftA/MbF36C/9XPYCX5VLCF+4t+f3Oh3BYdkv3bT92F3EDV
 P00inw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datv19frt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 21:04:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35c1107da15so2794768a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775336651; x=1775941451;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VWvdxIpjkxEIHhKLqLaBgrD3bE9pPar0wdDrSjVEcHw=;
 b=SXNMK3YgWcaqshDa6HewGZYmECDxzhbBydqU/7qNVleUrpzv+vjuCJh4LMv1WP/35q
 khev1e2oReNG27tgpDq7UVOFQFYsscwKjFCLfDsF1HvRiIkR3sh9UUySwRaCG1B7xtei
 RbsgZk2rIsYE7O9GGyk22yvuH3dICpR5EOopv8Sc6QI0XiGqkatrXb4nEmKoErnfK0wY
 BI8x1/EoetgkMB/jfKSrr617iDS6AJaVNDiMsIoMiKNlnRrYiWU4B52WL8JEKocpNo2M
 atdi+srZFiMxVZaylKh5ai6kLKKc+j7HRFjd6ETYcYeT92mGlhpMPWuFKunnAKOKg/rE
 E4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775336651; x=1775941451;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VWvdxIpjkxEIHhKLqLaBgrD3bE9pPar0wdDrSjVEcHw=;
 b=HZt+WiMBvFaeCzw7/I2lk6BJPWrEA+NMdzMUKFxLsGZ7te2GiSTwe7asZb2CRDLBW+
 xEH3VwyR76NAluUKgrEbKfuIaVUZ07znYwvRb2nnuwtI0BUPK855GlT3nYX/m6+8qwTp
 xM2Ezy2qt4YEXkMEiDjlFvLM/bZFgEcd5iv5NM3H+9ft9lMX2PdkV2QywTdZf9q3yUEw
 yrYhSIMv2JGJSwqkS+rbzcKvWubvMPFk206LqAAm4kMhEL5o2yQuWpgAqP/65Mq5OV6k
 1Dq3FURt7ft79aV5MpU4J/GO/LaRwB2Eic2gppbX1Bo4Fs94T/Knfvm5cKmxLZNVe+dF
 9NsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg1S7J9aVeFxM1gI8hNnuL5B+RS9q6HOFKgVUYowTkcsauWB4YxLzRZ6N+3Gpauw+eBcwTDJ90WCY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQGkGgGV6MtTm13tUwzvaHehV4ODIk2s0MyVfpUknvh7AwI5A0
 V/70EiDsOu/qdn9cphE5wHUq8pYPTuiy+c6XEb8isaO3XtuPN1MZhwZyJMLLxSu3hxDOejFlvLp
 012sLFBJGksytTWO13PzhPKrbHmMP4n4Oti6VXTfgaZ34enVIldGRp5gNV7DqdcBcp0CS7Wc=
X-Gm-Gg: AeBDieu9DFGsC20U0iJITPITRoSC/MGFLNpUVPMLjcg8anBsYEWFfTOih4t3xXvnvwZ
 VBObKW+UMnS27InNUI32iN5kqq2ReADedVZmhfrs2jZy8ITbuKOoW0cUSSxyC1XsBRfVc/Z2ZQb
 cGWej+BNUtIVCoQs9Q6ooHLlUIXoYhduRKTFeaS2lJdR3BQ1vcLFJSp0ZSmdl/tV9VVe0W6/nkO
 YHjoVSvGcL4lVc9GcICNv5lsoaiNLDMZA34dTokziaB1dP/+7GYUFqedWN6p8is/bqZj5TYA626
 OrDCAeGTt0269Gu+gVFSvBYI4WJDks/nNp3QuqHuxAihn7VeISeKK2DZv+jW3iOPlcsMxOU4WUn
 D+b2ij8sec2fw0hWGa2P8IlkqpKRyqpxH5syC1zWTu8tQWQ==
X-Received: by 2002:a17:90a:d406:b0:35b:945d:752a with SMTP id
 98e67ed59e1d1-35de68f82damr6916291a91.17.1775336651047; 
 Sat, 04 Apr 2026 14:04:11 -0700 (PDT)
X-Received: by 2002:a17:90a:d406:b0:35b:945d:752a with SMTP id
 98e67ed59e1d1-35de68f82damr6916267a91.17.1775336650573; 
 Sat, 04 Apr 2026 14:04:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de677e2dbsm2675545a91.4.2026.04.04.14.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 14:04:10 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 02:33:17 +0530
Subject: [PATCH RFC 4/4] arm64: dts: qcom: Enable GPU & GMU on Glymur CRD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-glymur-gpu-dt-v1-4-2135eb11c562@oss.qualcomm.com>
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
In-Reply-To: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775336618; l=767;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ccn0jChaL5zN/iyxjxDcPtJ373eleo71GyAme/3kkcM=;
 b=JRFgBXK2KbPsL05frSwn5I7UhOJlDvht+GmFwpZ3gnbdAA0ZppSJwRmWewXWhpoI4MqTiVhEr
 9DATLVPnMy7C90DgmwdBoebxDyPBn/B2JKWyKW+ibt6nE6RA2tYEYbe
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: kbj3W7iLXlYr3qgkNuDssNlCngjJ3L_m
X-Authority-Analysis: v=2.4 cv=GLEF0+NK c=1 sm=1 tr=0 ts=69d17ccb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VLalC5YaDb2G5u0TXLgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: kbj3W7iLXlYr3qgkNuDssNlCngjJ3L_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfX+NviaJV0CUHU
 sz/MC/L6c/KS6bFOK2/++9ROygbQWClbM4Luo9vI+UFzA+cISO3ZgvBS4HkPaCDCKTOViwAdgOZ
 AI3B4MnwhTQnXs0vDYGjPfX9Q3plXOY32euUQ2tYUOL6w/uHsuu/qAc/mspa51vyzrRKUA5c8ll
 BCXj4qXRoCfxhclduLto+xgRiKEwM4UxmuUiUI34odWlHPOSXV6QqLWm2rMaVUGXOWTqzrNpJxl
 Y73AFOYv3ux/OaKf+Q1IUlow0Pr7Ac11Rc4X5EtdPg2/dn+4UCP4wr93KJiWsW+qsK7zQLi/ElQ
 uUN1JwekCs/Rp5eHxLHbktp2Ae60fiQqdfRw0LNBVhnc9OwwnfT7nPNHiap2MkimJsBrAnMAToK
 keGqbTI/FhcpSs8OtajXFDYu39qhwSw5y8JfNCdzvU+wKncWdWHazEOyjnbtwoBu/IRAtSxHdL/
 Et83uJXcA2iu4E0Csug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040200
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

Enable the necessary DT nodes to add support for GPU on the Glymur CRD.
The Glymur CRD boots Linux at EL2, which means it doesn't require the
secure GPU firmware (zap fw).

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 51ea23a49b9e..a579df902323 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -110,6 +110,14 @@ vreg_misc_3p3: regulator-misc-3p3 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gmu {
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 

-- 
2.51.0

