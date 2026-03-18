Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798D9FCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB65D10E0AE;
	Wed, 18 Mar 2026 07:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NjXOlTdO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bsyGFTvz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD7810E0AE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:07:48 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I6ZSvb2878682
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i2rdDHXYPxCKAA2XTWkadTP5kTXD3VwNrVsXvmFPi+4=; b=NjXOlTdOE/VXXpHN
 x/QnzXNEbHRVDcuFhg3ogWVkczZIki43BMhs/iR614X99t7njU7n94OSuTtCVhJu
 FiWd/ejgAg7QIlGZx0t2ZDdVr+y5nRnv9PL6FA5GhTosWTQFu5/2gTat797zp5vQ
 6fpx7IBDQ7aSVyMv3Ql5CdlW7qyMwvYCRMStVbr3vbEAwgzcyAy7hFvaIW6pkn08
 86td0hWcXRZGKNDsuyZi5ggnZExZiti+T18mes0kHoMv02M7lv3uT3Arz9WJXZIw
 nCaIIRGl6SUpTx3XBP+MWo9Wo3w7DT6KaDZsFBkYggyDS1JJk15T5Xck8QahUAlg
 gSp4rw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cypwr039j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:07:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5091327215dso176375171cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773817667; x=1774422467;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i2rdDHXYPxCKAA2XTWkadTP5kTXD3VwNrVsXvmFPi+4=;
 b=bsyGFTvzcOje46mSJ41U3Ozao403RTVB7tJoMwwtwCRja9dQAIFuW/orCpLzD3jy7i
 Jar3PsFcDMWhgHbY8zwRlhq7TIaHS0UaN+v1xJWD2SHQIUlrS/iTr5PQ2pMIQTruU30y
 aVzhIfX5V7yFbVZtAexs1Cxzc4hfZEreU9okzB5bG7PZTS8OWzU0FXz2Y0u7INj4C57e
 yNpJPM1VXdRiM+9WWxOGILCjlUUsYbyCZngi/261vHopyE6wnBgsquCLBcI+jqDocsLV
 qcnobs8a5atHjEiEACASA7pOt58edzIG1OW93id1ttUOkvpDKE1fK88K2n2fFr7cI1v7
 MNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773817667; x=1774422467;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i2rdDHXYPxCKAA2XTWkadTP5kTXD3VwNrVsXvmFPi+4=;
 b=Dywoc4dJdQgCbHZ6hEdpu9zGPaYmp0iyO8FAjS1yuDWRsi9ulYoVTav+MF3rXR3SbS
 wYdqh6eBHsw5EvLcpMlpy0yfocsCJPgeegW13HA7xs3sM0OO2nBsSv8N5ciiMHEs7AbH
 g8IJI1IyYppSQUeVm684vW5m5k8kiI3ZyrvqS1glwNaVFJO+4tBjUkNgAnDO8Ra8z6V7
 w4ZLNbb2xVed7VjuJ1oSg6Yis13RDA7Hr8WzHXWLAElyxXcZoj4OVSYHmAbtNivRWBgT
 s38fs9su4V6RezAMoTQEtBSGnPUxv9VVZ8fipUoyTLL9W4UjiO6ki1urz6us3G+mRczd
 QHEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoA3NEhySAkajW8W1Ya0lwL7GKvPW4K0WYS0PA3GpufMjXgfjDTB2dbyRkTEo0LtgdM8prInImNxY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkZmwHfsaQFb8TJlO4f+IYZOEzII8KJ9qfSB4gj/jau9E8eNto
 WVcQ+KnSyYkFT3C7/SdS1EA+JNOOG2u1U4eM1QcF730irKZ8Y8rbd378BnSuzdHTV873ePwNcdy
 h16LKpniuRqiHxzbZb9CaKi53QLunm8FL4VxBxcJKV6PFkOl1zw7YZHW3rSXvPbE3uiWitHI=
X-Gm-Gg: ATEYQzyFYXbOZvWtNfyAWtARRLUkvImYVU7PSVJj7D3G7DEJXH4iXWIjno/jNrB8E3t
 Ew7NKrV4VA3MScMtkWXwdjmEbRpO5sTNrVU3UmtL+J8ht6tQqsi86bzZQ8OtYZq/oNQhgAPN3dO
 lz1VdL7pi7F1Ed35hE1tGoGCKEgbF1zdc/szQOTFloTG6oYFs/PEwH1EyyKGulTmigLELEgfnR4
 ddL+t/Q4WWOWuyQYhnibq1+FQJV3/WSMH6C7yCxiEy1+YWqffwm69wr/uwu3h1c+mJBO5mj8pZV
 MuXi9CETvbuF0367a/bE8AjAghcm699chWzcEVvuoZ9ogHhSLRc4bDn221c59N2vrg9FPn9U+NS
 4SQ0vr/kW2XIh7TxZpuUw/Ff8kxAMHrWqbhGZr+cCTohaNsGn5/Ip1oveFm8B/P8faMe2isiEzf
 Jd+xBFOVsm/mksQR5ak9zUO0hI2bhz7EqWtCM=
X-Received: by 2002:ac8:58ca:0:b0:509:35a7:2e57 with SMTP id
 d75a77b69052e-50b1485db17mr28670211cf.38.1773817666721; 
 Wed, 18 Mar 2026 00:07:46 -0700 (PDT)
X-Received: by 2002:ac8:58ca:0:b0:509:35a7:2e57 with SMTP id
 d75a77b69052e-50b1485db17mr28669771cf.38.1773817666170; 
 Wed, 18 Mar 2026 00:07:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd54bdb39sm3914501fa.33.2026.03.18.00.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 00:07:45 -0700 (PDT)
Date: Wed, 18 Mar 2026 09:07:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kamil =?utf-8?B?R2/FgmRh?= <kamil.golda@protonmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] drm: panel: Add Samsung S6E8FC0 DSI controller
 for M1906F9 panel
Message-ID: <toypfgi5hvyficlcjqcqal3soprwhwni2ypqg7khjniekwxv6s@yelffkw2tjzu>
References: <20260317-panel-patches-v5-0-ef99f7b280da@gmail.com>
 <20260317-panel-patches-v5-2-ef99f7b280da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-panel-patches-v5-2-ef99f7b280da@gmail.com>
X-Authority-Analysis: v=2.4 cv=bIcb4f+Z c=1 sm=1 tr=0 ts=69ba4f43 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=sfOm8-O8AAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8s1cotv8QL1OgUCTKcIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: 4ctXKLQS9tUhhNtqjkCP-l5ZlSOhxUdH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA1OSBTYWx0ZWRfX1TcSuAuZY9uL
 V0jL0vRoaENweS3ULGhqKVVEXO5mnUKeuLzCvrYOxwriAm1NVTCkMovXuLyNhEvsbi6kGcNrEzi
 a46aQkHovy1mK/nkPBtQdWcIpWAdSvxHD1zSAN74C+qW5xGpP0M1YHAAu1S3+wPPRJ3qBoOXeYh
 N24XEVzOnRJjPkuPCr014xqRAsbXnnOORZ8IYEH/lbzLmssLhQXClZ+iOx9E8Pxa6xdo8PnfobI
 vC+fHabR9qFejqoiB7JCKAxvQ+oI7hNNYwUcxSJyV+6Q1b5+EZUmAJ/EEnrljGncOUyy/nY1GJ5
 lpOGEL4+vyNQz0N4eiE5zEjf7NMvc/x02H2Pb6EUMnVYGmELuCtrXG0ttl3Ic/Q1XMvR8QOOTV/
 UXT/YsTPdQA/XHS9TfWAgw/0vK1JauO2Q4jW5L8sPTAbai2Xmuih3aL6sxbyE+ngkGzRIotx4lG
 PkFDpxzWOb1Y8RxLu3g==
X-Proofpoint-GUID: 4ctXKLQS9tUhhNtqjkCP-l5ZlSOhxUdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180059
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

On Tue, Mar 17, 2026 at 08:50:30PM +0200, Yedaya Katsman wrote:
> Add driver for Samsung S6E8FC0 DSI controller for M1906F9 video mode panel,
> found in Xiaomi Mi A3 mobile phone.
> 
> Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> ---
> 
> The downstream dts claims a max brightness of 2047, but seems to ignore the
> MSB.
> ---
>  MAINTAINERS                                        |   5 +
>  drivers/gpu/drm/panel/Kconfig                      |  13 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  | 301 +++++++++++++++++++++
>  4 files changed, 320 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
