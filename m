Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ACBCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC48810E627;
	Wed, 20 May 2026 09:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BgyAbB5G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9wvYAo6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6192210EFB0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:22:16 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K6dCU5629692
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Rjtq3peL9p9PxOypZu985aac
 PSWUcWZM+8JLMllS69w=; b=BgyAbB5Gsbl9LTmJ8vtyhWifro6R02Xdj4PUD/Zi
 90tSQG0JbTDp21fX+TJcyLpRGU8tvmK6NtNUw7yWeuSjWYj3FWtjngtvr+FKXxnU
 mLTEK5bb7AKZmbcQH1TchB5lf/M2fb1N/tgGwkN7IP0G5wuZOUhpc298piePT95l
 aFQQcuIvnnCkr3/VRx928Wf1RXEowvm56ZXSNy6eEYNb412Zi6n0WWeZTZQYt6Ki
 IdMRVCCLyDCf7DGsuOom8AiNKX0DkGiS9lZxV9hY/16jMYUliIyhGqeE1jQquLbw
 y1fec+VevE0IHHLVhs+Qwj3MPMIJUkNIDwb2JhIUpf+u3g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3nv2e4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:22:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cc01da8fbeso22744796d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779268935; x=1779873735;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rjtq3peL9p9PxOypZu985aacPSWUcWZM+8JLMllS69w=;
 b=E9wvYAo6HTBtLpVjN+o6o2lmD1RRRwq4tOuacA46soNxYtc1XJnmAsm37hvXCQHwX/
 f1+KU9rBv1QCMnq+Eypba7nzVdPHE1xY4BgB2QFEl3I0Qj6vCEE+X+wz86Xmh0xojnza
 K9ONosPYsXJoqLU2vu9k4LLwWPkcn7531iMzGkgn5ZQPGa2MrKswunzDTJos8sziRmY7
 fH+ufrfqOuVjOv92gNS9ojVlgQc0biCVJFrfbGkoM6UONHX2Ktihttkmn2n3Y23vTXDn
 uckg4qWkaVpZhW+m29jrHrO9pTs4EKTCqLW5GJpWxSjclNRmbvbskiVvhs6fdSk/T5zO
 9H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779268935; x=1779873735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rjtq3peL9p9PxOypZu985aacPSWUcWZM+8JLMllS69w=;
 b=n1AZykCMSJOl7eWdsRs1mYPOIR5GnBM5KWWXXfpd/0m7KkzwEbYoMx7195vCHCk7wT
 ShwruWCkwCfvQhVr5QWiOoceNuLONlAoiUZclp2zAR1XrvwCeWNrs7OFwmwtbsgtJgSY
 hkgR62zcIYW7ByGjA2FygQQ7P/sImgoyrXrWPpeeBDIndRcT99ruayAJEQ6MX5/kCftR
 tXpLgeEwkl8yjOlMWPFYI0jGU7O2kthUXGiakFCRZgU98sNFU0IBqGzBnqZpGl4MsFEn
 rkna+X1Q461EPiFh+qZD2PofY3P/o+18Q20BI+zrVtO0dijdyfBtrZ5fu1QJPNR05UQl
 QmCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pGx7YQMs0AEGdDkDZwoGoAwmxQ1oabjN1BpKulc5AE0MHkbeUEajp7AF7vgcFmEu0npmAxJ51F94=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6N/lDAE6pNNW6uTOg5q2qXoGxXBYMNdfuTK518DyLZbX4Ne3k
 dB1/Ivs6dmJROLyYP3XGNt6uCxRTM4QKY7h5FIO3q9shnT5HJl4MEmsSVeQrG6BXaT7rUzI+0kv
 91eMgQLKwyJxDpBkaHXvL+5tQD6l4vrDoEQw63tli1r+PjULtZyF3Voq2MxvtKreB4bTdaok=
X-Gm-Gg: Acq92OFCcfMnlH2VhsxEb/xvDiYPE0vURyFlX1AaYSev3T6Ae7qTnKd2JvmPeI34/z+
 VJs6V9SUffuN8CiQYpxwLpspypQtY8+ek1o7z2wa0C1cR11oX0ZkVqcIUFnhxDA2rmC1V7P6pmy
 6DblYVPD+0FjPABYZ3IYpWgl9ddpz0L9cCSDyPc5XBWxerGIlctRu+a2g0K9XaOnUh5YAO7RuQy
 lRTnr54fToj9AACrRfne8ge3b6Jyq4WxshRaRAK3TNXm0sRIPhgsbGeMsNrZmrnlbmmQyyFlFsL
 ZnhrWcM8CE0tYS+XEMNBXzXoFmf+ivtGCRGYEp0U1cLmBucFYzRF2Lq6GCCTKArLP0v2nhT6VwT
 FGjLfh1mLVEIwcgCgC1hRGkvMGKcVRkPqoWFWHmMGzIlzSuACJsaW9uKMdErBskJC9H07++jVa1
 lX24Kem3KkyDyEpqs9IYj4G4+CnghVv0mpVyM=
X-Received: by 2002:a05:622a:2606:b0:514:845e:e7a9 with SMTP id
 d75a77b69052e-5165a023123mr326100751cf.15.1779268934671; 
 Wed, 20 May 2026 02:22:14 -0700 (PDT)
X-Received: by 2002:a05:622a:2606:b0:514:845e:e7a9 with SMTP id
 d75a77b69052e-5165a023123mr326100501cf.15.1779268934241; 
 Wed, 20 May 2026 02:22:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3958828150csm27404561fa.7.2026.05.20.02.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:22:13 -0700 (PDT)
Date: Wed, 20 May 2026 12:22:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/39] drm/msm/dp: remove cached drm_edid from panel
Message-ID: <k477w6qrrqugfjnnzj4h7f54ahehgpws2xfjgcyewqsakplnzl@e5wj4aqwax7g>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-1-b20518dea8de@oss.qualcomm.com>
 <7cnjdge435t55s5vf66fkjfmkz7jvcbbax2uuismyc74mv4eia@toe2vu2folqa>
 <b02965b1-3805-4ac0-8772-aa832f192756@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b02965b1-3805-4ac0-8772-aa832f192756@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4OSBTYWx0ZWRfX2uHrLAe+n6Rd
 zlgXSl3KpGWilh/SVClBzMRbzOZpPxSKsDFI0gnDl6f8TI2kLlQer0M9hitesBFb3B0bkkufTOU
 GuTgSMO6Og/k6iOOTLJ7xCX7ejKIM4O0Yld5mryHOtKLrQ/xCnJym+lkDUIm78X5cuD0uJ26GzI
 QCdr78yN8NZ8SmpEJiDSELY5LHasIAVGTgBYvOXhhTVH/YTQrMOt7OkpAAoa/PApceViUH2MjM8
 hPnQWtrC0JK1hwtdiCFIzvvjmJjFj+xOs/03lfqHQhpDyhw1T+efNV82z43fTdSZN1atFzJs3lz
 4Ph6BZjf8rgDjGKfWJKXsd5yG6gecv5pbR+waP9Q2HqTiCsqR+HdphSOtWCZxM0QcH5PnF+BJej
 Ko+X6plbbLZ6rKLNKh8fpfC2JFhOXy8gM/br5JT4eRfJr1494wp3CD+6AHAD1skf9NaDLWS224S
 fTTGLaeCtdJ6HGVrnJQ==
X-Proofpoint-GUID: pxDBBV7iA4lCusiMQU4gTyccboo_ctVm
X-Proofpoint-ORIG-GUID: pxDBBV7iA4lCusiMQU4gTyccboo_ctVm
X-Authority-Analysis: v=2.4 cv=Mr9iLWae c=1 sm=1 tr=0 ts=6a0d7d47 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=zewPlGMgYXjjnaek-JwA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200089
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

On Tue, May 19, 2026 at 03:27:00PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/10/2026 9:52 PM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:36PM +0800, Yongxing Mou wrote:
> > > The cached drm_edid seems unnecessary here. Use the drm_edid pointer
> > > directly in the plug stage instead of caching it. Remove the cached
> > > drm_edid and the corresponding oneliner to simplify the code.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++-------
> > >   drivers/gpu/drm/msm/dp/dp_panel.c   | 57 ++++---------------------------------
> > >   drivers/gpu/drm/msm/dp/dp_panel.h   | 13 +++------
> > >   3 files changed, 26 insertions(+), 71 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 5c6a24ec140d..e28cc1bbb5b1 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -268,6 +268,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
> > >   	const struct drm_display_info *info = &connector->display_info;
> > >   	int rc = 0;
> > >   	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> > > +	const struct drm_edid *drm_edid;
> > >   	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
> > >   	if (rc)
> > > @@ -275,10 +276,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
> > >   	dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
> > > -	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
> > > +	rc = msm_dp_panel_read_link_caps(dp->panel, connector);
> > >   	if (rc)
> > >   		goto end;
> > > +	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
> > 
> > Where is it free?
> > 
> Ohh, i miss it, will update next version
> > > +	drm_edid_connector_update(connector, drm_edid);
> > > +
> > > +	if (!drm_edid) {
> > > +		DRM_ERROR("panel edid read failed\n");
> > > +		/* check edid read fail is due to unplug */
> > > +		if (!msm_dp_aux_is_link_connected(dp->aux))
> > 
> > Does this work for USB-C AltMode usecase?
> > 
> For USB-C DP, i think it always TRUE, here should already existed before
> this patch..

I'd expect the answer without the 'i think' part.

> > > +			return -ETIMEDOUT;
> > > +	}
> > > +
> > >   	msm_dp_link_process_request(dp->link);
> > >   	if (!dp->msm_dp_display.is_edp)
> > 
> 

-- 
With best wishes
Dmitry
