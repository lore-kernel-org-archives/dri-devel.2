Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E149ACA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABA910E0D4;
	Tue, 13 Oct 2026 12:25:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB8910E0D4
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:24:53 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8xwOR790997
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PAZLkQNYwSb4nLxIcNZMx93y
 6XjvRKbla5HBgOI8foI=; b=AXh5GDVRp8iSdIH8E0cDJC5O0+llcQcPjQfnNXOi
 t0JICSEbOcyfOP+q8o6SCH+2oORjQqZ95XVF1KZcr5P7cTl/VK35Ap9iTGs8YqO3
 sWFEC2pHSYLzMltn4M1toAlq3xRSvAIl+x0dd5FPOHyQ6gZMBRTJiELR6QgylcDn
 O3h9SN76VpDjVU/72kqjy36TKap5G0lOroLTnEXtzMfGrBrBsGDQzVxaV6ltCiHh
 R1bDz3PEQx+NPje9aOf2N5cAfo7Oanh6pn8yKJFvEhqBU5bQiol/wmxUbipn1FXo
 Y06p0ymDctkgmBERAJIgEVBeTttIT2amh241snSI3kshhQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjrtnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:24:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so584195685a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791894292; x=1792499092;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PAZLkQNYwSb4nLxIcNZMx93y6XjvRKbla5HBgOI8foI=;
 b=KYfTnUxap/pfQ4q+ZXnx3x0/EMa1lIfgtqwoo9XL42XBOpjj4y58NjfI6ShFhIvYcW
 11kZSLS1wYhKoDdGVc+BzxnV7XuBHUOCsQFRKV9TFhCos5GwLGauwinyYu94ctACvMjo
 ID1HqdyiXIwjQda3l+SFad/2Ud5CnOBRAmzBdTC3nVvn351YYNPw99WaQTSRC5Vzd7Qh
 8I3zavrUiP/vR+24/mqCZUmBeDz2mWJIW9T47BnBHvgQmcafcyiziLyK900hMF+X/Saj
 TXxkqYEtCmh17v8gqNxMzPP8jPUqW6VoofFwk5Uuc8HZdX7LFnPWr5VAr2qxtugQ97o9
 +ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791894292; x=1792499092;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PAZLkQNYwSb4nLxIcNZMx93y6XjvRKbla5HBgOI8foI=;
 b=XTFfBzyIHpxk+S4BbCmG/YQ09uljbALz7FMkRVLB4uHJTIn/TGGH/JekojHDeABU6m
 y1Ak3USF9LOg9RpyJVNgpTZjf7pZPGs8YaVhy6Ygv6uk/cHlt8RJHZbvNX3vlRZbK49f
 Oc0+wQcv70ssBWA5/hvehWVUWegsrMR40JC4WW7vSIuVBiH+jqnn7T2BwZFmOLE4oOOU
 YH4MaJIjSoiX6pu/ZFmBhuPLR1Nc0zQTOUAl+TKm8u3WrggqzWNKr4Sw/buEnJ5rQjw1
 oqHwZ7Q8dGInA9JYI+mssgdOCO8Ud6XkGxOGBXT6BiZgz2NEqQo/tZYcKSpsmIVDrT16
 jUSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbrmv25Q03hEG+INdkudPgvwaE7uMX5YM/FMTCHgR1GFuTW32SCmGmGV5XLP1jK8J6Nl8BNkFH2R0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJNz6g+89d9wD/OfgckjdhzGrrlnEa/c24MaFT5O95f6O8Ifxj8
 VII3NCDjIXBmsFslwWR4CTP7VJcYzmZRBN7g1g5s+Ayn9aGiOYAkwkgHSSDTKgNiOPDUSqZDDtf
 bs35trINslAHKbVVNCVk//fy5Rf01ket6od4aAuiUFjsnvUYERSKyDGb3E/9xQ+EWaWTPjvQ=
X-Gm-Gg: AYBFou3ygG9VrBLkKOPy05T6AypvDGLGOUpt6ButDcXo9LyGh1ovd1yt+qvUMoOTXuT
 Qw4xruwh4bpegutrbyoNDNVXVfU5eJjNGn+HRnTnIFLobk1ott+UYqW1VAuhjKq1H90HhkS1U1k
 GQh9DIpmIXSU051q097IM3lT1pyrBxZAt9Vqg5xtO2xXwD2bFg8D1qdvT1T1J+k4JteIdLJuoXM
 BhHgqHy0O+OHcYvYPxWQmEJ7Gzs3km/EbrVrerSili0rHXD+OAdNX0E3Cnm5q9DKHQ7oapj7XZS
 SCGCY3HBVbjY6mXDZ432AghgO0DzzQLihjK5ERfa3f0YwjIV25+mmiMc8J61G3TNohXZniFMFha
 lGSPJ93jzxL2jXLaRyuj3HCG4wKQkirYmGWld7wQp+DScAmydUX4lij2Jx8EiYeYqUjvYIV5uk+
 6FGaRDYnFHg8Pm
X-Received: by 2002:a05:620a:46a0:b0:93e:9292:1b9e with SMTP id
 af79cd13be357-93ebd0cc5ecmr2058378585a.1.1791894291908; 
 Tue, 13 Oct 2026 05:24:51 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:93e:9292:1b9e with SMTP id
 af79cd13be357-93ebd0cc5ecmr2058374085a.1.1791894291411; 
 Tue, 13 Oct 2026 05:24:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcf28292ccsm1659124e87.12.2026.10.13.05.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:24:50 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:24:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/bridge: stop mentioning deprecated
 devm_drm_of_get_bridge() in docs
Message-ID: <yvuokyvf7oibaihrijfiishlxhln2cateqd2x6derkrnss62j6@zfkekkahovzy>
References: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
 <20261012-drm-bridge-every-panel-cleanups-v1-1-0fd272f486b6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-drm-bridge-every-panel-cleanups-v1-1-0fd272f486b6@bootlin.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX8DE6FPBEvuEq
 4d8hXEZRThK788GVjqb9pExLqSrvyh9+EvAdGguosU7oGHiKnd5CcMiyQd0bJqEKgXHwv4myJCl
 GjzmsXSOkYunvhud2z67oWP1BXnJ+Ec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX+Ul/yKYR5KTk
 xF7fdM/BZkWatiJPaLJJ1DZCdKanyfBuJaroIPkRmDQbXCniwSMPeO+YrCxYH3sns1Pghtbo58W
 x0PxVcPRLHZCg3dwWQk/2tCCd3lBqg+i5it0S9mfmPfy8PXvvcSKPGaF05pY1X7H8YOMsrHdF/Q
 DQ8Vv64WIGv7NaIMC+j2otAYpAr0kWLqRsZ3XBHv2jW+VF9qkLpIiHM9fO1x60bATaV7lwl8vaL
 daAB7sT/VBLGiitbJMhQMLwnPeByiAKTHBhgr8pFxDIocJ65MqElUR56AJWxfrwbmf2YJmk17M1
 mCqAHtGRmwpDyAokkc+ZXt5o7Cu8BuTLuOMA3MHqC30OYjqnqCLoZHUIwpbrWpxP23Eg2bw2kqg
 ZJjjmEeMp2+ujY2LyL53MQMoI5rbbtvo2CUihaAuwS1goVCKc6EryhRbwnzlOYpyKXd3HzWCMFj
 inR/81fTaiR8EsCiozQ==
X-Proofpoint-ORIG-GUID: bi7LIaBkZNYgwkamnf8d8ACZ31Oej_18
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace2314 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=5gYlZd5X36b-6VqQ97oA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: bi7LIaBkZNYgwkamnf8d8ACZ31Oej_18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130049
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

On Mon, Oct 12, 2026 at 04:29:51PM +0200, Luca Ceresoli wrote:
> devm_drm_of_get_bridge() is deprecated. Update the "display driver
> integration" docs by mentioning the currently recommended API.
> 
> Link: https://lore.kernel.org/all/c1b065c8bd926708500b7c42864279e055ed95d0.camel@iscas.ac.cn/
> Suggested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
