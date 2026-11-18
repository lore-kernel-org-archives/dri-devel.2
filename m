Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED60606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iHsP0uPW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aRPa+9xH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A4710FF5D;
	Wed, 18 Nov 2026 18:50:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E7910FF5D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:50:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHG6fk401575
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G6fSMtRefayhZI5g3aR9XsfohDmCy0PJvzpqSftD5bQ=; b=iHsP0uPWNbZEl11k
 Q8Uuy0Ax70dRrgth9uQGkV9jWJCgNxJu9cKOmwRTbNJ+trEEMyMZextqDFnJkNCQ
 e9q1XghSK+7klBiQJvmB06OdHje5QRvR2J0hjMQlj8QgNQ9nosh9PV0YsmBpcA28
 0DpAHl4B/EhHU9XJUITKSdpZzktgBCPXflWFetqvKUnhoKdUZ8bmCAOI5qsr2fyy
 KuCwgX4DEYttanATHwSeMp4bL7LmzAbk3vsFY1aaI4hm50MArsxWoqSWmFQDMbEE
 K5nITVOPH93HT8ElbuFzXit7+26i+hjFvLlrO+295XTqZbGhvsQHLedkExmialxs
 R0bEUw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1e5qs324-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:50:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ee04c49451so16752605ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795027843; x=1795632643;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G6fSMtRefayhZI5g3aR9XsfohDmCy0PJvzpqSftD5bQ=;
 b=aRPa+9xHEt+g4SCtlkxrRPus1r6tF0tLVV4JBc39MMTpjqnYAwSb0Qsn8i6F/f/nTA
 xgMIuGg2OYl3plkVwD4fZ3dGzbKI28xD6sHeucRpXvBubHvieJBKo/oOQpF8MpRvrdns
 EgSAKzd6PkooIgoCmU8JwKatocTRq/zgUfTSMbEObnbOo1NjtROA2U3OfOMJuzZ+3Z5N
 WzKyFl159U0uKz4tor1IGdCladlsDKOeyfk8j2Gg8ilt94C4f/Rzf9ynAmC62vziBvwR
 QGofDcUARgj/Xvhwmm3lB7bydMUZi3zg8jqvvad5EJ9MHHQcL/TPG3RDNVO2vd78G9JW
 /nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027843; x=1795632643;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G6fSMtRefayhZI5g3aR9XsfohDmCy0PJvzpqSftD5bQ=;
 b=xlJyhNvoGWND4ni6ufBIHdD84nsIIxIa87vBdsJE0fVxW776zuX4Fs0JD/vBZ9B3yX
 HjR1AxNn66iDuRTubG5GmXu0Mmfb2fIFThDqkmr4CXbHSxCuvfVikQ9wQmirb/e7bXfn
 dg8ZveftxQoa/Nootz6iY6XfLvGKk5pCof7ivaFQpcD2DSuMVCnTHPdBv/zyr9bm65GR
 1UIN1Nesf/gbclB5Ntvv0oZPuR6yEoAVsgWJ1XamNLtWjKf7YUUX7GVBZqW3sEXw7Tnf
 WtmElMwDCUpXxX+Bd+v3prjsYq31eKvL/liMMxs5oyqbT2Ba9zcc+dAQnLDBUVR78Hsw
 2Uxw==
X-Forwarded-Encrypted: i=1;
 AL+hErGTf+hTazVE/dUCQ0y0tt3DwcIDAFG/Hrq+lJzlSM4HbIU02rU1py5J+1sNLYWyLXi8ayoEJCTViQo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9BN6ansFuXYkDtP39WUqJ9t6c6Q5ft9hmm/zw+2TSr652B5xHX
 HPV5iI8MxDSk1cRfKVvWCn2fTdh/FATEWYffXAuSdYg2h4lE5rmvTyEuZaXNAivjLPR+2h0Za2x
 /COwiApdeklwlZ7ifZDkzf6C+VfMADk5Tb7jTyKM1W24YxvTKZKFumM5dipRxre/f99ki/gc=
X-Gm-Gg: AZFdTZcFc1BLMN2l18HZbKIWPYhMDy5GRglOku4FIJ20+9JScDZvVeFiLsCEV5x+yWQ
 qNl4f1jq1av9vP1bWdOWuiTVgDz/KOGmDUUf+cAQMI9MX/QAYp7PxzsZTTF8xwo0mIqIUIrHcSh
 hYWTuw13SdF5F/BaIYVUQDvTfUfZpKs+zPIzY/m095y+2QvjAIi3Brnc1aa7A/mircSGBqMJcfC
 yUdXdehqtpMRgb7KbOODQy+CMkzWttTMnG9vaM6PxhIBtt++vIHRjesZhGkR+J/8yf1+J1GHCvC
 WAN77IaXqVqa3w7rNf4//Q9UDkvo+/1b3XwglVvA5DMUHMr7vcGbNMDLFxCikCafiW0SQQ1Tjsk
 wrqVAocav5zSiyLVtRKubGEO3m1sGUJVJzwIVYCrMzQyvE8SEC65raVtzaPyrdOna8uU9Qg3jWQ
 ==
X-Received: by 2002:a17:90a:fc50:b0:3a8:185:cf40 with SMTP id
 98e67ed59e1d1-3b3d07598f0mr3522907a91.10.1795027842658; 
 Wed, 18 Nov 2026 10:50:42 -0800 (PST)
X-Received: by 2002:a17:90a:fc50:b0:3a8:185:cf40 with SMTP id
 98e67ed59e1d1-3b3d07598f0mr3522890a91.10.1795027842199; 
 Wed, 18 Nov 2026 10:50:42 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3f6bbe469sm469942a91.11.2026.11.18.10.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 10:50:41 -0800 (PST)
Message-ID: <3b9e65b1-2b7e-4310-924f-ca190a0ce91d@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 00:20:33 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: shikra: Describe the GPU CX SMMU
 aperture
To: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
 <20261118-adreno-scm-fallback-v1-6-e99cdbf3121d@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-6-e99cdbf3121d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k5gG_p14F2lvhfO2K774NH5VukqAVyf-
X-Authority-Analysis: v=2.4 cv=c5Q+0h9l c=1 sm=1 tr=0 ts=6afdf383 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2DaYFnQSzUVrrlYHPwYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX+3KKqAHnje1w
 1FCG67xrsiwFS5tsDFNLlp3g+KxArYeQVtHFkUTd7KOSLms6FE7bQJc5m7XxQs7gfR+4IFL0vC4
 Z+RVt3TEjPjTeXPBheEpKmLmQgZDVaE=
X-Proofpoint-GUID: k5gG_p14F2lvhfO2K774NH5VukqAVyf-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX18p+OVlERxDs
 6XDmaCDhasmuw3CPFElDDIZA/LQ7HgJnPeGIMMblEQPfNbngvNstEDF9NVi0ZcYybFyAth2WJnT
 jsU0aMwsPgUxQZGgF41z9LKCH7VM7ZiAa2KIFf/1bQlXEmvzc3l3HRJvs6w9u/YVESrItR4xkIL
 KTL97YUYRWDV/QevxvsWf28OKIrA3oe2tlQc93z1NYSDWpwc+K1qyHxsiH0acebU9yEttKo4xSJ
 7EpgfCNqGg+bfslcv8I51l0+FPzT6a9FDvNtH5fn2g+kRiK5p501R2VoHIsXxzd690ezIoTSMp1
 8e4yS7BU8xYNdraqnpKDZmH5nSznD4u/R/idUr9v2L/bmE35NqXQY7JMeAruwfFNVJnGAtF8mry
 gN+6JzHIPk/5uXI9bzucrX4zfFfodPIV/Sj62T9v24Sjg4KUKNflPAbc9bgr48/+aGJIGMf+EFQ
 iG7jkhHphp8M8IUm7CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180074
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/2026 6:38 PM, Puranam V G Tejaswi wrote:
> Add the CX SMMU aperture register region to the GPU node.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index 0a95ad5a5582..ebbe5e23d173 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -2647,10 +2647,12 @@ gpu: gpu@5900000 {
>  			compatible = "qcom,adreno-07000400", "qcom,adreno";
>  			reg = <0x0 0x05900000 0x0 0x40000>,
>  			      <0x0 0x0599e000 0x0 0x1000>,
> -			      <0x0 0x05961000 0x0 0x800>;
> +			      <0x0 0x05961000 0x0 0x800>,
> +			      <0x0 0x05960000 0x0 0x1000>;
>  			reg-names = "kgsl_3d0_reg_memory",
>  				    "cx_mem",
> -				    "cx_dbgc";
> +				    "cx_dbgc",
> +				    "aperture";
>  
>  			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>;
>  
> 

