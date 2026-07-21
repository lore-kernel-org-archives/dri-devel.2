Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22795C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E766610E1E6;
	Tue, 21 Jul 2026 18:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPb85F0r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jRlr7Bt0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB1A10E1E6
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:54:11 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2jeF2449285
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SMUsR7BSh0s3toLvJ14SFMc5jpWtih5ahRw168rWv9c=; b=PPb85F0rqjIfG+31
 weIRv2CX1QLYry8qDZkKXJFXcdc7ykanrMT4bXQh2Rzk6XSvA/ZF1frZQ1UIX6/d
 uX5FmSjChOAGCyxafmKV7fM6maSOadtOVpBwY4ysGN8NhwQ/7n8mYgQQrTI2PJ5U
 O/NUB57owXbbZqzWSutqk2erdmMnEJTkCQFdK9t0jy9lHejD4WrtYZfuCmTuXZVq
 fi7d5bU8I8sLt/Un0tIT3Gubc0Vkp2bmZSZYgWvEMmywhARl4FYMIlERN2vCBb0T
 d2/u43SfYNU2buRzja68H2/O0x3cH2cj6QgZqUddzLBS/RGp0cKTdKJC29tUQDE1
 +PVgPw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6862mrd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:54:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso93387171cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784660050; x=1785264850;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SMUsR7BSh0s3toLvJ14SFMc5jpWtih5ahRw168rWv9c=;
 b=jRlr7Bt0S/5FUUeYUKivDmK+lgE7sGRHpXyhVCUyf6LRTnkKeMHN1b56G1pqcZZ5UC
 GK7Fyx88rR5CjVpYMYGf1trdNTSG9tXIgZ4FgYYst5DhJ8IuCC7g+aNw5yTkGgGSPs7D
 Ks6lQxO0zNYJD6O/9endggbXo0PEA3rkD/TSvIeUQlrXsHP17kV32iqXsh7yronDFpd6
 fbZmI+CnMfloGv/6CkJzz5HJJNrgPao4TWAl4KlwqMbAbg7Sgea9S4OtPIKC0NyjbZps
 QDRtOYOjd7270ZqgtE1tSgtM2XAKPfk++8S5o5ZyVG77vKuj4uF23MDXsU1xnm+hqzfE
 2pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784660050; x=1785264850;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SMUsR7BSh0s3toLvJ14SFMc5jpWtih5ahRw168rWv9c=;
 b=Ekm+bF/Kpgro0IaHVV2+JTF37EEDFoxskb3jO3Mu7XSSewS/QGzPrZu+8qrkq8Pgni
 yJUONIboC7enwTZUemeyayCxqk+ZNiFOWOmugOk5I+5JmE7NEQFbBplYAsd6RYF7scfG
 9arSDFTB8ekD1PUNOj4IkZ5dt6SwzA0+N/sjRUXk9CzPwKxDDcvhyp9yC3lZG8sMyFzK
 9vvi+f3sOfEsJDhu3uiYlP1m6iaYLM/meew5aDp17dW6Q4nr0enQZornEuEj7dKcuypB
 4nz7arcLTdEhnWNGSgNyvvwJHixyhetEMSgOAk4N/1z3WTK8udjvkFf7VmGxY/vNu+lx
 V5iA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpmq7SzOlF6gg9WeReEIhy1zUHk4qKIO8AN23tuxoS3TnzIcFOVKRBQcBQDmzQevV5ZFOzHU8YJTVU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7oQ0W19HwvYQ+7BGkxUiMP1hU7dszM3nQHoQ0LHXPEFuL3u4T
 ei+xG4CfDmesg+Q6eFmuE8adGfz+cIoji3bBdXCTLqtKNNy9F3eni59aV/0upk5Mq9OiVMYs9B4
 i7f1IzcvL7GY1GpajlQ8M1UTiIR+kvK4NfGBX5kGd+CDhQXyceeCKcuZLAnpHK6FKmnTGfj8=
X-Gm-Gg: AfdE7cnBsLdoCluzlLh1hx9sWl7ZeizhbXG6iAThuj3xFEEjp28LFdStQrbV+IZnXtZ
 Q+c3S9Q4d6WFZbuztlkFwOmXT40k2MraER2IKDJPt34Ek/wGGdxyJJcNcdU1T85hE2LzgsjEO3Y
 U7BUunetidf/XOlQjdPR+PPI6s/EbgBT173A+tBoIuTFr20iNZZjGB44s2CoN2/1WVeNKXqDOgo
 ONdbqaaAnxSTNzQ+Isi6FH/qBwMbhY7qkm90ANewucMkk1OVLjjHX9VznQHz6r0C0KPz2Bp9BKw
 rJwK5ue9CzvL0ed10sH3MJE8YCj/9iuf7FRni7297pf5XRuA2kryjULE0iP10+Em+vI3Fd4a17L
 +RIj6eL0QFDDUw4kI80IvwuBLjLwOZbTJxyjdre0NomZ7UNSWunpsUprNFS4y0hHUCrewYME8bm
 /0kDaDAhUDj52jZw==
X-Received: by 2002:ac8:7f13:0:b0:51a:8c99:1f17 with SMTP id
 d75a77b69052e-5213eb8266cmr182508351cf.70.1784660049725; 
 Tue, 21 Jul 2026 11:54:09 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:51a:8c99:1f17 with SMTP id
 d75a77b69052e-5213eb8266cmr182507991cf.70.1784660049206; 
 Tue, 21 Jul 2026 11:54:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9ba342esm74873e87.27.2026.07.21.11.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:54:08 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:54:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
Message-ID: <3k7xz57peytyda7cvzfpao3j6xuhn4gyf7f43wnspdpgnrel4r@vipemh3nkoi7>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-10-bea261bf4e7d@oss.qualcomm.com>
 <20260720062405.E079D1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720062405.E079D1F000E9@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NyBTYWx0ZWRfX0OuZ5IufJHNA
 YeV2LM/wzc8+RPZRXoKe8u4zpgjps+Y7bGwi+PmkE9kErckBzYuY2+Rqoxc53QK2aTMWMwxFJ/i
 +btTzA2nqKgF4eQafpY7Mp9PuFvof2I=
X-Proofpoint-ORIG-GUID: -g4dsRQX4HNzE4eEscDcIMsJlOZ7lZk3
X-Proofpoint-GUID: -g4dsRQX4HNzE4eEscDcIMsJlOZ7lZk3
X-Authority-Analysis: v=2.4 cv=X75i7mTe c=1 sm=1 tr=0 ts=6a5fc052 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=fjmCN9aIutHrqzZMW0YA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NyBTYWx0ZWRfX+2xfIFN8izDS
 0Bx8eWO/mgW7pdHzHHzTJeq9BzRNpBRaY2BhsKGwveqZF2jD9uW29rSeUjKK5KhsIPhVPGwtnbx
 LcUg1Ra6jmXd8X7R8LlPZ5NnkrOGUzRp9ulM7Ug7W6wc4d2iYv9Q7Zu+16ZQzEUHus2R1MitLRh
 +wOgp5ZrbAC9U7KHMAtNksx37+r9FMmSeYdZv/5kEeszfZoprEcu6gMUv4behcL6idYT4D8ep9S
 FHwvpB3PsCPxXzp9vbIc8dMrUI7klJlQwFK18dZs/IrvoP/YrpLzT19X/A5wudG6nCgPTMvUEsY
 39d7zpJtrYNoyrdw6UutkoiLD1eAdkdAhJ1LyRnXAigeJOBKkW/RzC9d6sA4keRGU6QS4csXGTd
 0D4r1e3vzzVv2LgtfCTk62pZIkXyn9eS6oS3m2/r1rgJPfdmhSiUzLA2WzaU6RwKjUEFztuw9K7
 LUPk28I5hkofPByAc9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210197
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

On Mon, Jul 20, 2026 at 06:24:05AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Secondary stream panels fail to have their `hw_revision` initialized, silently breaking controller-specific hardware workarounds in MST setups.
> - [High] Stream-specific panels are incorrectly passed to mainlink APIs, corrupting shared link state and misconfiguring the link based on leaf monitor capabilities instead of the MST hub.
> --
> 
> --- Patch [10]: [PATCH v8 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it ---
> commit 07d3f4b80ae5875a958a8aceb22c9ffab07db108
> Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
> 
> With MST, multiple sinks share a single DP controller, so a cached
> panel in msm_dp_ctrl_private can no longer represent the per-stream
> sink. Drop the cache and pass panel explicitly to all stream-related
> dp_ctrl APIs.
> 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > index ae79cbec26d19..207643fa73063 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > @@ -219,7 +219,7 @@ void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl)
> >  
> >  	if (!ctrl->hw_revision) {
> >  		ctrl->hw_revision = msm_dp_read_ahb(ctrl, REG_DP_HW_VERSION);
> > -		ctrl->panel->hw_revision = ctrl->hw_revision;
> > +		panel->hw_revision = ctrl->hw_revision;
> >  	}
> >  }
> 
> [Severity: High]
> Does this leave the hw_revision uninitialized for secondary stream panels in an
> MST setup?
> 
> Since ctrl->hw_revision is populated during the host initialization for the
> primary panel, any subsequent stream panels passed to this function will bypass
> the assignment. Could this silently break hardware workarounds that depend on
> panel->hw_revision being set correctly?

It does. This should be fixed.

> 
> [ ... ]
> 
> > @@ -414,10 +414,11 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
> >  	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
> >  }
> >  
> > -static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
> > +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl,
> > +					 struct msm_dp_panel *panel)
> >  {
> >  	u32 config = 0;
> > -	const u8 *dpcd = ctrl->panel->dpcd;
> > +	const u8 *dpcd = panel->dpcd;
> >  
> >  	/* Default-> LSCLK DIV: 1/4 LCLK  */
> >  	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
> 
> [Severity: High]
> Can the direct write to REG_DP_CONFIGURATION_CTRL at the end of this function
> erase stream-specific configurations established by previously enabled streams?
> 
> Since msm_dp_ctrl_config_ctrl_link() is called on every stream enable from
> msm_dp_ctrl_on_stream(), it seems this might overwrite the shared register and
> corrupt the state of active streams.

Hmm?

> 
> [ ... ]
> 
> > @@ -1810,11 +1821,12 @@ static void msm_dp_ctrl_link_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl)
> >  		   str_on_off(ctrl->core_clks_on));
> >  }
> >  
> > -static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl)
> > +static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl,
> > +					      struct msm_dp_panel *panel)
> >  {
> >  	int ret = 0;
> >  	struct phy *phy = ctrl->phy;
> > -	const u8 *dpcd = ctrl->panel->dpcd;
> > +	const u8 *dpcd = panel->dpcd;
> >  
> >  	ctrl->phy_opts.dp.lanes = ctrl->link->link_params.num_lanes;
> >  	ctrl->phy_opts.dp.link_rate = ctrl->link->link_params.rate / 100;
> 
> [Severity: High]
> Is it correct to use the stream-specific (leaf) DPCD to configure shared
> mainlink properties here and in msm_dp_ctrl_link_train()?
> 
> This appears to misconfigure the link based on leaf monitor capabilities instead
> of the MST hub. If a leaf monitor doesn't support features like enhanced
> framing or downspread, but the hub does, could this break the link to the hub?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com?part=10

-- 
With best wishes
Dmitry
