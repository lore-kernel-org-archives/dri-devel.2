Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDFACD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 12:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BC010E19E;
	Thu, 21 May 2026 12:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EUrdCBO3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9JjLdH7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01E210E4A9
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:20:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L9ANvm1731280
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YoxEM1YTlmO3FFalc7XhHVbs5SY7WJHAbzoe8nlfLQc=; b=EUrdCBO3DL/fXinD
 PwIjPGuWJNGEw564Sz1Xsxvd/p9ehHya6OeuzmFpSwBdNg0XWa67KpxmLyCALUwV
 YJn6MlAqjiSCjykTuPCiOtRh6TO9ZMu+LNE/JFK5mdhvDNaYf0MxRBErej3B8QlL
 GXJffLFTKBfm9vPmqF4O4W4QGT/4mPMaVMba29kz2YCbPqrM/b4xQTxaZsV2OKUR
 mwSHLozia/aGTN4zGiZT6BF8rq/vJdl9T8JoA7LGv/ypYkpe80rsmgPtwvzxQu3Q
 0Ws+vwbtFxwaixco2MR824fgxIqtO4Y3XlLifm6MfY23sllr8/sKDl6nfookJl9r
 dQZacA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f5agt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:20:23 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6312af70ad0so7527525137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779366023; x=1779970823;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YoxEM1YTlmO3FFalc7XhHVbs5SY7WJHAbzoe8nlfLQc=;
 b=E9JjLdH7318poocYmqSn3wbi2QjgmZNEpkvkI6/onwSsWYGqJ/kYB8XlGEsh5Nw26k
 79RqhW0rVNnY1Xranz9C1fJHvuiiBPAXo1cbjQEpnUTULt3Vtwt27UaNKTQOret2ic+s
 5yX3DsultC+VwimH2VjhjCDrYPzLsyaWYXn+1P4nXejb3kjnk69uCYQcO7rCJQJ4T9HL
 lvPbOz/drJh3eHSzwhvxFJRH6D6bWsTOhhVxnFv5B+jZpDNvVwZGXMZX+9CMujSsMc+0
 hJMuBh5cOYCvd89B657h7ErqWGrPY74ZcqKEQLaWLgrAIov61ik0q5tRtSCN8Ms24xPD
 Z/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779366023; x=1779970823;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YoxEM1YTlmO3FFalc7XhHVbs5SY7WJHAbzoe8nlfLQc=;
 b=RBKghmsttR5alg6HuwIO+nJPuotgAYb4QMtA5kVIqWzvwcJ5OsDhYw8+CulvXEyuIn
 jFfFpDD95/laYeuOOfprXjPN9SVSQi5EIcbH17QrlVXyeg2j2GOX0Mmtj2wtAFseBNZt
 h/AE6c6euAA3Lm2qy4YP2c3nsGoNhnvEolnbOQf9v5uEHS8N1qF9iALwUGzuaKZCtW3U
 jv9eNH1+xwnQYHecWyKcwv1pK6D2iiIBowThtR2HNBZNNiTBpy+43GCkuz7Vn0mCkkHk
 6NSfNZ3o6eyaTu0RAr7QruONEE1YID4T4r1RM7y3ieLAvnV38N5sJsf5CIN8eqQXqC00
 5kXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TkpOPvwOxtV2XJaW2Mbjt+QbowYwVrC2bscYMtN58hDrTEo6otD4F/clDpYxlKMGi3ujjEyRyVj0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOwolrTTVnGepio6ZHccPtfNC6R9Ilefwz+w90orD4CKL3TdB9
 jw4pKykod7RkvWOqtJMJlkf4CaOonb1dM++xmlvrWU2CE99gmF+3gRxni2o5Jm0ta7taDz3WJOH
 OMb6I+FKmY6rh3w+ztEZt/K8CyuPSR75uDfJjQny4lTJdzcgIM4+Q47t12IrzSIL36tgilRg=
X-Gm-Gg: Acq92OHwWOZkxN2htzESFyLNGJMJHDebDDgcF/T1L7QEbaWscMv0S3DmbRFwAZ5e8pO
 mv0g51Qa0IMfINLvLwRPWFuyvua/noacmBE3tkhEyBOlThPJkUfPgplybbaURmLzb+2Runf6Fk4
 qOYe6ZSSm0nOGdnwxTnEKkErqARYEHACCHH9HNL4K/Qb1lLqvotVBAId4mI3F3JsnaJOkMRUtr1
 cSbksMAEHNzer3kVJPuRwXL29B8i1xEloleQaHvN8ReLQBIfFygBindefTstdpfk/1WJVBqcMbn
 B654aXCCDYCG8l6FmOuXD1mFvokhGX5enxU0eP0fO66IwjhgmID+XIoHaSQMDJgYfd9zuNAok8D
 xM9eh7YA6SIrGrJ44lu5vVXwtgLjE8CCoJjnYmrpb22LTgH29sO0h/agvIm+8oAcrEhmUh9Z3ej
 QUflCLv15yNa0FOh56agXIkMJJDhLXK2ZF4Tw=
X-Received: by 2002:a05:6102:809f:b0:634:eb91:695 with SMTP id
 ada2fe7eead31-6738b876346mr1484621137.5.1779366022964; 
 Thu, 21 May 2026 05:20:22 -0700 (PDT)
X-Received: by 2002:a05:6102:809f:b0:634:eb91:695 with SMTP id
 ada2fe7eead31-6738b876346mr1484515137.5.1779366022279; 
 Thu, 21 May 2026 05:20:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d09df0d7sm2370981fa.4.2026.05.21.05.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:20:21 -0700 (PDT)
Date: Thu, 21 May 2026 15:20:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 15/39] drm/msm/dp: Add support for programming
 p1/p2/p3 register blocks
Message-ID: <qslmbwi3xwdlc5fac4yjbxf5neckmiuy74en2wiccv3gos65ey@twcgc5wrayrh>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-15-b20518dea8de@oss.qualcomm.com>
 <zputabw52nsba4ddwg7gd22tyouobkmlpq6blos7w3kx457otx@gitmjwroo7ou>
 <55081f4d-f1a9-42c7-a1cd-cdcefc008668@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55081f4d-f1a9-42c7-a1cd-cdcefc008668@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0ef887 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=gUfPeOkTqw4iccYOCI0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4xZCW-FdprehPXJPRlWhN1UAE2sM6tka
X-Proofpoint-ORIG-GUID: 4xZCW-FdprehPXJPRlWhN1UAE2sM6tka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyMyBTYWx0ZWRfX85rEhhkGMwU4
 mYWWYpQYBekzD6xsDYjG2HrxoCOmZQAYiy/WiwUDZwmhfBIHmwGBAwKhOHZA7L89kC4/AkbHlC1
 t+jNxQ7hG412xWl3PtYpGni/TKgSESp16ZPtjW6PxYFOltftGa7tDtZE4Nt/FW8Ur9V86zUSGVC
 fEo7Gqi0gHAxEt48FVe/9aeOqiZJm/ft4O5ycojTslRS3NeaY52e3sv0KB+AC9bT5EVV3jxMBBW
 lFrO0A8dxrHhk1gUPHMWNhZHHp/9h71f50l03n8XjOXggBTxt+ZkP4Hizpan+16StGdnqjQwdz/
 CSqhn1J5Rz9ymoyh4mXfpZpMyETIQnmQ6V7XloA/M9o6SpfgzgBdIhvYMt6VxnZ+8riweuLsQXl
 pfE7igt+oc1IVE9/9gd6rjj260A/XDwS9ifZ30BlLtT/ST1ewjmGO1P1sjViFCCFRRJTx5Tq++r
 F6G/bT0Jl3k+Eg/gwGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210123
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

On Thu, May 21, 2026 at 07:50:30PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 2:07 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:50PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Add support for additional pixel register blocks (p1, p2, p3) to enable
> > > 4‑stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
> > > and msm_dp_write_pn for pixel register programming. All pixel clocks
> > > share the same register layout but use different base addresses.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 40 ++++++++++++-----
> > >   drivers/gpu/drm/msm/dp/dp_panel.c   | 89 ++++++++++++++++++++-----------------
> > >   drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +-
> > >   3 files changed, 79 insertions(+), 53 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 7984a0f9e938..ff506064a3fa 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -85,8 +85,8 @@ struct msm_dp_display_private {
> > >   	void __iomem *link_base;
> > >   	size_t link_len;
> > > -	void __iomem *p0_base;
> > > -	size_t p0_len;
> > > +	void __iomem *pixel_base[DP_STREAM_MAX];
> > > +	size_t pixel_len;
> > >   	int max_stream;
> > >   };
> > > @@ -561,7 +561,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
> > >   		goto error_link;
> > >   	}
> > > -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
> > > +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
> > >   	if (IS_ERR(dp->panel)) {
> > >   		rc = PTR_ERR(dp->panel);
> > >   		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
> > > @@ -769,6 +769,7 @@ int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
> > >   	}
> > >   	panel->stream_id = stream_id;
> > > +	msm_dp_panel_set_pixel_base(panel, dp->pixel_base[stream_id]);
> > 
> > Hmmm.... Would it be better to set it up differently? Allocate one panel
> > per the stream from the beginning and then simply get the first
> > available panel when required? This would require some minimal resource
> > manager, but then we won't have to pass dummy register base to the panel
> > code. Or actually allocate a panel when it is required? Do we need a
> > panel before atomic_enable()?
> > 
> In this series, panel come with MST connectors, Because the connectors are
> dynamically assigned, we don’t know which connector corresponds to which
> stream, so there stream_id and pixel base address are dynamic.

I read this as 'streams are dynamically assigned'. Connectors are fixed
and created for each branch point / real physical connector. Streams are
assigned on the first-serve bases.

> we have 2 optionals here:

What is the runtime requirement for the panels? Are they required for
parsing of the resources or only for the setup of the actual screen?

If we have 5 monitors connected to a single DP controller (via the
complicated topology), how many msm_dp_panel instances do we need to
handle the case, present it to the user and still let it select only 4
of them for the video output?

> 1.panel come with encoder (after bridge remvoed), like that:
> struct msm_dp_mst_encoder {
> 	struct drm_encoder *enc;
> 	int stream_id;
> 	struct msm_dp_panel *dp_panel;
> };

This sounds like a good idea. This way there is no additional resource
management, etc.

> 2. During enable and disable, allocate and release dynamically.
> would you prefer which one?
> > >   	return rc;
> > >   }

-- 
With best wishes
Dmitry
