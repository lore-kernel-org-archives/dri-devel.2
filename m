Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21174C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7894610E48C;
	Tue, 18 Aug 2026 03:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gi7yg6CS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jdt2KGXq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322DC10E48C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:23:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLki0Y3370359
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/Mj3SzAcaCvmOfibRhtunrb3
 JChcTu1mYYWf77aYRPc=; b=gi7yg6CS3RxGzgedATshcmJaiGXWKnB2gLVvLaXH
 hblFxCEsGbQ8T+Wfp5yRC73yoh0cDC2MmPHF5vmXT994rkU0z2erOup7s7coJW+T
 LarnShSR/xs71I+vPuRdYJN2Ti7V7Xz+Ahqz+qDd2yv5DW939Sc78whe+eDLzI0v
 Cpob1u2wVHwQ0GjwH5CYJwCzy073L0Ktd6hP8Yy1s8uttIomxS/7hXfFyVfZUAT7
 8OaAPCeptjLxrQDG+lWbWF48QMqc+5J/Egy2f0wF/j2a/JNkqv+sN1BjauysRPFQ
 J7G7MXFCpMDwiRqATI9FYOqwoR1Ze5mqJFVQcN5ogSsI9Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xykc8km-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:23:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930a098ea19so560108385a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787023432; x=1787628232;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/Mj3SzAcaCvmOfibRhtunrb3JChcTu1mYYWf77aYRPc=;
 b=Jdt2KGXqacQlIL5QD4BmIJsnjKX2FKwfv5wo59YbeFMp5O9G+xPt6k3XxDo5S0ppSW
 iYu+d/KBpSo32DU5yI18snMudOHP7J1PHhoRYdaEFVZbbjPqAC9d0p2wT+ZOv8wCmEzH
 aU5uVKMwvoIY0DCizTBREY9t1mnuu2M7vO8XyXB+7Iig/mQIsgVNLKwgwLAr3zu9ww1q
 IdAqT+wBs8nlI9qvxFyLm+pjEbm8aTqrWxV9oeCFozU1WqQpaW84bZzyQoslyhzmECcc
 DpJsPu5Cg1fPO+fGNFvz28a3PPEAcPSG1z93UH4j16U18nbYiLePTjcB5+s0PZ2Lju4q
 5/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787023432; x=1787628232;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Mj3SzAcaCvmOfibRhtunrb3JChcTu1mYYWf77aYRPc=;
 b=oPyoFWFwPDBj52F9I1mBDmRYF5EsaHM4G4pMspw2p7Y7zm6nu3uCNxTE2TMyqPn9hc
 1gkUhBHWqQJe/G7usTWTuiFsaT/YEGaZMlZUnbFg03xb5vLtrptn4Y6j0mW7EylQLIBl
 HjkeedF38qCA/2N9lEqAcya8vgmAgOIq+cuXQ/t2Z9Mo1T1R2eURdq9eQn/j5Ez4m7yS
 pfZh6wr2TuJqDSMFtNtPAhjh37pEBIghr8CujE1UGhLIvUGwujdMDj5HdQmORbNuXTjm
 qNQR8/aYgJ13btMSZ7SSvHJxRmbRPKqpe6CzPAsNooMGkut3bSlwtSMOzZT+yHgpRryP
 wc0w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5pIDRmKYRQdynVOYrybP4JWfI9hZpLzGkGwXxMoalHI8y5vM4QHwekan97z6xPI9uJE/bgzpH8HU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAdjk3vlGA59OFuQwqLffAdqfQ0WxnwujnaICXLWiEXwngD6Zd
 FqKiKOj42lXRS7UpYhNOIVbQiNnWuro+poW4qnEzhVZjXd3Obop2AlU/hPDKEEMF7LFUFUL//Sb
 5R+p01fXETvHDRB4chvQXv8u0lYIHIqsldL1/EGPt333a8KGyfr/DUGBhLb1criH7TuPf0NU=
X-Gm-Gg: AR+sD12zRA8HRW4c4mgiOCgTsn25wouTTn8KiOB70kPjEoTpj0lYvuZQkZ8mIkYidmT
 TJA0liFxBHMc4j2whtwXDOJiNO9g3wG5p1QOAnDc0493CSRyUdQXZ2CZdJ3UzwJkStgFnlQiPXs
 isbOwDdBHI6WmGguGkFj9yW5y1o3sE76p0bpeJ0RTfTWfRpE14EEctdrf5JmrucEhTr0IjUofxf
 ccAhZ97UbYE9u/urYKMxD/nq1XG9Bg8hPksDVhOOR8NAePDrlBTItEAbWMIRuHgKOivbzz0DWf7
 H6FXNUQQD+7skPEcGTsv04qcsaOCywDwFzUwtBbO7lp0rFm/1tgvBVwoSDTw8blPs7CjL03n1Im
 rQsuc4i6CazYSIVxAzj7Nals8a2n/DhQpzoI8bYEVcTO8FYmVLuiO9VzdfdCT/fQxx7smFf0Ypu
 +uaB+QXkmf64zq
X-Received: by 2002:a05:620a:1786:b0:936:cd74:4f45 with SMTP id
 af79cd13be357-936d232e6cfmr2796689385a.37.1787023432424; 
 Mon, 17 Aug 2026 20:23:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1786:b0:936:cd74:4f45 with SMTP id
 af79cd13be357-936d232e6cfmr2796685385a.37.1787023431954; 
 Mon, 17 Aug 2026 20:23:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cfa096asm835514e87.19.2026.08.17.20.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:23:49 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:23:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/msm/dp: mark the SST connector disconnected when
 MST is enabled
Message-ID: <ue75tcf5hwigfvo2pdcmkako2ovvgoxte5oeqs5an7fsupfqk2@oe2adzbdhv5q>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-5-646a10256233@oss.qualcomm.com>
 <sijdmdhcbxyg23gh6c62hspruvbnyqbdrtv2er3bh6n6ftolsp@b6o4khv6dofc>
 <96344518-c0d3-4424-804a-c315eab3e39e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96344518-c0d3-4424-804a-c315eab3e39e@oss.qualcomm.com>
X-Proofpoint-GUID: H8YR2v7yV0evVSrH762Y1QKh_hPLBEj8
X-Proofpoint-ORIG-GUID: H8YR2v7yV0evVSrH762Y1QKh_hPLBEj8
X-Authority-Analysis: v=2.4 cv=dLaWXuZb c=1 sm=1 tr=0 ts=6a83d049 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Q8SuEDP3D7tb5lYi7iAA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyMyBTYWx0ZWRfX/DKNE8Eie9oo
 5c7/85rn8SXQyqAO6LDPvoONDeu3N4dYjM0zuQXUmnuoiC8/E5FBaVxzE0veHN0ujoTO0zpt0XE
 lJl+Zx8Md0QRvyF4n0vkhguMZM41ufsca4QfoFrL4ZbwgiweA7CNx6YI2PwRm7eqodSLiGnQ2V+
 Y3Qti6pUb9a/F1HY9LeCkCNPiCFjARV+ERgPvrkn6d340EvfoxCuRRaU0wZDuDQqLQF34Y3pPV8
 KKqxJXybndJgGp6nFPlttqLr/dh4guVmlfL60DdHl/SypesGJZTjv/C7eDzQTxdWCVXNNPpPbbp
 9cxd5FeUmsN85dgwWamRJnAE5MU+A2Np7V+MqYkcMlSXg36bGQifhkiY0IGnP4WrxVHzo5s/mim
 jPne+oRdO1FHzhEc6tJcpr1IjPhMUyjcN5ICzx0kWn76WVnCrkCO85+1TtTonG/K2sL0o38Es9g
 5mxKbPNXMiAiXQrzD+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyMyBTYWx0ZWRfX4oZWBrIXhtxH
 8Zn7p3aJnlW3obDFQ4kshYHQUekp4EMEYZ7cxuHoEKJ0qTGnXd/FLjpKEMo8ZPs6249ZDpXRqET
 BvX9u5scU11eSkktoZF+nUlucD5aDpI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180023
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

On Mon, Aug 17, 2026 at 04:01:34PM +0800, Yongxing Mou wrote:
> 
> 
> On 7/12/2026 6:56 PM, Dmitry Baryshkov wrote:
> > On Mon, Jun 29, 2026 at 10:48:07PM +0800, Yongxing Mou wrote:
> > > When MST becomes active, the initial HPD plug notification updates the
> > > SST connector state to connected.
> > > 
> > > However, the subsequent SST connector detect path reports disconnected
> > > while MST is enabled. This connected -> disconnected transition is then
> > > observed by the polling logic and may result in an unnecessary hotplug
> > > event.
> > > 
> > > Set the SST connector state to disconnected immediately after MST is
> > > initialized so that the detect path does not introduce a transient
> > > state change.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 4ee391cc7165..f8ca60d6d714 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -352,8 +352,10 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
> > >   	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
> > >   		msm_dp_display_mst_init(dp);
> > > -	if (dp->msm_dp_display.mst_active)
> > > +	if (dp->msm_dp_display.mst_active) {
> > > +		connector->status = connector_status_disconnected;
> > >   		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);
> > 
> > This should be a part of the MST series.
> > 
> Got it .

Also, you need to take the lock to modify the status field.

> > > +	}
> > >   	msm_dp_link_reset_phy_params_vx_px(dp->link);
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > 
> 

-- 
With best wishes
Dmitry
