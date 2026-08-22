Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61832C5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 08:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9426A10E3B8;
	Sat, 22 Aug 2026 08:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GtebiucI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrRE8PMN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DA010E3B8
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:47:30 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67M7xaCg1699068
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=N1a6O6NjEytK9hJDVGVFUwws
 TOE9k37COwvFoZAH3pU=; b=GtebiucIfO+H/berbPBi8ULD2hH0u6FlcV6SMY/z
 oLoafysEMpIDs5HyxNDCa2ATD3MXPi01sWtrMJIyVTD+Pnrjy/leURlA9T2Zi1YQ
 htnxzber9vXh1xwGnFDxj0C0vzS9HNY6F6HWqHJITmDhz32Yhdi6iNnMPaq1qrob
 XvB7m8FkgHgG3OIuyltRLQUyyNuUvSgsbp0Y8oKQO2FCU9mOY+gZHLCQyvPRlx79
 JfFMr5dvgrCizOi1qAU2Q/BLt9ZWmvqxRpumex8PrwHc/gALggR80TgMSWE4t+Ge
 cAh9XyZ+lAH7XukKu/jkliW1GG9qColUnG1MGHbUoO+3zQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g743xgndj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:47:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so178887485a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 01:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787388449; x=1787993249;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N1a6O6NjEytK9hJDVGVFUwwsTOE9k37COwvFoZAH3pU=;
 b=ZrRE8PMNWqvKYcoGmt3vDnyGTbGpeyACY5ewbLlkqTGxjK2xNloQ9FOFbe35HhhBWJ
 bkanJrDG8oWCnG9j02l6nAOc3jrxUp0Wg8RMa0bs14cYwaT+xeg7ImqKtQsox2C1QQlQ
 CX45Y+NVN5H+pwgwS41paDYrm/y97hpkmkkZ29hd25CLeWM8vNVP3DU8Lll3+UTnZUo2
 ZdkoslELR+HfjkuIp0d8mS9vNNXnj9V9E80YKgFHamxiF6xE1likSNhyOSoGIyLUBR5u
 qrEM0zAPVmTxpz1phlXJG3edKBZnYvVl9hYBZWHrZpsfWAb5oLs5P5DQAfguHOFh3tdZ
 vrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787388449; x=1787993249;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N1a6O6NjEytK9hJDVGVFUwwsTOE9k37COwvFoZAH3pU=;
 b=oI3BsBaGOWMKL+Vdj0S7p4MukDnmMWMVQuSQF0UaWYWjZQc2xpQWIIy3ks6RClby2D
 4zcD95i7kv5HeCbFg1aFrNjp6CHX4mXjU+RUP+SPGpRcJzQMBP3n3eV5O/Yv8mE5MTuw
 SYgm0wt7A9Vwv7HblE+LMm5PplFJAjzz+/vrKRtbEZMPeFwRUryH/rnTYUvPXIg5kAQu
 yUDJcgk10wmwEPtQW1J3oRQXv9HeFPXI1DqHtsnf5KGXbKQQVE4qgTLVvQSjDkYt5z5F
 Vw0n/0PUeMzLPCIRkJPgewlwGVWAPuLLgHAGskTO7m/qDB8lCQA7jyDXoYUqzKL2mdFS
 jfog==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAJD4UENP4k+NP5traaxVty5WA3gOK6mDP3+S4WSjY0UCeU9HCBTK3NEP7/VhA/rWjSpMnH/z5Fcs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kE2xAEeE3ZxyaY0nCtblLaedty+DcD4gSAtY61TryyLUNAf1rK
 pq07zjW6UtC94aOkNAVOPYAb8+9EOuIoXY5v0Eq17vbqxhJondIyUe6Q8xMLFnNcEVhtUVUguWH
 q1FrEkgPO8y37DxzM0x6L4qoIxSeKunsVDMjbA/w3qb/CSmQwZli2nXd6Y5fq9vXwZ88B28k=
X-Gm-Gg: AR+sD12IYq4JX/zIncwYeZ5RLIwoOV+dK9wNrGZIamGqHZ3JEWodSuV2ZlEkJs2acKd
 PJSWa/fmCsGbQtHTqmHRaxrK8nrqHFbHdi6/TzWpGAq7w8YkjRPvEUCEv9W1SDA6ej+C9CR1uWD
 m2oIG3XVRzQZ6nG6QxkoiIeaWTRgBOWzmlvnMKPHmQ6zt/D7PwyieFi+09Gy+5oWGDH7R4Do7sK
 jUrTIh0VwVVfkqk0h+CzBHwTeq9R6V+6qd4lGnpKXks0x5WbiI2xIt1V28/zzUMEbCU8cZhXl6d
 qUr8IrhGPamHcm7ZLJrTLz+saSTBaMfPHwBhMENaRkeVOoy1utyDN8dJ/UzqJE75z9PTcUVs1uJ
 Z5u9Dz8IRcX4uHkN5+R7P7VnjmJP2VG5MGGlj9Xj8wMec3yENVfVSAhjD1LBhY5z8aoT+LjGs54
 ZYEzEYaOM+ekxp
X-Received: by 2002:a05:620a:1a21:b0:92e:f3ca:2ec8 with SMTP id
 af79cd13be357-93739479916mr999605885a.19.1787388449141; 
 Sat, 22 Aug 2026 01:47:29 -0700 (PDT)
X-Received: by 2002:a05:620a:1a21:b0:92e:f3ca:2ec8 with SMTP id
 af79cd13be357-93739479916mr999603685a.19.1787388448685; 
 Sat, 22 Aug 2026 01:47:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c2e87dd6sm3030581fa.13.2026.08.22.01.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 01:47:27 -0700 (PDT)
Date: Sat, 22 Aug 2026 11:47:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 69/70] drm/atomic-helper: Remove
 __drm_atomic_helper_crtc_reset
Message-ID: <a33duwtatr426bccqmvvktswpg727cjjhnyvzgqjajlazzducr@jxz4twrkwuxk>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-69-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-69-fb793475c05a@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfX/S2y3WVaK3t7
 ioi8YkdZwKe71G7M3V2aVfL5SL0LrcRv96dWZtvRniaTAMQSAPp1PA0U1DojFiFvuoB4ocztdT1
 PL9C/jT9AUBD3neP4hvOh/zOdjPM6jg=
X-Authority-Analysis: v=2.4 cv=HYckiCE8 c=1 sm=1 tr=0 ts=6a896222 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=QKIOgcZmh-SpJuLugV0A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 4Tjq_bqrffg85G9Ni8WpxSKOj1-K2-mY
X-Proofpoint-GUID: 4Tjq_bqrffg85G9Ni8WpxSKOj1-K2-mY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfX9A5jBOLz8DCB
 +NszApHKunhBmMKM/vM/ulJJbYX5MolshRI2tTANkwsmONxfciCBFRs/AjhEKLndHIKTh15tomb
 MUjCqWwP+AqxalX7OT6eGt66DIo0k9925DixGaBUAZdkBcPwE0OGZwbe0Jb3c44gJ2okV71IYMt
 8YnhGv+fFKAeap/jveQ+dqa/0BWcth3QyCrbT4yYgLM6TmPNLv0RYGUN+nS2ssR+2bmGAyj3U1i
 EMZkL1g8TpedVgGHkXdgzgzle7CiPamArfkybgDZklMA6C26KoEvW/RNGlGZxWo18e5g5k7/YfF
 REBhGk3UCTbz5X+RJ0WXbnRpJ5FNZYGvop63k2o0xwmxqkJXTWTwxR8JfaB7MQg67I9ltioBKJx
 MxS3SuTJ7c7iT70vcHzDC+LmstDJr2CrFGMB/gM10BRQQp6uW0hbyj55hD2nMEqOe31SFS4MUla
 1DbzicBvm27/DhApzhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220070
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

On Fri, Aug 21, 2026 at 04:39:45PM +0200, Maxime Ripard wrote:
> All users of __drm_atomic_helper_crtc_reset() have been converted to use
> drm_atomic_helper_crtc_state_init() and atomic_create_state.
> 
> Remove the now unused helper.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 26 --------------------------
>  include/drm/drm_atomic_state_helper.h     |  2 --
>  2 files changed, 28 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
