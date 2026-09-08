Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22194C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D2D110EADD;
	Tue,  8 Sep 2026 09:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkSJ2Qln";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MOrcYKVL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F14E10EADC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:13:20 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886Lrjt2154211
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 09:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KWwNAX2mUWCs5FzODk/uly2iRuerdONpcs5Tz35srsM=; b=AkSJ2QlnMd5zFhSx
 iS0uYsgDfVBP3rqbT6mRixx3ng+7k9pB3MWUSnLkfutt0Cg0vGvJoQjQTBld47tj
 bagplflc+bng1oQpUvTS5nXy0Cz+d2xD5Yy315ZXNU79DYc9xs8BqI9P+U+cQv34
 XkSoVvm162JJezqAVWQp8vjwnPtsOnbl1kvlb0gLYhKGrh8KQDWWhVPHBZEYqoXI
 zvpSR8ID1gk2jpmJE8L1l2GvHzchVJSswoghmWGDVgnKSCyKPMXpt93SN/bzhxRt
 0INkUdk+66nuJ0OY0bPB1y+/qoxg69B9MLh+FLJ3hs55FOeZedX9V5sqNjgIoLZO
 sAh9HA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwjnu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 09:13:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db3734d06dso53581915ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788858798; x=1789463598;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KWwNAX2mUWCs5FzODk/uly2iRuerdONpcs5Tz35srsM=;
 b=MOrcYKVLfJJpMLbdMKbPV/bqHo59jg/pAZ1GFdSFKnzO2NrXNhbAt7uJZ5MrOseR6o
 FeeKcst5HNI/ddKdRd06heK5X2Xfnrm7zgonu+ri9vRdB0IOYWVMjQAEx0FgZDX4tPnY
 9/d2PrLUx0CiEWoRvQhAgdlchtAa1InTBR63h6GkOSCGuKlLXr96VFwJeuHq2BQwhYP+
 SOwtgCFuAM7MCgSrKTYdFNStFHnV8pcz3kgZjAYuAfs7rN9S7Wae8wGNvrdewtFuaJmW
 uTvHFoxonHe6PIZ1yf/1E2D2J1RX/YeACd0IuQivfBW5X0zRRGNHe/QIPjW48bmPcNvz
 JZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858798; x=1789463598;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KWwNAX2mUWCs5FzODk/uly2iRuerdONpcs5Tz35srsM=;
 b=XcmkMCmyq5N9/AqlT7LiPZLrBVDbQLTIA/IkbUghukP2truDJiodP16r/snF0EiERo
 O+eJRa2D7ehnHseSTQmGxnu/WYFT+uue+tWiGMWnNxJjLxXLppvxTZdbkS/0jqmFCvy/
 gau/S6TO/YGrAAwCX8f4qXZuNc6zF/ZQomNYA9swdjOqXUY0b7viUzGwq15Ugk+cJL1D
 FNPbsf31q2+7jqIX5GVo3NzjdUfPlBcgn7bhGOU0CjeJ6zVwYykKf8GLYh/hdzwqRV2l
 m5OI8mKsJgJicoy2VNZUpkOn5b9ni6/piOydyYN552vvmzq+W3zFKzmQNn9OnGqA8HPk
 UA4A==
X-Gm-Message-State: AFuF++nK/e++4MOpxRbaDqML/K4Ds9INLyKOGK1FcfjPKk99XbsHJx23
 fpJbSsb92evXXHtuYnKcaQnXIKo9ARA+stT4D6DOu59t4ugepUafueI3hwavM09vsu7GPyMjQ0m
 HVVK43mKUpZDd1OkgsaxKPW3vD7eLkgUn0vrvPK47EQdW3CugvDj9xs0vMx/YJAGZAZxWIhk=
X-Gm-Gg: AYBFou2UeIbt2GjByI4+1S8Kep23vfV5I36w1WwKVcDw8grZ9qeZkjDd3lq15OY/PW3
 XtG/i/qum0WK3W1uUGTnOb3sis8wiysDoCLupygN3IHbRufVZs8nXo0+iSFtYNLObvB5CiNItId
 lFtPRLG/9unVdXuojJnb/FLJAZ9DF358HRdJd0O5vcSn5gRUQDzbK5xGXrEJsYR/KSMhPZWWuON
 ObyvBheXyXVYQcdlQmJqEWmhVBN9ky+b571aosN3CF1/trcX6Mh0uGFFXHEwIZ+5+mwMYaG/f+B
 +XUO/RgO7GWKVLcpwer0RM0cluXLHXtcl6c0wjghd9OSk2Zya4c3NOcVhTzc4sc4G3DuZWUuENy
 vRvDba9VxU/nnLELYUbIDDDp7s/Yqui9Ks6i/T77Xqa5+nJERF5UmQSZ7bzL31fKHPaQOXDru
X-Received: by 2002:a17:903:13c8:b0:2db:56da:6a0e with SMTP id
 d9443c01a7336-2db56da6ea1mr164573715ad.9.1788858798198; 
 Tue, 08 Sep 2026 02:13:18 -0700 (PDT)
X-Received: by 2002:a17:903:13c8:b0:2db:56da:6a0e with SMTP id
 d9443c01a7336-2db56da6ea1mr164572905ad.9.1788858797666; 
 Tue, 08 Sep 2026 02:13:17 -0700 (PDT)
Received: from [10.133.33.226] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1497d455sm56667045ad.30.2026.09.08.02.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 02:13:17 -0700 (PDT)
Message-ID: <3541a607-0699-4028-8a06-70a5acbdd2b7@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 17:13:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/msm/dp: Add MSM Type-C MST support
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9fd1af cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=daqqUZpfhLtBxDMUUs8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5NiBTYWx0ZWRfX6nzNpGRqnrTD
 vf6xdh/ZYAf6R5sme6dMfMXIUAB/sRA8LIVRgD/4NONojdkD/j8q2dZfAtN/NSudPVUvupH7DPy
 kthMcNFIt7i4Al7jO+Sx98xmmTGUCwSHeABrwynLZr4X+a5fGBXdqpUR9oJ/HQ1nQEZKaSuv70N
 KPmZBkn76Th/uSpBIkrNiHHMxG+Q9+J1D0zj5rE3gN647p1BMrZFyIJpsPIkRDEZIWAmPffPEKN
 TItJPIApHgXY9scLTJhwbDhyrdg56ghW3ICzGEBUUYiYBs703pVzcuu82CceR1TrRQxFXjZmlQn
 BPjBrA8WV5SUXgLJ5ri82fgKZneMVludeLM/E3U4CCZngn0TYUihuYrXyx8Tyekpj0MH2jZwYQ5
 Bmzv23AV1UofqqOVQ4MDze7t2suVk8xbLMirZbAngibogWMZ8QW5eZ01qBTZvqg0WjeLi4abY3F
 nrr5GVSi+iksg5O4L3g==
X-Proofpoint-ORIG-GUID: 0An-CyPrXmL_8RSsFd67ldL0mCFl5x_s
X-Proofpoint-GUID: 0An-CyPrXmL_8RSsFd67ldL0mCFl5x_s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5NiBTYWx0ZWRfX5VTW9mGpS8VJ
 f8YVRhOjNDpNp/zXTu76OhQZQlDA39Ap6tSMKlc27H82Fj2zt/SpWb0lrNyWG6jKNxPi6X/QuWI
 vV7S1LIFE327xRLdWQdpia6h5EDShrM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080096
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



On 6/29/2026 10:48 PM, Yongxing Mou wrote:
> The bridge connector framework currently treats every HPD notification
> as a connector state update and emits a userspace hotplug event.
> Once MST is enabled, however, connector creation, removal and hotplug
> handling are already managed by the DRM DP MST topology manager.
> 
> As a result:
> 
>    - the SST connector may transiently transition between connected and
>      disconnected during MST initialization
> 
>    - MST IRQ notifications may generate duplicate userspace hotplug
>      events, once from the bridge connector layer and once from the MST
>      topology manager
> 
> Introduce explicit support for IRQ-only HPD notifications in the bridge
> connector framework and allow bridge drivers to suppress connector
> hotplug events when those events are already handled elsewhere.
> 
> MSM DP uses these mechanisms to integrate Type-C MST hubs without
> generating duplicate or spurious userspace hotplug notifications.
> 
> Testing
> -------
> Tested on Hamoa-EVK with a Type-C MST hub and dual-monitor setup.
> Both fbcon and Weston were exercised. No duplicate hotplug events,
> connector state oscillation or display flickering were observed after
> hub attachment.
> 
> Dependencies
> ------------
> This patch series was made on top of:
> 
> [1] drm: handle IRQ_HPD events correctly (v4)
>      https://lore.kernel.org/r/20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com
> 
Hi, Gentle ping on the IRQ HPD series. I'd like to understand whether 
the next version of this series is expected to separate the IRQ 
interfaces or continue with the current design.
> [2] drm/msm/dp: Add MST support for MSM chipsets (v5)
>      https://patchwork.freedesktop.org/series/142207/#rev5
> 
> [3] drm/msm/dp: Prerequisite cleanup for upcoming MST support (v7)
>      https://lore.kernel.org/r/20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
> Yongxing Mou (5):
>        drm/bridge: allow hpd_notify() to suppress connector hotplug events
>        drm/bridge_connector: preserve connector status for IRQ-only HPD events
>        drm/msm/dp: suppress bridge hotplug events during MST operation
>        drm/msm/dp: report IRQ_HPD as an IRQ-only notification
>        drm/msm/dp: mark the SST connector disconnected when MST is enabled
> 
>   drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 +-
>   drivers/gpu/drm/display/drm_bridge_connector.c | 31 ++++++++++++++++-----
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 +-
>   drivers/gpu/drm/msm/dp/dp_display.c            | 38 +++++++++++++++-----------
>   drivers/gpu/drm/msm/dp/dp_drm.h                |  3 +-
>   drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 +-
>   drivers/soc/qcom/pmic_glink_altmode.c          | 14 ++++++----
>   include/drm/drm_bridge.h                       |  3 +-
>   8 files changed, 65 insertions(+), 33 deletions(-)
> ---
> base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
> change-id: 20260629-msm-dp-msttypec-b420df7da587
> prerequisite-message-id: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
> prerequisite-patch-id: adc6d802a2f71d23c077a5cdb9a257809e9db50e
> prerequisite-patch-id: bbd956a3b65a90c1fe9e884bc32c49bd83fd3129
> prerequisite-patch-id: 014460a25c380d089764ab4e1a58577ebc1b9e71
> prerequisite-patch-id: fc03fb9435b8c60321f9ae28e396a6bff2f347ae
> prerequisite-patch-id: cd4cd57a72c798fc95afdfdeb9b81cc7a2dbd25d
> prerequisite-patch-id: fe431fb614383eb6444f6bfb928e7e40c2de951e
> prerequisite-patch-id: 2a058aa8309016f424b1d4ca19a9b20e92f4d8b6
> prerequisite-patch-id: 64c3616bb979b663a01342d1f217588b347ae8bb
> prerequisite-change-id: 20260410-msm-dp-mst-35130b6e8b84:v5
> prerequisite-patch-id: 1d440cb9fed2bdd66d8de0e1e20475f0fe166973
> prerequisite-patch-id: be0f4b80697df7224c80362b161b8a9f0a542184
> prerequisite-patch-id: eefa6e6353df301420feae1da704a9db2c2155f2
> prerequisite-patch-id: 9e9095f82dd6c131c9f3c1de4fdb8a62bd65ca24
> prerequisite-patch-id: 3e635f008f9b56823101abd9253905f078fcb3b5
> prerequisite-patch-id: e39e0dc124ed043c7a419610ebe03ad105da27db
> prerequisite-patch-id: 945af39213cd4241e1a5929fada04a9286aeb5db
> prerequisite-patch-id: 898ae7e4582a6b31492c223e7dd167fb9ce78096
> prerequisite-patch-id: 3887553893357c1ffbda99eb010801bc2166cbad
> prerequisite-patch-id: 7ccd961fa3c6f925659dee7d7a5bd167c8e7331b
> prerequisite-patch-id: be2bf918e0e87ec2ea999927f36bd172c498748e
> prerequisite-patch-id: 6aacdabb2dd0536dc04da04f8419ae39e35f8b19
> prerequisite-patch-id: a9f27eff8f643ff445810b17d670891928f5b416
> prerequisite-patch-id: efd300a2b52715153b8c1c7407db696eb331594b
> prerequisite-patch-id: 950abefc4862050ef606404977fd27c5dd2cbb2b
> prerequisite-patch-id: c6a9aaba753b5538864f7f6e065d910833baec21
> prerequisite-patch-id: c73c1f6eb16b2a6ff11b20495fa0981683bdaaee
> prerequisite-patch-id: 94957394b3870ec63ab766d682df592da978dd19
> prerequisite-patch-id: f27cba0cf5f08d21f59f29a0c9ed7f197ddfa2c7
> prerequisite-patch-id: 683855949a9ed37bc0cc4d1899373e55eac4ddc3
> prerequisite-patch-id: 9b3a2b526476c32c8a859824e551e23412674766
> prerequisite-patch-id: be866cf2acd4960f31f0dbd05e21f0722dcb70ab
> prerequisite-patch-id: 58bd115be590c0d892a72e06794f5b244dbdb7f8
> prerequisite-patch-id: 87435a0f6827516f4e2b5d8471a2b289bb73a88c
> prerequisite-patch-id: 1064db7111fc77377dbf246eb0fdef90c18c46ee
> prerequisite-patch-id: e112aaf6088f2bfa90bc67feaac86a4fc1ad23ca
> prerequisite-patch-id: fcc0f2ee6dc0358d62593c1295d26a013fa11223
> prerequisite-patch-id: 66364b8806fc6abeabe1a0b871e4e8c841ce2aa7
> prerequisite-patch-id: 243046f52a14b416caead3469d580ea5b029f9bb
> prerequisite-patch-id: efd8014f647a6aa5fadc9d62a6e1920d76a6c80f
> prerequisite-patch-id: f4dbd5ae84a01ea89c7d00ca39fd76cd247bc353
> prerequisite-patch-id: 30a16a45edefc8769b10d90a7807b6522cd31f15
> prerequisite-patch-id: e12fd2908ca33de1f1265fd40190eaad8637e569
> prerequisite-patch-id: 3baac076fdda664d00aa9a83481f76ec38c07e8a
> prerequisite-patch-id: ee6a93ffa2d5461ee7b07929ff21626a14773b7a
> prerequisite-patch-id: c8d444e2a6512f106da2675d4a42a92208d5c6f1
> prerequisite-patch-id: 0491a69feb036cfa2e75401e093ebad387cf2846
> prerequisite-patch-id: 707e7a3e5114c86f5bcc0b36e7cc8beb0c957780
> prerequisite-patch-id: b1ae90d73bd7c3d19cfe4371b5dc9a816f1316a6
> prerequisite-patch-id: 4c183b8ffd599169c8d3c5f3aad5ecc467b150f2
> prerequisite-message-id: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
> prerequisite-patch-id: 1d440cb9fed2bdd66d8de0e1e20475f0fe166973
> prerequisite-patch-id: be0f4b80697df7224c80362b161b8a9f0a542184
> prerequisite-patch-id: eefa6e6353df301420feae1da704a9db2c2155f2
> prerequisite-patch-id: 9e9095f82dd6c131c9f3c1de4fdb8a62bd65ca24
> prerequisite-patch-id: 3e635f008f9b56823101abd9253905f078fcb3b5
> prerequisite-patch-id: e39e0dc124ed043c7a419610ebe03ad105da27db
> prerequisite-patch-id: 945af39213cd4241e1a5929fada04a9286aeb5db
> prerequisite-patch-id: 898ae7e4582a6b31492c223e7dd167fb9ce78096
> prerequisite-patch-id: 3887553893357c1ffbda99eb010801bc2166cbad
> prerequisite-patch-id: 7ccd961fa3c6f925659dee7d7a5bd167c8e7331b
> prerequisite-patch-id: be2bf918e0e87ec2ea999927f36bd172c498748e
> prerequisite-patch-id: 6aacdabb2dd0536dc04da04f8419ae39e35f8b19
> prerequisite-patch-id: a9f27eff8f643ff445810b17d670891928f5b416
> prerequisite-patch-id: efd300a2b52715153b8c1c7407db696eb331594b
> prerequisite-patch-id: 950abefc4862050ef606404977fd27c5dd2cbb2b
> 
> Best regards,

