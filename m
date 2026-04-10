Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CA5F44870
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 13:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3813810E95F;
	Fri, 10 Apr 2026 13:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SGfzgDEf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZWK/qpn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E5810E95F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 13:52:11 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AApPRx3743239
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 13:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=D6n98aPN2xgHIqFP3YmENZo5
 DpksRhsWwsJxP9z2Dlk=; b=SGfzgDEf79p4IOvBYHZ3MlwLFiGZYl4aSfj9TXLt
 5BrXDR08ksy8IwQ1TTzgSoOr1usAXtRoh+n/iru1LvcvPw2DVNmtb5+wau8NJt2i
 urH67z27uUOl+VNZwpSZhDFSmaFRAZ8NG3uMTBWW7Z9OQyNSAij/JOPfgoi6Mw94
 YBH19kB1/UA/+eayBzx+RWoPwpa2GR49TEHf40A3T7ODrkCwzaq8kWyQNhE/Wo45
 TJxjmYIHCWQkDC/AwFzMw1kTFyH/bu5b8v63cRU4LBTwHBIqGxoqoMGUVViFla2s
 Iry5V/3GG98bgYeoh6Cx6g5GYrzoPlY5t34sZfT+pSJ1rQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deytngg5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 13:52:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6054a46d802so2768804137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775829130; x=1776433930;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D6n98aPN2xgHIqFP3YmENZo5DpksRhsWwsJxP9z2Dlk=;
 b=eZWK/qpnny8FthC0jPBE15PYxxJyFBOwEKKnS+giOkMb4y8OCpOSikou1HH8Nj9hAg
 2Pr0Zv6xel8Bei1EtWPfnENzTgKPbrN/frpR1kHZ0geV8+hKOPZ00YYSW9uYzWxUHRz1
 bj5szfXFZ27lSisfMOdp9bkH5vfhcidzDnk5ba7DJmRMCODQ9TYAM3fORJhaMDDhB6gK
 jiMrlc46zrnP3Lf8H/ia6ipZ1XCeL8Y9rso0QxJMwGbMVqkf/gBm8JCzYyEyKUbb5Fll
 O61Qj7FPIxNduQ8aBjgFCj5VQavFy7FOFzcKQ5oaInWypsry/xH1HoveELvqTDz7a6/F
 3t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829130; x=1776433930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6n98aPN2xgHIqFP3YmENZo5DpksRhsWwsJxP9z2Dlk=;
 b=mo1Ek2+2JlvAv+481XtY2zwEJKzCbWRUIus68PgejjZaHdx5Vs7+gfshO3dCX518k3
 ocknxTnAbtgZJHQDUBz+CtqCBqg3g8bOoS+RgGlfz1qpMbu5KiC9kTYK7IpNheEX/NkT
 RO1dBxL56qfcvB5w9iJ92Yk/DFpe4x8Vph//6PC4Nyz1V7xxvTB6l90TWQ53k+toPGu2
 eokg+pHNZXeMi3PyaR2I33TH6eZuuGo14t52sKTigTnmvml3U9+Z7pYEC86vlNJSW/p0
 bu0Y0fDyB0LuAneeRFnktRCMFNpGo62Vn1e71d7bNf3m65ap63h7qtaYjlnvH2nkG5oE
 MNYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWquKkS0IDF8ALORPp2HiuHRM60jQ7qXnYw2u0jZz29DLB6DHszJ5GZ0dRbmZbzHwKY140Jk+FQJeI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIg1/zQ5EY1XwLP+TGsWOIZPqAblMNMrsWUEjlFTIV7oveW1Eg
 541JmGWwp+5tzLdmd7pWfFtNxwwmA+esbuXBh3pD1beUtOCMGv0lpX24cvP0PjwscLFvD6IGiug
 3lHibrlQH1t9YUvgKRHSWxDJvn1269g2Yrz5G0hao4O1MnqteqqCtHfsvVaq/xLnfzW1cBCo=
X-Gm-Gg: AeBDieuOM3rnAxCF+XgswNNs7Tw9OhDW2PCh0sa7q0oYuBd3TAanukvcEyULjz95F6J
 a2XLK79wmbaBi2o/knStGl8Ij0TAl6365SC/NBSJ9zpIuXedj5saCkb0PjDVzRCAKesfqoHBgJD
 ELFyzkGbH1RHJu2IdEAvbrtP19eYa0rfihfGoGaAJB5rgDUM7GTMpa5cBMwBOPRNyPcywcbYoHM
 VoweKm/Pk2bEnQPpqUFtw3LigcQb7jQqveFkoMC8m113YUpRvTSFYmfo9jKPmLiyIbKrryDFuk/
 6R+svsHEUHI8OLA2FccZNy7jB6GSqvjAU2fAvQqsv5fyidqAlwCYFqBQkxLlIj8v2N1K22ozSj3
 fSGh0bQXU75eWAOES4AZHG1TuGm/tbja9tn74gk/9llP84+gYOCSN6dLIXUBnHjHS7hYQ+i3c/s
 if535T1Kz7lDLkhDH94fl2AzBbOyyXqs3qEVg=
X-Received: by 2002:a05:6102:6044:b0:605:27db:c899 with SMTP id
 ada2fe7eead31-60a01472c5dmr1167183137.29.1775829130166; 
 Fri, 10 Apr 2026 06:52:10 -0700 (PDT)
X-Received: by 2002:a05:6102:6044:b0:605:27db:c899 with SMTP id
 ada2fe7eead31-60a01472c5dmr1167166137.29.1775829129762; 
 Fri, 10 Apr 2026 06:52:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee86a45sm754519e87.11.2026.04.10.06.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:52:08 -0700 (PDT)
Date: Fri, 10 Apr 2026 16:52:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/39] drm/msm/dp: remove cached drm_edid from panel
Message-ID: <7cnjdge435t55s5vf66fkjfmkz7jvcbbax2uuismyc74mv4eia@toe2vu2folqa>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-1-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-1-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: PpyyUm2XaXaXJqN4uFd5Zsu4UnYxZvZY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEzMCBTYWx0ZWRfX9QHXG1Yk3LNH
 lZs30jevMKvXs3Me4G9i/J14j3Csu65tQewYGABsn+gpQUc9NAu8XN441ywWRFVmidKTW7e/nXm
 BR8ka7bFhJNJvZCPlHB71S/Zo7/2H39VUZZSDRFDnnO0AudvZ/qjS1jq3a16WirEHO/WeapQDie
 kzJs7hbyHgUyRkcDFGK25XZ+Vh11we1k4+GQG3nkTK55m+2tLd1jutjHpPsM14dF4teHBXTbbxh
 lPEIgYYBB186xXdCUrTxOwJpfsRwycZ0Bs6/EUUFTmBfhn+7aQeSggF2BaXoONmgacMgfVOGC61
 ph0u7omn1Lt+ND3ZkBEwjjVndEydeqiwnyZtheI/jzcCyraed8hczp2k/1WajtJ48ww/pFYIHmA
 g7EZzhxiUP7MU/7dRbGgfZrXSeJEuHGdmvW9YciiL8XZhEW7lfXY+kqMueS/gMtPMTzCWq/6TzN
 yLMmKI1XUsce4eP+K+Q==
X-Proofpoint-GUID: PpyyUm2XaXaXJqN4uFd5Zsu4UnYxZvZY
X-Authority-Analysis: v=2.4 cv=crGrVV4i c=1 sm=1 tr=0 ts=69d9008b cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=moIHXxoqlhIiEUXYKbMA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100130
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

On Fri, Apr 10, 2026 at 05:33:36PM +0800, Yongxing Mou wrote:
> The cached drm_edid seems unnecessary here. Use the drm_edid pointer
> directly in the plug stage instead of caching it. Remove the cached
> drm_edid and the corresponding oneliner to simplify the code.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 57 ++++---------------------------------
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 13 +++------
>  3 files changed, 26 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 5c6a24ec140d..e28cc1bbb5b1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -268,6 +268,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	const struct drm_display_info *info = &connector->display_info;
>  	int rc = 0;
>  	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> +	const struct drm_edid *drm_edid;
>  
>  	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
>  	if (rc)
> @@ -275,10 +276,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  
>  	dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
>  
> -	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
> +	rc = msm_dp_panel_read_link_caps(dp->panel, connector);
>  	if (rc)
>  		goto end;
>  
> +	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);

Where is it free?

> +	drm_edid_connector_update(connector, drm_edid);
> +
> +	if (!drm_edid) {
> +		DRM_ERROR("panel edid read failed\n");
> +		/* check edid read fail is due to unplug */
> +		if (!msm_dp_aux_is_link_connected(dp->aux))

Does this work for USB-C AltMode usecase?

> +			return -ETIMEDOUT;
> +	}
> +
>  	msm_dp_link_process_request(dp->link);
>  
>  	if (!dp->msm_dp_display.is_edp)

-- 
With best wishes
Dmitry
