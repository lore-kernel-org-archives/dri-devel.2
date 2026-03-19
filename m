Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89234109190B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B819210E9DC;
	Thu, 19 Mar 2026 18:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gQHzm1a2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KewRpEZI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D923710E9D5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:59:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JEJMpf4155932
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6h82EpweN7+m0WPV225yn70R
 0VhenZVEg8Gg4RbOaxA=; b=gQHzm1a2WTPnKc8MGuCQ+tiz1e3m7jclOtWs2gmM
 RCm9iXHCzaIw+jlxp1q7tdELRIsOJ0aw2EpJ15XbUAYVSGpUtBLixjSQ6eVv4QMg
 W4tbcZ0qVl8FR1tRhdt73gsZaaiJlOFz81pjeQKmwgxNXAAeB168pKRcWrU6D5iW
 2WAQMlyxak+ImoiFJWi8jO+8n0MlY6fPyveevDCWBB0iOpZx1smgh8E+SjYZlL5a
 VG6kMjmXrSNxdEkEZDs8KPkhYzz8oFg7RmwV2nUdZAj2Siu3EroRIueFD5UbbplW
 g8JkONc38Ulg+yrVJlt5ZLI5qMo+Gxc/X0opjrIOsHGFIg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0jt9114p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:59:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5094ba09affso87568901cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773946751; x=1774551551;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6h82EpweN7+m0WPV225yn70R0VhenZVEg8Gg4RbOaxA=;
 b=KewRpEZIWnMKAOv+H3Y1vvzbA8CXZ68x3v98PZfY8hY4le+Ysi/MiBPlxa2HfDnuP6
 zj6kawt8kGm3OdV3BNO4LaMP0sBtJGoYDj6PvctoEPTzwWWNbKKiy+HHMCxBsLULHm6k
 T3Jf/YlE1kpr3h/8M92Ea3lJq0CO9G4oFvSE0kmmgA4F63owHoZ83PmtOyCQWnQlmU7x
 JxukZXc/U5HEucE/1os6qA2JJ05iI2z7+CuS+CFFFsGl1+mWT2nBlTw8UPvOiXLNWsw2
 sLRecpZzCb6RpbJfl5SWV54SI0o6qMl4H1pv/6Ad5VDrqE4A+7GB6F0x2P01Te3t7DzT
 UV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946751; x=1774551551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6h82EpweN7+m0WPV225yn70R0VhenZVEg8Gg4RbOaxA=;
 b=bnhkbMRv2lgtZpsCubcyN23U5hjs5NQPnEjJ020HIp/QnJ9XavTrez0EIEbS1rEqZA
 MPeFS1oNb6cye/QuxTozdgvs1+tPlQVsvwPPlfqLT+dPl32HeqaIKY7wwEN1A17ZaxQ3
 dPa/DoWr+zbIEMGIdf7bFHMo9HDqE6on/AnCCakEuSA0Ov1cMoT5oefShRcQueXS3bXU
 Y5McQFS45Is4GsLpa2tIUW4US7DcDa0ALqmRQeAtiPfXZUGex3GYOxiXojIGJTW+tZwX
 DR9b7UG93EEjqLik41dETZS5uHXKwpB1hFCuEH+q//Oe4eCDAKeZRU6ZyJimElTtK5ij
 IuOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAK7ahSQgxUZMJIxiLu4UycdoEyl9cydR0PexbzuzxfzQI8pZ4bmGD1H16jxy4dA/6ACeVU/0xkfA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeFMzDf3NKdRPtHgT95/tHLacUH6FOxZYKqj81NOrb1ndAHihq
 HS9Hc6/X/dt4EBY+tu61OSxNaB9P4PKg3VGGAq2KU0AktZfTZ7TQP+vqhW5Xz2oYWDlDPf4UWjo
 OEN7RnP1jP6s0nhRXhWE8uihx2Ih+KoiyRABzAIbFJhAczXTTXW3YUOxlLjMJiM4jzq1Hids=
X-Gm-Gg: ATEYQzya3iQ8UKI+zfZfD2E8gvdHq+kqTbouMi41vT8nyFUGLv0Y+d16oUkCFnTvvGf
 Lwy1ageAIZROr5eDwUG7u1YTJRq4B0eO81LJXbWtCbZkuIDQ9ouzQB/YYgS77XSwZRDPN7DarF+
 2iJuM61ngPtlMM038wK464ARW7iizeD2aBFg2Ujmrn3FpCGqp3hDLga08tHjDuI+xY1fKSAOqoc
 ANVSkITGi0ZyyFXEh2w1LDY/Nq+mpCQcAf2qn8MqgK9d3KCp/5mL74mgoZXRx77XG/1xpYOhYcn
 WYTEYM2ogh44ZufHyxxJ86SmMZoJN3KWDHioNMJyFQQCkPSgSjRMDHRNS276zTLvsC+hLYwO2g5
 4+wCgeBnHadps00KGWohyNtzngC+YFF2M95tdtCTQNJ+7CmSsCo7RLdEkfOuWPRIglXU4vBmGzn
 gHL2HEQFla+JMPansfiZETn6bvytM3J7kLXUA=
X-Received: by 2002:ac8:5ad4:0:b0:509:3706:d134 with SMTP id
 d75a77b69052e-50b3756004bmr4379771cf.52.1773946751199; 
 Thu, 19 Mar 2026 11:59:11 -0700 (PDT)
X-Received: by 2002:ac8:5ad4:0:b0:509:3706:d134 with SMTP id
 d75a77b69052e-50b3756004bmr4379311cf.52.1773946750585; 
 Thu, 19 Mar 2026 11:59:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9984248sm757621fa.23.2026.03.19.11.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 11:59:09 -0700 (PDT)
Date: Thu, 19 Mar 2026 20:59:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 3/4] drm/msm/dsi: Add support for RGB101010 pixel format
Message-ID: <gompbnsbhmfx3ze2nq2h47t5aohsm6oxuetaymjpn6kajmhu65@r4qnbfshwmgh>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-3-85b99df2d090@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-dsi-rgb101010-support-v3-3-85b99df2d090@pm.me>
X-Proofpoint-GUID: o8CfqsGQK9a1DX6vR4hVmH4FNTAP7rzq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MSBTYWx0ZWRfX6u7HCslf2L8r
 iJmbq8DOZbda+9kmDPYQyqIhy3C7NidkFrumdztgyHcNDnW3LrkKK1bYsBz+WBLr7p2rUhJ8O30
 sH+kqydJT0PUI4S/lDvHyJjj+SCEXqZjudH8zhHtAyUqPuoIeytf7e3i+8/mrNQTTSEruQuW79c
 CPZtsjvkugOMwnrZ6nzCUcu5nZqZsw47Hl2cNRERg474I5gRPNlRHh0W6ghpIeAJWvgBZ9jdjgo
 CNra9RsWg/QzlxIgN1jmEDq42oPfmL8ejsTVYAmULjAIgt1ROA1pU4GUeAettwVOl04sIIzmlh5
 bsy0K5iGM8XNBhYSri+6o0e2y1bI1Sq0LvTUjgighhevwqINgm4fbb9JiQONiRmJrLIDxDdaoSs
 jmdtNPznh50UvdoQEpJnjrjxFiPyceShLa0cgGTLdoGCmhFjcqra67eXl+JNHChi/ksPKVlTYIy
 CzyK+tO9zBkcmkbVYZw==
X-Proofpoint-ORIG-GUID: o8CfqsGQK9a1DX6vR4hVmH4FNTAP7rzq
X-Authority-Analysis: v=2.4 cv=FKMWBuos c=1 sm=1 tr=0 ts=69bc4780 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=R0a44-rvPaGPu9M_SJkA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190151
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

On Thu, Mar 19, 2026 at 11:57:56AM +0000, Alexander Koskovich wrote:
> Add video and command mode destination format mappings for RGB101010,
> and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits to accommodate
> the new format value.
> 
> Make sure this is guarded behind MSM_DSI_6G_VER >= V2.1.0 as anything
> older does not support this.
> 
> Required for 10 bit panels such as the BOE BF068MWM-TD0.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c            | 10 ++++++++++
>  drivers/gpu/drm/msm/registers/display/dsi.xml |  5 ++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)

For the patch itself:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Note, you've dropped the patch adding RGB101010 to
include/drm/drm_mipi_dsi.h without declaring a dependency on any
external patchset, so this can't be merged.

Also, there was a report from LKP that you need to fix the meson driver
while adding new MIPI define (we should not be introducing known
warnings to the kernel).

-- 
With best wishes
Dmitry
