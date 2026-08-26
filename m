Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BB6C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901C010ECF0;
	Wed, 26 Aug 2026 13:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W3apjqhx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y4ZltR+m";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705AF10ECF0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:05 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCBjuM1909029
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wvrhRhSRgFm3KRFeRtyPfPbaECnbE0fwGNji3RrKscA=; b=W3apjqhxoZO5HRyy
 gYqHC/KoERrxR0zO1CGszuN0uYLt0405e149ZOqXkcWvTtGdzzmiaZwIS+YaFARj
 Jo/NvKN0vWymEcEx6bdEGFT90ce0j62/W1BZKbF09GHEiGmxl+rVAGg1EDyE3Jxs
 6IkYaDM7r3z4di9O/jsqnbOyK07Kv36TKY3fBzYXrRoJZYQ2qK2SpqUqzCBXhpTi
 OdRR4rti3NYIipCrnRb0X6jgYHjhwo6nPEJ25mg9B7hcGqrnB8wQEMxBmb3hSvtC
 KFQoA7/8FiPxCuXx42JMAGQgoVcIrnfliKhKMriP3u3mL38pvCyun/+ugE2NyHE1
 7EXW+A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1sgya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso1144227a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787751964; x=1788356764;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wvrhRhSRgFm3KRFeRtyPfPbaECnbE0fwGNji3RrKscA=;
 b=Y4ZltR+mkBpIfdBqM52MiEgCCcM0se0nyj7bOrSrFp0FkdBFs4hC/cZiAPd9feFKym
 PCe+T0AxLUc5VlPo1swDveygpfDkFlO01Z+uqM5CmHyv/9EZ9zPUW/ATXykOBNJRQiGJ
 hnjGEqTAYygGhftA31mA5HPSINd0VZPhifEl023i4nJ85nQKTIFKLFf31IGRYT9Ijle0
 jk7nsoM01D8XZapt5MWvzcRakPESuv5JaEqL8/ZpsJO/XQsRh+/i6jQe7lbD9EtybMbT
 Q3SvSNSmCMIyvmutnvKWJwFsRtseoKri5kkr0Xcq4WXzbqLmVtPl1F+nj+jBblEpCCuz
 e4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751964; x=1788356764;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wvrhRhSRgFm3KRFeRtyPfPbaECnbE0fwGNji3RrKscA=;
 b=V+FRqzSUBbxXFB0jE7RdKGR8HZA/+/fkFDa3XPd15otV7bJHFBTb14Ks3iwvjJGzoI
 txa5djqQDan9VAjnVl1D7rHslJQlTtZ6E9h7cvrCA+R6nl0qVZkRQo4tBJ9U1y/8t5ST
 8Y9h4hf8p6PWFWDI8NHVKjCYc5ba0uJ9yQV/pXfmt4jFs329aJeXC+mlFIWrNURtqgX+
 AkJrMSdJjLnTguxq5Ln9G1D1RolRXJtKMUpYsnRAajM5Me7lBwRwpALlBkzx5vbX7ZBm
 v7AtHSSCzmRFL6DCxPmq9YuiPDxI5T7Oq2BI29i22aisIIkh6zUbE9W5+50ScMGfcfJB
 kG+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqpb0TWrhqu35hI9Oofd7xkw2U+2RsiklpHvv8EJg6SgXi5XrHgxU7XVlBXDYxGTuWc97GzuJ0rn6A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nln+MPTkPNfn+SSKnfeFIoNvPvwAP3wVbRlpq6iPPCdETF39RR
 dTgl2zjm2lGVU3ptnabUNPPEDFA1iO2jAxTu7o4pz0gEfK5/YdEjT3tO5RCek0MD30ImyL3bwVe
 3Hs8IH+MmradaeWfN9mQvvBY61paQ72//6O40vcHraIAZGG7xvgWY4lWtSgzkJ6ztYNrAric=
X-Gm-Gg: AR+sD10m3k0c7DGF1FsXxNuHozjj5TX0GqevHVXyK6y6HylI2dUZWJ9G2lBV0z5U1KD
 eoM3TGEVoEr7zgICFO85akA7xjqvTuP3wIKHPGcqXcoDJOVGBLWwcmdxUpBP9iy7Oks2M6KLWiH
 YryL6fyB9fWTefZHKBMHZ9y84VGTzAvU9HLdygYoGknmSixwgnmD01HB0leZhkQNJ/FLce5UlyE
 FoXdHloND/jYMT6cRgJqOUzXSyPXIL5+FywvmUOJCajR24owgWR+kU4Gd0nqJ8EdBAr7Zt1yHvg
 vmvldVFkS18RS6w8Z+pxRAa1lUMlk3MtP6J/SstJ/VfmAmK/Vmmg7XZD/LoLb81OP4TizMqfLLe
 O2FPEgoONv4v3a8oMTZt3zx0ALObB1Ce+aA==
X-Received: by 2002:a17:90b:54cb:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-3966d5b7c62mr15843966a91.7.1787751964038; 
 Wed, 26 Aug 2026 06:46:04 -0700 (PDT)
X-Received: by 2002:a17:90b:54cb:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-3966d5b7c62mr15843827a91.7.1787751963551; 
 Wed, 26 Aug 2026 06:46:03 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b64c48sm8179696a91.8.2026.08.26.06.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:46:02 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:43 +0530
Subject: [PATCH 1/6] dt-bindings: misc: fastrpc: Add memory-region property
 for context bank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-extended-mapping-v1-1-d046c1cb9a9f@oss.qualcomm.com>
References: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
In-Reply-To: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787751952; l=1735;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=BbU3aeT8kDtvkKAMi736qK8ufQxuuJe55yKLxu9JT1o=;
 b=zF995oQ3Y0zaRNhFCXjq1tnksXYHKJozOLD4+QwP/nP+FPezLYl+3kGt9We4nGf7xCmvNvKJ/
 eUDi/vV9KwtDasgYRAh3HPzMy3qvlYEsTSuS0DS8fY88DcFZiC4U25u
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: cMIWOWClxCTRT1MnyFxx3lRJ-ra2FquG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX7BM5rmdcQSfm
 48ElXAxQ1r2wIYJVO11cJGB/jnbyB9sSig74s517nNYA+8Zvq3S3yuOItPWb4EKq3Y3K/rWnUrs
 lejXmR0BM0yledQmsfkvHZDvjRgFwHU7gc3+2X1yb7f4O7q7qzPMVpOH3ZJ6O8OLErqQLCGOAKv
 ulis0aDcW0mNdaDEqZa/pi46mZQd555U8NEUuRosEUbxC/CyI5IuhsPKvcq9dmDygWJ7ozJZYzU
 2aH+bPsX5onU6C3+W89iEx0v37nvY0+RIqG0XcP6rSStu3fIYo2JuegsSxRpkv0uSfidzlhbgnG
 8HlJT0dMXQyZul5qekk0TCsL/m1qRTAz5VhGXg/O+Ytz4usIIWwqahlWfQDnOIbwjevsR6KuTAB
 /H1Ulk695Vb8aeGIN1NYstrARfeE+RBC+sxFMe2v8S+NwcGdbVnmTxSIFeLyxTvaOCQgy4fxnKf
 R1nZJtAwVI2x9VhwLtg==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8eee1c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Z90vTsduAcvSOalKQMcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: cMIWOWClxCTRT1MnyFxx3lRJ-ra2FquG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX0mWylqNgL41e
 7KSnZNwqNPtudZxllGEv3zu9c46eCovY4lb6X1/sd9+fb9zdGFSbWoJxzqpJ/gDPDmuJdR2xcT0
 v4P2TyGKDhz20NHFkbyFBA4cF3rOssA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260113
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

Add an optional memory-region property to the context bank node schema.
The driver uses its presence to identify a context bank as dedicated for
extended IOVA mapping and programs the SMMU with an iommu-addresses
range to push allocations into the wider address space.

Relax #address-cells to enum: [1, 2] and #size-cells to enum: [0, 2] to
allow platforms that require 64-bit values in iommu-addresses to pass
binding validation.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index e945c8ba75e3..f9830ef37814 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -73,10 +73,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
   "#address-cells":
-    const: 1
+    enum: [1, 2]
 
   "#size-cells":
-    const: 0
+    enum: [0, 2]
 
 patternProperties:
   "(compute-)?cb@[0-9]*$":
@@ -98,6 +98,14 @@ patternProperties:
         minItems: 1
         maxItems: 10
 
+      memory-region:
+        maxItems: 1
+        description:
+          Phandle to a reserved-memory node whose iommu-addresses property
+          blocks the lower IOVA range, forcing allocations into the extended
+          address space. Its presence marks this context bank as an extended
+          mapping bank.
+
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
         default: 1

-- 
2.34.1

