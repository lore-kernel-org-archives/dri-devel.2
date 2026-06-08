Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962A3CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5D510EDBB;
	Mon,  8 Jun 2026 06:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h1NpwClZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6oBgSnq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60C510EDCD
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:55:25 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OrxS2274544
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lAb1aizM6FPZXAuhv5xV1KHu
 AlfDJtLdX6Y70fKJtdo=; b=h1NpwClZJo13lTi4lZZXh6bXoMiAAVcTHkbnn9vV
 NAGy4ELbZYZHkSTMzE+46E38LMRxEUaRNl4MCLASRdhM5qidETNZyOB0yqosjK7W
 gVjZYDRNCtfQl3P61kMzK8r6VpPdKACTnBJBnfV/uhGcOjyE6PJMqKuH3ATzcDjl
 so6SiP6bjbDgTHNatuJK9rs1Uftq3voWNybGV3WUr8SY2aduYZxKzMj5YgpLGL+N
 ieCx4PVffpI/8m4qDIARrz8XJCZQ7ULAwYoVPQxcwbPj/iKqXxWg0lUJ7QqDYb8e
 uPVLggoaBTSPevX1qu8+tM0E7+LxCs3Cn/2aZTWVqQGTIg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgx3pp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:55:25 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6c40601e2b2so4551324137.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780901724; x=1781506524;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lAb1aizM6FPZXAuhv5xV1KHuAlfDJtLdX6Y70fKJtdo=;
 b=H6oBgSnqquf4dxPrjWLxCp5u/dHScE74X5+UKJPQVW7l+sCefY4EkFpKvzCpeVbaA2
 0jayl7MzK9E0fZVnvnpND2rVC+KA7JeN4Io3MQEr/Vsith2JkK8cb3+vjC8mSPoTz5f+
 RE1eOe9RiifxFdSpl7DlhnNeiSTjdxqKSxaekcEioiChJ87Wg0Q5SAPTsksuzoS66crj
 OL/XenTC0AS8q+//T3IvCYSRAW/DikxMyLFhg2308K8k0J1hHiXBjwvFapbSqWul32+7
 qItdibhjXXrPfd14qIv1y5QTiYhp0uqFE5SXgCFFBCRKDxXTqh6fnQSdAWfvbf8MSt2z
 /fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780901724; x=1781506524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAb1aizM6FPZXAuhv5xV1KHuAlfDJtLdX6Y70fKJtdo=;
 b=UDPOLdpfiv/p/iXaM7iw3Vmxh1dgHGEwbpSIVs5Hxvo7KJn/PMYShoMSwGYTITLz+f
 /Hj7hAdaDonci5E5KTz88cU9KoXS9uuj3V0ESIAe8OKjv+yXFwmbVZ0E6x0PslpziDxa
 jDx1KOTbLw/iI+KWSRoasGhzEv+/BcmKph/Maqbj9VDT20xkLXrBbTO+76aZavz+l7Gr
 UrVHw6QRJJoiyDL4JzxRijoALriXTlG5kmrpvtZJPOKJ9HOvNCOvYRaQVbLEWEznMn6S
 w4uzUqFTHWI5aySMJhXJ9zh6skFjmHvfEQN8j7Ddwnf8NHiopKsYBuFELkZ7nkBe78+F
 eUhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8enDpMaG5uCzilOubMLpUlrD3EiOjpvaeMtXJh/uqvhXd9hTqF3tUpbr5nKJ7yL9q4IszMD+j+Jgw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx54zFkbN3qbCEW2TMlIevsYVl4T6Z5tiN5dO7RWXW8lz1GEKyP
 Ahzfnkty2SGoK0F83SzLYpFyrw0tB1spKVr3hPxa3SEopifqIdp+cAnnvzTUu6mLS3L0REoL4JZ
 vYON9pJWqhQNJzM8XBT0Vt0DcmdInEx4+E+tTN9ULLki9knMp4K6YbkUXHDP8K1bIejcP37A=
X-Gm-Gg: Acq92OEHM6V8lx3vzPbk103KISIAxXzhJJDJLz9Tn0ETgAdIiYZ1G1iBOEEZj8oRgYO
 Div1UmSrDy7IfjMhBi8yItvEMHBitlHR9f5x+BLAPDernHHOn/uaAIkG/+yQehdTHhjcyA7Rd8d
 zdYigzoH6cbtNA/+qVtm3X+Ymxs0EDF3JC8v39mKh9Ipark+bWV3h4Kgd8sd5/R0H+bJRHMpjuj
 nkI+YuOgl//2vW6Ai0NyZPOZxbkzD9gWLI8MDv/DeaElNv4ynn3rc/6biTCfG9S9S56HVSPJdhU
 il2/koDNPba+OHR0mLgZBB/i59hcclU0Ydmi7IHXpKN6lSeyqYAPo5tfwkmUHUqgp9RzXtE6oFl
 GD+R/5yFwmPtPHvF2OC0DekMUZ3oJTlFNhtlSiyPx9w7PuBTsSg+L5UcyB/50Nt0VTczgBPYquC
 UAQCEP4eyAhLMJXAZB9HeMSPFj3SGxvNf9/SYyK03bjPB2rQ==
X-Received: by 2002:a05:6102:390d:b0:6c3:95ee:73b4 with SMTP id
 ada2fe7eead31-6fefe3bea6cmr7099938137.29.1780901724398; 
 Sun, 07 Jun 2026 23:55:24 -0700 (PDT)
X-Received: by 2002:a05:6102:390d:b0:6c3:95ee:73b4 with SMTP id
 ada2fe7eead31-6fefe3bea6cmr7099921137.29.1780901723936; 
 Sun, 07 Jun 2026 23:55:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b97b9c4sm3588080e87.48.2026.06.07.23.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:55:22 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:55:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v6 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
Message-ID: <vom5rxvlz6lf2roh66c7li4zjunewy32p25xj3cpcvx66lcxzg@yo5ch5qy4l6b>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
 <20260602-dp_mstclean-v6-10-2c17ff40a9b2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-dp_mstclean-v6-10-2c17ff40a9b2@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a26675d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=kW0YW-xf3kM7CBANKvcA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: msmngo8uQwJkyrtfXzapDp9ltHgDUH1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfXxhQMs39szQ2c
 jSi4JtbUHJze/q2dwl8BivNlSEAi5E978jF3GmDgOe1U7wRhFDeOIgLBYlcJhGuxkyOUZM/UWDs
 7LaxEQpztTzFTlI9azHyEKQlWZSUJoYyfs6GNi3QMbIICbztQQl6JsGNYBDpFfyafBSabo2N8iD
 9e3FUQ5K0AUGkO+/1xQbA7XINoh8HdfcKEQ8rz8/NbqPsqrjRDiFe4Jts9jHfgpxI5Cf+Hn+0Bf
 bTDz77xkcIw+uWd/AyoZghsJebT9xUci0M2bA6rOR4OABBara14YGa7efR4UPXi2yAnriDQNkMz
 FSso0OhhW2GpyojFPBgrCvq3R+AYR4BF4tltRtgFeIf+WVcFBa38kV2xL8gWmRte4Q+P8c8UA5E
 ChlNG5ZJed9XESSLn+P4+BGAR2ith8Odi4nEB9CeZNSbLgvqfBcRSzO/EtJrmSHCYkx4Z3i/Yxq
 zoe/AK0Ho7MzjOX15ww==
X-Proofpoint-ORIG-GUID: msmngo8uQwJkyrtfXzapDp9ltHgDUH1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062
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

On Tue, Jun 02, 2026 at 05:11:22PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> With MST, multiple sinks share a single DP controller, so a cached
> panel in msm_dp_ctrl_private can no longer represent the per-stream
> sink. Drop the cache and pass panel explicitly to all stream-related
> dp_ctrl APIs.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 196 ++++++++++++++++++++----------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  28 ++++--
>  drivers/gpu/drm/msm/dp/dp_display.c |  24 ++---
>  3 files changed, 140 insertions(+), 108 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
