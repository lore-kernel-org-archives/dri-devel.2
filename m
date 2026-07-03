Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAF2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A6710F8F8;
	Fri,  3 Jul 2026 20:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bkVbzb/m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FgAUB5yz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B42310F8F8
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:35:27 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPuHi1031407
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=; b=bkVbzb/m/+c8R/ds
 OquV2I1Ep8YCvaIC++gxM4vg7K7PZSyc4jMj+AKyLx7efXnU0ngZBlfbyE/mz8zx
 QoBQ5aHHH4Omjfwr6F1zNttJLcZsyTllra9bIKwHyEXb4rO5nagPVeFhUP54TACx
 BN9fYt8B7UxDdMnN0szkJvvg0GJLKEAjAQ9/9220RZT361nl7NK6ut2o/3loNwy9
 ohJeLY82VilBIvVO6UhCaERmW7I9zGtDYy86C6yqUarNARTNCN+WJ3Btlw+T4040
 eI4rQ9QPKPG5sicGAXAes68UDQNbBYYCHYOHpDUt2rb4I3IVUCtIxAimKEXqF8P/
 pa15gw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bw1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:35:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so946818a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110926; x=1783715726;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
 b=FgAUB5yzQaa4VX9CYD7cWTh8gXiGjncs33D8ZXn0zSSdAobO8GmYOaCJxNVBwoeG4m
 Uk8IwCAFiiew8sa2LkOPRqDXNLIIDk9UzlhzsFxrJoCd591ASCERqP4CvkxW8fgtI0Uy
 arhAVLwNH/K2O6GP84BhXZ0iX+h6NeB1HKtYFDY1REKE46N31BwWgSKENRhZP4dyJrk8
 KR6ljCzWY3mzSJ4yEQpF6i87TFXzjNtieTyFQPVZpYw+CRoAeonE54K/ZnJnE1Mjn1YJ
 ztujNFtHbDYEaIsYLm1BPHGGm9pwOcobIdfEUjPFnBRTLcEEVLxp+ItUj0COROvzua/O
 U75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110926; x=1783715726;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
 b=KHg0VyNmiwCapsC0GZYTqQBUIDVmdOQhc4k+m6x5NMFeHMbz1ws8NUbDudtguKfGWa
 zfDjH6Fz49ClnEu8CJ2JylchR5dT+ZE6MEeU5XTic1ehebG9Yd1P2bPNQzQ7L/OFEu/7
 +cMeQ4ZveiTZmiiwn/GKfF+wAUnwebXw2sF2QqWlli/Ma8hH4hPRnJ4Kjxj/hji6iKb7
 73Gt5P7Gog58/xnwfNY6ev/y/I45GbHaNrbwkEW+/DASdYlYPkqdQ8OH6x6FYQ8VNVAM
 SUksWMhwyqb5b1593MQ76k6UO4NGUfAd37YKKb4qCpYtAHrR1CHgPpIT0DJSgifLtcDn
 zPzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKD4+GxxtoAYVMTar1dJa+rNvxGbA4ngvuvLv/8/EedemxLD14P728R5KAwM41wRQtCGLfeEQZkcg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+rfxzwnGlgiiY98lvwPoo15jZwFY4DCH8s8gtJ45ywIDmXA0Z
 2lFFnF2r4VEFrU7j8TySDtADmBACGi4di0IGqLnqUk8Hg1yCE4hY1qIEZRXZ8VsgJ7FbmMi/uEf
 IZxYED1bjjC+QyxZiVmR2J74zO0xdUNakBCnq8eXk+YQMYQTTWSUz1Ws5f2XSeOmHdBnjqBE=
X-Gm-Gg: AfdE7ckGqGJneeUHz9JtOcHgtRJFS/3NgUYaumsH06VWtG9jmrqMIyYXYHVzSIcluu4
 9zaJBEVEYw1vbwlu2cHn30HxoTVZ14yQcRYx5hcPWdThVBry2IdO1nfvURnTfE6R4MAuwKSyhvb
 IccJQxjJXxCF3i4JHBakDpoyGsiYRDSExq9asnMSdnESF2W7TAN/vHE8C/2lkuxt9XfMKfcitCY
 keVLDS9dT305lBVm8B1hNkJboZYMh2UMzwPHgL4XGPm4mkI3BSzrFsA1K8sRG81EP1Ny1Zokwis
 R5KPOreyimYMVqWI/vw8UOjEIIL06w8funTeblbS0sGYSJXGCFQs9QTudSgTqoFWv05jAzqrnCf
 hxNLTbtHdSXzIIg9RMPx5U8RUzi+cjm7jKw8=
X-Received: by 2002:a17:90b:4c4c:b0:37f:eeeb:646b with SMTP id
 98e67ed59e1d1-382800d2225mr1038696a91.3.1783110926360; 
 Fri, 03 Jul 2026 13:35:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4c:b0:37f:eeeb:646b with SMTP id
 98e67ed59e1d1-382800d2225mr1038664a91.3.1783110925866; 
 Fri, 03 Jul 2026 13:35:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:35:25 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:27 +0530
Subject: [PATCH v4 1/9] dt-bindings: display/msm/gpu: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-1-90cf1a52e539@oss.qualcomm.com>
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
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=e0reXjU4841qQsB76OT4bfKmGmY/z//RRWVRYHDWGzM=;
 b=366NlHMFnKH7Fuj62J9JVaF1Nr8CsES6ABTopFiQsD6b4y9xxXYodoaDhxIvDxQzXBPtTPNRB
 4O++nujOYdvChSFrKzJQei8xwwbHJTOg5lXp9iD3kMBWnYPuMWgEJpm
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX1JIyeGnjK33d
 QZq42AkkFhAhcij2IVsVSY06A5tVWaPIssDiT9OSRi0E38eEIdD5DNwYkFNABoRWTDotwZVODOQ
 DlWk+Hi3Hy2CLrK3MfxkV/Br7G0ed90=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a481d0f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 3fZhylNq0VhsyQ30fZQgwNsTMTgpgu85
X-Proofpoint-GUID: 3fZhylNq0VhsyQ30fZQgwNsTMTgpgu85
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX1h+kMkxeuTzW
 PbvzMnJeu9vwo7eYRLC143yFgrDYLYUVi1PAZvH7PR3GRzt9+qQ3g98boo2En5YZdSX9r7dX240
 Xj9Xsz/VHrwx9f6ZvuzjQqqZOJrPy2FdXQkCLp5LF2tUzogwwlptJaubJByUZHA16T8bSXMohA/
 J45RTm76kV/W9JWAKaZ6uvTy6wYS4hYmUKI8zqaRUYKo3Ly5FLWSvxBPmGkTaSqIBnmP+SDXI2D
 0PTBnG0aXCAFhrrHedWefL0mbwZfat6SSsHTXAUNOfjc6RCANZKsHuqtuVNIg9yfCmABn94aLq9
 /9Z3Gfy733bAdpMhOm66S7G1SIPyPf5sbuUTj8PZEXLYD77JpZ0hfg9GXprVEbq3mIGMdXeoVRT
 MwFVOSuOcniMh7txtOso4fiEo5XRiA/QdRs0ZOtqP6GKNYerKAn72R95pm+auX/i5fSxBXmTiU4
 enw0h048ujja33ifobw==
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.54.0

