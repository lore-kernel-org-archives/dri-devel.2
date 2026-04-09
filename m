Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B2BF31E22
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76A210E83C;
	Thu,  9 Apr 2026 14:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eRa7KUUw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qs+AU70J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F71010E0B6
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:50:46 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6399bp342247256
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 14:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=cplHpuSTozGbY0Jmvy5FyyiZ
 KYefgRQbuZrxIqTcYAk=; b=eRa7KUUwZu0fn5u64rHjFvW7xavaLVxKl9CfM0uZ
 tzmfxm48ZzEyxec/4advgwLasVISXTIOyTKnoyN/W4T9eMbkx9gp/PBwGNHVPARo
 vDxnScMKvUWK7v1vtTNYxuV8qyPCRjZ4uCuhyzB39lhQAgbsl6p0b4Nw55N/wJMH
 y1/NOz4DwlAGaJQX1sA5tYnwhLwn4l2s/tOLHuJqk8F+wXwrKuu0/81AAzzBDiBa
 U9nr+eUYmOKcNI6g+4N3b2MAar3L0Jt1iDLLqUeB3Ct75klSAqj7MZ39ZjQJ/qPf
 S8EPaUzxBzUgc2o2GEy9iRae9tcX5lS16rJFyO42Gh4BAw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4de3s6tmh2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:50:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d831e8083so32957081cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775746245; x=1776351045;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cplHpuSTozGbY0Jmvy5FyyiZKYefgRQbuZrxIqTcYAk=;
 b=Qs+AU70JkM4b71Rl5y+UkKWZjTLAFS9/M80y0psU+qIpP+gGfNi4pM4XGLZOad+tBw
 5xbQLltjnhgWhaCVXBwOudtiB2WvSI6iHLwr6N8jn0qt/X278yYzdqcHvIQXHHLpI9Xl
 /b3yrB1j5fBXFf0Zo9VHk7qwt1lvctCBJxnBA2nFTyjdM+ZxiuIxTtzr4UaRh3bsC/DU
 G6T7kpECtu4fVR2SlEpocdC4CYbjBMQdLwMjXR7zR0s5MtQfVCYVuZlbSzzASaN0Mk4F
 3xlqVVSe9g2hZiY8TAnS9RIUGrvZgg2//aoMwxl75KcTraJgSvj3doA6Kvij/vmp5m8S
 CWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775746245; x=1776351045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cplHpuSTozGbY0Jmvy5FyyiZKYefgRQbuZrxIqTcYAk=;
 b=d/lRcszlAxzq9+FCxa8G7Np2cX4NeZ8jXCotbUvfZVz9w4trSxpawR1yOquZBAPQ+O
 C1R3QvaqQL+Arp7rOJYWBU+vhKFgrq1JX/GA253kgI3xkIGnFwMprDavkV64EjUTsNTl
 se4yT+BuE+zBskGI8oXaEfKfIArgiOPU4HXHRg+tG9Qk2gllruo2srNxKCsfHhV0N2O6
 QwGRTV6ziSgXsWHn1hw1fjp8RM3WslCPay+TOfpmGv6KTYtDrH4W+J6NOFWFhr+sDJ4w
 HRoKv7gR/9GoiaTwQ7CBEl9ezpexO3Q+rT4loO7pDHJiALR4T1a8l6ca9T4xbbcqDU4r
 fvow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXakxjMdFzHjsOQIcqcTaOg75F/xc4ZRFuzFL16qHcRB6i8yZlfT/BhR8h+aNCqi6BUyIh2uvBR4KM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCUGEKG1A56EKfSfFmogi4mfQtiZkuEQwAP/nlZPymy1Nox/7+
 fvvyxm+EjNJyQmJkXJspjJudPg6PIANH5VpvFLQ4m5H7lgbNfQhH8OL5vOde9hG+zcXe745CYOh
 0JLYXtagqTZTrjuTaET+p4YF+R8TviKjscNqvUucOujT7ja6we9sBaqS7RKe+P8vQzUPo8pU=
X-Gm-Gg: AeBDies3LYO+iXPc43923eCUIdapDF3Cv7BJns8veEm+0K6Nq1FlKv6JF0gAwzAOPuP
 lk6XGGQXneZqVC6qmMQilLN4NBKg0yMuSNK18ToIkBjURJkQuP9iZr8Zw3kb7C+usiqq9uWw5NH
 re07O5CszGs7YlRZL/N6vKT1nCOGgf7vCsGgNjmffWgMpXDzKA3sdqACowiotQLb+qM94Rsncsx
 5y5Ly2Ndqaf+kUk54j0ZY3VZ59U5uJa93Ths+ykBDEzLukfEIFuJ5kA/2+hzzyk3ySKUBQa5++Z
 tIENvYm2hdbQ6S6XmIYS3OZaDEj1iQX87DGPpNNxy++2dhs6UVWjTfF7txiII9hMT7f6AIvtQlX
 f7X5MqasHquv0J31X9nJKAGhKU1ekUaLkNS3Gyq6wVO1aR6PzPlDYka+QsAGZbx33JYxmpBydiY
 Ptw9B7seAKMG649VdrjnNj/m438v7ErEKyZt8=
X-Received: by 2002:a05:622a:14cc:b0:50d:aae1:7070 with SMTP id
 d75a77b69052e-50daba8350amr137926271cf.48.1775746244849; 
 Thu, 09 Apr 2026 07:50:44 -0700 (PDT)
X-Received: by 2002:a05:622a:14cc:b0:50d:aae1:7070 with SMTP id
 d75a77b69052e-50daba8350amr137925531cf.48.1775746244178; 
 Thu, 09 Apr 2026 07:50:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6c951a6sm5448412e87.10.2026.04.09.07.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:50:43 -0700 (PDT)
Date: Thu, 9 Apr 2026 17:50:41 +0300
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
Subject: Re: [PATCH v3 34/38] drm/msm: initialize DRM MST encoders for DP
 controllers
Message-ID: <3oa34fgquincznj7g6cou2iie3lwuctt2mawp5ckkqwq7etift@nmbmyyw6dvnc>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-34-01faacfcdedd@oss.qualcomm.com>
 <npxu4ybwj2dztn3dbvmkxiwqw27wyr57g7ps72ndst7cful6n7@vuk2rizlz356>
 <a69c3d6c-da4e-4ee1-984f-cb827c298c0b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69c3d6c-da4e-4ee1-984f-cb827c298c0b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Eh7MEjvVv_pkRjsiUio0uKTCx9VbCULP
X-Proofpoint-GUID: Eh7MEjvVv_pkRjsiUio0uKTCx9VbCULP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNiBTYWx0ZWRfX1opgtRCl48gA
 j9VyC7wR8yK+j8Ss9Gm1j15mPNmHBe/rXmRVA1ik8TGipX+oJv9qbtXZWhB9CZxZndKs/PB9cjX
 N4G37wd/jIG8jHP2cDbrsF7YL/XUvnnSMwoouSkc7u6S7bEJBesde5R7J8Fd0qW3W+wo9aaS8Nw
 K/zg7lUgt8n272s9CLqMKyHkjjehc/GYiiM0ZHYgnCqVzRE4r1DAEVmZWr5f9ql7EmV+V0X7MUE
 TmMPcOjYPebw2aUTRHoC4kyWPdtL9N5jisCc0zv8wgyc9nSuruUh3SdvwjJI0Za7qomsiDerr3/
 9g8jupk73QOQUm0pRdsdeRNo5beCi4jMrw/dRat23tTVFMfJ5vxUzDzdBSGCsTa+jNBlvxzEDD2
 prO1TPtRULUcm0SPjKqgDsBhLZhq70CKuadtrtAyQzd3sfNYZ05qKRyL6km6ROOl2ic5J0KzEDF
 Pofl1joSNaVyjviCCYA==
X-Authority-Analysis: v=2.4 cv=TZemcxQh c=1 sm=1 tr=0 ts=69d7bcc6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=x7XlNq7pBUMbsz1zpqgA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090136
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

On Tue, Apr 07, 2026 at 10:35:49AM +0800, Yongxing Mou wrote:
> 
> 
> On 8/27/2025 2:55 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:20PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Initialize a DPMST encoder for each  MST capable DP controller
> > > and the number of encoders it supports depends on the number
> > > of streams it supports.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 23 ++++++++++++++++++++++-
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  2 --
> > >   drivers/gpu/drm/msm/msm_drv.h               | 13 +++++++++++++
> > >   4 files changed, 37 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> > > index ca1ca2e51d7ead0eb34b27f3168e6bb06a71a11a..2eb4c39b111c1d8622e09e78ffafef017e28bbf6 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> > > @@ -28,6 +28,7 @@
> > >    * @h_tile_instance:    Controller instance used per tile. Number of elements is
> > >    *                      based on num_of_h_tiles
> > >    * @is_cmd_mode		Boolean to indicate if the CMD mode is requested
> > > + * @stream_id		stream id for which the interface needs to be acquired
> > >    * @vsync_source:	Source of the TE signal for DSI CMD devices
> > >    */
> > >   struct msm_display_info {
> > > @@ -35,6 +36,7 @@ struct msm_display_info {
> > >   	uint32_t num_of_h_tiles;
> > >   	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
> > >   	bool is_cmd_mode;
> > > +	int stream_id;
> > >   	enum dpu_vsync_source vsync_source;
> > >   };
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > > index 12dcb32b472497f9e59619db4e810abfbf610c7c..0b9d9207f4f69e0d0725ff265c624828b5816a8b 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > > @@ -653,7 +653,8 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
> > >   	struct msm_display_info info;
> > >   	bool yuv_supported;
> > >   	int rc;
> > > -	int i;
> > > +	int i, stream_id;
> > > +	int stream_cnt;
> > >   	for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++) {
> > >   		if (!priv->kms->dp[i])
> > > @@ -676,6 +677,26 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
> > >   			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
> > >   			return rc;
> > >   		}
> > > +
> > > +		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
> > > +
> > > +		if (stream_cnt > 1) {
> > > +			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
> > > +				info.stream_id = stream_id;
> > > +				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
> > > +				if (IS_ERR(encoder)) {
> > > +					DPU_ERROR("encoder init failed for dp mst display\n");
> > > +					return PTR_ERR(encoder);
> > > +				}
> > > +
> > > +				rc = msm_dp_mst_drm_bridge_init(priv->kms->dp[i], encoder);
> > 
> > This is an implementation detail. We should be asking to init MST, which
> > might or might not be a bridge.
> > 
> Got it. How about renaming it to msm_dp_mst_attach_encoder?

Sure


-- 
With best wishes
Dmitry
