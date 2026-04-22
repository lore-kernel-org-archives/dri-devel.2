Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D328FA1FEB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982AB10EF24;
	Wed, 22 Apr 2026 19:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5uk3YIw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SCsZDXua";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C542910EF1F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:44:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFUBIB664394
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QZ7ccC/Oi6MF6opuvHlXZAnP
 QwAxSMZhaQdKsbbz5YI=; b=S5uk3YIwpzKSCshHbU8Fa8WxsEo0Aie6CptlEGs5
 NSNLdBuKuuUVFX7FjLh3vk3Foh5rA/ZvJ5Bs8KHPxUOUSl6i293igpL7Q/eBu8Jd
 wJe0B+OZrzSnETX2NAa+ujS8NNxXNiwO4KJ4LrLiZQLYlvHxugzZYTaVDWgoUxGr
 PaXMc2sOdnN7gKwGBQeui97ZrKPD1GScRoc65PcsZlkXE10wQ3tZqWlM60lB+j1c
 STVi4hLzuff967KHvGio5rQYotzN5jD9wRZTuN1oF2ourvSjq486BbfE6i1pP1xJ
 mNgiB5psvMPfZaoAtHadf7X77t9x/gV4I7xx06X1gh+Dpw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgtb15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:44:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50fba8d8c40so50334101cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776887046; x=1777491846;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QZ7ccC/Oi6MF6opuvHlXZAnPQwAxSMZhaQdKsbbz5YI=;
 b=SCsZDXuaslSSGFKJxepmu7ddSNvNYdU4jTYlZP042W/9YhhCkcD9z+AYHb+MPwsJ6w
 C9zFDphSudY+BqL8UzNAPM1K2FWq3KMXW/PdwmjS8mHPIvrFok9Wf+Sk9JKOeAUNDs/l
 0H7PRHVzWAmARkKkNIqSPkro4cbM9AqcEQkXAPB/9LD24BBcUW4+zZb2QzexgYFQu0oi
 t1f4bwhRlfvxbuWwsytun7qmQ2MauJW4EU0jIkFXNS3VVX7pu4lsQFdPCbLIuKJ+ywGO
 sepKJgmLqqzZhG7eLhbHZRMoMJgy3Dx76jVBmNzVGbMMlcXQWcJSVpPIlfWUhVkh1dzO
 ArJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887046; x=1777491846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZ7ccC/Oi6MF6opuvHlXZAnPQwAxSMZhaQdKsbbz5YI=;
 b=FTeUtPL2o1ve3MQlcwU2KZqwOQgVa1alGNjVEI0xVjxyYKpzUuDXNzfWDilnrCTGAn
 KcqgyRx24zGFieSz+gqwe6C4Vl6qU5bIJ9LDfuAGQER8B6cDD0fxOn+8Uj/qtJadDG64
 5lNB2VkRLHPrpd0GtOWAM99JEv6UU2c4OHwgevYS7TkvUi5pM7VnLJ9D72PqYqAcOWTu
 QZiApH0Q0sJuy1On2qgWTjEmjejq0I4TDDAixyYtUwR4wJXPBPtowmmb+BERVRNdlFPi
 FkO5XnUYFH3vtdnvooXLsQ/QZ/PkFLVatxVy4gR1TmUMFLQ86bnYhHg+Bc1MM/NZCa9T
 MG4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+auMAQHnbnUm4p/lZ8kKdOb3c/YpLBrBYXttBdqRGwIJGjYm/Zc2XGVPX4w6PxxgYbFNe9h4aNqLY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5XV2jxz8YFtEO2Mhp/5ZNcPB+rSjqvsodXPKCxmQQepobfOq5
 tGuJM5gx+G2nL/WZI5Ed0NwrOVso4/qjDjtk14gFCmezWXG1by1sfMxUShwOMwZ66db0SDD8QCG
 g4Fcezud755TkZujWoXiO0wl9uEFwGFSFoXJF2M303gXqs37Qg7Uh1Q/1AYizBkJm4V3U+WM=
X-Gm-Gg: AeBDieuEcwxF2k1xbwo3tZkfe24mpI4tOmvWSk/intMiOGjakMIAmH4HzY6JxPHLhhN
 VxbSDKT1wradbGcl6xWjGKJ6a7+qUVQ+GTDgC0gtCpEvib6lCV0OcSKWSi9Zi0E1bAcVUApLife
 S/7DSNT1aQzFVusnW1srfodudHZt+w3tO9V5Inpq8uisXf2l78TT6sV+LrR9Iv3CI/7M5yPPBYr
 pSju2iPcbAfvKE6hzftklFKD48el5G1l/HCYW5c53BXSpUu6Qk9QL1c0oV/dZgRiqL2K7knDs7c
 R012JIwD4jcs47NcC3PqPuIEzNPb9N+E06lrQkMXmzxiUqlQVr3kW5xs4qLjHI0XYni5Cr059r3
 Z+wTbBHAhX4oBb5Y2RSF7VlvHxEuvvAjM0GmzV1ms++noiR1q4CmQnVaRdmCH6HeNiyUjxgS8zq
 7XGvg6yE2627fGpnr2SRdtzHYeL5/lPsNesKYu64WaYEtOQA==
X-Received: by 2002:a05:622a:a951:b0:50e:5a1d:8422 with SMTP id
 d75a77b69052e-50e5a1d85bbmr173885681cf.28.1776887045939; 
 Wed, 22 Apr 2026 12:44:05 -0700 (PDT)
X-Received: by 2002:a05:622a:a951:b0:50e:5a1d:8422 with SMTP id
 d75a77b69052e-50e5a1d85bbmr173885271cf.28.1776887045460; 
 Wed, 22 Apr 2026 12:44:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e7a57sm4585441e87.57.2026.04.22.12.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:44:04 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:44:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: andrzej.hajda@intel.com, vigneshr@ti.com, b-padhi@ti.com, devarsht@ti.com, 
 y-d@ti.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 yamonkar@cadence.com, sjakhade@cadence.com,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge/cdns-mhdp8546: Fix incorrect register clear
 in j721e disable
Message-ID: <3tmais7fsu4bfpaeto5xrseeuxyapva7n27apurmu3ijagir3t@mfvm2xeqmn4d>
References: <20260416040933.3052831-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416040933.3052831-1-u-kumar1@ti.com>
X-Proofpoint-ORIG-GUID: gE_TsJaZo2vgZbMfeBKhyI_MfvES7v_h
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e92507 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=lARSoy7frKUrfrJr5SoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: gE_TsJaZo2vgZbMfeBKhyI_MfvES7v_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5MCBTYWx0ZWRfX5O6Z+tDSnJuZ
 9JWNlZuOhWrTU1iHdCuvpsjVfGAxEfTimjK/10B/u1T4DJ1FFwNb+7z66CvMjRUsRD3naOSMS4T
 UpbrTMTFmeaQqJ13HIkdq5UMbMSn3JuGco0Kg2mcBOBlBL4iyuqRbv+fREcIAMAbgwSigmlbiur
 LTIkMlqqQfleCp61xvkT7dQy8ga9CFinz5wjpyhtbJAM39HgeXkSPCsSh7KdyNVq7C9Z4+PWsFp
 A4KkGhkt5huxWnu9qDaSLmXOU9fM0wPuh1fxMx53/mQmDtPjO6/doHPTfQGLSFmfSbjGXjoArLS
 y4DYMqD9VLw1Qz3ajrwsFBypBUCYUCoVgmKFxEHq1kXh/0Kz3pwKBLbXxA7AOOZi+EXrf9PIowq
 UQOplU9sGrDZ3MAE+cWP25EwvIKWsHcqmmSKj+sfQvDbL3bHWH95wUBn23819YB8vWP7ZPG3a8l
 m2Qvt/pzDRkOCGx7Gtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220190
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

On Thu, Apr 16, 2026 at 09:39:33AM +0530, Udit Kumar wrote:
> Fix the cdns_mhdp_j721e_disable() function to clear the correct register.
> The function should clear DPTX_SRC_CFG (video source configuration) instead
> of DPTX_DSC_CFG (DSC configuration) when disabling the display interface.
> 
> Clearing DPTX_SRC_CFG properly resets all video source settings (VIF enable
> bits and DPI selections) to their default state.
> 
> Cc: stable@vger.kernel.org
> Fixes: afba7e6c5fc19 ("drm: bridge: cdns-mhdp8546: Add TI J721E wrapper")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
