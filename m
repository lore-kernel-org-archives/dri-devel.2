Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E57C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C3F10F5E8;
	Fri, 17 Jul 2026 20:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DpiX1zfS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MitxR+m1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65FFD10F5F0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:43:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJu2ap2824939
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j2OnpQ0EmgRssH2L3CQIB8lRZrNWoIaLQHzlCrugCPk=; b=DpiX1zfSRa6lldwY
 U3+6wAwK7OaEjUxXNbS6Hpa/Jz9rdmUiuJruNGa7Ft7Pb87qNd5/8ado7rOywoji
 4g8r0n5RFV7qkO1xsONitbbpmd6wSIJCznkxWiA0eV4tMGotcuuqFG9WordV/heW
 63GJ6k2CtjkSArYE57hlftCsvm03e/Gye8q3E+q1/cQUKZwicwmULldy9+pxbP8S
 FISXmm7f99LpO+yvArlXiWZNavYDNvcCVNSE2ypq+uC19ybeV6JwC7YwVA1PNXMc
 msb1YG+ci7MF2ImSX7AqWz7uJYIdoiN1XUfk490TItw3eAD8W/N1yOczeHCe7mjk
 l0VYyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff8138yq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:43:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so5562923a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320980; x=1784925780;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j2OnpQ0EmgRssH2L3CQIB8lRZrNWoIaLQHzlCrugCPk=;
 b=MitxR+m1oXk3ME5RlwT4TLj6rbpaH9IK+I9qQtCD7Rvd5Xkvrt2LwNoD/Usw5tFRrZ
 NuT/IaMGfMgZKogyaXsxVkQyG6id8XmhY6QVEuAUBGs9HDQQKtfXGDoailSuouoRobP8
 zBbKLdXdArXNz2Rrlng/RF1735RhMH1qA2+B5OUCnz9bD9Xz9Mbh0lOl+mrfu+HgC2ct
 Cw0Im/1s/6sW6IuG2idqt63X4vGSdqDs9gChspCSWuBec01oX53pc5TGzGLfp90bh1HV
 UdqnXx2B51Y1JEpmcWsVdGWVLB3wo/6VYd8BczNBLFn+XOV53KuilRC7N3x9BmCVqIhB
 16XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320980; x=1784925780;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j2OnpQ0EmgRssH2L3CQIB8lRZrNWoIaLQHzlCrugCPk=;
 b=GUvkZW9CgntTTqbtikC+MyovD9a8rwbTuOkVw5NwCRwqJ0BnBEDGAlK+UwBqGPbckd
 F+6cFQBNwXooLhVkDr44dO8OaDf6qYcA0HphyFSC65JeB/fSyfp9TWpjsB19RE30/tco
 2g8BINOBY1pEuVVmYuqkdVu4l0V0pDY3P2uvo40OipTKPX98lgNEkAUaccU4qaPN/wO+
 y/BnodnKys7CD8/ivr2WX/HY9l9Arz1mqmK0TCfuP6ilu7nrtTkXOfaA1v1hlOI076fB
 zoUAI+rK3pWizRwWvCjlqSRAAokS4785g4aB0s0kJskX83c8tmbuhhy9Iyu3FM/gJ+Jy
 44DQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgOJHCAnrpICauQXO5nLaasFsSlac87D7ikt/0TfrZiFa3AlyyJvXBZ7wSxPs++b9qnjHc5xYdWi4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuL5M1j7XlDpQGWD5WDHHq8R1LYhm7fownuIKjkogDt4MQt+WF
 ard/QSRC2T860zgBgG6UloRveltKUq0b+jGrZGpFggSwBYiWjbEcqZnqZc5R652bfOeOoL8rWm6
 e48UOOWsdFQOInksb405NAxNzYk9ZBEPGq1BXXzKGz4yMHAYmfsMCRwnLrhXvWhkvNY3VSfliXZ
 TabLY=
X-Gm-Gg: AfdE7ck6sqQ2JJN0lbnSWcofKy6t5y5VEirNYWKi/rju0+lSzpbgEHnLrj6HM7EFgA9
 yfQOn9Ma3tdj2vgka712y2CG+1/seIfcZRAwgjc0+xuNvJ61jZuVUZEmWG2A2pKp22PsfpdenSy
 vQuA01Z9sif7w371AcY87TueGKHyLdDp4K29CPvq8Xqfz4cw1GcSBOMkeHRB//Ivv9Xe98AgNPX
 RwdRMCe8wQFxO7dcHBoYy8YdAZNsmm+ZHGnhoOU785dq10sEtOLkm65UHCTeZagrTMoA3LXf1/o
 4JEPN5BSCCM5W8pkMlyrqtdY31BzX+SdXMOEUPIlnHBOBGBfadpCdvb9aNvGtyR9NXyoujbR+w7
 YISpW1A0GSns5GA2vfnQXygHi
X-Received: by 2002:a17:90a:d60f:b0:38d:c834:2106 with SMTP id
 98e67ed59e1d1-38e4b51656bmr4228871a91.28.1784320979913; 
 Fri, 17 Jul 2026 13:42:59 -0700 (PDT)
X-Received: by 2002:a17:90a:d60f:b0:38d:c834:2106 with SMTP id
 98e67ed59e1d1-38e4b51656bmr4228835a91.28.1784320979372; 
 Fri, 17 Jul 2026 13:42:59 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:42:58 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:33 +0530
Subject: [PATCH v2 8/9] arm64: dts: qcom: eliza: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-eliza-gpu-v2-8-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=1862;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=I2qdHaXAWQ66skBdEcFBDJZY9iFXnEWZCtP8SvXbtEY=;
 b=Hr26za7eMf4CPEZuBeq1QpcGTa+cwNyDY7ry7ltZ24uYMQrlbbDQKhp1jH0P9FhBarogV3/ti
 yGBLL4sPirEAEkMVokLL3QmWaYWdYvOUfnk2qfLFmhYQ4OdQKTpPQry
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=RbqgzVtv c=1 sm=1 tr=0 ts=6a5a93d5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=wz9XmjxeAwFrORu178sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: jexDTOc40M4U78yGzY6xrp0cuwSChxv4
X-Proofpoint-ORIG-GUID: jexDTOc40M4U78yGzY6xrp0cuwSChxv4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX4ljE2zrrWKTK
 LdrT+AG+DpJuWDa8J4H+twvDPOA2ikSxbxrQSjuA1Ww5R+EVrBGLwOHmlVF+oQO4Z2iiQWuxFjn
 51PifpESmOEfIrGQ1xRCGzfX06cCj5/MQS9zUmNt54AKJRK+x2mLT6I/THuKM8GGomZoadtzWxd
 aGxGuOvt1xCbjgKJGZh8L29fPiWqgST4UKf7WnXkCVMc0tkouflZHvpt5W2JI5IRKk1nus0YFKh
 WodA/OWj7mNQnB9uO7uwatUAMApQoLj651fEpgKSBPvNR5t9DA+5uktXLtzlyoYLUP527fxvvma
 izfTLyNVq3K/7TqIkns+cCn91mQal1CUI2ajynwTdzGECmNKkCgZze5t0AN5SurBLS0jyxH2woc
 5xESe9FgQLLOMU5o4fF6zJ8VjJcHrll2661mkEEpwT2ZwBJttLI5imAZWi/OJQtQhUtboHmQw+V
 5iaQInBhEcEkQO/BUtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX2OLq6ff0KV8+
 jUvEK1/eGj2DffReiDC00VDwLe+vSDXArvJNlYgxdQkHyHi3GdXs+6wtIwFKb3M9P0jZZiWv1uH
 aWq6Wq9Es0STWgfVFm+S7AL68RIoE4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170213
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

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures. Set up GPU cooling by throttling the GPU speed
when it reaches 95°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index c24c5e9695d5..7a6095495b5a 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -22,6 +22,7 @@
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -4203,7 +4204,7 @@ gpuss0-thermal {
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
-				gpu-alert {
+				gpuss0_alert0: gpu-alert {
 					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
@@ -4221,6 +4222,13 @@ gpu-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss1-thermal {
@@ -4229,7 +4237,7 @@ gpuss1-thermal {
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
-				gpu-alert {
+				gpuss1_alert0: gpu-alert {
 					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
@@ -4247,6 +4255,13 @@ gpu-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		modem0-thermal {

-- 
2.54.0

