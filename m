Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51543CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97C010E5DC;
	Mon, 25 May 2026 08:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJXaPUEb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="COADcdw3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A2010E5DC
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:19:14 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P6VSFw3881856
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jr2LPD67oEe9tTsajAyX2eh19LrOZ2oQSoyeTJxvAZ4=; b=KJXaPUEbKNCMnFj0
 f3IhHQJvGF+fLDP1oo/OA/zQc5/jDVYwGPmIaENAmbJE3IgWWLd1efmlQgSZLRn7
 whmOjkRDr4DouNkdwAxBVML0tT8wscTYOd4G3HXOMpXXY9ITaJm59IpRG1J0zqvr
 N+MeYQ1euLIoJwfVRr67V8n5didQwI/d15Y5t+q9EIivQTjaKah94F5HHcCnG46Y
 YnUF9OBvTMSOx00FL7FLubutso4oD5K/jSQBtnPHtU3rC2gJDOKbLaKnMD6XkVuK
 QxeozXO3+YUOnUsrLiX1/uNH0+DVtjZqoZkBE0FDUZ7zbbRX0QjNB7HZxxaoW51P
 136rFQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb386ny1v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:19:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51650041428so38056251cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779697153; x=1780301953;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jr2LPD67oEe9tTsajAyX2eh19LrOZ2oQSoyeTJxvAZ4=;
 b=COADcdw3uj3JX/497QsYfSi42svcMT0Brm6PPBYKPWfsv3nKI6xMS6zj61eCBbDiO2
 Ln+JYR1Hpfki35ur99PsXLvlysYEr68VGv2eVXGURXZTwNl19d0zala82BBTHfwXH1Qi
 NiiF0D8I9ARgVtVr9dUrCDikhChmXCmcW+sOodOjQCtBBF5O6/lWkI+ar8q1sijs4rtN
 ouCvf7QP49REIfBCm6JqbuYumIgTw7HnzXkDtBQpTJDMFT6x86kb/MLz7kPWgkMGB7MJ
 /D8j6fL9dSSVdFVI1ujwCApTCITxXHGt4onB1tEh2HUoyo7yB0fqPkRXOtTW6pJmM1/i
 6x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779697153; x=1780301953;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jr2LPD67oEe9tTsajAyX2eh19LrOZ2oQSoyeTJxvAZ4=;
 b=a8ko1R0ZV0GfE+WbFTg1PToSU/NIZG0bZ9Wrv+3IjrspCqkKbs2eH0EvhM0LiX/Ibo
 3e9AGBWVb2JAaLmyJfPLOdlQ0e/G2PwGhK5FneJqhrwjVbsJHSHEIQSAv8jmM8ZImzgh
 heOrBh02mAleID/Asog2jMIIaJ5YFVyH17CO396+3ETPNzyIGA6IMY1ygYajokmUKQxp
 KE2O+rSZHmSF2CjMaSupJxEhGzHGUjnvd+RHAKYLKVsZf7Ps8IqIQnAtbDSC8R7/doaU
 KMfRchTIVLD9xR4Vmos2K+Qk4lsUSXqAepaUmWYltgDYk/YirwFFDdyfJmEPUSFd0pT6
 PLpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/icNwKZPq2KPyZ0EolMOkV7PeofiEQhLm0zP1oDIIjTXGuVgguOSoDKKZ7d1KSOjIe7IGQ4kI2ZWU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNc+/W1J4XN2WRIePH7jqktUzoLiA28+fZAWr67zfHvKZYX80x
 ZISB18Iug9aQdQyAXsgZh1EiCb+xWiFMTgIE3zlAidjMG5DWevVyUxetSPt55hdq2vlUhwCU0Gf
 rvm4MuslOapw03Fk3Z8Oix2MoNOiWIZBeZu/bL77oX/JugYCJYJ/8NP6fj73RT84L+rfO6WE=
X-Gm-Gg: Acq92OFVpCTYQAc6mNmovdWqhrHoLML75BunPYRcqLB67e9WVcM3zHWnM31OdDJcqzW
 k0ymwU7GE8HZ/Iy9RitPECKhO72PCmzwoGeAeaKA2vg7BY+Ip6OZw8b+raCFc5p/EU6lXj+m3/x
 rRgFdeIyQr8QwYsskRNhP4Ay4vaxonqASqBlx5YOyUNXYpCQNhb0zA2j3mRVR61aQvizqUlTSxV
 9RIoA0lbWnGvYZQv74IjDGzD7iQKNicoMzq9Z9M0XCIsfmbWKl6QLiCvcXgN4vs+vnL5CwIoXvQ
 Gt1opMkLUJoeSLL4vvVed6R4Vdoy7pEPgs/VeOF8AS79Otr8/CtzxTGLrGLYsbyKoUMLjTWBlPF
 jTP3HhhIFo+hP+E5hD2SUHFA6UdrF0rMqjjOo7M4fs1TsI9DBohDGQo46D0s4McGLB46PB3A3uq
 2lAMTbf2GKDCf7JdgHvHeZUpozEagCOvpmKh0=
X-Received: by 2002:a05:622a:406:b0:516:f4f7:3325 with SMTP id
 d75a77b69052e-516f4f737b0mr44874861cf.35.1779697153270; 
 Mon, 25 May 2026 01:19:13 -0700 (PDT)
X-Received: by 2002:a05:622a:406:b0:516:f4f7:3325 with SMTP id
 d75a77b69052e-516f4f737b0mr44874561cf.35.1779697152648; 
 Mon, 25 May 2026 01:19:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc2c6e3sm23988181fa.30.2026.05.25.01.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:19:11 -0700 (PDT)
Date: Mon, 25 May 2026 11:19:09 +0300
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
Message-ID: <233pa7rqxl4plfk44utgdb4jizoonaur4ypr4oyytbzdz76bwm@rt3jibbck6lr>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-15-b20518dea8de@oss.qualcomm.com>
 <zputabw52nsba4ddwg7gd22tyouobkmlpq6blos7w3kx457otx@gitmjwroo7ou>
 <55081f4d-f1a9-42c7-a1cd-cdcefc008668@oss.qualcomm.com>
 <qslmbwi3xwdlc5fac4yjbxf5neckmiuy74en2wiccv3gos65ey@twcgc5wrayrh>
 <083fc602-7549-4abe-a11e-51dae9fd0c8f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <083fc602-7549-4abe-a11e-51dae9fd0c8f@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: HekIAbPrGPunhlJZ98PqCZh-TL5yQwUl
X-Proofpoint-GUID: HekIAbPrGPunhlJZ98PqCZh-TL5yQwUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4MyBTYWx0ZWRfX3atXhjYn953h
 mrsW1HXSMFPcjIs6tIZ7XFUGm8JtkFjGmowPD80W5VOstIfGWme/q3F1NEuLls0Jzg8MZEyop+W
 PGTB6c7O9+jG4kz7vtk68LnmxmNlL38JKpTE5B8U51NgcBVuibxFxpvMjI0YPOb4OM7kEU/BAAi
 a4HutE0NM3Bj0Kw4JBewXPdKdyG2nM4284SXfBptP+1enmBxTucDjLr/0TCHyfs6jGrsUWTKB/5
 jdr75L5IZDqJHKiUIRol3m0V/gekjqCPgmoI9U6uvl4T/uUDLkiYegi4ocjCaZIGTM+fA3KBjK+
 aRpllIgBZ6NKCs7utvicBSMMRO9/fJFQF01NjZO7St+lo9/347EfYstN6/mPM35aYS1UdyDzZca
 VT6AM6/OU38wFzy6vrg5vS7GwstKtDLcV/m3/dPJgcETY2yQCZ6DDGzRuq1IpBwwAhLEBxTfnUr
 Jj/6v77H/IJGm14HQGA==
X-Authority-Analysis: v=2.4 cv=PJY/P/qC c=1 sm=1 tr=0 ts=6a140601 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=EjYkQcJriFt4rTJH55wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250083
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

On Fri, May 22, 2026 at 03:51:57PM +0800, Yongxing Mou wrote:
> 
> 
> On 5/21/2026 8:20 PM, Dmitry Baryshkov wrote:
> > On Thu, May 21, 2026 at 07:50:30PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 4/12/2026 2:07 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Apr 10, 2026 at 05:33:50PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > 
> > > > > Add support for additional pixel register blocks (p1, p2, p3) to enable
> > > > > 4‑stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
> > > > > and msm_dp_write_pn for pixel register programming. All pixel clocks
> > > > > share the same register layout but use different base addresses.
> > > > > 
> > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_display.c | 40 ++++++++++++-----
> > > > >    drivers/gpu/drm/msm/dp/dp_panel.c   | 89 ++++++++++++++++++++-----------------
> > > > >    drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +-
> > > > >    3 files changed, 79 insertions(+), 53 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > index 7984a0f9e938..ff506064a3fa 100644
> > > > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > @@ -85,8 +85,8 @@ struct msm_dp_display_private {
> > > > >    	void __iomem *link_base;
> > > > >    	size_t link_len;
> > > > > -	void __iomem *p0_base;
> > > > > -	size_t p0_len;
> > > > > +	void __iomem *pixel_base[DP_STREAM_MAX];
> > > > > +	size_t pixel_len;
> > > > >    	int max_stream;
> > > > >    };
> > > > > @@ -561,7 +561,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
> > > > >    		goto error_link;
> > > > >    	}
> > > > > -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
> > > > > +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
> > > > >    	if (IS_ERR(dp->panel)) {
> > > > >    		rc = PTR_ERR(dp->panel);
> > > > >    		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
> > > > > @@ -769,6 +769,7 @@ int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
> > > > >    	}
> > > > >    	panel->stream_id = stream_id;
> > > > > +	msm_dp_panel_set_pixel_base(panel, dp->pixel_base[stream_id]);
> > > > 
> > > > Hmmm.... Would it be better to set it up differently? Allocate one panel
> > > > per the stream from the beginning and then simply get the first
> > > > available panel when required? This would require some minimal resource
> > > > manager, but then we won't have to pass dummy register base to the panel
> > > > code. Or actually allocate a panel when it is required? Do we need a
> > > > panel before atomic_enable()?
> > > > 
> > > In this series, panel come with MST connectors, Because the connectors are
> > > dynamically assigned, we don’t know which connector corresponds to which
> > > stream, so there stream_id and pixel base address are dynamic.
> > 
> > I read this as 'streams are dynamically assigned'. Connectors are fixed
> > and created for each branch point / real physical connector. Streams are
> > assigned on the first-serve bases.
> > 
> Thanks for pointing that out — your statement here is accurate.
> > > we have 2 optionals here:
> > 
> > What is the runtime requirement for the panels? Are they required for
> > parsing of the resources or only for the setup of the actual screen?
> > 
> > If we have 5 monitors connected to a single DP controller (via the
> > complicated topology), how many msm_dp_panel instances do we need to
> > handle the case, present it to the user and still let it select only 4
> > of them for the video output?
> > 
> It seems that if we move the link-related resources from the panel into
> dp_link,
> struct msm_dp_panel {
> 	/* dpcd raw data */
> 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> 	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
> 	struct msm_dp_link_info link_info;
> ...
> }
>  we would only need to assign the panel during atomic_enable /
> atomic_disable.
> This way, in the scenario you described, only the final four panels would be
> exposed to the user.
> In the current implementation, the panel contains link-related information
> that is required during the link training phase.

link training is a part of atomic_enable. So, what does your answer
mean?


-- 
With best wishes
Dmitry
