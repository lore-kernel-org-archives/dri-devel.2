Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79073CD8C8C
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2909112DF7;
	Sat,  6 Jun 2026 12:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cV9Ov04g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R8MXKHsX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EB9112DF5
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:26:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BERfD1330742
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=54X7KQzUXeCLylQBD9l9cQGo
 OcAgzYsMhQbZ3OncteQ=; b=cV9Ov04gn6P2U6PWOAUNiZB5Ssvky7hbJgnv0sXK
 5+1gu72UVri2PoAOkE3mIjwZJjw/fykHar670cgaA0+7jewByTevNxk/2D7c7Tlt
 9YBQYBjf+SMVWq87Br5ihPgs9fSfMzKteulA5GW/bsvrvBKRVKlmtR96vraknz5M
 fygkEmO+ydvCqv3QOj0GW1cn+NWoFuwfnKBSBR7Ho4LfXFodOb9RaOAfOzi8xjeo
 AVentumm9RGLKuXHLg1ajCB9zvwuneB8nvY0UCDHZOhLxDk1PRnxJEVmKyiE5RuY
 rmPtRd5Zoyaz/EnEGrBF0LN1MnxLLManAEwWXniluPMy0w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs18y98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:26:03 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-963bc9a24f0so2866451241.3
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780748762; x=1781353562;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=54X7KQzUXeCLylQBD9l9cQGoOcAgzYsMhQbZ3OncteQ=;
 b=R8MXKHsX882ZfjxO3TS6MHJIc3+QOz5AWWK1Jzgk5DSPnGQ3WNU1mrzhBEqm2GnRts
 8+EEtq5RTGP17ceHx27CIUo1p9hnWN9CfhES6iOHV4TiwvxA6Dy0++tGWrX0tQNg2nAW
 8JnmrfGL8lA55cWyOmCFMftxcckB7T9RSrk6SQRpsS92BBMPchXotqZZIWDWG1Cs4XLp
 viVggGW6zos/wOYVMBHzvmwXg0OS97V2Xg1aOf812gDBsz7J7JQxt62iytrRuM7+JEf7
 Zq+deX0+P7zpqwwkVoTC4QKGXuDDIVc0jdUrfsCDinTM1x9b1DsabPFpsCuxcitV1Kvt
 w8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780748762; x=1781353562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54X7KQzUXeCLylQBD9l9cQGoOcAgzYsMhQbZ3OncteQ=;
 b=fzXB+Py/38yOr0j9fLTcahhBNxLoQI3OlKeo2fS5TnlKxB8U+4tdAHeoeu1Ieqcsxd
 uOHeKTFXl4ifxUwyS9F1SWJMEisabQeM8JanZxp3B8umVzCpH9z51Nc2pszYxfQ+7Gp6
 n+9qMJt+O+8bPdOVaArroKbZaphK482JkLsvT8/bGiCJOhVlZyUS7xIT+USdwxdKjEkr
 qZBame5CHpmTHgmiyd2P9WfX92sdsNpOErvgCJ+F2BrT74L8BnLnTRdUyhwQUS/5JO5z
 c1POJS7pf4utmPYMp52e4dWxZ/Sam+tC7bIdseiX6LSoQCw7Wm4bkyqvKU2ArHa/OC3q
 PPTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9v2wVaq8Wbs3Bu8hR9VwKuuUdS3VYeAff2/0lVw7HjYYxPiP28b3dk0ww049CQVlpXL7HbilUN2GY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPVgLjbKd8u3FeDE/EXY8ksMMatD707y0M9+nycLRppiVLb11N
 LZAB/tgXdopmgYDiDGtSMqNzZIN5BjJKKEcaM29QnyOgBHpg5bAhZdunoudyWmLVI7ryDvkHB4Q
 +7fO+KOQESI0FCG+GeyS/m1mLO7KiH+5HWMrOlhT+cJFdoXxldRmMMEFtMFLso9vSV+ux2fA=
X-Gm-Gg: Acq92OGFwfKgOmP8a4GDEQthhaSV7b5VafzN8aOed+s4cfRL1XsxaP3oEbRQEJxIo37
 +CTl/bsu0IplyC9WOt9xYjwNw/3QjHx9ww3hucdOKLnv8qZz4WjP3siKTpMiwMTlbhkNafOKqnJ
 xqQ7Ftcee06+z2dqDQdZrcZ3+zEotn3BwQ0dE7E5huz4OSPufZ+cSZYpNvuDOUfjT/OtC6U3B0z
 /mslt0tibliVYw/jl/YfeC6BwnEe4TT6jFvvSlfQD+EqwvRTjnzurk4qHYT0uFBIFLEplerwyN3
 ZuNZYBG4ZbEQTLx0Z9xBS7yu5P9gwkJeIH/0xClEJUrVosXGb2DjrPbCWUfaQnNo/3ETybebQgE
 AynjqknU4b5q9pk4gdV/7+LIyRAev0hHAAO/rsBR2HDxrCZ7Zi0o+BLYp2fBnmb/G0HBsIIGxwS
 tAIw7+hOCcXDXK9nbiPzT4vd/tGNx3ImoTX9oGOJ1O3wiiyg==
X-Received: by 2002:a05:6102:6886:b0:633:c6c4:b321 with SMTP id
 ada2fe7eead31-6fef853029dmr4573025137.18.1780748761983; 
 Sat, 06 Jun 2026 05:26:01 -0700 (PDT)
X-Received: by 2002:a05:6102:6886:b0:633:c6c4:b321 with SMTP id
 ada2fe7eead31-6fef853029dmr4573016137.18.1780748761641; 
 Sat, 06 Jun 2026 05:26:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396abd6cbe6sm31142401fa.0.2026.06.06.05.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:25:59 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:25:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: Introduce poll_hpd_irq callback for MST
 sideband handling
Message-ID: <rikmu6glk2ehh64rdt2csucjyn4d2asv44gpsbrkz76b3ct5ro@u6ioy5ah2tod>
References: <20260606-mst_irq-v1-1-98bd86445c03@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-mst_irq-v1-1-98bd86445c03@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNCBTYWx0ZWRfX2A3uX1gPzrhy
 1Ux5yk4aw7d+Og/jkbiLiMd2tXdf3uhGkZ8GtHdijKFkQVGdWb184H5+mUw8jbQr937+JBcwDok
 B3UDjYzR5T+CzQ0mVG+pjxcHqiWfmoKQnra2+WINbUx339ycMs01sTKvU5yBw3qAmTDFEjpgp1X
 b1mpvC+CDuMpUggNhVZSu+OfhqjCviEEMJyRYzUqPKdRmYPHDbbgAlHy0F2Y+S8eYCj2PIv1EYU
 QGFuy5BWrvHSRdcC3f95gP1jM2zTCPU3PGRYzAg9JNRi7OL77VKClmK4B36j4hgZof3VsRofaVD
 wI71zQnXt7UrX88Ej7mfHvG1nZZH8/dQHgVxxWkqFYXnkWY5UHAY4UqspkeKF1Gj8RrXzhpwr2l
 f6y3HGEnns73l4v0Rzw42QPIHG5u85GSF0O7wNzojn62+UrjuzFxZ7qMYM98Zg6xDIOtjv+Gf6e
 +JKXxfDNFGXQ37PMTEw==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a2411db cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=xNi0aPyhXB9LEuxe7ewA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: X40uq1RfLtJYOQ8qkVn1Ifm3_8-O8s0a
X-Proofpoint-GUID: X40uq1RfLtJYOQ8qkVn1Ifm3_8-O8s0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060124
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

On Sat, Jun 06, 2026 at 08:05:29PM +0800, Yongxing Mou wrote:
> On RB8 hardware, after drm_dp_add_payload_part2() completes, the
> downstream MST dongle has a high probability of silently dropping the
> short-pulse IRQ at specific timing windows.

So, who does what? Is it RB8 missing the IRQ_HPD or is it a dongle not
sending the IRQ_HPD event? Why is it being missed?

> 
> Implement the .poll_hpd_irq topology callback so that the DRM MST core can
> proactively poll for unhandled sideband events whenever it suspects a
> missed IRQ.
> 
> Note: The new MST series will integrate this change into the introduce MST
> IRQ patch

This should not be a part of the commit message. And also the patch
should be a part of the MST series.

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index c8623849c001..8cc44dcc37cd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -60,6 +60,8 @@ struct msm_dp_mst {
>  	u32 max_streams;
>  	/* Protects MST bridge enable/disable handling. */
>  	struct mutex mst_lock;
> +	/* Serializes HPD IRQ handling between IRQ handler and poll_hpd_irq. */
> +	struct mutex hpd_irq_lock;
>  };
>  
>  static struct drm_private_state *msm_dp_mst_duplicate_bridge_state(struct drm_private_obj *obj)
> @@ -500,10 +502,12 @@ void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
>  	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
>  	bool handled;
>  
> +	mutex_lock(&mst->hpd_irq_lock);

guard(mutex)(&mst->hpd_irq_lock);

> +

-- 
With best wishes
Dmitry
