Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE590FED9E1
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E4410E5AA;
	Tue, 17 Mar 2026 15:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAXWnJ8C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MBhq68vP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFFB10E5A5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:04:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H98iEE3101965
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4mzLqKsdTkLuo3uP4PBm6rr/
 ZdhOz2I+FVqyk8deICY=; b=TAXWnJ8CmwypYHaROUZrTl4kItJl4uMOlbQ5zSQX
 g9gwm8oItEU0mjgDU/IXYuXa1JmoRWxK/VpaiT6gE+Cct3oUYBQBVVfQstUvMEAa
 nR8qcwbuj6WwErfmPg11D6TN59vZHuut4MnrSa900SaKCLf4AH0q/f4EMAw9/p6I
 PsYi2pRpaD6ZU3cOJdvMxT415hkmp36CMsEweLeZs+1j28/s7Q2DK+7fxknOYDib
 1IiIEp7fZ76F2N6t7Kl/cJ1gOJfXGspopwtoxw5J6Q3OiThgpY0GPihvq0EwQifX
 dT8ZFsWGoohkKuE7LUb7gDBD5V/cKGe00Plf8rPxnYgzmA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxnb7cau1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:04:29 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-67bb368c757so26044549eaf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773759868; x=1774364668;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4mzLqKsdTkLuo3uP4PBm6rr/ZdhOz2I+FVqyk8deICY=;
 b=MBhq68vP6fg44OCiKnUwKsrBldwKW9ejkOFdU2SrWw51aNigabeBTFyn+MEo6ivjhe
 Je6ki95loVwLeBpJrnpRIJrTemXtLO0h/5EOkTMb42XcljhMrluiguP5rUpxUlrGneok
 ZekpW65s8bbmwQH0Kt6dhQ3gpsPUoaW/X/ubDmB73QctCz7uvLMS19e60U0+/yobbPv5
 dNmpIyxw+OKgIZl046niacB9cNNr6JHAFPxCkPYpH4y4TRjMXA4QQnW3/mh9WiBHlI21
 jCJ7aeJ/UfKa7m2XefNLuG58sIWmwxzzddNy7atzyDkAJYhJYJzu8vovR4elR9QG1u8I
 1asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759868; x=1774364668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mzLqKsdTkLuo3uP4PBm6rr/ZdhOz2I+FVqyk8deICY=;
 b=pynoa+dFed8NHGvrkeHrgq48zQFyL6Royg5Bw39+4fJNwf48/Og50u5e3MZGPLjjl+
 fe/UMPKQOppeX/4AOgL37fdTrVtVAP91tWZEMxW39Y9ClRZ8rDh+7e9AldZ6rEFBnKQ0
 KX0+hE1PUFTqCUYmsi+jWFGae6afRF75t4tE4f7/AdYxbJ6S/14dSXWyBd5bEuN+gOvt
 mQZByV89g9vtaUrTQ6UY3P3YpROyBuE8cvXF7/LSMk48ve4VcjzHrpi8IddQ2Hnh52a1
 5rV+9UZgUGjQvYxDRTyTl7Kq/QvtmV7E3/Tassw+rARwRh/LRoMj9GYtUjaOQWPxehas
 a5Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxod25Q/2radHGU91Wst6eH+m6/Ag11tZ7dCqd+x0qm1+jMXTvj2gtu79kTVxQW77kdjM0ZMrW1rk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxM9vLRvX2m3MKNp0ESCinH0AbkRCo8U3gFiEqFInZvDnydocju
 260MOtVFduUlxs72qDhcs3IA14hfAIEgMXbkJTkl3OQNbK/CBxfmg5T3vVuPQWsU+m6wbAK99E6
 jh9MQNNqvKRy89DdlVPJglWHmGtA40KXNtsfZQQrSvcbJdogCEiENL2uoAYJD8VWOD/O0Yts=
X-Gm-Gg: ATEYQzzyY5VEG1wKz/pX1zaVthC1xUREAxC0kfCFZu0RL0G7SiLXRijuJM/dWV7esnS
 b7+hIpp6WLvMdCYuIQHFuXD1QNy9GnFhNO/6ML8C/EiCQogN8PVSZ+9/nKJU22ISdIoh6dFKKd+
 5ZjoLriVvNabq9FS3ZnoSxfkMM+VRrmWjNb4/3M0qD8IofubVegl4iFoI8Fhv0J1B0CV7nrJGJw
 2TNQ048wRZ9iS4N4OjDVZD4i0Z7W1Ve+xIGogSDd5j/AuWI8yKHZQII+tiEXOV3wpNGyqe2rm1f
 tPqdcj49k7Vl8w6iGTvBr/JVJymfFE+quyXZLbWWCzpTsbZlDdcpVyMGLgSYK92iyIZngXxc0ju
 aN9BkNgeqZ0oOeFohyU1ATFuZ1poDRB1PmQNX4bVBe9PSAVezzqp0w5my/obKs4DN/6FrwrLiN4
 VFXjvykeUoq15jhIfrZy0Eef0n/8ZwuYUFMLY=
X-Received: by 2002:a05:6820:616:b0:676:83f9:c8ef with SMTP id
 006d021491bc7-67bdaa809a8mr11456047eaf.65.1773759868163; 
 Tue, 17 Mar 2026 08:04:28 -0700 (PDT)
X-Received: by 2002:a05:6820:616:b0:676:83f9:c8ef with SMTP id
 006d021491bc7-67bdaa809a8mr11455997eaf.65.1773759867326; 
 Tue, 17 Mar 2026 08:04:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15602e239sm4141639e87.23.2026.03.17.08.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:04:25 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:04:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm: default separate_gpu_kms to auto selection
Message-ID: <higas4vy6hla7vi2b54k3erdklt3u34efjocbcd5s23ypijvho@rxgj5v42romv>
References: <20260317-separate_gpu_kms-v2-1-b027ca97b9fe@oss.qualcomm.com>
 <8b58adfb-ed3f-4c2a-ac4a-da5ef1bd8dba@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b58adfb-ed3f-4c2a-ac4a-da5ef1bd8dba@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzMyBTYWx0ZWRfX9ea0JIgtd2si
 txJ90BUt1a/OB/+45Yg1f86zALolgvItuIhmiLjjX+V2QLIFN6uxqvHuST36RxZOq7+3iFkx9SW
 k/FmBe4Mf2Oj5F4lPtPjcBUmhlH0Gw+Wf7yRcwLPsJPOQQZWREfb5OB/ckoawScHGexjd44iq/F
 x6HwiZQ6oApe04W7HMhUafYvF/Qi77fOVk+Jup8idtGsZQLMhTJhCOQqgcaF+aK8V0gzPLDJMKF
 LVmu8soUx5Hd62nYiBXzM/WZLbtibCw8KQBRCqNXBQkWoQnOZjexsXswKQ1lIn27/i46VAYYRBG
 kaDv1DXYDISR/H+bMA/Afv0FKblHc6WjVel7X897+9HnqcELsd/4OyuRdgKiI8rHBBQoQ71GVUG
 YSPrng9mhCS9TuEIsXylBwxiu0f1f6ICWmm1sQXaI+Eb+K6Grfq+F8kns99MYlIxfodrN5Cq+Ge
 as1FmMCBsSMbOmhl8Wg==
X-Authority-Analysis: v=2.4 cv=D7pK6/Rj c=1 sm=1 tr=0 ts=69b96d7d cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=y0ZA1Vlu6mLbDXCHyQcA:9 a=CjuIK1q_8ugA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: hNHkgFkCg0s3VBSX6QpXmLWgi2G8p-xa
X-Proofpoint-GUID: hNHkgFkCg0s3VBSX6QpXmLWgi2G8p-xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170133
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

On Tue, Mar 17, 2026 at 04:06:30PM +0530, Mahadevan P wrote:
> 
> 
> On 3/17/2026 3:57 PM, Mahadevan P wrote:
> > On platforms with multiple display subsystems, such as SA8775P, the GPU
> > binds to the first display subsystem that probes. This implicit binding
> > prevents subsequent display subsystems from probing successfully,
> > breaking multi-display support.
> > 
> > Use the tristate separate_gpu_kms module parameter with the default
> > value set to auto (-1). In auto mode, the driver selects the binding
> > behavior based on the number of GPUs and display subsystems. This allows
> > display subsystems to probe independently when required, while
> > preserving the existing single-card behavior on simpler systems.
> > 
> > The separate_gpu_kms module parameter has the following semantics:
> > 
> >    -1 (auto, default):
> >       Select the binding mode based on hardware topology. If exactly one
> >       GPU and one display subsystem are present, bind them together to
> >       form a single DRM device. Otherwise, expose the GPU and display
> >       subsystems as separate DRM devices.
> > 
> >     0:
> >       Always bind the GPU and display together to form a single DRM
> >       device.
> > 
> >     1:
> >       Always expose the GPU and display subsystems as separate DRM
> >       devices.
> > 
> > This ensures correct probing on multi-display platforms without
> > affecting single-display, single-GPU systems.
> > 
> > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> > - Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms-v1-1-e8231e7f1685@oss.qualcomm.com
> 
> From coverletter this got added from b4 will make sure will be posted
> properly with subsequent patches.

You know, you can just edit it in the b4's coverletter and drop your
manual changelog...

> 
> > ---
> > Depends on:
> >    https://lore.kernel.org/lkml/20260124-adreno-module-table-v1-1-9c2dbb2638b4@oss.qualcomm.com/
> > 
> >    When separate_gpu_kms is enabled, the GPU and display drivers are
> >    probed independently. In this configuration, the Adreno GPU driver
> >    may no longer be loaded implicitly via the display subsystem.
> > 
> >    The referenced patch adds a MODULE_DEVICE_TABLE() entry for the
> >    Adreno GPU device, ensuring proper module autoloading based on
> >    device tree matching. This is required to guarantee that the GPU
> >    driver is loaded correctly when GPU and display probing are
> >    decoupled.
> > 
> > Changes in v2:
> > 
> >      - Drop dependency on Lemans dual-DPU device tree changes as this patch
> >        works independently (Dmitry)
> >      - Switch separate_gpu_kms to tristate and default to auto mode (Rob)
> >      - Rename msm_gpu_no_components() to msm_separate_gpu_kms_components() for clarity
> >      - Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms-v1-1-e8231e7f1685@oss.qualcomm.com
> > ---
> >   drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
> >   drivers/gpu/drm/msm/msm_drv.c              | 52 ++++++++++++++++++++++++++----
> >   drivers/gpu/drm/msm/msm_drv.h              |  4 ++-
> >   drivers/gpu/drm/msm/msm_mdss.c             | 15 +++++++++
> >   4 files changed, 64 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > index 4edfe80c5be7..e40648c05797 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -272,7 +272,7 @@ static const struct component_ops a3xx_ops = {
> >   static int adreno_probe(struct platform_device *pdev)
> >   {
> >   	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
> > -	    msm_gpu_no_components())
> > +	    msm_separate_gpu_kms_components())
> >   		return msm_gpu_probe(pdev, &a3xx_ops);
> >   	return component_add(&pdev->dev, &a3xx_ops);
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index e5ab1e28851d..575d1aea7927 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -54,16 +54,54 @@ static bool modeset = true;
> >   MODULE_PARM_DESC(modeset, "Use kernel modesetting [KMS] (1=on (default), 0=disable)");
> >   module_param(modeset, bool, 0600);
> > -static bool separate_gpu_kms;
> > -MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
> > -module_param(separate_gpu_kms, bool, 0400);
> > +/*
> > + * separate_gpu_kms (tristate):
> > + *   -1 (default): decide automatically based on hardware topology. Split devices
> > + *                 if there is more than one GPU or more than one display master.
> > + *    0: force single DRM device (bind display + GPU)
> > + *    1: force separate DRM devices
> > + */
> > +static int separate_gpu_kms = -1;
> > +MODULE_PARM_DESC(separate_gpu_kms,
> > +		 "Use separate DRM device for the GPU (-1=auto (default), 0=single DRM device, 1=separate DRM devices)");
> > +module_param(separate_gpu_kms, int, 0400);
> >   DECLARE_FAULT_ATTR(fail_gem_alloc);
> >   DECLARE_FAULT_ATTR(fail_gem_iova);
> > -bool msm_gpu_no_components(void)
> > +static const struct of_device_id msm_gpu_match[];
> > +static int msm_count_gpus(void)
> > +{
> > +	struct device_node *np;
> > +	int count = 0;
> > +
> > +	for_each_matching_node(np, msm_gpu_match) {
> > +		if (of_device_is_available(np) && adreno_has_gpu(np))
> > +			count++;

If !adreno_has_gpu() we definitely should be using separate binding.

> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +static bool msm_separate_gpu_kms_auto(void)
> > +{
> > +	int gpus = msm_count_gpus();
> > +	int mdss = msm_mdss_count_masters();

This breaks MDP4 case.

> > +
> > +	if (gpus <= 0 || mdss <= 0)
> > +		return false;
> > +
> > +	/* If exactly one GPU and one display subsystem single card */
> > +	return (gpus > 1) || (mdss > 1);
> > +}
> > +
> > +bool msm_separate_gpu_kms_components(void)
> >   {
> > -	return separate_gpu_kms;
> > +	if (separate_gpu_kms == 1)
> > +		return true;
> > +	if (separate_gpu_kms == 0)
> > +		return false;
> > +	return msm_separate_gpu_kms_auto();
> >   }
> >   static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
> > @@ -1030,7 +1068,7 @@ static int add_gpu_components(struct device *dev,
> >   static int msm_drm_bind(struct device *dev)
> >   {
> >   	return msm_drm_init(dev,
> > -			    msm_gpu_no_components() ?
> > +			    msm_separate_gpu_kms_components() ?
> >   				    &msm_kms_driver :
> >   				    &msm_driver,
> >   			    NULL);
> > @@ -1069,7 +1107,7 @@ int msm_drv_probe(struct device *master_dev,
> >   			return ret;
> >   	}
> > -	if (!msm_gpu_no_components()) {
> > +	if (!msm_separate_gpu_kms_components()) {
> >   		ret = add_gpu_components(master_dev, &match);
> >   		if (ret)
> >   			return ret;
> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> > index 6d847d593f1a..64a5ad35f7a2 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.h
> > +++ b/drivers/gpu/drm/msm/msm_drv.h
> > @@ -555,6 +555,8 @@ void msm_kms_shutdown(struct platform_device *pdev);
> >   bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
> > -bool msm_gpu_no_components(void);
> > +bool msm_separate_gpu_kms_components(void);
> > +
> > +int msm_mdss_count_masters(void);
> >   #endif /* __MSM_DRV_H__ */
> > diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> > index 9047e8d9ee89..00e3ac7dab3a 100644
> > --- a/drivers/gpu/drm/msm/msm_mdss.c
> > +++ b/drivers/gpu/drm/msm/msm_mdss.c
> > @@ -73,6 +73,21 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
> >   	return 0;
> >   }
> > +static const struct of_device_id mdss_dt_match[];
> > +
> > +int msm_mdss_count_masters(void)

No masters please.

> > +{
> > +	struct device_node *np;
> > +	int count = 0;
> > +
> > +	for_each_matching_node(np, mdss_dt_match) {
> > +		if (of_device_is_available(np))
> > +			count++;
> > +	}
> > +
> > +	return count;
> > +}
> > +
> >   static void msm_mdss_irq(struct irq_desc *desc)
> >   {
> >   	struct msm_mdss *msm_mdss = irq_desc_get_handler_data(desc);
> > 
> > ---
> > base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
> > change-id: 20260316-separate_gpu_kms-04d2cf4d91e2
> > 
> > Best regards,

-- 
With best wishes
Dmitry
