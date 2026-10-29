Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4D606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h5ds+4Nz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HRjgP9CM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853D910E80D;
	Thu, 29 Oct 2026 10:55:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51751121E8
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:55:19 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vHGk3825154
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kRQ02HMpLQO7yduLf0Ej4eDHdHrDR4RBPe/ZlU/WyLg=; b=h5ds+4Nz31FxFcC0
 yYd4bs2DRWtngnmfVlkeCjFwPcXpfBRKRoujZxONoZCYvnbEH8QO/v8Op74WGRp5
 YDqqQspGamx9P0rYj9/OQWTlpYrpoYR8T4xxgniSp/FCYc0T09Pt5Dvu0W54xWQ6
 NLK4uoEmIVP7/CZ55Z4HfcoSy4ivMTabaY9N+Y9DcwaUqUucTkP8QplGZkhix+O/
 8J2494qywp9lOIc9pa028aB8Fh1QpfpPdlVuUuCKaRljSN4ErnDQGicHxC50YPib
 BHS2eLk65yJFNPXwSZ6OVdwwpe40qzz+7rNiwBWMIDVz+roM4QrtNV1Uzas4EvXr
 NxM0sQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3j18w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:55:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so352526285a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271318; x=1793876118;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kRQ02HMpLQO7yduLf0Ej4eDHdHrDR4RBPe/ZlU/WyLg=;
 b=HRjgP9CMp556fMZ9zvBHguP5PJuYkYQKTI4PZ0HINzfA/yEpTyM9gZZOPMLINj7kdq
 +8l8ypyGAs4CL8lgjktMms7rAHOBjzQLvlE2Qyc7mocQuid92IqubYn0J4uy6wFMxzM0
 Lc61Sibr0+UbgYqrIr2UkSQJr00fiCajk5Pmkf0BaYK9txVC12++U/cHDnwxfYKxv+1S
 HRJdqsT19J/re4Q3sSAUttWE/9iUCA8fhnMBlBloRavhg88Y/dvq2jJ53GDuEuEkqZO2
 NpX7saTvJ30VBKcE3RS8+f/uX18qYAN8xvwh8aqxW/GFLMoRCKREcdhQCy7MFMq4+CWJ
 zJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271318; x=1793876118;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kRQ02HMpLQO7yduLf0Ej4eDHdHrDR4RBPe/ZlU/WyLg=;
 b=dVAX9SBStjvBXKrSFUH002rDzy+Ni6UrxM85fnjjgUJ5pJfQn8B7qAK6xSrPHq2Wux
 lea/qXy06B56vY0085vXFK6CSchge2CzVztpu13ecGVBtmv8qw7HMQPW0MtnWfpTdT6x
 OST66po+N3x/fIEw/jk3th1q1UifR7OnmmU5SxDX/3vTaILs0Av1qxLzsZy+v9imtZB5
 pOAR36/aeKPsMBcZ1VtBOUYsKpihV3Ue6w348rFWQ/Tk6qiIh7SDXeQc93r0Im0DzvsM
 gdMgb7FFN1UEpze074SThofjKqRFLUQ676NwS2Gmg249S+zp7lsSJdFlYXYlaX5sAvTM
 syeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztz4KqfIf/tMRIXzd2yiBRkEUnqzbGPl8loQUN8P69Aq2+heo01epbeD33ExoCEahc49NogrpMaEI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI4DBbDWsN+hfg9ne5Hj/hMWLD5SFPPAgDRkcmg4Pnrk5Ldx+0I
 d4IoXqmd9P3SepAnKN8T+GiutoZ3ytLNlPiKmwWZlML5R0vh4IrDQY7R0El8DGNO3gVlQB2td2Y
 ieQ8Fopk7e/CMBmQbqh9p0rlD8lpyZIJBtOGCv/KouWRkGGXEKjKGTUuUNh1K7C1iog+BFoc=
X-Gm-Gg: AYBFou02wlpIr/YI0SkHNcPSysPjNbmIPUP3Gyd38gEvMmJvpH+17LTnN2Oq2l4iW39
 /4iaY1lnav/Zul8C/WdGSWS7riuEUQzgUU5zfAXBp7sb1T5FdB12jIWROkeQtidCJuhAbyPBXNI
 kfKK2HAInmZs0l0xd2FXXTzqAbYTjP5fzdJWeSLneASOa3/WOrSTiVWM3l5a9Nx+tD5i/Ac/A70
 YowK/lZitXIsfhRVJb29VbCnB8uZU7VroJnYzqTN8UckB8L3zy5P+Z3+W0i9396BywxB6iZJ20J
 idCFviuP0eUWdMhRiGHWoVzzaKKV8prdrOq5cWI2KLUlZKpu9G7mt7El05nOOWA/Een/dwZPBCk
 Ku57Vkaycq0EYIf/hVoMBd5WJQQddRvzvfagBAUexSWzEXMvxgnokAKpdjLGuMwnwjnmO/+bC1G
 0QqZ4rurRU8x5IlA9/SyHBvu1p33SJQDnTKyaZBnPdzNONzrYJI1lhKMjKjLbQpBCckpj8xoO1Z
 Z7ksjJRzlHh0D0mYQP7/IoBlrJP3zG+qh0vhPcC3Qg=
X-Received: by 2002:a05:620a:170d:b0:93e:c691:a1c with SMTP id
 af79cd13be357-94408d45cbfmr723009485a.76.1793271317924; 
 Thu, 29 Oct 2026 03:55:17 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:93e:c691:a1c with SMTP id
 af79cd13be357-94408d45cbfmr723007085a.76.1793271317256; 
 Thu, 29 Oct 2026 03:55:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:8e96:3679:b9c:de47?
 (2001-1c00-2a07-3a01-8e96-3679-0b9c-de47.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:2a07:3a01:8e96:3679:b9c:de47])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c49d0734d9bsm95378166b.41.2026.10.29.03.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 03:55:16 -0700 (PDT)
Message-ID: <646b3a89-0a7f-4db5-aea1-42d1f066b4e8@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:55:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Soften no-firmware message
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029001601.82269-1-robin.clark@oss.qualcomm.com>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20261029001601.82269-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX/o023B/l55Hk
 nvKPgxJBDPwrm4ugqAee/SMKX5wv9/1bYmh86ULBwvRjKtuVV6vwJ4Ha+ZMlwiXG+EPNOVj9ZIt
 h/X6wb1VTZqrYJJb2B81Osk2+IdUO3Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX0YGpNQrfoFox
 koKpRH5cybxRRk4Y+MZLgIqn/REJlheiiE12rhJyDF1szRKDx/3DthyppGW1+vg3coxpQAdRfkd
 gwYkHLKodNZyZ0mEOnxdf7Sdrsh61JiE6XsvTuAXpIYsBgZ17BZFPO8jFtxt5eUHJ8ykt9LWOZK
 IhTqDHF+YvVhErw8VqrNyi1YBUVZvjlYacWDJNF0CNeVpBQZeImHv0oKlfO7Z94RfswsXXXtjYi
 y/PbKvYID2E5y7Gm9SWLhNoRPZKL7bzqdv9F39n28wZJBQPPBH9wcOZiI6IE8I2MfGuGu5+Ifz2
 k5ym0lYMy0ulcQit96V6E28fvTjApEmst8b4ltNbO2h6Ycr8Kw9mrsa8KPtkRn7kyk0N7yd9R3w
 OpxvbndYhFrtIlnRZ/hN+g6UZTkhvDnSsO3oB8xK5QHws8NXLWlK34y7YoMdZ44La56nnfgaMxi
 AOcWtzGBFaMzP1Cz76A==
X-Proofpoint-ORIG-GUID: l1h3CWQKxy30f_grkqB81VwWsdyNRahJ
X-Proofpoint-GUID: l1h3CWQKxy30f_grkqB81VwWsdyNRahJ
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae32617 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3MgKiW-6PIQHAM_P06AA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 29-Oct-26 1:16 AM, Rob Clark wrote:
> It isn't _necessarily_ an error, the driver will try again each time the
> device file is opened.  But if you don't have GPU fw in the initrd, you
> end up seeing this error message at least once.  Which seems to confuse
> users.  So try to re-word it slightly.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans


> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 5832dc25d6bf..6db6cb7eb287 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -558,7 +558,7 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
>  			adreno_gpu->fwloc = FW_LOCATION_NEW;
>  			goto out;
>  		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
> -			DRM_DEV_ERROR(drm->dev, "failed to load %s: %d\n",
> +			DRM_DEV_INFO(drm->dev, "failed to load %s: %d (will try again later)\n",
>  				newname, ret);
>  			fw = ERR_PTR(ret);
>  			goto out;
> @@ -578,7 +578,7 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
>  			adreno_gpu->fwloc = FW_LOCATION_LEGACY;
>  			goto out;
>  		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
> -			DRM_DEV_ERROR(drm->dev, "failed to load %s: %d\n",
> +			DRM_DEV_INFO(drm->dev, "failed to load %s: %d (will try again later)\n",
>  				fwname, ret);
>  			fw = ERR_PTR(ret);
>  			goto out;
> @@ -599,14 +599,14 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
>  			adreno_gpu->fwloc = FW_LOCATION_HELPER;
>  			goto out;
>  		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
> -			DRM_DEV_ERROR(drm->dev, "failed to load %s: %d\n",
> +			DRM_DEV_INFO(drm->dev, "failed to load %s: %d (will try again later)\n",
>  				newname, ret);
>  			fw = ERR_PTR(ret);
>  			goto out;
>  		}
>  	}
>  
> -	DRM_DEV_ERROR(drm->dev, "failed to load %s\n", fwname);
> +	DRM_DEV_INFO(drm->dev, "failed to load %s (will try again later)\n", fwname);
>  	fw = ERR_PTR(-ENOENT);
>  out:
>  	kfree(newname);

