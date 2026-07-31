Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3112EC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE5410E205;
	Fri, 31 Jul 2026 14:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxoqKk6u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b7UvglIB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E1D10E205
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:05:33 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VCHjov058232
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 343B1/3+b4zF0oyHAPXPcWl8rg0MW19SgLHKxpdb+jY=; b=hxoqKk6uLhpYiQdO
 yECxHJ8rxjUyhccKYseyFK+80rp9j9fJi8vQLuUeeeotQpO7xWDeZSTEBrBFLBLP
 zTakhBMrKC+ZNlUvL5ksYm7QwV/gQUEhCN1mU1MnTXaW4lEjQomgJYvyt/macZGX
 vZXq87Ja1x4OYHEd+2bDilg+wXJoon3/AkjGPidwFEygdCJQINfeniHgvaSGVFew
 AdNF5SR0DX1Pz9WmrhruMvpaKv4aCMCxhSm5iuJVHfQ8YN8lyLXtEKND4yR26NB/
 /OKzEub3IRYZwfLP0tSRl+3d0mXln1Ruwzgr+xKeivmV7KcjOqhIjA/gy84IB9UU
 B9RNcA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fruk8rfhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:05:32 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-739a588fadcso220464137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785506732; x=1786111532;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=343B1/3+b4zF0oyHAPXPcWl8rg0MW19SgLHKxpdb+jY=;
 b=b7UvglIBPspKE8+naVd91MrdFK1M5WpqCERDSg1ezRZkprDbutn0JXknJLgYf0WCze
 aNAdqwGsNzflXabMe+nMiNB7agnKqdCGOvs3ZjYKdmtbpE+uNittRZH/mtc+UIBWEOIN
 Ga2XrozLOLg4A89FSC3gP+KwhIdkoERtuEVcIVVnxUD2sLNIQK5n+7TfzzZT6sivhxQi
 xVp3MQPv4MxNBYdJ6YjQJXjSDN87bAFap2yCqYYE4KSOgHrRCjkNLTwiWVGkQrcoJX5X
 pNDTiBYVOSdZGvn2XdVnqBsF33sEWm9JXOCMh488rvul/LEn9+w7h2L1Q4/T5erCXQGq
 Jqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785506732; x=1786111532;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=343B1/3+b4zF0oyHAPXPcWl8rg0MW19SgLHKxpdb+jY=;
 b=QAAbL3/i4FC+p+Kp7npsPdJgZqZOaUamaKGUDgmAmSxAXvqOJR4WXrHL9ZvmioaWBg
 3x/CEXccExQkeZl8pVurNMtUcnocLlETQ0jMal+5UL4eATz8sCmrCGzjLdCD5R24w0ZB
 RhyvXlYF9eq9Io7356L59GJvNMSNjMsMU/1JLKWm4JINulAtLU9nUiB3vL2lAZUj7VmC
 LC9HxH8AZRmN9yMmt6aAb0TrfEexefN1kG3YT0yAozqUtgqscHAjjHOEShZNSZRDsZ01
 T9TAWyOzZYcfac9wCG2JVg/x1lPRAgYpCrZy6c4h81Maz4rnfETATzsdQXwmyqpIq87O
 Hd+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOdqaF7S6tjef38BJhAeP83rRwZH4HRmeNKpCbXACxV4tTdcF0iDN9MPHt1J+WnC8is7lAkmhl1x4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7Rny+grCl2hv7AQwnZaOnP4CsZXMDp4P5Svo+dGMU8fLUqyXW
 ugTbIiuALYmSzr/VQIvJM8A9c2WSYBAW/EulaLQLeGqeroSazDbbmsqfdvJ8W2uUFSO6Cvvsl7v
 SX4BAnntKNOlNgbZd4MfcBOgd1w3Gm2jj/eA8v04p56V629uRc0W/8scJQaS+7kx3nf7fru0=
X-Gm-Gg: AR+sD12J3ZwdwTj90UJxNIz7Kvom6GJTiDhmTpuOWytQDSzQqldPLX/714FpUhv3X0M
 EMycFs0U9+RiZ8ditZ4WfUJ8nYmN6iDtjF2mXQIrbIK4Nji3O3dlrB4SwAaC2vlEKZ7x+070+2A
 mIN54EENWd72eXwszdsC09/tG02IBuklXw+rIfJUIXR2knA95bwTr42RFpth0bcR+XyDOFcB0WC
 xtCwbJoOg7Elj2nGuMlyP55BKFvZz6IjqxNmDbMIB77Ckwou0N/i5sxIb5WI3PeB+h2n3lSW4ww
 3HL8kOKB2vLhZ7YvmHA1c8p9wgs97feV+0x/oxwTDr/PDSYgSoR7Q302x953MXyTvzxRoNIwb22
 9g2he/HM0ZCCHPf6UWqzGfrHfgcDGybkejEv5NW3wmqNwmkUgbZh9puUufV5GFwLTw3TOaVgabt
 aFzy/GslcUCxp96w==
X-Received: by 2002:a05:6102:549f:b0:73a:128b:ea07 with SMTP id
 ada2fe7eead31-75b23a635f8mr167406137.14.1785506731651; 
 Fri, 31 Jul 2026 07:05:31 -0700 (PDT)
X-Received: by 2002:a05:6102:549f:b0:73a:128b:ea07 with SMTP id
 ada2fe7eead31-75b23a635f8mr167332137.14.1785506731103; 
 Fri, 31 Jul 2026 07:05:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f810dc89dsm1229371fa.12.2026.07.31.07.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 07:05:28 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:05:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Yuho Choi <dbgh9129@gmail.com>, dri-devel@lists.freedesktop.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kees Cook <kees@kernel.org>,
 Dale Whinham <daleyo@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/msm/dp: Disable stream clock after video-ready
 timeout
Message-ID: <ka3af5qc63pdcvh3uf6ulb25wrsf6udjugm62ooxuscxvz6zhz@mbuivewege2k>
References: <20260707175212.412699-1-dbgh9129@gmail.com>
 <20260707180553.78C7F1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707180553.78C7F1F000E9@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=W8sIkxWk c=1 sm=1 tr=0 ts=6a6cabac cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=c92rfblmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=YuBhx4MO3GsoJQDmrn8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwNyBTYWx0ZWRfX/2hVhfa53AYx
 QkZUNfZbUFzhEUE5PZGETcVbqIQE2rKVHDfZVHaksPirwIWQPppM0duBxsoFQBnfxCBoXz+uBrc
 B37HWY7iPQ0HLi6TIfdjknQEQa15LoE=
X-Proofpoint-ORIG-GUID: L6WB7BZjKWynd5g6cr4jIcNQZiiyIowz
X-Proofpoint-GUID: L6WB7BZjKWynd5g6cr4jIcNQZiiyIowz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwNyBTYWx0ZWRfX5WIzVS8pxOK3
 2h4PH8yqYZtjVHM0GzoYfpeQygrqD0CGl3R9g79HpTnffyxHRgXg2jq00jusZHZzzGdkya+yMes
 sVZmJb7j6JDAkrhXzNVk0g7m/26kX9y7Bcw35YM/3Dk0dKwAEUYgQiCX2wTsY4y2Jf8dM/LpZOf
 hy0VsodKsgKgzdVGdT7HNRt72C2VmwvTZLsVJASEI8rEfIHIs8pb8dV+j4S/ZBGCMZPO1B4sY3S
 0lOkGLZ8Pk2Q3mpZvUl8sd/P4ZOHO088mxHJyEbHSZHxsV8l2Sdaa7tgrWNkiqoEqg4JY4Vaxu5
 nzKGQIYRR8ObsL6n6lld3fUPCl1ZCzW9P+j31wo0+TVHg5hdSYCdyNXpnau5czBPHTwQadHV+dq
 6Kgjv8M20v/nj8m+kcZyT1Hr8Y4xbenNMFWoFBiKCaKsHz3W7541iA8JcVod1mRpJ8ka71PdnTn
 yme0u4oiPIuZI/VCfQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310107
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

On Tue, Jul 07, 2026 at 06:05:53PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Disabling the pixel clock while the DP controller is actively in the SEND_VIDEO state violates the teardown sequence and can lock up the hardware.
> --

Could you please comment on this Sashiko comment?

> 
> --- Patch [1]: [PATCH v1] drm/msm/dp: Disable stream clock after video-ready timeout ---
> commit d51f59f75198361a5116081d3f135fd586dbcb66
> Author: Yuho Choi <dbgh9129@gmail.com>
> 
> drm/msm/dp: Disable stream clock after video-ready timeout
> 
> This commit routes the video-ready timeout path in msm_dp_ctrl_on_stream() 
> through a cleanup path. It disables the stream pixel clock and clears the
> stream_clks_on flag if the clock was enabled during the call.
> 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > index 86ef8c89ad443..139e9fa25d6a7 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> [ ... ]
> > @@ -2543,13 +2545,17 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
> >  
> >  	ret = msm_dp_ctrl_wait4video_ready(ctrl);
> >  	if (ret)
> > -		return ret;
> > +		goto end;
> >  
> >  	mainlink_ready = msm_dp_ctrl_mainlink_ready(ctrl);
> >  	drm_dbg_dp(ctrl->drm_dev,
> >  		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
> >  
> >  end:
> > +	if (stream_clk_enabled && ret) {
> > +		clk_disable_unprepare(ctrl->pixel_clk);
> > +		ctrl->stream_clks_on = false;
> > +	}
> 
> [Severity: High]
> Does this error path leave the DP controller in an active state without
> reverting it before disabling the pixel clock?
> 
> Earlier in this function, the controller is programmed to send video:
> 
> 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
> 
> 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
> 
> If wait4video_ready times out, the code jumps to the end label and disables
> the pixel clock. However, if the caller ignores this failure and DRM later
> disables the bridge, the teardown sequence will invoke msm_dp_ctrl_push_idle().
> 
> Since the controller was left in DP_STATE_CTRL_SEND_VIDEO but its pixel
> clock is now disabled, could writing DP_STATE_CTRL_PUSH_IDLE cause a
> timeout or wedge the hardware because it cannot process the state transition
> without the clock?
> 
> >  	return ret;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707175212.412699-1-dbgh9129@gmail.com?part=1

-- 
With best wishes
Dmitry
