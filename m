Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753AAC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2DD10E2EB;
	Fri, 11 Sep 2026 15:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dqyk7Z5o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKvyinLl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C3210E2EF
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:48:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm2YB442908
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +D114KpAsx+agyqYsIr5jY5EYt36qFLcj/ka8IKdRy8=; b=Dqyk7Z5ovAa7SRGT
 K1HzDG9VtyHfDZdfKyJvpISk62nPxNK89BrrA5MMKUTxZ2q46OGLN73UhptCNvYd
 JARnUbS9+RzSxN9DHJSx1gpF74BEy9wwOuzIpG9CAgJaxakI+kU9Ep07/9waNjAn
 NEj+IoUrYNGrYfU1WB1oIDmT4vkwsvseXzpjPklkLCg4ulAtnaNT175/grQFbb+q
 JrhstgCzXUA+QDxN7T9Uz12asMRaxRpNyh89VBlUq0fezg49KDltwOKGPz7orOyU
 4m00yTdDS6/1UOh0Mg7ewkceiTurr1OtXH92qQYBWTGY9ohH3bKEJ1nHj+8cUCcn
 xAQCew==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmapg2q06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:48:56 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c84b0a43efso39524e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141736; x=1789746536;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+D114KpAsx+agyqYsIr5jY5EYt36qFLcj/ka8IKdRy8=;
 b=YKvyinLlTyEvUtm9VRE+VuFJPBExWSWsYURBeTXaDJ4M1fVNKLL4Pm9DuMKy7m/Px4
 EcpkkkRcPa3a/N2h40dMw2G0hwtSyUvRWgfokYsW2tmHydVbrAM9dNb2VovQeiEhu52T
 UMrUAIw9Y47MO1X+QsOvaniEYpKB5ZcNY11d9VfxvyQFH4fuQazcTNfbucriOlPrhj3h
 Tm3trAQtEaNQpUCxFrhENima/MbPoPvoF9Ok0vEdI/8ozKeUuJrYVJHvdv2b/tmlyafK
 XVjBVLHMAZQ+jH5525pj/YgBEaYU9mKCSQRfqRqTklFWhnK/sS4SHiNgF4XP/DwHOFgC
 4+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141736; x=1789746536;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+D114KpAsx+agyqYsIr5jY5EYt36qFLcj/ka8IKdRy8=;
 b=RKZte9H4LxCP9SxpkoGj1nOas2Bp0cTw3Z+sFJY5WfyUAQIVT2xJ6GH8hv7KaVeu1R
 XYTvh3XfrI/slv+DmanunmFqWncYh4RaF9iTDga2qi6fmDiZkGqVu6HA/1MUjfUm1/lF
 H03V+2D/+UuLLqGkflzKorDeHgA8cZner+itUEvl86oYpouW0Uf3RZxo+u4x5xz9xDFN
 fCMyqm3OuEjPHyW/j9+N3Qm7tZy2uiGKC9Vd2LK1+Cq9Odcs6uQi3yknpE4F4Gv6+m/n
 NpXd0v0GGxblEgiRf4NkSJ6SeztDQZL4a/aqj9QmigVDp7D8ypGJYYHnkGo2n15JbGlK
 ARzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoGNpqSebeqETH1B9SJANf9oieJPjshYX1TTvTmhOw/86GEWYAp1PWt9tN7oLTzo+A4KoiWTtq5E0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mPWSpmXdJxRotFxc1U6c7obXNqPAghsKlDXqDaJDscAZfTEJEI
 vQTQHQucO5LbpQ3onvkLS8jlLkjgl41G95uJtnH5Ulbkc/nGvk13YPnoAvNdig6lhfTcAdVawjn
 Gg1h+ZCsgvrAZBZPvVhXx6trBcIx5AZH1hkBmbvfC/N7ElC3NNe037pqm2wvjken5vF1j1x0=
X-Gm-Gg: AYBFou2cBdYAHh0ShpM59xARSxx3i+QCCMQ9FhWkC1LcMkd3ADnopO+LOYx2QBmnNKp
 0WQnVdpTmum7peQuAMHvnmYuGM6WrU/EvGLCmtWJGwNP+efvIndXI8WnAWBHJH4KyB3O/nrY1FS
 YJmS9Y30X3hKJsZ3npbhb3bja0zr40vPbw+x8NFCeJwdI73dU+teyust8hrOod5mUGs2uUr8niJ
 HWKUpnh72SmNngvRW0bNnoBH21amvM4zP/lKlCPA7haOZezBJUyT5Sz4TlJTcLAyZB7JBloZ7mX
 GZXlId9qmrOqBNCeE5u6hx2vliN6QcnKJWMxr50PIsiuB8ZzufV7QcOD2KMBcUwmUqFydjeolIO
 Oln8yPBDG4kzgL/auPC4CaA==
X-Received: by 2002:ac5:c5ba:0:b0:5c3:b339:7b19 with SMTP id
 71dfb90a1353d-5c845f4547dmr1731519e0c.1.1789141735826; 
 Fri, 11 Sep 2026 08:48:55 -0700 (PDT)
X-Received: by 2002:ac5:c5ba:0:b0:5c3:b339:7b19 with SMTP id
 71dfb90a1353d-5c845f4547dmr1731461e0c.1.1789141735422; 
 Fri, 11 Sep 2026 08:48:55 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b594f0fasm1042819a12.25.2026.09.11.08.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 08:48:54 -0700 (PDT)
Message-ID: <dc49be3b-5b8e-420a-be34-09bb27fc65f3@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IXj0DLvs-FJA9nQ1xTvErl0_NucZXE_f
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX8hTDn+bIGxKr
 rgKbe1in7kjEfVy/JY8mr/+ZZ9q9JGWP/iN+qTkJ3B4reWLT7L+hESIx8/jKurIVuZ7aU7kpPws
 flwTVGcI32s6S/k0stZT/vgTJylC1GM=
X-Proofpoint-GUID: IXj0DLvs-FJA9nQ1xTvErl0_NucZXE_f
X-Authority-Analysis: v=2.4 cv=DLoacCNb c=1 sm=1 tr=0 ts=6aa422e8 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Gvqx0daIpy4NcrUZJzkA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX3SsINwRq9sz9
 LrjdWC4zRCRCtfbhV+LEhNMZBrZtGriQ8byOkHXcZmmdkiW7r7DAQPOSjV9Vj0s6Bk51c2D9SIL
 +4Jx6A/TO23VPNAVNWojY/FfTo0y14TACkh2y86Ip96nWcOUhJCjYFobZCpOmOb/3nSIgdUDmdh
 CQAC3oWaj9SoZl0CHSUj3/IlALZle0hS1szP4JBt7Rfm34mJNC2QSfVOHVQTkSB8hP0e4JoxdZi
 nTFbs3c3U49Onp8cGrMI8x4cE6chJEg57M2XG01XG7hqs6tPg59+BzCWtbfq7Cg0h0S2fn8UIuq
 2YIcvRG85pOXiIp8eGrLCZvXa1ryo9NhRKM/W8p0hvqUnWQ13j2CMeVaVyNGd2WbljB3FjCuk0+
 gGdVex1xLPxko38ALcpYoLT+kTC3JsyetjHCMdR0pi658y38xYeo3gNEzkk9IliZd3lov1cDNQj
 skNLNEgr9M9oWPQDBKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110220
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

On 9/11/26 12:29 PM, Krzysztof Kozlowski wrote:
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

^ should fail too

Konrad
