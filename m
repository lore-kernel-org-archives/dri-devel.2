Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4EDCD98DE
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3463A10E25E;
	Tue, 16 Jun 2026 00:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MaKPAN6H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ADB6Eu+V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5FAB10E6E4
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:44:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0OGn61914887
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7zc5eDmQnq/IplllR5eB1g7D
 oy3n+pE93DScVljOljw=; b=MaKPAN6Hs08YUzzGdefVdfGEzU8ikH7dqofgXvX7
 AA1ScvVLo1sPrtKVRM1CcrlihucQBI5m+AQ9kwmZi5biqHgEBKlsCM8W0xbpJ3T9
 4tsdsdozM1tQ4WfbIOBh/dzMquvDyFzo3FNmq1DPK4awrCjqoSUJZHTM5cJx07Nx
 yiq7Lly4apXTnEsgGnJJTNjR0lxHnkctKAWjmcZUKi/N9jDcWx138RB6VYlcLe4F
 M19e7MIFu8Ic+l5V2FWgf/AIsvA86zBfVyWGyzwHDAzib5G4/T1cwRL3v2EVAPa8
 lUUy1AUy7Th3TPBWF2XmpPPwvnlNFzkQy6WTqoU0C0w50A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx3ttc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:44:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9181f3cc5ecso484420385a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781570656; x=1782175456;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7zc5eDmQnq/IplllR5eB1g7Doy3n+pE93DScVljOljw=;
 b=ADB6Eu+V2GN+jEecO+n5g8hHQlZu6ndPlD1gPQhVlRufbISKZ5cAa26pFaaekMjFX6
 airSzN/dZc40c5FPmS1OQC0pL92w6E9k8N67MFzOKHnoDuy+WiwSXPEE4WHNakkmNTjP
 tGkuelGBEOIFwOqyVB81JoSOhXRWUKHsfIhtDT88Baieh/hC+OPOlY4MgS9oGjJ8GqM5
 npTSBnHUPvwM3tUhBEDHYEz/3TnyHvgdft//Mk9IjZfKYVb/hu66nXhSSKL9Oe7TTc9U
 OsB0WPM4GQchEAQor3D0VbQ5zL5lPvReJ5I5Z9DF9OzJYZMIpJya4OX0sGmlqVj3Nvmh
 WpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781570656; x=1782175456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zc5eDmQnq/IplllR5eB1g7Doy3n+pE93DScVljOljw=;
 b=EMnaZD6S/U6qwpQ1pJzK00sZrNjKnKFm1nmisjMFEvOyOHd1Ay/uwHZyc4XyfGou0i
 nDizXQbZzd31YMzXZKn+H7kY6RuF5A+IWtRIw/ZFlptJc3KRJjPARzDfCPa6MZatSTfS
 /Q0LWdGWqrK8aqVLiMqHxay2u+Pyk8QY8PHEdwPQhxKJNFI58L+hxBA1KGIbVmlxa+Tm
 mx7TAX49Uh9IEL71e6lYWb53Qr1tfkEskHYOtvFCtZX6B90N07J4h1KD4hE0PBPie6c4
 y1gDiTY6j6m7UtpG4WygPs8tYu27jKjrH/GP1uo3oBqkOO4vFiMJct5yWY6xsvsnyH3F
 YseA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sAioKnYv6m3tVSi80gjd6RZJcnbVqBwYwbkyScnHRGMpDr9ETNQuO+SOB5TDntXkfnTSiKxnZpTE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4xHgxvRU7mt6N8yYznFda2ygBQ44uYnh+2oMpkxQJL9WbRDPr
 N9qqHXGjCjIeTnZFgNrifkAUbfMixRC/RN5XGNMTAfP3uQJZn5ctiZg+5bv3zfbqsFy+KCos7AF
 CFIDFSB5yW8dp7S9bY++mR43dYatGKNXuIYGc3KV2kYNQHPzhz6OPvsW2mDEyJWt8v2FxErE=
X-Gm-Gg: Acq92OGqPxD5xkT3bh0PsK0PV/7ZfWyXkvAxbsChgDNIJTg85qNxUGLG4CD3QS/GE7T
 wY6g+GD3cJo5XtPe5cgUmHQ+UDnN/uARPJSzNNnv2eE8DTYH1z9WoPM7IsXyIu6iaNcIwW7FgnI
 QJ6xdeHHwf7FWkNtWaA1fpjSvoGTjKtmsdwiWG5Qaxi9BEdOWRhk2Yaw73CJYKsn4PlibnGMA1u
 H8BHtmu4O2UZnJN7zP9YiNH/0WNkTl4eBf20q7X+1Q7YnJJhkukSJrdzmII9ViFIcBvFqXniN5g
 M9GK1eFGVU3zYPp67henLjfI8WCvkpzFGW6Oi42Gy9KryTOVkSrtDsF7SBDWxlUe6Fhti5UTSeL
 3Ajh+uPxyAU33K3Sts6WUZsFSRNIedYd4rBR8fwIujfrW5GKwCFtL5ckO7li/RmwGKIaoWNIyJ/
 pASbPD/7I/DMSOanSGHk0UBsBAZNGGAz7axwE=
X-Received: by 2002:a05:620a:178f:b0:915:9931:3a3e with SMTP id
 af79cd13be357-91c2e9077b8mr252270385a.27.1781570656023; 
 Mon, 15 Jun 2026 17:44:16 -0700 (PDT)
X-Received: by 2002:a05:620a:178f:b0:915:9931:3a3e with SMTP id
 af79cd13be357-91c2e9077b8mr252266985a.27.1781570655497; 
 Mon, 15 Jun 2026 17:44:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1a7357sm3155367e87.42.2026.06.15.17.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 17:44:14 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:44:11 +0300
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
Subject: Re: [PATCH v4 22/39] drm/msm/dp: Add support for sending VCPF
 packets in DP controller
Message-ID: <n6qjiuouisangxtov7dd7au7wb5ubt4vouodhhziuq4fychkva@275qni5tykry>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-22-b20518dea8de@oss.qualcomm.com>
 <i6x7675n4neufglcjwneds6nehetclystyg3abosbdjkh25ub5@psdjsrfl6wek>
 <d3689914-4afd-4bcb-8aad-380aefbf23d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3689914-4afd-4bcb-8aad-380aefbf23d2@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: RRJX9iL5Fq8vniFCIFOI7FFbfpWLGN95
X-Proofpoint-GUID: RRJX9iL5Fq8vniFCIFOI7FFbfpWLGN95
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a309c60 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=aoCmxbk1eBWus4yxrFEA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNCBTYWx0ZWRfX046uS6uLENu7
 efb130O+Ks6nkvDwm5ns6/KDy36Axr0/4stl3a6xAKjuuYAWGPlQKh9pLTf+EoqwkS0iLCJt3Wx
 morURdEcV0BtYQ5xyz7Lg7v7/cXSf/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNCBTYWx0ZWRfX6xf7qpQzpGdc
 /yqQmTh9g2ms6aOvc9Y8/aFDav9E4w/A6gH3MjpGcFh90E5oPOFwI7e7CHEYLzfWE265t2TLp9h
 hiPloGp6tuZYgMUWurunfuaAkbdCqImYa6GEAg4AhciGnu4JaNKL0ewOSgTal2W+MWpPuQczpm/
 SZtZ1uQ+EVtYG66zgiry5tRe8pEEj90M+3chVH6U5aT7iigH5VKXlkJRCUglDsQxPo+dC/DDd6N
 mvnOa3908GIc313w2L0Tq1+DwSDmQ5XNP62UCB8rMqFc34Rr7wtRp2gw2R+pS2KAT+E0+EB6Ur2
 HcLL4r6F+l7nw1yFdnLiA5kPCQRdC5ddwoTK2B8b9WcMSdiSmM04BKIaKxDlXni0h7OenpScLST
 U1SOGNNt47eVikPHvcAvtzNkQJu2p43J9L9KGYjEBOjK/9PTOXc38wgpN99A+bSPcV1iqRSleQZ
 /GVG+prlRR+CAwWR84g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160004
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

On Mon, Jun 15, 2026 at 04:35:06PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 3:24 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:57PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > The VC Payload Fill (VCPF) sequence is inserted by the DP controller
> > > when stream symbols are absent, typically before a stream is disabled.
> > > This patch adds support for triggering the VCPF sequence in the MSM DP
> > > controller.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 55 ++++++++++++++++++++++++++++++++++---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
> > >   drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
> > >   drivers/gpu/drm/msm/dp/dp_reg.h     |  5 ++++
> > >   4 files changed, 58 insertions(+), 6 deletions(-)
> > > 
> > > @@ -516,14 +542,28 @@ static bool msm_dp_ctrl_mainlink_ready(struct msm_dp_ctrl_private *ctrl)
> > >   	return true;
> > >   }
> > > -void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
> > > +void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
> > >   {
> > >   	struct msm_dp_ctrl_private *ctrl;
> > > +	u32 state = 0x0;
> > >   	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> > > +	if (!ctrl->mst_active)
> > > +		state |= DP_STATE_CTRL_PUSH_IDLE;
> > > +	else if (msm_dp_panel->stream_id == DP_STREAM_0)
> > > +		state |= DP_DP0_PUSH_VCPF;
> > > +	else if (msm_dp_panel->stream_id == DP_STREAM_1)
> > > +		state |= DP_DP1_PUSH_VCPF;
> > > +	else
> > > +		state |= DP_MSTLINK_PUSH_VCPF;
> > > +
> > >   	reinit_completion(&ctrl->idle_comp);
> > 
> > And there can't be two streams wanting to push idle at the same time?
> > 
> In MST, msm_dp_ctrl_push_idle() is only reached from
> msm_dp_display_disable_helper(), which is called from
> msm_dp_mst_stream_disable() / msm_dp_mst_stream_post_disable() in
> dp_mst_drm.c. Both of those
>    callers hold mst->mst_lock for the duration of the disable sequence,
> which serializes push_idle (and the wait on idle_comp) across streams. So
> sharing a single idle_comp on the ctrl is safe.

Comment, protected by mst_lock in msm_dp_foo().

> > > -	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_PUSH_IDLE);
> > > +
> > > +	msm_dp_write_link(ctrl, msm_dp_panel->stream_id,
> > > +			  msm_dp_panel->stream_id > 1 ?
> > > +			  REG_DP_MSTLINK_STATE_CTRL : REG_DP_STATE_CTRL,
> > > +			  state);
> > >   	if (!wait_for_completion_timeout(&ctrl->idle_comp,
> > >   			IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))

> > > @@ -2183,7 +2223,7 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
> > >   	int ret = 0;
> > >   	int training_step = DP_TRAINING_NONE;
> > > -	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
> > > +	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl, ctrl->panel);
> > 
> > Which panel are we passing and why? It feels to me that we have two
> > different cases, one for the MST stream and another one for the SST
> > link. Can we handle them separately? (note: I might be wrong here,
> > please correct me if I'm wrong).
> > 
> For SST, we push to bit 8 of MDSS_0_DPTX_0_STATE_CTRL.
> For MST, stream0 and stream1 use bit 12 and bit 14 respectively.
> For MST stream2 and stream3 use REG_DP_MSTLINK_STATE_CTRL.
> Do we need to handle MST and SST separately here?

Where is the MST panel coming from? You are pushing ctrl->panel, which
is the SST one, if I'm not mistaken.

> > >   	ctrl->link->phy_params.p_level = 0;
> > >   	ctrl->link->phy_params.v_level = 0;

-- 
With best wishes
Dmitry
