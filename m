Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73797F483C8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA84310E59F;
	Mon, 23 Mar 2026 16:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b17pxW72";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QeqIlzXZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D422A10E59F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:48:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NFGhaE2490267
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8+rg6T95L3e6cdKRmvOpy6bF
 42FLdyllOf+gYk+r2to=; b=b17pxW722M9j9oJ/IP8s8dtAYi/yBx5wKXEUHUS0
 x6SDLEFeAGIKIzOjzQGV47Oyk/14Hq+SkQ+YZnSykJ83agwW5E7/TypkX9sv/SS9
 NXzpT9o4aKemyY6vdkrSppvk8xpn7yCti0MHAaxU6x2we82FEwIgFUrhFjzL/n6z
 WHFaGQEFN5DIDiQ4rl/GNRAcAu1VPsq/BeYjfqUsyGsyeQcS4/7DiV6dUl1qitsc
 sOOV+AQGbeOBCBap7egEMM9mw7vQZdLiHfH27hbxaI0x4qSb/dtXVrLUnJ3DMzgS
 5wC5ewTZi/tkuC4TUInCM0zDWnsc1hdPgm7gOpWaGt0xCw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d364jrtpc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:48:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4661881eso5464051cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774284508; x=1774889308;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8+rg6T95L3e6cdKRmvOpy6bF42FLdyllOf+gYk+r2to=;
 b=QeqIlzXZ21CykY3MEnB6yZMjIJ6+Rr3dDzhVdbKPfGNra11n7BGcap4C1xEhn/Bvha
 wnha+Vj+7Pxs2YZWHi5D7Jlk4DJNpTJYlSoCoIVea4xyal9LcFHr+JEtBwXcCd3+sE2C
 dUoCT/rjvc8fiMxaBMzq8AZdrrfRihy/mFH9LJ+q7BSaLHpI5YRBil4ViOv+lSmOc/QI
 fPE9WXwyIvVuAJLRY2/ssmODAwFydjODcm7ahPI3+s43dKgGViK7oygvx0i5sf7Of0PO
 wHbbL5jMTyheZRD7UoOMBhmcc2dzoNB8QLKZIW8P5YU/lbB/HmNZqvDOFhQqEkNehYTt
 bkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284508; x=1774889308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+rg6T95L3e6cdKRmvOpy6bF42FLdyllOf+gYk+r2to=;
 b=fsPKy4Zwwzg+5SGY1omrcstopYXd/gyFCVLYJHsQFQdMBezt3evNQ4+b2VI1rol7Ht
 V0hUispiXTVNE6ybyg1zysNUydxTJGnxzN6xO29mVZZVvokjboxKmzO8sp/F/yP5Y7Tj
 4VeyD+XTKVsBTS5eptJ/SIQav9MqUnm+5YlEUIFbRyONJIsfq4ThLI5xpGhMEHrQjVu7
 PMijy5bC0hASkfkcjdnq/S7fKZj10qRidCnAF5XzixMmfgjgkA9In6dgQ4AP6FY2c/Be
 tq6Zr68yIjpbaOEMm9eiJ+wdTT+aK7aK0LaO/236Aqf9MG54ZYlt/IGdUlwNIXFtQp9d
 AtUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJMk3qHKl5u5HQLv9z4Ijnabj4q7oO0ZcbAiPljf7ptbUfLF/1Y4Hrq86Mg1IAEvfj1TcVjOsR/s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCCbVKzsOUgAvUHbmxg/w5gxl6bE6QO6c3nwzR2/lRIVElE7q5
 QBFTwXG9euGLtVDbfYiqZNUh5YMCZEo3aXpZE/+E0HWbhAR7G9b/xxX38Qx+dAZNMRJXC8+NDle
 BR8Eb7L37hUHkBYph7Wj2x1okwqOm9ONIyHCofuOGJQA7zQzciDkvgYLuyMU0ZWAsz3RMt48=
X-Gm-Gg: ATEYQzyDkAWKb0U2ELq/HUmFHCj20RBsi8W+2GROxduGS2nzU+amwFN9h+ND4zEIzio
 BREBiaqxHRMBxVUXf+gytqSkUE5d6Qm0FuxTT9oo1YuHiqARXcHaW3pRrAOdkmmUF4S9j2x8x/w
 h0wjwDwfV+mzWgRWgdH43lEfKgWU+NKNBMyZlqNmOa1hY3qI4fEJgM1zBgXdhW0p5/2KShpJBxN
 s7stzh3gSgq6yFbHS02tXsXqx2YU+qeRLIKQDsK8m/61AvKlONXlfhAbmq7OsJqSj7R+3o/BitU
 z+Xf0prdI/XmEPGzhW43efzZUg+QCZcE810tjne3UH6Htr7KpLMimyIuJPWJ5SGSYaQWbTNCNio
 EG4Hn4w5maXyRihfQypmlVFDptDXQ3XCk7g0Blgon90pvC6H426anEV+nd8lBbhTgBYYpn3mQ5a
 lVQiIhCoklkN8SeHXf2j4F/mctoMXZ/Quiu6o=
X-Received: by 2002:a05:622a:8c1b:b0:50b:277d:efc9 with SMTP id
 d75a77b69052e-50b374f5bd6mr176063151cf.39.1774284508178; 
 Mon, 23 Mar 2026 09:48:28 -0700 (PDT)
X-Received: by 2002:a05:622a:8c1b:b0:50b:277d:efc9 with SMTP id
 d75a77b69052e-50b374f5bd6mr176062621cf.39.1774284507620; 
 Mon, 23 Mar 2026 09:48:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf97594bdsm26711581fa.14.2026.03.23.09.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:48:25 -0700 (PDT)
Date: Mon, 23 Mar 2026 18:48:22 +0200
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
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 5/5] drm/msm/dsi: Add support for RGB101010 pixel format
Message-ID: <l7p6mczksd332pdxsn5lttnzxljux5fqupnmnetfdox5kriqpj@rolh7x5zdxxi>
References: <20260321-dsi-rgb101010-support-v4-0-eb28ecebbfe8@pm.me>
 <20260321-dsi-rgb101010-support-v4-5-eb28ecebbfe8@pm.me>
 <nmC5g-yqiyxWusbu6f0dZ0s7W-bqYdVUT0fIX9h1MsvYrAE521869Ei9NAKzwxbz30rvdYJCVjEWexnaUrAx_63G2DtM2mVUZthU1VRUbrg=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nmC5g-yqiyxWusbu6f0dZ0s7W-bqYdVUT0fIX9h1MsvYrAE521869Ei9NAKzwxbz30rvdYJCVjEWexnaUrAx_63G2DtM2mVUZthU1VRUbrg=@pm.me>
X-Proofpoint-GUID: iml0T4kSMEtcT08Q7MAlBAXOgzdW3Gc9
X-Proofpoint-ORIG-GUID: iml0T4kSMEtcT08Q7MAlBAXOgzdW3Gc9
X-Authority-Analysis: v=2.4 cv=JcaxbEKV c=1 sm=1 tr=0 ts=69c16edd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=qC_FGOx9AAAA:8
 a=lcybLqEkPtajXZbn_A8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNSBTYWx0ZWRfX30ufs1idbImW
 2aDAW/XnJM7K/FaC8WTdz3/pYdZf35pJJSmQfwERzrC4apKGm9tKExBdwkgcOb1dGNPGNZ5zOwO
 3G+NcjfhwgUCHw2+hWtzJ7m4jOlbE5Gp3ECnPA+KAKgbkz+6K2CQJeOrXbvcrqxnBOLc2eI+74m
 ChE4KS93X7BMMO953KFmBthwJfvxF8cBzJ201KYpzHCZfxYNbMT7OqeAV8tQPy6cU8CWeLjlBOU
 4I6uHK4gMKxVmODIrqcOB+bikbrXP5HeoUqJH8QoTNZP1kwBGpHcw1gknddz5TMUtqzSOpfhIJM
 FOnLl/BE6CcwicEXhFjKYWnpguQjBETxtt7hueSVne1/Q4e9l5Z0JXX2F94Y2EOyP1kHZW/9Dzi
 r280CFWlHfNv4mKua61eto2u7smNZNdvpzRTT2JNoX2SWXnzyUtnEKErhG7TK8G9ktTT2jJdkXv
 fbUrPB+ljSZxMspjnKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230125
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

On Mon, Mar 23, 2026 at 03:28:59PM +0000, Alexander Koskovich wrote:
> On Saturday, March 21st, 2026 at 3:52 AM, Alexander Koskovich <akoskovich@pm.me> wrote:
> 
> >  
> > +	if (dsi->format == MIPI_DSI_FMT_RGB101010 &&
> > +	    !msm_dsi_host_version_geq(msm_host, MSM_DSI_VER_MAJOR_6G,
> > +				     MSM_DSI_6G_VER_MINOR_V2_1_0)) {
> > +		DRM_DEV_ERROR(&msm_host->pdev->dev,
> > +			      "RGB101010 not supported on this DSI controller\n");
> > +		return -EINVAL;
> > +	}
> > +
> >
> 
> Was tipped off to this bit downstream where if DSC is enabled and panel uses
> RGB101010, it overrides back to RGB888:
> https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/DISPLAY.LA.4.0.r2-10000-lanai.0/msm/dsi/dsi_display.c?ref_type=tags#L7209
> 
> Only does this if widebus isn't also enabled though. Should we do this as well
> upstream?

I'd suggest adding a bit fat warning here if widebus is not available,
add a comment about downstream switching to RGB888 and letting it land
this way. I'm more than sure that there would be some additional tricks
if one uses RGB101010 on SDM845 or SDM670, so it's better to let people
having those panels face the need to research those rather than making
them believe that the panels should work.

-- 
With best wishes
Dmitry
