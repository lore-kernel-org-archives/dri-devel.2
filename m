Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5499FFEA805
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1DD10E704;
	Wed, 25 Mar 2026 03:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="au5rUQ0c";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AOL/RzVy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1537D10E704
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:53:57 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCfxW989052
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vzyNvMFuHZ7
 AMRTGu9dBLqXG9QjRaM8aJeviwp6Cqpg=; b=au5rUQ0c+E6bEn8qGk+2XRn+Tnf
 M3ygFDhnB5kivVqYU9utjr6eScJE9CNDrJvF6WbiGRIb5sO9z849JkMCptQ/gjCQ
 ZtUH6d8koDX/l8WrGGUEHZFkMEgg5bEVIHU/fVk/l+A8IpGHgTO07D3b8WaDg0Qb
 zlTG+lu/5AwjuY2cuxrWWCdl+v6pfLnSBtH9iawwl3+u+n4N2yIgVATaH7zYdhTi
 VyDve1qyxoRULdSU5c5FvQ1jOA0tUuzZnOeOtYzFBIbyIgL38cZP4RDmzQK/yFsT
 hp9YPZ0b0MuXbvCM3GwhZUjEisD3cxdmxE9Z0CRWqTJg73vQehQN4cpz/9Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m2xw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:53:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35c0abf427aso1071446a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 20:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774410836; x=1775015636;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzyNvMFuHZ7AMRTGu9dBLqXG9QjRaM8aJeviwp6Cqpg=;
 b=AOL/RzVy+euLvHsfx3TEa8Fh3YOky1YsvdIEHF+L+g5/CsgSThDnCgi6EkP72rduvF
 8MvzCYPGDbIZkJkUiY1JIy17RhSDrBnTZPsjg+X98FyxgCzyylDvCVEzEXoV80HAItVJ
 43PtjpfC0cvSIi7Oh+mDOounjsOeFENCCgfAK3vVfgcHh/V3zKNPr0OKIeS+GOS04nwK
 SAhNCQyDhoOjmkvbAaYT7U2Mh4QRNOvGxt2Avd+YjPqXh7wQnc/YfKL2Aco5W6W6bbTz
 wMntlhPoVCkJeD7U61x2ZNi55zOIoTTnH5wMRZ1w67OfLZCw2sPMfW0APERzKGt05yQY
 g7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774410836; x=1775015636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vzyNvMFuHZ7AMRTGu9dBLqXG9QjRaM8aJeviwp6Cqpg=;
 b=UV1y+0juC+FEdHPRxj2X+07T5EOsZiJJlqxX2/Vf2vSfQb+mgS7lxdMKrUIvhwAQdz
 X8+Hncp4o8EbVsj0S1UPbAHEiScCk00OufHqQxORhauAB8WU4r2Dop0v1cwJ8Uly4GFR
 3oIitUYUx6TABlrLwDlZ6jYe5cBt7Zro3rTDOqPC0DE4Os3Hsto0quK/1affYkKNz5a5
 uz6PcIBDnCxBagRhnWilyHaAKaPLA/4HqsFlmjqm/WIX7HVZ6yVPMgjPl/IpQf5vwkw+
 aLlfsxX63XfqklxbGslNDUW5t1GUsjgmz+wGybzhr+PFv3nHgfJNRq5ErJi/CppT6U7+
 aiCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0hWcwHOX7Qf9ZUTc/K3bxnJUOgRMgMglpUBmC7/cvzQjyeW3nknxP9eThSq/I5qrBCcSRzE2B+Gc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygzvS0xW9iUV86KOWmPlIpb0pT867ixmW6TIABk5tON05hsNxT
 COuj//P1dFT1bb7VBZIs6y3VlcPF4seQHTNz+N9wg+dNVLykm+wmBBj4Dfnpl3yptS/QSFmfpur
 oWVjduR/PhAagatGj6RMI9vUkwsDUxEsCmseQC11GQaWrTowtllgC6oY0qW8ZBffNW9bLA9U=
X-Gm-Gg: ATEYQzxdGlldm5M6+7kCIc7jw4OPzljG2FwiX+KHsf62ytfn/fRtFktpImLijRKUPZr
 gGnCCaW0kfIzAmNPjIXq72lJj4aag05h9ct/GJP82EQiQh9ptAwMfcNRwFJpfpx4PzTY+cxZAOy
 KE3P+2bY1IQlG9ESkSFgoU5euY3B8nv0qlg8wJ0QxzaW0+J7+xiuAQJdyPMDGOgaujbPXbvC8uC
 R/CbwbKP9kOalY6F6Y2mIbGy51yPJZhQVoLTgnxrbhaLExG0mUFK9YW2v7vo82hp5fiSV2QGVax
 VRzMi1G9vfyHaM3M8A9ZqOSFuhreUqhcJAATEGlIrNJ9uaHIalI8F524JCb57015YMoMClPLYnc
 u7QS9CGK2ZjuAJf9JxsykdI7B84hXiRYkSwV9qV+KeMi9de7DeuJI38F0LcPE06yHE1oAyEyFqH
 ce0VAOoIyiicfQa5OsptuOoOLhoYeqfdXRpqOu
X-Received: by 2002:a05:6a20:431a:b0:398:ab13:b990 with SMTP id
 adf61e73a8af0-39c4ad5b696mr2381838637.34.1774410835795; 
 Tue, 24 Mar 2026 20:53:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:431a:b0:398:ab13:b990 with SMTP id
 adf61e73a8af0-39c4ad5b696mr2381797637.34.1774410835085; 
 Tue, 24 Mar 2026 20:53:55 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0410870csm14220689b3a.52.2026.03.24.20.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 20:53:54 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V6 1/5] dt-bindings: misc: qcom,
 fastrpc: Add compatible for Glymur
Date: Wed, 25 Mar 2026 09:23:34 +0530
Message-Id: <20260325035338.1393287-2-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
References: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c35c54 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=z2LoTb0XuyLmHK_nd1IA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 3Iuoj-AXDKU3WjQzdWZFLZhalYMESTbf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMyBTYWx0ZWRfX/a69xUGKIMLE
 QdflFMAN9/fe34pjLpPwj2og9aglhqlX1HqGn0i6avGWlWs5M5GoVemH4yNvrXr7lh4bjdnRKxw
 cxfOD5mGUHPbl4HPB3wTkAGoLFWka07/QftD62UsderaiY0sIQg5RKDUNx/a7oG8p7X6xLoW0Lu
 1lrEbg1WL/0ttvH1ZakGEqjplwx6HPcESK+rhvPDakZ8kYFWKd9fNMFiXa6uxtMGWx9R9lorZsi
 LvfbJY4x36H6/TqT9f6XSQXOsv/ksl1wA24xGrvhprKIXnpJkr9/yIMMvwkZ/OVVzREZidYhuri
 rq+rMNyfyIc0ip2Fs5zWEb3LnSLAbHtsgXMHqyoIFpgxI5NrB7vhjTm7rD6OCUlWZJeSuc9BKMe
 edPmuhXz92eHA4sB0o5UT2Mi3YrPwsXcHCq7RPwc5pr+5sdHdeEez37v4Qg9eQA21IskHc8Gkm/
 q/F5/3cP22Q7pO1qmdQ==
X-Proofpoint-GUID: 3Iuoj-AXDKU3WjQzdWZFLZhalYMESTbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250023
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

Document compatible for Qualcomm Glymur fastrpc which is fully compatible
with Qualcomm Kaanapali fastrpc.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/misc/qcom,fastrpc.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index d8e47db677cc..ca830dd06de2 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -18,9 +18,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,kaanapali-fastrpc
-      - qcom,fastrpc
+    oneOf:
+      - enum:
+          - qcom,kaanapali-fastrpc
+          - qcom,fastrpc
+      - items:
+          - enum:
+              - qcom,glymur-fastrpc
+          - const: qcom,kaanapali-fastrpc
 
   label:
     enum:
-- 
2.34.1

