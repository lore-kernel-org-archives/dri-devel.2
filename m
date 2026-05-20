Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C0CCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2758010EFBB;
	Wed, 20 May 2026 09:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dyBR6yJu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CSCwMvvm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E3310EFB0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:23:20 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K6smmw1725496
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2dk1xLGP6qUJ2X8iBTE2ICZu
 6S7Az8HHzhrvZdWPUyI=; b=dyBR6yJuZxKrrHZ8dfjUGQd0eixfA9PtBsDPv0yE
 XEceYydH1qTyG2Kfsye6z+FImj4m8rljS17KdWWwFx/KQtqeJaEQlOGeMcsKdmQ5
 Oudyhg/CUEyyWtBJZ7XnE9IYPZUgyx2Ve+GnC6IaXstujnQ3KwVyVJt8vwaRxYxf
 6C1rmybrbRtFgMwJyrqaPVZ+BiTtHBvpcAv2cxEFXKu9pMbsQVIOwpw7MdIalo0W
 mkTabsFYvjxBl2qIAxSm1FKpxydoMMHiInT/sJpJOA/lvFXjHu1IPB6ZHwM6cj/D
 w0mdwWBpnLBX227X8sfSD92DrNpLq4Tr3zQoCa67hTyPgQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qm1pr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:23:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8c3bdb60dadso159400286d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779268999; x=1779873799;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2dk1xLGP6qUJ2X8iBTE2ICZu6S7Az8HHzhrvZdWPUyI=;
 b=CSCwMvvmhwHD2/aRW70p5YmUmdVr8+QlouVeLszz7ruWWtwzaW1Z9KX8o6IvZt/KdO
 qqq+cud07+mZCRvGLgty6huwGyh70HwIiz6rAdXsbHm1bHO1eF+3vJTX3AG4/4uQ+7DI
 bNP2her2GONbbuiu9iQ62QFm5/5wVCITPWZXVk1Zg2j7mgHAOz6/4ekyidbcMZBGrrJo
 HBRAKwRBvcYQwI0YzeLNqdOt0fpVdeOHfZQARQKeKZ8PEoAo98Tj0x9SlS0bLS0IGV5e
 jhT56fJQmcG4mUhhwlYTT+ELqNrCX1rbJRwOfMDr7JrpgaWQ1+Co1o4Al3VwLg/MLJt5
 ilvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779268999; x=1779873799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dk1xLGP6qUJ2X8iBTE2ICZu6S7Az8HHzhrvZdWPUyI=;
 b=UjePuwY5vvRQtK1e8LWcrF4EBDAb8cELcjcFg14jPBe/cVA2CEWjdNxQoNIi9IWG0v
 2AJxnPWsyc1RX8lHp0jz6fFhfydNLJ88e0ddZGY2KWM0S2rkqwPv751cKyo9iMuSc617
 qNOkWTy4CusvsrHo/7+fxRD2eho9w/u8RluNxuvv3J3duDp+l/sUKQadyV8xKv0c8+CI
 F/UUtoZmhd3lBhp8Y+XAhqJyPU1nvtVISEuih0g/jZ9RzPiHe7c3NBztnATfGwMiz0Sc
 VmdVYh3s27Bdc7j4MfuNzT3RZn5Q0+vnCMvroYNmEQ1MOPT5c2ik5lk7l3MZ4BJLIYRs
 cRYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vuR27U8rPs2F0xrQo84yXFYzKGyWkcl0lGJ/0u2fpEPtodJX/3H9axcSblGPzUQ+KKeogdAZdokQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDWAXpJNMXtqHk3MF+MdzFI47lxPYvBSN3axTPTIpm2QXgNx6G
 OqZKyV8rae3vj9HmrYjwnC74W1XIoGJQ12WiVT6hzmLiDRZ0XU6e08X2xj7w3/7D6wMkV921Atg
 X2yyKcxtxjdk3WHEMRob0kdN00AFxXGohpOIFWqNPkqGdH1NwIcf7Dl4G3x6RGgTzho3/55M=
X-Gm-Gg: Acq92OE1A5QuA3Fx4rXRLHALXHA1pBsM6NuljQWLI/beS0GjPQxOGjMEqneTRLYHSYA
 4sbwPXHKJ77FIRpnmjWW6KQ8AKftLsCbx0uUCkP3ahtSrPgur7KJ/mrSVBiBPTAZkr/7k5+Pi03
 Wtc4FfjwW9myWqjHzp1F/lZ6D9IMqGEZz6ypOAdyQ2iGe+QcFz+wBPRK15+w3efBs2c4szPz0G3
 +tKwnK9MOxAJWmYFhbZXXwASoq4sEQBdWn9zyUFjrBkiiWEB5bdSuyQM4ZBKbOyMMENn2MlRizJ
 yLJAkahGj/LQMAxxp+kr66+2DlQXG5wUPWOMjMxYUf7tVA6b7QirxBnMSiI26o8Q1wUfYGVFlmV
 GEjPOTb65be/1cFyRZW/8d61nuxuUx00/yWcoLYSDc8VmJS38A2e/QTvtA+l3WHs7jbe0rR3RHm
 o6ghdwEhlGULxspvRegFqSjlaPj10jmd3GSQs=
X-Received: by 2002:a05:622a:17c7:b0:516:508b:bf55 with SMTP id
 d75a77b69052e-5165a276f8cmr302275041cf.55.1779268999213; 
 Wed, 20 May 2026 02:23:19 -0700 (PDT)
X-Received: by 2002:a05:622a:17c7:b0:516:508b:bf55 with SMTP id
 d75a77b69052e-5165a276f8cmr302274701cf.55.1779268998741; 
 Wed, 20 May 2026 02:23:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c944sm4915432e87.6.2026.05.20.02.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:23:17 -0700 (PDT)
Date: Wed, 20 May 2026 12:23:15 +0300
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
Subject: Re: [PATCH v4 05/39] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
Message-ID: <etjni6nlx5a6xd4oqb6ow5ihxdl5zcdtcofmo74pbdt7lilnxd@q2zqgiqycjt3>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-5-b20518dea8de@oss.qualcomm.com>
 <omw63f7fbqiuw2t266dq5drk7rz2kohydpvbbhcrbfiehb7lzh@aucqhfaliams>
 <57f574d3-7000-42c8-a5b7-88f1a73efd50@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f574d3-7000-42c8-a5b7-88f1a73efd50@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4OSBTYWx0ZWRfX2a0xbIorCwpM
 uGdTY9fzqbTbem6CQqrR4fcukcTjL8ZeaqKjuQHPf/SLG+8SyT3KDR1VBjQo7Fxm0Na/TS+f/ld
 KatXZ/XIvbkKRyjdLJl4hHz0Gi+PPYFbZ+yq08EkGyXOAJgcK5cF7P9ZA5bbU4q6uQg3n6ZHHJS
 EAhfVOZai8aE4/lULhtad0d+TgpDyjmZqNg79GBV0ikgJ+Bq0eyCgFp+2eKFPfSpxS81u7BDDfN
 /yFjXJpYQsDhRuGCpYq4LiF/AJElntutwEPuUOm2W+ltFzVlzh9+mcmQc+EZov6TVIq19iAk1Je
 FX7O/hTzyQaMrriFi6Xqqez2G7bjh2mVso5lrTB+4euVt/W/oHq/DRtBGObJiHBBXPEbhpMVXix
 KV+ZTq+mrPFKXcLLUW1fhruFOrCE0MhIrgyn1Mhl1mNbq1cDMDu397brUSrib5Df+Yit/IZswJX
 /Ih0tJ5/HiMGN0xmV7w==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0d7d88 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=zA6fHH8LBb3Lnj-KyrgA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: lp_cxtb3PGbROte68IjF7JRB9w132r6D
X-Proofpoint-ORIG-GUID: lp_cxtb3PGbROte68IjF7JRB9w132r6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
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

On Tue, May 19, 2026 at 03:46:36PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 1:34 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:40PM +0800, Yongxing Mou wrote:
> > > The DP_CONFIGURATION_CTRL register contains both link-level and
> > > stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
> > > all of them together. Separates the configuration into link parts and
> > > streams part for support MST.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c | 43 ++++++++++++++++++++++++++--------------
> > >   1 file changed, 28 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > index 476346e3ac19..85315467b5d0 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > @@ -388,26 +388,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
> > >   	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
> > >   }
> > > -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> > > +static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
> > > +					    struct msm_dp_panel *msm_dp_panel)
> > >   {
> > >   	u32 config = 0, tbd;
> > > +
> > > +	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
> > > +
> > > +	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
> > > +		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> > > +
> > > +	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
> > > +					      msm_dp_panel->msm_dp_mode.bpp);
> > > +
> > > +	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
> > > +
> > > +	if (msm_dp_panel->psr_cap.version)
> > > +		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
> > > +
> > > +	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
> > > +
> > > +	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
> > 
> > You have an RMW cycle here. Please document what prevents it from racing
> > with the concurrent msm_dp_ctrl_config_ctrl_link().
> > 
> Here protected by mst_lock in MST case. Will add a comment.

And in SST case?

> > > +}
> > > +
> > > +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
> > > +{
> > > +	u32 config = 0;
> > >   	const u8 *dpcd = ctrl->panel->dpcd;
> > >   	/* Default-> LSCLK DIV: 1/4 LCLK  */
> > >   	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
> > > -	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
> > > -		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> > > -
> > >   	/* Scrambler reset enable */
> > >   	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
> > >   		config |= DP_CONFIGURATION_CTRL_ASSR;
> > > -	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
> > > -			ctrl->panel->msm_dp_mode.bpp);
> > > -
> > > -	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
> > > -
> > >   	/* Num of Lanes */
> > >   	config |= ((ctrl->link->link_params.num_lanes - 1)
> > >   			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
> > > @@ -421,10 +436,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> > >   	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
> > >   	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
> > > -	if (ctrl->panel->psr_cap.version)
> > > -		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
> > > -
> > > -	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
> > > +	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
> > >   	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
> > >   }
> > > @@ -450,7 +462,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
> > >   	msm_dp_ctrl_lane_mapping(ctrl);
> > >   	msm_dp_setup_peripheral_flush(ctrl);
> > > -	msm_dp_ctrl_config_ctrl(ctrl);
> > > +	msm_dp_ctrl_config_ctrl_link(ctrl);
> > > +	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
> > >   	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
> > >   	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
> > > @@ -1628,7 +1641,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
> > >   	u8 assr;
> > >   	struct msm_dp_link_info link_info = {0};
> > > -	msm_dp_ctrl_config_ctrl(ctrl);
> > > +	msm_dp_ctrl_config_ctrl_link(ctrl);
> > >   	link_info.num_lanes = ctrl->link->link_params.num_lanes;
> > >   	link_info.rate = ctrl->link->link_params.rate;
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > 
> 

-- 
With best wishes
Dmitry
