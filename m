Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0175BCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C76010F57B;
	Fri, 22 May 2026 11:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HkkSHchZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nz10iDjQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42F010F570
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:49:54 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M9AGLg1816083
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AGLayqoA/lyQQ1EcFZcThAEASM/G/Sr+5X1wUf0ZVkQ=; b=HkkSHchZHkjUvBPb
 Na2DqDIgnFk6ag54FRNJbQoEru6shIn7/YZzXS7t1Ti/NTrtXZ8kceFyMmyNRVT/
 /EjqPdNMDhqVMEKHQSLOUUB+Ch6Q7nmLTev0SUc6iq2sw/u6gpikGbSU0auJeBX3
 67HK1AXZJSsMizVgVhP5AbQ84PhXKFTCIbr99wS5t5oq/g3PTCObsM/3WrSDOnLo
 orD26QHc2q6CYHPMC7Fn0ffbdrbMb4ozTdcwc/hIhcsV73/Kru7auTuPy36Z45Sl
 wQvIUehu7d7M6QMQE4vkBOJRtsxLXWIjV4xL/kQreTnQIBeofdSHr7UKtlNlmrRN
 Z82DrA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrm1str-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:49:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fb98b09d3so22973651cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779450593; x=1780055393;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGLayqoA/lyQQ1EcFZcThAEASM/G/Sr+5X1wUf0ZVkQ=;
 b=Nz10iDjQtjBvYIV0ApbSIOBuvAd3zbMFGGGUYbGxEiK0XFWuUVs5Nd5obkItcl6jcQ
 tom6DHOSWycDLsXpydNuPKVbZ4WvvHtTUXl7KxDpjn5zT131QYxYKToqYp90cUDY4dbw
 dwNJi5YHoh5U40zmvWvSVHXvJ8RtdnWnGyVFPuYBg2JOc18Df5nUqF6XJMmihJ4/UBWc
 7ZusXL7AFeBZTuLk4PhCNbHHq0LIUcxzOriFZtVjXdN520nHXJzHEi/NcEFsNkitaB3u
 c5ww/sHFe8SnimNkEk711qgkObRDd9pX6e8pUv44IC3Ry05UBhACUIaZnhJV4HiQtmwL
 2JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779450593; x=1780055393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGLayqoA/lyQQ1EcFZcThAEASM/G/Sr+5X1wUf0ZVkQ=;
 b=iBNKGNIyBXYMrRdWuAbB9jC9oqFP2rMC0zadYdowsktlRRH0KI2jraIPoe2kktrKm1
 EmSZWPghd5uTri7kupLq6YK6HXqhVoEX+jO40qI/iGdFYXhVLJlf274zAOaWeaFhBIg5
 eXT5la56CJdfn5nTaeEl3CK718T8p2vjuXrPy0zX1IPpq40gdzPBqC//bhS38Df9PXkX
 NlsT4KrwxMSVOsnbi2MHYfVmRnWVL8Ut3L+72XtugWNaiMn7IRXtEddOEUk3VAVXib8Y
 kER/PAVmeL04kdhUXpguFRxlOFEGqLmxL4cp1pAdLtkaRaKsQSg4NnbHRgLHjwf06h4F
 iH8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3ybZzUeq/aa6gNBfGL/rzDfkeue8z2jpELDoE7Mlt6sNakfDJh5siMkc3DlFYT8yfnGbBtLi9oJ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywj27uNnnl8eYM3s7BYYSIHY8dGd13Uum3YFu4WpbXWy8fVsmn5
 eZrBXHaDt4LPHI8vT+aocFIjnlRofA8taVsUZGFgef929s7pwrIJl/tHgSxWobrwtuddVsIs+LW
 F4rxKtyLBw54FAyNyorrFfQeDtSVNmjshKMRFnYqDcxAVkRyeHyWFawolPtEnQLnfDHdzFI0=
X-Gm-Gg: Acq92OGwImT/cDI7oe2PVGx6tVi0v4xn0ZroElkzsXMIROIzqKnA1Y4AvA9Fp4Nvafl
 wrYNpd7RHstCSPKYQcqwfJko+LEATX1Ak8jRkHsp65scqRwqPbtDMlUaPjffUBLcYwjP06I8JYR
 IQh/CpncTybouG786iyoQjQDbzySAWkN6eBVU8Pe7gvYIYHJO3pUig+S02WQcvMYccYpxNTE/H3
 BBYSX0xLMnpL6R56Pd3FItyuLwJBXmTDRY+2DcL/rfzvfRB0tUddPNKCqss4KZw1bV/v4574Wz7
 L99HAa628GAvMElZZPzLKcF5VZcz2z734GaqWWETV9RrROu1L83jUW3UZQdr/dYfEba7tUhJFzZ
 emTD3ZHDc+LFHeM7bzwlKH9yj4PjczlPXZNxHFnTV+FDiUg==
X-Received: by 2002:a05:622a:8d02:b0:50b:2875:5782 with SMTP id
 d75a77b69052e-516d43a2865mr28083191cf.6.1779450593444; 
 Fri, 22 May 2026 04:49:53 -0700 (PDT)
X-Received: by 2002:a05:622a:8d02:b0:50b:2875:5782 with SMTP id
 d75a77b69052e-516d43a2865mr28082941cf.6.1779450592979; 
 Fri, 22 May 2026 04:49:52 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc5eca616sm46577566b.30.2026.05.22.04.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:49:52 -0700 (PDT)
Message-ID: <93327e80-c4fa-464c-90d2-26a7b08b2ea9@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] drm/msm/dp: clear EDID on display unplug
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
 <20260314-hpd-refactor-v5-10-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-10-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 37_YucX6e5ME32vtwGKW7GPRRrg2m7Xr
X-Authority-Analysis: v=2.4 cv=Zekt8MVA c=1 sm=1 tr=0 ts=6a1042e2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_8rHRARLNTRLG0PNjecA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNyBTYWx0ZWRfX9TMz0IT+RGWX
 4YPUfUIEZU5OdUNO2wAxCjHV6NznX61kOC3JIDPkcEgKvbhFsXtAXm48tZQVTwcfhaR2rBkTK21
 pQbl7a8NaLzjscsn7J9320mOcyZCDbzQb/CoiaygnID7mrh7MGKFcipYTifCPAq6klZF4T43b2f
 6T3veUKO4XTbvt1xcWoTVPrTKOjkx5e0HrC1CHZIUXO4ZFRCMOMumz3QFbXC9c9pumb3mgB9/GZ
 m3xqZ2OH2/59C3dTALqbDdxLT70B/qiohdUtY6/oKnivJYzszXGEOjBRjfsOsomH1qFNctgVN5P
 kSBQKgS1fvcpuzrxDgAtvZ+FEcIQQ5QhUlYXKEVP4yVa5pVaU6zYVvMSKcoy+YUG8Fopc3v1coI
 eJ/t2VziCYGZzc+oV2VBGWHe8tK91EqIsnmMmbBbO5fGaNJPsiDEofWD3ScEizw/JA2HM3xKnI0
 C0gFagg62qPe7PbSjhA==
X-Proofpoint-GUID: 37_YucX6e5ME32vtwGKW7GPRRrg2m7Xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220117
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
> Currently the driver only updates the EDID when it detects a connected
> monitor, which results in the connector still listing outdated modes
> even after the display is unplugged. Set connector's EDID to NULL on
> unplug to clear the list of modes.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 8 ++++++++
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 2 ++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 0a38957ea901..5c6a24ec140d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -447,6 +447,10 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
>  		return 0;
>  	}
>  
> +	/* Don't forget modes for eDP */
> +	if (!dp->msm_dp_display.is_edp)
> +		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);

Is there a change some ""funny"" panels decide to output a new EDID blob
after a "proper"/custom reset sequence (e.g. to remove limitations
presented to the DPTX at the UEFI display init stage?)

Konrad
