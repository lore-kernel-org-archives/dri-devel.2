Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A530C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8924710E163;
	Sun,  5 Jul 2026 08:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mx/nqlH+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xs8QMY3k";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C13510E16B
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:15:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6652An0F467616
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KnbrADbl03nZ3Cw89pBBXWj7vEWq4V7jAOOPfBK1kzQ=; b=mx/nqlH+vQt38iZQ
 d28JFJ/cemI1rlkM9IGsruBz3FStlE2ismhLruTZkYLsHK/TAIDeWZvHAH67sOCn
 gNEXWi3bJuodCCA9h6F3LSX3oBr2HztIVG1Pnn9lDb6nMrr1mrSQ1BMF3BfMYay3
 So9w13jlRxMWddtwLFWb702CUBzfPj7+Gvc0lN8WNcpFm1sRd4+fbt29w4WiLza9
 keonQARIz/xuOcnA1icyyGgBSPfIstPNoYWlWaP7Co6w1pRXz7smtrNeYEHU9Irg
 ebAD27rNojNDVWOPktWa+NXGIHNhS6beGoxvZlp06mCqEowft93vcljxV/LWmzC8
 tN0/Aw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4stev8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:15:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso28703845ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783239344; x=1783844144;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KnbrADbl03nZ3Cw89pBBXWj7vEWq4V7jAOOPfBK1kzQ=;
 b=Xs8QMY3kD68grwG9dFJy8frpSEjuIRITPz/3Df9IQjTtRTrJVBgeKs6dqiPKcAmT1H
 f29PsBoC7kKjYog8r1bSO6wlVmyMdzUP4guyPwAWObbGICz8MajuG5nuyhzEJ8eVJFIJ
 GIeFR/HSzAjzARpxyumnC6l4aRTigAuaCWC8pUigmsZBZpyPEePFtvY2SI4X06upQKXG
 DfpxHFA/U9gAvHtTnaMfGvdvBSdAF7d88gpPBdXSWZGqkXt1iFoaNdHxY86flSgLJcXY
 jfJC0qYLemCRK6Nw7BJcr9gWsItuTFu8hrPAl8NmNyQvJahtA5Nzzp/pfpNNuF8ICHpc
 sKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783239344; x=1783844144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KnbrADbl03nZ3Cw89pBBXWj7vEWq4V7jAOOPfBK1kzQ=;
 b=TOZ1xz+WPnOrj8J5Y9j3nf8umuE8PE3vw9C/YA4oCTxqN1FZ5wzixlr5RvmlAKo8iw
 OTziCHkn5XZfRk4y8O0YcN4pnlJNFCseHBXvuW9ruVHVz89axd3m7jtv7ERI1Lla0PRQ
 M/NFzzG35mVAFNgF9MKgf/KxuArznpJsWQyhxO15GoNxZoh3qOUPMRw+cwtyEh/z1HIX
 h/LvP6AMlHKpIktUZzFX/THmh20D1bJ9PWncdldHqQEwOHHef2nNEr/Oq70r6P2FuKRc
 PjEIP6Pne9/OpvuySd83DlN8VOQHXbdC1ulelbDATeNQq5tVvyrIsAEEIWCKrQx9Fr9y
 PXPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpn9kH+UoA57rFE+3QlJ9m/60MwT30Dfl/9TEphr3AV97a4/3WUjfJ5EIONr4SvrA3CXvHz6J3gKyw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCPDE0hgQE4AetTYdDbaMYP4TjLiOTXNrV15wMocfn1ctYYP/9
 xEvA6KQIRMIAxFRLZxfGohbYuIwqNivmK57mU+JVDoYcHBiQEqB3QEvsYoHh8Y0dl93QytqB0R7
 3SP5vj3b8Liw6Ibvy6myppPaR0wWlg7ClRsrhj4dmQcwkO81xhJQXvmk2fFsYBpjnmVSNj+Y=
X-Gm-Gg: AfdE7cnt/lwc8PU2U5ol8I64tUUKYKzHnI84c/sRLw82/Ad9JmFVPniXkPChIFm7Iec
 LPbOSk8lPZQznn4bHGXNz8n3tfTUr3rSuXh6txL7ji+Apubj8gT6MDLTWSiM+Y6AY5pxc5/Bvqn
 6YEMldubGhfVjeZXqgd25UT0ATsD/9ouimVwwzsRpgNIfcWVly7igOqVnGwaNC73pMXFclDYOJ3
 Wnve1ilwj+Cw7MGyDutXw1XM1Jc3V+zOg6iNOnRwpwih5FU148eDdhkFXSNENwG8LGZ0aTgmrea
 uwHqqUyJ5lpgrT+0zMCoT4lWqLhYG4N133rwh/TXe09/jkhVLjPE7zdBHvs/ektq3IW2SAIYreU
 taZcnLCBNq9TSbPxE1YytTbJDh70OO0pNUDQ=
X-Received: by 2002:a17:902:e746:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2cb97e47ac6mr62891435ad.7.1783239344087; 
 Sun, 05 Jul 2026 01:15:44 -0700 (PDT)
X-Received: by 2002:a17:902:e746:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2cb97e47ac6mr62891115ad.7.1783239343645; 
 Sun, 05 Jul 2026 01:15:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:15:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:23 +0530
Subject: [PATCH 8/8] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=765;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=7fFNa6LfUvVHEiiBGevq3c8n0UAvOooWHrhEPYn74wE=;
 b=6S8MpiE/YFAUGREvxnleOYfr3um2lofUcKuw1nfRX7A8mx3JwkxdgebU3v0OjfjzNtQWaFiAS
 /og6Rpi9tCdBjBax04qDhYpZnfbJh24WgKhT+Nh+02OcLdPzXBHjNLS
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfXw17r9QBIFMh0
 vno8tLjb63lR0e6WTStHHruRxPWN+KzVSRFr40A+9V1UHdnlAmB+jQi2zw08RvrbvjD9oghj16E
 aW3LN9wHRA+YoSgXGdncPk8L2MT/mP8=
X-Proofpoint-ORIG-GUID: t5X0L3Mz-C_tcqwBrFVrh_t3y_x2vLQr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfXwKCqwFBD0+AY
 MmbTURfHpxLwftYiLlqC7LUrOwXU0hG75pmwj/EOrI90Ri9WNZLP54ijzRfzvNBLG+SA/e4QTRt
 7U8csexwweg5pcxCnmclJcncq5TU/0cpqVPvmunjbAW3JDzeaiON/QUIn1xGnoOaW74Xisxo/2r
 Ftn7yUomMk3DrdGnm01MLMrsONSDWxuW+p4eoky0vjipEAZVBCIDYKJ1vj2SteuC7KczVVJuz5I
 3nZA7ICWZY8+vki1VUHdW3tZPN05rZmkrvz4HU7LNO7FjD0pSe7LBLVaw7loLgaJSxT5B8F6cxV
 gdcFjxMSoM+0V1THX83zPF5lfaVuna+2L2ar78lRdmCc7wpnj0dCn50VhVOu1qtaXBHZc+uBlVs
 aF+ZFIJY7IgxE4+ZYcRipNR0RcBu7OIxakqne+BjQH9B7TczFWMrh50NiITdIl72CxtYs3uYLn7
 bUm/sr7OThLVzDDajYQ==
X-Proofpoint-GUID: t5X0L3Mz-C_tcqwBrFVrh_t3y_x2vLQr
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4a12b0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050082
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

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
shader firmware path.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
index 1374afd9d14e..b280d8e845b1 100644
--- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
@@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/eliza/gen70e00_zap.mbn";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.54.0

