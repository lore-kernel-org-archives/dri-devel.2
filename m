Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741EB1093163
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCCB10E88D;
	Fri, 20 Mar 2026 01:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGineV8l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kk88bU73";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0228E10E88A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:48:39 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JEXNMh3648192
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nlFMLVa07a9IMlgit7CImUyQ
 MUM2PByEWw1Tn2KTY2k=; b=MGineV8ll98GfDhLCT4i4ekLHGxb7nKOrxRahsQl
 E4hFwA8hJwBeszoPMzKgk0VfPO50mOabCj626l3hIjJGNXT8uqLomvX6CrfKROdU
 PPNMsoAmT5OkklZLxiapWVPTV8jj1ZDjbv0JtF7JGUH12WaNQh6dq7omnEaEAlJ4
 /ZkBB1TTxjkhvCEL5/wNY0LRRiF2Y1vMRcOGxO7eaZjOMWuU87KqptixfD/CgNDK
 Ly77qFNPXOwSsaDoBJrKvc+z+s3msc1pkGf/0WwureBnsERxNkEZFe66nuf76WLO
 HhAWKYMi/n8BMQOEmP1w41Z+yglyPpfkYF7TYlGwvgpuag==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0v9w4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:48:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50925fed647so114061731cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773971318; x=1774576118;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nlFMLVa07a9IMlgit7CImUyQMUM2PByEWw1Tn2KTY2k=;
 b=kk88bU73sqoC/T1AnDSW0lrNmkikMKbMo1IpBElTzwur7mQPDuVqCNDXEKWM3Um3eQ
 wnZONeFT1B26ZddcL83v/kz9dNm2zKIruI+WZ3/r3PtnhUD8w/0zlRuEeEcLWp6l4mGe
 j9gmoxXpClHpfMpnZNow3IOowoRoqe01DQoVM48mdjsZmHZJPLY+M0t61tiYp2bd/sli
 dNDFBj2XPXygKQJhA3ySuRBThiPalchZuMjyx8G7PjNwVO+ARYb1Zka6FgZNpjU5rxg9
 TxZyTCRr6rKpKeYZxq8WMSK/TzyplFYMZPCvxSuxeNQY8Lm8WtIwVW1EJRBT8w9emREN
 +a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773971318; x=1774576118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlFMLVa07a9IMlgit7CImUyQMUM2PByEWw1Tn2KTY2k=;
 b=kG89E8daT/IWVJz0AZVLC1ScbI4NoRFNB7ORnYSCnUpHVMH+Oy/Wn5CCofbCQYjJLB
 /XwnDqjXo0C54Am74PLjv5uNHvVBWD60udzQ7s8Fz+he5mK3eEP48SDf9J0IvpU3usqs
 XioUf1dAGqgtwZ9+yvwB4eiGF2yjNr4xaM9uyLfbF1HkWHPXf7LDWPHZG31mIR8qM2j5
 5xwkeNkZVLfTYedtp3Ji9Ziv8MoiXRdXdUi45ZI0CWVH4lkNFI1upZXPCsEXb1b9ScpX
 FRG4Y5LTGGEchLdbVs1+2a+zog3snYxqBQiLghOBkgSdtAZtRkcwHtnumWMwj1Exsadm
 XB2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo3xH5InXlOBHCjmiRJYfZHLgrAvkRsuiW0hP3v8u6XxkOH/R04eVax9Sx3i+4CUaP7lxZlNjMf9I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzflqwL55oMpxBZVWm8kcO/hPnKaY3zB+GPXMQSyMN7kr/3XgNA
 Onw4H4XBonqS4nZfu2sWsBa85vd0q4VVWRCp/stahp56eOseEUC327ae5XqWXTcDaIpkx/OYnXX
 dJPKR3+YhLsQiAFtuAVCSsqHWvhLeURrDmfmAKygNMF70FMMhPfDl/VOdlu5Wl0WOT+nHUpI=
X-Gm-Gg: ATEYQzzbfbeEMBxaC4f6j71UNFM14it5z/j2e8+iOrYIXpR8rjrULjX+/KNu4ozCUyD
 gPol9bmxHgbvHpDeS3heY1Lmu8BaWhs5EiF4txTSD6WQAl5sMrkzXtx1DN2socQ5QSzYTLDi2ts
 QNDKMaR0rRz3WdQrjRmz6feqzeQiiQHq+ak4cONXkJIgiKnsvVb8NoJwCv5HvEjBiwpitKGAf/e
 Zyos8xyVBEUHXvWyjYeW6X4FXJN/VbeNBpXHj/OHHeggwoIlijXkDSjMMzwbnM6qcOBwaYAojMo
 ZJRzJtBvavqrcry+UZIdEKScXug6Ag0gSeWWNDNcN0dWcEn+qHKf2RRdQGTZA4llR39vZ9idyt3
 Sqv3JyV7FnFejFPyyTXvU3NpBPSfDEcliv32luBq4LbEG825EsHaLvKbwYhvzpTnirC1rMlxywq
 ZWPSoClKWywUQy2hXdSHxSTETDmhZiImWlEzQ=
X-Received: by 2002:ac8:7d84:0:b0:509:39b1:d4b3 with SMTP id
 d75a77b69052e-50b37505441mr21583991cf.47.1773971318511; 
 Thu, 19 Mar 2026 18:48:38 -0700 (PDT)
X-Received: by 2002:ac8:7d84:0:b0:509:39b1:d4b3 with SMTP id
 d75a77b69052e-50b37505441mr21583721cf.47.1773971318073; 
 Thu, 19 Mar 2026 18:48:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2851ae39dsm238925e87.36.2026.03.19.18.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:48:35 -0700 (PDT)
Date: Fri, 20 Mar 2026 03:48:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/msm/dsi: fix bits_per_pclk
Message-ID: <dggubmwmcgepioyev4jfibntdgmmiiomahnrvodewcw6ktplo3@bngbsgvzuzoa>
References: <20260307111250.105772-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307111250.105772-1-mitltlatltl@gmail.com>
X-Proofpoint-ORIG-GUID: OxE2hLsu9Gfv06JfZfDaGIWKYwca9C2B
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bca777 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=4BbrJ76QWEWctDjhbfkA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: OxE2hLsu9Gfv06JfZfDaGIWKYwca9C2B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAxMiBTYWx0ZWRfX4Ew1pesmzRxm
 NScjkF4Gp3I+7GO+G7S5hHQFGYbAnXH+gCK379WrBty89J9DhHXSnZfgmd/Nr2ADY5+n4iCE4CQ
 m7cLzO2aYcj0bArBK1/vAExTKaZ+lByFHndhzkCrmXkrmvD/tXUMU2rfuLv2C4x2l8jFCmazSjj
 0djFagzPL9uYzgbQp9v71emO8wLzMZTgEeM5dP8cueLRdW2nX9zgMDVF5c04z8fzLawCxYnZ49P
 rIDOm7AzpiPEu12MlejQkqJd4ajONXt65S5+yvDOoCZ66tfpHymc5t1YVhr7yut8oWHQooqKm42
 V1sYyMA3xahvyj3ydxJUj9X3ASxcmoeIGVo+kpyRH8YGzNfWQ7/DpJSYNxq8TgJE/faQi7unZF9
 72dKZH0rqiPWUkxEmdWqH7B5vXJAdoD3EbQH2ZdhRDWB7W1Gmbz7bNTBMkjZdkB4HaegyDwiIfI
 nzR2TPutheksG6C+qbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200012
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

On Sat, Mar 07, 2026 at 07:12:48PM +0800, Pengyu Luo wrote:
> mipi_dsi_pixel_format_to_bpp return dst bpp not src bpp, dst bpp may
> not be the uncompressed data size. use src bpc * 3 to get src bpp,
> this aligns with pclk rate calculation.
> 
> Fixes: ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when programming dsi registers")
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pengyu, what is your target platform?

> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index e8e83ee61e..7c16216e8b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1030,7 +1030,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		 */
>  		h_total -= hdisplay;
>  		if (wide_bus_enabled)
> -			bits_per_pclk = mipi_dsi_pixel_format_to_bpp(msm_host->format);
> +			bits_per_pclk = dsc->bits_per_component * 3;
>  		else
>  			bits_per_pclk = 24;
>  
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
