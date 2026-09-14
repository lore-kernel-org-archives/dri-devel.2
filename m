Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836B3C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC9F10EAAF;
	Mon, 14 Sep 2026 00:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKJDLfnd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVLc3JrR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBAF10EAAD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:55:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E05xqu2421452
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Eqj8O5+j4nR4tTJICXutRdTQ
 r7vbmzRL35wvcRkWqos=; b=DKJDLfndDxEy2z35J22zfTEJ/MJVWwmdNtS49hZm
 Ijfk0rbkYGnHvfhb8yQcnRBTrZp9t7w+mtPx9rkoGWvMsLPthFeYR6BJWlPAy1iO
 gOGJAhX1xd7uk3wU//w2fkj8Ai/l2dZU9g+Ogn33nFXn+37wlishZF/DRC2NyrNj
 7TK5vxKchROt+LAJzb7XZJVEgkQ3qvZQzhSlDx3ckRUxXwNE2vnQ9rRJMX5a2edY
 84Q3XQTeJ0N+T+nnT05fnMr3v+C7mfTLigKZEN0YmtP5g+XnthpVEs+7RfKbMFV6
 fcCl5fOgir6TaFISu1iLEzGNLKXbPDTp7tWcT+z4xoa4ow==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gn018mbbf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:55:34 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-78fbc5a4cf8so3151639137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789347334; x=1789952134;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eqj8O5+j4nR4tTJICXutRdTQr7vbmzRL35wvcRkWqos=;
 b=eVLc3JrRrbLkwQmdcdWZOPzEnnfcM3y2c0JsBFlmgTj/gAIj+QWDcAQBloffwLOBPr
 l6hhm/6E7BOB/fpz14iZFKsafDiriIbbY2FjtGc6f/boawO1kEa8azBJBJyWIYJtCS7g
 HG8pT+ZG7H0v7pzUk7gYfwj8IH2uW2/hBnRsU6toWn0Zt42vH34585L6vZ7+BCaB0QFy
 q/kge3hHP310Ywnf1HR9Lw78i+IWOOgJil7LHfj8ft7WC8mzOAsfoADWVENYgweJ20tp
 Tk4OSr4qMrXci34xXNe00eB7l4OKhU7LUWzCyAOxmJ1ytOezr81vQkpPV2urOG1peZjt
 a8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789347334; x=1789952134;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eqj8O5+j4nR4tTJICXutRdTQr7vbmzRL35wvcRkWqos=;
 b=NzCHH5j2nvFrwsys7+QEBdqXIMAI2xhg5pNpnht23I+gCCZpYf6i89jwgyoYxYf50y
 O7V/SbJFXEv5jlVvNupuP60irgIlE7PybGH5FVYYIQDtJOCXnRvbjKfLn2EUUdkygnHd
 7hcKeY7Us9G1BPWfS3iTOUxdYtJaNkPLd6QRreTR4I0puKP3fcHKEH8BedxagPcziQi6
 I+DxyVO+4us+P8Exawq7q8DdYnCylAI9nwOs7sRL+jVSA8UhJEPRpTseDd4GisdbyYEY
 9ix1p+t6/nPTdT82b5vVXoAr4UtN+HgV9tsfJY1lYat4OClOmtT9SFrfEzeY0U9YhdDI
 yWMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZEg7uW+AJEhKBeA1+P15ngMeFdZQ84NlEwAtdn8KbU32py9qfCLNNC3aKDEaYxT+CtdlQcByfMrM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++laHlqT/q5UdqeDpDXEa2cOvLv1b1GCov+oaF8IjdowXQAXG6O9
 GHsexa7Zht99ucVGl/u/Dz/qD3g4iAufs7ayJT0IrRYf2JouXpVnQ5GJpinGCQC1NwpkgOFnm44
 4WkPNwP1cJ7DaPz7p3kxWBleXUEB2UWY1X0GOUsHaT7rQSUrcL+6rhBIebkRlxHPMtCLbjJY=
X-Gm-Gg: AYBFou3uaS96bWQBMQjrWQj7vjsKuZ2OyRtxpGNbzqtekoQqnJdUbiWXqZ4lxFf0zbd
 4XUfU9jARxAFDi1+D1TE2+3MZn8IF175FocDyS8LPWwao4V0Btuwp61RVgnGdoH8ibHjqrm5t0s
 ApcQLdikNSd3qsJuug4tkjHfeQ+lZwu5kOl5AU/ZKQ2LSjMSinS0A9AKvDywbMGm5nIiNG+0VjH
 zkB+aAFkmQm4ypTRkItEQvjZeltVcTnqT/op9V1XlbV8kypKFEx9IyuKZW33PfzD1NjoJSpyv+t
 O2M7li+NT5LxX5mk7wcT83u9hLUg1I3p+VWq5CT+2fZ2altQCVIAG4LjeU3pPjncRwRRmDim/gI
 fE/i+K1R/3803pR7T8kI4CKyV5lddGwdBV8O5uFGVGfTAT3dRdm9lm0BmyhTTd8OJVRBq/JeYFL
 uswUsLy9iMGd4E
X-Received: by 2002:a05:6102:5f0c:b0:791:d32:d2c5 with SMTP id
 ada2fe7eead31-7988f56307dmr1409704137.3.1789347334012; 
 Sun, 13 Sep 2026 17:55:34 -0700 (PDT)
X-Received: by 2002:a05:6102:5f0c:b0:791:d32:d2c5 with SMTP id
 ada2fe7eead31-7988f56307dmr1409680137.3.1789347333625; 
 Sun, 13 Sep 2026 17:55:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0456fecsm2054227e87.24.2026.09.13.17.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:55:32 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:55:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
Message-ID: <s365obqnzubh46l766wcw5hd7bbbictenj67hm5taarqssrngl@bjk3gebiamk5>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c4g+0h9l c=1 sm=1 tr=0 ts=6aa74607 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Zn5m-JxrSwsgyg9zXDUA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwOCBTYWx0ZWRfX80a5vzJ2EeyO
 qOPhRI0CaV6HukAdT7YGlmnkYGvvBoSbyD+upy2sfdmX5NS6NGGC7IR9Yu/6LIf52BOV4uUo5uu
 BpUy5kDV+P4BQUaOJt9ZzD9cRx4pjhY=
X-Proofpoint-GUID: LXsS71BjLs3S7f1l5SlV-j-dWLM2Pxm8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwOCBTYWx0ZWRfX24m46pR3vm5j
 TQM97awiqw931MRia+R+YwVDlBmVMBEOo1mEpG6EkOIrQcUtTwrkFBWor1kKSL+UAtgWyGhOJlf
 i0yrNRjpWiM1+1sCo8pp/CojDBfL7PJmjyGP4WpM449bb+wObbrvjOomwC3707PdRs062OfPmXK
 36JR5lzQA/7vAUSPLr6h1YY7qsMUooNP+5Vsc8AU1gtOeIHOsOPz9AeM0699a29KXgx5gamY3rO
 YGWGCPXfWHGc2qf3QdNxiohMnaiiTNlFgVG3ZhlIfmIVG8CioA/v/eHjfR6GdygtIxAxW6jmxR3
 BX5prC06JfFkx8rA/eM3caNa/ZPME5z5Q9nSpTlTUdWTJmpo1upB4Znqtv62RKQucDuwTKC5oQL
 4PDi5J9DclkLsmjwUL/cqIZCLBDi78+7u/L2l9PVZpWYZPyBeflWW/tMP475mmOYTGkfp+MDjk5
 zd/N3/GJ45MKLCfltBw==
X-Proofpoint-ORIG-GUID: LXsS71BjLs3S7f1l5SlV-j-dWLM2Pxm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140008
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

On Fri, Sep 11, 2026 at 12:29:35PM +0200, Krzysztof Kozlowski wrote:
> Properly handle power up failures during .atomic_pre_enable() by
> aborting the .atomic_pre_enable() to avoid accessing registers why
> blocks did not bring up.  Otherwise this could lead to imprecise aborts
> when accessing MMIO while entire power domain is off.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: ba3d7bf3a7ab ("drm/msm/hdmi: Convert PHY files according to new design")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> index 157f19bd90b4..db85400e574e 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> @@ -13,14 +13,16 @@
>  #include "msm_kms.h"
>  #include "hdmi.h"
>  
> -static void msm_hdmi_power_on(struct drm_bridge *bridge)
> +static int msm_hdmi_power_on(struct drm_bridge *bridge)
>  {
>  	struct drm_device *dev = bridge->dev;
>  	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
>  	struct hdmi *hdmi = hdmi_bridge->hdmi;
>  	int ret;
>  
> -	pm_runtime_resume_and_get(&hdmi->pdev->dev);
> +	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
> +	if (ret)
> +		return ret;
>  
>  	if (hdmi->extp_clk) {
>  		DBG("pixclock: %lu", hdmi->pixclock);
> @@ -29,9 +31,14 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
>  			DRM_DEV_ERROR(dev->dev, "failed to set extp clk rate: %d\n", ret);
>  
>  		ret = clk_prepare_enable(hdmi->extp_clk);
> -		if (ret)
> +		if (ret) {
>  			DRM_DEV_ERROR(dev->dev, "failed to enable extp clk: %d\n", ret);
> +			pm_runtime_put(&hdmi->pdev->dev);
> +			return ret;
> +		}
>  	}
> +
> +	return 0;
>  }
>  
>  static void power_off(struct drm_bridge *bridge)
> @@ -287,13 +294,18 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  
>  	msm_hdmi_set_timings(hdmi, &crtc_state->adjusted_mode);
>  
> -	mutex_lock(&hdmi->state_mutex);
> -	if (!hdmi->power_on) {
> -		msm_hdmi_phy_resource_enable(phy);
> -		msm_hdmi_power_on(bridge);
> -		hdmi->power_on = true;
> +	scoped_guard(mutex, &hdmi->state_mutex) {
> +		if (!hdmi->power_on) {

Thinking about it... Why would it be power_on here? I think the if() is
redundant.

> +			if (msm_hdmi_phy_resource_enable(phy))
> +				return;
> +
> +			if (msm_hdmi_power_on(bridge)) {
> +				msm_hdmi_phy_resource_disable(phy);
> +				return;
> +			}
> +			hdmi->power_on = true;
> +		}
>  	}
> -	mutex_unlock(&hdmi->state_mutex);
>  
>  	if (connector->display_info.is_hdmi)
>  		msm_hdmi_audio_update(hdmi);
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
