Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15647C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE8B10E4F7;
	Fri, 17 Jul 2026 20:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g++Cc5C0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U8cRH3vf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38A910E4F7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:27 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtnbn2653361
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jhtEkaAJenJ0hU5bVGOGxpv27XZDgT+ujwuT8/gsZBo=; b=g++Cc5C0YYJJ8Dk/
 LGGXvFZII+10CKTxAg7HF5JIbEdKqq3swihLsV4xu75qj91gk24AjmkNlMAn1T46
 bKHViNP5g+EgJfvw4HQ1Yj6S5B7PgNsc9MXj0nMUMawOTNXcLHN9NjGYYK9sB03I
 jVpxCcYB2HE7oW/VC2M/v+n7bqZAnLMLLMxBfXh0bRSOo9HWNbmH8fKe7BFpyVPF
 reeNtbuuZSEuDFa6IoC0ps+qDgUfO/hMOfYiDLQmGlLpRcGf7StQ+eXTkkeQ90he
 LaqVIZsYu1Z7UWm2FUq0fGUDMsQu30VBdhmw7LEQDizPgwI1hrIgt3Oajs9+JBVm
 XJOrVw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9pb8de-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e5a616d07so251904a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320945; x=1784925745;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jhtEkaAJenJ0hU5bVGOGxpv27XZDgT+ujwuT8/gsZBo=;
 b=U8cRH3vfkOrxWNgzm8iXAVYavMoNGWjrJfevt9EtB8wOvvfKxdiyTZBUf6uAPO66e8
 ePSGbSVx3fosJVX38rwqdT2APaSP8MMJCEDRUUVzp3K6dn1InQnU1tge2tHJ5n19T1kj
 7MRHDufzsNa3We8h6SNGgPV0fB29HJuAIbwwT9Tv3JYNLcpWnnKBLHtgeNDVdCS+mMW5
 ZF7wRLhdlOqyz2W04wpcvZ6Odd3H3CMjr1GCtQnUQACqZLrIkAwXjN8Hc9WhjwozKsa4
 mU/+Xc+GMxD5u8n9GPYTyNlcc3UdFjOOCxjzHyTOxrDcd2qLEOfLGrd3DGgXACofIRqA
 DmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320945; x=1784925745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jhtEkaAJenJ0hU5bVGOGxpv27XZDgT+ujwuT8/gsZBo=;
 b=hFzbdR0wbaMIlBB9QrSoixZkXFTkYQ/+PFE92HDUoBfqh1mAqJPwnKXpEwvlJjDudX
 NcEg4cSirVKB8fe9IAtUQLOwyu+iXfS1nK0Bov3VtjTB9zSkCCODhu3qIWkDoyt7Vrue
 d+24hI7mjOOpA9PeIoeN5xOZrg2He8lfVXbArYopR1KhdaFgI9AYBowhfyvXlK0CqYDL
 PE9fop+60azB6lwy25QTCfzc6BMXwn3BC1gQ16/NwJMBcnPIgnMwomWG+hJB/rfZr+Mf
 3YNSeMrFLrpqluC81h/pXH8c4RG7NG+OJNwvsH7RhIwiTq819WpFCfROH6MjsmRzTHCO
 56zA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpio+2qvyM3RFfZ+vRhTJFYWPFzHqNxn0elenb137g8FZu89z7R9CPCaVELQ5BRicf2/p+SHcVdlu4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhNebWcrnsPVQ7TtMZ+2GLY8RKV/l5HwKO2XGzf9tVMX1uuj8u
 0DT2Ws1P9VVvzxaxElmnJlj9LOQxA73GiXtoyW/TihwSPZQ/6JgqXiVG7yOMXsHGqVZgkv6seEL
 Swnl8ty6EMD3ayjNlmIW+u67i177l0Knf6PIeGcjuQP5/YfdYcupbMRZ3f7Hs3FBdSH8Fvqo=
X-Gm-Gg: AfdE7ckFOSY0m708iOs2BC6oyMMtgwV8+CPsx+bZHRiDoihZY/3fILGFh4gnFHBSojW
 QARa+jWAbJXtaHnn8rsUfyFOzgdBF5q9BxkFa+57tKFBCLV57h5UPxqZjgQYlOUBs3iVcwpOQN3
 RpoOPGdENZE0ecNs2YobAihgeFUmmlIOA6Mqb3A1+2MLD3c1VbPLviqBHLleRAd+N9ou8g8O1zw
 3DniuS0H1iLbV8obAs3IvbhzIDpy0csctHk07zy/AuUxiNGrpGmmbjEz+ccKBLonYqVam+zq1d2
 9AdesNJGk1wWw7AZeQZsyyR5tfQEq0+XEN80DUGg2rlDeoJVSOzOYePcdKa6jObj2TkvFDbtqqi
 noRm3eQaiFfmL0Dvf8WvMMZnZ
X-Received: by 2002:a17:90b:3f85:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-38e4b3dc094mr4230475a91.1.1784320945467; 
 Fri, 17 Jul 2026 13:42:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3f85:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-38e4b3dc094mr4230426a91.1.1784320945021; 
 Fri, 17 Jul 2026 13:42:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:42:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:29 +0530
Subject: [PATCH v2 4/9] dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-4-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=1190;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=A2VsonGAk/WOFU4rW5YOJ3BUlJlJl5QyL5jYHngu07I=;
 b=zrhPOCHooo2chb6Nfl5XD3FoSGfFuqiqKsCyL8WnuhUoa9KSgaCthbOm2ZQw1aKW/dQRH6TOg
 Li2Lbjrd7/DAd//jYP+/4uSrdQB0BTkMd/1iEzhPHbwlXmqJKEUSKvp
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 3s1qTEy1QL4n67EydtPePtzVavfLf-Bm
X-Proofpoint-ORIG-GUID: 3s1qTEy1QL4n67EydtPePtzVavfLf-Bm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfXy2iQG8yy7ezz
 xi5XmV0pd0Rj4v6VAdphfZ2q19i4Ft8En+ZIWhy1GEI4oTTESAYaWLzBz+FnG22aytLFlDiytqT
 oK5Rd7v2YuyQBDISrou+T3s534cNOD2VbZldKnmb07yglQK/aX0unkMY5hKOMqXNkrhaxuvvG72
 HgiqR/4yq9hk0UqqEXuIuVTeTKVyb05kRIcof0uzkCk6QjYuOJBBhBmnx6g3WaGqfdyi3rcike9
 ioWxQGDwZOQaw7LSUPSdocKEmd+grIzkmQMjhNA1HDs7j/o/PI/qXooZwgmOIA+0UIffNYBUNVo
 Z7iUbSSn+OX/aWhio0gRIgLUv5gvzhEpCAXlHD6z70Tf+jRNtWQG8z/LhusSBlKQG9ijcyC7mkk
 a2ezJ+bVEGR+fEFJNaJUjXf1VTVQuL+UuzlEWzd7Y9u8PgJ1uBO+Ec6k5fgMsG71PZMWIbe0cd2
 ULdrsVAFnrxsDvPaJrg==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a93b2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX0avcBiLK6EFn
 V0Qq5aDsMVdyFui16a+2pKnYaPSeqNQYBE3zaslZg2v9yM3nLGhJVqfapM/4jC/LDqXkcNYFF8w
 cePPXA0Q4ojpISwnxr+dNvwaTlvKPwE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170212
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

Add specific compatible strings to document the GPU SMMU present
in the Eliza SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ed556683817c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -95,6 +95,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
               - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
@@ -570,6 +571,7 @@ allOf:
         compatible:
           items:
             - enum:
+                - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.54.0

