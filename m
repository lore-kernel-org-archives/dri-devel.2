Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAD8C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 18:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7DF10E66B;
	Sun, 28 Jun 2026 18:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ilWAAZOf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CpGWlLMP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8CE10E66B
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHjCMT424279
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X9p3oCZzvqstazXxppdDmSZcGrd5rTD5PgWo89uABCs=; b=ilWAAZOfBhBzCFZb
 hQXPU2IHDPhZvPfe1PqWl8u9gK6zCsOvHAI8y+u9c9gtTG4jOQoJ4tpfm3sO6mEo
 xc30qaUKFlAz5+xqmZslKmMQCUEBN3yfMULQvChnGob2uZ8BBZ0EOkfLxgOjKiyZ
 UihblrL4LyigsylWQIX2SYXhLPcdo6Um4+Cu8JXfsZDJUb1CZEfQ+K+w63jU8tQv
 4FP2SNE87g6m7cFdAoQie1TWhOo4jgQN/++eGW+5+AADTpB7Ob2QEonVOFR8XTk5
 RmECGeVhcL+I7bioixGx3FOG3KFhWPR5ZPdbLBa5xwPcBVSmcGn9Mk0g35SJIhwr
 Jsg1bg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279ckb6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bccca5620so3792648eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782671088; x=1783275888;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X9p3oCZzvqstazXxppdDmSZcGrd5rTD5PgWo89uABCs=;
 b=CpGWlLMPC5GSmMpRE7hnarnd/nTGCdR8tjPw1Fi8iZsfUEww4TLnwmnVmzQO7AHFDD
 2YNjhPEj9Kqdt13qi4To/N7vShmatviN8v3nDuz2nT5MTHkrCf4vvV/1IzW18DmrPiwV
 3+xo2YV+RC7ohqALYbiTi7tn5cRL53I1Tg5Wl6opb8ByhzdWnPtX4Yh13S2U+gahj780
 +lpF3vg9reAjPWDTYASSgl3alBnQA7HIk58BHwENSn9a1lWzKfQPzvIDd1D0FtP0j4FE
 PJ//VuzpFkUEaOPNZUZ4n5lwKofBnx/pt3l7rMbivL0kyWF1TsdkLY5SMDBEJBjjbwdy
 sEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782671088; x=1783275888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X9p3oCZzvqstazXxppdDmSZcGrd5rTD5PgWo89uABCs=;
 b=gj4YuPcIqQfqPp5wHJBchXYFOMK2Vy0UdMqWIju0yxwOuKnpWR37R2FznBw2rogELL
 JX4VLuEfvU/8gDDFPSSD92WS9l0436IiZ5BL5tyPFOQrDhWMuNJkHRzqF9wijmHkfDE2
 Zx1VtQ/1haPnH4HgLMKNl6sJl6PA0iDPWZX+Ut3kclOqxKJZKUSTSI1+kmC69Res0BIS
 NHmdXK9rilJdzXXCnU0r2Ho2sTIHk9+HXqiiXK7SZ46vmL07aVW75hZ1SJivTCs/B8+z
 KnGaYRdaGy6pU+tMFB/DQqjny9yg5Ku3zCercZF3jIIDQ+aCr0wNvs+Lu1mLZtA/l8eV
 dBfw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrow4M/HSkDYlgRoOrbzM3lj7eB9hFj6n+Vchg1Px+F0loD5LIbZWOSuKqTWz74bYdNjZOLW0gNfHg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUwY+f8xTffkoLlMzjEp2ePPQPK9PRWVjzXrlunx0i3xe6q4yw
 ufSGzIWBs7IiEEEbT5hhxLGjLn6c1Y4d7/tFnBIsBKErY6rASYjwXZyiTEGJq36r3DSLAlrq/+m
 M0dmQH3pHSPwmw5o41fLM+fFuHtwlUU7kXM53ySfGpRjtB2L4RT/E5v3JGLZB/PC5idCL9mUBPl
 gJokg=
X-Gm-Gg: AfdE7cnxJtkogHuaa7gEVn7HUpnpnFrSGW+U648qdIRVjrMi5sLy3yYK2zgp0YsfoyY
 duWrGDgzbCzduMSVpl+8PoMZDlqj2Q//a3yFAPqGwCBmTG/7D6hg9aGF0X3rnFeZ7FXwt3+noWm
 EiNEtSr6P47ARbrO7NtNvf/x94kGVQ7lhKrBkCx8g3vFSgRlCdKjKZqAWlxfVXA7vnNSp6IpUdm
 srQ0XnNvmCmbdXxJLQpVnu66w2aMYKKbFAa5WIDLyrF9fDhTtURYqbwIpUWk8zG0gGOW+yumRgW
 XPivgEvNVnvCY+OAUgT09zo0Z9kp2uMmuaCE6D2lO/BY9GhjAQnGKBFHkMAQ3DD8/v4OtjHr36W
 9tNjd0YAItzQU8UePXQCNoKkeDj+NcIAkhHA=
X-Received: by 2002:a05:7301:6003:b0:307:91f9:c1d9 with SMTP id
 5a478bee46e88-30c84f77b05mr14159290eec.29.1782671088538; 
 Sun, 28 Jun 2026 11:24:48 -0700 (PDT)
X-Received: by 2002:a05:7301:6003:b0:307:91f9:c1d9 with SMTP id
 5a478bee46e88-30c84f77b05mr14159282eec.29.1782671088092; 
 Sun, 28 Jun 2026 11:24:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:24:47 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:56 +0530
Subject: [PATCH v3 3/8] dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-3-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=1298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ab2FJciDIqw7/jxV1YWmBTVegZUhQ2SXaZRIypzuWaI=;
 b=DtAI8ypsLKBEX36oBYU18khootZJoi9iiNXb/fY1RbtwZTn86qyHcgIO51NjZJDUqackd5Lan
 UFQMxskGcxLBwd0K8GC7ROWRU2OWVZkcEAJqKGI7ITqTZV+Phs2p2eS
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a4166f1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX3AxjXT2p90Fq
 g5vEpqJ8umzpwcPrVzF3puNRvj8V+MUjKLTqTDtfonj2s2fOrakE2MpqkXjCQhhuri8ECKbrYSC
 78vCsYSShYB6s7R/7EYouOMN693ImJA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX0g35Nv+5Y6x8
 QFAXSvjRiMmqjrtN+/1oc/GYYt1lpQmfdxOp1duDL58Tmi1uN09sYrWhuKXZd6BhhMLSARKK3+T
 a16yQ0ozJEB4z+2xSU2j5c/60/kausklcvqpxXyNbke4wTz5PG84l9qi0ZMpXk/Y9tS87FNp5fV
 eTO9lyiIwLqcocxarxD2d7TxKq+S2pzwQUPzXJ4qGV4H+eMybV0rXrv6xAg1ceARIs9TUSoUDB6
 9oJ+FGHLbp1HJdamTSd/sapwzTF4OWrLs5YCl8Sx42Yt+65z2rEX6lRoCUGf09ShaS+jaYAAzd7
 erJjPJyA4il98szdD4PcOpWCmLkwEhQ1rZt6JvvB6cSfS4PLRqCCnTOvaJEJaaa3/+PC3su3tlO
 kowXa7j8QtBwWmp7NTkO+kyHlFxQGsC4FhppkBn/eBtiG1iJJdYbCxYGdHQj70CU9yDWxw77MDW
 h2gyz8WOxGI2Y8+12Rg==
X-Proofpoint-GUID: A-64zO_bahncqnMQa02GW_9ZfUlY8VHF
X-Proofpoint-ORIG-GUID: A-64zO_bahncqnMQa02GW_9ZfUlY8VHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165
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

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ad15fda5c25e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -108,6 +108,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm8150-smmu-500
@@ -543,6 +544,7 @@ allOf:
             - enum:
                 - qcom,milos-smmu-500
                 - qcom,sar2130p-smmu-500
+                - qcom,shikra-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
                 - qcom,x1e80100-smmu-500

-- 
2.51.0

