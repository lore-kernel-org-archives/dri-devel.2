Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F390AC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000B110F7F2;
	Tue, 15 Sep 2026 09:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C4rkHS2/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dkyu7LM0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDD210FAA3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:10 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F6ZTNI3316452
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sOD1KP36pobZqUuAtEcmWFCfB4SqMaD8dO+mChPrfyQ=; b=C4rkHS2/MXlMdPl4
 M4VSG2VHUr4+i011eQzf8MREF5vSksrICKXIbmOEyFD7xxZIsBztCz3jLq3k8mN7
 qHs6wMKTq5yeE+7CSfOgEiADryjKMnSvnOujDKwPCI+GSfnGZrPD3vdtjRVujxRK
 JG3orhmTG7rKduEskWPAdlR+jS+neAKQuzESvARDOCr/yyLFD4S1hCq2RptKEZyL
 QUyKjmSbRNCOm0gCK8JKskOFzG2MIq6UZYG1xBEVYdP3+IpZ0zsovbloMQROq/BH
 ZArrF8zh1hrhCXTBdjHp+GliYIsVlxU/L3fIH0VCQfsNizrUG7G47NQgkIf4BUB8
 Suu3mQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux0ypq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-530e5b709b1so61851441cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789464488; x=1790069288;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sOD1KP36pobZqUuAtEcmWFCfB4SqMaD8dO+mChPrfyQ=;
 b=Dkyu7LM0ul92XCXdprQV8y+6Yi9PtaL1CsjhlvpHibLIigtcJhU8tcWMY8dqu/RCkL
 QHDQY+l6h/ZFHENwXQRZB+PCHWCFzk4sbqv2H250sMG3ZKntA6E+XyuFPeE9ucMaTd3h
 xKwv/Y073L+GofZtXWMMaKRQHXTgScmkvbdNTnCRPKE3iC9Vg2XkhhvdWdktKLmrHIXl
 W8udvm863xVx5C/4++pzJTG3bWVFZJ97AWuGdZ2MwQviZjGAtOaiN4qGg51urg/pfOP2
 b48Mn9ZDUsjUB67Y/RAmrkARUQTqngHov6g/R+4GzakTfpSNMGuxJ78wWSbBh9wJqcHH
 0pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464488; x=1790069288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sOD1KP36pobZqUuAtEcmWFCfB4SqMaD8dO+mChPrfyQ=;
 b=aXSTKh5LjUmW40fLpx8wLJZGi3ghgYfYP7L8s+Sr8XtkZWNB8ls6jng55gwHQ4s5FL
 V7lOsrmWskBxUGFeGL7z8gJVmLjNJjLf9T2pjFJv2UVymguuM3LvDC9cIe0ZRvLdhxHp
 CVh9gMISB2yNHlagroEF224OFQsHAgVQpYNk4mhn6iqM0sehtOOpySW6G3Aj7gGZNvU7
 lTpONhCH+2tv78XkQ4NR5BNFaiYPFPM/SLPd2JfKCVKPBVQAe6S/d5ODOFWvwpcZbf9y
 3pwhb8KRMKmYOQlWCv3oQAoUvc3t7W910K2jksNCa8Y47BfamRlQ7/um+Ckj3BWu8Cqf
 wpIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjcVJZBALnjoS8FJgh9nH44b0/ul8wIN6dEqRok/dSRXVXaz3ZuGh/xM776WJctBTXJsNsZuyuxr8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kxpdxvZwHz3MRCOu6jFYPzgB0lSitgfQbeyULoSi7y6cAv6Ifa
 40r87+Fe+guNr9bJa48XQmITw3W5GwAIqNelvyLz1ZGds0GZWQlGvXODeubr5aVQ7dwT0gQA3C6
 Mpr2jol75C1MBARMIHnTGlKlWOj3DGtz87psmuzq13yKxU8cndOZUWVi7w5GlcmycsT5KF8Q=
X-Gm-Gg: AYBFou2RKCqhDUPcXbUJEa9JpAf94pE+XVDGaUdDMUHIRcRPTprbj+Fwae52krLITwf
 RmXGfcT+Nv8dFmr0PRLFJcr8UjVhIVcsIIH2qlwGsAjqlE3qxgiKY2qiLJswW01h3Hhu+HRkHCr
 e6Cp0KKxXMQOG4tM3X4oUMHyRoIexb1mzFPfBf7vj86lf5+rnuL89wHoTA7TJOPra/K+LbYMIQr
 YCmSLG1hQIAhA+duESKM22c4H4EtW9vtzKLIqvnjU/UW58UCQGjwp5nFczOVIvmFayPVxBL2hNq
 ubBQ87L0CMzR+Jw4TkhbRR48o4BY7GI2307wwgwJGHHMUlJpOIXCRPreStgZCNM77MzCQz2LXDY
 hCc82yiERa47IRwH2GnmdADvHFsV8uCJz8AzdLNlFZypFnduQhbhjCA4aWOp64s8=
X-Received: by 2002:a05:620a:460f:b0:93a:e8b:2df0 with SMTP id
 af79cd13be357-93a299efe8emr946843385a.40.1789464488380; 
 Tue, 15 Sep 2026 02:28:08 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:93a:e8b:2df0 with SMTP id
 af79cd13be357-93a299efe8emr946839385a.40.1789464487826; 
 Tue, 15 Sep 2026 02:28:07 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93a3f467566sm18939785a.39.2026.09.15.02.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:28:07 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 17:27:48 +0800
Subject: [PATCH v2 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
In-Reply-To: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789464471; l=2699;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=TX4jqPBLlu4A2aYFMXqYAcpyR7z5nFViS5MfFWhFt3A=;
 b=ccj30gophPm075i6Y68UPWPfvwlgy2kmluX43cL4bGo28OMdYsKYhTip3oPMJG4Vzb19Q3NIY
 7imkjaOrf96Dw5N/3TJKbl1cpR/bZ+4iE7UR0/58HmUzrgEskLnqoyW
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEzNSBTYWx0ZWRfX89hO8KHgkhDe
 GEbQbV2fd1KqzFuOFtInXSpQfh1UgKe6D1EuwjWa93GnzVoNzpl2v/H7yY6pAvibfnlmhCMeoed
 2tOdc+EyDfloiS961mpMV/UmA4WmZV0K6xybal8a1Wd6oo9tg8MNTnhRZU8w+DcwsBFVfG2DhYL
 vU1K7Lv5yp2keg1LaiZI48i3Sffw7Kn0icmLnolkdgNc3VsnIXrzajlkK8bGhB8Zi9NwRxtSEYh
 FPg5H8gA/1JkNG/vvaXv4mijBq5PM2zKzRhAbYqRtipZ90GtYQspbOLnyW06KrcQzuWrOubdYRF
 Bmsr8NvsuyapgIt776lGkqCcxM1gBdqXcVZMI5sfWUON2E6zkEkM1kibCNAYCKI3evwYWoj+25W
 3sgNh6enWdFcYhmE1owWKl5swYqrk6uruhyTrfNi6RO/Yzo1oSB1Mx02zODJsW+Xx8JNKRbw97s
 GByhK89G5IZZpmVDbew==
X-Proofpoint-ORIG-GUID: 1F0dz9-cEjHvZwenLzufNmjZ1tj4ETWJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEzNSBTYWx0ZWRfX0BqnMGytpPTl
 n40aK66g2IlI7k31HVEQJfvBF/U2R+PpMf9zAYbrtuKRGGwbDOSc6NiHK6i05GRKvkIDMj/1fOi
 XVNvYqCtZ1FSGiIcPE6eaq2GRx21hHA=
X-Proofpoint-GUID: 1F0dz9-cEjHvZwenLzufNmjZ1tj4ETWJ
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa90fa9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ObFffn2ZCBQ8pwh_5TYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150135
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

Kaanapali (SM8850) has an additional INT2 GDSC that powers a subset
of the DPU source pipes (VIG2/VIG3/DMA5), on top of the CORE_GDSC
that powers the rest of the MDSS hardware.

Describe INT2 GDSC as an additional power domain of the DPU device
rather than of the whole MDSS, since it only supplies DPU-local
source pipes. Restrict the schema change to the Kaanapali DPU
compatible via an if/then, so other platforms sharing
qcom,sm8650-dpu.yaml (which don't have an INT2 GDSC) keep the
existing single power-domain constraint.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/dpu-common.yaml           | 19 ++++++++++++++++--
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
index 3f953aa5e694..19b791a857b5 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
@@ -25,8 +25,7 @@ properties:
   interrupts:
     maxItems: 1
 
-  power-domains:
-    maxItems: 1
+  power-domains: true
 
   operating-points-v2: true
   opp-table:
@@ -53,4 +52,20 @@ required:
   - operating-points-v2
   - ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kaanapali-dpu
+    then:
+      properties:
+        power-domains:
+          minItems: 2
+          maxItems: 2
+    else:
+      properties:
+        power-domains:
+          maxItems: 1
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index aa0cf0ec5b93..88aa71d2b912 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -61,6 +61,29 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kaanapali-dpu
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: MMCX power domain
+            - description: INT2 GDSC power domain
+
+        power-domain-names:
+          minItems: 2
+          maxItems: 2
+          items:
+            - const: mmcx
+            - const: int2
+
+      required:
+        - power-domain-names
+
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0

