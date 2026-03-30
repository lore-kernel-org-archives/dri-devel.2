Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DBF1061B1A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA9710E6D6;
	Mon, 30 Mar 2026 18:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALQaXzQu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HEDSh23D";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A94110E6D6
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:57:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UFwsQQ2723720
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bw2n1JjHUO1SVcf10j+QO0Rs
 MwFDwlWuIyf73gWTUSw=; b=ALQaXzQumj5oXkpvH+ySP8jCWuqGUkbYERSGebez
 0O3gCz3ieEbzs+gh73yC3VwaN1T3JQi1enaq4UXkNPo/xwpC7w69YwB3I1IctwaR
 1uaGKocjKk9P3xqmOLwRPbfGabovaizuHyreE9FlZVJomnsOwotV9SU2T4gkVHIn
 wW5QV2q37Zts19Y95Xh696Ke4chidpJQxXMNWsWZ2JYx5qyu5C3Fwd/RYDtNsPxE
 9kMsS4KhwmPmjD//wpFvO+U1Hb2DgNOXWH/i4dccU5+Du4IX6L5jZIul0y4WFMei
 INW/kEQbxRdgr1555svSme3I/cvplQLU45FDJkH1xEKIIA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7qt0hxkr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:57:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a7b8fe7c71so16686775ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774897046; x=1775501846;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bw2n1JjHUO1SVcf10j+QO0RsMwFDwlWuIyf73gWTUSw=;
 b=HEDSh23DksqUVqKXbcbMicSxq92pe5+/h6pZE59JPL80glHDc35kyf7mljuwx+hB9t
 h7Wp1wHwQOlKVjYU29jlCgHULrkQCBeSI1Z2g52jxlwfu+OGRmcJOuyXgfDtr1yvfbVQ
 0mpta02+IPg6BVE8TJuR4upii4zfIFtjpIewzbI+JK9GlpQge8k2riY5xqFUungn/zjQ
 jG1KLFMNf8rGzDK9ioWoTK7mF7DUNUk6qJwqJqdzJuM498+jiK7BS5+eeiHTXB8BWyxS
 Tac53qC/X3satIgLZU6nY967MU4BZbTL/lXKwltCul1QQ18lg6g8vxRclUDj61HMTV2o
 wk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774897046; x=1775501846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bw2n1JjHUO1SVcf10j+QO0RsMwFDwlWuIyf73gWTUSw=;
 b=VO9MvM5CdrvKe6B/NTDfOUEHolgEsCT577l3y87ha749sMg6h/yF4B+4pTcWnilm67
 qprIlLTVBSge5I2MCkLGoi8g/5DiOQQ6/2fNjByXd8E6PE2KpoZp5sMY4oVZhAqgLQlR
 5SKUcAsSSmfOGza2K107xw8610QBIz+rqQ8vi2frziHgi7QwLlCiMnIFtCzywXFXXxGs
 +quPrG+Bq6VLHG5o97BYrsbYN44ERWncjwsVQxfMLH+ivsJbUDjd2ThDqX5OXKxKr92A
 S+5hgjekAT6g9joNRriPX+eXpFqcb1Fi2+kpaNQ1v1J7mrXohjorkbFDdefL1kVoA8Db
 vwIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfTPCtPiWI4VAvBrTgB1k7jJSM4jRza4VBnab/6o3I9bTu/QzyvbHYEo/tJhUQ4C+9TBiZF2/aHa0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRxCupVWZPBeC6oa/g88700Gt9ak9Laa4n2il8SrcoQmF/x0N0
 SunRbTrZb/rIlkwU8i40RZqi2uwV2HwgtCngy6LnvjgvGtK8LPbwlSuzfGcMwoKSA/Jn2dq7+S6
 sWVWoKChSHXOhc2o70LXrjuIyUitJDvl+c52hkwTeoTkB3/EWOnqYq3ghVZh0jTd5rJUvRkY=
X-Gm-Gg: ATEYQzxZ2Vf1AtRDyoNcqD9cP0+3qd6lmmMfbTsv3igBD2XPKQ+KsF8oJyCinD/gXii
 6XWIN6Hc4S3EW22MArEb72ChcPsjFh8HHumAlP+bboIyhtiE5JSVWch1tV2NsSpLDQiTJ/wv8aZ
 3Rzq4yUnwTw1cKk23RHlLvSM3J+QO4ONg2Xb6slqVrFcvs88uLmKcmp/Zs67l9JEVuZ8y2jCGUz
 RCoScAqobSxCTeb/oy+1A8iD3sMsDs6HtMb3DUs4EE02v1/kXvgckFjBpv8nSkr1F90xNHnLgLV
 naqF9bcDRIwZcNfOr47cvAakinFhnn2H3iweSMdNWR9OMEt2CXGZr0bdETpbFcCArFlcln5EumG
 xA/bMEQRmZ4BJYFtNCLrx8BNmpyWojtO+7U8pRAFWO2m2BFYeAkds4017YXpbBWYqVAc/HuFX7K
 bSaI+uqtrIxbGYGEEN+ilXaGQq+9u4FqArA5Sj8jr1tA==
X-Received: by 2002:a17:903:3d0f:b0:2ae:5d79:a163 with SMTP id
 d9443c01a7336-2b0cdd44230mr80987845ad.5.1774897046169; 
 Mon, 30 Mar 2026 11:57:26 -0700 (PDT)
X-Received: by 2002:a17:903:3d0f:b0:2ae:5d79:a163 with SMTP id
 d9443c01a7336-2b0cdd44230mr80987605ad.5.1774897045710; 
 Mon, 30 Mar 2026 11:57:25 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427a27f2sm119371675ad.67.2026.03.30.11.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:57:25 -0700 (PDT)
Date: Tue, 31 Mar 2026 00:27:19 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com
Subject: Re: [PATCH] drm/msm/disp/dpu: consider SSPP line width during mode
 valid
Message-ID: <acrHj02HsaoK5N1b@hu-vishsain-blr.qualcomm.com>
References: <20260328-msm-next-v1-1-12ac4e27c670@oss.qualcomm.com>
 <v37m6z5le4rk56b7pinr5wbi7l7s2bbgkggglx4eog6w7ja77f@lvyxc5tks2bs>
 <acrBL4fF4aiAw8m9@hu-vishsain-blr.qualcomm.com>
 <c7xvoopmujdmdar4lr5oghcc4olc72fpfrpe6yq7wrmtqaytjg@iweixftggvbg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7xvoopmujdmdar4lr5oghcc4olc72fpfrpe6yq7wrmtqaytjg@iweixftggvbg>
X-Authority-Analysis: v=2.4 cv=XN09iAhE c=1 sm=1 tr=0 ts=69cac797 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=dtW-sFU6C_rc-SncmgUA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: mfZlmPDFGSWtQUPGojoTHLzl_EdUnYjr
X-Proofpoint-ORIG-GUID: mfZlmPDFGSWtQUPGojoTHLzl_EdUnYjr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1OCBTYWx0ZWRfX789bJRHe5oC+
 hzm5X0+/f281NKpJeUQ0qr3OwlGH/yZhFLiYCUL/GRHZ/6tboyKOzY7Ys9r74/YT3nRHvMFEZfq
 HtM+1GDfShlnI1L89QCTcxaBuf1elZVjU55GaLaiwhi4TjL/JjwnqR+jCPnbx7tzhzaLMlEa3sL
 Z8w44nJoIQK31v1OnZey8XSfsKr63z2lmjrDDPB/MtnLHpCZqbxmMC6bCYqs/IeZ0iP3EDRsV8a
 uEdu1B1aRR0V0wb0UhVmEf4PZYql29/M9QtZXTxeq394PXGpeT2O9c07RV9AOadhl/bleyEr4Kr
 51F3GSPIJ5yO+t3sKwWf2M9WeiB48Hy8I3bl5L2tXWJZaNrvwONRNeLcD29LH6OEB/GqVv/yOXr
 DPx+8GiZ44u7PXv47WxF36Fg/V9pgaz1uic7AczdykGhANEFFR8IPfGjxRF9eMkDx+EF8I3r+wf
 i5sW/LFvylfLXN7/ulg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300158
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

On Mon, Mar 30, 2026 at 09:39:31PM +0300, Dmitry Baryshkov wrote:
> On Tue, Mar 31, 2026 at 12:00:07AM +0530, Vishnu Saini wrote:
> > On Sun, Mar 29, 2026 at 02:24:53AM +0200, Dmitry Baryshkov wrote:
> > > On Sat, Mar 28, 2026 at 10:45:35PM +0530, Vishnu Saini wrote:
> > > > Few targets have lesser SSPP line width compared to mixer width,
> > > > SSPP line width also needs to be considered during mode valid
> > > > to avoid failures during atomic_check.
> > > 
> > > Technically this is not correct. There is no requirement for the
> > > planes to cover the whole CRTC. Nor is there a requirement to use only 2
> > > rectangles to cover the screen. As such, it is perfectly fine in
> > > mode_valid, if CRTC is wider than 2x max_linewidth. It would be an error
> > > if the user tries to stretch 2 rectangles in such a case.
> > 
> > This is to fix an issue with 5k monitor on rb3gen2, since SSPP maxlinewidth is 2400
> > it can't cover the whole 5k buffer in left right split mode.
> > Do we need to fix it from drm backend by dividing 5k buffer into 2 planes and 
> > use 2 pipes in split mode.
> 
> Quad pipe is pending for 7.2, most likely. However, I think, instead you
> should teach compositor that if the commit fails, it should retry with
> the lower resolution (it might require somethi g like -E2BIG from te
> commit).
Yes, from driver we are returning "-E2BIG" during atomic_check.
Thank you for the clarity, will try to fix it from compositor.
 
> > 4 SSPP rects --> 2 LMs --> 3d_mux --> DP
> >  
> > > > 
> > > > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > > > ---
> > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > 
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> 
> -- 
> With best wishes
> Dmitry
