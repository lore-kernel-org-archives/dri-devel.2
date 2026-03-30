Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C7B10D14A0
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627D710E489;
	Mon, 30 Mar 2026 11:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RobYE/7X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LCIHA3LE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4189710E47E
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:15:48 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U9lN4s2197293
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xg5b7vWnWR48Z+nmUzvfsCBGvAyRjlRj5sHV01r2xzI=; b=RobYE/7Xt0tJg4Ni
 6P1GG0VaflO9tZtQS8/By5bdSWB1TRTW9mAUZlp4yf9VvcjHxCsdE8QjUeIcqTVJ
 1noWVa17cksc5jyLJLffb56QxquYtcLn8TJI0+SbFKJ8sgKOKz5/Jbjd3ocUSpOL
 wLD7AtWA3wZzYRe3RjFOmJP+OVh3KtrEBp0/SD2hJ617bhRtoRxoYjL2uIH48p/v
 03Gam6/tyRCnax1OmeTKIu6NEMDahxcbXUaurszRsKNCzQjqVu7xZtmfzrJbW8Ew
 bk91ElFDkW5fQ5bkSU4fqLS8U68yCMCI5vyFA6gyo4SoWxeoeXWufVJI/gmw1d5H
 /cdjyQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6v9c3ts6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:15:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b9074bd42so14608931cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774869347; x=1775474147;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xg5b7vWnWR48Z+nmUzvfsCBGvAyRjlRj5sHV01r2xzI=;
 b=LCIHA3LEaycZuLc7vnhvRUhfTAkD5XleQSVGGh5d4+k4x6DIfSDg7tzKu5M70N8vIp
 y7otsgPHrI8ix0cRHqZk2s8bZSoJDpP5iwOqY0IjPs3atA5IVB7qLFqeSwrNLAQ8sj56
 U0ccGakQHVO+GNJ1bc+k8JcSzmb6VHGCdctWcLOxK+bnS1OySNjj2znjGEoj6UvP9Uv/
 dPHBQDeVO2BcL2pYeVf53R/48HWTaHRkSKGCcF96eS1Ul921zqozwSC1DUCECA1F8mTX
 Js/QmQmpoG0EhIgNH9nHMYCKN5273H0rNp70zu7nCWmCgvEB0qWYvIt3Lq/AR7ETmIBD
 t8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774869347; x=1775474147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xg5b7vWnWR48Z+nmUzvfsCBGvAyRjlRj5sHV01r2xzI=;
 b=Pqhynr6FWGXmroOrHty7LP0ZsPXdsigDeuujUq6KtUoigJHDqBDRfv8N/3wubCf2I0
 oHetuaFAQabk7hNQPd/5F1eOlf/6eIUATO4XXyi1JXsD4inmraXphevaVO99pFoPd10E
 NtLi6lTIjYzNbM1b8aUztzllP2z6p8aWYZV3ZVaN9rPgliQKHINQEYjnwrjFXuz1+srw
 bErWME2t5iaXYo46YenESnUGWvIFzO+f2Qwer1StWsQ+JaXy2UVznntvkNqzY5ZC9Y5E
 eTLUMSS2CCTCwEnoyb2iQHjDZRibks3mryzvcd2MyNQzyhcSWWczFaErYRatV8IEbD5L
 6JNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1coIBahbsWpUV/+JqmNqTK7gbOtXsYsZ5DPl4vBXTJcvyiiBp+lkdXxYNctyrDB27hbciUKhOuxw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWOHHPCimhx6cnFSEzSIyzGCx9GrNaZ8YJmQFqy19J7vBDMnXE
 zLzPIK5NSvDHFWP/fGB1dbauRX1qgjPJlh4A8UoZr4RCkkvP2hwrrfPWmiQCDosCG8Rs2gPNbHT
 hj4jze8fvypsBbDBa5MJfB/mILxWch09JVzttPr7CoNRh+OtEP+nZ9DA+xFea3C1RSt1ejc8=
X-Gm-Gg: ATEYQzwMy3hGnFm2DBdVF8Hhs3J4/ABqI+zZWq8Tqa05Qk1zINd0KnD5kp6AeXOWKbz
 9RBSTuJVDipBQi4EPsQfn+FcHpH8qUzc2vCC5/HVbm/0m5A5tSmk+K+InVuCXP83qAXhVtB5G4n
 nPyxK4xY07uBqxpRoeC6DnY/50YZyokNa6oU3n6pmlZMFzVw/d5cqflBqBkC/zX+kAv0s3GF8bb
 C76aIlb94Hrnlyn7P0i6lLAATSitrXpyB/DN0Fvho60ZlX3zTUQAyDvpv1jOjciH4WK1oeZXpTA
 kn+0bEA6UZBmDoKw4GkIrzCihIeuo+1gQgd/Hmb/x4YS9BVtNa1IeZ5+leN8VioDw8pXhF5gOIy
 K3sJM39xAltiUffGas90AOdFfxZvP+ZxFo2crBVTKRCKtcvNBdG+q/dHV7ttuLlq6oKka5pDPPP
 CjVB8=
X-Received: by 2002:a05:622a:4a8d:b0:509:2239:8b46 with SMTP id
 d75a77b69052e-50ba36b0249mr116206901cf.0.1774869346545; 
 Mon, 30 Mar 2026 04:15:46 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8d:b0:509:2239:8b46 with SMTP id
 d75a77b69052e-50ba36b0249mr116206491cf.0.1774869345985; 
 Mon, 30 Mar 2026 04:15:45 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7ae522d4sm283960566b.22.2026.03.30.04.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 04:15:45 -0700 (PDT)
Message-ID: <3465929e-262f-407e-bc3d-7564787bce3d@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 13:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] drm/msm/a6xx: Update HFI definitions
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
 <20260327-a8xx-gpu-batch2-v2-10-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-10-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OCBTYWx0ZWRfX9WrLtzP2Amh7
 blT9q6QK5k8K+I7dSliwYvzQcqNC4BR8FrOLINycxRCp+TYmZmIQ8wxQxubqksWIMYot3zY2DrW
 CauGZ20qN+bpHD/30QAOYJ+VTWIGveQnB4yuGAO0A44q7/YjTV3F2+Raz24k7GjKWYvGF6/IyYX
 pjBYcOraoM9KYn9mEM1USvPGp1WAJH+ZBSXGuIwAuIwjluJjDIqtavvV2SscDdm3ymHg7Hobd2Z
 GQtWl4J8SltraixPP3nBTv+L674w+U1PRE+rHbI/L7IxRtVGAHkPCYdXTJOof/C5hZJNIlutR9R
 kIynO/A2FgacbqiM0O32KBNNX3tF5ibkhHMJZsRr0S0hCD+d/sWjB6f1rxLm3lcz0ZhGn9Gng7K
 jm7/mY8vY5ozOiMMsKIT21Mdlb1mxASFIfs/2bttboUeE7G+N6Ug0iwsOx5xw93MZGCWqe7z5Sj
 2KfHwuZQn7XTMX4DBdw==
X-Authority-Analysis: v=2.4 cv=EIQLElZC c=1 sm=1 tr=0 ts=69ca5b63 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=obEroLpJCF5-QB5h4XEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 7CrLwf-HA0qjUD8SHRnPsqfcwI2bA33v
X-Proofpoint-ORIG-GUID: 7CrLwf-HA0qjUD8SHRnPsqfcwI2bA33v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300088
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

On 3/27/26 1:13 AM, Akhil P Oommen wrote:
> Update the HFI definitions to support additional GMU based power
> features.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Whether you want to proceed with bitfields or not:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
