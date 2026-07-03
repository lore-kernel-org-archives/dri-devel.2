Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BC5C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73AF10F8FC;
	Fri,  3 Jul 2026 20:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OomLeSBG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NqfqzOgM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559F610F8FA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:35:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KQOEQ1032347
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=; b=OomLeSBGdaXwW9nF
 k4zirJkKvIjQMNSCeeMHkgHg2Nu41+fTSH1hESfZCyqPqxPLdnBB6nyVzOsIP/1f
 npgRwIiurTWf0CEL6Q4jBVciA4VGbDTS9eCvC1/E1fOh+eaNJsRF/lSRshNXlsxB
 6pte5e140Wu3DOMLOzi5j74PoHdWQ+fRbH69UNzrVI/nOaQ/mRVRuorfoj4DlS7q
 aPbzZbNv8igCLD7FJa0Qx42Lwm2LKb7lsaBxh9pp95l5SHgjqdjWUe9cAJT0hmYy
 DSST4wfvfyJ8TwNN3aOfVPy66dRhq/kUMyzHieWnfmv0eXLU0R5jMx9FNZp2QMO+
 epyy/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bw2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:35:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37d4eede8ccso795901a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110944; x=1783715744;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
 b=NqfqzOgMhXoavcG+71g1tmn6zWC2xNi8tn9nDW8SmtZuL+mP97HMTq/W1coWCfWeh5
 U0twYg4k7a9mh0pDR3wzYwZhhhJBxbdMjewYrW7U0KnbBk4YnG86nICfkzj/nI4efKg5
 kgrWjKMsppuEhqzZBc5/17dTVSt2eAzR3XXLZku/fkzw+7vudLwuIxPG21TsQ32xSZrV
 QHchl4lQTk1Ezh8h9RggTH2gX8CaSOg84aeclJH8EbWol/8/kXQp5Zc2Tmu8OYEzBE19
 V1MDlUF4i0KYfwLwRA/jvY1RDMOL9IdBNqaMbBRuccxzOKZon2XCKVtqH4HtR3ppgvsR
 IObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110944; x=1783715744;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
 b=jcaIXupXReEtL7iAaM6kT6KxbKc6eByW5zjWvRJU0LWsxC3pGy10ZemjLlywOtrpgp
 7O2lwHyXEHnIBjsooXHZ6whKlSE5N7MsFCEZq2s2AjeRbGRJD24r/p121MZJO5IJuUwt
 oh1iiN62hSAK/TG4ujjJEAQRulap8g/ye1NF5ZQifkl5+tn3JBuaGk1P2r8NNlYIMk2v
 jkInxOBeA9wzdGpCkFOJuDslIgzNtXX/ob/BsR3j1CSIsev/6JclKLsg7Gl2l7jlXY2i
 XvGYf9sF5nkNz2hch5a2iGMM5Z13zyhR0/85FwFp944Emo3HIwWhxUzDuglTkDt/o2Br
 /NtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSGvIZ5VVr1zIkU/IZzWANZ9Ixwcgig8oCr1NfaTb0ylWdQtNOQduxZm60/8FGsseVekYZCNy65oQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGh+XLVRGbcvJfitFJIDD9e6df0qEIJXjyzT6F7xPJiNMFBnm0
 2U1b9jkXGK0VKKmzu6ypNAaOm5+2x2HZH/5jCHzGgtp8veK1KMgiKtYdZzrYdGb5skNy+k58nsR
 W9dGUKVFk7skefrtFcLvEs+QYJ1UTx6ZccqVfbwoYfacTXp4iV0zWcVsVt86WKQS5tn9DgVU=
X-Gm-Gg: AfdE7cnjw9bFdmcW6Yz5fV0J8w7GFciKrop+i7cNDXKJCy3uXo9K1ufoHQNcCX+F30j
 f0eEQLsKANgDuOfmDsEONYsF5V/s24qlQd4PoREDaoHCsvpzrSpISguPFujbZAG8btLRLm1HF6i
 bp0RHTNkAn7CS4OiL39Dewar+9T3VGd2qBkbq90b8oE0mgCebAF5OorXzsPuhDtJLEXLemvHCzd
 ezhTswajc3/mqf0A/ateHnAGUftQJuN10QHulqQW0uhHn4gE7GXV5R/hQVXlByiAclVNtAQvi8f
 O0ipHr2myDj8+/1CWkRqsFnd/R36CB5+Ao/GY7QtBz9Cv5Hx1weHlJYCfwVuycvxVl4AYr0gw/H
 91vME8I5ZOiYN4XLi2a2ac4xnRkBhM14Yn0Y=
X-Received: by 2002:a17:90b:3808:b0:37f:9ce0:af31 with SMTP id
 98e67ed59e1d1-3829f4e6e58mr958002a91.28.1783110944170; 
 Fri, 03 Jul 2026 13:35:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3808:b0:37f:9ce0:af31 with SMTP id
 98e67ed59e1d1-3829f4e6e58mr957959a91.28.1783110943675; 
 Fri, 03 Jul 2026 13:35:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:35:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:29 +0530
Subject: [PATCH v4 3/9] dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-3-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=1298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2jQmU1XEfwX7ksFDjORvPn6m0bWV65j9hgt3Tl3GEMo=;
 b=KNwcyIU5VqC/XQr4QH/U8KJlsgyT01EHf38v8j5tlJ2UjyZDi/yhU6ttLhTIayHlMRgIJ0PKZ
 lcgwcjlSFQYDI5rA10heEZb2fIAwdN9cVwv6HJVUEhVI+ZiVqtcHGSt
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX2YkjAuSn2Yss
 Y4Yf53L0rYknDdToYJmqrksuN9uYSQR38BvCuxxQMbf+A2MxBS94qRILuOFJwRD/aX4ngJ/aZSx
 ZOd1hwETq4gACU98Ivwe0rwohIPlk8w=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a481d20 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 4TRPwY42XoIkhoazuYfcqNuSO0ZTtYDz
X-Proofpoint-GUID: 4TRPwY42XoIkhoazuYfcqNuSO0ZTtYDz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXxZGiWFXERcZH
 I82Ydr5OZ7hyRnel41F02gAS5nAjRUg7MSxarh5FgOATUQp6gb0QtVCJqcvtcntlHdMxjn6wcwH
 xciJC6Ef7zawERH0cFBsIQWqd1WeAtp32BT6cb6uZhYF7S9l735vIhLG46Syezfzq1ZqiP3zjRj
 El5Kom4cMXUpLa6Z1+g2qx3KpeIY4fWlC09ohFPzjyvATIfbwiyHe/afxaQboMClR4sdZPIVSPF
 47Q5uj4iM01K6ysbnpDkreeoo/G+90GpmUIekugjtEQjFJqDn/2vGcetcCY4VxIXJcOzAMKy5YN
 aSTFXtUQsiGL/NDolbgDfd0qzuhem23nntql4V7oJ7zT5dTGzRY6GGRFodp49AR0CfQ5adPRUEu
 0/K6OCGrs5KMosYb4wu9G0t7luhNfeVh1ZrN+rsLBCgFb7aUW5tmAV3ZQQnVc8f+t8DXzrAXYJf
 dRWQ6G3TVIreo3HJA7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030208
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
2.54.0

