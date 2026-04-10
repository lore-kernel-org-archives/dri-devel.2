Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0E8E99071
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2C510E920;
	Fri, 10 Apr 2026 10:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zjiup33z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FF1ZWyhG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DD110E92B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:23:52 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oNZc4148365
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XaYLNQUphR/lWUOk/mTQUwW9YYZEvSerDmEd50yoXrc=; b=Zjiup33zzocnk6bv
 WHB1lT0HsouahnjG/Xxfaj/KQ2/4rYCGivaY7KTnqIF3j6l51k2T99+VnJxpoifJ
 on+AU2MccbBy5k/P+y1+86gnD0IgIrpPHEXwQRX4m9e/Raad/4zomhPjXTC12fTI
 hOrvH5Krwnyl1lyd6bsBImuUbGFhuVTWQdWMdN8ma0CLs9ujZrAnN1vOaEMfboZM
 uL40HclDdIY7odtpxZT/gd4nOlHpHRRDYz+I38yyCfixfqHpKQdna5itF852KY7T
 UDieNCENvz2CZeoBikqK4pNdaN5ah4yjZcy3QGrtPEm/uuWnq4V1XNusjUxnIa6J
 81ypVQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudggyqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:23:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d87632952so4596761cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775816631; x=1776421431;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XaYLNQUphR/lWUOk/mTQUwW9YYZEvSerDmEd50yoXrc=;
 b=FF1ZWyhGFIot+R7AYmMQsv3RIjCdgEULZiKpVVdSVSC48SHhu4JiTWwaDRr8TLQjqn
 h8LNn309PPXzG5A2dmOVNvzf8Y2KtKsj3PcbuAdaCY6ia9tcNHetQFLii6M0V+niDp0q
 vz6Hn9zASYvBtI3HBiVe/m5NR6G+zVGZWNICa/Ms/vQEz5x+0eOjOoYk24VXOWGoFgu+
 pm+6Mo8Ulo2tmO3zle50faj8hKaODi/9Mee2LfZMRFpRDpjrjCnMyB5PtGKcDax1dYQ+
 Yqrz3qaLaoYY4fbjiGPrnVjBrivrOzQqgnw30VUOG4lcPfmJz9QX2EptQzfZO0iFswJi
 SJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775816631; x=1776421431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XaYLNQUphR/lWUOk/mTQUwW9YYZEvSerDmEd50yoXrc=;
 b=WZvMlIomNKKIJ0jD8/c9i/3sUSkO3GufMXaBljhSlScZJsAc52wQ4li7jGoLEGK8sR
 tFNJGpuBUQ+ZLZYALSUVM7xpzYXAbt/96+PnAn6tiyfEHtoItJzcN/I8yS8C4ku6M4Hr
 Yuax8hfh9Q+uPRN08/Lvw6JbzvLLR9nxkijt3VQNPmUDHM2qZfuyNiwYWm9arj6DNlXc
 hg0XpeGI3RFJI0j3x1rOVZ725ve6xTe9ZnGlbL8OFd0TIZCWzFd7o5JesyIJ8ndzlV3i
 nX4RWndG95a3ZiGxWkLMfONdC8ogth+4XtFeaXfxaWNPPZLucbSdm12rL1EIzyHnXR8j
 ZzvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHjq3TechS8E0PyqMpbL4Ag78suAW9klu1csPXPxiraQe/SZnV9esPsjwOClGU2+jecr9k+ZnZlTo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwX+NFJfcoGrpt4bYIGojKt+o1TA/3AFxdsKa5baAkapLZr0hgl
 bn/IvRXh36uDPR0u01ySppHrL0QOOrGx+bLECY4aHCodc19JNYOlIDfWJzzEYTOrjphM2PEihCa
 9TzRBwX+WBh7cAT6YBFOydySQZBehG95C2Fx5b/jwZY7Nm2HD2yxsto++UfzCwgmwS8PjXYE=
X-Gm-Gg: AeBDieut+LY/jI+yaw2zBDX7gyvwH1GR+pLYfZOhMWkBFAMVEeDTbFdDJiKyNVb7KfO
 IXYy9HktroooxjwzIXWvD5T0t1+fLIU0z24rK51Qozi2RTZMvdbuybc5q+OFb4o4Ev4yLpPy6xS
 fzoTwxuoLrZHwLGZTDRdhN9+dXqC2iJ4UqrxG8TtN6sWAshTJdZkiJM0f5YyODpT9aRsiNsyECn
 Zg0Fbpx65gdlcrDjo8eA/tYg6KrC9vodDCcmTahdTF20SQgf/HgrcBobMBPFs6qIEVRpT/LPVZE
 v1QCk6J5V24PttjUcsGLRxlXEBvnjVJ2oYVE6TrwbHinC2BO2HflQo+m5eTGpO6bMNJCkzEpYzZ
 ZDE1sz940l1WnrWqDh4Lmo5FYhoJhBR/A53eyErt0HqAIwqQ2YxQql5sHfmuzsiA9t8FS+l7QhP
 hwKYk=
X-Received: by 2002:a05:622a:5a96:b0:509:15aa:cf03 with SMTP id
 d75a77b69052e-50dd5b76641mr28793401cf.4.1775816631335; 
 Fri, 10 Apr 2026 03:23:51 -0700 (PDT)
X-Received: by 2002:a05:622a:5a96:b0:509:15aa:cf03 with SMTP id
 d75a77b69052e-50dd5b76641mr28793161cf.4.1775816630923; 
 Fri, 10 Apr 2026 03:23:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9d6e5c5457sm66123566b.35.2026.04.10.03.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 03:23:50 -0700 (PDT)
Message-ID: <724f14e2-83f9-4637-8e63-f31001ca0725@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 12:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 39/39] drm/msm/dp: Add MST stream support for supported
 DP controllers
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-39-b20518dea8de@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-39-b20518dea8de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9ZYg8wlAFOweYazMO4XisRf6hj_-bVPU
X-Proofpoint-GUID: 9ZYg8wlAFOweYazMO4XisRf6hj_-bVPU
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d8cfb8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=UGWVb_hElQaF8LtDzA8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5NiBTYWx0ZWRfX+jRHRifa74Sm
 bv26vAGDkxiP6JLgbwHK4KIVPxVy0s3e6hwfkvArlwu/h18f3lCcxze7q+mRyhAaWzRP65xVTxH
 UvVA2rHEa1m0FAlXHZG3nSMJl7BlYLCWkp9vIGakVZuBwQKHlmE+phjoc/gd6ZEwSnjbf0iNVi/
 fu4RzRyAYfQG3hLiNuvIWXmqk2K0MKxSJaWwi0nUld4Sk6Gorvq8uUiwmDBuap/640pipPpIq2S
 n/GIqTKtwFHWmKkSSls89MFdqjL7z2F9f2OAM0oxIe/AgcsHZueNwXGJmjoLdvELwOU0C28iGBS
 ILwpqdoclt3vcfeO6OVA/Dv2H9KG8/+4nXAvyUXIfyaBThXW6XM3a4/8DZTPn3AlwsEVisdp6XH
 /8jnMT8rF34eoZQfQsTpqr6YBXPe0M8lg/ag+ujrhSOK7zX+zF7gjWU9x08jgtsbuCpYq5arXNq
 CL2UkqRnYMQAVuXqvww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100096
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

On 4/10/26 11:34 AM, Yongxing Mou wrote:
> Enables MST support for MSM DP controllers that support it, allowing each
> controller to handle up to two or four DisplayPort streams. All necessary
> MST support code was already implemented in the previous series of patches.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index ca89e20b7563..f632b4f64ccc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -107,16 +107,21 @@ struct msm_dp_desc {
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_glymur[] = {
> -	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },

Please reformat all the changes so that the entries have one assignment a line

> -	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> -	{ .io_start = 0x0af64000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
> +	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
> +	{ .io_start = 0x0af64000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
>  	{ .io_start = 0x0af6c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>  	{}

All 4 DPTXes on Glymur have the address spaces that suggest 4-way MST


>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
> -	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> -	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 4},
> +	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
> +	  .mst_streams = 2},
>  	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
>  	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
>  	{}

Same thing here

> @@ -133,38 +138,47 @@ static const struct msm_dp_desc msm_dp_desc_sc7180[] = {
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sc7280[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
>  	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
>  	{}

Interestingly the eDP host on 7280 also has the registers for MST..

Please recheck all the entries

Konrad
