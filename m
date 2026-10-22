Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8360A2607
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AbXPla0A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aj5G4KeF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7C3112480;
	Thu, 22 Oct 2026 09:50:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA92911247A
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M701SJ2714245
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dnWRkXpHDUV/iq5zv2EkNTP0NIBqskKv9yRVf0xDCaw=; b=AbXPla0AkEHYbGxb
 OtMj/fQ/ZX2XeVwGNsyn4zdC1u5ODfSLmejfHwDj24HV1jeRxjB49jrugb4ckTCl
 rHRtmK3VYImSrD2oN1zxhiZsd9/s6SCvxvtAUh4NU3jvfc29dm5WOql1NSuVj60Q
 VLGdxU6vMwpifPZPK2HCsoTfbB4Z862NrISLeKW+BPRhN3qPkUcIEqot7KT1QMAD
 GGu3GHT9z0c6+3Hi2jX+Tcj9F0jqeXwGminVTrlH+S6aAutNxeUyXg5HMVh8csTo
 /c48n5M9bA833A/8fieLN3X35L0jJl0Bge/X+xpPaxiGonFUNKjn40SfOqJaQMuI
 NfWIpw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bsrnb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3692c5b061bso962650eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792662609; x=1793267409;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dnWRkXpHDUV/iq5zv2EkNTP0NIBqskKv9yRVf0xDCaw=;
 b=aj5G4KeF7XpjH1SqyMAhqazyiQxT8bINtNy91c9NLsZ2X+E1qMkL3/0AZ8dAoLHkJu
 IYc+OuHJm5NG3qdRHyhZ6+/BW64Ejq3h6sG7EN6K5wt/JvTnyyRTM5TBoww3iktUBVve
 KUJV477ofkuhVEl/SRI+q8gmnK0US05gunZ0Km7QZ70DJ0dCr/I3IVxrwVX3dinv9HBO
 /qvFxWe+MZtyjAn6u/tE5fe6QR33z1qDh+UzP0FUCRwt+F1SDRhjLtumaqC2+1BYdGcL
 e9auSCZ0WtSm6Fj7GeFp8wo2X0TZrDm15IB/Z5W/cnMw9CCdQG017yrprq19QGtni2TA
 ENcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792662609; x=1793267409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dnWRkXpHDUV/iq5zv2EkNTP0NIBqskKv9yRVf0xDCaw=;
 b=0ItgbYLSZ82K7hgJS2/BpdC8aAADcL0ye/v0fXleWfff6GeZuvEhqjrBIkyojohzql
 OSuAb5s/1BZj2Xi6y8uGQcg8bf/oL9s6cqmhmaDbUNPPPAjVPmuqhpIbfID3fBq/uNCL
 1257zA9Wztfkbxp73N62UVDDyLG+fvVDoR2vEiX9Vr+aCBvoycK3FPXuyT49nK1/4Mtd
 udTHmFXnLEbGqxLoEd3/dqiLt56W2J3JnalJbjpIRw9zhvPguF4HwhXsArwkzBWCoX4k
 dcBc3eoHWJ4xhk8mqOjNQCTJIAGw3WiYGKF9VOSyz1ZXF2cch+rImeW1QZnXhXZ/FrVl
 qdFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzArICW1SqaTmPXuF+cm9MXJ3rK1k6wUR2yOIXCds2NL3FyzDv5QLt0YBH1IMU0MtS1A0M2ChqlFwQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJEbAnuoMrnemgV0kqhVdfZvQIWE9LXlka2pc5dnec2b9YymfHC
 U1MPqS7RseITpHndX8HMWNnZnvWpMI9FretDEOv0rFWFGCBeUkzXh+pusv7QqOY+Angz4D2ra5M
 HdpdwvsTlvD0aLY0ilFa9AQXKmbpbqIoWmN1I/UaUjqq0geGLtNw9+jfs2sfZhhYbt1n/gDQ=
X-Gm-Gg: AYBFou0cCFM8eN3HP9a3sCVXMx4wJFTuSD79Iy/s4Aq+5U51SZDt7ZpDNhjovCn1VZi
 NPpT8EniXwnRy/cZasIHeX49xmpKKSl3yefx6Uhn52Uk8XyYQm1ZeBy/eabZCkcDEsmEXTCSrNm
 3aUKfkJR5Jk5w56x86ZW2G7gOGigyqyIXHcXjW+g4PbOXnSu3Kenp3MIaIdWOQXoVxJ+umjwdHK
 Tmk6pRUP9YgmiF2hdMEKWORGEYHi3NFRSQvclJHfrcL2NWTixUzAyBtsjWzUWjvuwgKs/fBbsV4
 NnbOAfbw34KMi6eLOims9l0rfxnhj8qB+hCMFwCzgP7AFQaFZxTs4h8tx7CTEljDfKog/5IuqHq
 PtxnnmAlsyWJwvXeQkq5/RVROAkFNgoy9OCw=
X-Received: by 2002:a05:693c:414b:10b0:360:5f7e:2eb9 with SMTP id
 5a478bee46e88-3674ff008ffmr6968375eec.32.1792662609437; 
 Thu, 22 Oct 2026 02:50:09 -0700 (PDT)
X-Received: by 2002:a05:693c:414b:10b0:360:5f7e:2eb9 with SMTP id
 5a478bee46e88-3674ff008ffmr6968325eec.32.1792662608877; 
 Thu, 22 Oct 2026 02:50:08 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367417a2fadsm14418035eec.21.2026.10.22.02.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:50:08 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:19:42 +0530
Subject: [PATCH v3 1/5] dt-bindings: display/msm: dp-controller: Document
 Kaanapali
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-kaanapali_dp-v3-1-b5ae8e6083c3@oss.qualcomm.com>
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
In-Reply-To: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792662591; l=1990;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=gFpmXsiRDLU1j4jPsZHAla7qt4QGjHqNVO9ALlnOzsc=;
 b=97hfX5kyCQXb5TRjlzEy6alGk4pMuHZazh7cCYnWQ/zPZQo/65Uck0Tbax8iowk6/bE5tISAl
 rH73MZ9wRI8AWLCySmVAhq8+krivvAC8Zo6YS/NcF9mJmASkt1UH34D
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-GUID: 9mjc7Oltdh7731reEmFmnxCU719bSNTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX0zNq8owBRp44
 Sh8ji/NfBY02jxH4hJZ205iQHw9bRHSjow2QMy5mlN7R8PJGK+Y56n2MhTQzVzwseTlromnaRay
 vum1xtTtAXGYpUlZAEhSRfEGKxlWEG7d4d9Mjihov667VHPSIkrRvrkQh3EQI+V/SMbiTHsgBxH
 zvNC3DkMkEFvvJU24oOw/J1z6G4YxX1J3xfhe+5qQhwMkGY9PGT+6REzk8gND4noj4tbXmBli4O
 Hz6+tXBPk+4PUfa5jvFc2psKlwMPbMjp0VD1NoxaxArC7gI9L3YeGTkyIkgWw0Dy3hQH43VzgoP
 pL1NMqDUwtDn2EEjy/IMrVUhWI1JianHFX/IUbnTyGEoFr/XZhrpHe0sSDJYie+SS3feXS1qxJz
 nUYq+UkG786TgDdKcdvk6srlqEaQGkz7YnArnZZu0jkAzzeHAHZFuL8OdEAXz1uSnJsUhLEwmrM
 YKEgre2NWAWBn8AIRfg==
X-Authority-Analysis: v=2.4 cv=HJxWhYtv c=1 sm=1 tr=0 ts=6ad9dc52 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=vzAMpc0yBbT7bysrcb0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfXznbNz5GOw7p4
 D6v9KKdWTBYCwtm2cvht5OlFup6eaU5TnDXsIJ0ZDTRgv+BdCMRJWeJH6LVk29gsUpYPCxM0jSE
 eOiLQmLZwHyI5ihjnSZOWQzs1zBLOes=
X-Proofpoint-ORIG-GUID: 9mjc7Oltdh7731reEmFmnxCU719bSNTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220039
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

Document the DisplayPort controller on Qualcomm Kaanapali.

Kaanapali uses its own DP compatible string and has a resource
layout with five register ranges and six clocks. Add SoC-specific
constraints for those resource counts.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml   | 2 ++
 .../devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml       | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 094a6383bb77..63e1b515a355 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-dp
+          - qcom,kaanapali-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -275,6 +276,7 @@ allOf:
           contains:
             # 2 streams MST
             enum:
+              - qcom,kaanapali-dp
               - qcom,sc8180x-dp
               - qcom,sdm845-dp
               - qcom,sm8350-dp
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
index 9f935defd6b1..b4851d1d48ea 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
@@ -48,6 +48,13 @@ patternProperties:
       compatible:
         const: qcom,kaanapali-dpu
 
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,kaanapali-dp
+
   "^dsi@[0-9a-f]+$":
     type: object
     additionalProperties: true

-- 
2.34.1

