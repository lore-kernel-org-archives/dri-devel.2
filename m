Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F12DCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29B710F185;
	Thu,  7 May 2026 14:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBvYNpit";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PqKkDL1N";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF09610E26D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:47:37 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6479nUjD1671923
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 14:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /3JgrC7UvTp4naNvuXkki49ri1BHchLSl7wHWcJmTuM=; b=WBvYNpitYEcOz4On
 ewod5PR5zejdMaJnoxj6Sle1QDC/RM7QzQsga2phfCRCgSCYSymVwqix4rIjK6vk
 o1mbdTtv++XF2mIy+mMonTmkwyC5Ea+CiNX6WdDlvk0d+0KHrbWkK6ncHqHBxUjZ
 6wDrUyZH2c+fg5ivjREOdW03IThkLQM9Y0s+4oB9RqvbmoeOZALjp66O2bO4vUVk
 IDyJb2RfzwzQ2c4bUOuoEaRIguj1ppzgbZ6L0L/rCVRmm2BM1bL+iDTRMfnUtyiX
 BCEdBUzeR47l/R3bwPnBfm1iIbdRx9stflqxVCP1m07dTFYRNSQ/Ahzqcz/XPF48
 0wrxjw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p2cqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:47:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso11820015ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778165256; x=1778770056;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/3JgrC7UvTp4naNvuXkki49ri1BHchLSl7wHWcJmTuM=;
 b=PqKkDL1NY6AqyUtyBnhHU1CLntxqw/zMCa6u9mQ+FwSTYT26ZHlcHeDKhMMLauja63
 wMca35OU1YI4mmJhWiovHpY3ntkgnkUzh/XrXdaDhBbcdjMU6oJwhfeOmra5mTzFruCG
 wB7LPab8NZWE8G5WQV9lCH1kaYisrms84XOmIzmP4J8ujF02LZtJQpcxHBftV5qupFLG
 c10h97cZrpaKmZHCDgFB3TcxBKR3s5U0puOmHgArqUDSO0TC7fc1Oz5wRlq+GPwwEzbR
 e/T8ty6WeYbfG4jz75tFgwR1T+ruEkHRfveLU94P2vWENHrl2equP06uA3tifKvnJomQ
 Ta4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778165256; x=1778770056;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/3JgrC7UvTp4naNvuXkki49ri1BHchLSl7wHWcJmTuM=;
 b=F/hz7J0aOzDe5P+nnT86TW3hgu00/WE8rgc/KUZcaj0OvewOOpS2CQBlXs+X+kMs1H
 OsjtOUFoh9RzIzjRH8jmk1IKGCuUrMU18FlPukHWtLTqyTx6mVzWch3xCB41m5yhhf7l
 FZvQTlmD8lVtGcrLGNrD5kiytIkVy/4arBIFF+TuB/7t2x+MAbszLaVYz27oGUJSFyEF
 9DoY3Mz10Z1hcqRUWxb/tBL8wrp+IeQiMReNh+Cy2mDC/4RcubCQNtT8NkwM6G61cxBt
 jScl9EXtNaqVksrsVmOHp9Q4iTs5ei1XRSme7UzmES+AdyZkt2b4UeY+AwiJwn7vdB2X
 t1MQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zUDONIgD8Pe8SIu6TBGkABcV6S8hjzwt608wHgZ/WU57HPNuuq7nhyhK5eNbKLU4aODrpnCntYOY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/4Lvt/nAkEk7p35zCHihh8/8FfH1l7rBenyv5I9ikfabwsvf0
 7SrBhJisWGQ6SuG2mpCrN1Ae3s74iXEOGnLFMT2V1AQTG9yttgt1StTLPo7FZxjEHVHbd9ax8D5
 hLX8kHw5He0x3swsIOrUju4xF06g0H9YK++uL90uazU9JF8tXmmBN2ENuHw1LyG/XY9g8FWs=
X-Gm-Gg: AeBDiev89G/sAVs1uh4pH3983aHFJxWnhV+DH9/MU+yfOjwueMKW+i/4iL+UWHbpwDA
 mnuzxevtQvtmYjAfz4ga8+TcZndC90WfNQKfPcXHrXTIm2U2SyM0zr/UvRzpepRA2VdKIuWC7Af
 uvj/QYmsEjawfrLnD99JcGakB6VzzBFWmTr1PH43oq6S+/ZcAvmJL7ChLDL199lymm6I3JAMCXz
 JOF6v/C7KHq7rsD/0ubkT6j4YvBh+J2DZNFSTHz4mUtk+RtaOfGg3PxCSj9B4uSyDlyIxIX0U/y
 NsUAf0o94EzG3vhilW2OqXpniaHjK1vbZOpZnELuZI9lJaMJ+b9IxBCGQX9O6Q3l+I9vLZUtqfW
 jtD4/kSQXv3EUzoCWe2p6Ytuk7zIND/jvKhwSukks/xMUxuTGyXfSyIQ=
X-Received: by 2002:a17:903:2f4e:b0:2b9:ff02:a154 with SMTP id
 d9443c01a7336-2ba798c2792mr86545195ad.15.1778165256233; 
 Thu, 07 May 2026 07:47:36 -0700 (PDT)
X-Received: by 2002:a17:903:2f4e:b0:2b9:ff02:a154 with SMTP id
 d9443c01a7336-2ba798c2792mr86544885ad.15.1778165255667; 
 Thu, 07 May 2026 07:47:35 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babaac34a4sm31666325ad.16.2026.05.07.07.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 07:47:35 -0700 (PDT)
Message-ID: <bc52edd4-86b3-4521-9ea4-4fbd30fb4247@oss.qualcomm.com>
Date: Thu, 7 May 2026 20:17:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/29] drm/msm/adreno: set fp16compoptdis for UBWC 3.0
 formats
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
 <20260507-ubwc-rework-v4-17-c19593d20c1d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-17-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0OCBTYWx0ZWRfXzSW8tnQDXcfU
 hVlC43pE9VhyDJ/0lyI5Zo1CrdsZwfK3o46t/y2u7QJU1vY7UBB8U4YjICPqYtVtvM8F43qJVvW
 5zyFra4NjiPrltyGDOWBzJr8yxP5DfOYY6L20JCpT3tgi7H20349ZZqZJbUXeKtroRR1zqwiEKO
 2hnyRlv5jP/FUWoNCTU+DTM0bthW1VBTHS2U8cU9M4SktWtSnunErh2zXTMu+a2NlAAASPI4qXw
 CwMsZQLt+JS4/+OgVrPxiVuEssaP/g4yHRcZZ2FAG+ibLbFuGTQ6/oPN8HP/VvIflaAk9nKJkar
 375sDxxyO+u1C02tCwKEMxmCOcymAPx/qMUAl8vlvlmLEYMvbxfE5sgpF8EUzdIoSZsTr9HZN3M
 Chmt4tqw1LT397R7NIkDp0tgiU5XxcLaWYkKRvf5Vtpmg7zIWpACgTe7WdPyGE2dibgdid4uLRk
 CuTDr3lQWoj96As6uRQ==
X-Proofpoint-GUID: 2SX2IAR7vWApBjxd8BgNfRxFbv8Ezx29
X-Proofpoint-ORIG-GUID: 2SX2IAR7vWApBjxd8BgNfRxFbv8Ezx29
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fca609 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=4tzv1H2Sf9v1fZNdEqgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070148
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
> The fp16compoptdis bit should be set if the system targets UBWC 3.0
> format in addition to UBWC 4.0.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 7a6223ddd8cf..867c7d05f670 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -303,6 +303,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  		break;
>  	case UBWC_3_0:
>  		amsbc = true;
> +		fp16compoptdis = true;
>  		break;
>  	default:
>  		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
> 

