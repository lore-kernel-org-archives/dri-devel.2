Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4E4C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B262D10ECAF;
	Wed, 29 Jul 2026 15:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kwCMMNCN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f3N4MY8k";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DF310ECAD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:34:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3LIY2108372
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QUnH+rERyXcOOevFVTmjG9tv
 hkhekENrGxjVVTyR66s=; b=kwCMMNCNfZnAf8pOQmuZW8mEiYknC552j6RhMaKD
 QXbtrnsTBy7EJkGrp4cS3030eX0kyMc2YW166MHlRYIC1mAUmvq0XDJ06OHyOp7I
 CYMDK4gZXqTeIUAuOEdwc5/eNP2UBCRsPkM8OIKcMMP5ffkc4YZLeZcosdHyuZae
 86elXKl2WFhpzbKu2A6A86zZ8V3csxh0usCmIot+Iv2MdGu0Ew1fQZQT2gqN1EQD
 lR4ZvTPWqoWFWH0u7kJqX2xe0DPwjzXxnuaWENzg6/xXjHZe5bKcaYt6rSykmnaf
 dQDd6YLy1lotbwrf1iTiN7QfniDWmdOvFlpw6GgwyIzMOg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkds8bpn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:34:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d30035dso9719761cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785339242; x=1785944042;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QUnH+rERyXcOOevFVTmjG9tvhkhekENrGxjVVTyR66s=;
 b=f3N4MY8kO6GDX+eGnrXoqIjuzzJ0kQOmFt6qtU/Oa+obWpI0de2XATiSei0eYMzMlt
 h2yH1w9zLNmI5QWKUoROn8tynIJSyqsnEJVhh8qnvLCVPsGgJxDIfpSTARidNAHDopwK
 uz/C+YRrGcVoXF3iwf2JTVddM2mgFE6jmduI73ebZdc3PzOY4P9eMQtLWLqov35py6EV
 qC+bFQ9n3bYiO5xKybbnPrMEnypEMjnc4HIhx/9I+HS7KlBP5iOEZCN9CmVRdM/fWYcj
 11kM4Os/sPTv4CtyzCwSlSoGRa1Px2CtB7q7HGY2J/ttn1/TjFIvIuuWK5DBJWdPXnq2
 EbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339242; x=1785944042;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QUnH+rERyXcOOevFVTmjG9tvhkhekENrGxjVVTyR66s=;
 b=gRKmD8pJTIY07dzZCIN/wkJ4y3fD7oFlB2zjhZIeRiaburRUEnGkd5rLwyjoOYFY2U
 WGI9PsWKOP04CVFHlyxPm/SOnRBveJqmtOkacR7yXWgLd71GNotcb7tLeAJv4H7jAd5Z
 wxcl+biR0fNXo/kTWda5dTbb6YBa98ekQALZ1O5NkgRlvpJJJ7zXaHDycQ2RMgzIrjlU
 HxfNdtvR/i3BlRA85niWRkXqDMjh6kRO8HyXH0I+4gOInXjxwGAIJ1+IAvVekWMTHVv0
 KpzE/c/FlmpwJG9sw3tHgrasXt95BNbY1dLhsBopOgNCPBVAMEZmMd0JTWfnjG/BlS4r
 NVPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoO+ZAw7PQ8LkPyMMXqBgl4q/yjZKLvh8DAHHv6BjNZqxgm0E5M2Z5Cvk2dm8tsJe/0wQcac3fB+8Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNq0PIy9fzZAikUiB83/G4f1s5XC2tgEwa5wM+AZgjnVCetSa7
 SjxUUVJeo7aiYZiNfoh3OfvVh0EjUJkPSv8W+V5jP3grX2K4zitGnkGyGskfIX3Ubqslqd8UghB
 GeyeR206NLy5jHrWwBjHwG/ynOdsVAD1ydClvagWa4gRG1k51pgur8TwyisRucVmDD2RR47o=
X-Gm-Gg: AR+sD12QCOkuJLMzHfzWaFsrYLQyY6tPk+TUPQcQDdFLpa/m3l4K6sbdnvarbMpNMCY
 KKq1f1dET8b5vKTn4KQcdnMvhFO0Q7HLn49diLG6KPALAuSO+pQt+r4O9GqpZoJNgFXGp9euq+n
 9dXsnpm/N+7knt5jNG85HQ5Jtqb0XU0op/KKWyOt4wPnrU0kPTMlznB7T5BoD89NddR963jtM7B
 NzmgAGZHs8zuy99ou6C2RJSo1MXQx/p04us4gIM8h/AlVSVB0PXG2x0wkxzTpVG4uaiBg8mSWG+
 ZZ/rBypijwmv4Ij7gX5yiAWF14n2Mv1TqAdIBmTMpxJHimCpnReo/swa4fG7RUcqZ3sRJftX7xW
 goa1jDx6ktQB0Ew8=
X-Received: by 2002:ac8:5885:0:b0:51c:640:231f with SMTP id
 d75a77b69052e-529d70d6591mr71296631cf.45.1785339241919; 
 Wed, 29 Jul 2026 08:34:01 -0700 (PDT)
X-Received: by 2002:ac8:5885:0:b0:51c:640:231f with SMTP id
 d75a77b69052e-529d70d6591mr71295911cf.45.1785339241231; 
 Wed, 29 Jul 2026 08:34:01 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa3b1csm9218589f8f.1.2026.07.29.08.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:34:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:33:57 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: eliza: Add GPU nodes
Message-ID: <gpqulnkjhpp3oqin3xouxcyytfpnaw6bckmmutbzdebfmnrdvv@ylnrzbznwwcn>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
 <20260718-eliza-gpu-v2-7-64379dbebd7a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-eliza-gpu-v2-7-64379dbebd7a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX5QdsBbEEaTDw
 pHdebRQipwLu0i+zO7KD2Zf0Y585+fNdmaCzXOp0q2JFi/qhdHm6q+8DxQuI2BddFV/zHoILOr8
 v91wNB2FodFul1YD72oFhR6UinbXLFg=
X-Proofpoint-ORIG-GUID: ddWV4JihIi-2KtfL6epymvUy4MPDO6ud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX5WrQaKhxWVwQ
 kfAPHfX2XD5Tw9rVMUzgn3dxL/B07Y6+jN07nD61QOyELr/aetFAyc/MrnaRX4FnX8BO2t49oR9
 7gyKx0c/wLz1+WS6Ns+UVqFU4ODa9OksA3Lm7A6vrKgpm1DYnDyuJtae8Rj4rku5kg51gtONBD6
 k01iwXMysNLpBMotx9cRGnOegGMxFwlsRXnUK81RV7D+na0j+XypNkUBHC8ACXaq9efxdG89Nmj
 sQIkW4CiHlEoAV1nBkOEm7LoKpjwxnbCFfWOWx81WOoEvGUo46SzZE+LYOtimhQaUV+fL6qaus0
 4uCPIDLPk3nyDmZGfDb5wPLnXJLrIpJNY9K1usCOikzneXfb+yQqoVlMh+1SoWdtggHCtgan0IU
 8wqm5CkjvlmoxThyetacWoUES4tAwmBTZKv/aWnufv2LLkxb52ULn6n6Xu7vzALlkphUcbcWMd1
 WVsSG/o3dKjjIRIg39g==
X-Authority-Analysis: v=2.4 cv=VJTtWdPX c=1 sm=1 tr=0 ts=6a6a1d6b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=LzKdWfoJb4QxxMUDPeAA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: ddWV4JihIi-2KtfL6epymvUy4MPDO6ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290125
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

On 26-07-18 02:11:32, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Adreno 722 found in Eliza chipset belongs to the A7x GEN1 family. It is
> derived from A730 and shares the same IP-level configurations: HWCG
> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
> Major differences include lower cache/core counts, 1MB GMEM, no
> Concurrent Binning & LPAC support. Some of the peripheral blocks like
> RSCC are from A740 that resulted in updates to RSC layout.
> 
> Add the necessary devicetree nodes to describe this GPU.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
