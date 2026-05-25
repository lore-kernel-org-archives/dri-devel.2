Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13D6CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA3710E362;
	Mon, 25 May 2026 13:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y9hbBT09";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QvJ5R374";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CADE10E362
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:32:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PA4Y1B2145826
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=w7FmZpcTa1770YwRUngtr9kv
 50A0u+VdLPdImEuE8vo=; b=Y9hbBT09rYqNTqtaPtKPPFay5kQXxRVwpiuzd4pv
 0pOZxXHTYE69Cmetug0ZCcbfdysc//qZ2CIj1kkuuVq1yrbOYcgRWc78Q5AWmE1o
 Ox218RzYX2MTfIgwE+lZjZOnLZhHlUZEd2g4pPrkor+CvX/eUfzcof+KfhztomfN
 q51PtCMx+5yZrWk3zKJsZzWQNS13hRf+3SNBnvmNhIUAjy3uHJIKDuuQNFOCAAFP
 Nbirm/k/UDnf8Z2j6yL4+ixhxU1zOtjBI2pixiTCDhgjufMad2NiWSeT9xdTU/vO
 gJOtC9/WbNAN5F4YMDx9DtzTx0sZWBDQIiYJeH9meCbnOQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv0nbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:32:26 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e60dfccf42so1739982a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779715946; x=1780320746;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w7FmZpcTa1770YwRUngtr9kv50A0u+VdLPdImEuE8vo=;
 b=QvJ5R374v/4aFFfFPPMVHdjuwgKm1ABupkKsUX3gGYc5zjJ7jflskCwUm438cBPMod
 LGMFQrKgu7FfQmdHy+tghzIcytRyTIY47JdScxUrvw9Q5Wrpki22u5/Y3HbJndGe0ORP
 C1KNCyjcTA3i0rfRhpFcDth/GeKgOBGb4M7JvblffR997a2GmnN3HRKBiKwTvPiOkHzw
 sM9Kd27QU6qF1AMKdeGWTX3zpHkGeKQkpGuY3kGQhqS1b0F1L9DjaAtIFb0H2kZnen9s
 6zyxjxLuIsF17Q1WlMW/NE5yP0GSQ7PY9C2o8FUAttykglrxaJnf9ufP6s0ErCZyqVpM
 pj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715946; x=1780320746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7FmZpcTa1770YwRUngtr9kv50A0u+VdLPdImEuE8vo=;
 b=Lq2F4nH/34rQjvMDiaDtMdNKErOTz6rqGiryKJkWWBSjJpEeqfR5fqiz4ieKklqFp0
 1CGBqsBP81iOgPEwRGgAlvZnZjbtm08rM2C05S3dM5bC+0C9uAA/7ucUBI5s7JMY9zkz
 pjzGtVv2zvQv+nubcnEnMxKLVU52+g/sfaC/Wo2YjU8UYFCzbE3fU8MMENylfinAUCPQ
 oHEgCIYGV3ED/CSBkWdhW8ykGIp0iaJ03HiJty6I7r8aFsXQGWV37A7F25XWYvZM+i+t
 uj3XyHvGVJmZLTfTDtdzIwgwuH677oUew8DRnT4MbXP/Sf8+P18CCopU+pLhDhhSbsuR
 19rA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VZE5APPw860T9xcRT3nZ+JqG4vk+pJSepj3Ue84fDLroFBhNpEGp4NA6M/190PFHJoFoXR/3SHIk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTLuZeGz4zXUiP1MJ30YywJ9qA51L5kGuV7CWrLl07rnQM21Gc
 JtZa9lfUc/Io0Nh5YFcfgXbIddpEPe7xibghpoc2fnilhPhjxGLQCK1GowY3cycyAoEDG6PXl/7
 GsfGiUlyGSHsI48eL4kQFfw38tjCmHV/MblGIIAOJttRzZbCGBpRIiJqfbQePsQKtHi4uFNw=
X-Gm-Gg: Acq92OFKauXRvtAnOlsgeX8kSwEYHXjmhhQtDTe4DyUA43ei8gSa7xCqbwE40PiMAva
 2h1uurrTm9o/9R4Do8rreCSunGoZCnYEwwVW2MrefCumEg6uSayFckbB1K4mcHozwXKUOnWTqz0
 bXxyMWLlOKVkI4nFB8H/FGbeLLts8Y4uTYvc+DCf1GpeLYa5+LwBpKauS66WToUHW6+c+aLnGpR
 mP0dcmjqoTz6pVt8PUUtn0zw6ozw3ts/LX4GqZWpAHiqB4oF6rltJKsHo9uvXnMGoPKzkZsPRB8
 Z0AC52HpinHtD6ciLhOvUWQ5hEfJsQys4DebKIZHphspA7px5Pdo+8d5T1f9TlfV5HHigMdWsZP
 RuE/uj9a+RFROM0BDJSy2rtncwa/CLyUJOGYpQA7vVxGttRrwCGxJWcZ5u+wNVsJKXY3sgRdkKH
 jA9EqeBlb4z5W/nk6WHk+dqG1ynG7FQjAaR1s=
X-Received: by 2002:a05:6830:3887:b0:7dc:c338:d23d with SMTP id
 46e09a7af769-7e5fee9bb75mr9585816a34.14.1779715946010; 
 Mon, 25 May 2026 06:32:26 -0700 (PDT)
X-Received: by 2002:a05:6830:3887:b0:7dc:c338:d23d with SMTP id
 46e09a7af769-7e5fee9bb75mr9585767a34.14.1779715945539; 
 Mon, 25 May 2026 06:32:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb3689sm2722845e87.5.2026.05.25.06.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:32:24 -0700 (PDT)
Date: Mon, 25 May 2026 16:32:21 +0300
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
Subject: Re: [PATCH v4 17/39] drm/msm/dp: Add catalog support for 3rd/4th
 stream MST
Message-ID: <m5a2dsnyrxiexzvmqigpfbfzeopai6eqceph7nces4yp2ywbic@qvyl75b2axf3>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-17-b20518dea8de@oss.qualcomm.com>
 <roqivmstbvdd7mhyyljhmzxv5njvuqqgjdn5gkekzrclhveozx@fougiain3kfh>
 <2ef51545-e3e9-446b-a97e-a01d02fc4863@oss.qualcomm.com>
 <4t6jaqelrjdcoczdtnig5pwpsm4fj3fxo4sqh7222dh26dzq3o@yc3t7y2amsl3>
 <339aac36-db5a-4013-aa7f-58715f3fb9d3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339aac36-db5a-4013-aa7f-58715f3fb9d3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzOCBTYWx0ZWRfX1TwadnPiBAiw
 /qbs3+vK2OzSP1ZlmFBcy6bz0PeogMVt9OCGqM8y5h17ZqJw15ylVY2KTkmUosRK4PP8P18TeYO
 yPSEHKyiB0SWUlCqf0PdHYOqBGmh7CDvmaHdo89RRcX2Pcv8lPFCYaRBdXxrhHIrRs5FEiXv0XC
 YeGl5bU/Xdg7KFkf67gMmP5TZFQ0sTlMUP0jMDXUI9GAuNBDSXPa+JtkQW3RQuiwK5k3DwoqHC0
 kn1HMtYnwJjlQBzmgps5e4dlQ1pTcvDaghCLaZntHLXQ8K545QXPgf39THcGx5tZ5IEMO72MKum
 3lddgLxV+N9boozeS0b0zcaWgDOjWa42lGgCXZZxukpgUpKpeZ2BcykI0X0Q4R2W59hff8EzuJ/
 lPJpbuh4mVPHdxH1FTdDdiTRiwU+uSliusOJR5ErE4SObXjIMB/TCMoPdfEIJjbn7EABOsuGPEE
 qwKgj8lk/ZOhQY5Qbng==
X-Proofpoint-GUID: DwP5hHgVm1cJg0EOAVz3q2R_hvOsgOfO
X-Proofpoint-ORIG-GUID: DwP5hHgVm1cJg0EOAVz3q2R_hvOsgOfO
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a144f6a cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=uxpCQ_6U4hnA4gofv-oA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250138
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

On Mon, May 25, 2026 at 08:01:09PM +0800, Yongxing Mou wrote:
> 
> 
> On 5/25/2026 4:25 PM, Dmitry Baryshkov wrote:
> > On Mon, May 25, 2026 at 04:06:17PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 4/12/2026 2:24 AM, Dmitry Baryshkov wrote:
> > > > Nit, there is no catalog anymore, please fix the subject line.
> > > > 
> > > > On Fri, Apr 10, 2026 at 05:33:52PM +0800, Yongxing Mou wrote:
> > > > > To support 4-stream MST, the link clocks for stream 3 and stream 4 are
> > > > > controlled by MST_2_LCLK and MST_3_LCLK which share the same register
> > > > > definitions but use different base addresses.
> > > > > 
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 225 ++++++++++++++++++++++--------------
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +-
> > > > >    drivers/gpu/drm/msm/dp/dp_display.c |  24 +++-
> > > > >    drivers/gpu/drm/msm/dp/dp_panel.c   | 135 +++++++++++++++++-----
> > > > >    drivers/gpu/drm/msm/dp/dp_panel.h   |   2 +
> > > > >    drivers/gpu/drm/msm/dp/dp_reg.h     |  16 ++-
> > > > >    6 files changed, 283 insertions(+), 123 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > index a52bcd9ea2a3..1109b2df21be 100644
> > > > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > @@ -118,6 +118,8 @@ struct msm_dp_ctrl_private {
> > > > >    	struct msm_dp_link *link;
> > > > >    	void __iomem *ahb_base;
> > > > >    	void __iomem *link_base;
> > > > > +	void __iomem *mst2link_base;
> > > > > +	void __iomem *mst3link_base;
> > > > >    	struct phy *phy;
> > > > > @@ -158,19 +160,45 @@ static inline void msm_dp_write_ahb(struct msm_dp_ctrl_private *ctrl,
> > > > >    	writel(data, ctrl->ahb_base + offset);
> > > > >    }
> > > > > -static inline u32 msm_dp_read_link(struct msm_dp_ctrl_private *ctrl, u32 offset)
> > > > > +static inline u32 msm_dp_read_link(struct msm_dp_ctrl_private *ctrl,
> > > > > +				   enum msm_dp_stream_id stream_id, u32 offset)
> > > > >    {
> > > > > -	return readl_relaxed(ctrl->link_base + offset);
> > > > > +	switch (stream_id) {
> > > > > +	case DP_STREAM_0:
> > > > > +	case DP_STREAM_1:
> > > > 
> > > > Continuing the comment from the previous patch:
> > > > 
> > > > Or, can we remap all offsets here? It would be much, much easier to
> > > > always pass REG_DP_foo and then here, in the link reading code, remap
> > > > the offsets for DP_STREAM_1.
> > > > 
> > > The stream 1 offsets relative to stream 0 are not uniform:
> > >      REG_DP_CONFIGURATION_CTRL  0x008 -> 0x400  (diff 0x3F8)
> > >      REG_DP_MISC1_MISC0         0x02C -> 0x42C  (diff 0x400)
> > >   So remapping inside msm_dp_read/write_link would require a full lookup
> > >   table, which seems not help for current status.
> > > 
> > > Can we introduce a small helper msm_dp_stream_reg() that selects the correct
> > > register address at the call site:
> > > //dp_panel.h
> > > static inline u32 msm_dp_stream_reg(enum msm_dp_stream_id id,
> > > 				     u32 reg_s0, u32 reg_s1, u32 reg_mst)
> > > {
> > > 	if (id > DP_STREAM_1)
> > > 		return reg_mst;
> > > 	return id == DP_STREAM_1 ? reg_s1 : reg_s0;
> > > }
> > 
> > No, that's what I want to get rid of. You are spreading these lookups
> > all over the code. Push them to a single function (or a single set of
> > functions, one per the stream, but having a single frontend to be called
> > by the rest of the driver).
> > 
> Okay. I should got how to do..
> void msm_dp_write_link ()
> {
> 	offset = msm_dp_stream_reg(stream_id, offset);
> 	switch (stream_id) {
> 	....
> }
> 
> msm_dp_stream_reg() will handle all the offset. then callers then simply do:
>   msm_dp_write_link(ctrl, panel->stream_id, REG_DP_MISC1_MISC0, val);
> Does this match what you had in mind?

Yes, exactly!

> > > 
> > > //dp_panel.c and dp_ctrl.c
> > >        u32 reg = msm_dp_stream_reg(stream_id,
> > >                                    REG_DP_MISC1_MISC0,
> > >                                    REG_DP1_MISC1_MISC0,
> > >                                    REG_DP_MSTLINK_MISC1_MISC0);
> > 
> > And then, if we need to support more streams or if the map for the
> > registers change, we'd need to go through all caller sites. No, that's a
> > bad idea.
> > 
> > >        msm_dp_read_link(ctrl, stream_id, reg);
> > > > > +		return readl_relaxed(ctrl->link_base + offset);
> > > > > +	case DP_STREAM_2:
> > > > > +		return readl_relaxed(ctrl->mst2link_base + offset);
> > > > > +	case DP_STREAM_3:
> > > > > +		return readl_relaxed(ctrl->mst3link_base + offset);
> > > > > +	default:
> > > > > +		DRM_ERROR("error stream_id\n");
> > > > > +		return 0;
> > > > > +	}
> > > > >    }

-- 
With best wishes
Dmitry
