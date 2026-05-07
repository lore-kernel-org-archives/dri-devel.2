Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F137CD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A72CA10F174;
	Thu,  7 May 2026 14:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="adwB2c9Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMxa+zfh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455DE10F16C
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:26:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BenGh3157738
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 14:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dZS4Z+n5yl3239JmhoNbCdzxJTz/lzr+NgykezCYlEg=; b=adwB2c9YM0FDWiD0
 cmohKfPby6lxzA0BsnDT284VXkXuOkgeUt5AL4J5FGwrvvEM6YasblgKxrPUt6fB
 wFIaK0JJyyuoqRO76/NMXdt1SExdMQkustWMCOkLNI4jUxE8kGTFkgsgFxqPwhu4
 Wm4og2BspTUhFWN93HSR7QYIG6USP0YGUNpCMqhVmJon7if0RT0DRZM49T9BJHPN
 F7vMDK/XkgFrS+oi/owf9+Q9zdE1cjlNkMLU27Mv+Ff+O7YsVeoRqoY/xc/2/VN2
 299HCLLyclAf2rrOmJZHBx9ji+oRbaxrHxvFEzCXwVcEtGEhsv/0bkXNkkz8ROPf
 +q/QIQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhf206m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:26:00 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-65c364b8683so841884d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778163960; x=1778768760;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dZS4Z+n5yl3239JmhoNbCdzxJTz/lzr+NgykezCYlEg=;
 b=hMxa+zfhfHeLMCOW9S3hdhZSL0rPLVeADDR6sEcYw2wmJZ5aYXJPJK32H5/7vsrFzc
 jnIYHRH+iGlvm2EJB0gcK0cfGYZkiRrW099GuOp5wakvFemusgZ9wnzk9uKE3rmGlVkL
 MGunKqdD2ltBMponxUX0fc+NnQtrjHz4peCC90QmIRGY/iD32zqn1C9BjgiR88huAyYw
 b6oWca5qu1VOCOizbR0cJKogirooBsGqak8oqY8nHK4cunzcZsSnpYL2BbMaIf1vREW+
 rEMN7ONY9BFrz6RlZ600fomek8o8qnuFWWl13gk829LgEG9ApHW+ilAYy/0HkZ/LGHBM
 nouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778163960; x=1778768760;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dZS4Z+n5yl3239JmhoNbCdzxJTz/lzr+NgykezCYlEg=;
 b=YL+ZkjsbRTlrJ0SOtTFbWwUlk2CUDegQ841gtMtsFxi9EvnYHxaU0iZnBaNo3JyMkY
 8BKd1NRUbrE2eq2KXqL+ToI6efuhTq+RYmngYv4I3DqnODw94hw/OArucbeRxqN14aUo
 TYb2yNMJ9GLKK9jFQpIqIU1FEzUBYi/t1k86si8yKASHWqwYyNqWwKvwoMAbsRA6OQ3D
 L7mVICAkhUu5iU7ubD/M6DaCrp0Z/bqikuC5pX67dxHP86ZsTL6xhtnHqlHLy50KLhs8
 CbRrNE+cdLDZEHI5WLU/o58fRIv8S2aXALTaWF1LXOBdAq6U8hdPh8p96gw9+D8jxWbA
 7cTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YJKAEmrZQ94UPStSWvwBZ0Xd/wwrKusWxr+C0j4rXyF5hxksfSaNCI49RI/o55UEiydM7bOSOijs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXwXmjP6bRAN8v6Q4CNllw9BzStOCazuKILeyQmWUskR5Ozc/o
 7gQJewlTVTMEoxVPaZbt4fROra5v/PdqC+9NJFbZXAzomhB18RmXpz4jXV3/HiNX9IVc/HxZ75i
 ZUIL5lCN/+nx2dvJkCE50pcc2atwRZZsAfF4aHQn9iEYy3IA/YAfbgeMdqOBhuNfIm8oGaYc=
X-Gm-Gg: Acq92OGtF1n9djLNCIJ/QpQXCPDd79DaXRHGlKLq2+Mpfro23fVradYCyKaXv4I2/U5
 PgQil/v4m7IR0rUp+3lRvuRGPPiqQCfrKvW9tfnI0JQmxy7/3J2AQwvUIeXD7SNWnJnkkTwaeLR
 ehBYKQO4A7nw2laB0CL8QTnNP4idYVVMmBJkKXPBhz58S+YpceVvS+cD6x8tjCTX0ZzJ2SUoMJj
 uBQH/t6OBgEl8+tB2HfkQXpeV/jKy8FIHMVWZobY68OHd4JZIr9YLBkQXPKgXJ5B+FNohRh+/5Y
 jqJAGCMxe2BiCLKCABA2Lh6PbKjTZFVs2UOz30NXrMHoyRuh77iSFq7KVT+PzCs4Q3LKipQpJJQ
 rGoyF51P39fbIuF7Fwzh1UnK3kaSmanpIL0tPyW6Bf1aEGJnhUzX3kzU=
X-Received: by 2002:a05:690e:4846:b0:655:5ec1:59ba with SMTP id
 956f58d0204a3-65c79e60c5bmr5123320d50.32.1778163959705; 
 Thu, 07 May 2026 07:25:59 -0700 (PDT)
X-Received: by 2002:a05:690e:4846:b0:655:5ec1:59ba with SMTP id
 956f58d0204a3-65c79e60c5bmr5123287d50.32.1778163959303; 
 Thu, 07 May 2026 07:25:59 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65c7adeb830sm2719495d50.5.2026.05.07.07.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 07:25:59 -0700 (PDT)
Message-ID: <8fd04ec6-1337-4d26-b20e-02d3429d7196@oss.qualcomm.com>
Date: Thu, 7 May 2026 19:55:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/29] drm/msm/adreno: write reserved UBWC-related bits
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-16-c19593d20c1d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-16-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0NSBTYWx0ZWRfXyepIGAYRH9xx
 8qfU0UHgUBZf143aMrubM/dyvBTJ/raVhu7xqmgq76kmVoaRbz/FpnwPI0Jtw4uZb2G2Mbm4JFA
 jgHJPiuWKuY19ipzVUJGk+MY/h+l1D98SuHZISWC0oB7XSSr2tijrU5EzoKG8NpI9KtSiIshpkC
 Xk0j13nNHC5yVNhTtso5APppiyMR6G/A3jXNvTZDvj6gKrNWHYB7SI0VJ/XP1NW3TmL+5TDLw9I
 DYZhF8KJUr2U/ImOrnOZQK58L4iXoGjQtUkAOQ1Ri6Li1awzvopjcpwult0BCj7hMxgsLG42cHS
 t/CvsEnqY7QSMHHzrHMXJuNEROmbd0S5l2kVrkLh/skGAWw3pN7z0F0hmvUIGM02vSVtu7ee+gk
 /1MUIIxgRoqHfELr6YEbaQddZ3kme7shLG1fLFRQAGlXaxIAGQwjVOnajVqTje7GgZd+/8L82Qx
 Fkp4AXhgq7l2lABoO8A==
X-Proofpoint-ORIG-GUID: 3kygSUOtCWKY2vuAxr6JOlbhtCZDWl0Y
X-Authority-Analysis: v=2.4 cv=SuagLvO0 c=1 sm=1 tr=0 ts=69fca0f8 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZswEv4b9r44Tze3PQiwA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-GUID: 3kygSUOtCWKY2vuAxr6JOlbhtCZDWl0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070145
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

On 5/7/2026 6:33 PM, Dmitry Baryshkov wrote:
> On the latest A8xx Adreno chips several of the bits in the UBWC-related
> registers are now hardwired to 1. Currently the driver doesn't write
> them because there is no side-effect. In the preparation for the
> refactoring in the next patch, write '1' to those bits anyway.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 53def136e0fc..7a6223ddd8cf 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -288,6 +288,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	switch (ubwc_version) {
>  	case UBWC_6_0:
>  		yuvnotcomptofc = true;
> +		amsbc = true;
> +		rgb565_predicator = true;
>  		break;
>  	case UBWC_5_0:
>  		amsbc = true;
> 

