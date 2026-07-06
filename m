Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC67C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B3E10EAE7;
	Mon,  6 Jul 2026 21:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/HVbnMK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jXrLx2KY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DFCD10EAE6
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:41:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDsd31495400
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=; b=o/HVbnMKBfWdPeGE
 YfYaoyoYMuON7hNNIrCJ4qeYkqm+0GAX0x95cvU6wFADsAFvB14Fg7zY9I+x8Kr8
 joP6cPJGyqRiA2M8kFUUJFkdngGFLDD/FbnO5iF12K0FrpsN328ZKuLdRNaAmppE
 Lk5BNaJEPm9ZNgfYqd28qCKnJ0VssVdquZ3ULhDf2f7u2NutjYXufb0qeY0r7OfO
 2SUgzOKo2bCWgmJUOh94Qae41HHid8+OyPNjuFM39zDUfO6vkNyzabNEfS1CXJ3A
 wnVtwXbhmXRg9vnusIQ0vIjuEzzoi3Vv/2JBOXKeQS9Scbm+TNTayATWFB55E2Ua
 VJnhZA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8bb9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:41:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc86cab84bso25664365ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783374102; x=1783978902;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=;
 b=jXrLx2KYgJqxnZVQvoI/NMpI9/PuItZfIorHfyBPaYY2k5u5tsD7m8tAaYEPPX4vIy
 QEA1/rXUk/UEX5mvUhQIQtaOoSxyRt1/R3byF/SLF6lqI8EXoG24/ZF+umiPn6Ov1dKk
 qv3Nea2CjyT18MYOp+zTth0os7FZZBTmJh+jbilB5S43H1qu9nhJ18m0eWL2I8OHkDmJ
 DTw7tbYU3rA1ZVXQVQVzaFWqZuC3haM+OBzvVAitjlaiaRErcPqukm+7xJBCRobSucMH
 mKEHT4VhaanRKlMGHL0BTp9p4yOWOREMjlf6BtLlPwuVpZi30MJ1Ks3T1ZOJU4H0kg5s
 9gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374102; x=1783978902;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=;
 b=a7FVXmcjJMZKVkeWEs+ijwZ5ygvQTSYnPG9tt9u/k5BuXWM364OgXd1CEpaYvojbKY
 q/iQ4q3oyWKTFp/IIcybN7Du4EMQhn1gL8yBj1MuCzuEjG830mVbHH3EYAnMMfF5lMoL
 eiLv+guc6Vsk4oLcOzGx/gmcrhpaAwpgVYd0OxSIbWsOy/jfxQeY1MgLNBbwDKo+02PI
 8i95zkNrgmQHzYzQiprFSCt/flkKzLTbHVgZCLEbqRHNX9//v9Zm91NTMFwV88TnHNec
 CXIszV6vfrh3qB1CSMXB6DolzTetT6QrtEgG06Po4/gqkdZQtl2fi9hbPKbjH5VQCtcH
 yPiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMl7YfG4bo9c/19qCYvOnIxfMk5bNxyWsxVcyu/iMgp4zpUth3uN5k9yijfTB1wZrP/iMQWl8pi6E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYIV8DgTl/ZNNmm30aMpmA8t5vbDG/R8KHsJH3YOxh3LUwM0O2
 BA0/ZDuZDM8uZiixy+kn4s107k3ajDitV3NfkQ4J0yCkQ4vV/WYQ1OYr7i6YkYWy9N6ylUFn4PL
 zd3hMwWh7PePWaszSyJrSgOpcitmGVpOlWADrmpXZuI6uALHPeFi9uh2m8SAhcemcLihH8Zg=
X-Gm-Gg: AfdE7ckAWRG8vVhyjNtH250m+QiugYNdwTeDiF1MAp++Y6aLMlCW0nrtIO0JLRX38Ux
 RUL9CRlwZIQSarjtQrNzYTJQJpJSq6ku6KSElIgLvbYK1dlbnxp6r+G8KZdN0cNMQJLN2XPvotq
 cG9eKtmoflzcN7jRclMCzE/15n8QwOdYgbmHvUx6xQbcprgZ0T1KvFq5/ks6O39wukM5/Ef7fVh
 Sh7yeinDeTlKyQLuKuVNNXB2NgOvBBG73f14E6VQy3JqGZNYy8yeTuTpZaBookoSBF97i944tgp
 k2C5cnqbId2Ee07ztk7DBkZu2zDXvNygsUgR4YlCIgR3truI7PROl6ojrFUM/0R658dWZawtz3s
 yyrh1Kk0kk7EsRdoKAyl7VtbQxI3ZM5DPXu8=
X-Received: by 2002:a17:902:db0b:b0:2c9:a5e9:c26e with SMTP id
 d9443c01a7336-2ccbe6134e8mr22172835ad.13.1783374102115; 
 Mon, 06 Jul 2026 14:41:42 -0700 (PDT)
X-Received: by 2002:a17:902:db0b:b0:2c9:a5e9:c26e with SMTP id
 d9443c01a7336-2ccbe6134e8mr22172395ad.13.1783374101635; 
 Mon, 06 Jul 2026 14:41:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:41:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:25 +0530
Subject: [PATCH v3 7/7] arm64: dts: qcom: kaanapali-qrd: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-7-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=851;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wcNtHiPt37tRcLONgZr/t6X+o8Dp6m14w6rdasOzENQ=;
 b=/vxFPiWhExDAZrwWpa9l5y1Vh5+B3MHCEDcTetW6Rnsi8OF+RTcQYPZQUwPmK0SL7uCCDX+zC
 BZENeY9M3FPA6/x/6kAZHbvTkjGW6EySXdhiV8xYjlk/ovPvpLvmdhJ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX7cv/Uh8rIvBr
 PIUbETemsO6/Yjod4zyV1WAL5LfuKYkICPtVhudvqXTDjif/G+13azO7ey1+8ZdC/E2BwJE4RpR
 wkLsJgiff+r5Apgq4H4usw770KQgkng=
X-Proofpoint-GUID: t0qjjTqBnJfTJ_jlH3PX8PryogmePmc5
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c2116 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ckKq4DLX54o5ySWhiFgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: t0qjjTqBnJfTJ_jlH3PX8PryogmePmc5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfXxcv9pSr/3wzI
 YHN+VEwnXEME8BjVP7vgbvUys57eXRTypv1v7fg8vMZ1Q8R+PvjZsgWaMmOZZ/oPQ9xY+iq8FZ1
 sYZRqs1vFDwqaS0ZdjPjwXhxuPEDTSiyCcyRkibvcAIRumeo3vWmfxylsiguP+C28gVzihGMesH
 27hPFO4g3oOkXA0GKu6EjMPlVH5A0fjSJQ0cPMEeMFLhYht6bVACvawF+RqMHxcknSOgB3II2i3
 +QySpYBpFiL6xumodtGjPYmTGokWqOU5wcCeneM1szhg7XchLQbO+lfbA77mGJgDLwyhokG485H
 9dMLcNG2BDFEtBzBa4aq6h1/nK9KHOj5bKkKt/oo9qB0PxUdqp1PYjJlZZYoX2V20MTkDdsAIVT
 I/zRj8vIN51TFTe2F3Y9S94MMz1IMpamnqOff3ltjjmB+eAhyA8SiAaY/jR/0EGVZkSjs6COne+
 dFC1/wVy3+YQAJt3rsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060218
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
Kaanapali QRD device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
index 55d02219ef4e..6bef8ec151f8 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
@@ -693,6 +693,14 @@ vreg_l7n_3p3: ldo7 {
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
 &pmh0101_flash {
 	status = "okay";
 

-- 
2.54.0

