Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96364606A339
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N3Y7bnYm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+47JTY1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038D910F0F8;
	Mon,  9 Nov 2026 08:37:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AD010F0E1
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:36:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96A51i3611249
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 08:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QlQZJAxO1Sv3Et4pFgTum0IApIio5YpzXsMhTuabOKQ=; b=N3Y7bnYmtQ3Oupim
 X6wMIAQC9ZhmqQ2Vgg5pOkd9Ue88q1gu7WSF27cAZn6es+NQy1F1zq1MoI0glqm6
 zomiTk0bctP63LVEttJtm8q+FUGy/U5qfkcUYU3NxRYP6S1oVF0202kabQNf4fAd
 YsrUPypXSYSVBMuRvQRDHOM96J6GcRsT+D0rzS94mlqp3CSkMhf+45DDML5fuPE+
 xDANDXOpZ5TwzJLj2kMhExBY5tJr3axj3FhY+kjaNjuBeCcudopOoHM7Yq7hkIdf
 hmgcsOf7417/oBluY/Fav5uV10xKaKcuv1z5prJR3TMZkLzHIsoA/plVdh1umch1
 blEqhg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hssbnwvkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:36:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2c0e6653so121215085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 00:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794213415; x=1794818215;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QlQZJAxO1Sv3Et4pFgTum0IApIio5YpzXsMhTuabOKQ=;
 b=Q+47JTY1WBAn4Ldg5X/wmHo1IwXvTgWMp32g/KPzB/9o6vdBBjhp+6vI4swIiQ5ge5
 R1R2WiUt0NpE1C+DDQrG1qyi3uUPOVDe9tZSykp3o2Wca4V1rZJPPOIj4TRMUEFPJPAj
 cgRhYJBSUbpr4qp0Q+c4IZQ+cdvRTBop1rdyJDbS2/mM6Iq5yxqiNExxkuZl34IxMPcE
 ZD+WYYPJbXbMqDIjFW63Dbs06Cb6Wqy0Q/KBu2ySB0uEYt+e+kk3NymOCztKzHev7b82
 55UMpCbBb1RHtQD8SwRSdrGEIMRRv9G3z1RleC75W5Mxs/Ou+EY6FZ2A2pvXHxLmI1fM
 e8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794213415; x=1794818215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QlQZJAxO1Sv3Et4pFgTum0IApIio5YpzXsMhTuabOKQ=;
 b=wMdCshmzfEtCXMs16HiMLZNzryS/764Hq2aMV34NoadXOBRhYsXMWZqOrwKmQ3Zmue
 cCv7O7VRh1T2oiQV+5tutmPimpptdLBFDdL9EqWQOYB8+jNrMDptquH5nvqZk++9f5uD
 AQg3/OPhYzVVOeRP3H0kJnzV4WUjsTygKuPkZgnNdJ+BC7Wo9aauG9WaH6SWASRhAj6M
 IwhJX/9qaJriTceFWjMZCpafpL86umlpYlRYIziYAthdgmDdBuK4mBH9BWg7cCW8jFYd
 ShNTDgMJI2RvX+CYN7E4okz90xc4wEy5CM2O2tBYqXES5bge1YK0ASNVaQs2xEEuZUJP
 K4FQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEk+mj6s8Rdnwl6XJwqedtoG9wMNkSJe4h7h05lBKJXn4Xlr2NJHTQUzsREqjDgLYxXZSsU7Zc7yMQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RMZ5od7HM1WkWMVqpZMy2xitetyRXp1DLqAaoX1mtZQF/eZXE
 IBwATIrPvopfh09tEq6ANd3QW2hk8NS5MwkTuNcE9F4/PMqLddU8obYY5Mq22qXmADk8r+3fa4I
 YyE0wudURUNmXFATpjtsL8prY05kZUr6tweVcMCsp4rneriP2FESB45S+iInH42qsVrNnyqE=
X-Gm-Gg: AYBFou2QVndFkl29/S7jhiuxFJApD+a11zW9WN8oUG/Y8LPY4fqkXvWogRs/Tlh+Wdu
 lZXTa8/z4sBZoxTJ4QShH/Wk/Kn8FKAK5eurLgHxRUqidSrYDZwCeQpjBywQWu5+sACwee3Povg
 xMIqIMEt0gX0FhP0lteExSYdCmzzwbHG/4kwXjHrh0gS21Butr/GM6Tf0zQfpZvzMTEXBJFfn0c
 2vVwEgZ9jpGSnSM7ySAAz/TMeMbtYm8LXTgoHFOaS2lCXE4Cu+XN2jVzqsCvo+l8mZaXJ/0hF+Z
 rR9YDhBpNEOiO8ySlMKppeg/EsMsTzL8bIrWUJxkleVQ59dKAUV3FFkXpJPQnnjeGY4I1/EBdV7
 d7pPZl5xxE05hCXb5+ktgUol9osrJJlzmPiN/JHbSQAM1+cFVup1Slg1drj+GovTJbTmgG6kkh6
 +UpRm5osPN5qpw6NMcVbCc2b1e13tm9gMnKEU=
X-Received: by 2002:a05:620a:1a0b:b0:92e:8310:7369 with SMTP id
 af79cd13be357-9478421ae5amr531301185a.37.1794213415090; 
 Mon, 09 Nov 2026 00:36:55 -0800 (PST)
X-Received: by 2002:a05:620a:1a0b:b0:92e:8310:7369 with SMTP id
 af79cd13be357-9478421ae5amr531297785a.37.1794213414549; 
 Mon, 09 Nov 2026 00:36:54 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94782dc37e5sm418223385a.34.2026.11.09.00.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:36:54 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 16:36:35 +0800
Subject: [PATCH v5 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-msm_gdsc2-v5-1-4a3159b5e4b8@oss.qualcomm.com>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
In-Reply-To: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794213397; l=9906;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=KfdZuvSWZwaiZF24JN3cwwsiGYbigawCngmZ1N3bIwk=;
 b=Nc95XLCZD9zVCjX6yjrNsRLKMzLVQWzGQwcdEVklh2PVV1dWQE8tkYFqLsBiLYffuqy+eBoiO
 Qo574qgDzc6B/8E5IZSJmNZtpreMEgDZ0XeroWGSRmFsou/725vVma2
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: lM2NzBLXjqZZhWxIakBOeVAGQqMEBu-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX+zDqekK4VzNy
 lEGuzIl4uBtJiptKvhO6b5qy1uhmZoei993qYqEWw3fBTTeOQZCNCrul6myyo7Z5B7xigXpx3RY
 275T9zdESfT7FK0VGOatqP0xmbyvSFLE3b8WAJjnAUKiaVvC4fe/JlokkIiVbYVjzeiHj/O/Mof
 XpezJuH2H6fxomjVgcKOxK3JYIOoi0BJAkKsOvDZdZfCFnGebz8kP99LPKLkbyFVJV/6MjcPW9J
 X/7Z1bUiEKJTds4CuIbG1ASGyit6y4jGB+b2xurBK40VZlKC6bmOxphxkic3UKGU8WEWO6u/B8Z
 bWKis7yfh3vgVslVwQ79IinVHOGF5RYCS1m+MntQOQJb6zhoJBiJxHadL7ygYmTAYkzOCIpPnSo
 AplMPYLucb17yO8zZBM8fEZyjGsn5SUKvvgsdBvWAUDXxenVpQfr+UkQa5gDGwkLR1MUt4QJ7Kn
 aeUO5QhLVj4IO4esPFw==
X-Proofpoint-ORIG-GUID: lM2NzBLXjqZZhWxIakBOeVAGQqMEBu-6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfXysfNVihUmtWw
 JmOSzDRxiVciyaTnboCiuplIArG3Ra+XAEoV7GpOe3zs/lz43AIAnJ/MX0r11ny2OKBTKrc7yea
 5lmYFge0eZHssELFI2Nx3ritUgVWEMs=
X-Authority-Analysis: v=2.4 cv=JtBkP84C c=1 sm=1 tr=0 ts=6af18628 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=3e6MG95HUu93SJj1PsAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090034
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kaanapali (SM8850) has two display GDSCs. CORE_GDSC supplies shared
MDSS hardware and most of the DPU, while INT2 GDSC supplies the
VIG2/VIG3/DMA5 source pipes. Without INT2 GDSC, these source pipes
remain inaccessible.

Describe CORE and INT2 as power domains of the DPU device, matching
the hardware partitioning. INT2 only supplies DPU-local source pipes,
while CORE also remains attached to the parent MDSS device because it
supplies shared MDSS hardware. DPU performance-state votes on CORE are
propagated through the genpd hierarchy to its parent MMCX domain.

Keep the widest valid power-domain constraint in dpu-common.yaml and
narrow it in each platform-specific binding. Require two domains and
their names for Kaanapali, while retaining the existing single-domain
constraint for all other DPU platforms.

Repeat power-domains in qcom,sm8650-dpu.yaml because dtschema requires
power-domain-names to have a power-domains sibling in the same file.

Tested-by: Joonhoe Kim <26rote@gmail.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/dpu-common.yaml           |  3 +-
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 ++-
 .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sc8180x-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm6115-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm7150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm8150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 34 ++++++++++++++++++++++
 13 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
index 3f953aa5e6949..c67199011f263 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
@@ -26,7 +26,8 @@ properties:
     maxItems: 1
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   operating-points-v2: true
   opp-table:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
index 9f935defd6b12..6d6391970d6b6 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
@@ -125,7 +125,9 @@ examples:
 
             operating-points-v2 = <&mdp_opp_table>;
 
-            power-domains = <&rpmhpd RPMHPD_MMCX>;
+            power-domains = <&mdss_gdsc>,
+                            <&mdss_int2_gdsc>;
+            power-domain-names = "core", "int2";
 
             ports {
                 #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
index d5a64c8a921f1..bded43a34b87d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,msm8998-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index 034d3df8d2470..6c1476a0faaf5 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -19,6 +19,9 @@ properties:
           - const: qcom,shikra-dpu
           - const: qcom,qcm2290-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
index 8137618237ce7..3fa0f02f44892 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
@@ -19,6 +19,9 @@ properties:
       - qcom,sm6350-dpu
       - qcom,sm6375-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
index df9ec15ad6c3c..7703d9b017cfc 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
@@ -24,6 +24,9 @@ properties:
       - qcom,sm8450-dpu
       - qcom,sm8550-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
index a411126708b80..8e10f9e0d1769 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sc8180x-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
index dc11fd421a27f..9dafe1d827e13 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
@@ -17,6 +17,9 @@ properties:
       - qcom,sdm670-dpu
       - qcom,sdm845-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
index 510eb6c193649..173c2f034241c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sm6115-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: MDP register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
index 8cbf99f9fcba5..b8344ff8895ac 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
@@ -16,6 +16,9 @@ properties:
   compatible:
     const: qcom,sm6150-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
index c79b2d4428003..8e50942f3e1f2 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sm7150-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
index a88d22f30a602..b407bc3994620 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
@@ -17,6 +17,9 @@ properties:
       - qcom,sm8150-dpu
       - qcom,sm8250-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index aa0cf0ec5b93f..c3bf4e7ca1ffe 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -54,6 +54,15 @@ properties:
       - const: core
       - const: vsync
 
+  power-domains:
+    minItems: 1
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: core
+      - const: int2
+
 required:
   - compatible
   - reg
@@ -61,6 +70,31 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kaanapali-dpu
+      required:
+        - compatible
+    then:
+      properties:
+        power-domains:
+          minItems: 2
+
+        power-domain-names:
+          minItems: 2
+
+      required:
+        - power-domain-names
+    else:
+      properties:
+        power-domains:
+          maxItems: 1
+
+        power-domain-names: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0

