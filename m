Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB82C5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 08:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7610210E3BD;
	Sat, 22 Aug 2026 08:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EMTf8zbk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SCSK3SFW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509D710E33A
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:47:11 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67M7xvBV3666946
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2xyiDkmSoXEYwFIOKDY5gdNL
 xvz1vUv06irZue3YGAU=; b=EMTf8zbk3iKHAyJfLjkSe+5z8Sjewl4/IaCraSM1
 bMqAHq0MdqFIUeqGSYKd7sVRnXmCwWBWJJh9ZN4lqc6bfeYDg7101XbuMrvNHBf6
 rVA6j0tfvH1LrUwYQ24Jpf8s9OJOexyxNPCCdoQvKcEE2TlVK/Pis+4BNicaS0DV
 Cm0RMalDlTx2mYhMjAaLRJTAocaSmzx1NBsLlLksVNEn9YlVcX6g3iLn0P/Gkm3U
 mbQjS/OdpyQeLje7/TAEd4gIEme3NhJwHohyv/hq6qp4yJPSqBjouHRMwAToXMaN
 okeS1VAdJcut9fhjCKzoaOiGhvgvfUNLIrax5NGHVyxGog==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g744qrnux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:47:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa3d9dfbso172394885a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 01:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787388429; x=1787993229;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2xyiDkmSoXEYwFIOKDY5gdNLxvz1vUv06irZue3YGAU=;
 b=SCSK3SFWVjgVz5oeSokSBvsqZmmqEeA8E2tupeFsg/oaVxlbew1NuuuLV34jgbv3q4
 jp/F2zJbSYkAt7v7hA9ZSQWaMN00iE7RSWkj3+KibYy38947W5bKdaz4wWmnyZinPU8C
 hSwnTkfbP2lr0kElkRGIhWL/+b/LzL2xsJiY1nzC2NuXiw6aTf6SVsRIrDgdnDHYMD2p
 B63S6kMpPoJyhFD9SCER7vFSX/cwBZ2MLEWcaZdKfgdKJsQzBG+Revg2ryBymfiqPHyC
 bnKCETSKb07UfHr1BaS0/DeZF/8BmQa3KF4W7lNoI0NjN5vZAtoKSTl2sdrI6JeG6vsQ
 PR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787388429; x=1787993229;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2xyiDkmSoXEYwFIOKDY5gdNLxvz1vUv06irZue3YGAU=;
 b=Emjwk5MEygC/C7FwDGcd4HGBnx5oo6JCEDdCYic2mpaMBx9a6ZibhaPWd0hjM7iecj
 GQjhECRuXiin3guIdtsLSTdrZDYc35MjqYOkVTn4uj4HrZ99Hr/o7lBJ/99J7Cf+Dmqb
 6cMt8hkxHxPCdtLywVGFgGBkSuPwUx/jQ16PW9o0hTwPO3CuKVnIDP214SN5MPQiZJEt
 eUhu5xEHN0KgIJNnRYdbq7DKJBsJj5zR0tzGK3XK1iYBrqF8WJrCu2aoI6fqOvdqpHPz
 wH7OGwnbeubA4gGb1MkZT2t9JQ+qHTIwt5ynLZXiHvYbj/GskqLpyOHURLLt1JbdTNso
 kmIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLdslVzIe5xikqWu/mlAQDL4LVkj2wc8X9zcGAr9jjNRE9/pz2Q8WzQf92DrFNgISQi4HCyC9meCY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lAsEbZnNGJG/RWT3lYJ3eDhq8yE54JlT0oJbnSzkxfz6rhavQC
 QU44oNGYe1ODb76CJjfx2G6OJUePued0CrcQQNLKtebz3ZQIZ2a7OY7LaxG6JevhgHxUGmcF3ca
 No7Bxo+2ioQIBHWFdJsHE5H/7aPOjaAGLVMf843lmo61oxyWGmOE6cz5QxtSylVFxIYZ/kZI=
X-Gm-Gg: AR+sD1318APmLgNpFY/D1k4h+WnK96XP0RLkTgWihwMu/hBlnAvyxe+QnirhtMaUGoC
 3VycJLvxWVa7A7pCkni5+usM4uhnHul4HFI5hQfCsmRzaEjcDFLafSFUMBPvRf3at+1+6M5c+ic
 14we+hRfO3orGZgPNY9R/c+8yoJnT6p55xaL6L8kt3XmV5aeNfVM08iJ8rDmt5aIGipULe6eR1P
 z80gxW1MPh2Pzk59wxOtT74hqLBAgRJiDPrRjhhCK24ajImy6DvUead6at1CX3QRBTTWuK/nBE6
 PL8D8dTka9Vqkbo7XNbbeNyt8abe9Bf9YCm5gOyNpqHR3E/gHNvMoFif+5bkgBXlLa1/DOb3d/3
 CPN908IfSyahc9DHiuct44giOmd48KaKH942GCuJb03FWQelkNimBMI5r+oMH5MK+uhvtPHgzm3
 A7rAkg/PmZ5KbK
X-Received: by 2002:a05:620a:4783:b0:937:123a:3b11 with SMTP id
 af79cd13be357-9373955373amr846531185a.28.1787388429107; 
 Sat, 22 Aug 2026 01:47:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4783:b0:937:123a:3b11 with SMTP id
 af79cd13be357-9373955373amr846527685a.28.1787388428651; 
 Sat, 22 Aug 2026 01:47:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c2e89c54sm2840991fa.17.2026.08.22.01.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 01:47:07 -0700 (PDT)
Date: Sat, 22 Aug 2026 11:47:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 55/70] drm/msm: mdp5: Convert to atomic_create_state
Message-ID: <ucsot4m66fnajtgfz2ewtsiqemtlerrquxk37dlw6npb4s5u65@faoite334nqw>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-55-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-55-fb793475c05a@kernel.org>
X-Proofpoint-ORIG-GUID: 8Rr8k6DnV_6wlsQOZ_kGQBw0Pbprpj67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfX/g9b1cXzotMx
 mQj+OWMWlPhdOxBqgS89rA3kyxXvD2N0wUCjMicKmfidDQk/QoKONpZn5LZD6Za2rppujYLkI9H
 HXqOdP42Qo9JpkPNZoXoqGjajkPNdzLR2B6F/u4QZVuKMzXoqTsxe4CG++8B1Q2JoqgnyLh1sLk
 dlwllvfH1R04pqJNg85EZMbMvtcYVheWOxSNXgLpQme/uwQ7+6HfAANQOml7lqvC1LQN86jzpof
 VSOU86TfMmofgx25HqG4Dm4N+/2fX7MPDbUwg8mnFr4buo0v/pDlI2rdHmZvEP6V5PJFbRfkjX+
 OC+f2xeQB0LfSntoZp+J42VyAprB424cXgyEaloJmfafqXr8NpExan5OPJyyF4fyrpWYBFkXLny
 DGNHLe8sxhtw/WRpJmVCKi3LYlSr3fM4ntKHd2REMCEMOypjfZtQTlCf8SUekMbcj+O0unSqJwT
 DstYzFwQ93VstEQlqEQ==
X-Proofpoint-GUID: 8Rr8k6DnV_6wlsQOZ_kGQBw0Pbprpj67
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfXzyzjHvR5Wmlk
 8POYJoPjrskwC5gFFrNpXvLSchp8phMLeOAg9u/vR97XJs9ZQ6G6tonQj5oxez5JXJX2WymDLri
 A+JdofVv6T1TntX9E8TrEZukU3UKYFw=
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a89620d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8
 a=JUukOM_wEb1cdPDkkI0A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220070
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

On Fri, Aug 21, 2026 at 04:39:31PM +0200, Maxime Ripard wrote:
> The mdp5 crtc implementation provides a custom reset hook. However,
> this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and frees the previous state. It
> does not perform any hardware reset.
> 
> Since this is exactly what the atomic_create_state hook is meant to
> do, minus the old state cleanup which the caller handles, convert the
> implementation to use atomic_create_state with
> __drm_atomic_helper_crtc_state_init() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-arm-msm@vger.kernel.org
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
