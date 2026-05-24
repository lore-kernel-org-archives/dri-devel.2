Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1716CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 09:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABD110E054;
	Sun, 24 May 2026 09:51:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="plN+vWvz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XZ5VPv5Q";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32BFB10E054
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:51:17 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O35O762511185
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fEqqSKotT0GFkp5iRZUp2dFk
 zHVllsIMcz6/tSNgQLs=; b=plN+vWvzKZVE1ia/KxXPrRBF8IpevFd/XRznfoRr
 YKonHpCXbKwC7T9ikhveV73D0i9dZDvAyTnREK06gOiUQxbzOFfsmHvG3Nnvoe/4
 ODOnEcuZD/WFWE+RvMmKKJIJ69agh9VMvaD3CLhdUFAr1t13AEP/1tFEjW3Ip72u
 6ZFhH12UV2u5sioRhGkNyQHj38IlYEpvI89nH9wb8DqTOVGd+SbyfgNHQD/r1olG
 qk3+Slisen2dQxLL0suEnGKwgjmbB6aiKwuucKbXt/Ivf+S4AAbSRBUKMT/XswnZ
 jDqSUgC0UXZW935oAU9kIcXi2S1TyC476PLDex34dNeHEw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9jr9k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:51:16 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-57548c75628so6292413e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779616275; x=1780221075;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fEqqSKotT0GFkp5iRZUp2dFkzHVllsIMcz6/tSNgQLs=;
 b=XZ5VPv5QN1eHENSTtdeSW3E0usBlQDie8v65FqmmYquY0HrcpEJ1C9yQ0OkYNmRDcg
 YUw0xrnp5C0sd0PkPUH51ime2EFCPuIvH9KTc77pDyAXfY0/sUBCeFRpfcFMtGcnhSog
 lLD1kDFornzl/ZrFpqfIQp4xFce08n7aNKFpbdMw5WrAZxUJGLzTBkl07bwAD6GxqOxb
 lJJjELYUDL3c/dYa5NCVsbxGe8qmJIKZSQEhk/C3jZn+HklAO4nidA74QeErOWscD9uS
 h9Ze/VY36Ism2zUSs8GtprMm3VAcXBWcDY+/jWPoQ8VYCpyDBGa83JPV5K8t2nkabm9m
 UrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779616275; x=1780221075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEqqSKotT0GFkp5iRZUp2dFkzHVllsIMcz6/tSNgQLs=;
 b=F//mauEpOHRfupmJS0siiZQpdQybyy9Uru3M47I54vE87Qjw/gKhWr3MQbVPS8rmTf
 nKEYhLjr7utE8h3cY6TritnaTbKmSIdhK5/XvN1dEpRaKW62uHQBHbFBKZZJL5Crfs7Z
 poFYA0kQcOlxFcEGkcmXFvjGq6lNHpn8JdTYek8d1A2Rk2aUZctRkMQmB7tYoxu/B3G4
 ruVq6KdQr3eG60XVklqlQY8kT6AChN/nc/QBMN++ota907L4wohv+EDuBWBWD0k+T9WG
 m639mbKBwZC0otODaSBXFVhH9Wc+Bohw/H20kO5JEXUtJlUz9I3eYN8bUrN9s+2rKJr6
 vaMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/A2K4mRcq58UwF0Wi9iGRMAph+gmMfpIf9gGBOWh5ibc68CQzOnRgRYd7N6JJFwfSKYrU3qUC4ihM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzS7DWSCS538jk+26l9km7+zzcmlFyrIeiUQ+0BCZBZDJK4zowL
 Bcbt6148L2Oce4EVAvvLVLO/KoVFaYqbYqL9RZUm/Ti95rSTFWpdtGuc1+4bEOe2CJyiWkcQeyi
 yGdSuQ9U5OYzXXUu17zCr8XJWcLfU7C0/4sHTzVCIUkqv/XGcdpb033X/FODdFpTZ2ARXrMo=
X-Gm-Gg: Acq92OFRIql+h9hfOXAVyXmDO9nwODmuncUCsknCJsYrugLHCK7Snespl6wDTKs90//
 gpAGyrDm4O6QFMijk4LLF0XCMJJcSdDHE1udYpewgqjnI+lykTzx2/oEHXvw0f6cd/reRyEV/l+
 gcK/aQzDHfVPJE8lsUsyRPmYwBWBly/JTpRkHw6hxvJAsFlnfeLRFxYlLjTvNT0wmY+MldZ7Pz6
 WzeoLeqme0DTa8Idrw0MC4gJxsMvpcK2YMi6luMM4MC5ZbdGuYCRGBXXlDeW7b9x5ARiKTJUrJY
 GKVn6SyHNCBAsvXCJ9bAfpY2ChN8oA+1TtARN3m7ihp9d81xSevv3e6zUAqjKv/Gu5DPwNsc38i
 G2T+rgjcoHPIez4YQO4UfwG9A2iFXHKucFF+4GWr2m5wSl+R+xwh/6S+s7p0yHQ5zNUbZkFMM8c
 PEFn3qd7cwKRKCZ+g+nWIq+Tg0mN+mropXdtU=
X-Received: by 2002:a05:6122:21a5:b0:575:1711:a9c4 with SMTP id
 71dfb90a1353d-586624cfa80mr5296982e0c.9.1779616275311; 
 Sun, 24 May 2026 02:51:15 -0700 (PDT)
X-Received: by 2002:a05:6122:21a5:b0:575:1711:a9c4 with SMTP id
 71dfb90a1353d-586624cfa80mr5296971e0c.9.1779616274901; 
 Sun, 24 May 2026 02:51:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf2b22sm1816006e87.55.2026.05.24.02.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 02:51:13 -0700 (PDT)
Date: Sun, 24 May 2026 12:51:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] drm/msm/dp: Move link training to atomic_enable()
Message-ID: <une2soerfhyu3zjyn5qa2jkrrnaws75suw6ct6zayankz7mt3y@bjz2ed45fe23>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-4-0c8450737d64@oss.qualcomm.com>
 <7bfcdf7c-f114-4f4f-9ca7-6a0d31c856d5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bfcdf7c-f114-4f4f-9ca7-6a0d31c856d5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: HkKcNzV0MrnJTmQ_0pVTtcgPnuZ38xhW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDA5OSBTYWx0ZWRfXyNjw9zfOMyRv
 Qn7OiCW4XZRUqr3mif7OgKaZtjS9kmmKV/IJSMIYugndAOzOquLmB3WWLCyFPKFRFlmGoK0eAIQ
 FNvKZQ5EJSV8Osdkg35vCHnAOpboP/NW+QPdZ/2uPH3z6t1w3+ur9unAlv7ZTt/2hCZwD1k6VqX
 +q4Q9o6rprIC5KMyRg9CRb9v6reyS6pzIDtD7SNU3SjSMdqvO8O1cXlHy68EdFHO/1HGn30PYml
 UadVYXM8EXVRv29bgiR6Y1ufZunR3lhgWhrMl5z742OyrFZXh9ozgwFk9Mghub9vbid5iLKAgce
 4+lsvTlkaz/t7FdI8rQ967abpXPBvwMQL+opejy0oyTpdcJVbCtNt+6dPAC434BDboIXfso/+wf
 FU2NwuQcn82BvUSNrgD/CvDIVZyYqgjXuHDrZxjxEbk9JtzOP0eWKSkFUqSF7RzdaDMBl4aF0fC
 m0nBs30Z0VCXM8fASbQ==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a12ca14 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=RM-pzoYVJfQj4HWh9lEA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: HkKcNzV0MrnJTmQ_0pVTtcgPnuZ38xhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240099
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

On Fri, May 22, 2026 at 01:33:07PM +0200, Konrad Dybcio wrote:
> On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> > From: Jessica Zhang <jesszhan0024@gmail.com>
> > 
> > Currently, the DP link training is being done during HPD. Move
> > link training to atomic_enable() in accordance with the atomic_enable()
> > documentation.
> > 
> > Link disabling is already done in atomic_post_disable() (as part of the
> > dp_ctrl_off_link_stream() helper).
> > 
> > Finally, call the plug/unplug handlers directly in hpd_notify() instead
> > of queueing them in the event thread so that they aren't preempted by
> > other events.
> > 
> > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index a05144de3b93..e7b1ed5491c4 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -436,11 +436,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
> >  	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> >  
> >  	msm_dp_link_reset_phy_params_vx_px(dp->link);
> > -	rc = msm_dp_ctrl_on_link(dp->ctrl);
> > -	if (rc) {
> > -		DRM_ERROR("failed to complete DP link training\n");
> > -		goto end;
> > -	}
> >  
> >  	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
> >  
> > @@ -1695,6 +1690,11 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> >  		force_link_train = true;
> >  	}
> >  
> > +	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
> > +	if (rc)
> > +		DRM_ERROR("Failed link training (rc=%d)\n", rc);
> 
> So this will still crash the device if the above fails - there's some
> return statements in this function, should we bail out if that happens?

Yes.

> 
> Konrad

-- 
With best wishes
Dmitry
