Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA93CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A770410EF98;
	Wed, 20 May 2026 08:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fi399r+p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BPr/Azsd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFD810EF93
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:36:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7bbJ4341440
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qMm9rGe9sBf75zeraZiwiYKH2NWtu3ILaP9e9pyvYOU=; b=fi399r+pR1tPMnWP
 91z51alEc+OT+KkcK6yln4BoU31VrB/ysI6yV6q3z2MSS+iLE7KtP3StE7A7Ey0I
 6LEfj95KnYS0M6fDHs20b1utoNf94Sa1zDDy0lgQcDiIbmWiPLJBVZjN05+ltHrO
 tnbIBuF6teOt44CbWw6f37kbuQn8dz6VCgeDMPJakFY96Yj1ZcBOHGPe+zGpchXh
 7R6RkCiBcZOUSRrzHP+EH9nf5y1H6Du4sP/KYyEREMjJJCfBDiZHXGvGZHucriHk
 Y5Uk7/qs+7Rs4HAAue78u7pDTYyOliRkwXsCoIRkhkU2DvkhduJKqZGZtXmf5/v6
 obNWCQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3vbt65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:36:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82fa2165c3eso2908302b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779266210; x=1779871010;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qMm9rGe9sBf75zeraZiwiYKH2NWtu3ILaP9e9pyvYOU=;
 b=BPr/AzsdcNKkEhyUHWkvLMgS/M4nb5pc8VLlVl5Xf1yGdCgjAHIEMQL2klxrqWSaGU
 LI7ERlSYTg2n6e8d/2X1O2/DBmUGmMWSSIG3tQ4+U/BXnD46RVArW3l9HljSlrk38jc9
 CqD8ZID3Qm47WirsBVlUGC4YyfDnFK0qRX+TZKvIqzijxY2wKNXBpfx2ARuuwpwYYPxo
 2//+VaSs0oPDoZ4jZQZ7C5ke+G6UDOPxnSW5xrp8P12XjGoudBbfLWyoWdWEjLwDu1W7
 z6TEe7mhqLEaEbzhcepZb/++/tXP1H/Yoog0bkykxiTNLHqK9My1CVwP+KEhcaG+45KK
 FUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779266210; x=1779871010;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMm9rGe9sBf75zeraZiwiYKH2NWtu3ILaP9e9pyvYOU=;
 b=XGE2yRdTw2b0kfaFUBRuyOPCOD/J++8Fy8RYwbH68divBREZsOlhLBMOGNF8AM+kHp
 sHWKW7/2ezzmeBtRhjBPu0RXPAguVH6v4h+ddftDhVGqAMCh5/Q1IIndBMuo0EJcp0GP
 v46mC0TyDgRNbmvd4ALxnGHS4iAahY2XilkbuThfE5mtvKEDT4qdGpwJQ9w8Q9W4Om7l
 5+M8Fujb+G3ZUpO87NDRJuLKF6me16oL+T7H/FNyE2YSOYcEQwfzMLbIem8jDRllB5mP
 yjKjApNSmzAmZjd5OaULDMnaK2Z5pxwVbDBQLH6XCUzEiZzqkffyEcClKMCE2AfW/iOi
 LKXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QL3k0lwbeS9Gq9IgbgotGe3pr6W46E70uUTWHRZa0gl6bjeAehiiJG7UtYafBlmQDdqIT8nKgnzc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIn9gMRJ3WLB+rTKNO87hhC9i+hh8QKCvlZfabh00tKHyLcye1
 qq38yxwlloXIAh/Z19+vOAdnE2iAhmoKRucKjvwh7BEKG34/bc6TL09SsTDyId6JZNLO9DxeEhM
 kUg3GnXx7CjW1/i2C9ByVODzHZNwEuZPe8TmofUok3FXt59J4KpWEsiibwz9TSx7qN+SokkU=
X-Gm-Gg: Acq92OEd06lILgAsHw8nB91/VcoCnm2+5zONKHbq4IBjv9/Xc9KYToOt/w+3nR4FUg4
 4ixeAxVnNBReYxKQTWGvDkwusBWek3oiZ9zMhditYJW9tdlBHGvZinL0XE6OSl+qjDLjHkL1hyI
 /sbgC6JEJv6s3sVzxuNjw7bEmFzKYyw5kBfHjiTCLYd9YsUJ1PnIEguWk1gwbIDeuq9Wq3Kg0qu
 Jpog8DcLLqFTaSzFsWJ+pusp0NJhahTlvmR7iYPd5OwRYcow2qHMxHelQLlqYVZ+sNi7opxXU8A
 3W7j6KySAXB3WHca345pCbdguMlK4Na5LjoAAAv9W7E6JXqTgFkCCFeFlMM/0Z2VBX9w5sX+ObZ
 25+lA676801vwnzqyIiVNjexf77RWSbzDhkSuWUA5W0iJTLpQa5zj
X-Received: by 2002:a05:6a00:2e9f:b0:83a:4846:90b0 with SMTP id
 d2e1a72fcca58-83f33dd8d8cmr23405742b3a.46.1779266210208; 
 Wed, 20 May 2026 01:36:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9f:b0:83a:4846:90b0 with SMTP id
 d2e1a72fcca58-83f33dd8d8cmr23405710b3a.46.1779266209678; 
 Wed, 20 May 2026 01:36:49 -0700 (PDT)
Received: from [172.20.10.3] ([27.60.134.77]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5c3a9sm20515303b3a.38.2026.05.20.01.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 01:36:49 -0700 (PDT)
Message-ID: <b4787a2b-c1db-4c0c-8c58-fe60fed83cfb@oss.qualcomm.com>
Date: Wed, 20 May 2026 14:06:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/16] drm/msm/registers: Add perfcntr json
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
 <20260518190735.16236-6-robin.clark@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518190735.16236-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GqU9oqrQwOPpW_mg5jObGJeoQefgIj8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4MiBTYWx0ZWRfX0CrgRsNY18KY
 w8amiIwj5IVd8Kf0IgFQj53699SSSP5yGVjoIDTkCfOqyqt5KdTkiBc6olahgmQJOpxntfQKeeI
 vm1kxOLZ83RZaaXQ/Oxx6ze/7RtSxjimIuCrj4YtTSwiLykh2/2NSrelLyJvwo03C2/YtCFIrUw
 iv4LOHmjYbDgOK0VEPtrhh8iHsi71z5M6SNZuq9CqRf1wkXkjGkxIgppJNIHWM6qS8x5QlXwV6F
 +S4k2CIISxfGgYqfF3ZwZ1+vaw0sYolKiM1k1NiCmtX3P3j/dms6WoeYATkH5jNsNsf9KthyGWk
 fbhH3eyVFCM2ydEwK8R9oc6Y/1vcWyaV8xSPj53qJhrCCyrH196AQRdDyRGemMJs1H+b0Qc0CS2
 4CX7xLmZyKqCgwuSPUt2b9zBL8lxpX6tIG6noQnb3R1hGap5PJBZHyjffpv+Fd6OKJRLDA/UV9s
 DdFqsFHRp7hSODdXEOA==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0d72a3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Q/5yxSSCruZ1lXPW2Frkag==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=Os_MIW4w5OSApcyPIz8A:9
 a=8f1wxSZkJpRnjI3K:21 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: GqU9oqrQwOPpW_mg5jObGJeoQefgIj8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200082
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

On 5/19/2026 12:36 AM, Rob Clark wrote:
> Pull in perfcntr json and wire up generation of perfcntr tables.
> 
> Sync from mesa commit d2c4653ee953 ("freedreno/registers: Add gen8 perfcntrs")
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/gpu/drm/msm/Makefile                  |  25 +-
>  drivers/gpu/drm/msm/msm_perfcntr.h            |  48 ++++
>  .../msm/registers/adreno/a2xx_perfcntrs.json  | 109 ++++++++
>  .../msm/registers/adreno/a5xx_perfcntrs.json  | 128 ++++++++++
>  .../msm/registers/adreno/a6xx_perfcntrs.json  | 105 ++++++++
>  .../msm/registers/adreno/a7xx_perfcntrs.json  | 228 +++++++++++++++++
>  .../msm/registers/adreno/a8xx_perfcntrs.json  | 240 ++++++++++++++++++
>  7 files changed, 882 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> 

<< snip >>

> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json b/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
> new file mode 100644
> index 000000000000..8bb31820479e
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
> @@ -0,0 +1,105 @@
> +{

RBBM and CMP groups are missing here.

> +    "chip": "A6XX",
> +    "groups": [
> +        {
> +            "name": "CP",
> +            "num": 14,
> +            "reserved": [ 0 ],
> +            "select": "CP_PERFCTR_CP_SEL",
> +            "counter": "RBBM_PERFCTR_CP",
> +            "countable_type": "a6xx_cp_perfcounter_select"

<< snip >>

> diff --git a/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json b/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
> new file mode 100644
> index 000000000000..e60aab1862ec
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
> @@ -0,0 +1,228 @@
> +{
> +    "chip": "A7XX",
> +    "groups": [
> +        {
> +            "name": "CP",
> +            "num": 14,
> +            "reserved": [ 0 ],
> +            "select": "CP_PERFCTR_CP_SEL",
> +            "counter": "RBBM_PERFCTR_CP",
> +            "countable_type": "a7xx_cp_perfcounter_select"
> +        },
> +        {
> +            "name": "RBBM",
> +            "num": 4,
> +            "select": "RBBM_PERFCTR_RBBM_SEL",
> +            "counter": "RBBM_PERFCTR_RBBM",
> +            "countable_type": "a7xx_rbbm_perfcounter_select"
> +        },
> +        {
> +            "name": "PC",
> +            "pipe": "BR",
> +            "num": 8,
> +            "select": "PC_PERFCTR_PC_SEL",
> +            "counter": "RBBM_PERFCTR_PC",
> +            "countable_type": "a7xx_pc_perfcounter_select"
> +        },
> +        {
> +            "name": "VFD",
> +            "pipe": "BR",
> +            "num": 8,
> +            "select": "VFD_PERFCTR_VFD_SEL",
> +            "counter": "RBBM_PERFCTR_VFD",
> +            "countable_type": "a7xx_vfd_perfcounter_select"
> +        },
> +        {
> +            "name": "HLSQ",
> +            "pipe": "BR",
> +            "num": 6,
> +            "select": "SP_PERFCTR_HLSQ_SEL",
> +            "counter": "RBBM_PERFCTR_HLSQ",
> +            "countable_type": "a7xx_hlsq_perfcounter_select"
> +        },
> +        {
> +            "name": "VPC",
> +            "pipe": "BR",
> +            "num": 6,
> +            "select": "VPC_PERFCTR_VPC_SEL",
> +            "counter": "RBBM_PERFCTR_VPC",
> +            "countable_type": "a7xx_vpc_perfcounter_select"
> +        },
> +        {
> +            "name": "TSE",
> +            "pipe": "BR",
> +            "num": 4,
> +            "select": "GRAS_PERFCTR_TSE_SEL",
> +            "counter": "RBBM_PERFCTR_TSE",
> +            "countable_type": "a7xx_tse_perfcounter_select"
> +        },
> +        {
> +            "name": "RAS",
> +            "pipe": "BR",
> +            "num": 4,
> +            "select": "GRAS_PERFCTR_RAS_SEL",
> +            "counter": "RBBM_PERFCTR_RAS",
> +            "countable_type": "a7xx_ras_perfcounter_select"
> +        },
> +        {
> +            "name": "UCHE",
> +            "num": 12,

A740 and newer has 24 counters

> +            "select": "UCHE_PERFCTR_UCHE_SEL",
> +            "counter": "RBBM_PERFCTR_UCHE",
> +            "countable_type": "a7xx_uche_perfcounter_select"
> +        },

<< snip >>

> diff --git a/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json b/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> new file mode 100644
> index 000000000000..503b113df397
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> @@ -0,0 +1,240 @@
> +{
> +    "chip": "A8XX",
> +    "groups": [
> +        {
> +            "name": "CP",
> +            "num": 14,
> +            "reserved": [ 0 ],
> +            "select": "CP_PERFCTR_CP_SEL",
> +            "counter": "RBBM_PERFCTR_CP",
> +            "countable_type": "a8xx_cp_perfcounter_select"
> +        },
> +        {
> +            "name": "RBBM",
> +            "num": 4,
> +            "select": "RBBM_PERFCTR_RBBM_SEL",
> +            "slice_select": [ "RBBM_SLICE_PERFCTR_RBBM_SEL" ],
> +            "counter": "RBBM_PERFCTR_RBBM",
> +            "countable_type": "a8xx_rbbm_perfcounter_select"
> +        },
> +        {
> +            "name": "PC",
> +            "pipe": "BR",
> +            "num": 8,
> +            "select": "PC_PERFCTR_PC_SEL",
> +            "slice_select": [ "PC_SLICE_PERFCTR_PC_SEL" ],
> +            "counter": "RBBM_PERFCTR_PC",
> +            "countable_type": "a8xx_pc_perfcounter_select"
> +        },
> +        {
> +            "name": "VFD",
> +            "pipe": "BR",
> +            "num": 8,
> +            "select": "VFD_PERFCTR_VFD_SEL",
> +            "counter": "RBBM_PERFCTR_VFD",
> +            "countable_type": "a8xx_vfd_perfcounter_select"
> +        },
> +        {
> +            "name": "HLSQ",
> +            "pipe": "BR",
> +            "num": 6,
> +            "select": "SP_PERFCTR_HLSQ_SEL",
> +            "slice_select": [ "SP_PERFCTR_HLSQ_SEL_2" ],
> +            "counter": "RBBM_PERFCTR_HLSQ",
> +            "countable_type": "a8xx_hlsq_perfcounter_select"
> +        },
> +        {
> +            "name": "VPC",
> +            "pipe": "BR",
> +            "num": 6,
> +            "select": "VPC_PERFCTR_VPC_SEL",
> +            "slice_select": [ "VPC_PERFCTR_VPC_SEL_1", "VPC_PERFCTR_VPC_SEL_2" ],
> +            "counter": "RBBM_PERFCTR_VPC",
> +            "countable_type": "a8xx_vpc_perfcounter_select"
> +        },
> +        {
> +            "name": "TSE",
> +            "pipe": "BR",
> +            "num": 4,
> +            "select": "GRAS_PERFCTR_TSE_SEL",
> +            "slice_select": [ "GRAS_PERFCTR_TSEFE_SEL" ],
> +            "counter": "RBBM_PERFCTR_TSE",
> +            "countable_type": "a8xx_tse_perfcounter_select"
> +        },
> +        {
> +            "name": "RAS",
> +            "pipe": "BR",
> +            "num": 4,
> +            "select": "GRAS_PERFCTR_RAS_SEL",
> +            "counter": "RBBM_PERFCTR_RAS",
> +            "countable_type": "a8xx_ras_perfcounter_select"
> +        },
> +        {
> +            "name": "UCHE",
> +            "num": 12,

"num": 24,

> +            "select": "UCHE_PERFCTR_UCHE_SEL",
> +            "counter": "RBBM_PERFCTR_UCHE",
> +            "countable_type": "a8xx_uche_perfcounter_select"
> +        },
> +        {
> +            "name": "TP",
> +            "pipe": "BR",
> +            "num": 12,
> +            "select": "TPL1_PERFCTR_TP_SEL",
> +            "counter": "RBBM_PERFCTR_TP",
> +            "countable_type": "a8xx_tp_perfcounter_select"
> +        },
> +        {
> +            "name": "SP",
> +            "pipe": "BR",
> +            "num": 24,
> +            "select": "SP_PERFCTR_SP_SEL",
> +            "counter": "RBBM_PERFCTR_SP",
> +            "countable_type": "a8xx_sp_perfcounter_select"
> +        },
> +        {
> +            "name": "RB",
> +            "pipe": "BR",
> +            "num": 8,
> +            "select": "RB_PERFCTR_RB_SEL",
> +            "counter": "RBBM_PERFCTR_RB",
> +            "countable_type": "a8xx_rb_perfcounter_select"
> +        },
> +        {
> +            "name": "VSC",
> +            "num": 2,
> +            "select": "VSC_PERFCTR_VSC_SEL",
> +            "counter": "RBBM_PERFCTR_VSC",
> +            "countable_type": "a8xx_vsc_perfcounter_select"
> +        },
> +        {
> +            "name": "CCU",
> +            "pipe": "BR",
> +            "num": 5,
> +            "select": "RB_PERFCTR_CCU_SEL",
> +            "counter": "RBBM_PERFCTR_CCU",
> +            "countable_type": "a8xx_ccu_perfcounter_select"
> +        },
> +        {
> +            "name": "LRZ",
> +            "pipe": "BR",
> +            "num": 4,
> +            "select": "GRAS_PERFCTR_LRZ_SEL",
> +            "counter": "RBBM_PERFCTR_LRZ",
> +            "countable_type": "a8xx_lrz_perfcounter_select"
> +        },
> +        {
> +            "name": "CMP",

"pipe": "BR",

-Akhil
