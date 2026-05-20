Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4767CCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A0010F066;
	Wed, 20 May 2026 13:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JOB67p3h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4c9E2iU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA75310F048
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:36:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9nmZ2447958
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DJ6h6DRsnqQDPyi2JxuOi7VJ
 mjKcICPojxj2bNCngiw=; b=JOB67p3hSVJLEAa1bLTVKRoF6Wg24jsZ+EX2ovBJ
 AWNln+pfEJNnTzVpzOChXvk6tOw3ej4x1prWgsFvZys7/tz/gcDwQxNg7ycY1Qbw
 W3HQqWWeT1IXZ5mSs5DwzmYGO1Rsp0v9Mq+LRdE6XFxI//TuwllEKydpbIQvUPQV
 q2kf3gZ2MZaB/1Hqbgb/UGOiQ2CoXAPpWqrvlk1R2Ckodt6Zdtcv9b1IJBHOj2Lc
 RuebvKfSWXgi8CVGtCE9rgn5govv1ecCeoBtN4T4IMDsLSu3PeHRaXSIvhc8rakF
 Wg2STPcmHc2fdNW6Vt7a85rJKno8rXk99G4z6Vk1VPZYIQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrgtr9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:36:51 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-63146b7289bso13837649137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779284211; x=1779889011;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DJ6h6DRsnqQDPyi2JxuOi7VJmjKcICPojxj2bNCngiw=;
 b=L4c9E2iUPzyFwA/3GgJ17bTRNTdbXXWKlFHHfona+Tu7ZNr2b4KpZuJM26CK0eX+Nq
 SdIB9hFBowqyBpbb/uwUEJEUfK3szTREdk24uk2IcbyludLc1hjoQSVV5pPzpCulz5ZK
 KwlFoJul5decrHAotYHWixwtX7N6r7Z4RNAT7FhfBm+ymfxpc4zzSxqzCcFMIKnAvcGy
 VFcihhKodQyM4LEChcDKX79Axro2OM1+diSCt4mPrTXRqeu+C0GpC9RC9zplteEXdjwa
 snMRDRH9YD4UqLFbBHE++A3jTao7ItEdlD6pQ674wuGSFhgquth/59HnxHcwYjCu1ZJI
 prWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284211; x=1779889011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJ6h6DRsnqQDPyi2JxuOi7VJmjKcICPojxj2bNCngiw=;
 b=i3HceLvbIRXEizobolG0vZxIL9Y0yiYmO5NQdmoGHX6xWk1lmniCNnu8v7g8RZUUUk
 YWvAFhd5S4LWqaVX5lR36VtoIiUHx5N3QuIVXOWN+KEbD72FcBEJTQ2fAFSunFzNNgic
 DQm6WmHIHxIfaxTfEHLbJooDQfslOuyuLinE33zdLMV6nU+/IFPv0XxswsZb9b5rJrpc
 I8LB+MzGMEuggWxBSG1E2LdKyDfCm1dPTj8pSRejdid60LbR4ALmnmjvVHZMYSJ6QaCi
 iRMpd6wKuRQp3OkVB2fKsOLLDejl73hBAFmOsFXLWx5s3DlAQscyL6uGTpwj+ZqW7YUV
 ImAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9npFJY2iRYIXB0bNDAZu39YRB5nlO2lUQMUt5flGC4rgxEZ9Vuuhpf33H3pwUDpRU//LwStP8tDCU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGaPr1opptVSjbFQ7Hu9MgiaRBeu3erEzT+EhqVDFP5oTV7SJV
 DxjhHWiPyKYATEPU1tcLeV5cUPK746z0IH+YQ72RaUbxr+3seD8JSbQ2Uu1Wqo85e6Zs3iVWCAK
 Up9aUyBLSiOZXzRnaoDfJASpiShzr59BRtQYRKu4rEo3njnazZO0wmZqnARAjrX/DEs8U5zs=
X-Gm-Gg: Acq92OELHf+MFvqB4be06ReLD88nP2+8CwwQhgE4XGs+ThG4WHPYB5Hjyhc2uGMkqME
 dS+D4Omtlmrm7fGJG0nTYhqI5T0YdKBD+VOCf7FgGFahxjTnbdWkussZhYx8pOHs/VJ0prUOGep
 xNXOnbZLRRYNz+pw4SGEb1HIPIvQPYaIwvQ56M2+/iKH3/FpJxJX7gbd+uGuJO+xwhyN6TJGlQd
 twqpVCLfHi3kcOR+jQAstWvfty/h0doLPdXpLxKYfiGcdMJ41MiWFWShWykf7stkO6TluSh3h3r
 jUiHERxHc/Ow8a8st0nfG3uGNW2IP5T01QnRqyHDh6U7OIIv8KSEQ6fBYqQP1wqyU2EKImEBBrU
 AtkxPKhSG6qt0V7kA1XS6HJXCZp57hVdiOq3CFW6xjqlfDQpiHC3jm4ykiynLa+gPk7g5WrcVnN
 +4y5f4DTsjfX+A+OhrAEglVfJ4frpjET0BzodF49K9esIUwg==
X-Received: by 2002:a05:6102:c91:b0:634:d97f:7ee7 with SMTP id
 ada2fe7eead31-638b566d9ebmr11127670137.7.1779284210832; 
 Wed, 20 May 2026 06:36:50 -0700 (PDT)
X-Received: by 2002:a05:6102:c91:b0:634:d97f:7ee7 with SMTP id
 ada2fe7eead31-638b566d9ebmr11127644137.7.1779284210357; 
 Wed, 20 May 2026 06:36:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395887f7b99sm30026341fa.42.2026.05.20.06.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:36:49 -0700 (PDT)
Date: Wed, 20 May 2026 16:36:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v11 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
Message-ID: <jtqfnly2ma56gbdstyk7exk4lhw5nild57uyokkkgrtnnqqscv@xik2phrs4v6t>
References: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
 <20260520065047.3415790-5-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520065047.3415790-5-ekansh.gupta@oss.qualcomm.com>
X-Proofpoint-GUID: ORFpIb9XD2fMXGKIM9cOftueVdD-wqZV
X-Proofpoint-ORIG-GUID: ORFpIb9XD2fMXGKIM9cOftueVdD-wqZV
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0db8f3 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=EekQdeYcPna9Ds66k2oA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzMSBTYWx0ZWRfX+Tmn4E/1inJ1
 0Y9KSaqPMwTTUokp9Pn2Q6UBosvfd2DINDYb+TPMEUzyNjrds0xQw1dg8jdHgIWeRMRCQbqQBnW
 KVFZ9OOdgaEcfmJVRiXsK1w28PnWaCO0qKYUpfcz2mk5CtYQqXwx7oYIB9aieYM5UjR3FN6EJeE
 j5lnhHuUVMYyeulavDgmbf88mjbbykt459/DrEvsJaY0uTURQdAXqzaAx6PlAmzbAhf1RWm21+n
 l5BwDQ2NdxQBFKuOKrRonH3RlH07iKU6tdqXIcyfFVcuMHHZptLcNWElVTrXy9XjO18gTAW0/Y6
 fJicGUU1NjEioBEJOgGWBNWpfLrRDHQ9yvy1by1O3FUPUgFoiaTpqU8mferL8Y0W/Dj/9cXoo4f
 aJR2GpdcLFE7AD9qpILx6Cp22bmlinM1LDVq8VDmvj9nO0UebrFnB8mc3aeFN+69N6Kz9q19Nc0
 lRypSEc7UUjI/XhHKMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200131
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

On Wed, May 20, 2026 at 12:20:47PM +0530, Ekansh Gupta wrote:
> For any remote call to DSP, after sending an invocation message,
> fastRPC driver waits for glink response and during this time the
> CPU can go into low power modes. This adds latency to overall fastrpc
> call as CPU wakeup and scheduling latencies are included. Add polling
> mode support with which fastRPC driver will poll continuously on a
> memory after sending a message to remote subsystem which will eliminate
> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
> poll timeout happens, the call will fallback to normal RPC mode.  Poll
> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
> request with FASTRPC_POLL_MODE request id.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c      | 167 ++++++++++++++++++++++++++++++++++--
>  include/uapi/misc/fastrpc.h |  29 +++++++
>  2 files changed, 189 insertions(+), 7 deletions(-)
> 
> @@ -1813,6 +1907,35 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>  	return 0;
>  }
>  
> +static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
> +{
> +	struct fastrpc_ioctl_set_option opt = {0};
> +	int i;
> +
> +	if (!fl->cctx->poll_mode_supported)
> +		return -EOPNOTSUPP;

This is being handled too early. What if the user passes any other
option?

> +
> +	if (copy_from_user(&opt, argp, sizeof(opt)))
> +		return -EFAULT;
> +
> +	for (i = 0; i < ARRAY_SIZE(opt.reserved); i++) {
> +		if (opt.reserved[i] != 0)
> +			return -EINVAL;
> +	}
> +
> +	if (opt.request_id != FASTRPC_POLL_MODE)
> +		return -EINVAL;
> +
> +	if (opt.value == FASTRPC_POLL_MODE_ENABLE)
> +		fl->poll_mode = true;
> +	else if (opt.value == FASTRPC_POLL_MODE_DISABLE)
> +		fl->poll_mode = false;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry
