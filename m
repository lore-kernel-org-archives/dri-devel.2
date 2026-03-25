Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD6E103A99A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F5910E1FC;
	Wed, 25 Mar 2026 02:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oSQKfRKV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/jUd4eg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA83110E1FC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:21:59 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCf6a989054
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AZAjTdb23/M2npBdSvUtQcYv
 RjizA7ic31PrulfVWko=; b=oSQKfRKVMxs0oobZOXyFZT9OeR5KNgHOvM5gakng
 hErYKWEfrS87/e2cF3ok5EUbZvj/x1/A0j8CwRvX8yxz/8o5HGmmEKYE/iYK5Pnx
 Ph2eALs+BFczJ7TdI0eWWMadk71d/WDtSAKjJnDQwfZuOLfCNOol+1JuDUEwxwtb
 AGJplG9jnB2daZVP6PQb5W89MBOfv0navTSKktV2IPHZMj6KCE8Em9y3Cpk5ANy6
 reegc1TY3tqFmb0ZINQGPvFPCpzQ7e/rAtRTqRPcMrAbfD5DGPoE8g+0Q/WdB4ws
 Fq0ldN//08CeXRMEqAxU/OldOm43b5Ru6lOxQ7lRQO/Czg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m2p8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:21:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5093a985e21so428722951cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774405318; x=1775010118;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AZAjTdb23/M2npBdSvUtQcYvRjizA7ic31PrulfVWko=;
 b=d/jUd4eg5l2hCC8RxDvytmPuWaUk5aokDcG6cn00O2Cavj+riAsVOcXrA1+mz7QAri
 UdH/W8dlpeHxLSJe5GarFxQ81GfvLKyFtoRvqGf+RZ1iZw8yn4mXwDfGZehL+/uXqx2A
 D/sH8Y53EYzqN8VmGNv1wdc1Xlk3C/g+i5BiYqIP4T3SPBBkEYGIhK21tkmtfMj2DUZk
 NXQT4FoJDrNsCCexKWMJhCYYosGeiBxnEDaqRuv+rSOpos3Jw09C42BrHpBVobM5/hEu
 aaLTKaWH8p5ILlsvL2ghqlFhl6FIb+TiluaQ/47Z65PQXltPCW6iuDdQEyJxVOuhVAoC
 GRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405318; x=1775010118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZAjTdb23/M2npBdSvUtQcYvRjizA7ic31PrulfVWko=;
 b=XGi0ybAv06wM2UYSZ8JbhmmOg8vcGkfOobTugBcAIOkgNTBmlUmntCmqXGgNfXZFrQ
 o4WAi2/V3PN0Wii+Ez6wwjf78r0k4q17q9dvMUcgSFkJe4ihPR1BAZvVXS9nVxztCD95
 q2oKVRn2gR/BbvIUtxaIOMBwQn+GOkLp+Ax+tEJQGpeO6uOVdmp8dyQ3ZUAJZ3uHQ5U2
 3P0AYAQCmYFHzSNxqjaTjOcJ8P8MK+NIPXqhAzI7F09OsbA+OrAn0GtjlZy4CUraddhv
 2xtYvFnzzfi1yQeguX1LAnR34q8+6PpUj3AAC14JhqufFvD7Z6wz28ssztNw6uvoA8KM
 l+Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEceVSyB2trOyONJk6Lj/Odl5RxOSghELG9vzW8UEBkV1W71ux4gx9PkQP8BmcMdfPOAsBeYFrKo8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyAjES+hBuiI+bDZ4hyXRBzJapMX6AiGzRDo86Bc1nHuWH7Gpw
 tTPmtEXTtcv5rEmvZoKQdzF0qwyV1n1lU9k1DwpazGwYJBYG9+Dhqcgj4fQXW3/Gp/5Lnd6IDXl
 kmWynfo6cNF7PBPP2Kq4V3anIzqAMS0RBV07noekucsbvflm21GAv7x6mULqHPHIRvAw46wE=
X-Gm-Gg: ATEYQzyuTJwl9gtoJyBBdIecIqHnn7+KrrcXMkVwL2fgaka1+bVdllOJ4Fv1Yo5s11Q
 zMm0s3DqGeTeku6i0ASK8SqJiFu+BSkWnEK3yItYe3zNDkiBzm9ZFa61E/RjRF3WIrCI2Tqi4ZJ
 rQQntejf28ZN6Mhc0Epu/DpgqhA3HYe1+5KkbPv8cO9ZyEOVTbBGJpOfnbGQAqpyb0MJuYIZ8w7
 uehUBHEMEismgSuJwERL4A+HLF+EsjK9YqtxFEQJK1VRH1fEvfLDy6vDBNsZVkMsF1cOYP+ntyT
 cSuTm1WkHYqYlxtBUVKfzpYKXFz78R9HcWnLRwT2FTWwY6bPhH3WWiBRLOGwyOqSs5PcY4t18PF
 FGmd5XLCuINTYZOB6cK0UQ3hDSO9gI4rZnrim94gkqeU0md2ddEFEvBf+A0DYpMuHIA/GwyVuNC
 UAMkewpYueBq/MgxWmyhAVRNEysWtS7ZyE94g=
X-Received: by 2002:a05:622a:356:b0:50b:51eb:c353 with SMTP id
 d75a77b69052e-50b80d3aef2mr27807341cf.31.1774405318422; 
 Tue, 24 Mar 2026 19:21:58 -0700 (PDT)
X-Received: by 2002:a05:622a:356:b0:50b:51eb:c353 with SMTP id
 d75a77b69052e-50b80d3aef2mr27807021cf.31.1774405318019; 
 Tue, 24 Mar 2026 19:21:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a28530660asm3530091e87.71.2026.03.24.19.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:21:56 -0700 (PDT)
Date: Wed, 25 Mar 2026 04:21:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Prahlad Valluru <vvalluru@qti.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: lt8713sx: avoid 64-bit division
Message-ID: <avffo5ejnmtidp3ime27onpx2q5zwwpdcxxcj6t6n5slms3g5j@k3tluzf4vqh4>
References: <20260316215920.1993390-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316215920.1993390-1-arnd@kernel.org>
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c346c7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=BHw0BEnDFb6jVTUBZTMA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: TXyG7YlJO45GgN6yddXNlAeG06CLK1cx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNiBTYWx0ZWRfX3GHTFsGbJ019
 eHDimH03U0obhdz92guT+hShmkJf21LbI4jwjDEeVFn50Uv75hf4SFINGacfpSeFL3nr+/M6F2G
 0jlizPl8H/HdN2R3PXqxl5PrT2/iqYFovpwJ4ouCZt89SDbhpoJeTWbIUa9Y3O1b2TDf+qgdG5z
 zZQ6p+KJcHPIVO5fVeW7ZbC51oDB0lDTT2a3mfJq3f7q7JcSJam4tu2Q+grslFv3JxyyCD6HJs4
 ePbADUqUIsiNhXBjxI2R2x1xOe0ScBci5sCvnWt8rRLIXFMstn4vPvoPA4EmGWD/FG4CYWqMG/k
 a7sKxuQ9t5tlQ+0HzIC6VmfQlsAvkS6wxKxgSaP62KqlrDVpoIN+xCroThyRStxiBkpqn1biOya
 Eqd5WPYQxEuMpALX2Xu40XNeINFrJ9gT/a15xFqoJ8ocTBbKxIEdVYc1FuFH8TXNFFUAvUlvv3m
 ReUM7TNNlj1iU3E03vA==
X-Proofpoint-GUID: TXyG7YlJO45GgN6yddXNlAeG06CLK1cx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250016
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

On Mon, Mar 16, 2026 at 10:56:32PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On 32-bit kernels, 64-bit integers cannot be passed to the division operator:
> 
> ld.lld-22: error: undefined symbol: __aeabi_uldivmod
> >>> referenced by lontium-lt8713sx.c
> >>>               drivers/gpu/drm/bridge/lontium-lt8713sx.o:(lt8713sx_firmware_store) in archive vmlinux.a
> 
> Since this is a constant number used to divide a size_t, just change the type
> to that as well.

And if the firmware size doesn't fit 32bits, we are in trouble anyway.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 
> Fixes: 4037c6adc1f9 ("drm/bridge: add support for lontium lt8713sx bridge driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/bridge/lontium-lt8713sx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
