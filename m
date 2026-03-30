Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF8FB3D03
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3E310E616;
	Mon, 30 Mar 2026 10:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYEqS+SV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMQ4BGfX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49BF610E611
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:36:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U8PxeC2458383
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Ljcssy/ERf4QcGfS8vs7FwRb
 Tir6aoFr0Gd62KpTua4=; b=kYEqS+SVU41e3Atdxm4iYAnATL4KZ+TCmmERRhUh
 +sqSTorjgusQWZYcl+v+5TwAEvhC+wvYgGSJ2IBKTbhB1DWgwIAVD+CChToHEQDO
 9kBFZT+PFaCIn4vLnL9nMUMi28qFRvj9Dw7FoOqZ9DGSks6lTrjV6jEJpXOdKQC1
 krWTV1v0EppikB+C0MnG27KWbhLUuGAR16kSDE9Zs0A9iYtaHLQFu4HZMxT8k56j
 PGLHoCjUEevfp9i3QoZmd69gla81dZOaWA8N9nFxM8uAYQh71VzTPGbyCDUA8iu5
 ZwH1awYo/0Keb67yav2Q6+WRvHRuwHHKiVvnp5Th2bZXng==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7nnmrhmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:36:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50911c94db1so106498921cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774867002; x=1775471802;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ljcssy/ERf4QcGfS8vs7FwRbTir6aoFr0Gd62KpTua4=;
 b=OMQ4BGfXg1DdBamqb8OcqekslL/3jYoyGRqKOhRJR6Mz5rhPvQkLbxZP1p30pJUtTQ
 UwyXCRSPN9fGbTV+4+CiQ9Bck5+RQq8avrQWsXTyUhz+jZP2kXWzVN+Rv2q/lBM68DZT
 saHbPGxqqOgUzFjBrnIgyhgBZfU642WLtWVcfQstVrHfIDBhOqnHj4KX/CHujkvVPrzq
 JOPZ31Fhm7XV2l5V2ZjDbQEHjE249VY0R3IfsG3PYCyGbqqbuH+ASQ2hv4MYM2mZdIC+
 Xdifj8OUt8CgeqDdmJRsCP0Ff9ThXUahpQhH2EdFWx/cgP0RJx6FIl46fW8EXV/AP6z6
 7jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774867002; x=1775471802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ljcssy/ERf4QcGfS8vs7FwRbTir6aoFr0Gd62KpTua4=;
 b=qhv46lE5jPdtMSewi1JMNBA4BTzJHgISBq7qNgukIBkHqui4Ypd9kgZHVfvKIU3hjB
 GTSIRVttrzkVyOo6PFaE6V3/ifp9SNkjfGTfmeHXY2R1wmpbZx2lxDnMP0MaPds/lr4R
 468HxPWDjfDK77lLR6pHwc0PQVrc6q3J4qqXi24LZpPH4TN71EHsyRSinWym3d09f9Pa
 5UWaTthFw1ADWL7ASRqmkl1TikBjq8+Ny8x4NJLknsCPfoXTg1OPsj6BAM29azwaviek
 W52hpivT2SvJIV9phEcJhD7jlVIyd7pHMpUZUttsUv0tBuziEfaUwoay1iT9/JGCDNXt
 hLkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQEZcA+Jyywzd9ZA2iGJS/wk7kwK8Sn5lKjP91sNUF64xcp7cCb9szauqSqywF2Ins2dcQITWpwKU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxn1dTbDbMaIzGaLPv3IRwsNRPk0TYPL0AdHL6XKKnU8736fsjS
 agdpf6p0QgSwQCrATNYAt923fHRpFYVe7WfkezzvrFxxF273PYvjqkeQHdNtj5LX4sfy9nRf/M6
 qk5HkgpuJZPm5H0Heyz3pQ9GlBC2XND/zS5lxpoLmUPbb/K3uh7BIZbehqq8liedviZxzrKg=
X-Gm-Gg: ATEYQzw5H9XJdnHDWFtquUXaZdeufMfXRDGwc42yKM3YWZkQ2W+ooVHZGubK5Gsli6H
 TLHnhxBslqqffrOmB5ebl8AsmHb/68wR9nCBlqd/XJVlz0BfLXbXS7xNktAydHnEqswjAfTWoMT
 JCe6Outpcx2VPLPj3P9MpL5gVW49wGdKLaE2tl4IU22bPh7OADXOmQdSVyAlQAgJg2Br4OlqQHF
 IW3TsfUQiPxKro0IEmsUyxhilqmsngikPORtWCf19aIzlcX7fMx4bR8zYxgSOnTHC8TNzKovCqq
 4jsZLRtTN2Uk2cvSp5iH2+EfAF4HhugaxtNc7diqghLVNaNUHhirUVdcV3NL5MxTOPY2+riiG9m
 bB17umKuaFuHexiOwQp7pdkphKGCt9YnAcMHwy6NSwQru3lVN3GVCS6ehjrPs2P/wdu8GGDg5KM
 KJJUzEn15UAtZZW8d3XDoP5yuUafKd8SfZdeY=
X-Received: by 2002:a05:622a:345:b0:50b:352d:6b5c with SMTP id
 d75a77b69052e-50ba39a4ef9mr160734681cf.64.1774867001717; 
 Mon, 30 Mar 2026 03:36:41 -0700 (PDT)
X-Received: by 2002:a05:622a:345:b0:50b:352d:6b5c with SMTP id
 d75a77b69052e-50ba39a4ef9mr160734411cf.64.1774867001254; 
 Mon, 30 Mar 2026 03:36:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b144f4eesm1549972e87.57.2026.03.30.03.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:36:40 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:36:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 12/38] drm/msm/dp: introduce max_streams for DP
 controller MST support
Message-ID: <iscoaaduakkhs4rpbut6alybigt23vxzezl6o5iemrelkrksad@6fmew7afqogi>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-12-01faacfcdedd@oss.qualcomm.com>
 <lngtq2tw4qajgjk57un5xrveblkmtjkkz3yjgue53vp6wwmqmf@owderf4zerfq>
 <7e6a7bdd-a94c-418e-92e6-524a58cdca46@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e6a7bdd-a94c-418e-92e6-524a58cdca46@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MyBTYWx0ZWRfX1D6sl4bPEPW+
 JfdbztTDUzz/+0lgCDjdnwn0ss0ahWCrVZVuQp4n8IaD3+auawYTcxNSJZdBAT+jqrkVNXVljRu
 ZZ9tqnmNnZvplDSQFfy/urS4JLIeHBPl19ZRBicV+dJgCF0Gi4R4kjzwIq86o8PKy7YiMk5djKV
 t1OXD3IkxxhZVva3zGCXlG6qhryE/8asfp2lpcqZm40OI0bRQM338KA/x20HFXmQGJuCsh3hROL
 4RQ9FwoT4QZl5nvaBrZfqASH3t3xZAF8+Y1xEdWZQ67TwBuem01gRehPtjqxqcDjOTkrAdeTDlK
 SQIe86CVDFuRPTuXB2lMkgLnYnDqKNZ9AbDsjGvniWUw37tI2CABGheiyRAT8RqAS5VFspLrlZf
 cAZqg9fQOhEA4vO84icXz1KW20E/QX/AAdV1CCHr8Kq/2BD/B11rUj2+EHdPHfIIqWngyJguHkH
 Lvf+Ztkuyx+28ucB3gg==
X-Authority-Analysis: v=2.4 cv=M4FA6iws c=1 sm=1 tr=0 ts=69ca523a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=lhG8_MBpUet3lCht9r0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1FGffWPsmMU678_CUNTP9x681DPZD_qj
X-Proofpoint-ORIG-GUID: 1FGffWPsmMU678_CUNTP9x681DPZD_qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300083
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

On Mon, Mar 30, 2026 at 05:59:28PM +0800, Yongxing Mou wrote:
> 
> 
> On 9/2/2025 5:41 PM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:15:58PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Introduce the `mst_streams` field in each DP controller descriptor to
> > > specify the number of supported MST streams. Most platforms support 2 or
> > > 4 MST streams, while platforms without MST support default to a single
> > > stream (`DEFAULT_STREAM_COUNT = 1`).
> > > 
> > > This change also accounts for platforms with asymmetric stream support,
> > > e.g., DP0 supporting 4 streams and DP1 supporting 2.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 21 +++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> > >   2 files changed, 22 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 78d932bceb581ee54116926506b1025bd159108f..a8477a0a180137f15cbb1401c3964636aa32626c 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -33,6 +33,7 @@ module_param(psr_enabled, bool, 0);
> > >   MODULE_PARM_DESC(psr_enabled, "enable PSR for eDP and DP displays");
> > >   #define HPD_STRING_SIZE 30
> > > +#define DEFAULT_STREAM_COUNT 1
> > >   enum {
> > >   	ISR_DISCONNECTED,
> > > @@ -52,6 +53,7 @@ struct msm_dp_display_private {
> > >   	bool core_initialized;
> > >   	bool phy_initialized;
> > >   	bool audio_supported;
> > > +	bool mst_supported;
> > >   	struct drm_device *drm_dev;
> > > @@ -84,12 +86,15 @@ struct msm_dp_display_private {
> > >   	void __iomem *p0_base;
> > >   	size_t p0_len;
> > > +
> > > +	int max_stream;
> > >   };
> > >   struct msm_dp_desc {
> > >   	phys_addr_t io_start;
> > >   	unsigned int id;
> > >   	bool wide_bus_supported;
> > > +	int mst_streams;
> > >   };
> > >   static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
> > > @@ -1213,6 +1218,15 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
> > >   	return 0;
> > >   }
> > > +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
> > > +{
> > > +	struct msm_dp_display_private *dp;
> > > +
> > > +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> > > +
> > > +	return dp->max_stream;
> > > +}
> > > +
> > >   static int msm_dp_display_probe(struct platform_device *pdev)
> > >   {
> > >   	int rc = 0;
> > > @@ -1239,6 +1253,13 @@ static int msm_dp_display_probe(struct platform_device *pdev)
> > >   	dp->msm_dp_display.is_edp =
> > >   		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
> > >   	dp->hpd_isr_status = 0;
> > > +	dp->max_stream = DEFAULT_STREAM_COUNT;
> > > +	dp->mst_supported = FALSE;
> > > +
> > > +	if (desc->mst_streams > DEFAULT_STREAM_COUNT) {
> > > +		dp->max_stream = desc->mst_streams;
> > 
> > We should keep compatibility with earlier DT files which didn't define
> > enough stream clocks for DP MST case. Please check how many stream
> > clocks are actually present in the DT and set max_stream accordingly.
> > 
> Now these DTs should already have the MST clocks added.

I wrote a different phrase: we need to keep compatibility with _earlier_
DTs. It's called an ABI.

> > > +		dp->mst_supported = TRUE;
> > > +	}
> > >   	rc = msm_dp_display_get_io(dp);
> > >   	if (rc)
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> > > index 37c6e87db90ce951274cdae61f26d76dc9ef3840..7727cf325a89b4892d2370a5616c4fa76fc88485 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.h
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> > > @@ -29,6 +29,7 @@ struct msm_dp {
> > >   	bool psr_supported;
> > >   };
> > > +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
> > >   int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
> > >   bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
> > >   int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry
