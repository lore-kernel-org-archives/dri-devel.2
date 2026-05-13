Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A113CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 05:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B77E110E5CE;
	Wed, 13 May 2026 05:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9mxK0iJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5+L4KLt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BD310E0DF
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:42:04 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D4p6rc2338816
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IgM8gcz2SKfXvL/L07c+vZde
 l0N9q5supOksnstbB2A=; b=E9mxK0iJnh4Wt5wk8jWpZaCTi7xk8K6SL1yc6GpJ
 YcIHcTCiCYyJ3TNaY0fQLRYcUZ6CDHqM0d87yk+WUeO8TuwyQM9fcHiAJB6+4J0u
 9pJ4zcbFryfEpVsB95oD0R3YcaiwT/G/ezIuzaQH3QprQT8sfawnk9MuYMVNWLjQ
 rkJd4AEprOiCDwpha/6BOwp5MQ7mZ2OiUdjcbhwWeUKraqDK1kVS2GukHVwkU8SN
 YkP15PhowlZ7RaWudmN/FpAWMh0TkcCXhyuvuY1qm6TLxf0sb/ZpoTQxSg86Z/yV
 hIFT3cbpSGee69zWEGZEgM5tkrBwpy+579s9pu/+6aH3BQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vx9u55-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:42:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51009190feeso125177831cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 22:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778650923; x=1779255723;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IgM8gcz2SKfXvL/L07c+vZdel0N9q5supOksnstbB2A=;
 b=M5+L4KLtuzW/SizPFeK5Rbhf71U64NfRpq1aVgiQiGoiQl0lslCQ37RXf6LVpvTNQI
 3NPyFFciZULf+goNih+GJzaw1MP59LrnIyW++LwQzyNfS9oiOcR9ycpLNP7U0wMFZuZr
 LQf7pSh8h+7gnUyo9KFVmjZJSw50HCuQKGbQ48emVcvc5fuF6/FOvgkEstI0moF2mxRi
 mfv0zdhL8RBsGB9yfSKTD+Eclho8k4fPVqXtohXeECbFL/LTVHQyRq26XWU0RNj4d2wY
 jRZ+DysVBLnwf0KdVvIAonImHK22V1PigAs3EpVBvzwPaub1YXgmVEBo1N21q89vTnej
 3Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778650923; x=1779255723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgM8gcz2SKfXvL/L07c+vZdel0N9q5supOksnstbB2A=;
 b=rnirsAB/psSTwrpzGqNVXQfLbhwmhTm6n7UXggFM73rwWqpWrWOSOc3M+AVkulNmDj
 XdyP6NfHm6oBiR9Zp2DkGWqn/e5Y2cHSf+TXFnnu+UUOsv0KHZJlJy2B/pDErz0NIOz0
 zGb4el4Z982DxlQEVkuYldDfd0+nEM0yyRSkIsfQiqJCOyOo9l3di+TcXNft5sV+tGA8
 No9qbDoN6TtQHFfuYPPQ+S1fBXVBT72ckMOUryITCEFhG7DBOiKCsbI5qFWKMPfPnCjs
 zkbU0liiBZZ9X5nFtv+B0B/81acLhX65+BAk5uJ4IDKLIygQ8hspy6C/noS+jkwIw1on
 cEwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4BTJQmWve2JUw9dPUHWpKS+0l3kJhdZXnmvQJzX7DdEb4PEdyapUBY6QkvE43h7tbgHrBkVNazwI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5NQj68C612L/+9FUepHXLrvqGjkdG1BsKhXH15RSpPEXr2rs/
 cIl8cuc/DIqNljI3AItpgsyAfctBC84SMAoJMpS4QXdw62DcIir3rt4bYIN1b/iJHQou5YIjlwe
 MaKomQ562nBa7JeTASZauGXlsQzxE0frWlH2XHCGex5Si9CHnk/WpJE5j14kUgLUFzmi6r/E=
X-Gm-Gg: Acq92OEywIoC3h/wib3jSIMlju6tA7PxSAAaKzndjU/0tZCR9eRgYWDZtuyNFdCOnrf
 Y/4sh46FfaGyIbHyDyb0V3t/R/JKYHyjiwVm2KJ8nK/dppc58yu7121EM2xz9g9SeNVuF5ZdLBg
 DSRbqOyzAvVIxbpYSqVHAw+RjMH23kF1HaIqlxrDvRn72Vyxgn18x0rShger6LXvEg4T8VnA71g
 Rt+/q9WAiVUQg1OESAMqqwGHn/quMWlaqDTlTPEfBwnygAYUu5jnFaiv15u6MCLJToD8kekbWN/
 FWiwaexWsPBprBS//3aHfz4gZJaPuOaw6yE7SXhrn/mgPHJs89s+UEVCqRP2QJggijjyrC6FwM3
 wr5TQ4WJgDIC+n6hCh5yplzaFAZ802+TjD7MXkqnH1ikrRtVxuvDrRsG8p5VvXMIkkgwAcdjdpg
 BJ2mjNDtlakUzl98SUzXHmpDaxLYhE+PiMp5A=
X-Received: by 2002:a05:622a:7c8c:b0:516:3183:c1fe with SMTP id
 d75a77b69052e-5163183cademr9783001cf.52.1778650923463; 
 Tue, 12 May 2026 22:42:03 -0700 (PDT)
X-Received: by 2002:a05:622a:7c8c:b0:516:3183:c1fe with SMTP id
 d75a77b69052e-5163183cademr9782821cf.52.1778650923009; 
 Tue, 12 May 2026 22:42:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f6292993sm37660181fa.41.2026.05.12.22.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 22:42:00 -0700 (PDT)
Date: Wed, 13 May 2026 08:41:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 2/5] drm/msm: Centralize the standalone drm device
 check for GPU
Message-ID: <roeaegvmg2nvzt6j5yhmsv6p5vzhvsglzkmtvbnw7yq7u6bqqm@lo27u5mwsrwv>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <20260513-gmu-sync-state-fix-v1-2-6e33e6aa9b4f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-gmu-sync-state-fix-v1-2-6e33e6aa9b4f@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: wf0FpB2jtf9rBC0YUcCeqjf-eEIZHlNV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1NSBTYWx0ZWRfXz3FlM+2y2wI/
 9Y93FLbL7Z3gSP42c+uxT+zgaBAM/+IQh50DhDCqle6GtSRzXxHFbBDrTJsJjiVNMa8kCWOzGdk
 oY9QNNqS0k4n1vzUEvCEY1NgO3hKjwItHR/G7DOmp359NGlRCe9zK5JdE23LZudkN6Em2/iJZ9y
 04V2B4GkFxzrRF2o9oi8PU029dEMxon63g/Ky9oHGunwgUShb53Nzak8JS0rdufReJnFQoTzrpm
 167Z2GofJJ2AwWvWF2n0tyWHxvnzmGA0SKHeTrS51wE9RqznMKvJUOyFch9v4h2txfTfB5Tc/XZ
 Dj2/Jbv81rbpzEZspvqAKmRgLvNIeur/eou+CVyx9wj3PbPn5Jfs5InTuLZGKkoQZztlOdzyK7v
 kEV2eW72Jqc8z30MEiomaZb/A7A/FqMj7jmGPoxfbnPDvOdk3kzpq+YtfxBv4ZHcBn7JxvvGNhG
 nh97dBrr55ZFHXDnyQQ==
X-Proofpoint-GUID: wf0FpB2jtf9rBC0YUcCeqjf-eEIZHlNV
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a040f2c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=MqZai44AJBDnTZDtKi0A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130055
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

On Wed, May 13, 2026 at 02:22:57AM +0530, Akhil P Oommen wrote:
> Replace msm_gpu_no_components() with msm_gpu_use_separate_drm_dev() and
> move the platform-specific check for "amd,imageon" into the helper so the
> policy is centralized and reused by both the core driver and adreno probe
> path. No functional change intended.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  3 +--
>  drivers/gpu/drm/msm/msm_drv.c              | 11 +++++++----
>  drivers/gpu/drm/msm/msm_drv.h              |  2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)

For the next iteration please swap this and the next patches (yes,
introducing some code duplication). It's generally not recommended to
have fixes which depend on a non-fix patches.


-- 
With best wishes
Dmitry
