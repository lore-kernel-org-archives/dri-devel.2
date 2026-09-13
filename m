Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2464FC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E5910EA3B;
	Sun, 13 Sep 2026 21:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HiG7s61O";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kKkI4wyY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C75410EA3B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:42:35 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DJxvSu1986393
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UAdGueHE+a9zntgGiuhM1GjC
 qAqzf2hTlkwX0CikYMg=; b=HiG7s61O7LGrUojzPSNwW2HKxGtpYY3b88ujTUKb
 bCz5YQeaL1TvTwyu/bR4bkuoLNH1OXicEdKxBlRWa6xI5XwLKLWrUisB+inMjHPt
 yiaZttPMLj1pU1rDsqxtBnIitLj7TmSKsT9yTtioZjE+IOjGRxSjUBhlkF+nahOs
 1A+VL6iuLZYJt8WeheaW5DnRma/8QI6kfRauPkD8ripL0p/y8OqdSI97VH8XLAeY
 hYVMXso/MHXdeWoN9Tfd7dEjdcfUARMHkjU0TBsb1L+SLoTGoiSbntsjm7PhVxu5
 +od8D/nSWUgqo6akM6tHPP9KHqvj3U7PPd89be8d3a3D1Q==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cc5pp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:42:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c82c2e9761so591441e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789335753; x=1789940553;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UAdGueHE+a9zntgGiuhM1GjCqAqzf2hTlkwX0CikYMg=;
 b=kKkI4wyYy6AMf0CfJ74LNkmS8hWIi8xVxQ4bjhJSB4OTlVk+WPnPr0ZBRp036VrH3K
 PtbRTj8wHnSdD3TU47/5e7fKy6RFq9saUUmzJWCsPkRcP7CQeFLkWfst1f3ZmUz2jngu
 aNZfL+sePWJuycDp23nqB+dc8XGNlqVu6lK5RqaTgE6q9mDTreiQtHwKi/5ImIztTzfe
 qUHKWV7p2zJB3Y4jm9cybkBaqLYTRdqa4j/jPBE7m3rkbdxc49XZkxy/QQwgmWm4fT1k
 XLUiRfOhzlwNiMjx+JbF7PifuparS/wtHvK/d9qKQTJivdbq5l+vgwI0H5vEC27ZjyHj
 7JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789335753; x=1789940553;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UAdGueHE+a9zntgGiuhM1GjCqAqzf2hTlkwX0CikYMg=;
 b=a4xHXmh1fbZhKs5sd+kPA3s2O6/Mg7e+MsBTW14oFofNUGbtPMf+zk+Bp211szlkvj
 VpFgny7VbHZVTeT+r//yH3886w3Ge2hEx5F1EDS86B2SVwm8HETEXKSwxkAUvo0xxBe5
 b0Amo7oJpaCIu//X0INTkLjZGWactGO1RfhcQHd9nP8ZiDZNG8OW6S0oZY7pWWEBvQrQ
 b4HmtoNgQRM4Yn1ShcNK1jXj4I7b8UmMX/ynZ5ZqAJmliJCFoC79at+5ONRV8GcZq0BQ
 ak6pN3wIk9yrJblT9BAXjkQyAp3zxiCSX+A5JJRqN0iqhEjk+8H6qOQMJ41YSKuUNIFF
 Fl/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEDzWjPumRlE4MW8ZuS5rfArP2nv9lMOd+kuyk2/eDgGHg2rbyt8dfRwHtzs3dICmNixCp6hfXoBo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0EgNNnQXkAXDE9XsGYvDHzYcs803oOgtLeVgMRmWUCrygDBPQ
 Hthz/Mt/Xw2sslMxsR2dgqukPCBHhYcDqtlurSiWWA5sNQd3ugdhiPj1Wpd7PbjqxFh7odO3CCX
 NMhJg8oaeKPphkyumFpNRq/TROeXf3E0DEfuYZy01efvfHPe6Z4Gvg97MAKtF4e87u//SwmQ=
X-Gm-Gg: AYBFou2eaaoRY6v6N56Ib7tpHZjuG6Mr/ubEBQPQCXO3Wk6KN7qkvOvpn9768zswcCb
 S8two/A80XBy/gKZATx9uibaIyJQoHkCyhFvJasyH/VBHMqcuEpnBKS5f0i9w3lf9gnOImjHOp+
 33GMtlxoanrNLneRC1qGBUgVy0oNj+flqEKq3nDz4KsIqKY3zpPF6DV81JN/f4g6QkVeYEJzWR6
 G0jFp1lbPgjzYxERVMwOjdeYWsFD9/vAcyT9k6WT+A2T/JEJvYL0HSwbNHa4OE7Tg42JyZ5vrcW
 jxOcBdymmccVe9/4ufwUVdfMPR/GIhfTYNFfNrNp8Akgss9y8G0YPthS4ZoK/R2vPuaAhlJa6Ip
 binzZJjtiQP+rtKGFew85HHL6yxF6fu4+89InT9giGvRjxgxgDIVA350sOrEMlhW/CQz2ooyszb
 SErEZKn7SaPcvo
X-Received: by 2002:a05:6102:a144:b0:796:7d9:a60 with SMTP id
 ada2fe7eead31-79607d9203fmr2599821137.3.1789335753490; 
 Sun, 13 Sep 2026 14:42:33 -0700 (PDT)
X-Received: by 2002:a05:6102:a144:b0:796:7d9:a60 with SMTP id
 ada2fe7eead31-79607d9203fmr2599819137.3.1789335753065; 
 Sun, 13 Sep 2026 14:42:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a047854fsm1938531e87.67.2026.09.13.14.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:42:30 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:42:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] drm/msm/dp: continue link training downgrade when
 cable is still plugged
Message-ID: <q45k66o2geby5lewynwx3okmmmun7ippmlzsyx6jegabptmrd2@cwk4f2hu7vwk>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-4-2825e5bf8a96@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-4-2825e5bf8a96@oss.qualcomm.com>
X-Proofpoint-GUID: mwN7UcOhwyf_YHMw3TWM5jhVwx7YKXMR
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa718ca cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=282R5v4PAPrGKAVVY-QA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMwOSBTYWx0ZWRfX/pLSEzwLfZ9L
 WV+kUPEbuyqdZCDti8OhPBrOleQjkeAUftBKU6CWszWwzZ/mWtoASBgO/QX2OJit8HtW74cIUIC
 Sm1K02l3Odxm9C1BOAKcukvpfZ7LMxc=
X-Proofpoint-ORIG-GUID: mwN7UcOhwyf_YHMw3TWM5jhVwx7YKXMR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMwOSBTYWx0ZWRfXyjnEfuDO6uQf
 Jafn00+bQhueNMZovBSi54t+kMQZCccqjMUAmkQ9U8KQRbZFTvjwavsH/dlpHBh7uQZIJ0KTZQQ
 aIusTe//1OBo3XKbkRjT1BKK1AkXG1exqO/8o5WKA1835XYP6NmY3nj/FgFPZoXKiyILPGIHjEI
 Qw9a72awpEWnt7sqnWmE8oQb1JDwZs0EbDm6EwrxY4ZiKZ8NfeEotOxxRM90ynHoIaglcyDXIqt
 NYxbd5nxehst2EcadJpEI3LGCFTQmi98cRicvRNUM47joNHDzTicgEz407z5OoYnJrdXmS2lact
 YQtrpq10WpuDrejEkVOVWhz78VHOiJ4omAsL2Q5qGy3VPnPbvNLjEY8czolygVCiamIR4+V8pci
 iMlFzA6QGIQwMHRo2Tym/tCWPFn0eUWx6USf2RSYRY0j6kqSSNyjcLn1fzv3TfY/XdiaCFOmh/z
 9CgWqBeN5Rk0GZqKaPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130309
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

On Mon, Aug 24, 2026 at 04:58:07PM +0530, Saurabh Anand wrote:
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

A cable reconnect should follow the full procedure. DPRX may use long
HPD pulses to signal that DPTX should reconfigure the link according to
the changed status registers.

> 
> The plugged state is snapshotted from dp_display into msm_dp_ctrl just
> before msm_dp_ctrl_on_link() is called, so the retry loop has an accurate
> view of cable presence at the time link training started.
> 
> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 4 ++--
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    | 1 +
>  drivers/gpu/drm/msm/dp/dp_display.c | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 59070f399e2d..e8fd8f4c75fe 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2379,7 +2379,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
>  			break;
>  		} else if (training_step == DP_TRAINING_1) {
>  			/* link train_1 failed */
> -			if (!msm_dp_aux_is_link_connected(ctrl->aux))
> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !msm_dp_ctrl->plugged)

Locking?

>  				break;
>  
>  			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
> @@ -2404,7 +2404,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
>  			}
>  		} else if (training_step == DP_TRAINING_2) {
>  			/* link train_2 failed */
> -			if (!msm_dp_aux_is_link_connected(ctrl->aux))
> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !msm_dp_ctrl->plugged)
>  				break;
>  
>  			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 5902cf7e746a..95533b0b6297 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -12,6 +12,7 @@
>  
>  struct msm_dp_ctrl {
>  	bool wide_bus_en;
> +	bool plugged;
>  };
>  
>  struct phy;
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 1f60c78a463d..93a37a44273f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -644,6 +644,7 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
>  	if (!msm_dp_display->power_on) {
>  		msm_dp_display_host_phy_init(dp);
>  		force_link_train = true;
> +		dp->ctrl->plugged = dp->plugged;

No, don't create copies of the fiels. They easily get out of sync.

>  	}
>  
>  	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
