Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0266C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F29F210E0BC;
	Tue,  8 Sep 2026 08:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="arIuAESW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WCwC+BeQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9454810E0A6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 08:02:15 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886Lneh950642
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 08:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WozNudziLKgBxiX08uWyerO5nuWlCikb2YN/NDCsgqM=; b=arIuAESWcUWwrGI2
 pjqkoOyJNILtKK2cq6jHIw1appcqCWGaIrfPiN9hHaHs8t++cmtKy3CztvswBNVD
 t/6GjjGovrE5VKW00dJhb7Di5oG4pOLrSRwr8G6SqWWHV1FuFCfZmy4YkB9ya1+K
 ocMxPyWERANVyf/04rKh2xg5jPmZiBXA5WaefWlk1WEX21EhXsYBQ3zNmjkhImXz
 /7lfYFr6uGGQjS4gm+sKQ6MLV5ExzzAtYG7G/n3z9v55eWrDxNxZ/2IDzXUQUCDa
 O6gJ401SKTb7APWF/bnEwrDYZif3Ao/9o7AHNWUmW0JvheanXxCTexjM44ZEqwbO
 cpWkFQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcrp8fx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:02:14 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-783743bffb9so61253137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788854534; x=1789459334;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WozNudziLKgBxiX08uWyerO5nuWlCikb2YN/NDCsgqM=;
 b=WCwC+BeQ0AczLzVSeFwc9VdvRDBCNNuntr/kTxAS7miX6x7VM4wH3sq2+W6qjSgdwk
 Mb80XalnSzWob8HCpWedRMbhEUnpv6x37A9IpvBDI6wkgaSbMilt3NLnMacpXy4YKCFj
 dqzVbWxhxSnI3idkAK8tvHXTvPKu9/GER5rwCI3mZ9R36mleRXGFQKFgiFq7kl/1DpgW
 vPuIAHzPquAXUJcqc1RP2Emplgef+0rrEE4yg2mtwLeuLd0u/XIfWMvNVIIfJQSOwO52
 W1KkTlFzzunud/FoqXP3+DmGll67zmbDvroxx6uNECefLYTg9wCf94O9E/NBoMpi+DIm
 wCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788854534; x=1789459334;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WozNudziLKgBxiX08uWyerO5nuWlCikb2YN/NDCsgqM=;
 b=pyunX1U9cWJyXNG76rH0+SQE3oqJ+SGCxUYsP3qEhkievyX5aOyNWVzwfH+vKc44sn
 22nbGTe7MjHxcyL81m8LTkea8+LHDeZw9uyD/YfahlZbIxcT+BYlcGbuwIeQgF296veZ
 4qku2JuaR05thu6M2AiI+S14say9Whwcji64b0nLQtvxjDwAv/iPlhCtruph4S7t3hES
 049Kf1mtMqwNFzbjRcb7/84G7Wv5dqMeo+7XEbIaPKGqnv91RvGBXvxBNBVYLxrWjx4v
 uGIowsRSwldtGZ0VkT995EDkRYVUTUS4T64geGoXgxxpNb311cbVtPcqdGAIJFmugKRH
 GCnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykhCegiDlLOWGdufMjOfqry6OshgQVjgQ32EAKi5RcFBRjlIejrdf2buOH2PcaKsAfO9u4pZMpZhM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lUBQ2g+6oZI1Lbou/B3DpNjp13A+TrVliCFGqgIxVsbJ6XPcLd
 KCQMz7FmOtafMw06EqoCqMAkHVdF2Mb/PgDbINGyUwIDHcxq+5vBHEooT4w/szZctDjHXqfMPJJ
 YSjU8m8g0hFpkc6Bk34M3grdYn+GGBv/UE7NvEBhQz72PpnIK8pl3dJ6SlVPFs3zEJrwBFWM=
X-Gm-Gg: AYBFou07vJKZ+fIdOys/U/63FjSPu8HtIrHoNAEg9sXG6io76sO0MvEY51+Qh2LBao8
 48Q0eQG6sPqoME92C3AHctdy/6ddwWyW/tsL52Q0ipHjlS6I9Jjton13BRDCF4MbxU3i3ttW3zl
 Mrs9ePVwijGkzA6dltx/s/0W4UVXsvt+0uYyQVQEUXYizMfn21t/zwda0R754blT2BmwXIq4Y9Z
 7cehSsUzm51NMzx94kSN2iIc73RRPUBa5fpuiFSqFi3APbUS1ZKz9QmJmiuKtEG01pWa56V+9gs
 rul6eea2udbHLPX6rvsgn0B3BnBNV3vVc4Yu/htoKXnc+Zmd053NrhQi/4F/Z/TVtC61vPuC+VN
 TxV0ddDAmDisS0wA1KwxBGQ==
X-Received: by 2002:a05:6102:b03:b0:781:9922:78f3 with SMTP id
 ada2fe7eead31-78a60e5b62amr2664039137.2.1788854533915; 
 Tue, 08 Sep 2026 01:02:13 -0700 (PDT)
X-Received: by 2002:a05:6102:b03:b0:781:9922:78f3 with SMTP id
 ada2fe7eead31-78a60e5b62amr2664022137.2.1788854533373; 
 Tue, 08 Sep 2026 01:02:13 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d559364sm565451966b.35.2026.09.08.01.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 01:02:12 -0700 (PDT)
Message-ID: <06bb2b19-bdb0-4dcc-a6e2-6805edd9084e@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
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
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-1-dcf8956878ca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-1-dcf8956878ca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UfRhjqSN c=1 sm=1 tr=0 ts=6a9fc106 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dCp4QOuT8fr3gmi_UlEA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: PCyelX5lwPuEAsIAcYrXVEx68vYB2NX3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfXyDsW5hpuJCJj
 6SMtKBpWMkTQOVPTzGOyPMU+oy/IynlXMLEItuHw/L3LaU3MzpnMFbof1eB7K8pvC0K8tmLtcsH
 3XorQouwQojsbR+Mqlqmaw3CR5LMSR+hKXbeHeyFpFXuF0p9h5dc+c0CjjZGJkF4ughp4L6FjVG
 YsUfWyCJtWxhnArNyP6HTFUgnPFwYMsUoZFlFj7mW+tvnnR781aIQKcUaQwSYW9aKab5K7erY9Y
 QFIEwYpLa+rnypgNhdgniE5fdxZjwcKr1t3lNUN8XBHbenS3UK6/1gTVuRQ4lItPCPSZN5vuH7J
 Ywtcm+olNFlwso1xL/nP0huC5TOM69yLD4Vmgyf92E3jN+13tatqKgfy8XJ7xekX4im/zuZ0kGa
 2rDnqmqIQsDsjyb5JWKeMuPppF1dVZy9o671P4r3763KTkWafgrQDO+bCFLKpLllr41MjtoWTh5
 p57blbM0fgFJim+SgZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfXyeQTcM0c+0cv
 up3GVkRVYaH5czV2FcemnJpr7I/h8KGhgBmPcAoHcufHUyV8b0DbF7SgoFHlA6FQbVFB6SET3pH
 Lhy78TXzJ+PmmKV/ZUVSbl3/Lsib8nk=
X-Proofpoint-GUID: PCyelX5lwPuEAsIAcYrXVEx68vYB2NX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080082
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

On 9/8/26 9:10 AM, Krzysztof Kozlowski wrote:
> If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
> it should reverse the state of things already changed.
> msm_hdmi_phy_resource_enable() is used also in probe path, thus such
> failure, which could be simple deferred probe, would leave these
> resources permanently enabled for the rest of the runtime.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> index eb1088755cb3..15e37596bdb1 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> @@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
>  	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
> -		return ret;
> +		goto err_pm_put;

If you're a fan, there's PM_RUNTIME_ACQUIRE_xxx in cleanup.h

Konrad
