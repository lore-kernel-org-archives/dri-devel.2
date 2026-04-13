Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C13EBFD16
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E6A10E37F;
	Mon, 13 Apr 2026 08:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VOpUKElQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kIZ+b2qa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FED10E37E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:44:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D6mCbC1058886
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zoK7egPfz3mwKJuQ43LZbL7M2c1YHPxwem4ZHrcdnzU=; b=VOpUKElQWFxOgY9z
 2Vbioz6hG1flpPKTsL9pY8wcSHguUSnbidWCTPplaPkUuGb6s41DIlsaJBnjm2LB
 mXDwdt1aVrdms2PgmlBxkgQdXHi7vxnzP7XEyIzStaRnwdvQMMMedXqugUo56F+Y
 +YIxTNkWHBe9MuRzApCmQ98rjQhYQ4Xh0nYMOchVCbr4/vBZdy+GCeV0jiHtolrX
 fz0e/cSXAXbJEy4KfTthQPVnejBeQyun17iSm3E0mePNYU5Iz/HgY/I4ky52HkWH
 2/HJLeCyVmSlR8e9LwgBOHmvLshWFxAWbHpxZ5P8TC495EL4h6Na62TFjle7IgX0
 xx1MOw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtmhbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:44:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2e06219cbso19093995ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776069853; x=1776674653;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zoK7egPfz3mwKJuQ43LZbL7M2c1YHPxwem4ZHrcdnzU=;
 b=kIZ+b2qaukAMwRULYk8OJ+r1dn4lIUd/YDXQrufZZHBK1/az/95D/YN7ECqG1Iyrld
 7cS1MQi3bAwB9tR4cOKLmyTz7peCkzoij80Yf8JWCb20tjgS49xP+rdhF3kxqU5ry/ud
 +DTrEYUr1sNhlbk0ur1cRA0kmWAJ43JFtznEq7wmFn8WiDBSeOXL7qNOTEuenId6aJWe
 e+4gZMZVK1lOMOcHMRdDp5asxeUqooC6Y4t/EcovYNksOtBRuUQNLNFmRcdIR9kk0pWB
 PSrfWVbJNoLWA/20+iX1V2ZG5W9/ocmAKBIohFIw7KINCnNvFKhomq7d71iEhXeN2jLv
 cmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776069853; x=1776674653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zoK7egPfz3mwKJuQ43LZbL7M2c1YHPxwem4ZHrcdnzU=;
 b=Yr7LRZPx82BAbWfGCDNmXKDCW+1rlFozAo2SMVKFK20uaxNkyD+4ywFKh9YTghWb6f
 CxOGMcrnUaGMLPUEwJxP7T83c/jn5vG9q8O35kAAfPYKOEXyibkw+ycVmquFlotTISz1
 nfapJulRm4SC6wJpKYuEVCP9hnSYJ0YGJPHqpKD8GQ2d6jWY6/2JcQfH+iSGNZzvA8Cp
 qMBHyBTQOuiB03fxqD6X0NOFMWK3FJtxpmv0jTK07hYuIu/F176zT2pWoQDt+yYkoOhc
 OnnNcRkW5lpRn6uQ+oTSj9uylTY4J2oLLEGewIBmLQlXszYLMVqugfJ32kyFCUxXs75Z
 pzUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ErDbv7IN2kqiE5fB5dD2+gVXnGzXkrdC7iM5pOMnTBBXcLsXnYrBaWNyGsxCWIUI/J6BxxY7l6GU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxycVLtdvbTAPcjZ/ETOBAD70vv6VXUgEXoMs0QFEUV8DGzUtNB
 DaK8KyRlhXim0m5j204V7yKAwRnVun6a/w+Y/3NyNyXO3rxa/ry0WfoLZpM9W9l7ioO1QhL6alj
 ap+8PF+L50UfBWz0G6ZJNrPN2JWBLDQNUWPhoVIEOfXgBFVrhwcTVkiPSbjRIrX4MWFTB5eQ=
X-Gm-Gg: AeBDiesXK6wANwpEk3214Q+dYQ93EFsb/AOBDCWu+vejJgQi60a+x0EuULPk/xzy4ea
 vXq9JjpSJ3Eqkm0GwNZZTQIe0Kmpj7GwQVZaXoAf1OMtVDugMu3dHhAKAUQqRQCQO4itI5dF8zu
 Zr12mMQHLU3GuZxVqqiseaT7Os+A73BCahiBtRlfZjgDV8ISP7leWczdAvwB2mxL9AvH7nTfmDD
 9ECDxfwlgZu8MbmSXlsOwwR40XURSLIx54sMSlN1YqhwnUTNfQXqv55/2TqjplROvZdT+6aPpag
 YJlB4Sz55biGGqi77X1Vsv5gVi979Rw9LK6CRb4R/nyOvqUhhZdGWWdC07IThI3iecjwkS3PeT1
 YbK2cAlB98YNVIDPztZb01cQ63ipAyPXMI5vPrkhp7xV44yT9
X-Received: by 2002:a17:902:c94d:b0:2b2:5da8:14be with SMTP id
 d9443c01a7336-2b2d5a76e9amr126982935ad.41.1776069852872; 
 Mon, 13 Apr 2026 01:44:12 -0700 (PDT)
X-Received: by 2002:a17:902:c94d:b0:2b2:5da8:14be with SMTP id
 d9443c01a7336-2b2d5a76e9amr126982605ad.41.1776069852288; 
 Mon, 13 Apr 2026 01:44:12 -0700 (PDT)
Received: from [10.204.79.61] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b45d066afesm30849245ad.8.2026.04.13.01.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:44:11 -0700 (PDT)
Message-ID: <7cb406ca-e631-4cd4-9782-d3efe30844e4@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:14:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/msm: default separate_gpu_kms to auto selection
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260330-separate_gpu_kms-v3-1-a3e54b9c9417@oss.qualcomm.com>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <20260330-separate_gpu_kms-v3-1-a3e54b9c9417@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dcacde cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J7XNo4u_9JsdxoHv6woA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 0bZJm_rwz8IsGf2b_WfuaHN9BBWXu0Ek
X-Proofpoint-ORIG-GUID: 0bZJm_rwz8IsGf2b_WfuaHN9BBWXu0Ek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4NCBTYWx0ZWRfXxdVMn7FlzqGA
 N4tVd4imdmdh0zRce89drM8EcHTVGQ7renv9k0dJMMnfxE4EV37jDTALER2tlP7Qige8q+4Qlte
 IUDDQCsXQhq+c8pa1DeqFJmMiMcdrYq7E6jXptbq4S+v1nTS0AAOAoVrf7GvO3bV6369eDusF7s
 Zh7Uwl1nHiw8E6EDSW5X/SDkzA6ukDk5gIzt7AN5m/g9noxro68bVTrKm9vLUTQu1Bzd04HkBkr
 xFZJkmKN31GxmFxkr6xpx73qc5g2HrKoIGl6y/IxukPrIY4TBglCy2VjpF41fSQsNTsYu2FsCGo
 E9Bg3HWWj+5GQYUptg448AOOcTdw0ltjm3l6NyR5eBrEzEwVobnTMcnWOTbjAJojpOE+/xn2K1c
 N9sQV7JXbZPKkGdEb3AIf8p0DG3FjYk9Js0Bupss56JBNzMCLo/bXwKXq/4K6ryA3SaydeuU3PL
 XepSX8z9wrfjejEvd6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130084
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

Hi all,

Just a gentle ping on this patch below.
Any feedback would be very helpful.

On 3/30/2026 3:22 PM, Mahadevan P wrote:
> On platforms with multiple display subsystems, such as SA8775P, the GPU
> binds to the first display subsystem that probes. This implicit binding
> prevents subsequent display subsystems from probing successfully,
> breaking multi-display support.
> 
> Use the tristate separate_gpu_kms module parameter with the default
> value set to auto (-1). In auto mode, the driver selects the binding
> behavior based on the number of GPUs and display subsystems. This allows
> display subsystems to probe independently when required, while
> preserving the existing single-card behavior on simpler systems.
> 
> The separate_gpu_kms module parameter has the following semantics:
> 
>    -1 (auto, default):
>       Select the binding mode based on hardware topology. If exactly one
>       GPU and one display subsystem are present, bind them together to
>       form a single DRM device. Otherwise, expose the GPU and display
>       subsystems as separate DRM devices.
> 
>     0:
>       Always bind the GPU and display together to form a single DRM
>       device.
> 
>     1:
>       Always expose the GPU and display subsystems as separate DRM
>       devices.
> 
> Additionally, ensure that display subsystems are always exposed as
> separate DRM devices when no recognized Adreno GPU is present,
> regardless of the separate_gpu_kms setting.
> 
> This ensures correct probing on multi-display platforms without
> affecting single-display, single-GPU systems.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
> Depends on:
>    https://lore.kernel.org/lkml/20260124-adreno-module-table-v1-1-9c2dbb2638b4@oss.qualcomm.com/
> 
>    When separate_gpu_kms is enabled, the GPU and display drivers are
>    probed independently. In this configuration, the Adreno GPU driver
>    may no longer be loaded implicitly via the display subsystem.
> 
>    The referenced patch adds a MODULE_DEVICE_TABLE() entry for the
>    Adreno GPU device, ensuring proper module autoloading based on
>    device tree matching. This is required to guarantee that the GPU
>    driver is loaded correctly when GPU and display probing are
>    decoupled.
> 
> Changes in v3:
> - Ensure display subsystems are always exposed as separate DRM devices when
>    no recognized Adreno GPU is present (!adreno_has_gpu()), regardless of
>    separate_gpu_kms setting. (Dmitry)
> - Extend auto-selection logic to account for legacy display controllers (MDP4 and MDP5). (Dmitry)
> - Rename msm_mdss_count_masters() to msm_mdss_count() to better reflect functionality. (Dmitry)
> - Common helper to determine presence of a valid Adreno GPU node, avoiding repeated
>    adreno_has_gpu() and availability checks.
> - Update commit message to reflect the above behavior.
> - Link to v2: https://lore.kernel.org/r/20260317-separate_gpu_kms-v2-1-b027ca97b9fe@oss.qualcomm.com
> 
> Changes in v2:
> - Drop dependency on Lemans dual-DPU device tree changes as this patch
>    works independently (Dmitry)
> - Switch separate_gpu_kms to tristate and default to auto mode (Rob)
> - Rename msm_gpu_no_components() to msm_separate_gpu_kms_components() for clarity
> - Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms-v1-1-e8231e7f1685@oss.qualcomm.com
> ---
>   drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c   | 14 +++++++
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 14 +++++++
>   drivers/gpu/drm/msm/msm_drv.c              | 64 ++++++++++++++++++++++++++----
>   drivers/gpu/drm/msm/msm_drv.h              |  8 +++-
>   drivers/gpu/drm/msm/msm_mdss.c             | 15 +++++++
>   6 files changed, 107 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 4edfe80c5be7..e40648c05797 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -272,7 +272,7 @@ static const struct component_ops a3xx_ops = {
>   static int adreno_probe(struct platform_device *pdev)
>   {
>   	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
> -	    msm_gpu_no_components())
> +	    msm_separate_gpu_kms_components())
>   		return msm_gpu_probe(pdev, &a3xx_ops);
>   
>   	return component_add(&pdev->dev, &a3xx_ops);
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> index 809ca191e9de..409000b739b6 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> @@ -15,6 +15,20 @@
>   #include "msm_mmu.h"
>   #include "mdp4_kms.h"
>   
> +static const struct of_device_id mdp4_dt_match[];
> +int msm_count_mdp4(void)
> +{
> +	struct device_node *np;
> +	int count = 0;
> +
> +	for_each_matching_node(np, mdp4_dt_match) {
> +		if (of_device_is_available(np))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
>   static int mdp4_hw_init(struct msm_kms *kms)
>   {
>   	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 1e3dc9bf9494..086895c9f103 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -19,6 +19,20 @@
>   #include "msm_mmu.h"
>   #include "mdp5_kms.h"
>   
> +static const struct of_device_id mdp5_dt_match[];
> +int msm_count_mdp5(void)
> +{
> +	struct device_node *np;
> +	int count = 0;
> +
> +	for_each_matching_node(np, mdp5_dt_match) {
> +		if (of_device_is_available(np))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
>   static int mdp5_hw_init(struct msm_kms *kms)
>   {
>   	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index e5ab1e28851d..e2101c6632ac 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -54,16 +54,64 @@ static bool modeset = true;
>   MODULE_PARM_DESC(modeset, "Use kernel modesetting [KMS] (1=on (default), 0=disable)");
>   module_param(modeset, bool, 0600);
>   
> -static bool separate_gpu_kms;
> -MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
> -module_param(separate_gpu_kms, bool, 0400);
> +/*
> + * separate_gpu_kms (tristate):
> + *   -1 (default): decide automatically based on hardware topology. Split devices
> + *                 if there is more than one GPU or more than one display master.
> + *    0: force single DRM device (bind display + GPU)
> + *    1: force separate DRM devices
> + */
> +static int separate_gpu_kms = -1;
> +MODULE_PARM_DESC(separate_gpu_kms,
> +		 "Use separate DRM device for the GPU (-1=auto (default), 0=single DRM device, 1=separate DRM devices)");
> +module_param(separate_gpu_kms, int, 0400);
>   
>   DECLARE_FAULT_ATTR(fail_gem_alloc);
>   DECLARE_FAULT_ATTR(fail_gem_iova);
>   
> -bool msm_gpu_no_components(void)
> +static const struct of_device_id msm_gpu_match[];
> +static inline bool msm_gpu_node_present(struct device_node *np)
> +{
> +	return np && of_device_is_available(np) && adreno_has_gpu(np);
> +}
> +
> +static int msm_count_gpus(void)
> +{
> +	struct device_node *np;
> +	int count = 0;
> +
> +	for_each_matching_node(np, msm_gpu_match) {
> +		if (msm_gpu_node_present(np))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
> +static bool msm_separate_gpu_kms_auto(void)
> +{
> +	int gpus = msm_count_gpus();
> +	int display_subsystems = msm_count_mdss() + msm_count_mdp4() + msm_count_mdp5();
> +
> +	if (gpus <= 0 || display_subsystems <= 0)
> +		return false;
> +
> +	/* If exactly one GPU and one display subsystem single card */
> +	return (gpus > 1) || (display_subsystems > 1);
> +}
> +
> +bool msm_separate_gpu_kms_components(void)
>   {
> -	return separate_gpu_kms;
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, msm_gpu_match);
> +	if (!msm_gpu_node_present(np))
> +		return true;
> +	if (separate_gpu_kms == 1)
> +		return true;
> +	if (separate_gpu_kms == 0)
> +		return false;
> +	return msm_separate_gpu_kms_auto();
>   }
>   
>   static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
> @@ -1019,7 +1067,7 @@ static int add_gpu_components(struct device *dev,
>   	if (!np)
>   		return 0;
>   
> -	if (of_device_is_available(np) && adreno_has_gpu(np))
> +	if (msm_gpu_node_present(np))
>   		drm_of_component_match_add(dev, matchptr, component_compare_of, np);
>   
>   	of_node_put(np);
> @@ -1030,7 +1078,7 @@ static int add_gpu_components(struct device *dev,
>   static int msm_drm_bind(struct device *dev)
>   {
>   	return msm_drm_init(dev,
> -			    msm_gpu_no_components() ?
> +			    msm_separate_gpu_kms_components() ?
>   				    &msm_kms_driver :
>   				    &msm_driver,
>   			    NULL);
> @@ -1069,7 +1117,7 @@ int msm_drv_probe(struct device *master_dev,
>   			return ret;
>   	}
>   
> -	if (!msm_gpu_no_components()) {
> +	if (!msm_separate_gpu_kms_components()) {
>   		ret = add_gpu_components(master_dev, &match);
>   		if (ret)
>   			return ret;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 6d847d593f1a..a977fe7b36b8 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -555,6 +555,12 @@ void msm_kms_shutdown(struct platform_device *pdev);
>   
>   bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
>   
> -bool msm_gpu_no_components(void);
> +bool msm_separate_gpu_kms_components(void);
> +
> +int msm_count_mdss(void);
> +
> +int msm_count_mdp4(void);
> +
> +int msm_count_mdp5(void);
>   
>   #endif /* __MSM_DRV_H__ */
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 9047e8d9ee89..4c788f2647b0 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -73,6 +73,21 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
>   	return 0;
>   }
>   
> +static const struct of_device_id mdss_dt_match[];
> +
> +int msm_count_mdss(void)
> +{
> +	struct device_node *np;
> +	int count = 0;
> +
> +	for_each_matching_node(np, mdss_dt_match) {
> +		if (of_device_is_available(np))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
>   static void msm_mdss_irq(struct irq_desc *desc)
>   {
>   	struct msm_mdss *msm_mdss = irq_desc_get_handler_data(desc);
> 
> ---
> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
> change-id: 20260316-separate_gpu_kms-04d2cf4d91e2
> 
> Best regards,
Thanks,
Mahadevan
