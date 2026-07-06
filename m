Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA0C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3CA010EA42;
	Mon,  6 Jul 2026 18:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ftn284dl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hYsGAna/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E01EC10EA41
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:17:24 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FF6JR832946
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 18:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rY4OvCYsCffCRFkDZOeMjDyn
 E2j9ZF20naZfPki+y0E=; b=Ftn284dlx7W1qaekMaRVUt1wptaRREnc/qGBMP3P
 +7+hQkTDkJcApFiRQi3ibgrHLBP3jVT4LpMMOcAwRAI5Fhio41EeBMLFhIdOWaet
 tIGaRMKTPR7nXWmaiiiyB87dOD+aehGsrjFqX5uCHOJHqKSph8SmZrgLLdmtUsbv
 eS85DO60cfUBqFqo1twSmHBy9QCwOfi3d+rWdEOOQDz/0el+iXGnn+ptGtFuWt0E
 ESiVspgQ0JJBVDIzTnkN9G4kob+XjQKAqd0PXFtzFFCNwmZl+4BU/fWj+XzOpdrb
 K1Hi8zgPr45zxFpW8sAcODg0KIt4pLb93Nn5B8Ih+jMIZg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98j7ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 18:17:24 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5be3d6de82dso235390e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783361843; x=1783966643;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rY4OvCYsCffCRFkDZOeMjDynE2j9ZF20naZfPki+y0E=;
 b=hYsGAna/IdwG04eQ7ob1Yp+76xuh3fRemgzbsuA+4o1wBLaNigIIDmLT5NwMYRnGNu
 /dWLTpI+nOC3oVC7ZXaVuBntMllY1ghh73gFiqUGigPRMvvwHP59L3bT9wwLMv5YRfHF
 vJVLjq5+O+xJEHGWfDDTARGqMicNLWQq+JG8vnO7KTwssKhIoXEEoy4cQRTHwwKaei2J
 yQMvfnkEh12hpjpYbQG4zPV4AGYwYjDlHc3rxm9OBhkVUDm7PxcMgnlVJNOpRnKess5a
 RyzNMTkt99BPhj0q4sqXLBd/s+hlRhMEl7oJMh+CJhL/QSUjm+kMn9izqPBt4NWj6Jgo
 2VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783361843; x=1783966643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rY4OvCYsCffCRFkDZOeMjDynE2j9ZF20naZfPki+y0E=;
 b=Svh1IbQ+ndva/kt6799mdBJPTN4wCGwZqNBy2ijV9jq8l7lis2kCQALPsh5+czBBYh
 9QfG19HPZr39KajWAEY6lhgcITdGio4SUqeT7NY75ZWnaC29XSWepMANaoNQY2c7j2Zf
 V9rUk3JaFjbFZU3edDmK78iDNKGwhMmMIvDWH6s9z1cwdP2eqyxucUsrDm/kqmP0bpUJ
 0iuY+M3IQewiTviOd69nfWUw/lM/hw63arXTKPq4h6VbdVm4ypeT2tZBftNCPS+R0abL
 hPRiUJ8LvLH1oAPbPv+G8Op53tmYH2WDQ7XcmFHrEFwSYW3/6Je4jTZnPp5KWsfrOafw
 ZY3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzJc1YaaDpHal7DR1fdLhSSpt6kAYlAZWoVscgDPQ1Dn1wD9Gia5UBC+ebUsaGJD6u3FmUs4roc8Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPLbZnB9EaVNuhkx/Y1eMD7eOM+Vk2jgkQ1UjZoNoAZ0kukfKz
 Xu7tlq0AmRvEQ/r7JvyERvnpB8Xy9/ZQvD+Jv4QX5rexXTtIMLrTsYjwTQkSRrasrpFL7s20f0c
 UDkJWKCMxOT4sKyNqgiySoNa2GH3i29u7TsNLIzTUlBmQVoCq5cP/mgvxsEXGe7QhayEGPYY=
X-Gm-Gg: AfdE7ckSoP7f6srj2904QguqYWTFcQW5vxCBa4M3B7ZTqvUZsRZVq/zpa0jS7DMrga9
 rqtz9ChBauqX/jEbccMW7MKUecf69hKP9ghmfhqHXt/YETGzVoz+Btrg0Gw+2j7l9qvQvst6E/N
 ALtdHN1u0g+jWNfy7kbaEElziO20nmgshY6v7zFxaMOQJQQBQvns3bidKZ4vuaeWaJyHotyjhia
 ltW+9RU4FoNmZFopYDhaZ02wK8plNCour/eeezNn3FV1mY7WZDuGeWKk5MPKo9iRAzkN45zBhmh
 xvo2Vf84HMwj5veNO6dVAhubYQMwJa5vZDKACG6UdvK2lyNGC+uH0xX+OMFqbIYQMIla8RsieM2
 tVDzaGycCaewbPCAHYm4QTpIWG2lrRBTCOklLu7FkoIb3eJWg5159CSi9Eget3CYJO5x9bbcd0e
 v/EOxiWaKuT1n6Khr+7iAXDHly
X-Received: by 2002:a05:6122:1696:b0:5bd:fe7f:9075 with SMTP id
 71dfb90a1353d-5be90760024mr917805e0c.5.1783361843134; 
 Mon, 06 Jul 2026 11:17:23 -0700 (PDT)
X-Received: by 2002:a05:6122:1696:b0:5bd:fe7f:9075 with SMTP id
 71dfb90a1353d-5be90760024mr917793e0c.5.1783361842622; 
 Mon, 06 Jul 2026 11:17:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bfde7sm3017146e87.56.2026.07.06.11.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 11:17:21 -0700 (PDT)
Date: Mon, 6 Jul 2026 21:17:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kavan Smith <kavansmith82@gmail.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com,
 dmitry.baryshkov@linaro.org, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: don't re-lock the PHY PLL on every DSI
 command
Message-ID: <xaoluuysxp4oac2j672ewoqa6etmpbz7wr5hoibitnw3jltw3o@lomxntdjjefc>
References: <20260706180753.408753-1-kavansmith82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706180753.408753-1-kavansmith82@gmail.com>
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bf134 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=pGLkceISAAAA:8 a=YWbiCP-hGGFPDlVigyYA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4NCBTYWx0ZWRfX9Box/yB4OFbl
 Ze+oz1jX0vsi+w+zR+aOJGTYI5KPCOWa9J2gQvyMhYLskJPCYQ1Ql+WeEUHrr5baAWdFNiKOqE8
 SSo6PQC5xPJPjYGJHSdk67IwrCqrSBz9Vd5NSuuMfzDJm2lZHHACkI+bbgY7rHN0lNLvXasg+MD
 uTMMtQ2mgptdSFs8czgccyYS8Y6ApjK87dl0tEt1V4MxMW8XCFszij6vrW6y+x6mKD0USWUmLJX
 k253FbDbxwqehOTsitJ4Qa3h2QFNoP02V/N1/NmZCecDUjvEJsvUbRxAkXjNI9bKIkb+/C4Q6jl
 5K0iIYQba5DqP5/SdEIq+wqEP5XiFHUi4G/nwv+cCICilTKwxbOByWlsSFXECDVp/VNO/DY2Ysm
 75fKH3y3+m1yc+BZqSU0J+NeVJYazRWAxq04eg5JHsko29Vijl63UjYMJ4X9nhvCDSeMlCPZkbR
 dGOgXsQBfwXWEFxhObw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4NCBTYWx0ZWRfX6B8y7vvgNV7/
 8WjivP0J5PgyFIMuXo/fpAjjHxVxkm8pno/5nfrpxZw/MR7rfN3PuuFBYdn82B0c5wg1pV/YPRb
 lf0Smc+WHORpv10rsSOi/xORqiXebdA=
X-Proofpoint-GUID: ulVeJEWAlK38zmgP6HTctpQfbeKBpBIh
X-Proofpoint-ORIG-GUID: ulVeJEWAlK38zmgP6HTctpQfbeKBpBIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060184
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

On Mon, Jul 06, 2026 at 11:07:53AM -0700, Kavan Smith wrote:
> msm_dsi_host_xfer_prepare() runs for every DSI command, including runtime
> DCS writes such as backlight (MIPI DCS 0x51), and unconditionally calls
> link_clk_set_rate() before enabling the link clocks. On MSM8916 (DSI 6G
> v1.3.1) the requested byte-clock rate never exactly equals the DSI PHY
> PLL's achievable rate (e.g. 56250000 Hz requested vs 56246337 Hz from the
> PLL), so the clk framework treats every call as a rate change and re-locks
> the PLL.
> 
> During video-mode operation the byte, pixel and byte-intf clocks are
> already running and feeding continuous scanout. Re-locking the PLL glitches
> that live clock. On a video-mode panel with no internal timing generator
> (e.g. samsung,s6d7aa0 / lsl080al03 on the Samsung Galaxy Tab A 8.0, which
> regenerates its H/V timing directly from the DSI clock lane) the glitch
> makes the panel lose pixel lock, producing ~1 second of displaced/wrapped
> scanout on every DCS command. No FIFO underrun or dsi_err_worker error
> fires; it is a silent clock-domain glitch. Stock (downstream MDSS) firmware
> sends the same 0x51 with CMD_CLK_CTRL, which only refcount-enables the
> clocks and never re-runs clk_set_rate, and does not glitch.
> 
> The link rate is already programmed at power-on by msm_dsi_host_power_on(),
> so skip the redundant re-set once the link is up; init-time transfers
> (before power_on) still set the rate.

THe problem is that by definition the transfer callbacks can be sent at
any time, see the comment at mipi_dsi_host_ops. I think the proper fix
would be to call clk_round_rate() beforehand, making the CCF skip all
further rate sets.


> 
> Link: https://lists.freedesktop.org/archives/dri-devel/2018-April/172218.html

This should be Reported-by / Closes. Also probably add Fixes and cc:stable.

> Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
