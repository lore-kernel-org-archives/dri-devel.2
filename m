Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA3AF4613C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CBE910E443;
	Mon, 23 Mar 2026 21:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrFNjCMW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SU2XXY6R";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B2610E505
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:36:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqXVn362508
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bH91rnHhml+24JA2sTCrFNBn
 4S5/j59oXFJDm6t9eEU=; b=KrFNjCMW84X/A/rpvVLDVFYOUkprYc46K433EJOy
 00GoXVHLcpmZ4FEfAieTpL3dZK4s/wgVdC5ta2JCcQKix7p7s6PViifJ0jmOCrhy
 wQDGUzDIkqZCx01RY8jul2iqPypjp9BX/sZBXFxYljw7ekFx2DrrlIiX0SYPwMCV
 6so4mUzKW9mhkVH+sEKbtKEAcOvt9KczUh78UHdDCfoQaFREGRsWZn15zWFKW1ch
 e+lcgz+aUWtPdP4olkTmYATX0CXH9QOgJHEojf9YjhAoh/lk+CFeiLBrUTF2iZTa
 /8huyrQYU4xebz7K3QwRFN4TLat76ACH0AERNl9yoJid/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k3296f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:36:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5093787e2fdso148734111cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774301792; x=1774906592;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bH91rnHhml+24JA2sTCrFNBn4S5/j59oXFJDm6t9eEU=;
 b=SU2XXY6RSaDzVMfgZ9KUyA/HO1vm1iTGcSunvPqcjNhn6E7UZXG0N4zHsmXO5Iw10C
 eJfgTyWDbwLMfHAJamV3AyZ3FShtvBZtTL05GgT4qaTv4cWAYCt/SWCH0CE/Y6Fs0fGk
 97w45BIQPO6h+gSenmAuRuBr6QoaVIxCtpC0s4VQui9BmPmmVSp6j2V8iPYFSxWaIYvm
 4ESMM38LFalN42E/Ehet/JeygosbXqzJIDS1HrcpWDOiC0QGvOmPnyFUTEK6/0AtusoC
 cva140jQi/GsG9rUejmGzeeF/VVFWGMzY4zyunSJkDNeUkkHGLbfQP7cKaAVCI4S9g9t
 e6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774301792; x=1774906592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bH91rnHhml+24JA2sTCrFNBn4S5/j59oXFJDm6t9eEU=;
 b=h8hb1DYtLTCt+K6BRD+kcC1pld3KTEROQArDvxuJvlWlbo+wmQdXhc9OvX/ifimcUF
 MCBuri38u3YFYUedYtUagnRVsMvJP/qj47LJLZtf1QSs7CP9yWYncszmuVcZoQTu7BAN
 iHr+QIFTnhagy8PsDvnebValzXfl8aWOY5mmocHqnUvUxjp7RO0+sYu+G8qwdKFQzQg5
 nDzC23v19rE4ekNva+UOOqIml4q+UARt0lTojl8mQIr97tsUZuuResBlp2BiXy1BClWo
 q2WbgP9w3EhfJUOFlpZKr1LKE37OqCWpX8Uws8W+dDzMujO9G1HV/ZU+IHat4NUG8N7+
 WgVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW65ARc3HxFl34JARuRuhHISafHICC/LmfMA7Kc8p+d0znI1fBEKn/J7LohQwxsFTtSRUCHMvcdfw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yykm8dlvNe+nTgiWp0XwyWH6PWwEGxGzhmCE5lOZcxKrQst2j43
 GCiYJhLuVmQNQkj/wgO5lxZrBTDxZCozdxP5w6t7gfu+tRlGCLrsjUH6bBDwIfTh1BJr1YwIFNK
 suNAroK7lmhfXNG0rmmbY84Grm1X29a8X/twQs/u605d/0KiEPJ/oYV4y1ak/A9l2L09o/EU=
X-Gm-Gg: ATEYQzye5SnSjWFk89QyVZEFbNd52NYcaw5eKFZbocdeNC49k7gWzEkIKdMXYs0FSMo
 i0IoPX/u38LLUtBwuhEoKVS+of3g6J3EcRNVJk/rHJSeOKFcGgjusCvDI7y3GFnbLVYE584JL97
 Qao3JznbAahbWgYh/iI7jiaQHEdt4m7XA2eHQZq+9qwlM+45upUMXYCj3lDhD2OuivXEzrok2tc
 qxcKLB9k2yXG4Y4O7u98RPD98Xbvf6R5VlXqkhC27MBCCutBaGXCuY5hyo7CqV3AEh7ujtHErF9
 sflCnqLaXe966pPrrCDC3khIb2h1iTt1Rqqef2V/L9vgm8qEfP/7tOHn5LkV9OpfgrQzS2GlQjG
 jhncPjEbRgsk4TxEZpzr0Qz1EHWvchZkpIA5p4cdOnMSLaGD8PtCOWCxPHUkWhNKH5cuYqAA=
X-Received: by 2002:a05:622a:1f97:b0:509:4198:5474 with SMTP id
 d75a77b69052e-50b373c2322mr215964761cf.2.1774301792082; 
 Mon, 23 Mar 2026 14:36:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1f97:b0:509:4198:5474 with SMTP id
 d75a77b69052e-50b373c2322mr215964361cf.2.1774301791642; 
 Mon, 23 Mar 2026 14:36:31 -0700 (PDT)
Received: from umbar.lan (87-92-245-163.rev.dnainternet.fi. [87.92.245.163])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9aa3575sm30587691fa.30.2026.03.23.14.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 14:36:29 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:36:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] drm/msm/adreno: Expose a PARAM to check AQE support
Message-ID: <4cj3yheakuxh75hf4r33ukokswa7fbr4cetezrj7mujb5mcxjl@fqoek3yfi6ep>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-16-fc95b8d9c017@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-16-fc95b8d9c017@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c1b260 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=+WgfKLcscl3VAWRHYO56eA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=fNwUJo4UZAcYs_Yiko4A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2MCBTYWx0ZWRfX4xjPbVoFaPui
 QzAqT1hbtjGcgHXqjvPVVoLhrBA72nZd5yXKDglVsrOfc9H7SUiMnCyvppIDFu+9p+1mSdJ1dMv
 XNRwAnzi2EfGiMIdNxl4gC7aK8xXH5wkHnspQ2V04m/ttky3HckWx2RceVsaaZHxW/DspAtJv10
 aT/EmGXG5PwAjTEesVcc6f2Yb7gOzRe3SMmcr+xj4X4wIptUSIkPi0I9bNOtwItfyEP2Wyr/pvX
 ZQDo3PmVuCRaAUYNd844XjATcQi6Wo++JWImunl/UqO5W+herl0x8Rn0CeTQIfTlNneJuJZTX2D
 ZstSyXaU2E1e9W/Jv++QObgi6f1gDHVldLibmD6toReCFaQ89zwBtHNE2t9ewJ1Eml7WZLlAIM/
 hAZSP/nuCJwnHaDKvsifO8DGFYKrLAtDBcEBP5lIfrx36g6X0nKhGowq92oTdhIhyAq+ExnSKbL
 /eh1DKiFYRppPAN9QiQ==
X-Proofpoint-GUID: jlzkjkF5BO6y3b4tyjGFVwKarJLnmFYr
X-Proofpoint-ORIG-GUID: jlzkjkF5BO6y3b4tyjGFVwKarJLnmFYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230160
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

On Tue, Mar 24, 2026 at 01:42:28AM +0530, Akhil P Oommen wrote:
> AQE (Applicaton Qrisc Engine) is required to support VK ray-pipeline. Two
> conditions should be met to use this HW:
>   1. AQE firmware should be loaded and programmed
>   2. Preemption support
> 
> Expose a new MSM_PARAM to allow userspace to query its support.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 13 +++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  include/uapi/drm/msm_drm.h              |  1 +
>  4 files changed, 19 insertions(+)
> 
> diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> index 5c67294edc95..b99098792371 100644
> --- a/include/uapi/drm/msm_drm.h
> +++ b/include/uapi/drm/msm_drm.h
> @@ -117,6 +117,7 @@ struct drm_msm_timespec {
>   * ioctl will throw -EPIPE.
>   */
>  #define MSM_PARAM_EN_VM_BIND 0x16  /* WO, once */
> +#define MSM_PARAM_AQE	     0x17  /* RO */
>  
>  /* For backwards compat.  The original support for preemption was based on
>   * a single ring per priority level so # of priority levels equals the #
> 

I think this also requires a version bump in msm_drv.c


-- 
With best wishes
Dmitry
