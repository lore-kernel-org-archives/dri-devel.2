Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8070BC982E3
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9DA10F321;
	Fri, 18 Sep 2026 12:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XPcEpqq6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wey7spR7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D02910F311
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I9eEPc522593
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cI6VxWcYdbS
 4q6nuRTLojc583CcZ2sDeX8I9vTB+9wQ=; b=XPcEpqq6twBEgiKWUqnDAa9d/KL
 E6JaXi6/w6x+P65QAhC3by8n0Faf114Eemv0MxQFZrdAVJvrmib7e0LSLNQBeXWz
 pe+KH/Eb0f9KIY3Hj8JZ5Wx4+/GnGhwWLnPYBpiQau1yTEAwYoCyNk1kt5gnhCD2
 a1rf7gwPPGG1aJjwkDNWJy6rbY2YN2hwUu1yA1wW4myx4Uw2HN9iKS/ZJqP5IkH9
 JPiSMERaVoajvkpPfucCF1HKKpwNj3dO7Yhl/eaEBzx/4lBzZYi7/JE4qaIL3gYd
 TYy91Ow84IHDyrlrR/hMCR/5fLPEO3rFHK1k0xgkRoshJDYBSQyPJQlxGiw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grnqebt64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:35 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c851df59edso162126e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789733135; x=1790337935;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cI6VxWcYdbS4q6nuRTLojc583CcZ2sDeX8I9vTB+9wQ=;
 b=Wey7spR7CIy38OY80pAuPItb74X7ai5o+f3JAS+MUbivTdmdewUhkhc4qljLGMGPeE
 NTSIpFPjAr6mt0viUKCtx/2Q/8mjoZXmfnNe4wvu4fFnE105DD3Vk8KS/DbMVcxYC2wG
 i29Q/SQXY/mqT0qdsp0BxKNe/T6J8jE7Y2wqLRKR8aIwtNyKjEJrsGbH2iT6b5NcuHOC
 F1Sk3Iv2YhWv7H1zZsJbD95Rzzmd9ESdtnZd8hhA+RSMsHRJA/V7HQAt//Cpwb8nQCu3
 lUXY4dS8vXbKWCxL3yfwTz/ePmheB85kDx6gYX7DFPIORCedFpPZ2RjPF9x/6VTWtbnS
 rSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733135; x=1790337935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cI6VxWcYdbS4q6nuRTLojc583CcZ2sDeX8I9vTB+9wQ=;
 b=ZISBfnkj1++j68vV7ZUeVUzzIYwdQWSER/X7YyhNYCmg9fwyE79U6gwSNG58NG0Dvh
 /7eaPibS3RZdp4Bb/lWHEzoxrbs/wiEavcKKXwF/Vvm4CcDuEENTHU5ZTd5kvS/JOq4n
 FmX08fhQpSeHF4s4FWEm5UjNmpgLUgH5Y4nyBWPSHe/wym/7If2oaOHDsQcLHH1t2W5s
 CwYPn98F7gVkWM8iHm4O0sxqhIYeWT15FQibPQbOXBYa5A39b4eIhT+FJC20kYF5rGzg
 ZexZhKQL+htQZquGZFYAF4GREwX74Xtv//pXUQY3WVBSkw92+/f/fggfjbvVZrpAby6W
 ghfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwlDO0Ql0K3vQV6dLqeG6x5CRWp/RUM2nvjNngp2C9ZlSRAxQ91QwhSjx4GkKiaurZKj8B4jTzc1E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMB/8ho6B6ZQM/s3O3A00dHM7kjBUW4TPMv4PHhNAHcqRzdn5r
 2pfNDIgeox6tUGjBQIVUjRv2QRDS45hdOTvbQAxRda54viH7Udo9QC+F8L5nHQ6LMobnSvx5mQY
 gTJx979RjUDbfqchnjal5nkG97J28jiCGyfJCAQ748P7DGJcv6dvuypz4QW69GXAsdLRtVCQ=
X-Gm-Gg: AYBFou0ansf502YbqKXtKF/yvFBnmo42tnpfVT3tXMsYgt9tT+h2Qn0ed6vuTTRKTui
 70KTRBjPGQAtriy2gEA+s5ZkDEllRlh9gWdKlWTVdsEoIZtmo7BD6A5KsBe+erU1hzmynuxDEuO
 7e/RJw9vHAeqVHWpnp+nazdCTumE1e9BK73iniDieFHHNfhlLW2fL98uWc9O9+etCr4D/8U/oza
 Mkisn+nFqQp7GyErnuVe+JiM1m8P0179Fl/lha2LQKB4cRGQqJMuv+cCnPVRn/c1MZ+vJ0TV4qJ
 msOu54xkm/9movOdk1Lm7E1yhaD/TpK5XUrL18ahEukPYvn0l9LIeovjEz/AL8Xsi4teQiClvTF
 tPNahJwtviKPkaQ==
X-Received: by 2002:a05:6122:1822:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5c9b59cc79bmr888367e0c.14.1789733134640; 
 Fri, 18 Sep 2026 05:05:34 -0700 (PDT)
X-Received: by 2002:a05:6122:1822:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5c9b59cc79bmr888323e0c.14.1789733134156; 
 Fri, 18 Sep 2026 05:05:34 -0700 (PDT)
Received: from debian ([5.133.47.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff3ae49sm3917584f8f.10.2026.09.18.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:05:33 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom: add Lenovo ThinkPad T14s Gen 7
 (Mahua)
Date: Fri, 18 Sep 2026 13:05:13 +0100
Message-ID: <20260918120515.595782-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UOqjXGKGoKEc6A1NQK5hgoq38PuKkwpj
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6aad290f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=MSM6P-WPhp0LPykjVWQA:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: UOqjXGKGoKEc6A1NQK5hgoq38PuKkwpj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE3MCBTYWx0ZWRfX2HKga/GKG488
 V2NHYSv0z3PtxJmgLOjImduPq5hRE/PkjOMfKA72NPZlDTsW/Tt2uepGELxcamR5/jP8LYEt4Qm
 hNXGyfiRx9j6/apgPwQ6bjUj40SO+8e+7Fd92zjKWN6nw/9+ydDj3Yy35NbAMAx70xjLxQO84YA
 C8YmPH47seYkAxt/PkYjzra32tnQArRN+nJy8rCkCFWOK1E3J7RTmRc26yc7Tv4J6HpC8BlPnGo
 vQvvsJ7xDKIzxbpzB3rBvfSLrlZsr3t/xXSC+TpTFrGRu7sxJg+6xLpjGwgmIObQ3vFoyA9rbvZ
 dDR1nNifMzAyye+e0E7cugIYIcF1KQ52gTl2tnXjTgdGtXO2UmhyVoJdVHcrynm3Ar08kxicm2w
 i8m1iA3CcgUwjXVGEkK//je1YThP7hVuEWa9FfQ4o10wRPNL79tsRyroVDQx7UjQzuYB6vKzGhR
 MiaJqk+qZ7C9bIbRFGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE3MCBTYWx0ZWRfX9ZjoPhPda18S
 I67RSn/vSBORGdKD4ieantLI5hw9EvhiQlLPZRyYfGP0vV+v2FjPXkI3t4oqkRM2VlFuddY5sdX
 BPmQsCNla/GAMZW75ZPDz7T8jt9Da0Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180170
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

Add lenovo,thinkpad-t14s-gen7 as a board compatible under qcom,mahua.
The T14s Gen 7 uses the Mahua SoC (a 12-core variant of Glymur with
cluster2 / cpu12-cpu17 fused off) rather than Glymur proper, matching
what the platform's ACPI MADT dump reports (12 enabled + 6 disabled
processors).

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index cf9d940f7371..92326e0e7feb 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -188,6 +188,13 @@ properties:
               - qcom,mahua-crd
           - const: qcom,mahua
 
+      - items:
+          - enum:
+              - lenovo,thinkpad-t14s-gen7-lcd
+              - lenovo,thinkpad-t14s-gen7-oled
+          - const: lenovo,thinkpad-t14s-gen7
+          - const: qcom,mahua
+
       - description: Sierra Wireless MangOH Green with WP8548 Module
         items:
           - const: swir,mangoh-green-wp8548
-- 
2.53.0

