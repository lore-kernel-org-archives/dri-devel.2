Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D78CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF3510E8FD;
	Mon, 11 May 2026 22:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qp3AwBmV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qoz0WEU+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B624010E90F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6mol3384827
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VT84PwNDUBR/tJKsjUUmdrL7bPcbqpDnJjYc8wbzdjM=; b=Qp3AwBmVkx0EsjJ2
 vKcMSKGExBHgHr1iDbkp2A1IpUs6nUz3FfiGTOBgmHtNM1Tg1F8DP7XEM8p0a/gU
 YRhzibqnFtWGsjOJqAtnanVpzrnyxkGZvCmg8M1vkklyPRA9IQSEKD/MdzUxi9ml
 VWHRLWOaoWSn5wcNZ0ppHQKTBGxBsahdmIB86v/Da/wcCb/1KvaR5upWM7fdx0Pf
 ztgsWUm66qf/OhiCol8ldCwGILEHa5T4gMP9UsZc3j/KSb42PO5UU0GHTrA9IjTG
 7/wupGretjc/9D2mJbyzGEXn+ai/+nDFamh1+NXbt9CJZ4uc36XP7EPzQRiU388r
 Nq6cEA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv4gf0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8354503d9acso5833219b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778538279; x=1779143079;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VT84PwNDUBR/tJKsjUUmdrL7bPcbqpDnJjYc8wbzdjM=;
 b=Qoz0WEU+xSRIAPtNBOSmXfLJTVncaJbTip7OpbcOh06o5N6EDUoY33IIhl3t9LMBGU
 wE3UzbyuO35s1firm5uPVicuyPfaXZ+KzVAcXM2tkF6cl1Xizrv58y9MiXTlmKcx0uuW
 bDxup+zUOH9nm9ehrqXpffcBmZKYgt/afoaIVfEdR9D1/44PWjmq4en+DCIMVAJMlQG1
 l5wVC8VpWIgGhrXVRp9qIqdUB2/DLkNJ4IZMNT5hxdn/LA6U5hsVMLffW1ZBVC9w1nv+
 sRIOpwI91eKXwl5PXwgkw65MzcezoDSR05S+8MRqEaK/3a2WTF5bWj6JKp8CK27ckDTE
 NXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538279; x=1779143079;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VT84PwNDUBR/tJKsjUUmdrL7bPcbqpDnJjYc8wbzdjM=;
 b=Zv2XdH7frth3thRDws6e1MJAGWmkVpLKo/tjKbdCq5HGUxdB842f4+xyPU6sfbAXU8
 WNVw0zPd4s2GHDvq8F7E7EUnH523DAq8M9vb4uBkWH+R2AbUzIF5T27R1mx3QxQ33X4K
 QjD5EChRlXCzlyJ4h3Wn2ko8fJLuU17OvVfWY40HoA3b3dZJxgR0kGIgWHueOLm3qNdy
 TYlgBx4ZhXSXllOnBVhclyZN5YkYRooYRHlAWgqxSb0a3FBQU548iH/PMvuZ1rCMWIL6
 faNWEHvuVoZsUbrhsMjxOQQIog4FEQUsp2USVF7san9Onpbi3yhOrRksWCxOpwreKoeQ
 v/ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rYrH1OPPEBi+DD0FGMcy9l5rtTw7j6aAQD7MLz4kdGOh5YTGEJQdm31EKZc7VXk+3gfTE/06m5iI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFZzgj0eDpx4ykAQIDGcM3LrLCkYVkE4JcF78vyXi6b194I891
 ot/hxEa820A/ja4gxC6E/EkmJwgLLSzHzvHVcLcjZOYi+v+aTTJgiOSUa8OhfMMFCmM6rusEF7z
 6QWFYbo7fiNS9K7rlL3x8Pm3q0VBJUTQoyvdCvYoKSKaXj20jabKwH4WOe3ojR2hsajyQFM0=
X-Gm-Gg: Acq92OE4IX2mUaplYSV19HeO8+jQbDh94P+f/vUqRmnmJ5n/SMEDPa+9lovhG9cGB7f
 L8h8HwV8mItDT75Z1mBh7Cy5YotjhKgL7hbnC6e3L/g4ZoKfvwyH8OFM9sZ4cmCp7Gu5onG/4vF
 5MbulTvpFcNWxJ+pOCl8Edtiv4p0/3seNGlQpmc2FRIKZme4SWAqvi28pw/e5x+5HDdArG4v4Ip
 jLXDS0/ZD/nUqU0AFZn5kzl5vi/Rl7lmN3Y/nCn3T1IRcAYAEQtE0F/iSIlzR/1NZkXYiZ4zN5C
 g2HgpL368Kelg+G/E7Z/BKf8ZOIJujSZWvfWk4G5UHOZklwqh2k/n9kbBfJmY4DRLQAhmLO10hu
 OrYEs1e0hbKpMXghsVmVrAiwll9akPSgbrxQTBu0Mj8NJfA==
X-Received: by 2002:a05:6a00:2c86:b0:83e:c8fb:54df with SMTP id
 d2e1a72fcca58-83eeba03dafmr336267b3a.2.1778538278577; 
 Mon, 11 May 2026 15:24:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:2c86:b0:83e:c8fb:54df with SMTP id
 d2e1a72fcca58-83eeba03dafmr336251b3a.2.1778538278121; 
 Mon, 11 May 2026 15:24:38 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:24:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:22 +0530
Subject: [PATCH 8/8] arm64: dts: qcom: kaanapali-qrd: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=723;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=4TwFG6GQ2rWfxHvno6AGnLKMEMKg94Z6yrhbxek//KE=;
 b=waPfCkFYB6eDvZNGEFJsUZ4feqP4qBVshCQMu58SBRIUoShOVQKU1ivqUXVi57+d8FACeeVYb
 q0ZLr2DHU5jAOh82UtRnGExYjXfoo+hpAyQ8b0CbMm6Im6ysoGaandY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=ZrTd7d7G c=1 sm=1 tr=0 ts=6a025727 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=tTGeZ2WnJxbZjfYJna4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX6PQfT+KpTgUx
 f0Vfm1LH3UEyvxLid4Fr/drvKI+1M2Ff7DTT69KWG2fxS/O6g0J3p2e4BmVXskqMbfA3HgXf2vL
 BqaUytnGuGvUm98lSF/8KyR/wZHCMu3MvBEo+eLto9JtesvKvjMEBtRYTqL7X+KXGxrezQZqFFg
 sAfhqzWW7K+FGvXWMsyxE/6YyzYAZULSMUrmYQT/4k7qwjrvRLYx96mAI8aAEbyQiGGYZF4vcuC
 R5H3QYxnZKgR4qXRRtbH0jvn7YaZFJZ/z/6FjYVH3yzn7GMPTE9PEafL8elQR8yHWZH4d1zBP9g
 PdG0g4PVMOG8VUSGDoESw0IewF/jX+fZ31IC+MyJiRsWGimjghEnypbyOMNiec70lhdkoDC1iCi
 LE0gR3GJ4J9IO3xBOiFb9L9a0odjzfurcKuJ64+JYdIdk8FwuPliFjlB9hlqwzJKjAnPCaaacKY
 or6Jby1PU+haGO85blQ==
X-Proofpoint-ORIG-GUID: aktQ39ggxviW4Rlf2KzZY7IYeC_pR2mD
X-Proofpoint-GUID: aktQ39ggxviW4Rlf2KzZY7IYeC_pR2mD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605110236
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
2.51.0

