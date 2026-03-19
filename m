Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD6D1075280
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3497510E115;
	Thu, 19 Mar 2026 09:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oygSXYnp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M7NEZXrg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C9810E115
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:10:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J740rw2666132
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v7m7aQiw0qBzZckwF8h4HRoLRfPXlziXjLV1T22Cnm0=; b=oygSXYnpCeueZHt+
 YaVoHrFxkpgCVElTMpxIHPSKo+u4BrA/3PvRSMnrydNd9sZkLD9LzT6mNqdBEGLh
 tnB3Y3MHeeq7bYAVm+RAilMQ3l5X/yKWKCXp7JWtt8Xc+hRyuMV05LnZTopveuxh
 frgnSkIRQdl8lQfh48wgKL0J68ysTgpFScV8/XPvvYtkv7Q/u5vsDDSFpW/Yc982
 0YYl2r0iEBLTp4ZKwKAwbiC3WejXTz5L2DE4/dlaw22YqrWwIwVGdrh+vTjOS5Td
 npYOVXKVZ1BhPltK7TwFMEPbJ4d2FUc3PPKL5cooQMvschDEK8FJxomsx2ULwwru
 Ik0spA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cytj5433g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:10:37 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a086578c5so6126276d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773911437; x=1774516237;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7m7aQiw0qBzZckwF8h4HRoLRfPXlziXjLV1T22Cnm0=;
 b=M7NEZXrgtmqAj69G8cVuqHyubhHBE/qkV0ix2aOLtYJEvYeb0WrFTJZGq7OLxFx6a8
 e3q7gmhWsBaY5yc6bCS+LubhzXvcZb5RS9p7oLMHWQ60jGkzOKXkgmVb9OFFwR2YhRc3
 PjzLAH4vVF3U5vMlZoiUNNPjZZD98AipIxESz4AczXE6H4jebaESLlmaHx+OtxTTYVcX
 M+JKt4pJZNdGUc3eZPMW7tSQchEnhP5vYJ62/xMRM66beT+v7grum6Yhj+xznSras0sX
 +IEh/ytKLPDZgo0c++QfP/7NXvkT8DvBr7XYeVnaMRFJzCUYh6zs44gKu13gRY+b7iqD
 ALjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773911437; x=1774516237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7m7aQiw0qBzZckwF8h4HRoLRfPXlziXjLV1T22Cnm0=;
 b=Xo6LeNCj7EPqwfwLjdkUWFEMJjwoKXupe7t2HIs3OGOJHFWWQrc3aMmjTjT83Vtz4S
 sUk1pt0pUyEtJbQL1aFzLYMqtgNkxK/Guvjgnr6TbWOfMlrVtff+1Cw5s7qfU3Xhbv9x
 96/ECnOztRBtleJgR+r1fQtaLOOa1sXQPJI5UfMSLH7UvAs0ZuQqAjnDqJv1QCupRc2T
 wFGdrbFXmIu5UgzNXyUJF41aHDnJRE54T5aORBwqntNYXCtzLLQHJhzQtodcH8uGyYyK
 Iv5GQXjC2nqVvp3o4LOdfhnqnyinnEZzQr8o18NQRDddeR9O8YQnBoquDEAO3WgZ9ozj
 /C8Q==
X-Gm-Message-State: AOJu0Yx97FGfbpc++Py8CksSIyd6dqCe+E7+cB8YEBi3GyPTFt1HSVnk
 U52pxMhXyFZkN+xsbifmcEATvpgWmetjNUrRgGh+QbhvV/oORA+GC9OFKPPRezPG6lNVVY5VpNd
 8VF8X52k9orhxp7FPV6/dw97R90QsepJ2yyChjV6S7PvbOLYYm+u7S2JyeT/U1KSkpEsxvsY=
X-Gm-Gg: ATEYQzwKPqY9oQ/N21HmSEs0m16yQmQk0PU5AGA8ziKzLf3R223QCvzqrJhaKjqiSm5
 viErgkkDu323w1JZyqh4PtqdJsECBQcEnJjsETe/t6QT2FrQaZ3GQmalHqq1PvpazPt76DHxLb7
 cTDX65dNWuGQaoqvcxG7p7EiywrDhpvLp2Z2tZsm+9ImItM4rJK0Kp1+kMKh1VrQIdPmaMLguxi
 VyieOzFxO/JQkr35VL9y09Gb5ZEy6m4wA5IZVwxLZvTVjvV6aCxEwwNobpr3zyxUYtGRQxvcVXW
 NkEJtsToK8f/W3jEsmX4iZ/oR1fw+0DEM9NILxN3eOXDlQX5Ln2KpE1KLIvek7oLHlAb7Q7oMxZ
 2J6Jw0M5/o4gB6yqMR1tpClVt3q/+KD+KXvTTajHot+XTJacLeLfGOlxwVlWKevp+oJotiX0Xw+
 nhBqI=
X-Received: by 2002:a05:6214:21e9:b0:89c:40b3:1093 with SMTP id
 6a1803df08f44-89c6b5624bdmr69955226d6.3.1773911436990; 
 Thu, 19 Mar 2026 02:10:36 -0700 (PDT)
X-Received: by 2002:a05:6214:21e9:b0:89c:40b3:1093 with SMTP id
 6a1803df08f44-89c6b5624bdmr69954876d6.3.1773911436409; 
 Thu, 19 Mar 2026 02:10:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f17036a0sm409705366b.49.2026.03.19.02.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 02:10:35 -0700 (PDT)
Message-ID: <5b79ccbd-5c75-454b-8b3f-812a6c59157b@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 10:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/msm/dsi: Add support for RGB101010 pixel format
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
 <20260318-dsi-rgb101010-support-v2-2-698b7612eaeb@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260318-dsi-rgb101010-support-v2-2-698b7612eaeb@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3MiBTYWx0ZWRfXwjR/MxOB+YSH
 bvjmplNLFif0HUsbXpeWDgf7c+I5FFsCOIaYOqpZDynOADzjvUh04Ioo549rjkW8lQYWy9tlxfR
 dnW+lNFK1JiTRzhU2nJOwTH9KfwlWoMtj9OTi9XXOz3BSZ2g8ObvIPg3j1nBY5TXpklrc7ZcM00
 fm/0e6zJyueTk/D2imW0rXXRQgA5m9ZVN7x7AqelY0w5HnqcU+Y9E3NHR2PXzRCdqAwcedr5Joe
 0IeZICw9X8gOAngWsGIa0T+oKf4PTNndeP3wipYzWFwVaOMGaRLU0omYwNQwv+UV+KdBZvz4M3x
 NflIwWj3Gc5hYfIpJYnBUBZjIBreJcfhb045H/tA06oMuHSVqf1Q75XSuBV/uxQWjVSLnKzoLi9
 +JMSxeEK3L4kwPGscNWAEAyqY6B84RpPuojpjM4M6DZEgqDe2ZBTyDQiZnunIw56ex2fzxISM2D
 wEvktX/VamFNOVYX2EQ==
X-Proofpoint-ORIG-GUID: HEX_nRV8RZ9dl7m9n1OeHvgxRcoFnbtI
X-Proofpoint-GUID: HEX_nRV8RZ9dl7m9n1OeHvgxRcoFnbtI
X-Authority-Analysis: v=2.4 cv=dM+rWeZb c=1 sm=1 tr=0 ts=69bbbd8d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bo00AjUxo_B6Js9JdCAA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190072
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

On 3/19/26 5:00 AM, Alexander Koskovich wrote:
> Add video and command mode destination format mappings for RGB101010,
> and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits to accommodate
> the new format value.
> 
> Make sure this is guarded behind MSM_DSI_6G_VER >= V2.1.0 as anything
> older does not support this.
> 
> Required for 10 bit panels such as the BOE BF068MWM-TD0.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 8 ++++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h             | 1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c            | 9 +++++++++
>  drivers/gpu/drm/msm/registers/display/dsi.xml | 5 ++++-
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index bd3c51c350e7..6a7ea2183a3b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -133,6 +133,7 @@ static const struct msm_dsi_config msm8998_dsi_cfg = {
>  	.io_start = {
>  		{ 0xc994000, 0xc996000 },
>  	},
> +	.has_rgb30 = true,

I wrote a patch to determine this at runtime, and only after I was done, I
noticed that we can already achieve this:

bool msm_dsi_host_is_wide_bus_enabled(struct mipi_dsi_host *host)
{
	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);

	return msm_host->dsc &&
		(msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
		 msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_5_0);
}

let's perhaps extract this to a msm_dsi_host_version_is_gt(u32 major, u32 minor)
or similar

and your assumption about >=v2.1 is corroborated by a doc I have

Konrad
