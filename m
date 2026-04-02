Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAA1D39415
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8712C10F1D5;
	Thu,  2 Apr 2026 11:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mImhmY1o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EIqnzSCl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DAE10F1D5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:45:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632BW3NN948977
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 52oscFDjem1+c6zc6REhqJiMklNGT0dva2yqjZoyFxs=; b=mImhmY1oGBZrt2qH
 75fX8kZbnzFijwj28wOG6UCTJtUm6EjdA5qZlFJVnL5mjJIdQQsLOySZrpPjuSD8
 d4IsngSjeNL0JXg6Rk7lcm4jBZtM1BQ+PjKAYJZJ8mrsXjE8+BlERaxwiHUeBMFe
 Uo4J/lW4+//e9j35G81rTfQr2pjAqADmiM9Ea867OZpI/nGDv5f+3Qj5YZt74RSr
 4VZgyFYFGTx6Qt2FxlRJjwg+FdOqbiAk6fUPNdi9P8HHrwftwjUQN37r6mKwUL3e
 YzCHG89Fc2S7mMXsGDek1dL6GPttBL+rDVOjUoid2o3I8gZxXG3/Bq/K6QckO59s
 Q6cyyg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qnu0281-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:45:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b781542c1so16012461cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130341; x=1775735141;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=52oscFDjem1+c6zc6REhqJiMklNGT0dva2yqjZoyFxs=;
 b=EIqnzSClBTfEE6pWm4DT5t6z5d2f8EPL3lodABWxO2xgTwcJbP5iTl4ygvM6LRJO0j
 /LKwY/vuILIe7b7hBG68ETWtsyvtMOontTr1nSiilYU5rLnfZTWkuPCLBYmd8WIfF9nS
 nWJPuu3eiC5wbYQpMmgcc8HJa0GpyeMgqaLltmoe9uPWR9bhshEAyzfQGzrpTEbT55ff
 nMla3gT0SslBkGglE9KF/j9azS1xVTmP80UBcClsksSzb0e4kl8EsViUz7DAkVXdZ8Wv
 A3/6rT92f2lflBmcjeNiEVQeIgf2hRx6JWhi+HvMJZNu/dlehASqZ0pnBRMVQjTBFir3
 LPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130341; x=1775735141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=52oscFDjem1+c6zc6REhqJiMklNGT0dva2yqjZoyFxs=;
 b=JusgEBgIVr3cqnXcclo9eu95kGcWptJu3584s85t5ifpqCIe7G5tFpz/0vwcIUOeNg
 gmyZsBN4UujMrxaNVzucbKoj+b3L3sAdJ1Krm/llMaJEOrsqmIIoQ32O2on3d0T/ftaS
 fGHVw9RSBdeSa4SwRztSrDVaPYIpq/4PJ32TrpF9qs6A4YiEJEimRqbhpZVXXpVuK144
 Ur5Ibxd2iUngXsZDjmRc/0CQYfRT4VX83I0Uoc7udbNjZ9QPIDrz+e/3H65Q9HoyYHXL
 7dAFt68VcYaM/hDN29aaDn0/Ksq1hn5uCXK9TycIoa+acnnzq9yQygiyvXhl1Am68LXV
 MVjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIGXd3MfxNIzJsNXa3ayqAylC6Ib9T+WFGVYJhbPg1RDVSGOBilIEYQOt9se2k0pRoL4EruyKELrA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi7pDE3d4uVVM3Aq6qRAvvK1W8efV+vUXnOoKVtRe7n3BDexB1
 cdy+lkh0x6AWvERzHVQ2OUMSNdzKBfcf2IZII5/ob/NVmw+KPcBiqdRkcJVtbW3mE29tJxQ0NaG
 U+/JXBXkrchGIxD5T7dY+WlZyyPfXZTigp5LB8A1qUrppt8KOMKkfPa2AlaIHQLWSeNLiX+4=
X-Gm-Gg: ATEYQzzcfwDV9TicSMfai9aYSz5a15XWTcgq58FDlevIcAxR+49ICIkRp2GeT6bXVcW
 p4r6D9ryn9ZkgSoTQMRNcQlTLc6vzoTUSLx6O23KOat+P7IIdUKUF3gT7NQPI6nDjvtu0soRuAa
 YmYwad/pqUGoaB1HzLPs9t5XPNfQ3tUvBn5eIU4VUXWXqEMp1lchR4V0xPQjG93EZrm1kxvhHj2
 xX2JNZaDgMLPZfwOCqNLTXMNVOxK4LSvbwwEQqvAmLhkIyA3kWy0WfK2dNVc9BBlgLCkKIHs+Wi
 D8yGKHNXL1Cyuaan+rjB4AK8j4pb15o7RlhferPaatC2u0pcjihLmV9MnvowtZlVisotn6B7xKD
 ABxztwqqYIlRngBpXonL0LZwsadOn8nrbf46qaKt2IXuP
X-Received: by 2002:a05:622a:342:b0:50b:4ccf:135e with SMTP id
 d75a77b69052e-50d3bca319dmr93914051cf.31.1775130340847; 
 Thu, 02 Apr 2026 04:45:40 -0700 (PDT)
X-Received: by 2002:a05:622a:342:b0:50b:4ccf:135e with SMTP id
 d75a77b69052e-50d3bca319dmr93913691cf.31.1775130340436; 
 Thu, 02 Apr 2026 04:45:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm141614635e9.0.2026.04.02.04.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:45:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 13:45:18 +0200
Subject: [PATCH 7/7] arm64: dts: qcom: sm8750: Correct DPU VBIF address
 space size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-dts-qcom-display-regs-v1-7-daa54ab448a3@oss.qualcomm.com>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
In-Reply-To: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Hl0zlaD4IFKg1NjUgP4F3RZL1deVCm5fZzxtJLP6NuI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlbRKzvDDtL47/CaCW54CxrNWexS9GahJTKi2
 iaw89qsyy6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5W0QAKCRDBN2bmhouD
 1/12D/9lyqCjDlTWt2wGfOBuaN4F+vLvaKdGUDuVV78ws1k9JCci/g5hVhpK8FZ3FlRRBgypg7b
 thYKSd7SoG1B3GXAQyC3uCBG1yj9t9cY7tl3o8lLFOUdtXbuhZkl9KTqdzL0U5BepmmPD6l0cBG
 ge9Wz/kZ1Fbzwlv0OIaXLmBeq3ZzpYooFYzfxBxOkHjpRDvR46bPDcPbla/GW0og9UNurohTNRz
 1DyvFCD3OzQkkq/46es5Cnks2DOBA+GcRqlhjchrA/mT+jyQVtb+dVDqdJqtIES8W4m0HSWYPug
 ac/wKFUCONieXfzrSkgilXvqToKaYWjU6q2pFPxYCYnni2I/1rmGpxTuu8vIWM7L3ehFv+B7Bfc
 zT3dfwFb0MH8Mvv26KYnibHXcocPLwDIm5hQ9jYH7SCAOhWlJBs/3S8XC7R0yI8bYAEEVBGKZJK
 bVuEZacc3owj4gJ9NP3PMMt+YLD1pjV4DSBr7cw8Yedn9LVWPoojdodqWqdHBVNYsava7bBrYYu
 a2vpGtV32UY12xOwdXFfTNDiEhEVyplRz09O2PABk6DQ2BdjgsOwqXlpo5zWd+XyDlBslpJbRUE
 102hsPJZa/zxOv1scEAZnxiYFxjZyYo9Ioi1vugoKMEv7UgviVZSKTHMIlrHSM0x57ruCmFrfLo
 W9Mka7rzRqw+qRQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: uu6Nof1iUcWNR3WmXli5r8QAkSzgtMEG
X-Proofpoint-GUID: uu6Nof1iUcWNR3WmXli5r8QAkSzgtMEG
X-Authority-Analysis: v=2.4 cv=RoLI7SmK c=1 sm=1 tr=0 ts=69ce56e5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=WYllmNudUJmrw8VR-PoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNSBTYWx0ZWRfX9MLX+SK9G39z
 0XnFIqhsT+3nwwfr/v1h/fQG1pJl/aTYY/8ZgRWjwNE0eHgct0VtUZMph6LxaPXa/LL56Ss1oUw
 srrV1QhLGc0LpjUWXSRmUDq553JPf5SS2NDbKn6vHJZJ+JQDCHZumSGSxFdDOOQueuygJzT7FdP
 oLtKSBxWpNn9eiV3ZNVmsXmzynsI8SWfBa9oDzOm3FEUG7mB3y0PKZrRm4j0mhyurpqC0vpfzyA
 SGGU0R6cYLDaNDKlD8Lo/birVGN/5dWV4ZNOFNSYbd6h5aIEcYgH7R4o7Ip2VtQb/hun5ggRZ1j
 XodSX5kz/l9/UZUMhSUjCa09CDlyOvFMASnVciZYoJFEtP/cgj7X6NuOBtCBfSfo+omVRwTTKPa
 1ExVW145s6d9OlDo4Ex8M4p4bBcgzt5MCwPoKmn/LzgTs9hMkPkZzfA8o63dIY6bLdECBFV3PSx
 +zgr/gDpoG+Mlerqzbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020105
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

VBIF register range is 0x3000 long, so correct the code even though
missing part seems without practical impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index aefe517e0669..f4b8703ef856 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3041,7 +3041,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			mdss_mdp: display-controller@ae01000 {
 				compatible = "qcom,sm8750-dpu";
 				reg = <0x0 0x0ae01000 0x0 0x93000>,
-				      <0x0 0x0aeb0000 0x0 0x2008>;
+				      <0x0 0x0aeb0000 0x0 0x3000>;
 				reg-names = "mdp",
 					    "vbif";
 

-- 
2.51.0

