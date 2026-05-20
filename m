Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BCDCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261FD10E0E1;
	Wed, 20 May 2026 09:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3dSJE86";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BcTcHT8e";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A0910E0E1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:56:21 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7gdB0341575
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=x/vh6NtaY+3/iUioJhrCUPwI
 nd8makFBLu9msT4Nc8Y=; b=O3dSJE86rJYQbkrtjDsTmBIAzG3nrqJD/L7YGIW9
 bs6ZdKzLpld/ruIofzgcBhy1U2on5y8OIGXqUhFhuR6NNUKqasxr0Lt6t8fUHsVw
 46CqVx50W/D1avmRcbPc75xqfJdcG0AB36s8JZYJvr4kojnmKClXBPlXRslwllh9
 hakiGkPJdlpEoEdu/FCK98U1G2bzsIhoQ6M2O0PyBfzG37bSkMPak+w540GgxUMT
 14HSADriPY17tim88sGdvExIxeAV7HIFsVWEZqf/MIaWXh98093MCktPR8KxLmiP
 O+szvkDw6Yvq2CGoVKbHyaRndeAvv2kbZ6wyhPMUFppXNg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3vc4qt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:56:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514cbe73d00so148386211cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779270980; x=1779875780;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x/vh6NtaY+3/iUioJhrCUPwInd8makFBLu9msT4Nc8Y=;
 b=BcTcHT8eUxPYD536ZjXYwEXFerFVPWGwBpBwE6ZqbF1abunLlJaY5XgeyNwM+tH1eo
 o11/gsYmOzvgzzA7/A1lzvm8APXdmGN74UXs8lKTrJr3a3NYxD66QG5zIVp+g3XJkThZ
 R/DVOiMu9UUQFOTKRMKd6iDQstRti6Fbh7u4jytWOno/Ltvkd0tGWd5QUyt1L2LLoNHn
 DYnldArS/B1c2f3Z75YjqKjGhH07RBPqWm5Mh4+ANTVLPr84YV0StUU/N2YA08DjNCVD
 ALzdyp165yQPGeyJdVMjnrsIUG1K+odgy+BH81WhgYRoeABh4oD+r+Q02kWBbRO39riV
 EPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779270980; x=1779875780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/vh6NtaY+3/iUioJhrCUPwInd8makFBLu9msT4Nc8Y=;
 b=QOFdOMzhCSt8eoStFjHYpIP7h1HF8nW9oGzJelfmstwD27u37NDhTFZrgGWmCQgK8H
 FFTNkIzb+EGwidE7/pRNHMT0O+88lazkc/8Noqvc2+ZPf7g18pucD1FX4+VRKnF9S6My
 IjdHVRSfuDbW+JM6CL7WF1pEfjIOxNRlGq/Yeef5D7yvdS2y1loeYQFC6ySTr99711nJ
 00sTSTGojCQbD3pSfOXTrq+1SUrS5s2wA+TXleQ9/QQAMYscxgJwzKwcaUJDaOYh2+F0
 R3HwKJALn9a5gUFmcn0sxYCYOX4PTzN2peq6eCtiniW0O4bYuds5DrF/3g7Qry3HUuW5
 +Xng==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hxeKcjizvNIBzI7LBsXTLqV5lqZ46NXMUaTouDqfoNTE+sIcuiM+YTUaclk29EFWfQNcZQOZOe0c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtXK6Q4+BPe1a5n7gVN3KrJSALzItIOO4+51SJ3TY+aZ1RK0hi
 ucvY2oOSU2CAIehqB/6GNHdXM9V/xHXcCTDagtPQx19LIM6KHz7gtLH3diu6jRuIPcDvkd6dGrn
 /XZK9Ae/imA57ko1HfjVKNKeHn+CSZxdpRJHu1HTR5gmZJ+nYQV7qH9IS3Z7cX+Um6J12Co0=
X-Gm-Gg: Acq92OEaCqrhvMkfBuODOP7boE/hJE93lhrosJIszIp7k5Qnl3x65sJvipQoo5GpCBN
 WjLUaZmeIziM0IAbcMRfTjuu7HvlCYAuiTpDKcdJ71LHzia8qrx6hVlyhmMK6E2gY9tfADkFvw/
 ZGgsRRXlbm7DXRu77CdsKnE4ddxl7M1CMu7JE3mo1b1hmesX5Pjyk2LDXa9U+TXSwaqfmyLfhVD
 iRlgMugJZEDsr33PEQbRghMaNZF4+s7csSoGFqXD+HJMS7riJonoXCdqHb3SvIO2RaBt1jl2z5H
 l/ui0kjABVKRL6Z1F2V0K4YS+biiSdNDQuH+2cla3POiNtRpQIBrO+z0WbZlcdTo2G1YKgAE3o7
 eBGpaRTkrJ39tEuW+EeHe3menIxPUW+veOAT8DYTDL0r5T3psMCMHX3XiUj5EUbcLqILJhTtMIv
 6j7/7xfHcScY0QVHq0qNAJkXUCpEi5G5XjMrM=
X-Received: by 2002:ac8:57cd:0:b0:50e:614c:661f with SMTP id
 d75a77b69052e-5165a040625mr319617811cf.20.1779270979714; 
 Wed, 20 May 2026 02:56:19 -0700 (PDT)
X-Received: by 2002:ac8:57cd:0:b0:50e:614c:661f with SMTP id
 d75a77b69052e-5165a040625mr319617631cf.20.1779270979246; 
 Wed, 20 May 2026 02:56:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c84dsm4811436e87.10.2026.05.20.02.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:56:17 -0700 (PDT)
Date: Wed, 20 May 2026 12:56:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Jani Nikula <jani.nikula@intel.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
Message-ID: <62ruh7xc5bgv2iifshhnd746nfghzczblsgxrumchuak564zvt@nligwnzsw6pz>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519144712.1418302-2-javierm@redhat.com>
X-Proofpoint-GUID: TsHP37PgPgd8QWbiUB9GjbgxeRAtOWcs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5NCBTYWx0ZWRfXxYxboEJgoR6I
 kEND9ibJGe9dH42C5ADpWXifAk4FkfzPrE368haEJ7kosWkULmG064/5x96MInegXinAS/MUT+p
 eKyDvb1cfTtrFHyInbpZ+bncabZxIStJ92l3vEg9ilifm63pB88NZIuwjkvWWK7kspdq2bop9E5
 oc/5Kzf4FDYm1VP1xqkxZ8o3fcfX8iWtIrABd3ET1D7xJdJsFbAezaFKT18Jg09lPD+0LnhyyRy
 3AsKsJcC6LiL2tkE2wFYMiRlGAVpDxEPE/S8B+TZHv51fPo1FKBoGQqqf28alr9Y1rCgR/ORjJG
 4yC4q+Ao9p1BNgr2JeAnCQTKekTuyCPcZn8l0HsMNOsmujrAywlwEkYX2syRVaVpgrJBycY2CiD
 Y/SabNX9y7qXa50d3/UMU2LN7SvuHwcwk/Y88CooZptTR7v+W5FulUk8xJ1/v3eSWD8laFFIONJ
 Z+uFRVIvlonvULYBRPQ==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0d8544 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=-TeNy3OwqtCayIha8J0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: TsHP37PgPgd8QWbiUB9GjbgxeRAtOWcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200094
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

On Tue, May 19, 2026 at 04:46:57PM +0200, Javier Martinez Canillas wrote:
> Several DRM drivers already define their own constants for minimum and
> maximum TMDS character rates.
> 
> By defining common rate constants in a shared header, drivers can just use
> them instead of having driver local define macros or use magic numbers.
> 
> The values defined in the <drm/display/drm_hdmi_helper.h> header correspond
> to maximum TMDS character rates defined by each HDMI specification version:
> 
>   - DRM_HDMI_TMDS_CHAR_RATE_MIN:    25 MHz (minimum for all versions)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0: 165 MHz (HDMI 1.0 maximum)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3: 340 MHz (HDMI 1.3 maximum)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0: 600 MHz (HDMI 2.0 maximum)

These values are also used by the HDMI PHY drivers. Would it make sense
to define them in <linux/hdmi.h> instead?

> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  include/drm/display/drm_hdmi_helper.h | 6 ++++++
>  1 file changed, 6 insertions(+)

-- 
With best wishes
Dmitry
