Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDF606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JC5gcMs3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BWqUNt6R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD3810F9A7;
	Tue, 17 Nov 2026 23:01:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792C210F9A7
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMesrR2627370
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L5Yn+CHje9hd+sqisEi7dp6zLpdXzwrI2oKNmqrlUIs=; b=JC5gcMs35H4A6M9X
 vPNREHXaNcRfAhv/ZpXm8SX8n+IrA/GeDhVuVAsYfTf+cezWboQrBXlojB8JevNX
 L7EFIuqArBAo39W2zYnpD4ZaXw5v2naGfXd/rj3aw4pymw8SqdivAXgF85NRhpfz
 qGd1Lm2yqkcjQbNUJvCYsc4ioLINvvkv4SC/aZ6NBtC29qN26F9yncXPOfZLtTyT
 m15RGf9WPCR8yIz8jOdz8da12+0WbkXPWDbyU5e+r0nWAJ7CT/+xwC5t99bpEShI
 7gs+sFuV96XIks9kgXT6jDwgwNwH8S7GpkSid5Kk8vHrJT0M3Y2baiiefx98rNbm
 TFoP2A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9g2ft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:49 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b3b63b9665so239001c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794956448; x=1795561248;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L5Yn+CHje9hd+sqisEi7dp6zLpdXzwrI2oKNmqrlUIs=;
 b=BWqUNt6RP0qDZvn7vtQWQSbPnlGw0byXsUEdYYAe83+7w6HGoOtK9W0yLTHRS16vPd
 zIZnMy/CVzllBsKz/tzVCtTA5bdpk+DcwCMKd82b21XhKdYO0iG+GW9TjUuHE9PiIK0P
 xAt4usftv1JTvULyraympdinRwLLVQXD04xigqTsbQF2ISu0y5ccBEXoX2yuJ9ZS1vzd
 gsoAN1/Zf3BAynIT/bSd3MHk3d8TK4VguBny84gvLi1vLX2YJVuBqMADn4v+9fRFE4N3
 IMR3eqdslqnQfY1d78HeePafEiE2S+l/B4bwCHxdZaL3jqCx2fnoGMZMJlU2LoBzxzTG
 735Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956448; x=1795561248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L5Yn+CHje9hd+sqisEi7dp6zLpdXzwrI2oKNmqrlUIs=;
 b=hrz43Yf5WxZ4oLulPJicGrnQXwgp3yWxvihxWywFbEZ7Ogk6xszA9w0uqrmjSER1q2
 kQyhVHByhZlYkdu49nogoNg+7OEK2BkDlvX6IidREtbEDlosy2aYnZ1JUDy03tk4w0+4
 mLbiy2iDSGdW0MYneY7F2fsIqzKHdCoWhiTt8+K0pTi4G90U8RYsnEZFAFkBPX/dOcgh
 No+A0xS58rwLsWWC02We94HQjfn5u/NQjfbP/EWNnqylW40DonyW9/+e9Qro/tnZbBdl
 MX5qjQODdrUwt5lvT0fZp2gol7sXhdEwhVkyGp6WpmjYMWYdlmYJsg98d0HrqwIUfLE2
 56lg==
X-Forwarded-Encrypted: i=1;
 AL+hErFfkxrjlhJO9nwq6EvxASG2fVs4/2U48YzALF5XpRX76psDQRZO1ANPWo/WFKJOdAmAGpBzJrYAVt8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z95v6tFLTt6RI+slucdOVTOUGJDndsKhZ+nYgJIQm95dy4NH8sX
 1639zFFmGzuWyyZM44BHR1KC46azkaz2Qw+j4zjxuxweBPccKTFlAxhVSSZUV2hLW/rIK3mskz4
 wJGHi3s6EhnAutQyUZlyXjMtLgyCxfEzakxxC7B5taUS1sJ+0T3K2rgLGOstNgeZ+mz+5a10=
X-Gm-Gg: AYBFou0l/ntCouU6erpnZvRXTKDKLsP81EBfV8XRaAfP9xB7nKTqCZXg2XDtCOVf+ol
 3SMFQgk3czhhFs/cE3fiyRMVExAvu6CP1jIeu5cJqAy5jdWRxt8kyunBXRfa58/vJKbuQB/vvcN
 X6gNgtpLx2HOwTXMT0byWT0UurBW9pKVX25FjbfY2Vo5UxNusIPM0xm7vKjs4L2VkWnttXhE0O8
 DEoYgCBxRPvmcWHXd8e7JX+cynNZM8zQIIfXjGraNwBuVFE6Z9zXq+C91MgzDkyQy/y94TdTYZ8
 B+MGJD2js5CeSa4ORgGU5ievSU/13QqMLVWy/FPn4xvaifFUqdGDzchYyQZ/TEQXCPTj0THrtDy
 UE6/OD8aSEmejCKjbWEukmBEfaWRFnQd25+D8eQ09M7EGwbL1vUMMannxzMdhikYuG+btkt3cwQ
 ==
X-Received: by 2002:a05:701b:2202:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1b543c14aaamr706534c88.2.1794956448040; 
 Tue, 17 Nov 2026 15:00:48 -0800 (PST)
X-Received: by 2002:a05:701b:2202:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1b543c14aaamr706458c88.2.1794956445963; 
 Tue, 17 Nov 2026 15:00:45 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5445eb29esm1380839c88.0.2026.11.17.15.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:00:45 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 04:30:05 +0530
Subject: [PATCH v2 2/5] dt-bindings: display/msm: Document Adreno 753 GPU/GMU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nord-gpu1-v2-2-8d6d9908b7c5@oss.qualcomm.com>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
In-Reply-To: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
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
 Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794956423; l=2675;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=McFLm0aMyTcV9N1kaYPA3PSC/gCV7LbW48SyQaf8meQ=;
 b=mrAHKWNH7J+q5CRxiq8eKAVDmZjI1fHu/90H1/VVy8UsyW/VM9VHzqWcWFwRPTSp3hv9SkAGA
 CnvdoZiKeeoCy9DHZ6FhciBRU61FloMlBPZfX9ZqnAuR+4QIz7qrMei
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: gWyUYETpfWgkHjclBepTEfvN-QC2Yy5g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfXwaEUlsibybbv
 jUnRV5DM+wAy6rX3VnbZ1vA7oCvnUREBVIwjsRkp5CmKNm4HIOq23qkRlhinZ1jER25u/NHccwD
 VUhyPoVIlrFGVArbK7IQE0lDtGXmCiE=
X-Proofpoint-ORIG-GUID: gWyUYETpfWgkHjclBepTEfvN-QC2Yy5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX+rHe80bANBm8
 F9IQec6P7hfML2gqzyQk4bnYnq5QSGJG2BulI8qmeIzXD8nMzS6M9SS2Yo25Y6oYfBU5EWZ78Sh
 hQCJEiSIgKIUv1v9+KHAmo96S2YVjb/WukAHLKX6hQoD2K1i0BZGM9qSn4lFKkItkOFpyPxdZZo
 ZOd1Tj9CTQH+qR8UinvlDADfZ8g/uhXT+0OTopDPtQe5SqCFs3BLf0btY0rFy/nW/ckn2eNS1Yo
 joAzUxXK9zia47PJz65r8lUvwbcszyG79rgk72cQ/NMYHRXil49IPdh5QgA9kA7ydlwJFGXw9zy
 cy+Nz6NNveDYuRZPvRWlPbJa4JTYVrjBltijgkykipAEMIYwMudC/94l90tg9w3xSnFOvOnLIMq
 cINs/cBaYJ8kfiM4OZYDahnRdWLskR9/lYbwsjsdURC/dCUKbLvMsxsF8PykESmJOAEEiveoPgj
 MNjgPuCrEHF2PG/0k3g==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afcdca1 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tfb5_1Jyd-QlxhXfLoAA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170091
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

From: Shivam Rawat <shivrawa@qti.qualcomm.com>

Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to the
A7xx Gen3 family. It is very similar to A750 and has the same register
layout.

Document the qcom,adreno-43051701 GPU compatible and add a separate
constraint block for the qcom,adreno-gmu-753.1 GMU describing its
registers and clocks.

Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 33 ++++++++++++++++++++++
 .../devicetree/bindings/display/msm/gpu.yaml       |  1 +
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 07f0e547b43c..6b28694624cf 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -301,6 +301,39 @@ allOf:
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
index c30de7feb447..3c90a09febe7 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -451,6 +451,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-43051701
               - qcom,adreno-44010000
               - qcom,adreno-44050001
               - qcom,adreno-44050a01

-- 
2.55.0

