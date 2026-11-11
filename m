Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CAF606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UUp3Ssbp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NYjLIOEQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E373110FBCF;
	Wed, 11 Nov 2026 14:09:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAF210FBCF
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:09:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCZ1GJ2338053
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QPstyFoqSPmuHiNdLUorh+Rr
 f2UfIpcMs4IumwAd9y4=; b=UUp3SsbpMCxDkmG8IVteiSnCXOXpT8PaZqwzPyzO
 DHGJrREKLf/xq8zpVZgXdboYDqvD3DvFlaDEE7BzXgLiSUbNo4eAyUjMAdsNJW7Y
 gP97dCBnH3+ykf0gYuvz8RczrG1rXDSZMUs85q+f76ua6PA5G0snPAMRUW4H4IXA
 6p0C9Lb8Ic4iHXE6qvkWvFVABLAa0vrxlgnux/K0pkA/wSNFHIuCtVO8BGhvlMx5
 cMoO28JHX1QrYl3fKAJCzhYlb81VqqItDUTLDhpMoK+N6+VuxxZ5RX34LCxyPU+d
 UZxiP2QIYua22z53/B+CpmdaaNoXSv6j8/JG5yrWa3ec7w==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnmay43-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:09:18 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eacd2f2229so3608181e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794406143; x=1795010943;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QPstyFoqSPmuHiNdLUorh+Rrf2UfIpcMs4IumwAd9y4=;
 b=NYjLIOEQcfc4bLHC06uOaQedOCr0YfUQxpfTxyB3zIx5Ae4KmJRSS27nrR65MbFvcf
 AAPU5/g8y2ODITlD4kSrw7OGuVcJTxy4YWh7jVu5SFxrUm+riHKl/jKvb4KCRfsCnbgP
 29sgpHEFgvSWD6jQOzUy5LRIIkbhFTuu0wUI9srqGgXFDZn1/THv5tWC6O1QYt2DA63X
 7ezK+Dv2TGuD6Vk9xUpj8fI4EURnCtupawnQFqK9LKS47PzNTb3ce8oVWJXZMgXm/DY9
 DqpwoOgp5hhTi176kM0VoQG3upj/0noQcSf4R/LqgrRPKkjXml4dT6s59//Vfnm2N6RA
 dA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794406143; x=1795010943;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QPstyFoqSPmuHiNdLUorh+Rrf2UfIpcMs4IumwAd9y4=;
 b=sjV3KRZpwpixSQZu2RDKNsXslIJIckrkgsW1drpB+2PyG2lnZdnSxZo4rP+gjRPTts
 aAm7d/BW3EY4osnBSb7L2YnQfXOsGJvm8ifeQ41idp+v5HzP8ZkElmAB/BvAnAgAfnUl
 izRh4bziOKtzm5OGdVLrMMGbeKsjQaxRifGPZYUWzsYTP5q63HdZWlxz/s0ClUyLNfzr
 HjiPA7DaxG9WZpCo3D2JRiuUJGSi06rGpanFkJ+sjGhZmsuUaj7YuHrD4rAQzmfq5I69
 Q3D2FO6dg53LpySA8qvEcA0vkEcV8mOPwX8ZZ6wRQnd9nktsuXXi44anCdYJZ/6CdeF1
 b6bg==
X-Forwarded-Encrypted: i=1;
 AL+hErFMEmhm353r5Uyk/qYd0EPGfoe/oVHESOzGGBuDN5tUlNv4CJ3Ng2WKUs5q7ORCvzg05s5EIyUqkW0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+q2XmjhIkTpdvGssq4ngJEoTAuic1G0D/lpSSmFVxFwQj2l9RQ
 m36h5+RTnxn7/H/yHMnVcTXuJTd9m4uKnFSAtZje3KA04hUV5u7bxTAjzK/4esDYukisWp7UrDo
 PgRZT5UCv5c8KVAzOTf0IukLGcA8VSzLjaCau6noRCsqRVrXmfA0rCPn/xbM+DH7La72PMy0=
X-Gm-Gg: AYBFou09DPq4gvpv8JXgYBDEWjJ+41m3vrpMRY+3E8bIAumzBwC4El8/JnPLZkRAO/K
 oAbbtMPKcUFMCJn5A5G6Lwwuvrfpbx8S0P3APfuP49wzpvmSmulMJDPBbd1RcwENTARguNxqMfE
 xD6wKxCzGV+LERgO2wDMYL/EYmtjkkaIB4vrlh0hpJJqCjx1EB3E5nFlV/oVFZfTGphmGUGk/HA
 BOoEErsnNOoadjNbHTgm5PdvdWQ3D3+W/pPuWrKTaC2rT2Lzz6fN154TtUiYPN5tbeYyi5BGzdi
 Wks5ZzdG9R6hz59GbpxW8I6P3PSmXeyF+UDVkvjqv/PecfOq4HZIa8qMKulV4syw+LVFqWSwe/J
 qAYcmSz0vbl5yGPnljKx8K7GZXLxFOs45RKskrOf/+6oXeXqAWbIbml0rCJZuwzEAJ1+r9CKtL5
 GFpXJhhVoES4F6s7v0ZSIOOM2PQC4msdyWuoHbvfDC3JoNAvkf7CzwvXpI4JTxdw==
X-Received: by 2002:a05:6122:4f98:b0:5ea:c722:b3a with SMTP id
 71dfb90a1353d-5ee1c3b5490mr777642e0c.7.1794406143347; 
 Wed, 11 Nov 2026 06:09:03 -0800 (PST)
X-Received: by 2002:a05:6122:4f98:b0:5ea:c722:b3a with SMTP id
 71dfb90a1353d-5ee1c3b5490mr777546e0c.7.1794406142456; 
 Wed, 11 Nov 2026 06:09:02 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157bb87c6sm972630e87.78.2026.11.11.06.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:09:01 -0800 (PST)
Date: Wed, 11 Nov 2026 16:08:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: naidu nama <naidu.nama@oss.qualcomm.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, irlied@gmail.com, simona@ffwll.ch,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
 quic_mkuntuma@quicinc.com, mahadevan.p@oss.qualcomm.com
Subject: Re: [PATCH v2 3/3] drm/msm/dp: continue link training downgrade when
 cable is still plugged
Message-ID: <x74bp2hkm4r2qz7oelhwpgexd3tslsxgc67pu22kmlo5yjy33z@v5ka23e5aqqi>
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-4-naidu.nama@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111104434.2222182-4-naidu.nama@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: kl2pf5bm0RAh-n2QhqSJ62aVg5fVYpu3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX27MImfekMDJe
 iS8jHCiRhwzxPN8pfkZTRrpN2tb5/NTcONNdguDS6EOaZqmD9VUw60CF8zHovg11+FF0YJ4ss/G
 XPWnp7jnAr8zPT4ZJQ0m4B7/rhe8rRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX2JXWLgNetyHi
 +dTnBWnl3bEq98VILxSu9zS2Ub4WNxJfmXBrNXTW6Op5+aAaFBdmzTYwF9DhNH6iH/Cj0M4xtD6
 u9EbXkJPRePHrZd8ef7OgZGSJgmdgnbMoH5q4IbAXuqN4EgIYDViR9RyHPxesLs0sj5yf1o6nrb
 7Jy4eMyPSS6ummC/7N7QUVAmz+P+hz/HAWlAUq+HTXprtHjGE2Prel0ffwK8zbrQ84cOxXaK4bP
 7j7evNXNZUYM43ZcL8vLIL5CkOawvuxGIX2/JTWPqQQaFNMNwOTk5AquL0wmo+vc4gI5dvHGV5m
 bf3YJP85TZ8c46DVzPxNkwyLnkqkAAwEMhNacaPUUwUaTd9Ax+LXyQE7l4ir8KA92XK2IzLE4B6
 P3Y+YQUrYwbel3X7FOx1tpmr4qvbEDYgUx5sgiJZ8shORiVVN8sFHKdiFbaSvoli0wXkjiTJ2ln
 v6yaW9Hg9pSGmyb7CUA==
X-Proofpoint-GUID: kl2pf5bm0RAh-n2QhqSJ62aVg5fVYpu3
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af4770e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=uXSOaOdxFjozXxwA47UA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 04:13:55PM +0530, naidu nama wrote:
> From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> 
> During a Type-C reconnect the AUX channel may report link-disconnected
> transiently while the physical cable is still present. The link training
> retry loop in msm_dp_ctrl_on_link() was aborting immediately on any
> msm_dp_aux_is_link_connected() failure, preventing the rate/lane downgrade
> path from running.
> 
> When the display is known to be plugged (msm_dp_ctrl->plugged), an AUX
> link-disconnected status is likely a transient glitch rather than a true
> unplug. Allow the downgrade loop to continue in that case by requiring both
> conditions before breaking out of the retry loop: AUX reports disconnected
> and the display is not plugged.

Is there a reason to assume that DP is not plugged at this point? I
guess not. But the other issue is: what if the DP gets unplugged in the
middle of link training.

> 
> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

SoB

> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 15 ++++++++-------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
>  drivers/gpu/drm/msm/dp/dp_display.c |  7 +++----
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 6b9d9a76ba05..f8a6bd7b0d10 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2274,7 +2274,8 @@ void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stre
>  }
>  
>  static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl,
> -						struct msm_dp_panel *panel)
> +						struct msm_dp_panel *panel,
> +						bool plugged)

Can it ever be false here with your patch in place?

>  {
>  	int ret;
>  	unsigned long pixel_rate;
> @@ -2293,7 +2294,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>  	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, panel->stream_id);
>  	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
>  
> -	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
> +	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel, plugged);
>  	if (ret) {
>  		DRM_ERROR("failed to enable DP link controller\n");
>  		return ret;
> @@ -2310,7 +2311,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>  }
>  
>  void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
> -				     struct msm_dp_panel *panel)
> +				     struct msm_dp_panel *panel, bool plugged)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
>  	u32 sink_request = 0x0;
> @@ -2325,7 +2326,7 @@ void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
>  
>  	if (sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
>  		drm_dbg_dp(ctrl->drm_dev, "PHY_TEST_PATTERN request\n");
> -		if (msm_dp_ctrl_process_phy_test_request(ctrl, panel)) {
> +		if (msm_dp_ctrl_process_phy_test_request(ctrl, panel, plugged)) {
>  			DRM_ERROR("process phy_test_req failed\n");
>  			return;
>  		}
> @@ -2377,7 +2378,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
>  }
>  
>  int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
> -			struct msm_dp_panel *panel)
> +			struct msm_dp_panel *panel, bool plugged)
>  {
>  	int rc = 0;
>  	struct msm_dp_ctrl_private *ctrl;
> @@ -2427,7 +2428,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
>  			break;
>  		} else if (training_step == DP_TRAINING_1) {
>  			/* link train_1 failed */
> -			if (!msm_dp_aux_is_link_connected(ctrl->aux))
> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
>  				break;
>  
>  			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
> @@ -2452,7 +2453,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
>  			}
>  		} else if (training_step == DP_TRAINING_2) {
>  			/* link train_2 failed */
> -			if (!msm_dp_aux_is_link_connected(ctrl->aux))
> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
>  				break;
>  
>  			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index fc884038182f..3edf954cc805 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -17,7 +17,7 @@ struct msm_dp_ctrl {
>  struct phy;
>  
>  int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
> -			struct msm_dp_panel *panel);
> +			struct msm_dp_panel *panel, bool plugged);
>  int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
>  				  struct msm_dp_panel *panel);
> @@ -28,7 +28,7 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
>  irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
>  			    struct msm_dp_panel *panel);
>  void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
> -				     struct msm_dp_panel *panel);
> +				     struct msm_dp_panel *panel, bool plugged);
>  struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
>  				    struct msm_dp_link *link,
>  				    struct drm_dp_aux *aux,
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 169938ba515e..551d2c63ef8e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -399,7 +399,7 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>  
>  	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
>  
> -	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel);
> +	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel, dp->plugged);
>  
>  	if (sink_request & DP_TEST_LINK_VIDEO_PATTERN)
>  		msm_dp_display_handle_video_request(dp);
> @@ -648,11 +648,10 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
>  	if (dp->link->sink_count == 0)
>  		return -ENOTCONN;
>  
> -	if (!msm_dp_display->power_on) {
> +	if (!msm_dp_display->power_on)
>  		msm_dp_display_host_phy_init(dp);
> -	}
>  
> -	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
> +	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel, dp->plugged);
>  	if (rc) {
>  		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>  		// TODO: schedule drm_connector_set_link_status_property()
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
