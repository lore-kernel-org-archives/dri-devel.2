Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A05CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E0D710E477;
	Mon, 12 Oct 2026 12:06:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A1710F06D
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:06:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0WKa2252698
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JQGb7wV8QBDsJJE2TUk92K6f
 TbAus6ZSYAa/PxD5KS8=; b=gk9YS+fiYhiYoOO70Lz+G4t69FZOmw1SOidJInvb
 V5n07EXUAWrIBNNZ1FhH8BaA0c+L4df1zTU6TAVQ/A0bIISM26HBJV9GG7MGU8lk
 sMRFJdX/cIprOaU2mbk+clOqZ3rq4pOoXZqxZd/79Y/+vVt9hfG+WEG8s6Zngisl
 +IAawpjPCd22/hHbQpE6aOJDLPKSrIC6nv4Tc47+7Rcdvk88JLGZavmYrkB9x0rn
 ryl0rdXESfsvqUlcO79WI1rgT7IMhWd0kXz7Qnb+4sFwxVMoCZy6HqSkbMXTcCLl
 meSyXCZRySuwUoU6nJrPFhcCOznmH3KlOTG4Tk0e/7/Qzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j712vjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:06:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93dd3c3badbso413250185a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791806760; x=1792411560;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JQGb7wV8QBDsJJE2TUk92K6fTbAus6ZSYAa/PxD5KS8=;
 b=DOJxHoC1HraEoLViPvhVedF8b7V+7P30kve873Epv7D3gim04yd5sN0Cu4b+md9XWk
 03G6gWMEkj4UQG5ylDUGxF4keJcQEjd2ncf3+MmSKkneMlkiQCO5pQtaURM0MqmQp8Xr
 5gJJW/ZWahFh9YFDQXoC1n9ks8EE5fYzj+c8T0SjqAEd7pw4LksUo3Q+9KuzxsJFhB4i
 yV2ajn0BGbiNHI9aRI5kvqCLbI/zL/HeUbovNrCVF576kpLHdrESiqs7NN55H4vrntG9
 nOH7Oroqe5wlNIzRwWm+5wiRpsdRemRI9myOVM9L4G4LGaaTxKNhN0Zyrf3svY5ifWPs
 XLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806760; x=1792411560;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JQGb7wV8QBDsJJE2TUk92K6fTbAus6ZSYAa/PxD5KS8=;
 b=VfZRTGSfPOYX66HEKPIFmxLal9Ap3bK7lxBXouze5fsky/iWrdO6IQ5gD32TPqHTqw
 jj9r/Lpfi8y2xF7ggYRKhpTM9SNCFwFXB7H57Lw0BphHD/SJOt5ZeThfFXH/HEmEVb6n
 pZ/uTsHSJPCI7//EmR25PcCSNlSZeEOYGgL/WunJRSwQqVOJy/6F32kiwCJ0qHgnRBKU
 GoYIJ1MbOwX7bpq/062mtFz4YHgXSOaN8mEcadmA95+Fjydqi2DYxBg2BG1Ms6ZW5ME5
 WFi2V3RRbe3hhFOuAbz0YKA0UhnfcDD3PH2e6FlxEt/5cDYsMtgnS+HtrWSWRlhK4FMX
 9gCw==
X-Forwarded-Encrypted: i=1;
 AKwUvByB51VMhVH2CuhD9lMfe/+TJv64Ky4I2KYIB3p51Vpp3YpssZac4iMA/LZtcduB5I3x+SXCIULJzNE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJiwIjy76y8rFokBifDwK1pwwT0XqxFA41fs33K+866ZVbLZfNW
 aMbxdM1BxD9/R+UtNCdwdDTa+x7bJprN+HaKwAyzUhQ6NgRc+N+P7pN9ULp59m6OlqjGn8F93gv
 K+kIzXV4RKme6AYXAl1POsFKndDK5k47Vipbemh4TDkzficY6+7iCN7v3t8UdPSvI3HqqwKw=
X-Gm-Gg: AYBFou3IbGyq/zkVR2UYMxl6OiknI3DdGA00u2KF9YhXtTxAv2Umu+F7wS2yTVObjj0
 yq3Dtw9W+ifu77kNxtXF6eeskATX5rcIqqTrFGN66sivcdtZSYaaS5IYGh2xkhYDDDYv5O4MOWw
 ewGxHSMHZqjsTIciiPbfh8LYzAPKORrC5ki0FjdTZlgcSzXPbopAEt+GX+gbFbFuQ7+c0+Gwiha
 qocTHG1egHgP3mA8cso8wUvPNII1W/H0hYZz+6LQzH3BTWzZ5SDaZSTcNG2+Rx5WhuSXtPkPUHQ
 b7PL0fecbZ/h6G/KQ+DV4ZIOedKgaWFKzvExicnIeJMxzW9KY0hx9b69RwEHykyeEs7VZZIEe72
 /Sr4Np4NpuTPbHynpK/wHAkUlELx4tiigoXVh3kYoevoY0ky0EcCqf7wxLdkjJICaL8PYZwvHv8
 X5mfThVIG7C8kU
X-Received: by 2002:a05:620a:371b:b0:93e:6c4f:bdfb with SMTP id
 af79cd13be357-93ebd22ab17mr1631960785a.48.1791806759618; 
 Mon, 12 Oct 2026 05:05:59 -0700 (PDT)
X-Received: by 2002:a05:620a:371b:b0:93e:6c4f:bdfb with SMTP id
 af79cd13be357-93ebd22ab17mr1631954985a.48.1791806759159; 
 Mon, 12 Oct 2026 05:05:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ddd8a0basm11338201fa.5.2026.10.12.05.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:05:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:05:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] drm/msm/dpu: rework layer mixer allocation and
 mode limits
Message-ID: <ahg4xrildtnicph5ecwknrxqwkct3odcjkfnsc6ehympy6y5mz@ddwmentwnuth>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NyBTYWx0ZWRfX1GaqNxz7DD+P
 In+cYyob96byB1HoB+vZ27PwsAP26+vLEk7kp48PKqiaCCUtp43zz3hmIyQ9kjAx1TBKRWrWXEv
 WwAc9hh3gU0PF4h85e5oiLaVTBRaA6g=
X-Proofpoint-GUID: HXbWb9ZKKjcrqapf_iLYb6rnaq3OYS4S
X-Proofpoint-ORIG-GUID: HXbWb9ZKKjcrqapf_iLYb6rnaq3OYS4S
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6acccd28 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SCZu2Cd3t1KZmZdEZlMA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NyBTYWx0ZWRfX4NAdXrlxtsdc
 esGbPn58AlXKC9hw/geGWtA+BgxNMtgdi5DfZR0XJjh9lyihIKwMIWEVITg7ylkVbzmWCCY0/Sl
 YN9jxbfRUxy25qpXyJOaX1MxmS+moez7x8sk9mZq0MGDRGvhyhiTRpZ2cl6lo/ywItEUmYh390y
 tGLJIvyBN0XR5n94fgunLRNmV+N0nMo58IlVi4fd2KNYl0zMg2wvRX+O98OoeEeCIYLTNcLVeDW
 lJt8ybmtdpgtDt5rq6vN/24Bya1XS4BoaJerksSBvlY7NGW8fZvvIX/xgC6UTmu2es1/vFmM+ci
 HaT37NKJNf5SP3M1z7Q4dOlaz1kiZvF8QhY0j1skiWAP+DviMoZchOht5iDlf2tycqcs6DI+Bgj
 L7SOcDi2C7ySGW1bzqCRQ2QLe7LM3kGmIvk89cqSYxNvccUrTt7E/GvwX10P+0a8lLQ09oXT8jQ
 Oylg/R2ErQD8Ce3nBSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120047
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

On Thu, Oct 08, 2026 at 10:53:46PM +0530, Mahadevan P wrote:
> Currently, the DPU driver bases LM reservation off of the maximum
> supported width for the layer mixer and an arbitrary MAX_HDISPLAY_SPLIT.
> However, these limits are not hardware limits meaning that a single LM
> can support higher resolutions.
> 
> Switch to basing LM reservation off of PINGPONG and DSC encoder hardware
> limits.
> 
> This revision also adds clock-based mixer selection and a source-pipe
> width guard for mixers without source split.
> 
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
> Changes in v4:
> - Rebased on msm-next, resolving conflicts.
> - Added clock-based mixer selection and reused the helper in mode
>   validation.
> - Added a source-pipe width guard for mixers without source split.
> - Extended the catalog cleanup to newer platforms.

What was the issue that caused display breakage on the CRD as reported
by Xilin Wu? How did you fix it?

> - Link to v3: https://lore.kernel.org/r/20260112-max-mixer-width-v3-0-f98063ea21f5@oss.qualcomm.com
> 

-- 
With best wishes
Dmitry
