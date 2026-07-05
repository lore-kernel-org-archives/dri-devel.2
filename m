Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8591C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CC310E14A;
	Sun,  5 Jul 2026 08:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWyX7gcW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gY0NZB8Q";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27B810E14A
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:01:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664MlhvL034841
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=; b=PWyX7gcWfCQdAu58
 F3T9QpQ04Xkrxc6Fjh+aetKsgundaI7nqojknAu9CE0124sk4c/XVlw5eg5wdWqh
 6KpnlnCGpvUdx/MUxSRYJuLaTbV11Dm3ri5JiPVD1ErN1T7IH0OqwCcxOPQNWpoJ
 eVPpPMQb+laaQchbR2adnAbxn3/UnUE7Ygc4iAGRCr3IhicamyKvNs+sjDa0ZQVX
 cHSPBMpOuVhAwswE7841nd/k5pymYfmSrxi+T4JiQcv1PafcexV1LzZhqiksWzyE
 ZW4hZhhBA2sEXaQWBAmQUi1BUhDeK2wv2uBuYmb0YuJmQNaqrbxCFw3BRgdVUWh3
 hl5eCQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh2d3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:01:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-380b630c505so2423416a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783238508; x=1783843308;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=;
 b=gY0NZB8Qf/2uUWqTHXPAu/z7wCxEdHZSQVqvPH6d22o0CuPT7dJGQ/xuWxyk/lSs10
 OgA6QmdOvWwU4cLy8D6XEt71Okn/3WZuVZhbXK/pQwwHIB8DWOYRJ1Gwfff+Tgpiy+xu
 jy0RqYF8GHAPSzkPkRc7ODMcrVaCFjj4m8+ENge+x+Ni8iz42g91xBUisPhk9L9trPrT
 XC6Ck/lOl9Ja0yqXEjDhhRLEEmhK5XL2jiV5t8SV9Q3WpWdLaQRHOisLLS3AAUYfUmZt
 iLVGKWtmphPG34/n/rZrpL49QEA7qswa9Yb0kMcUdZnZ/MZU8KgDIfUfMyncda2JMQ/W
 qtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238508; x=1783843308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=;
 b=iAxh3lx9pms6Q1gKjUgH8zJdFScANwkGz0K2Zgt2mD+SSODmaweWWf2Y0vl4LTR+xQ
 X0SBiaxdgW+G2XGVr3kzYS60vkjICx3tkkX7nzQCqtuS6S+Ho9J1w7StuqGJlYhszwfo
 e8TLHOOJ7iUHhJiwwldFx3awISy+wBoMSxVr6TwRk5hYxYXL+cxTI0fLyRke2TshSHag
 rdlZ89dYVRfEvLS66enrwW5r9dATPhevMEBDB6KR+6hIf/Jv5KJ6JXvlweq6FidY2p3T
 4jCmDiN0duLB3im3XZWS1YyTgRRlJx2XcatpWiwnhktJM0XwCk5F+Lybw5uR9oCd1q/f
 2B7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXdZPFbgKpy6ezv1iuIEm3QQ+S7jKi3OyfRAQeWdKwvZ63nk7/QP53Mc4bQHGLImiAIAG158FHVk4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWD4ilHXAdgSWpcVy1tqqkAamldY8NHZwx8+Mi6OLrPOdcZbLM
 mHFSecEoZwUZCOxfsP+TJlMC4pJOorbdRRg6H93nqOQZ1gIXUe6vhR9Y3U8nLaUhJVljE0W5I2O
 VK0nUMW21+5XOShX7qdr8ZM6gc9rrOExO6rcd+69GjMTb7PazjDP/AZCsuK58bIzzA4+Ofdg=
X-Gm-Gg: AfdE7cnTrm24MtHmi1k/949sdVB5IpmBDsgqN0J/NhHmxWw0nQ0q+T0V/Cyy4kJ8Le1
 cOGeg6kfv60AVI7ZL5C5jNkaJIxMD/xUEUp9zYC5zgzWkDUMNMqMhoEBWeCf1d1v+eOV6henWLV
 d8rI1UnNCHSJkFTGBX0V1VvPxCJXhzschQ3NSxnadXK0Ep3V3YgVKNq9EwmR/fkUIqjUVgF2Dqh
 LsqjXRJRbvprPo4FM4oRrzyDgxrjDmWKSYGrVHW2xZe26Fs78ol6HhUpWG3jaBpj5F88opOdmm5
 ft/PjY/VHtIj0ZZ3aGSaXgAMFrM1pFG9fjLb5FJP+cwVQISi1rARJZuHizfvKjKpwrokHvR1GRU
 Q/LYUbfqUeHONuhyupQFiPwermlnTMkEZpEM=
X-Received: by 2002:a17:90b:3c10:b0:381:270c:4dd1 with SMTP id
 98e67ed59e1d1-3829e656416mr5931379a91.20.1783238507654; 
 Sun, 05 Jul 2026 01:01:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3c10:b0:381:270c:4dd1 with SMTP id
 98e67ed59e1d1-3829e656416mr5931260a91.20.1783238505896; 
 Sun, 05 Jul 2026 01:01:45 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:01:45 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:11 +0530
Subject: [PATCH v2 7/8] arm64: dts: qcom: kaanapali-mtp: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-7-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=911;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vUUf0SFe8a51kmB8FPrJBDQ5H++K+t9n0PvwI74fWXs=;
 b=xiVpoXS8RMGK31dPCSwHTMfXAXe0kdMwaj2WE5K5tRhNxI6YaIAXwzIjirprdtrPKj3B6P3vY
 S0POanPFfdHCTa9ugRKkr6B6iwFsPGUorM72lzVY2AIYrw8NLJxCOQE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4a0f6c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VHn1p_zO8-rooJRYzQAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX849D1peT+ZSw
 5V/3mh7g0WPxgcxHwYjSzCQ4icwzPuSZAqCG/Wr1bWNxmvb7UPftbQpHIcXI+pB9on4WBUDZDNX
 cAaQfmZAsdFG5IqoKJ7+H2v7pQZxH4mn9oycWvtxX/ltgT1sKH8rAOtX2TRl+bIJfC2qUxnxdiB
 20iFaDOldkzUSs1n9EkPT9vUecnXFPO92nq2aJuu8Fdpi/pxYlBiBXat1Yk+gW0xvGgbJM1MRlI
 L8QWuufaqiB8+S+ZQNjyQ8cCUjZEG8wYsDZ5zPHqzatrgFfuMsXpQ6lbp7rpMdbpw3/k2CUV1R6
 bgSUUMH2WxCLlqHXty2jm2k2cowxB8dZf6OmU91F+wqLZQjBIgGDZsbnUDKdi3+YIEAPKFKjuAM
 cOJiAOqmwOs0owZBszbmrA6WWt/hFVBGLMm6N/Gy5XDVXiO0+gQEcH+kVxfYpFOgO4z4soVZEPh
 WaXpj4tVgMQ29QAwCwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX64sPHaEIQNr8
 qe+VsZdARzzVM+CKZlsANnDpNr2CkIYEK9LMsuQvBBoOS5R/YSyHG4gTTRHE6OEJ21OsXDqvfSE
 u52StPrEvQtO0T8mV2W07pnr7yQuZto=
X-Proofpoint-ORIG-GUID: gXomHij62aEZ7S4aCa53nlK1EBcsIXEe
X-Proofpoint-GUID: gXomHij62aEZ7S4aCa53nlK1EBcsIXEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081
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

Add the secure firmware name property and enable GPU support on
Kaanapali MTP device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index f9b5b5718b90..ba256039dd3c 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -865,6 +865,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";

-- 
2.54.0

