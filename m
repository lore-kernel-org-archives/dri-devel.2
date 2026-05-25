Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB22CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 14:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 078A110E132;
	Mon, 25 May 2026 14:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzIF6j+f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FkyN6uwJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388FA10E132
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:01:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PDoSB41588803
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I2xKLuvKpwz4CkrOfZZNnqoT3wHdH6+BVmL+VYCKYHE=; b=BzIF6j+f4mTI1yWw
 yusZQozgl4tSzZCkEjyjDMa8p+mUl//MLb7Y7C+w6/pUqLQ5j3tQIpenqyexm6FJ
 7vTbLxhZXfB/2mm47a26Fb3dB51OmqTdxjdyvMBuEdP7MFTBTy6vGqsqnEdoBxN+
 pGDvQWHgCG68ZOJ5s09SRc1gbNlyeeUViUdp+0VLV2KlccGVVTjU4W5Q2zbrXhPp
 ID59Ln87lnmMXddSrx8Pi+uztgaMObS7STymzLSDBSfhJ7Fz+tZOz4PvA+0Gu3GS
 wcuvuHc28WuaOSndLp7AaKMCzgO3PXDFfbfcfz9tzsU+/PvlqozTHCy8cIePdQUD
 RegVzg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txpyc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:01:28 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e60476151cso947995a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779717688; x=1780322488;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I2xKLuvKpwz4CkrOfZZNnqoT3wHdH6+BVmL+VYCKYHE=;
 b=FkyN6uwJkzzB6bY/fCdeOJ/MeV6YHaqo0jstuYDqskWUnZ3pgFcS4MgZomCh4Lk2n1
 dEO1WVPK9rVSHFVt1bCiXsNa6xtShMdbsvoVYrQIEB1G80gn2T3C+ImpKmzmWaVDpjRi
 HsLXeQP5rtYN8EiLuOQV4Om74t+tmUGfdoQmiEKKp22Rk4FdxnRxO6sczsglABaQ69bH
 h2PXj7rCEFvaSIlCx9/NbCuAp42YUDvYtRkWWQELLtYREbLEOf9dx3SvEedi6WjqpwY6
 iWwPY0ULMFH6MCyycUw8BGoGkvBzT/USlGTENb5REgMAnq75EgBldsAHYHIIclwqJXG0
 TA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717688; x=1780322488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2xKLuvKpwz4CkrOfZZNnqoT3wHdH6+BVmL+VYCKYHE=;
 b=hz5f5jZdVqDodmZqYSpjqAFUwKTUe1o4X6ONPBzbmpKk5qVpCita0nI7av+FuwGmcK
 7rLDilKFu8iPTPzWkU9+k+B41rUDGjvwk0wkA+sEH/9fGPvyCwS1yeazH/6yxxru85aR
 zjn40alW/Ae9AetiXN0rTih9Mxoprm7hgEV06BsAYLBKkY2qVhu9iyoHnqBBNC9jfydC
 61UBfgmaoBmCjc68Ze1C00NOHpi8SqnSf/ZwkE8QLWGzgUGe46EI31OsC4KBtjnRVtzA
 C+8puu9EdyqMAkrzlNKTp3utKp9LPNFR8k0Io6p6vjRzMt+PGFUDnqXqGUtTZyFx7+ND
 f8uQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8unXlxBtaNcEx39rBIFL67Boi+HcbSOm2drDyUGbXKf6BPBH8N2yKWSNanZrX7uQ3d8y/2dzHw/sc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTbImR/zDun8khtQ8E8XknvPGVkHm6GSeoTkVbtwnGdqVJbnI2
 1z19HOk+AiOsgTPNi4sa12svfyPM1mFdJHb51FCakv2s0TB3Vsoa3Ms5CDK3UuNtZcQOCFScKf1
 DZ+EgVVGqroFSUxOu1Z8m4NCRTBaubxbK5I8bE7OU8Pytce9tqLakPClxD8NQwbOtlscelzs=
X-Gm-Gg: Acq92OHf7qjgsFE4GnRKKmQRrQQAZo5czfKijcI8UwEydCTOfCKzkBhpS+mlGkzvGQV
 x7l/ntvbpaEhBTJzYmhP8lvo8XcpsAQTABSbpNupGOSBF96rg3z7nj9wH6d+fX5s1BMNODBM5lw
 /SuzwGijxq/o1qTAcEOHg45ZJYYMavb222Q2Fm4UuO0V+GjCOY7dhoSgyewinsnyeiZ7tE/a1lO
 hkfR0UabhQePltde0y4Qd79Omn3fhXpwh0M4lLqIq7kqU+EJZ/gOY3ygJaGiP6kt+b8QY1b+nXy
 BD41McvEgdzNh/QpBYL4nzbpwwfUQPk8GOcZurkDk8QbfeDaIPP9tmQahe2y0kHVqFBanEHITId
 sGAtTVQ5rB/jXos8pTnArqn7JI+bep6kjT2DjHs/6/SRxiA==
X-Received: by 2002:a05:6830:6f90:b0:7dc:d66f:9ac7 with SMTP id
 46e09a7af769-7e5feeed784mr5562908a34.6.1779717687554; 
 Mon, 25 May 2026 07:01:27 -0700 (PDT)
X-Received: by 2002:a05:6830:6f90:b0:7dc:d66f:9ac7 with SMTP id
 46e09a7af769-7e5feeed784mr5562883a34.6.1779717687150; 
 Mon, 25 May 2026 07:01:27 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688baf1e1fdsm4069015a12.19.2026.05.25.07.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 07:01:26 -0700 (PDT)
Message-ID: <79fff2b4-d8c1-4225-a75a-f9c2dc6a85e4@oss.qualcomm.com>
Date: Mon, 25 May 2026 16:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/10] drm/msm/dp: turn link_ready into plugged
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Val Packett <val@packett.cool>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-9-cf3ab488dd7b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-9-cf3ab488dd7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE0MyBTYWx0ZWRfXyCeuBInza/T9
 ICq7O+Kp2ZvweLNcfR4WRsrCB7I4U4Lhl2PWyOmuke59s7VbFSnF+xXyAZFHWaXoVNh86Rgh4ST
 CMzAoMi8OFvtkK2eG1ZaHoaWhi3kfSIAAFrQjX/dXbATSA/bfQb2bnW79T283ZadR2y0souOdow
 9FzXKWcDtMogcZQ+1y/8TzoY4uPP6KmJYvWRWKIjwuKB6riay44kEc/oM2SPmg1VL5aX+94ST0i
 UtahSS6cTIJr3XMnMSXkrsaxlRBgC2Rly57eQBlFwk12O1QqCafG+7+DBQ+4LkWxMNH9V4ZWFQw
 ul5hdVVmg38RdGDqBEvdCA2wtWuog4zcqpQsoUMazmrnnlZOLvEU8D/AKsLgSi8RBtyzNHw0Y88
 p81qLGhFafOmKVoDmJtJzZMzoHf3zJJAXYjgbDzOkY5fm7JEjYLOry8hNJAVerWKsutDMeNGvFr
 fx+VpciyzIwQn95a3yA==
X-Proofpoint-GUID: W3X0Lyvy98Xph4hnKc2a6iHvtiN_pYnd
X-Proofpoint-ORIG-GUID: W3X0Lyvy98Xph4hnKc2a6iHvtiN_pYnd
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a145638 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=j2DAZ_cRoNPVBr-R0xcA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250143
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

On 5/24/26 12:33 PM, Dmitry Baryshkov wrote:
> Tracking when the DP link is ready isn't that useful from the driver
> point of view. It doesn't provide a direct information if the device
> should be suspended, etc. Replace it with the 'plugged' boolean, which
> is set when the driver knows that there is DPRX plugged.
> 
> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
> Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> -static void msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
> +/**
> + * msm_dp_display_host_phy_init() - start up DP PHY
> + * @dp: main display data structure
> + *
> + * Prepare DP PHY for the AUX transactions to succeed.
> + *
> + * Returns: true if this call has initliazed the PHY and false if the PHY has
> + * already been setup beforehand.

This assumes no failure. I hope adding various return-value checks across
this driver is somewhere on the todolist..

[...]

>  end:
> -	pm_runtime_put_sync(&dp->pdev->dev);
> +	/*
> +	 * If we detected the DPRX, leave the controller on so that it doesn't
> +	 * loose the state.

"lose"

That is done.. presumably so that one could correct a coredump or similar?

Konrad
