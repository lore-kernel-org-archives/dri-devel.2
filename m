Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AFDCD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFE010FC25;
	Fri, 29 May 2026 09:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="giP9WsIP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RT4u6InV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB55710FC25
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:52:14 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T5KAxK1248012
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vpxQW+sWTfWoL+G9MrNleCVJ
 z9OWYvlCOBMGrG02KdE=; b=giP9WsIP9JUWTdICHDhFUi8Lzw848aV2zn7oppDR
 hCuqlr8wDi8Hu9dz6sveJBrw4iT0AVxDPtBKqZ1sKCTJNkD/YfALIvGOiTn+wEEx
 0LgVWi580DxxQ71Oe74SEIxAf48yXljElr1XOMquiRsQoNPnPtfTJDtG+LwOwG8z
 eWFa3zX0AxHfjAMcqkN9CzqzzCsMAb739VHHCLJtxluyBPzcrqt/u/RC9m6L+O78
 ApranRHvtJy0Zo6e5uQCrFJevC9cz4I6zo+T2fZM5COVaIpC7Cx3X/tZdbRr1kqa
 dJe59j5V7Luv+5c3G+A1I9xsrTJ2+NUnBtvLFVqfR0VKhg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj13ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:52:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d191f2ccso167472301cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780048333; x=1780653133;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vpxQW+sWTfWoL+G9MrNleCVJz9OWYvlCOBMGrG02KdE=;
 b=RT4u6InVPTommNX/n2skQcXCHyROf5NkAeT+7vu+UP5UI0uq2BFWbp+7gjYx24nV+A
 m2DAwCR9kpSuPJ88cjDdPSe6TQWrZqxlIMMnSgrJOz1as922+1ZNeGFAdDA0tTHb1m06
 f7tIX9OvJ96Yo0hERjnNez5HGK3xQFeibLyhPi3is7a/8aXE9V4j27QM39Uc9HYAeWji
 dmsal2/mpB61coQYOb0AdLN9KRbzsu3F5eihEAysGcWM4mSJvZHNPwEIGpx/yI4UCltD
 nozMfhRC6TYno+qWKkbvnIEPF7zZLAmkkamPbZ6e2cC7mofjlEd6qqOi55QNIQTXt0Wh
 dXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048333; x=1780653133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpxQW+sWTfWoL+G9MrNleCVJz9OWYvlCOBMGrG02KdE=;
 b=DxPoMMYdUesw9B0aVkmCnL3ykKty8NsXeCEHyndddTMJoyFBZsSe3QHBs2eIKS8Nh6
 TgSPJWBSbatPvavQwscC8mMXQddGv2jG2Npaa3qAat4z4Um9Ko/CxUEZ7fpTSCbxb0Gh
 V3EiQmH4hjDu3gD/UvQAcUAD1d3dq6kQUYxB3g9wbNqCGMsYm8LTtSG0B2LlAXRnaLBn
 oviSoRNYkxXKmwRRwNklG71fP4HFqb4Yld/jVLGQTdVQ0qU9HNiwnj8kMcyVaVZ46xyC
 HD8wSgv0Aw6Eu4iFq/Xi2NmPlLqKQmJ5v9kdzUpkVYBj+Yc/DjP7lDfMFnfqYzKLPTZB
 m60g==
X-Gm-Message-State: AOJu0YydO3fJpDbyj6ET/QaxDFx8R+TJPDZEbDcF4wwG7D7DlwLh4Vbu
 D0EL3PVIIbG7480UYGgSIJRtjLDNar6EOs/bhDfuN9ktNr796hxRog+rNrVzCuqrmB7b+Wzl/wl
 jabLsu6bDRmsSwuHdcbyNn2xrexuNUV/I+ID7JMrThAzs3SN37wt20qkUsETHz4qOODcVWNU=
X-Gm-Gg: Acq92OH+7Qq96IsrOcWA3Y3E52kAWUoC7/WJSyEgpWYwbBMLy6B+B+/hRFZDqeSUOnY
 9uKM29hm0W2hMyDmPZEP0uxeiYEQa/vME+US4FguOqHB8ssYm4koFmaXViU3yXfsZK8MA+KAeBl
 fFlq/iy0WPnWDFjO0ziKiczhPABkGMyxWxwroZvV+l7bgepKeWVFiqhwgEapnDLUEX55KJYdhNy
 X+A71QJ3Og2OtQDd4VjfyHFfvgMgR91YEaswObJoFRr/ziYmj6E6F1txnoVDRc75fow3wCxpDjB
 b1iZilGqTJ3meZ2XaM7cgaNnMbJSvTEFpCGtKGlueI+AVcdDkx71TddxetC71gZbLCgszMZKZCq
 N+1bXAeKKueIsCcd9xCM2kjVnrFyRDoZ+oHLrz4d+TsF484QPfa108BfiJRzAFXU56Z3+xem3j5
 SKxw3uo4pQUBR/AEeHFQ3Y7TyvIlNVd7eKafs909YUxvegbQ==
X-Received: by 2002:ac8:5d4b:0:b0:516:eaf9:f6f1 with SMTP id
 d75a77b69052e-5172dc58a20mr26691021cf.13.1780048333056; 
 Fri, 29 May 2026 02:52:13 -0700 (PDT)
X-Received: by 2002:ac8:5d4b:0:b0:516:eaf9:f6f1 with SMTP id
 d75a77b69052e-5172dc58a20mr26690741cf.13.1780048332613; 
 Fri, 29 May 2026 02:52:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b0688fdsm175764e87.1.2026.05.29.02.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 02:52:11 -0700 (PDT)
Date: Fri, 29 May 2026 12:52:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v4 9/9] drm/bridge: auto-link panel backlight in bridge
 connector
Message-ID: <kgbudan7bsiux55d3rtowc3274oqmzpzj7nfhfakvdcpyi4s2h@dlxi6yydpkwt>
References: <20260528054911.1513208-1-superm1@kernel.org>
 <20260528054911.1513208-10-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528054911.1513208-10-superm1@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA5NiBTYWx0ZWRfX3a+NPHWJDvnX
 xQgnoZJ4cTGuYcR1kFZFFjktEz4jnmdbwGPdaP7/WRZAxmMynKnBQ/AUeCBWjFdjzJ7yrj77wZf
 fmUAJlOh2ZsIVrV6Kk7Y8Qc2xhAKV4WYsMO7i7Mjs+iUQfXVLColC3AkoFRk00xQB95qtsNIy4c
 o2ittKly/50MBpB0La022C1jBCg0So7U5l8oWx2pif7JTAQ2C5/NtEZ6QbYu+uhKFuf6FCqWRFh
 1upt94S6ns57qumvRyGoBlP5sdA/Sor64i0M5KEp5E+Y4QNb5NkfZ4SOJKW6LkNp4k/z6QGGnf+
 QSsUbsz3nPE3lnewp+Su1EjbZs6kLkB5F9DVVMlz8padA1uECYQmASiPMPnVig7EKILYz9wSGOp
 bmba7N1eboOglVe6VhNE7avI3H9DWQZ1ZARv6w6xp9KzL3R3y4d4lvRWxdL+4XOq9yVl7xe0p26
 BxFXXVcpqToF/nSlmOg==
X-Proofpoint-ORIG-GUID: st2ZwtApC_BjmsAqahdkc_A0KDvFiort
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1961cd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3jPVR2SRzUYaBshDNgsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: st2ZwtApC_BjmsAqahdkc_A0KDvFiort
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290096
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

On Thu, May 28, 2026 at 12:49:11AM -0500, Mario Limonciello (AMD) wrote:
> The link should allow clients to change luminance property.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/bridge/panel.c                 | 15 +++++++++++++++
>  drivers/gpu/drm/display/drm_bridge_connector.c | 15 ++++++++++++++-
>  include/drm/drm_bridge.h                       |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)


Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # SM8150-HDK

-- 
With best wishes
Dmitry
