Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF7ACD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC23110EFC4;
	Wed, 20 May 2026 09:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CguKW0f1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cP9xn0Mo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445A710EFC1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:27:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K6sv0x1237939
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hwFSqLR4fpm13sa0D0efQGvW
 DEFilp39Rn2bMzFZjXI=; b=CguKW0f1/oa9iLjLJAnIvNnrhQ6hSHfeMxIKQ+EG
 /Wz6nw2E2WCVqC/mprBsug77BOw6k8WTP5SlSK4TMcCA5F+DaUp/sXNH3oOdWVDr
 1xqyVTrJoOb+yj1iLjCVO+aawdVvaj4HHBERil50voclaypsElS3cHjnaVsvDWPP
 qzX5P9u06MzPF8U+58EgMJ6PGSbT+EdVFk8UOAFe67Kcn8jSIHwwKjHcM4km405f
 bgXtDBd0ICAW7VwLjH6sBHJiuLxxCE9dj3bmzsBbrADEqGvyKGJZcd3W9uaPpeIl
 j0yahgnCfxLcEuR/BmQPRmKTlG68BcxsNsQH+Mkip6MJQQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3sv45a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:27:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50ea1a7a5d0so135801441cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779269233; x=1779874033;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hwFSqLR4fpm13sa0D0efQGvWDEFilp39Rn2bMzFZjXI=;
 b=cP9xn0Mo5bd3/frmtvaGwjnzRRrWjOdhpVbnbAHjPSV73R0/4fPex77OegWYMCcdnT
 o/gh4NH0rrWVS5Yzi/fbQOvQiHV9dO3o/m9Bj8S2p2WoqhWnyBItKKeLRwh/Fv4g2n4m
 46b10QHRUgCNAi7Kj1ZqEP390Fzn9EjtpadwvJZE/F4ZbEjJRZoc2M+kwRyHBb9HjaCB
 nN54x02Qh00IK+H2S0B2ZOl7H8gYGz+hSMUKfRAFvaY32pXXxfzNYTjn1AkwakQSnT7Y
 vsCOVMPih/5nj6iTES++0kR0FNtfUuSguw6GxpelFnhDT+eg3xTiwKhdBYq/gNdgxUIg
 KE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779269233; x=1779874033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwFSqLR4fpm13sa0D0efQGvWDEFilp39Rn2bMzFZjXI=;
 b=QgQJ0iUAoEZsmt2iNknwxfCfKug6QO2ym7dET6+VsgjezmO6tCGxIIM6T7Qrn67ByM
 Vpf93/VlzpwOZRSpbzaJzSptAs58dUfONJrQASm6//Q+RqX3FebcUuqqbeFH5B1DUNd4
 oBjqzcNuFMz+vX5At8sLUs7bTQ7H9goL9YcCoglFGjvol5PQo1RfnEFhQuCu9oc0fwxS
 qv140ehAI5MdIncZDfpS/P+SqkPfU43Ur8HksAsBTtRh+R8KluXfKPWqiljfO9NGEgw7
 Zt4xIqeucFVNm6GH319JLhhjPC3sYK1YcZibIZFDHbim/cvl8zn+y3NBCbGuPrtR3e6w
 XRIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uOj80ONKJz69h5qJ80+yYLa3uqmohsl75Bgte9mRtibi8n00kMsEVtLjQiLyyUNih3h375nt3x9w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrMJbX+oRrlXWzPyMAmKWyiN20liaB8F6G7xMmOk+Y4PPsz8Fe
 J+c7D77yKxnEr1cUGVeQVNh+xCuNlbPnBiNSZbl1xpBbBpp0klLre9hpyfVFLjUlLyPty84n7DL
 ydvvtgN7XCYwPSketk9WfYikNVdyiyfpLDIFxW1azfcX1WffXInA5FCvSZlABvWzVbhbD4X4=
X-Gm-Gg: Acq92OH6y9cNOTdGKjMRpVnSq9aXq2iEtq1qMKGKcQEKfa1KcisRjgBGkjIV1cH0lGI
 Ye5RNpmouosNFYpxMyiiWd05iMgctGMZ8mpscla9FYVQCDRImM2ZpKDBhmTUiyHAYtIqmFw96f/
 5dp1mNoUp99UO4+JoD3yL4gKPoEkR+0L3IbWm3qfL2rkqeiWGmQyIv3qjDHZD3HNVv0ostIBRGS
 xVdLTV2X5MwuKG8Bz2RgbcosS9zUtRi18/dcDQzUD2O16l+uTgH3mV5i22Om1AuHLtpInS2o525
 YcnB+3S0vGbTYpfwg2t1BR1IWWDmGc+FMjY5Oj9JwIHMzrfk2gCBtAtoNq0Hwm6hDovihagzPuw
 nL8acOlAeWM1ZGcgg3Q21rPvQ8M2GhapRX6VcJNdMA43UF7bKEkKeqXGTc6+2kH9wBl+VOdXb6Q
 2+EngiuKtZ39Qao6NTi/3fxa3+WoB2egpXK+M=
X-Received: by 2002:ac8:57cd:0:b0:50e:614c:661f with SMTP id
 d75a77b69052e-5165a040625mr318760161cf.20.1779269232530; 
 Wed, 20 May 2026 02:27:12 -0700 (PDT)
X-Received: by 2002:ac8:57cd:0:b0:50e:614c:661f with SMTP id
 d75a77b69052e-5165a040625mr318759761cf.20.1779269231992; 
 Wed, 20 May 2026 02:27:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10ca5esm4783245e87.16.2026.05.20.02.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:27:10 -0700 (PDT)
Date: Wed, 20 May 2026 12:27:09 +0300
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
Subject: Re: [PATCH v4 13/39] drm/msm/dp: introduce stream_id for each DP panel
Message-ID: <qv4ytuoojd34ls3mstj7jdb6kqptooavhbnidbnvqtodwfr6kb@qfvqsgs5vqb5>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
 <nzouhzeoimf32nwbm2qjecopildvmlay4t4xxshufsjaydmwlc@bnfom377r5b2>
 <a018705f-13c9-4e96-995e-b358778b0996@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a018705f-13c9-4e96-995e-b358778b0996@oss.qualcomm.com>
X-Proofpoint-GUID: XcIHkXms5YhvhtqWCC5EdaH6yPDazIWM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5MCBTYWx0ZWRfX92z8sPtOC1Q1
 NwXnOIpf0i8EDg1we2BhJLSohPdiQje1s3pwh+4I5m0cN6pVZWTi/BJx/0DoQw0x/8PxKXpzgnO
 kpOBMeC9/HvfY5CervlE2V33aaH0L+zjtrkHxq/Wl5kWjn3rlS9LBD9DxslmdQrsX+erLLcerwI
 x44kLLoDn1OTou45rzRJVqc/sPTyaA/eTw+8yfZCn8kFm+3c8uuLbCpdbI16OjOkhnrcWKN5HVs
 VoXsfzf0vXn/1gNG0ZBgCq2FQm/2NKMh6gD5YZ30NfHNK/t7kaNd+SKbDRZCb00jNNKCPLrrGDD
 NtKRtAGT4Sxcv28rIiMM0Ejef5DfiV43Mp6Uvhmpt3Gfh0FErZA5borLiPh5RWk9hNfsHiB0Bxh
 NqEATYanvm5Pv1ZFqez60SYhvZ6PATiktcNQTOyFU1v4/jbjbmgplvUDRvYDqD0S0fO7+p0a/g+
 I22qedsmsK0mIKtx0lg==
X-Proofpoint-ORIG-GUID: XcIHkXms5YhvhtqWCC5EdaH6yPDazIWM
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0d7e73 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=5QDKDTwAGq_DmF9AEKQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200090
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

On Tue, May 19, 2026 at 04:26:21PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 1:55 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:48PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > With MST, each DP controller can handle multiple streams.
> > > There shall be one dp_panel for each stream but the dp_display
> > > object shall be shared among them. To represent this abstraction,
> > > create a stream_id for each DP panel which shall be set by the
> > > MST stream. For SST, default this to stream 0.
> > > 
> > > Use the stream ID to control the pixel clock of that respective
> > > stream by extending the clock handles and state tracking of the
> > > DP pixel clock to an array of max supported streams. The maximum
> > > streams currently is 4.
> > 
> > Please mention that panels are going to be dynamically assigned to
> > actual stream IDs.
> > 
> Got it. will update next patch.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 57 +++++++++++++++++++++++--------------
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++--
> > >   drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
> > >   drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
> > >   5 files changed, 71 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > index 120ec00884e5..fb6396727628 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > @@ -127,7 +127,7 @@ struct msm_dp_ctrl_private {
> > >   	unsigned int num_link_clks;
> > >   	struct clk_bulk_data *link_clks;
> > > -	struct clk *pixel_clk;
> > > +	struct clk *pixel_clk[DP_STREAM_MAX];
> > >   	union phy_configure_opts phy_opts;
> > > @@ -139,7 +139,7 @@ struct msm_dp_ctrl_private {
> > >   	bool core_clks_on;
> > >   	bool link_clks_on;
> > > -	bool stream_clks_on;
> > > +	bool stream_clks_on[DP_STREAM_MAX];
> > >   };
> > >   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
> > > @@ -2176,39 +2176,40 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
> > >   	return success;
> > >   }
> > > -static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
> > > +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate,
> > > +				    enum msm_dp_stream_id stream_id)
> > >   {
> > >   	int ret;
> > > -	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> > > +	ret = clk_set_rate(ctrl->pixel_clk[stream_id], pixel_rate * 1000);
> > >   	if (ret) {
> > >   		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
> > >   		return ret;
> > >   	}
> > > -	if (ctrl->stream_clks_on) {
> > > +	if (ctrl->stream_clks_on[stream_id]) {
> > >   		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
> > >   	} else {
> > > -		ret = clk_prepare_enable(ctrl->pixel_clk);
> > > +		ret = clk_prepare_enable(ctrl->pixel_clk[stream_id]);
> > >   		if (ret) {
> > >   			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> > >   			return ret;
> > >   		}
> > > -		ctrl->stream_clks_on = true;
> > > +		ctrl->stream_clks_on[stream_id] = true;
> > >   	}
> > >   	return ret;
> > >   }
> > > -void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
> > > +void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id)
> > >   {
> > >   	struct msm_dp_ctrl_private *ctrl;
> > >   	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> > > -	if (ctrl->stream_clks_on) {
> > > -		clk_disable_unprepare(ctrl->pixel_clk);
> > > -		ctrl->stream_clks_on = false;
> > > +	if (ctrl->stream_clks_on[stream_id]) {
> > > +		clk_disable_unprepare(ctrl->pixel_clk[stream_id]);
> > > +		ctrl->stream_clks_on[stream_id] = false;
> > >   	}
> > >   }
> > > @@ -2228,7 +2229,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
> > >   	 * running. Add the global reset just before disabling the
> > >   	 * link clocks and core clocks.
> > >   	 */
> > > -	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
> > > +	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
> > 
> > Why are we using ctrl->panel again here for the stream-related
> > functions? Didn't you got rid of its usage few patches ago?
> > 
> For MST path, we pass panel to the func. For SST case, we still need to pass
> the sst panel to func, in here it is ctrl->panel.. in dp_display, it is
> dp_display->panel.

This doesn't sound correct. How do we differ between MST and SST in
dp_ctrl functions? I'd really store the panel only in
dp_display_private, passing it as required.

> > >   	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
> > >   	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
> > > @@ -2238,7 +2239,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
> > >   	}
> > >   	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
> > > -	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
> > > +	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, ctrl->panel->stream_id);
> > 
> > And here...
> > 
> > >   	msm_dp_ctrl_send_phy_test_pattern(ctrl);
> > > @@ -1451,6 +1469,8 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
> > >   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> > > +	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0);
> > 
> > DP_STREAM_0
> > 
> > > +
> > >   	rc = msm_dp_display_enable(dp);
> > >   	if (rc)
> > >   		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
> > 
> 

-- 
With best wishes
Dmitry
