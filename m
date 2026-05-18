Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52E3CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 22:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F5A10E086;
	Mon, 18 May 2026 22:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IQFmdHOx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IW/k47oS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB0E10E34D
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:06:01 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IHGuB82083092
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JIJpag4IKBHS2NicIuKqeOID
 rWkd8Nnw40za2QOynbQ=; b=IQFmdHOx/4qj0UzdCqejB0i/f3FtsBfQuy2Cp3sp
 wZu31uMEJ605riwKW0zxt/T8wLmYfR2uSfR3UMH/gcgelHe/ncTf94IrLWxzNN8n
 0fHTbx/ucBB5LIakZKqXdPwSz/Sz99ipibGJloZV77v3Rt6TvmMsi7tsgejI5xWk
 m1gvalzFlNB1LrDbdGIpkglSAHs1REYk20u8a+YxpqFgzLMRyNyzYccE5aWs7cyG
 IALPWkolsS0VqDAnx896njujJ1DLxkeJ458rPOjxSypEfFN315p1KYVwARkyKIp7
 NVs/wgBjZidkI1agcoCbxKAAqN5odE41qb+sY2rzysEYhQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81chafav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:06:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5162ee45a77so78981391cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779141960; x=1779746760;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JIJpag4IKBHS2NicIuKqeOIDrWkd8Nnw40za2QOynbQ=;
 b=IW/k47oSTwzuibv9aMV2Vge6CcEuHcbj8/JKQC0gb4ito1hiktYAT1heLbReleXhhw
 K876NvUhXI3tu8l8VUI5h1674gGPdAvA5RbtDOH2N37KsLG1QdmbyUcNEXLNRLbsi/zZ
 vQm4/enU2d90beU32ECA7NGl4TOJaaacjt6VS4prbmrHjPnODFeR9hIZ/dghc4EPkbkL
 Zw3kGpLakOLrksPx13Yj7UbYBetyQ7fcTZOnOdw6lRjV9dG5MenR+yad2l5O5F+N1nOR
 krLglAIjq2Hhq0y/wGRYzi+k5DBBy9vv8KMf2UI4Vwf1A8RDbrib1k8vFrx1fRU5suna
 /ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779141960; x=1779746760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIJpag4IKBHS2NicIuKqeOIDrWkd8Nnw40za2QOynbQ=;
 b=CK6C6qV+XqCJHJ2UWrHfAcDwLqSj+jrIWQ7vLfdgtM90LNLauR37kAQQaz/UN49Zrl
 emga+0RosZBpToZvzzsgfQdSIHy/UHhRVJkXDVukRb51CAH1FFi36DQ2nlpZ5NIAUXHl
 NrB/3ZtGGzkOwsEjYJAzjvN3hz6oWb7e57Aaaqjh2zyUoyPLzMR3DUa7DTOgKKbWv6J5
 jEYXaj6bbcNK3EUDixsfC6zzpA7i+e0hJ2rf4Qim8PBt9rtkH0AYWWojfbu11cNmg+WC
 X87o5ZWRzkh+AUvLfpdNXy3NZq3j4TWJez4icGITqeWlUqZqAQ5cbPeoHaYZQMRbYp2b
 yfLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8U0wzs0nmAm1CH9Sl0UtD5pnaPsrtMAUXV4BSqn9nhSUbDSRezMd7Uok/RL8xbIlKPSO+5i0X5pQA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxgk2RCD9cINYyMIpg9LHu/SAIXvNtWTRQIlmCEasNZWnn9kIGT
 wJWFH8nNHbushshMPQwnX9xMJgy9uVHeEqDbT7gxPvnAkGMBgsHHN5FExIrJfIf48c2Mrxse0FU
 +y2zi67cVwNk4rvTDz5GkKKsZcb/aV1xvO2ZHPV/WqWTLSSdyl68Sz8Nuwz6ddlSlR+Vaiio=
X-Gm-Gg: Acq92OEO+TLqDQkp5a+IjJV4+aeO49eek49coxW1y/ITKY60SAp5LriwBA4+3oKINKk
 0NznVbZTh3Cp4ID+UuYcimc3TjytiWcbLVmCfbDPK0iPbUEMmuE3WTzwWaI6FKVMfympGNdT0v2
 n45ZxdtlUShfHFvLLm5q8fxG9jfWc6OUidGIWEwxjuj14zuk7Tc4OoiblL3k2KUPPc+S7uzvxxg
 Y6xh38+XH/A8Ebuw4nUOEEV7y7nHMbOeZ88f6jh1I+PKr3Z67S/5vXqkY0P8wU3SuihwQPrmZM9
 dbo7L5qxkr0q7GWOprsOmaCLqUj0jHUl8K7/9YzcVIewT3vpLcng3kjFfvZb0u5Q1Gl+sVmyml2
 emkwoJVTI9EknVtY0wESIwq3CeIMb4qZlcZeuiTnqs0hg4uodLXes2u7H0FRVOOhw6LwnQKEcFN
 jtvGMDh2nJ7ppSf/5NIzrRBXyw1c0a6HGNJVI=
X-Received: by 2002:ac8:7c4e:0:b0:50e:5cea:a519 with SMTP id
 d75a77b69052e-5165a002a69mr244016091cf.12.1779141960173; 
 Mon, 18 May 2026 15:06:00 -0700 (PDT)
X-Received: by 2002:ac8:7c4e:0:b0:50e:5cea:a519 with SMTP id
 d75a77b69052e-5165a002a69mr244015631cf.12.1779141959750; 
 Mon, 18 May 2026 15:05:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc440sm3589514e87.51.2026.05.18.15.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:05:58 -0700 (PDT)
Date: Tue, 19 May 2026 01:05:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Souradipto Das <souradiptodas6@gmail.com>
Cc: stefan@agner.ch, alison.wang@nxp.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/fsl-dcu: Remove redundant unregister call in
 connector destroy
Message-ID: <vqskr4uqhd5bfm5jc2hbyagodmcakfqsygipnnj7gfe3srqjgm@kv7jb4hge4ec>
References: <20260518200755.5389-1-souradiptodas6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518200755.5389-1-souradiptodas6@gmail.com>
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a0b8d48 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=gKvw02I0i8aR3cq_mwEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDIxOSBTYWx0ZWRfXw3ZlMKulcy2h
 24R+l8hiOCMZLRWfohxmKbddwRVYq/x2G1mXEwKlR32QvbXTnNjEGBDH/5rAjxdLam07yfTHjTj
 Ef1aty96uOVtrDrvz47CRJc4PG4+oNgKbAlqxrTvQQlurIwZHcSqpFmU1FScJzCFM6xmHAn+Bts
 n3Ho7pZ+ggZGmiMBOf6UgDzIfD4YnC561uI83L4QZpJIccwzE6EoEkHSy6vgzJ5/S6taE0o494l
 qelBgwGc+3MQLREAIiv6re304tIpispUQA2vKkfKvq/UMsK7h4t80fS2pyHzndBT5NYAUbTbrtj
 C2MFcwOybUW5ozDq4NSreky8e3LDzsvS3CfNUhs89RVg+vZzRQp1FKf0Pz71OJhQeVv8JYIOfQA
 U8RbqlPQjRBPqNItM33yoWoLz2gaB2dw07FFZ0JIGRaFhBtbrSN69DkzSoltGEJ9PruUX5QUkv3
 cNPVujQgYRP93DQAExw==
X-Proofpoint-ORIG-GUID: Y7WG0ocTP9Tgenuw4iGv_AE9JPWcsT03
X-Proofpoint-GUID: Y7WG0ocTP9Tgenuw4iGv_AE9JPWcsT03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180219
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

On Tue, May 19, 2026 at 01:37:55AM +0530, Souradipto Das wrote:
> Remove the explicit call to drm_connector_unregister() inside the
> fsl_dcu_drm_connector_destroy() callback.
> 
> During driver unload, the DRM core automatically unregisters all
> connectors via drm_dev_unregister() -> drm_modeset_unregister_all().
> Later, when the connector reference count drops to zero during
> drm_mode_config_cleanup(), the core calls drm_connector_free(),
> which invokes the driver's .destroy callback.
> 
> Calling drm_connector_unregister() inside the destructor is
> redundant as the userspace sysfs interfaces have already been
> cleaned up.
> 
> Signed-off-by: Souradipto Das <souradiptodas6@gmail.com>
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
