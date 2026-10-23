Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7E60A263C
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mLGHNjZ7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y9AjLVyX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B90112AA8;
	Fri, 23 Oct 2026 10:04:02 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE3B112AC5
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:03:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F7WS3154001
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iOomS8sJJA+g1LuOJyNNfjwxlhWVKpv3aLO7udUuLI0=; b=mLGHNjZ7FQaMcyGK
 8pqEg/gVX+Wy4nm7/BRD3lOKUrlxq2WiiPV8ys/NiunCPYvy/Mn9sPrrffm6giKK
 HnAyiR4XJTPFLMe8e2ghwsz6S4aWt/EEf2yT+LjaC3XTJr744+PminRBS5VeEbtK
 vvGYEOmcfmNJtMZtfXLRuigFeVUJPCvdJpiYXZR2qw97rlVei8Ln+fRx6k3BeXg+
 nyqPFlZiQSYWT1w6QnToNc6r5M+YN2QzU9aT/HATeKmqnaXDzg0VJtt/n2IBxU6y
 8CNcYSmIJkgtGv8Q584mGiBbc3DCwIP6FNHxWCQi2W7fA16UEgB90CojchPgKq0o
 AZG4Xw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrb3yh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:03:50 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eb86091358so9386e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792749830; x=1793354630;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iOomS8sJJA+g1LuOJyNNfjwxlhWVKpv3aLO7udUuLI0=;
 b=Y9AjLVyX6MH12N2g6vC9lOqMkb2MdHqNH6cIbsG9UhN/Ht9vgbZJ4yfqKBIuCK4OCF
 I095jyvQNGs5U/AhCZiieWhDz4CBxtIVbCjNlOi5eh+XHZHHSCUC/y7Idb2C+7FB0yp4
 xasLRSpRQtApXOX/orDN6QudPDFROM3NuK+YFsFQoytrgLpR41GALIlaIu+w7UZRaHyt
 QWFi7sfQmuBaplrnG0F6CmjZcDCvZ8SvaVvNmoC+7fGndrXPlfOMXca8BihJ2Yi7zqKB
 xTymisblQaW3frD/AMr4ena49dKlq8XF3tenTajS1amY/5J1rHs5FCqikBGbOFFaOl8m
 I7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792749830; x=1793354630;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iOomS8sJJA+g1LuOJyNNfjwxlhWVKpv3aLO7udUuLI0=;
 b=yTDbp3ICjrx8W1A1vsd09XzanuGapZPONmp4RyLvij4sgOJ05JLbv84cSrL04jv+db
 m1CQ3es+paQqyPJPPTZq5Y2deHryZdqwIJqapXlB6/6+EHf1lwVYOQi6Zcs+v6a5F2tN
 yqCGHMa3ftA7gWHSBoCnWnREY62ubxLMiWivYhWSjaF/5HbZYAyy6L76LGX86wFfEVem
 KyUao6GZ4Ld0L1aNmGpYlgpv/olnvGd3XPxilB/3eYAz2EwzkPs6BORwRj0IxptgF34x
 C8OmoVrY2BL8AKQrNk1aAEh61hFU8by45h2G2IPLpGey6VYKNJHvntd8oQ7aEfLT72ro
 oTvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQXPxxY7N2LWbCN5Uw7VWlce5s3RssfCL+ZK7W+ZKLosIIrViy6kG9hAk+/gG+EXnRMaZ1R5UAtv0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLrME61K+C5PWzkPmDOSzivQ3R9Tbvksgd9r7l439OgGfIb4kLX
 VqzoLmb0nkTAVu2U9lGFhutHN0Au+Jrkj52s9ph4re5+fnWV0ZFqZ4uJFYz8tx2Ap1DUDNBP3iu
 wSVaugVicJ8xj8vfrS11m9WKHl4/IM7ADJMtsCK7mk1NPmZLEqfvHvODJHNS6Vl9jW6tFWOc=
X-Gm-Gg: AYBFou2nrhbTrkZfXAWS8EzvaoFTJ78OZqbtdXnM2d6OBTKFRsJ+6zZBvrBziLSz966
 8bTFvpqz09Qc9mgAELz8t9eBRIpVRQfeRnMrPwQXcmY5kQsh71KBodcrfLtLVweFtnMDGsN/4C9
 a/gIXkDGLS1TV3fogW7beERkIotN2S34Fc+DW28TWvGL6NXnD2fZQjPzyW+vX3/ZoR17yNUQw06
 R93ATBWV7HXKcuJ1Pjkmb1btYsu/frTk02rUxtKCFuySA3/RIpN4Fyk6XHMheYmNo1Qz8FiWSPl
 lglODmKZ/8MsN+7ZCOKLVvTAiFt6j7sGDqOeVoAp4RJp6dSAMCIOE9dGTJE+wrV/Dr9acwo1cjH
 Z0vJmLahhAtP9OFEDTuUyLw==
X-Received: by 2002:a05:6102:8648:10b0:7cc:22a0:de89 with SMTP id
 ada2fe7eead31-7ccc3313669mr512065137.3.1792749829597; 
 Fri, 23 Oct 2026 03:03:49 -0700 (PDT)
X-Received: by 2002:a05:6102:8648:10b0:7cc:22a0:de89 with SMTP id
 ada2fe7eead31-7ccc3313669mr512050137.3.1792749829147; 
 Fri, 23 Oct 2026 03:03:49 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5cfa594sm84380366b.80.2026.10.23.03.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:03:48 -0700 (PDT)
Message-ID: <70d5ef70-00c7-4265-b2aa-3a784d4f0d1a@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:03:44 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
 <20261023-msm_gdsc2-v4-3-40b6a71d4e3f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023-msm_gdsc2-v4-3-40b6a71d4e3f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -slxy4wuojJv_XEOfssHARF12GBcy7NI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX/b1ibqlS3XM9
 lTM/HDdmHvNPypJ7f1scKZsWH6Q2J44S4As7FaSLHCG3YN1CJOfvFK9Xr03I557VvmM6GykGJRP
 vZ6KsEbw0LhXretmDR5aEf0TLBBUHbA=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb3106 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6bGC0mKcvBxu2wzPFmMA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX1LiVoTnWafm3
 UpwLP7uE3y6B+rUAOsnX1YDf/vJRpc8PMKltb1I+z+8RnzaLwi/z4RzVcBcvl4ZgVc7XZW2tcGM
 +Pkr7upzDE31K0DI7XQ1clKNF0lVY5BBj2H2cLLvobXmbwFvEeecOf9zDUpw0KPbBYZcF49W+/j
 MJ744mFJ6IleBtvkSXk7VeISl5WOFIcAIoWJdzXQuzJrmcutpkTVhXvDPdV2C5zptJw7QrsYPlW
 OJdGe9gC4e8/dFKfn/IKXVEqWG5mLLLtXnVwNn5GSuxbJwLDk199SuCT6fIhoj+6x7Etqiv+K6Z
 fctwsUDVDo8sidd6V+UrGeQtRc/KDOb8taHABFTpxoi250l3uHrCoVWg4890IlRPZ5PYDYfIQQg
 d9agNwiEcJm9H4UfWuZlHF12o0t3dGc2b16ApsT9135q/7X0Y6xEBfiyYhXetBFbZzxnZwut7rF
 22PREnreGppew1DJxOQ==
X-Proofpoint-ORIG-GUID: -slxy4wuojJv_XEOfssHARF12GBcy7NI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230039
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 10:13 AM, Yongxing Mou wrote:
> The INT2 GDSC on Kaanapali (SM8850) powers the VIG2, VIG3 and DMA5
> source pipes. Without enabling it, these pipes remain inaccessible.
> 
> The DPU is supplied by both CORE and INT2, so describe both GDSCs as
> its power domains rather than attaching the DPU directly to their
> parent MMCX domain.
> 
> Keep CORE attached to the parent MDSS device because it also supplies
> shared MDSS hardware outside the DPU.
> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
