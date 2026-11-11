Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278A606A335
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L7OyFM9M;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eQoEosry
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFC110EA45;
	Wed, 11 Nov 2026 15:49:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8BB10EA45
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:49:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF18Am2115529
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6GnlyLNGY6NT+GSUapR6x1kG
 ipILRzIEm/U/49m1Jx8=; b=L7OyFM9Mc9v8R/qLVa0eB8IM8QxWLQnjY8OwAkGo
 O9WI6UGgHPN5E0wYHCI3bgxOt70kwmpuNNT+9MM8kRTM+DqPkIyUQaKv3+ibjOHp
 +xSPEagLmih/Xq1SKjNoBPlgIs7wF9x5FF+OBizABAcKLaK0D2A/sM6ofKybb6XI
 dftwV/XkDngacTPZ5TRD3cFh1+o49BGUmvfgqNs53K0VMroqbMpZcStIIi4DQIqM
 jiaPepTBxiaFZf3/t+BdZ7/YD4cKsuIjzNO2fJ6rVH619iLpYYFzEcOLcEMbsstO
 lPWqUnmQ3Jybf/B6pPKyvw3EbPpVx3malsXcVl53bv5ztw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawjv51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:49:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so841805685a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794412168; x=1795016968;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6GnlyLNGY6NT+GSUapR6x1kGipILRzIEm/U/49m1Jx8=;
 b=eQoEosryXSqxW0h8v1AhPTcKAllJXyH8dvJ2kJd6Dkx1jcb0HNe1U9KSp/O+H7FUow
 c/4erylo1mo4Z0WnXTfOEqFwnjxOkxDlwtLYjSo+KlV1Q2coOqHNyjzZpjKH5qjNwX7n
 MvuFMUZeewiGfaXnjDg8R4joCX1nnAXOGul9JIzG/+EmISveXz1Q6KGyFIDt3iLl0mDv
 109J9daxJeGjomei//VdW7RvksUjJeDvHYkNaZum/LDpJikSZt1YkhJqNk71hYSKsX8a
 8PzQ0wwTpvnkJ3PFzMeVA2fOyQfcF628AtBO+sO5ge4Hp9GSOoyPboyuvpM4PG7mabhp
 MQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794412168; x=1795016968;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6GnlyLNGY6NT+GSUapR6x1kGipILRzIEm/U/49m1Jx8=;
 b=srAXcd4l8WlJuGX+B499IHrUjQguT2Egs9O5XrUknAkSW7eqVr6Zzt+lGq7KCUOm+g
 mH+7931JV2JLCSZS9s5RQ+zME985D069UvlOKB2ntw62NAbsCLT5r/VV+s3YXHaskwur
 O/u/rt+FsWuQadDb+pM/GJ4doI1vlz3rpDftXzs3Cu42RN2vAEgydcrgTtafJqdXbX/J
 zV3eEqODuS1vRXDpVmQlCSfz99BAkKUR3a0sX79zEvjKGb1ZTU/GFVCtdGJRyPnV3o7/
 00J3YO5+/VqCvl0e4RsI9qGSVgkWqqkxa2brJNikKfBLaCsmjYrykaAv4soVUJc5aTrb
 CejQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGl8PKtncQotpNXJ9AgpNyjq6CKfec2Syfn2gwl1HVs9NW/GLpmQ4QFPhVhWdN8EsSgJ7rlrpvwz18=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z95OstufWDr7kXda/KsOOhrst4ATcDqd0fcY3EqW1xnr7eZOhUp
 MCv6HBPfGyoviP/4LresBXpjskIEH99OqLHqUeYnwvOZynFCAOiliGdZSyG+YzThXfEgq0ifKeL
 ZQFn5iGcvZZmDLxDth/+a+AtA1WrAsIpaB8jagWZY76njI38bwm/V45/fMSQ7qx/B/uR1sd8=
X-Gm-Gg: AYBFou3ytQuvPPBZ0hXI3v1hoAKxIlR/fgNnRXHc8rQyTtukXPCoK0JC6i53tM2X0VP
 TMS2wC8/8q39dtAOd4Z7sAyY3xUhnOYlMEXhXgQLLbvKkNalZCUgK9mT8/bJG8jrud8pxK+QKTN
 xXxl8zJQLRsaXAwbd0FlWHbIG2k98W4y9BZr5b2YMxvMhWiSlAKfUtdpDMlnBon0eZ+UY1dcXQC
 zrMp7JEP6q8jaqusrDZV8KZ9DHHtNocur82MTkE45Kmy76wx3RcgKwXwKvzqdif0E3hc/GIpKwy
 lggzhRMd6UKOAZiUYDCxnWFlVCsRr+VUFyvU2s/MlejPaP0xVFd8xt8w7r/3epfKyZNh3t61KWq
 rdPVhqVte/Sk+jThvaIQ4Uh9kmGFyn1KIeQKJY2sTftrqI5zL+G6CJHO7vHOoFfLsvlxDBC8HqW
 0vvdVqbIn0hGJicc5q1kDQ6rcow8Ua/WRKM2gjXM5JFUZ5/80M8YvCmbAJ+4PYSg==
X-Received: by 2002:a05:620a:4449:b0:93c:a468:2db1 with SMTP id
 af79cd13be357-947b001c81dmr448432885a.58.1794412167918; 
 Wed, 11 Nov 2026 07:49:27 -0800 (PST)
X-Received: by 2002:a05:620a:4449:b0:93c:a468:2db1 with SMTP id
 af79cd13be357-947b001c81dmr448428585a.58.1794412167449; 
 Wed, 11 Nov 2026 07:49:27 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157bab78bsm1006942e87.38.2026.11.11.07.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:49:26 -0800 (PST)
Date: Wed, 11 Nov 2026 17:49:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fabricio Akio <fabricioakio@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Paul Sajna <sajattack@postmarketos.org>
Subject: Re: [PATCH v3 1/4] drm/msm: Resume devfreq from each GPU's resume
 callback
Message-ID: <wivdiwqd366ucltiodaldicdc3liy5smlidwl6ysma5kmkyee3@adxian5nmcch>
References: <20261107-a5xx-gpu-pm-v3-0-e2480408abea@gmail.com>
 <20261107-a5xx-gpu-pm-v3-1-e2480408abea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-a5xx-gpu-pm-v3-1-e2480408abea@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfXw8x55xO3Xvsd
 5fGJ5IeWsx5hiSLHtZajoAvvLyF+ov8XP8guOzjoy9frJ7IF5DFfJAQEEarTz2yP/DR/UZ4tWPT
 77HZ+sxL/r0bpzNHkyE9vgUP3KvvzD4=
X-Proofpoint-ORIG-GUID: _wBPg138r3q7e17jWOXm-7gm9ybN179H
X-Proofpoint-GUID: _wBPg138r3q7e17jWOXm-7gm9ybN179H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfX/KY23h9/7WhG
 h6AwiPwiJAXeNNXQv1UgGZ55srPU4zeRs79PjRvDwKsjc55FXvkt0y/QjBntnnmehmtg95QYoXt
 QCmsINO7FILQjkgM6KiRT6GLMnxZ+GMBb/i3LBN12VdkUUc9Bwz3CxVgPQkl6CLULgS2/+xdb+o
 T8UO5beCWiJNfRGC5LsPQMsxCz1MrJ8W8KQct84etRLVdiPPhyKAp+BHZ3IPSSNXO03hl4lEZ21
 0wfXgrG8TzuRdEQIHTfKr5jqdLFeWrVYmf0Nh0qWLCnXjhx4e6jDOLxfsJTJdh1hGBAlSsmWwyG
 PQ6skuGlfvJajowDCFc9D/GQYY731MpIuAhPc2TJFyLr0KRKYhXurfWdDlKul00D6rW9tjeMDOY
 OEGW4PuAVZIKo4EHLENM2e0z042ne2+K6Xq5sMFmUn6GeROpdBYrHtxCIuPLvZoCXJFtp2LLVJO
 G7eCpAP+jTpltAviXqw==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af48e89 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=gKfNi3ubWl9wpb68aOsA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110062
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 05:26:07PM -0300, Fabricio Akio wrote:
> msm_gpu_pm_resume() resumes devfreq, which samples the GPU's busy
> counter as the baseline of its next poll. A resume callback that resets
> the GPU after msm_gpu_pm_resume() clears that counter, and the next
> poll then subtracts the old count from the new one and wraps.
> 
> Move the call out of msm_gpu_pm_resume() into the resume callbacks that
> use it, as A6xx already does, so that each GPU can resume devfreq once
> its hardware is ready. The A3xx, A4xx and A5xx callbacks call it right
> after msm_gpu_pm_resume(), where it ran before, so nothing changes yet.
> A2xx has no gpu_busy callback, so it has no devfreq.
> 
> Suggested-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
> New in v3.
> 
> Tested on A508 only; the A3xx and A4xx callbacks call it where
> msm_gpu_pm_resume() did.
> ---
>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 15 ++++++++++++++-
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c |  2 ++
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  2 ++
>  drivers/gpu/drm/msm/msm_gpu.c         |  2 --
>  4 files changed, 18 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
