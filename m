Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEAF105F78F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF2D10EB72;
	Fri, 13 Mar 2026 10:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hIosWTDY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="abBZ7zro";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD7A10EB72
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:19:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5tdpw3229896
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LFJr93g+gvzJomEerwFbGRLs36qbntliWexUDx+bAtg=; b=hIosWTDY0aM6amfz
 aMTQjkO/31Q8KLzkUqubCKC0NTDF90ia28DAxSKccLEJS17kTqR3NFXFEUfoUEZ/
 Q12plSPBzIeBRV4TqZOM/kiyakCN8keI7vg1mHj7ndujd0BxcRBXusXqCvj/NmEa
 E3Wzyi22JaN8FU0SqtuiL+oCyHBZJGDhPhnq+US2mzU9Q5R9rD9CFXYxgeDI6/uE
 NgL7hV77aZUVlJwOPiapuy/5virWkla3xz7TueawhOyf7VDc8Ve32t7mXpOtado3
 L0eVq8+FuzjEvRPMKmzCPinAcQZzJM4VonzXJBXoQXTlOekzJa9A7QrH2gzgI45G
 tDMI4g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7hpvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:19:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899fcb63705so9431036d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773397173; x=1774001973;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LFJr93g+gvzJomEerwFbGRLs36qbntliWexUDx+bAtg=;
 b=abBZ7zrofzchi7JKRz1EOLa2+yNoOT0Lo18dE69cGHQkKS3SqY5wKroAiWfoO7/mAe
 BfSaBEh/5p4UeSwbqoxhWyK90tI7cOz2OUY1jqlh5M0HwLFHke6tQNTyIWYnBgPV3ew6
 nROEBb11KIPCyvQlM7h9q7aj+MGsU+VS6Q9eWH7QCvVshlwLs3rKTr0+FJJFd3qLetMF
 1/Hv+9O5Y1enMczhLOUlUF2mkkU/zcCtvVaKQD+IauphdYhSeivKUF+iKevaH9DI49PF
 a/1qeUWPJ+/cehvRuPra10rq5V6VF8a/iWSmm5qYb2ouyoNlh54FotELXxXuqfoVR3hT
 3v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773397173; x=1774001973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFJr93g+gvzJomEerwFbGRLs36qbntliWexUDx+bAtg=;
 b=Rowksxl2OXgXPLJY8LyABUBydDjjeQ0/xYq8CLB9xuA5ZWfw9fMqYcWmZbbEiYtZTv
 FKIaqRUf09e2rboJpnXkfgtVPuTxkfQq1x9qO3MZhBJDkdCgNSDSzZ6qjLMpKfELvmTG
 oXMzLKBKvMXCnd/iYdZRAHkADTcco940dZcZrMPaD4IERahS8o6CMB7BYL3StRd65yLa
 1x1r937NfW8UadsHobNLOiCDJdI+jMm8IiWGVdakiM6qbcfUt2RVaazoCZEpjWzUJp60
 gWpASyy55l+4p2ycWGF3sgP1uRmzS/bYcE8lH0yVSrdAlY5iHho+0kCs7uxyqfPvjzgh
 haNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy2JhjNs6TKHUBujhnl7thyeT78JX1P/AWs/C2yfTI8t2AbU9EPSwi7lH4mkeO4Tx3O399j2zU7RM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6iBM5lbCpjobqC+Y1taYrXj0Cas1lyxSvuOcDiG8WUJFOu/d1
 XuGNFJMHeAsgXS9fTM7DkUS2ZVCAzBTilUHeGX3gkC+QXtqtXzSuPjTeaJiyiLrxgQY0z8IbPjy
 tYpR5Q1LKaNDXCpKQM3TMO65wez8aSPdAS44UBJSdmpmD4Dl+K3d+CE4rEmEQUygjXQ3Bwj8=
X-Gm-Gg: ATEYQzya6YDcdQjKb2SvPmQ2hRCUfCmAMp4V62UWN/xqxruH3oJT/WAQ49eAX6aikur
 FL7XODxzRFguy2pJcLt6XZ0QLAJTRjB/yuIX6ioP6aLX8xii4x4Zr125HxqaxRJJ+ajKXBcIZ4N
 ov49jg8gxSSYNq+vVopJDNEO90ZFfQaoXf3ryM+t6GNcEcVMbzu379ZpfNAfQ5UyEGF/y/QgkCU
 NnuGlFBVTOneB+i1pATtJblOeMTbGaCguUtZXjrQPaq4IGp8WEpsOXdLZpzUj7E4DzDKAtaUyDe
 xsGeJJjwk3XcLjP0DwJqzfNGk0Nw6NvPZ+4X9tGlDrmAbrI3To83l/ABIaZ8hsDMG1UrU+PUoza
 mOXTuI1Zr5b+k48u0rCl0lAyvSe94W7J456IKKeseec6Pt+53dS3yu0EqmDvwlfb4YrXYeLGnW/
 dXi+A=
X-Received: by 2002:a05:6214:4e01:b0:89a:595c:b805 with SMTP id
 6a1803df08f44-89a820986afmr27955026d6.6.1773397173299; 
 Fri, 13 Mar 2026 03:19:33 -0700 (PDT)
X-Received: by 2002:a05:6214:4e01:b0:89a:595c:b805 with SMTP id
 6a1803df08f44-89a820986afmr27954796d6.6.1773397172874; 
 Fri, 13 Mar 2026 03:19:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97756e59b6sm16300466b.10.2026.03.13.03.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 03:19:31 -0700 (PDT)
Message-ID: <351bd44a-3570-4490-a471-0d31750befaf@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 11:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/27] soc: qcom: ubwc: add helper controlling AMSBC
 enablement
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-4-b7e8f800176a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-ubwc-rework-v3-4-b7e8f800176a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9F9Y8frsk2tswun7Z0SpmBDRrEOBO2f_
X-Proofpoint-GUID: 9F9Y8frsk2tswun7Z0SpmBDRrEOBO2f_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MCBTYWx0ZWRfX+XCX33q1szFv
 zeZr0+k2c7hqTnb1mvtcZNmXRF/1knn5faFyl7tUzMy4imDPJXUcZnPz4+0DMGcUlHq4flnvUTg
 GkfnzzELW9DzT+aQP0EUncgoGx/r4EuhaZ9rUnKHbBg559+4WdWCvVKHYvjbUbtkUgaeQHMBkY+
 oAg/Pyd0Eovy6MbEy0nj8E7a/rlYmK1IVAGoN0VikJzZX9Xc9/gO7uldfwctXkzJGFiPse7A/JY
 FVTYxLgjqbUkDw2w5SSF/N37D5PsCGEKVh6HNxqA9/XwIsDDfXKnJx9A+AdLjsPydtpAmkjzCxs
 37jG8SzM2hTlaI63N1lMBxQflmR94e1HCO63nQe1N8fmbCYdEIs/Zb1YQgyEZxo7JQ7hsFxVLEG
 jR7NBPc4Wpk3z0S50plKHyb593kXtDriuAdPvO9jc+yu77LpmSBf7crZSatTFiTTN92Zmm5nuB1
 EWKs95ExIseNm/ppmbg==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3e4b6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ofppVGNrExDXTkBWrYEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130080
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

On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> Adreno and MDSS drivers need to know whether to enable AMSBC. Add
> separate helper, describing that feature.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  include/linux/soc/qcom/ubwc.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
> index 8355ffe40f88..83d2c2a7116c 100644
> --- a/include/linux/soc/qcom/ubwc.h
> +++ b/include/linux/soc/qcom/ubwc.h
> @@ -116,4 +116,9 @@ static inline u32 qcom_ubwc_version_tag(const struct qcom_ubwc_cfg_data *cfg)
>  	return 0;
>  }
>  
> +static inline bool qcom_ubwc_enable_amsbc(const struct qcom_ubwc_cfg_data *cfg)
> +{
> +	return cfg->ubwc_enc_version >= UBWC_3_0;

Note KGSL doesn't enable AMSBC for UBWC_6_0 and A8xx (but does for
A8xx+ UBWC3..5)

The initial commit adding A6xx support to KGSL has this hunk:

+       case KGSL_UBWC_3_0:
+               mode = 0;
+               amsbc = 1; /* Only valid for A640 and A680 */
+               break;

That was in a time where A640/680 (8150/8180 respectively, with UBWC3_x)
may have still been under heavy development - this initial driver was
targeting A630/SDM845 (UBWC2), so perhaps that's not really meaningful


Konrad
