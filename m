Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547DBC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA95A10E903;
	Tue, 15 Sep 2026 21:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8O/E+cH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VlrcTrqm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38A510E8D6
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:20:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FItnen3342365
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 chAJluwUiQNqr4LZZnWIA9G5yILa+6S7/Y3KKqeYuRQ=; b=P8O/E+cH5ZhO7tUU
 u5TgnSJyp5SvxJfPD1XY6QBLo30991IkgTRGJaNCEdHexZ+skk66jvReoHmr9iqS
 OJLWi0Sic4zahwuOwJpBxFGQQsWhGlBth7c/fC1EoaJMDImznPFUgwVVJS06t72x
 MntpxGT7INviqcfOpN8PcWp/HsqqcTVIOIlY2kPRS7sbd9Ce0bKfO4RMA5MRsxTL
 VMafdTLjTteSwTz5ZWEyfpuVbe9X/fTr0in7CwzJSAjIx2fOuDwXb3Z6RaT2fSgu
 RL3IPdXXossl7N1Exai+0LtAfLfcyn7OjL3eR1k4Ep6i8JA73nWHDlrCK3rInRcv
 f4OMUg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq1qpc95r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:20:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc489e7a701so6991274a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789507255; x=1790112055;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=chAJluwUiQNqr4LZZnWIA9G5yILa+6S7/Y3KKqeYuRQ=;
 b=VlrcTrqmizbtcJvvGfeb9y/OvuI7/UvxI4f5JvdCzOqXUAoVzdiObYoGlKrPq9UpR/
 JZK5y+jcIUGFZul02ana4th8vNL2wuxnAfTSzGm7YGqbejmt3NoC5JXx9r2xgjHX/pGt
 z4kSElE/pldZEUqLExf0ta6lFUJO1GRehjmdSsW9TV06abRXxzhp2DZ/Ob7EjugCsJKM
 o7ttab+ob1nT8PgGg9FQaz+81GAmT59ailcAUkKYSN/IgjfgAl5cidzZYERZ1NoMx/UM
 Ss4WnRw231yZoE3+tzvWm8NOb5deWY0D+PobDbT8ds2yt3GENonTzVorYpMMSv0ApE2v
 c1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789507255; x=1790112055;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chAJluwUiQNqr4LZZnWIA9G5yILa+6S7/Y3KKqeYuRQ=;
 b=gSO0myebjxu7GlKtEuGqLNPFurelr3yv/qvXwifUcWcuqIEuMICmHSE4EpDZc+dFCl
 ukT0Iu96q8vvkdGQG/qKGVgEyr8+vv4wOCxKjiCnnj8LROAuEMSjHvOy8vgMb0+1FIXC
 YLyT6/QbNPST/0Rc42LYUu/Cn5Nu9OuTdChM6fbp29WcNYDJjinn7p4ZserIgHECCIti
 Gb9pHTqlGWv/kedq2WTaj95szku+iAzRjcWEmh4dtG7+aNUlLcGbc9e4gAwNnpQskRzk
 RlpUr7XuRGaAeJ+3V7QQhPrsFLHBXkoKMo3mtDR2I6/R8edBWIt/BFRsa/DbXLF2Y0gS
 eLXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7EhKpzGrR6LCYF1mcDhGfoXX8OCMrmF/lR+X8qT02GIYjcxEoOjhAv0+uIxurmRQpB3H0QNRS3aE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPhvrL953FSpKeuC1aPPVFAKGQRW28h9m5SyHMrh4E+AryMOi5
 SQDtljXsi5XeKNZj6t9qY7lfYQIOgf0bY7/p8Lp7dbF7ydDnzczxLTanx5HTxFvrJTlEI3ei6ky
 KbmpVVDWK+/PsxQoF+0nVpMgJbPpdAHLOy7+1xOmGbROAkKKhBuWCn6sDiGF5gmuHDLgy2Uw=
X-Gm-Gg: AYBFou2VkOeC35mpYeP0pKEaz6Tmkr3gUPTQQ7IVOl/29tVx99j9xeVLWFFIoyMFKto
 E+BA+CH7HYXK8FSIVPUHbnYycU8O9agmVnfm188oqH75d3qmvCpBlLmc2akVH1HaXq/3r5C4ory
 z3ZwJ1n1npuadpulDXmZiYixjdyc0fSpWfS2mFYbAnTAqsm9O+tvqWtEbQG8TKWAqJkfEUC4cBM
 Cggv8tSjXLntC328Dljr5QXqQVUWbkterILDxsrA4S7+62Gs7qBMeqH/qFuZRgBAzxBBaoJKaeU
 gef9ASdd5zc3irGrsas4e7ySzpHwezDpCrS03WnIFtqWmo2GJI/IUrNTzO21AWqMLwaYkVbuGTp
 ZWAbnGMut1/Fw2M8sv3XR12qLgQ==
X-Received: by 2002:a17:90b:390e:b0:39e:53a:c8d4 with SMTP id
 98e67ed59e1d1-39e1e424a7dmr277885a91.12.1789507254616; 
 Tue, 15 Sep 2026 14:20:54 -0700 (PDT)
X-Received: by 2002:a17:90b:390e:b0:39e:53a:c8d4 with SMTP id
 98e67ed59e1d1-39e1e424a7dmr277857a91.12.1789507254153; 
 Tue, 15 Sep 2026 14:20:54 -0700 (PDT)
Received: from [192.168.1.15] ([106.222.230.202])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a166sm1717762eec.10.2026.09.15.14.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 14:20:53 -0700 (PDT)
Message-ID: <7128505e-c8c9-4d00-96f9-2576ea2a0fda@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 02:50:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/msm/a6xx: use correct timestamp counter on
 A750 GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMxMiBTYWx0ZWRfX+/MFSE2waXgj
 D7LApvyJcANNGDyJ2wpwJm5sjB8zNLShYgTcHvvNY3QNVAkJcpIdZ8AlJYZI0RB1I23IKDFNm2V
 yJZJMM5FcKCemypeZB9h/e83wMw1rSo=
X-Authority-Analysis: v=2.4 cv=I4Xw19gg c=1 sm=1 tr=0 ts=6aa9b6b7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=BSf2YShhMxZyV2bg4MjkLg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Nyh0hyempXrTQnLp8KQA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dahI2dzzFOsHTE7Mwns3N99ulvnZEKO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMxMiBTYWx0ZWRfX7B9sPpXELlhf
 MEbEx8kOFSsDKitcAXaLkFnevIJuvJEFHkRQfe8kihhxvexV2DfJBQAEm+MSiW4cjNHe1KNXjCF
 Vu6LdGQrdEFGrDRIDJ9IlgAGobeDzi5fyed0VpLT166J7CHbN91MttFCdJJm930K/dl5CzHkPC9
 KaBI1yblCKeusJyeF2QNsGZp5q/ofPjAxdiiYNQgVF25aV5kYJe2nd4u0bTXkLHLO7MEgenxCtJ
 Deev7K123P3JIwUB2CA25YpFOZZ+bQ/78kolBvunYBJg2PrQGllLsEgENobEB1eqcs7UCc98QI2
 vEf2SLHENuDzpLEmEurN4T6SYpgzE6jA89Dk73c0vXT/Rcr+CLnp5+UvmFiA63BlHoeaIdO0ADF
 6bOyva65M7cM+MHklxhLhDhFNdOeHvkPtEmw5JLmW7RNQipFpbzGTpwPuBwEm85ml6mNcsYCuFN
 m5RnHvc8062LTHLtdGw==
X-Proofpoint-GUID: dahI2dzzFOsHTE7Mwns3N99ulvnZEKO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150312
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



On 9/9/2026 6:37 PM, Neil Armstrong wrote:
> The A750 uses a different counter register as used on the downstream
> driver:
> 
> static u64 gen7_9_0_read_alwayson(struct adreno_device *adreno_dev)
> {
> ...
> 	/* Always use the GMU AO counter when doing a AHB read */
> 	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_HI, &hi);
> 	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_LO, &lo);
> ...
> }
> 
> gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_LO		0x1f880
> gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_HI		0x1f881
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

This is correct. There was a register shuffling in the gmu_cx block in a750 and another shuffling later in gen8 family.

It is a good idea to review other GMU_CX* register offsets with KGSL. Also, please consider including a fixes tag.

-Akhil.


> ---
> Changes in v2:
> - Fix swapped H/L registers in XML
> - Link to v1: https://patch.msgid.link/20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org
> 
> ---
> Neil Armstrong (2):
>       drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs
>       drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 12 +++++++++---
>  drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  2 ++
>  2 files changed, 11 insertions(+), 3 deletions(-)
> ---
> base-commit: df2908090cda368b01ff43709f51890076c56157
> change-id: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d
> 
> Best regards,
> --  
> Neil Armstrong <neil.armstrong@linaro.org>

