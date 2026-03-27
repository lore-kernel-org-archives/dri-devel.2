Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B8C10ED65C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE02C10ED8B;
	Fri, 27 Mar 2026 11:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KABEZbvt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3PwtxZv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394CB10ED87
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:19:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6wuKr2846152
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TMjrA6TTi9yCOvGqK1ztiHGK4CSNrrj4NvPFBfXCxkE=; b=KABEZbvtYxZx8vLm
 lxUSis05lkXMQT0EDjSszvh1unwpCRZ1REiD3tfUAEDiX1KeHbt9jtFwpZUsRA+m
 X9TGPVfiPq+xvV2VngUk68Fmsp8SL65NwBI4+nYhV8xAmh6F9/fDCexAgQQ5J/TC
 OOO0hZAUqRUQiBjzP/wMlsVB9+Etu+VHzUnDdXhsF5Qog72CBKRRML4t0d177Coo
 gCQZvPHkPMgtV/Fxnz7kW26dph5Iu6GEu1n/dOkzwRcAL5ChSp7cacn7cCs53EUr
 i4RLlxek8kyCl8UznEEW7pkA9Xaw1g3zhZfiHvxxYbSMFX+5L8Ti39o18dkdUk11
 rLgiPg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d53eqmsf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:19:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b33a19837so7480381cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774610374; x=1775215174;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TMjrA6TTi9yCOvGqK1ztiHGK4CSNrrj4NvPFBfXCxkE=;
 b=R3PwtxZvJ44i02FRjmui3we20nK3ys5RK4O8sbe1nYAD8M+THpweLQzlUr3bCRgj4X
 gfT34kfDTcHHwbYr8+2/od73+t0/2D4CbMMMCunqSbInAMJ0sq7IDoJz6eBRfd0DPmz2
 3MGNp7L+XCyN5NIkP9SEmleECeTnj0oIu1jlS4K3MGB7kXp4qgu6PsEYhj42iWiEOmy/
 6t696L0Zq2i0RG6dhDQVkvJSwaEhR9VyBMexh0ZBt8X/lFap1+a23GAL7S1g3AcapRcN
 0+7VGaQzqN3YSvf48k1grO86bCCXLhVRvKEEVY6XBR5ILq7sPVth9sG1aoLpDFGceotP
 h3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610374; x=1775215174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TMjrA6TTi9yCOvGqK1ztiHGK4CSNrrj4NvPFBfXCxkE=;
 b=fiODezAQa3DXhpLZs0tytSKBouuH3q8fLzWehkbnK4MeosxNPAf/M4ZmsQ9jWjnQSj
 ZXX1ELzBu9TIA6bKat+qM046+ogu+dKBs3vjFMRHPEBONniMSgTJatcHnK+YO0Gf+L3Z
 ZoSn8wMZWjRNYqVFX1Z7ykRdxAUAwApt/gC8AA75wsr4rNNlruvqfnb2b1UuCXMUJvsq
 GLSIwUZqyfdvGHEgc8EAm5/DOfeuxIKlTN6a1Lmw6UQKZWqi7PImPsjXOud+hHfJkNam
 uSa3bEFUCDFZ1zZrmx1f2/vuu1/4Eeijk3rReS+IHU7iNaLDjfIil43kKQNDViAHUlts
 pdUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBoBkDg8EdGnUau+WV6aB6BaZrYbMeQRSiMs+WPNw2bwSZy+4OcLChzYW3jjrgXwapWO103QMG4Qo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsC9ZS6xCbGVrUNMWqMQfbAC5vypazD4BS05i2Aq/1QExAKXPN
 M1Xrxly3+CcnZllxNCuiDqwyYPpt/tuZ4IpYODBCJsCvzf3RkSBtJZIxYlKhZ994da4HaanuQhl
 Jgwh5al8JKWMkk1TJGju5DCwnlh+NRQiGRrh39fcVhgPtj6Z37VbK5Lf2gDy78Lwv4zWFlR0=
X-Gm-Gg: ATEYQzyHEhK1tmufWTZ58bMn3KGW5chFACmwntXOqFNucncmPs3rK+dnBDuhgRdfohM
 qwAL4gHataDJVlcEZiJSvwVYNm6WuTTjaQZhAZ+OJ+I3bVhn6nXLYf4QBI7tJSdbSFSlx5/whNU
 iZhQNNnJZLpBoMwz1DA1tZwNZgJZG3+kcTNxZ+0uAEcT5Q5HxFtE++EVmk2p3TDsen88NC+zqK7
 nIiBoFhqrTLQG0RXIpY4hdmdqZJYswh4PAgljWIZHqUTdNOzoricd2A4CgsP9q+vMr1b5LpHTKB
 R9fukScsZsXFtDTWn1vZtUd/fan+0SL915EIdBXuE+SUcTEUr+lMnjYLcvyYskJy3Ssrq0W4UOJ
 R11Pw/tRYSLW5WJwIhi6MzejB5ZJT1CPDaw2VSvdait08cWbzpNNvNU5iiw3JXSjxJfHgA+QDbp
 sjuJE=
X-Received: by 2002:ac8:7d15:0:b0:50b:6b21:2a7f with SMTP id
 d75a77b69052e-50ba37fc306mr21756971cf.2.1774610373796; 
 Fri, 27 Mar 2026 04:19:33 -0700 (PDT)
X-Received: by 2002:ac8:7d15:0:b0:50b:6b21:2a7f with SMTP id
 d75a77b69052e-50ba37fc306mr21756651cf.2.1774610373380; 
 Fri, 27 Mar 2026 04:19:33 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66ad6a4ec00sm2110378a12.23.2026.03.27.04.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 04:19:32 -0700 (PDT)
Message-ID: <b3238d53-f384-45cb-ba8a-c5b572d27e2d@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] drm/msm/adreno: Expose a PARAM to check AQE
 support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-17-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-17-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3OSBTYWx0ZWRfX9YqLgOwjuXr/
 ppg89YESa0bEvK65DhEjTrLcM+NsjhAPrdhfCO7+tD2lseATECMj3KCZyjBiXy9acCtJLR9cwlQ
 9AnPfXo8VoWqAE68ezGZWKI3k/wqjrggMbtsl9TfgJtrtfSR2dDIkPVViar7MXcbmpJLpiSXhfL
 NtbSWvBGQzPCcXzmTC/h4sU7pIhGYsTxRPFZzrYZSbcotGlzW0+FqaNlQnMtXnkYxzQP9IpKTe1
 4dTWjVL8222kRfid8UGfhgWEUZAKytRkPt3wYpiyRBc7pK9djjtgkwvStWl5rgtNoC+OSX6USEa
 HicAkdr6lCh5wHoCatPi/YxeK83AOge5sHAqYfX6s7VdO34VMKWJkgnyxVLtil2UwqbtOoQ2mFq
 TY8Nrqs4obcj7lAYUq7LKM2+Cky5ajMMW6jsuyJMBRiuqNeBNZO/j1r3YmlZ2MGngQH5a3m7eA/
 lN4NMz2DNZxDMxlMQBA==
X-Proofpoint-GUID: c8z_DQmx9segO3GOPmAsgkY1Y5F6gPxi
X-Authority-Analysis: v=2.4 cv=S4bUAYsP c=1 sm=1 tr=0 ts=69c667c6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2XNqRJ050pmYQOFmOusA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: c8z_DQmx9segO3GOPmAsgkY1Y5F6gPxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270079
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

On 3/27/26 1:14 AM, Akhil P Oommen wrote:
> AQE (Applicaton Qrisc Engine) is required to support VK ray-pipeline. Two
> conditions should be met to use this HW:
>   1. AQE firmware should be loaded and programmed
>   2. Preemption support
> 
> Expose a new MSM_PARAM to allow userspace to query its support.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +	case MSM_PARAM_AQE:
> +		*value = !!(adreno_gpu->funcs->aqe_is_enabled &&
> +			    adreno_gpu->funcs->aqe_is_enabled(adreno_gpu));

again, this is a bootlean even without the !! because of the inner
&&

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
