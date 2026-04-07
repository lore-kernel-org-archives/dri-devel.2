Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CA6FB5173
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2EA10E30C;
	Tue,  7 Apr 2026 02:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aas/50kD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kfdJi3Fm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FA910E17F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 02:03:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQA9j1405865
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 02:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sMZG1Wq6VOOWUWapU0zDNsI3
 1QW4fzpP6mGBXi9ancE=; b=aas/50kD9Af4yy/L2b8SvYAoVjfUh4YYfZD8Wxkx
 EYkVoiaYIXShuKhF1tW3Tb/URgg792fr78jZLB3qi4RCclT6mrsf4gAShdPZg6iQ
 IhvxqHOC2CsI94kljAk1yOCNmwE7KQ39VxBpmuE0BukRM2/A1fAXkiuVu0VHDFhd
 7h2lxM3My+SYWECtqZIJ+uqSzp7mVRvEYFdNNtnjhzr/rg3iBYKndWp8gNjgAaHB
 KNivW3eXLu90f+Qf7mrLcNwnxb+2VpWy5xiRfGX1VMCpTE/Yix1IYQKv0pmN9QPo
 XpbrnfZS5epSM6VdK7qrWlkF+Y0LqwvIqrMiVH83Ju1Svw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrarkdb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:03:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b220c72bbso24593061cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775527418; x=1776132218;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sMZG1Wq6VOOWUWapU0zDNsI31QW4fzpP6mGBXi9ancE=;
 b=kfdJi3Fmiej/IpA2qKOyJvHafKQxnPZ1yk6cZVW6IIyV8np/EqmS6JcsuJutClKRjF
 hbXAqvEH2R5NR0iB/UX1kO63OfxDL5Y3jdbHDjQ5M5q5wNH6I1TPvtfxLyHmMgmhKH1M
 8spDS0Qlb5RKYhlhW5Va32gVauW1JrEDHYylmQp/1Ml40ku18HIPRGREiJJTM+I8zIN6
 OhjZQhXo/QpHTcPO53Ek72xq+ChegaAyPJo5It5PrctBDrPy2LAJncIydvANLm4e5wAE
 0C2kLoDCpWwLma0Fb1XK5uAYI/dWN9AhjVmQHpJrV89kqqdQlosTypbd1VutesVn2oEC
 wN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775527418; x=1776132218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sMZG1Wq6VOOWUWapU0zDNsI31QW4fzpP6mGBXi9ancE=;
 b=pdP7hOilRxPtQH5bdCd2Jb79PouLuqGYhNkB+fkJ4QPhPDI1d04PiKFsAjgNHdqKA8
 +Mme+PP/R8IJxI7hvw0pmqvk0g6pkwbHs1r4ZxdpNmJrWW02baY1yvq34Ng+RGFnXcFZ
 2/+dXYBY5ZTifW6J6HC/DbpniNWoCLHdfVSja5VnIqi6Jhy2lPw7KVCLqXvxaIjFwdUr
 ZWU/d9CEtWma35xbM6IdYxhvTF5DgG+aun8gmq9DQ3okPOSo2mQDjRP1eCb4RI42AldX
 NCULsshwTPSVbocHw1+ZKlSsNs970nWjHAmnSWuhOeExd8LvZBRHSqiugrkiWOFD0vQ2
 7pAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5ViPw29wQV51jBtj+gM7Wrw5HgEo4a/koqbbwT6e7auKGPHaPJiVaJreWCN/gMYZc1L0SZHZg/70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeMyZcAa+3wIyTc5nyfFZjkOuU+/sd9mSqM5lM4sQGy6K85h4a
 sSdqHK4FKVGUdEb2BQjeg2EXLLnCfTpduyMPbr9vf74pyoASAuIvWWnpCTIL5cQBtVM/PnvnikE
 spdNB78kAYwa7QoBHnSdOrobSITy6RpbJEKXb2NDSrgOCyMgYKlUudoC3eazil5KNPeQxBo8=
X-Gm-Gg: AeBDieukUaBUUy/oj6AyteNF5eb8iCIUKmYRwuWCnPe97d5TFy9yn+qJsSkIwB34bCm
 Yr0zeFvN7daC76PoJZUDH9cvL2XPzL8rEJIzm/XeRAvxGMaJ5k76MkJ9r0Gi5GwSlOn4WTkiOyC
 1MxTyss8H4+q9WftxbOwhzwlAtRhn9pCC9W1B1htxV9P6Jd2lEsqwDWhANdXnk+R+rBiEcrvzZ4
 XctFyrEpPQ0m0e+C/Kz+1HKVO4fDAUAIiXGUbdydbseulVudfIUN4T3BSuIijxTw9i6tCBF+j/e
 PaYbpoGXDDrz1/J1ktQdcN+vXv8CQ9EAd4hQ/Qf6cL6LPOZGWQw7lU5TIaGgDJqjTuBusWJemKj
 ghFQmIEgeAY0SIxJ/M1ghAZE8Vf2tgaWEQBwJ54/TKbk1bXBpQf2rY/E790f8TWUTr6upCGXaWn
 2TbUPfljuLeqlTj3ZE/CU1noJ0GRvyz6WnPZM=
X-Received: by 2002:ac8:5904:0:b0:50d:9030:c7fa with SMTP id
 d75a77b69052e-50d9030c9f6mr97837021cf.39.1775527418356; 
 Mon, 06 Apr 2026 19:03:38 -0700 (PDT)
X-Received: by 2002:ac8:5904:0:b0:50d:9030:c7fa with SMTP id
 d75a77b69052e-50d9030c9f6mr97836711cf.39.1775527417931; 
 Mon, 06 Apr 2026 19:03:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd1fdd274sm37329721fa.14.2026.04.06.19.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:03:35 -0700 (PDT)
Date: Tue, 7 Apr 2026 05:03:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v6 phy-next 15/28] drm/msm/dp: remove debugging prints
 with internal struct phy state
Message-ID: <okmmblz53sdgjwduiszsyo5l2hcqnxm3xq5yojbi6uxp7kmojm@jaz2a34av7ww>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
 <20260327184706.1600329-16-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327184706.1600329-16-vladimir.oltean@nxp.com>
X-Proofpoint-ORIG-GUID: 6uJ5JK4zfPo4uKBER_lf7aZpWpuL1JgN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAxOCBTYWx0ZWRfX4aUo5wW4BrV7
 S/IUix1romtSQJOzF/fXA95zuGrU60UZ7HMFDgYOFUzBZi1YN6kOB8J1hNBOH29Gk5jJMBkSLrE
 5LPRd+8ppJrBNL/nygqr8JJXMLwuPHHVG1yQvK3O9BCLNWc95Ofsaiatb5ZcSkiTRi+u54AxlK3
 sRctcEfS8kxQeQChkdzWNCS9mvXkuj48EF6w3gIsN1bGPcsPiBNegl2etEkUmhlrTr3JQUs4mWQ
 SpT1dEQw90qhBVOYVygq/yYHPGZv9ho8xBt2gsFw00QyDC+23nc/uIs6Jwte2j14rvQyJaP2Ik8
 tk8yJ3XUGUDOiSUCGhXFbCwJJvecJ+KXeMpAvH1eTAqpB2Cm9GCmOoj6wt1Nx3jsYgz1Ven4nty
 4TjOuFMcPaOkM2lpyGMyfTHWbEMqXVOoHPZ7Ax4ZQhPlk3o+TQLev8L6fxSO+gAKtNwTJ1HbqZU
 MTqmuVIXUHyp4DI/jTA==
X-Proofpoint-GUID: 6uJ5JK4zfPo4uKBER_lf7aZpWpuL1JgN
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d465fb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=8AirrxEcAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=3ogKHO_BN1K2bhpmqR8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=ST-jHhOKWsTCqRlWije3:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070018
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

On Fri, Mar 27, 2026 at 08:46:53PM +0200, Vladimir Oltean wrote:
> These do not provide much value, and will become hard to maintain once
> the Generic PHY framework starts hiding the contents of struct phy from
> consumers.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> 
> v3->v6: none
> v2->v3: collect tag
> v1->v2: none
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 

I picked up this patch for the msm-next.

-- 
With best wishes
Dmitry
