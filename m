Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191B3CA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A56410EA4B;
	Thu,  8 Oct 2026 21:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="URsV+fOf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVlf9Go4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C064E10FD3F
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:07:23 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698Kxwoa807709
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 21:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GkAYEYOJ47Err7LXItBpqjbWE5AbOyqqq/B4n5EVcNk=; b=URsV+fOfLPSAFsuY
 aB7s5je3lOmc8kUIpZMG2wMnhVa4NwMSLYa09tAyuLoOIhy9KJbwYo4HTOymXDmM
 wbwHnqLVvSXxnJmq9G7rzktH32UgZCRimFtsgd4u/jHme4elhLdQ6yHx42jPapex
 XzGMpXWzKGfsMgQ1xpIvDutXPhkAzFyZNwq1fHE19MMAcQDwU8Rq/A6CgVIbl5Hd
 QISFr7uYIJxCzi309EEMxV5zv+eZQDxQfkYRCwL2p1qlDlcpUPuoXGNlLmoVWmFr
 6XyTDKjmrwMBD1wH/uIWhW2xH4qqlJe/hmBLOsR7vY4RgRix1dKhCUM/fntVOG8r
 iLzAdQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxp0n8c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 21:07:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34e676375d9so5735876eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493642; x=1792098442;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GkAYEYOJ47Err7LXItBpqjbWE5AbOyqqq/B4n5EVcNk=;
 b=SVlf9Go4DLiHpER8yblblYZvyR7wjBy4IhDFAph6SsM7RY3fqx9cNRBQeUgp0oxR5a
 qi+4TZuFaWA0s6qv+Gp4BKxXB0woYHua72ONGDyyedxPMLLlZJ/PZPF6YIe/pNobINP6
 ifcA8ByO47ZubuWlSoCysiJ3Eu2H4XzzjQUVhr6aulEtxRnOLti/p2hbtpgNb43ReANS
 AnohQCGuyAUsbkyEP0JrGGkpwG83BsjHhgMcC2P+g77j2RWJ1a3LRXJbGRIF2cwjEV7P
 by5eCnIBB0ocP31/CDQ5seLRYCly3n/TUvywQF44R40WYKGUp9Q2qItEORDoPQceD0x2
 sS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493642; x=1792098442;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GkAYEYOJ47Err7LXItBpqjbWE5AbOyqqq/B4n5EVcNk=;
 b=14kNGFxHHf5YtYIF2LStIElSZMt+Fwm+3YNGX789hiS2U5+7fnco5APRwVwso091BW
 s10DY5cX5oGBlhE4ZOVwemopxvZlmdH/5sBnV8GlqrDJpZ4cvE10xlrhXurzlTd07Cvu
 38CxuBoC/vXjaZ6wrQO7tijbuq7YKQCbNQggvqGMFulnHiOdyHDz9Hq0yn5Z1Yes/P8g
 jSY7Zu/PR5kK1lTjoK27ynohTRQIg7bKJtkWskbc7eFYGTQ5Ryfha60RGVgPNIw6vp5p
 hzuL7hrxRAauQCjqLG2QMXrC6QIiR6xnu2fHTPQnKeKUZUXFWt3u44NWLH5zq89+HBUL
 jqMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7Q5H1HLxHiFrMmg0N0T+F4eSHXQ2yHpepEL3S0Uqq78X9lc4hOXlqnoiv13RB0fTfh/krsA4Ox40=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lfxYha6BiSFttcbSfwGGF/dXN/hfk6ZV3p512ISbuE2P6zx9qf
 ADdFd0qhZ+5Kr3HbBlxVV0pnoj+Dm+e5WO5bQmHGSPVPchdTssl1jgntQAD95sggKR+PEol82h7
 6WnTF/Woop26M2YwXif21vP6Wh/MFJeaJZI2Gk895/QieuQ13FpBZ++/DVpn+CXtVPpIEN2U=
X-Gm-Gg: AYBFou23zjBjnlSqyFIA9pd7m59P9WNRDuxJvKrkx+sgLrerTR8s9a/r6OQQPQqiX7+
 6Yt9x1MVdVEhuZKITJd+vZAp4Q0N9NqNyaWs3WqvnvuJd22frwLI+CLjOOOJ1nydENX5zNstFQr
 9gHAqjJsZofbQmdp2mtSe9FgTptFqB0w/BfH6lPag6xsry5q5vCA84yWIy3dB2ynoHx5ZzqOaX6
 Xe0wSNmXvAY4rgc5KGf5Cfn4DiIoOSH60rURPc84GvfOcyptlxCwmTRuyhvvfxexxAIpd3m/Yxs
 Q4X+2VXdpw+MdktesSUYC9fGTBMCuJSPsQXK+XvX7/PZPsOXjrSJTTLtgAPaJByr2IRjs8dDrLc
 jGo+oh0DzI4gqLvLb+3QlW3M=
X-Received: by 2002:a05:7301:29b3:b0:351:77a3:55f1 with SMTP id
 5a478bee46e88-3536c593e65mr645338eec.19.1791493642224; 
 Thu, 08 Oct 2026 14:07:22 -0700 (PDT)
X-Received: by 2002:a05:7301:29b3:b0:351:77a3:55f1 with SMTP id
 5a478bee46e88-3536c593e65mr645284eec.19.1791493641467; 
 Thu, 08 Oct 2026 14:07:21 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm634773eec.17.2026.10.08.14.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:07:20 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 02:36:36 +0530
Subject: [PATCH 2/5] dt-bindings: display/msm: Document Adreno 753 GPU/GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-nord-gpu1-v1-2-a06a6c57bde7@oss.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
In-Reply-To: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791493618; l=2602;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=BXsPUKrXl82KNwO286DM3lf5ULQHmjN1Oo3TDDxSoTY=;
 b=pbssSYLdqZgtTBavbt/SJM+8izct9sA/O4Zks5kh75xyOPxEotLYhCEpckT8zrNwuyNHEhkT1
 DGq9WfiwZUoDGWQEaFt4fE9dWDeCA+iSWtwIPyqR8rFrxaNGtMG200v
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 0774-BtBXn_7FyUZodJRif9WZn77KW1I
X-Proofpoint-GUID: 0774-BtBXn_7FyUZodJRif9WZn77KW1I
X-Authority-Analysis: v=2.4 cv=LI3z05W9 c=1 sm=1 tr=0 ts=6ac8060a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tfb5_1Jyd-QlxhXfLoAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX2hZyrb+MJmsY
 izMwYEMrrtuPwOPqNHJbj0ayhGbXuRypLE2YMJqkc1Kob3czs85oqlzZIFq+DvV9KpcwTF5RHXg
 YH8f+wHtmjZc/6Q/L30UkYF2s4eaOvs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX5wd0EPD0J5bo
 4n7CZsRfMH3nxEStnKfFEDAB6VAuynFZkv0NogfVumScC4sh9p68MkTAu8SIopeYfZ00eUSPoZM
 2BuZkObmeEzpeFgYSm4JK/zCgpLWyJrkWm7dV8VuEbtVjnA1hZcKADaqUFepSqepZh6NCFtMo3l
 Dflt0ixYe6Sm7fQUUNmQe4hqpJQD1ddGdVAHZRduV8s6B9rqWOxlU2tli/pdOlAepwoDP/i8qCu
 Hnq19xiG33ub1XZD+rtfGITfdX/1R2M0gWFvmC6CznI6xchREaQKeTsqV+McTwgy4f5EO0Ve1vY
 m/qB5VKEIR5WCw4I1HMP6Z7ef16qIdbgOrINlBqbLBIjhOha2MlWvsPcoI9wCkpVi+NMNFwL0uQ
 rRz+nptvRHaKdKXr9U3tctWugcDvIjz1ff3jt3/Wd9mLYkO4DavXCt65F1ZWLAiSK9AXEIs72ZO
 w2nEkEko0nrPnCRKgzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

From: Shivam Rawat <shivrawa@qti.qualcomm.com>

Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to the
A7xx Gen3 family. It is very similar to A750 and has the same register
layout.

Document the qcom,adreno-43051701 GPU compatible and add a separate
constraint block for the qcom,adreno-gmu-753.1 GMU describing its
registers and clocks.

Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 33 ++++++++++++++++++++++
 .../devicetree/bindings/display/msm/gpu.yaml       |  1 +
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index bc97d0706861..8103973908d9 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -305,6 +305,39 @@ allOf:
       required:
         - qcom,qmp
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-753.1
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+            - description: Resource controller registers
+            - description: GMU PDC registers
+        reg-names:
+          items:
+            - const: gmu
+            - const: rscc
+            - const: gmu_pdc
+        clocks:
+          items:
+            - description: GPU AHB clock
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU AXI clock
+            - description: GPU MEMNOC clock
+            - description: GMU HUB clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: axi
+            - const: memnoc
+            - const: hub
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index df21e3acee4a..12555530af5d 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -453,6 +453,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-43051701
               - qcom,adreno-44010000
               - qcom,adreno-44050001
               - qcom,adreno-44050a01

-- 
2.55.0

