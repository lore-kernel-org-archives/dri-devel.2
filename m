Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F17105F792
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B5D10EB7B;
	Fri, 13 Mar 2026 10:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mm30YTj3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAcVC4vp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E9E10EB8A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:25:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D9TmDW1498963
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z6JX/cxPB5KnT9jggs10cXfq45mIFUC77SLavUgRftI=; b=mm30YTj3GccoLPq7
 rkh02/zUDF++7oBxNLolIwe5iF5L/0lczgO6PFbuFj3v1EMugRoWi/IcukU8ItOO
 ggdLOUgW1+iUQGttJSbuVOBQ/jXGubnX+RFz3eDR7Mkb9LPJsZ03YgRlEH0zv+O6
 Z9zCy+0nD7x3hLjpx3vt6zd//udoAO6zi9C1qUpAYllAZIQZ56HvYtJpUztbqb/s
 ysMQes5FpTYfmiWUMLCPInr8o5jldf06bE11TDWpZYl3YSADJSeoyr7kROsD0VIA
 d+BL95FHwijgbT3VSRPdyC5pTK8Hsu0Qr6NDa0CqrQPtT2LRiEuoHvQHsqbtaVNu
 N4aulg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvg0hg680-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:25:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb39de5c54so110730385a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773397522; x=1774002322;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z6JX/cxPB5KnT9jggs10cXfq45mIFUC77SLavUgRftI=;
 b=FAcVC4vpk3AL1KsemdM/5DYdxYw3+8rxhFJ7S1wQZr7OM8ab31O6OR/aldkC85V4Zu
 kmenq9Iq+et3BOaV5h38wSqPtDkJ1tw1trw42RsHj9RJAbAEPKPteCeR10TcmBO6zg0E
 kXPUc6cA2jzJx7+KEqydFBEN7GWkgSTj+7B3UsigjaVca0hKpCCDkDwgxYTtIgXUnlad
 7jTWEuGjk+oQlspxbkm+eefwOnYbjcRyIXRagOmM/IfORMip3X+/hI0iXs3AzUtMgY82
 HbSTFeeSeEtJygzC7fGqMQxkjRN82rFSsEPDlQ3zOvQpq7KtqeDOeWdZh7Qkc3cF5r9s
 vesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773397522; x=1774002322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z6JX/cxPB5KnT9jggs10cXfq45mIFUC77SLavUgRftI=;
 b=mq9BRAL7FSQ7cbRfRuqZWXnuBRC0ffn37gYzYWr2w53lnjzmTM3m34cJQ9a39ntpkv
 qcMz3rY/lJ+mwqie3BMLz1X9+lvz8xRZelznv0f8/ZIQoUr64y1bPdXSwbZBGX0aoW5f
 GnKzE6w/kAwoHP7oE1Y0eDJxLWSpu+1e5Y+1g03i68ns7GM1P6Yg5NbBceNlnROVqdIU
 4I+c2PtD91nWGcHRhtT5qFQ+/lge9dpuIxGHgv/9QhtY73iAwxfb5CocqBM1BH97QuCd
 oCan2aHASjhlbLgW0s8gR8nW3/uDG4v100Ub3DklGAMS3K+DMUeEDYiVlPKVnRT6pERZ
 K+IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwHxAG9NKwjw7mEZxbsv1Qc7HwjMwgX3Tio7OWoI0ZqwTrVOTdweMmvaCBGfNKnpDQ/Ra5nKpaNlA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQjcD+cMDbCeYIyRlDSNFkLYiVs8T/ajc82t6qZ0kfMVPl2nit
 ZBzd7Us1LF30PQgKs+bXZbnwJfjqKGVQF/eo/bS6PO28El9I0rXGeGwoaTCtXxPD5+70kgvbYBc
 +6gl+Bh+Sg5T2FsM/DC7nr7dbpbr7P5sRw+5/X7qYHkrOpjwOBsEujGGVHm3C6+i/ElaFzlk=
X-Gm-Gg: ATEYQzwuOTytedXN3v3srt9kkJvuBCOU4vMu8943j3c10z5Fk4Hkbo742Yu7bLhJXtu
 uVyGGhfo14XY7RK/CMjur6p3dB5aSWHbQXjKNSXsIZh4T7auM4eD/hKd+Z+jnVcdN5eLdpekVvY
 250stBEFt8hhy8giORDqFiW/eLo8T37tuEpNPMgOHxoEaSP22W8qThD2+qURPBjPEu/oyw4POVw
 5ig3ohZNZ/oNZ7CUiqjVsh5YZ+xM3iwdvE+TcdidpFF5C7p+78S1Yt/8gn52zuVetu4q9STdLAd
 0MlvEHJ20geiEfkCd7inBu8UJxeqPsdPpO1Gyx5qOadoFuWVPlqqO2fg8/7CJ8k58YKqSmqzUQN
 ZpW12LaOVGwUlLxRZCsI4cm4jkwpuVfYGIBAeg2Qj0kR4+Wlzb8XVEm+Km6rVXDGjF70Fb+BSSE
 bHVgk=
X-Received: by 2002:a05:620a:4113:b0:8cd:9828:a7b4 with SMTP id
 af79cd13be357-8cdb5baac4amr264667585a.9.1773397522547; 
 Fri, 13 Mar 2026 03:25:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4113:b0:8cd:9828:a7b4 with SMTP id
 af79cd13be357-8cdb5baac4amr264665285a.9.1773397522025; 
 Fri, 13 Mar 2026 03:25:22 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976d0918a7sm36067266b.63.2026.03.13.03.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 03:25:20 -0700 (PDT)
Message-ID: <7ed3af47-daaf-43b6-8d2f-dc6b528d2c00@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 11:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/27] drm/msm/dpu: invert the order of UBWC checks
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
 <20260312-ubwc-rework-v3-19-b7e8f800176a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-ubwc-rework-v3-19-b7e8f800176a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69b3e613 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=C-aM3KecGx6sHzoCZVkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: p4jPxU94QZVz9KKq9YA_8YDU_ogNygoO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MSBTYWx0ZWRfX0xT4eqSQGDDO
 YxBI0A8M2PnDPpLu2oxYcgJWkdXmU0Ue/aDRw9oGB1vYl/UylLdrBNbnsMXUXkr/pAP7eSjkDN1
 xy1pNsbWGX01Qw7+UqKTyM7uin0U3zMCRbJe9TgK6lWhpDkPT7yLOYbkB1wvxvE3OnByU+ucIDN
 T4iDNkkbCo9GE5AOr/W3oTSW7MrxNrbHhdqDShnvmxEU5/LiyBkRUjum397BY1X6VluCocTgmJc
 BMt9B0+n+L9Tsb3wmgyNpzQoHCJMqavg72sHa2mhSdrxbWTt9xCqf22urcOZ6I8KsoF09nXItO7
 ZkNS5gTCO9G2wYkFXJrjKLzPMH86hINJw17qa9qXRcQupVucehj/vh1g/+zbNVtNb80wpnDPAWT
 4kRwWd5UpiddeOJ7YcHF0aHbsNCa0DB7mJSXqtv2nCOlUYnaGjxzCYRQ1rB+RbMWEK75MumjtSA
 gWZOks5ecmlv9ircLzA==
X-Proofpoint-GUID: p4jPxU94QZVz9KKq9YA_8YDU_ogNygoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130081
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
> Unlike other drivers, the DPU driver checks for exact UBWC version,
> making it hard to add minor versions if necessary. Invert the order of
> UBWC checks, letting the DPU driver handle new minors transparently.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

>  		} else {
>  			DRM_WARN_ONCE("Unsupported UBWC version %x\n", ctx->ubwc->ubwc_enc_version);

note this is existing behavior, but do we want to write to these
registers on platforms without UBWC, instead of returning early?

Konrad
