Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2DDCD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F11010F56F;
	Fri, 22 May 2026 11:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dtxv7DG8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UUIgfNG4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9CF10F55C
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:35:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MAIjaj1800770
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QI/blTowH0kaW2AM4jCG/m5oNq4TreS0VPu0Sj0yPxI=; b=dtxv7DG8J7jJ+raA
 uOip2j6Z2xYh7wx08NHYXEzbFLMMZ8grAm7QgkQYWv8poohJuPr95kbThi2rniOr
 ed6OLS0ywHQG57xaaGOEvEL2nVzXlRdceQrZedtBY92uzz6ejhMWPGlRs3Pv28m1
 lUw6iIqfn9ciQ7ZwvpFkfTRsdnVipAJGco9W8Vb+fjet5IsIVkYXWgfPovyZ/Yup
 X/0BQ8xHvAnu0fa/jkUwSb+IvHNC7rtxg0jIsCtQbcQHEh0qXaBy6TZFMyzDURji
 YlEUfvxo52SBO5BRpj47C5fGqTPO2bwFj/9Idq6xxAHp6gyrjdHFd91hk+lMKdad
 mfUH3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g07um-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:35:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-516d1b82fd1so1901021cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449738; x=1780054538;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QI/blTowH0kaW2AM4jCG/m5oNq4TreS0VPu0Sj0yPxI=;
 b=UUIgfNG469WYGs5O73IqDdUdU2VAegzw37PWxLx1OxrT+e2/4kp2xvh0nxItb8I8hv
 ggSBSM89go1Av+WjRX+fgemplVoZ555K18SZG7aLmaUG3lly4MMeISbad4DAczQq359h
 nz6l4LpQb6NAjfxxcx/nGJmyNH3BX5puyuHMjtXzz09htcl3IBZLNvR15+OGLA0w469X
 +BF08NW8TdHe6tLWsE8JXZu7c4mOfBVNUlsju3azZfeYgCzamai3OEnEZnTPToOzPOLp
 Rtk8lmVTLUC+aup1K0l+1sEDTNt45WdGlQy5Es8mjn9oeaf2LvD+yvqlG52ZLT/LhU3D
 QZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449738; x=1780054538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QI/blTowH0kaW2AM4jCG/m5oNq4TreS0VPu0Sj0yPxI=;
 b=oUyv66xQsCF8nRRVKoyyP7MN/QGIXiLdg/pJqbqvhA2GGY5+6Er4C/7XVSAoBN7clv
 2IqCjwv9dXuSttieQU4HpdcAOlK+RU8Jk8F+D1g+yoqqQtfl+L9NSgi8wCSdEiUV2WFN
 bH+qa6te/d77CiAwvfKEen829e43ZLLkzwGxBylHt/Mv85gpYZ1JXYf2sOe0nrq/BPhO
 sC4smU/3bQh2n59e33sjE4FhY+jF4WG5d+BInbzleVTlaZ91a7AB004N0Ilcmq1lPVGF
 tyn4QjcFss8mf93eFg338LSCSeezuA9pu2H2GvoS8eUyoUpHJA99d/JF33389Llzdcg8
 /34w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8weu8rHldeItH3w+sceYKNuDk6u4S/OFcu/5gtguj26PuOuni8+h8aubWhv+l9nnis/CPnZx+Ji+c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlBzUyWjzxebFgjjzB54097LeT8mkU1KHUTNwb2MzW9bYQZiWs
 hb6jtBHxZgUMXBeBtMEonscfGtJIdcVuiz5qjIZHIUPGc7Cl1LssGaW7onApKHuGcbdTC+ybZRJ
 o5SnYbmlJtLsrYFi0p4PUBPqlRLFU2VZ8keu2c935sRsxJM/R9OG2VlqZhFUfv1l6/+rBwrQ=
X-Gm-Gg: Acq92OFNHX1v9KIIBexr1yp+wZr33HItnLzh0F0qLxdlj1cIG2SD8Rdpp9Spxmv2nzR
 j5sYOODndRpxaP5uzCwMJb81hkPtCVzhN0f+xVK1tJ+3p+XGO0SyQpvuTzg6mlBkcvaLkkPesIY
 Ox/VvyVCywnUonMAn2v5fuJs8TnORZk3FNAKfpSLJ1LFYoRP47Gpj/cvEg1Wy8FYvoRU+CFvlIu
 IvpoZDWg5OiMhYaHVJEHvgfALF42TLV3SZvMIFYl3Azlx4wi9FJlhIrSFzwNnOU5vJUHHwgIe5y
 Kn4mvfu6dhFQI9mGZRdoW41aVC0tSsnw6y6Xv3p7QSGXZ7PtzPYSJVXN3h75ZtWPZdF70nATPpx
 FrSDGkr4myo90VT8Gfc6tXZ2r6kNYGWrR1d1yEMlhukJyVQ==
X-Received: by 2002:a05:622a:6116:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-516d43f5402mr28910251cf.7.1779449738414; 
 Fri, 22 May 2026 04:35:38 -0700 (PDT)
X-Received: by 2002:a05:622a:6116:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-516d43f5402mr28909981cf.7.1779449737904; 
 Fri, 22 May 2026 04:35:37 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b9f5db74sm567957a12.10.2026.05.22.04.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:35:37 -0700 (PDT)
Message-ID: <da75c570-8353-4a0e-91ad-d31e0c4453d4@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] drm/msm/dp: Drop EV_USER_NOTIFICATION
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-5-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-5-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7-OVdBSyxwhkO71veg9n7HnQBhM624Ck
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a103f8b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ls25Rwon0kCaizU-UYAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 7-OVdBSyxwhkO71veg9n7HnQBhM624Ck
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNSBTYWx0ZWRfX6Qy53vhpqcih
 hf4nHSsBpUbRGxhc0dj4zU0DViKQZvmdqzTQtqA57iiY+3ea2XkgCavggNGvP3eF2crNjrVSto3
 l+aqtWNW8mnizRzMNVcMNeygS8zLryEzsNx+eXrrV/lgnP4Nbl3EWMd8NjuDCJ03cYNcO/R25hC
 OkG6V7dOikgAbZ2SSf37tFE1dquaXGGK+v7uZpMG88rVuw6D7ypMDHUuH/kHREI8TpEBEY14bg8
 aVq8wtWBwY8lGohEQnCKVirBwis1cCEFEpBRfgZkCzk9wuR9VuhpZVNVY47G5Lc6Ba/97on/Ihy
 m+7K7pAckGN9ze5zN3noxkveo0pYTxd+mJA5PIRgMFeLrOwucTn15a0O91SjX2y4DOG2xv94A2m
 xwKx6BHib3f9OTrkbVj9HPGGQsXazJgvw49HG+tr6OxRTMItTh7OrpmpIyaEpmeY86VAVMBfMXI
 0QHIpSjAl2jvInmLI6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220115
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> Currently, we queue an event for signalling HPD connect/disconnect. This
> can mean a delay in plug/unplug handling and notifying DRM core when a
> hotplug happens.
> 
> Drop EV_USER_NOTIFICATION and signal the IRQ event as part of hotplug
> handling.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
