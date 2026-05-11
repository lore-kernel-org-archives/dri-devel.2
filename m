Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC140CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491F310E214;
	Mon, 11 May 2026 22:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CG8l9Pkv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SBrGQDGA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015FE10E214
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:07 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6T1p2186404
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NUPp2c9rAOL29gHVGIJXyIeP9TpBMN1OdAXgD2H+ohc=; b=CG8l9Pkvro36Dld4
 N/0dSJ66oyZTv3rClHs/r32KRRKZuk1OnZV5ZHWIsV2e/b3h6q7lxjL6QFcSb2qm
 JLNjdXW9dnssebTUeCvUdRH0M1FRxbFNFoE7FuHhfXMlszdbDO4ezcNvt68vJO5u
 bsml0ZEI7vZYmfsumcc7SPdF1h3RmaLR3AXRCNPi6SR4XfaMT7US/n7uyjMTFGOD
 2UgkFS67Xq2iRPlLmZ7rK+5Mcgf6StSyqBMTS2PMfdAOITQjGencCsLYvgcIcPAk
 /b8WyR+gkEmASOkZQkQH7KOlJScJ3NVm5Lpkyj/B3AvwbKMWqG+gcCln5Sq9peEL
 i8fgog==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0rf6c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f756ebd0dso3074444b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778538247; x=1779143047;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NUPp2c9rAOL29gHVGIJXyIeP9TpBMN1OdAXgD2H+ohc=;
 b=SBrGQDGAdVpMd41hLkK3SeUgl2dyETQsOkk8S9p69jhQZ3oHHPolWpT7Lb8Lb+pM9Q
 8TqmvI5xPFsPsTnyUXoGBRkKEcbEyilXS7QtqDvOxI2Oxa4FyJlUg3aACCiQIDrQSTqw
 y/y/jnzrdl54iaunCMntZL3NvxYI86z04kLamIoyiRDcdNpgGrf3862TixsIldXu+1Ww
 2VAa2BT2IWjBmWfTnyfR417syZTwgE3XIs5ZJUFPM+Mk5XQiqz94RQUe+sVZomo8Isya
 YIeXBiCXVt0GzfdWc8t1OqF8PRiWZ+aAbt4CArUPQv39kVtpZtImSMCtdUe5+GyY67tz
 3rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538247; x=1779143047;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NUPp2c9rAOL29gHVGIJXyIeP9TpBMN1OdAXgD2H+ohc=;
 b=RhK+B3MyQzqaa5pKjvG3kg+MKI5YWFR7Jgt8gfWwhopcPA4/RHRGMurTw+yOtJU5vj
 btdbHJYYzwsq+8My9jMinp5htQ6dvYogxZdi5Zzxg5stLPFXQ5Gifq5+QZM7B/Rf8a6G
 7XVH9ARH0uk74hIiul/6xGw9VOaOpfKtLUXShe7+IrXr9yuExbJ7RHp4w/yDBZr1ZUGm
 G5F2gCJxP0aKy9drcswKpLC5TlSvDKyZgeINKg7gKG24hggY1vAKKAF1QtXSm01k+2Sf
 EbrX2TsACr9JeEMQwnoH+DzwN5IzluvPUCj+izoyHcNIcbBo8HfSmMe+rzhze+CTv9Ff
 jbdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mNmDbe+tffB6AqJy5M4+gSlMzKmnxmjFS1w51+ymxlMgTL+7yCRZ8XQkrByliQu5aKSSClgqBtew=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpCAb2M4REMwcT0cCTsD3B8cUIvIyJU5R4dOmy/iZbu40cUSB5
 tLfUDY/Q1rd06YMbgp7gPXCG9U7M0/tDdizkrV3ZyUOFiUBGV1xowx0NaOiP6jkwKWL7+QC5xJ4
 nr/JRbVRDVYLZI2aigPVMiDOZA18sa7Wi5yKQLe/lrrr5TVW+bWybzWj7PvYxvhdqd92mhfU=
X-Gm-Gg: Acq92OG6dFfD0oDq6GzsLa65fd1Tk+z9YjMiJsPOYn9+GLYVYFFMwqSyBsUiXg5gWRE
 4Np9eFIDxz/XJ0LWc7qgls77xzEBbGOi/EHefnkAEjS8jhttF1B0tvlx7surH5Rs21yK9THzvLQ
 CYsv55WF4+1uTWkn6SST4AAHhIS6vIZyWIBizIrSiHco5LbhBtEYXXD0S3t+QeJcEwXqgKZyvck
 koYK6ZqXunJ3CnlqS47yw+sMSs1Ma3yHtyCI6s9xW6r5p2Lb35Ge/KgmBSMOvw+9vijMDs8uW97
 it4BEUC16nIzGHEt7+Ti0i16BLFWoZZTmMryA1R0HZ73o48KFJbCMGLpy72tNpEx7DE/aPdMV3D
 SKl3iwgdrvcrhVzVayk+zKKZ9uwJIqt1FAeGpehF/VpN3+w==
X-Received: by 2002:a05:6a00:a90f:b0:838:af72:fb44 with SMTP id
 d2e1a72fcca58-83cf4f760e7mr18257639b3a.2.1778538246804; 
 Mon, 11 May 2026 15:24:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:a90f:b0:838:af72:fb44 with SMTP id
 d2e1a72fcca58-83cf4f760e7mr18257605b3a.2.1778538246344; 
 Mon, 11 May 2026 15:24:06 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:24:05 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:18 +0530
Subject: [PATCH 4/8] arm64: dts: qcom: kaanapali: Add qfprom node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=1012;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qA59djGG78P3MNRfB1Y8EMktq/ELkcaIx0EmOPVu47I=;
 b=9OvPBcF1MZb4Ksy60cJdP9QxS6+kk6zi2B0H2ygRxmneK9+uTtViTgI5ljZCjPD/i/sq+fEEV
 0s0G6D2JEOpDKJB6PzrAU5NDlmvdjlzdEQD3pg3eLjw+GXlyZfoTeaD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX8vEpiNk/NVLy
 pZxeXKH740CHj9JiNXCiM4jzeBVzlzfkyashjPXCXVh+lPDaRBo+zuA4Ffine5SV6dNPGTFW+e4
 Ki2Ml8aXcNoHvhGixpOKLT809zLWIh8Plb0wdu6PaMG/njYOI7zaqNSEuMfRXeeFecbsq9Y0Zf+
 82Lsl3635o+nkRFWlp8Jk/PtwovKTJl5QxjKXyB3/H6Em7As3ftqEAuq1BgjSI87UHe4Al01q/c
 XDK8H/MwHlh2pBdjz5WOhl004yMUxvotTQp1+0kHGjjJQJJYhViX5luKvHdrUThnspAPZVy16ft
 +tZSuImd0MYVhHWx8/OBnA1Oi8F6Z+WxOiLGOzzvgaIsxriruhSPzG8zFAv3x1l6I4544DVhwPJ
 KXHpA/cYyyV1AKNbovd5QUp1q9e5emAFaQpn9wIxkUBvY/sovzyXhOYRQpffOlQnxlWhXCxU1R0
 zQnEcEm0y/5RqpuJbGQ==
X-Authority-Analysis: v=2.4 cv=bpB8wkai c=1 sm=1 tr=0 ts=6a025707 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=doS3iEISOceegCkkCwMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 2JHgkCKAs9-8fnEjxiE154Dhhd-STFxH
X-Proofpoint-ORIG-GUID: 2JHgkCKAs9-8fnEjxiE154Dhhd-STFxH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236
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

From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Add the qfprom node and gpu related subnodes on Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 26a4de9c8d45..0211fc9f8c88 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -5868,6 +5868,18 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
 			};
 		};
 
+		efuse@221c8000 {
+			compatible = "qcom,kaanapali-qfprom", "qcom,qfprom";
+			reg = <0x0 0x221c8000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@142 {
+				reg = <0x142 0x2>;
+				bits = <3 9>;
+			};
+		};
+
 		nsp_noc: interconnect@260c0000 {
 			compatible = "qcom,kaanapali-nsp-noc";
 			reg = <0x0 0x260c0000 0x0 0x21280>;

-- 
2.51.0

