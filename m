Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09487103E17D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B1710E03F;
	Wed, 18 Mar 2026 13:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvcSP2y4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RpoauM38";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDE110E03F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:57:45 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ID5uB02612576
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x9u2qmoAdv7pYKpKSfsrbR/+wBGQsLJ01sARA7HpqUs=; b=XvcSP2y4TBDJzMIP
 ae2tANoqm0Bmzxsum/2HHyZ8z6mtOQMTc3RxUfwvUOr6cwA4ozFMaKuOr+FDQtL/
 UVZZxJ/uLPqAdPDM7UW7wgqx7viwuuTvgHZOiXjk3HudLyXFdDA7OmaRRuXIH17S
 AHFgibbG3X9CAJBtyw0c2xFRLkZTLVVDyLT1+hGWuUWB8bbAMfpwUwg4Ojba3Lhb
 EVbgG5bwlubU0xbqipeAwxVXi4xrDvo0SApv4kcgf153l6RhHYzEUpwDew0x3zwr
 emdmbFcUujVcbYeY2GyyyBU5/1jrALmfzstmzXFbtVDYcdJpEZLpyMmzt80DDnCl
 1gD4fg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyqcdskq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:57:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50917996cfaso4340611cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773842264; x=1774447064;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x9u2qmoAdv7pYKpKSfsrbR/+wBGQsLJ01sARA7HpqUs=;
 b=RpoauM381O8Hxj+G/Cq3BY0FvcycLjutT2d0EBf6xGlABhyTIYyJAaaEI+b+TklWUW
 /rKnbgEBp1aTfCpL6P+ztq4j+vFCHUziOSyI5c2wynEutOm1mfE6WEugVlVuTOs7ZZjh
 Qjp417vKzEsqONy4waJGac6aPU9xiRPSPPpxskYDlCsvbeto2y/bk9BGGbcgjVKq63NW
 2iZ/ipK9ZEG3py1a2BOWNTeWiHa3Xp1j5IX+UXT+0JGx07+hwV3nxE94fFPX/udNLz0I
 EetMQ06gbzGLbYIzNbO0IhpKGERqCiLcRyoItX4vsSME2R9wHhs5W9lFYFm0+DYEY5LL
 yjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773842264; x=1774447064;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x9u2qmoAdv7pYKpKSfsrbR/+wBGQsLJ01sARA7HpqUs=;
 b=B/N9g77PD0L543alYjtC23xWoy0XZh+WVs/oF8uN69oXx9thD3KuT2wO7MChP3HmgT
 nEzQhVoheiFLlwpTPkF9UcgGUTTlgQ+9BF3A6ls8RZ8cybmQigEeZRSuxxYMXnMozGmO
 HNObaEvbV3ayQ/vMUgOK9hX9/lJUIdQ0dGptQTXX1ikWNMQ0T2iA9xe+IvQUYqsW0QN3
 27EC1a+THA5WkNud5cLx2sDHQsrmU5yBvhq9Vx1F+YCt/6/5cgQ9nu4ur9VVenaerUtR
 9ArgP0NXDEbq+NZ+dFIOX4VqC5giRlSNk5QVYZ4L3mPSelnTZ7M18KW5z/6U+bUkVbRj
 0C5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/wLpraCORDrlca+iKDldd288fy6+i5YToEMssj3zYUV/VMxyFvOO88JvCIfY2VyPD0a3oDaPFbCs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyv1pywOg83AFytvc5JbMdjszKxLPoofFABcd0707Ouum//SVT9
 61YfbChMQTckXK5MMAzvFm2iCTJ7uJvqbrgZMJ/E69QcRsF2TN8qjFyiGg9XZmR9WIzgN+vwhrl
 2O/mjI3qwdWEgiiByqTx+iEd9w5czUjLmkq1vyFvIgtQ1BUFX8c9dFD8VI4QwmXCmxCY1WCo=
X-Gm-Gg: ATEYQzxEHQq12D+9tLYiG0FyxqTdfNtGoh3s4f7incCrx6IVqYQqaYptbLEqU60W9Ug
 QJtmC7WOK5lP8qFCtPnOIuOkSeZQ8ZdUGYobFTQBP/NebHiC0+lEXZf1pR47vJMeXWxGKRkf1PW
 HEyQykCbbG62V+iXiHY8+7Nx7jNH7m1GNX0Cx8fAr5BQwLw2CVvfQ4adf7w3tm/Za7Lzngf9PDs
 5TqKbdHXxMod/bdiiuzNW3qVuxyjOLxZUXgHjakZLGcIuiijAaRx3cnx4dg7wmI6MkanEMP3NUu
 2l3tVmcvhZp18HzitcgrMhuS1iNqbKW0E54b1ZGJ7BfKjoLV5c/G127FAfHgy0SXXUDnazcxrDq
 BCDbCRl4ZQnKxxd00aDYNcmrqhJUny+m67DRmnpLq7B68o67L5d4KKYdZL1Ejh2dC3X8nA6lHup
 bGdrgrapFA5NC3FDVzJQwOUROpFIPFaor8mCA=
X-Received: by 2002:a05:622a:1a81:b0:509:24e8:ec38 with SMTP id
 d75a77b69052e-50b14751d56mr42403511cf.10.1773842263865; 
 Wed, 18 Mar 2026 06:57:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1a81:b0:509:24e8:ec38 with SMTP id
 d75a77b69052e-50b14751d56mr42403041cf.10.1773842263314; 
 Wed, 18 Mar 2026 06:57:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd517e114sm6366201fa.18.2026.03.18.06.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 06:57:42 -0700 (PDT)
Date: Wed, 18 Mar 2026 15:57:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?Q?C=C3=A9dric?= Bellegarde <cedric.bellegarde@adishatz.org>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, antomani103@gmail.com,
 mitltlatltl@gmail.com, krzk@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: fix race between cmd transfer and host
 power off
Message-ID: <6wu7eezhtqyatbvoryprfpwkcmofdk4albr2zedfrbnrw37amf@rx4lslum3u6b>
References: <20260318105635.270949-1-cedric.bellegarde@adishatz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318105635.270949-1-cedric.bellegarde@adishatz.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExOCBTYWx0ZWRfX08hhxJPEVBdS
 7gnsG/kXbEsmvy+L0Fd4Mfl1l3gebdD05zN7bh/0gQjnpshNfQmqKYiAL5kPAH0RSWqyONVubCi
 7Dfiu9OzAA3FjsxKS8vmvFyvM+ctxlHcdwTfo/2D4WfalPpOXTXKXRBGpLcvxTsADe42Gtn26Rn
 AwYIE7hunyV7AzQgLHc9ea5LKhtVYfF1aOTINDM3VKPoVFLIZsyglBbqbsIm/epxGpELC902PmR
 od+qq/LeWw4Dp1sIok3bmH2k/vKVV8CT0P9W2ZR/o0d/+GU/gmuMeW6WtYCK4QZmbWrtFd2d+4J
 WbIev8PHz4MliMe6JwGA3uh/1pWaJHGzIeu3rCpKhbripLBPYRugE0bZ3j0h/Eh7IO8MXpiIMVS
 vv+9+wI+WzZYL9nhPFDSorVU//qof4waVoa4rkhhWlxMiyANChj/XtTeFir/mKIvXxbVMDWjI0n
 Lvt887wivfHIbLb4M3A==
X-Proofpoint-ORIG-GUID: YX_T4f3znFd1090M9Xtdp4CBDWeuNray
X-Authority-Analysis: v=2.4 cv=H87WAuYi c=1 sm=1 tr=0 ts=69baaf58 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=LCWlJkpBAAAA:8
 a=1BZaoZaY-UnUrn2_TpQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=z1lahxahPt366DkPXCx7:22
X-Proofpoint-GUID: YX_T4f3znFd1090M9Xtdp4CBDWeuNray
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180118
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

On Wed, Mar 18, 2026 at 11:56:35AM +0100, Cédric Bellegarde wrote:
> The transfer function dsi_host_transfer() guards against the DSI host
> being inactive by checking msm_host->power_on. However, power_on is
> cleared at the end of msm_dsi_host_power_off(), after clocks have
> already been disabled. This creates a window where a concurrent DCS
> command (e.g. a brightness update from the backlight driver) can pass
> the power_on check, call xfer_prepare()/xfer_restore(), and toggle
> link clocks that are already being torn down, leaving
> disp_cc_mdss_byte0_clk stuck in the 'on' state.
> 
> Checking enabled instead of power_on closes the race by rejecting
> transfers as soon as the bridge starts tearing down, before any clocks
> are touched.

Thanks, but it is not correct. The transfer callback is documented as
requiring to power up the host if it is not on at the time it is
called. Could you please implement corresponding logic?

> 
> 
> Signed-off-by: Cédric Bellegarde <cedric.bellegarde@adishatz.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 4d75529c0e85..f66f138cfba0 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1652,7 +1652,7 @@ static ssize_t dsi_host_transfer(struct mipi_dsi_host *host,
>  	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>  	int ret;
>  
> -	if (!msg || !msm_host->power_on)
> +	if (!msg || !msm_host->enabled)
>  		return -EINVAL;
>  
>  	mutex_lock(&msm_host->cmd_mutex);
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
