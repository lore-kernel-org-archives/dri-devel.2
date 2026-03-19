Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E5F108E1F7
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DEF10E9B7;
	Thu, 19 Mar 2026 12:08:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNgM3QvQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTN/0KRG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA8D10E9B7
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:08:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J7452T3369320
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oHo8j6UGq4Y0XJeKDffpEvuDA9pXIKE8XFl4Rb5qjE8=; b=bNgM3QvQTbgqIa2h
 Xv2VgkcssN03X2/03DYJCNKCxRn3fraiJy29TFA13r5F042aGU1bse1AwKnAjZ7e
 DaslRofRC4XVRUX3PYgehz9vwYPZkCqg+X0/PEenQPfx77gZSgfxs9B8ORIs0jHL
 MUfz6DtH6d0xSnX5qVopfVaQTdc4hOeDYkzcwRHwBHwu4LV39+TPE9y/Nozs40jR
 XZtazNAaj4Tz38A2ndYeJ2DD4V4F5OoSNBzP2cqceSrw70uVQyFCVR2oinlLh5gn
 mJl0hHTP9vpfRg6YgGE/d0u4mY8oW5DPDvUPMH6ZtUs5b2xVKQL4QX3w1HRzzjgo
 O8G45g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00f9k28m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:08:41 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5ff082f8a1aso172214137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773922121; x=1774526921;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHo8j6UGq4Y0XJeKDffpEvuDA9pXIKE8XFl4Rb5qjE8=;
 b=NTN/0KRGxrMV4zbZioHPVOWgEzuyKFNQtNoABnZlyJMsybNXGBFTUY6A55dxMZNEZx
 pLB5IOTwDBwV4ljRQOlY07EE4AfzXh2s/5/W2AuCbDYmYIsbi++AcOW3rMMTpl5bq1jt
 naw1yZyOwzrIBnjjPAj8DDkYQQq7SfaIg9ZCfuXYaIUJytoCOAfmPBtfxVUI6LawSkkp
 R61r3ooI2dlaHtOKBD4Z7mjsL9UUP1j6FMaJyfTz+drO9IopcLZi8xlXcwdwwe2B4AuP
 WTySsNoXU+6QwRt6dAkT33XoWff4GhJjwqsDByi/5wrjd9eBKgDhNrjLMLaQqeCib+71
 eQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773922121; x=1774526921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oHo8j6UGq4Y0XJeKDffpEvuDA9pXIKE8XFl4Rb5qjE8=;
 b=ENndCNjLQJaamzCLon41kbaGpcW1rGdL9hi8+Mgesiqx6wRJGRWZmw5ELEwRGD/R5+
 S3QM+vRXsqdBNmZsWTAo4elg2nkgnI5FFI57ONMoQWXODlm+3INUS6tWG3e6IQFz31tD
 2WWGdPambnYpe/EotDaNV7lHuxhGrSejszkFwICk6XgcLADIE9tQ599NN3hy3Q68uIg7
 NY2KUNB3Ty6FRxotU88YFXsR9zfqny8coulR2t2O5ggWhQ5RqoTcZL3sISnw/RLmAX3/
 nsetFFTFTdr7EPE+5BHe2UMsIASjWflZ30vJ3/tBEbCr9gQ1GH04QMnJjo+ugob/8BBn
 4TCA==
X-Gm-Message-State: AOJu0YxrM73oE1w7x3mHx4Z5f9R5/HuYqK/GtigA2cwxB5DhczRfi9S0
 2B4EBwJqdAJgnlO2DbnNhve8PpvLpOaOR4xzmgt3pJYkP9KUlkAII8v8rGuAW9T8dELXc3YQFr5
 MhYkd8evVmnpfny5HVL9sdh1fjIKU3UF0oht7adyRbeRPa3hz7+dS0GN9V16tNe2RzXJBQwY=
X-Gm-Gg: ATEYQzy+gIWSLk9/tArdp7LYagTpEciBAeJbBujnNWiqQY3G3JG+bAYfYpZmGxm+EAF
 Omhmy8EaIEu6eaiNpxoFKf2VbyS/q0uB6bRYhor8Hc7/IvDqBkb2s7DxwfrtLRCw0At33LpPeWb
 6ZDdznWfDJX/8XmBcauB353j39xRae1b3f9p3X0i82CtIvfaVPZlS10i2kHlxzZ7C99L73dq48J
 dZQ+OnPxYxs9CprEMgpUyEasnpMc4jscAFZ/E8PhJ/LBQz3zC9apD+e6qXJMKPS8ud53av6jnqW
 ows1MiAy7Hy2gFX0NIBjRDduVNHHznJhNhWBgcOZPE0/u/mGsN8K3q+RLADfuqtG8kQ3GArh0hv
 Ihq8kUex4UUJGkiDXuxQnIbrDj19dWl9Ek3X89LhJzGv6+3A10JsvLkWGfVbJo+9126aaw2FDKV
 OEAkk=
X-Received: by 2002:a05:6122:5307:b0:56b:8367:c6a9 with SMTP id
 71dfb90a1353d-56ba714817fmr1721716e0c.2.1773922121196; 
 Thu, 19 Mar 2026 05:08:41 -0700 (PDT)
X-Received: by 2002:a05:6122:5307:b0:56b:8367:c6a9 with SMTP id
 71dfb90a1353d-56ba714817fmr1721697e0c.2.1773922120720; 
 Thu, 19 Mar 2026 05:08:40 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f17049acsm439921566b.52.2026.03.19.05.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 05:08:39 -0700 (PDT)
Message-ID: <a837f6cb-7b15-435e-a30d-22ef437a7cbd@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 13:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/msm/dsi: add DSI version >= comparison helper
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-2-85b99df2d090@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260319-dsi-rgb101010-support-v3-2-85b99df2d090@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NyBTYWx0ZWRfX5R52t86dwlgJ
 g4YJL9X13oyyIbuz9CuM0SVUjlekcaetDry5UL+Ds2Sr6ym5vzO2OjLFqM82Vh0DW/HQXSwdRBs
 42zeny5CM7YnvQ9K/Xw3u9J+0aqbsKOH1n1Ib700Pl+x8ybGHyx0uaUs5nP0cTCMYhcemiXDrvp
 bXquPxsYgb8b74QffpvrRn0bAjXsZWvgoiRHZ4lsoBWy4yKc6/5LKibMYXbcf1Fm7IXVd03ESnF
 OYSvdAp4ovflEXQ8bXgqiIeihpAVS3v6YLfD9tX/3jQCw2g/MARlapwDP/OCp9i0F/b3+e7muSi
 /ohF7/Pc43VeEq0LLZmunSSsv+5ab249VGAceKOBhLBKApab403xc43EBrJ3R2coN1eO+ePQFOo
 RULdUqoGkCPCtDAixLTZOkkGKYzgTZluDBI0cH1iwZUaEuvAy9P+TcSG/8hmYSXG6aFsVgwh75y
 +AjXVyVdqrhAH+hyCYQ==
X-Proofpoint-GUID: FVQME074huu096zeuASexkF_Od7C6YNv
X-Proofpoint-ORIG-GUID: FVQME074huu096zeuASexkF_Od7C6YNv
X-Authority-Analysis: v=2.4 cv=MJttWcZl c=1 sm=1 tr=0 ts=69bbe749 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dCPkbIS1lotwSDO2_C4A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190097
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

On 3/19/26 12:57 PM, Alexander Koskovich wrote:
> Add a helper for checking if the DSI hardware version is greater
> than or equal to a given version, for use in a future change.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index db6da99375a1..6fad9a612d4d 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -782,13 +782,20 @@ static void dsi_ctrl_disable(struct msm_dsi_host *msm_host)
>  	dsi_write(msm_host, REG_DSI_CTRL, 0);
>  }
>  
> +static bool msm_dsi_host_version_ge(struct msm_dsi_host *msm_host,

I think that "geq" is more common/obvious, but anyway

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
