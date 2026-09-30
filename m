Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5486CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1272610F34D;
	Wed, 30 Sep 2026 18:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJ4A8Byt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXhhU088";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90B510F326
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:50:24 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHf8d2643850
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SbdHAaAV2YbCqm+WWfaTCbSz
 kp2/geziO8S1ERFHk4w=; b=KJ4A8BytR+khCzjqhqitw9fl1y9fcyaIeG95UC3O
 8lzAqGXKk6thinaMR/aFrTcAwgIIGl3cIT314twp0SHEwrB67BpsekkPQ0YVb4Vx
 QFlRhhlpLW5aTl7MpkU+vqMUJx212TCmSOJcbc/BkbXMlEufjcnCer/eXGSUSbih
 XMcFPwajxVm0evbrCjCiehm9cvgsWahoISo9XbhT5rVXBnvS4m3dLaoAH3fAirlE
 VaEMjrfwZk7NaleKfalVK8oXSbN5jP7j6jOXXXoREbqyvO+dux+kbCP623YC5KDi
 K55iLry2sBMi0mEs3f9mUkxOPZLgD/+93GPhYpCxIX88AQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n214s8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:50:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9308eafb465so1416119285a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790794223; x=1791399023;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SbdHAaAV2YbCqm+WWfaTCbSzkp2/geziO8S1ERFHk4w=;
 b=hXhhU08844pre5MjpPpd4jYlpbwXSG/bRMEyMEsotiKBVjO42ki6VuFrl1IT11s2k7
 eCpR1kz5fQGd3Q6EWjUjnBP0R2BBN0sjku0Ws2hAnolXxTHdVee25nxrS7FC37kmhCBD
 zbDGCucflwX6mwzWLtJO3PoBf5luXm+rmd472R3LNAKlMq8+h1cL+FmXGCeBhIQzESZZ
 YcnoBk6DZzRQHDMWTSAd0LRHDrwOFTKTmdkTmg8uqa+yzR2cr5ECFfFHEmyTToy/koat
 4Tfsdni6Sk/vcNeIwh4g/iZmAexAMBaqLcHxclCghQ5uWb3WC1xwMG2iKjSjOlhPPNcc
 vb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790794223; x=1791399023;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SbdHAaAV2YbCqm+WWfaTCbSzkp2/geziO8S1ERFHk4w=;
 b=cJjcnK6M51h2SWbpK4vEzaWZ4hRtQeXcAF6mbD93Xg2bGdFtFYCx76vCsSJOKSXHL4
 /rv59E9mOvJA6HMsdPAHK+xm1z94w8Rrqt/nnmpHaDMTy9qg/fd35Jl8ZNUlqsMtOOA5
 V3O3+/xTiKhNXQ/3TotltGECtTdwIDSYxQLQIEMq8aA2ByXbasF1DYhCksiKlZn4bZ9P
 owFato7nC11FzzMeFaoCfeFGl2bR4vsFnoWiRC2Gvyqo6p/KmExMt/62pUzLnzDET0p8
 BB2plpiUBN8BJPhsNN3m5cMa3FtVJfesXJSLh/8MXxXJvqJ8E8uxT1GiVkZkN50lQh8s
 AZhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLj4H22QYiEMA2Xw5sZsD6V+4eZcAcWyZWiewnc/J+FZNJg/jDOH1lnfbrm3HOxoin1bCG+33WzmA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++klF8r2Cd1EzRp8sEmNkFljXoC1icRK6xloYOfRtmTyOoF9Vrmp
 qzI3K9KYHfdi3mu2bPi63ZjPtjWvejMh+OoAmLTPjDvSjTbY9PNfPJTO3OcTTW6UFtGNQ0wk00E
 K3Pww1SwvazJ/aaEWL3OH+J8/tWcnXJ4Ngz9Emhqg5ewtshuyNPRxnFPTnNnu4tcNAs8hXaM=
X-Gm-Gg: AYBFou2gKQ1mnGQDu/zymnPQdYIk5yCmB0+LJB5EfAVgrjQ3ZjnxqCtRaYy89czsYl6
 GpboS4bhSySRa/Czw8Ci/mCW9fv64y4LPdvETn4h74+s8vMAuegs8q3GFdDH30PqxiV8Fney4Ci
 +z5LpAtTUA66ckwJjTDx0yPzc4gILQvp9fIFxcoXMZYwOamlvadxal1PVmdkZYJr1vCfXcvPN4D
 CG8HM0voF1c6TQrhdNzzgSMd08Ts0XOJ+0oVLEz0Cz6yQvqD13Qtd1iaL2OFh+SdNUOzE9IH4LP
 ePMkXFjWZwPSUDUu+TNGXB+ryXfr3jvASc7o4di7/d6qzmZUPKKLvm6/jjsnZM6qCKSSds3AoMP
 nT1CjThcVxzTVuktK4p11IGFz54iYLBDae3JAFquQ2nzhseaj8lO13Gq+igA4/EyjniOMJoLsiR
 bSQiALB1qMDjxN
X-Received: by 2002:a05:620a:bc9:b0:93c:5951:38e9 with SMTP id
 af79cd13be357-93ca978e4e1mr454237785a.52.1790794223143; 
 Wed, 30 Sep 2026 11:50:23 -0700 (PDT)
X-Received: by 2002:a05:620a:bc9:b0:93c:5951:38e9 with SMTP id
 af79cd13be357-93ca978e4e1mr454230385a.52.1790794222511; 
 Wed, 30 Sep 2026 11:50:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fb1fe7sm161163e87.35.2026.09.30.11.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:50:19 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:50:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 10/13] drm/msm/dp: Signal BT.2020 RGB on DP and eDP
Message-ID: <5bm4fk2j6fhrw2zupe4c275zsktwb3o3htykdfq2tg5jiuybw2@5uecwvjztfjb>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-10-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-10-dbbf8b2b42bc@radxa.com>
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd59ef cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=ksxQWNrZAAAA:8
 a=wa0WequbTeZab0NVKFEA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3NyBTYWx0ZWRfX4GjKO3o/btnt
 5O4p2+6CzyCFxpHSQlEWMj6J5dwl5wEgj8yyzChZ3f1Bgy6c15fzHA5yOyXBOCMW2UqQ24/ltnN
 z0+IA03B7XUewZsay5GCZJFWUNZQGE0=
X-Proofpoint-GUID: AIzPbvfr7REUhcMal4QITxqMDPbNRw_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3NyBTYWx0ZWRfX8Mk0pzfbTXON
 BLCMz9j5oP3AoMDhqBsS8hwa4m9sBjalApxhdeQxQ21Coh9fyU8TdvKVAewSV8BW1MTa976ylGc
 SIHpqYyiX/SdFUn7jVRkPUbQ/hih2yf1qyjbMtuIQ4PbgkuzO1YeF1CpEDYt17aPTTNN9QxysNX
 e+ZfqVHbL3dBc5iEqMarr1hzzYuh6Bur9+IC/dCLsGaT9wi2vHYSyLbP0uxzpbSxefAERhU2nMb
 ZncfzBvrYhPgQIK1VJgGbf20/ZrZDOG9XT7VsQPqJw6G5SldWRBgZbSOh5kaRVQ8LZBwBPk60WN
 EzoEr5sUhPy5n/U3RZAaC6Fsm0z5Ilsd+0/sJVxSSOTaItCCFz2ENElmy1DYhQ4O6JXjnuGOCGl
 4ifJ2yuePQkOfFHdZDyyZDUT3wur2GuqGvinBmkoIQq0QehZr9AyTuGbxQPrFc9b9wOTJb4KalL
 O967kousV86I0qgGiEg==
X-Proofpoint-ORIG-GUID: AIzPbvfr7REUhcMal4QITxqMDPbNRw_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300077
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

On Wed, Sep 30, 2026 at 08:41:54PM +0800, Xilin Wu wrote:
> Expose the DP Colorspace property and carry VSC packets in bridge atomic
> state. Validate VSC support against cached sink capabilities and check it
> again after powering up the sink. Regenerate the packet if link training
> changes the SDR bit depth.

This doesn't sound nice either. Do you know how it gets handled by i915?

> Signal full-range RGB, matching the existing pixel path, and retain CTA
> range for YUV420. Reject BT2020_RGB with a YUV420-only mode. Clear stale
> MSA colorimetry bits and include VSC removal in peripheral flush requests.

This sounds like too many features for a single commit, sorry.

> 
> Force a modeset when colorspace changes. Disable PSR in the controller and
> sink while colorimetry VSC packets are active, since they cannot share the
> automatic PSR packet generator. Restore PSR configuration when returning
> to a stream that does not need colorimetry VSC packets.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 33 ++++++++++++++++------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 13 +++++++--
>  drivers/gpu/drm/msm/dp/dp_drm.h     |  3 ++
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 56 +++++--------------------------------
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  4 +++
>  drivers/gpu/drm/msm/dp/dp_utils.c   | 38 +++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_utils.h   |  7 +++++
>  9 files changed, 118 insertions(+), 64 deletions(-)
> 

-- 
With best wishes
Dmitry
