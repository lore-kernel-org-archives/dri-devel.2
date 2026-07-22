Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1D7C44533
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A617F10ECAF;
	Wed, 22 Jul 2026 07:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IWwNTUUF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SkoP+pNj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D771B10ECA9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:37:47 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M6fuWH200496
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=G/KGU8fNwt5eqUcntt5ioXwy
 LtN7rhmlKxUZdtI6FmY=; b=IWwNTUUF1zOkH8ZIN1PZ+hrxfZLo9aSUIxaRmtpG
 7a9V1zq4cTM1dFpL9WAkGEolqGTmwbegUfGGfZM3zwe6sa9Jc1Slf+Nat2RgyxFT
 q18NNq4nYB1socfTFwz/DR8IySyIdeXYdGhMBtR76a1LO1WkugdIrP8HmPiyrAHB
 WWQU1QwBAL1PotDQgTwpApu7+xXuqN58EnOBSU80bhBhUD7lD0EDN7/LFBIpcZzt
 uhB/GWFqeosK2TKHto26FXHBn2HfDy3q/+oY2sA8HfCCuMNvsD4vRjptNLBneRZh
 9mTq3bwB/xzleQonNho4iJXQigcho9LJz3BDLocmjEroLQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt0807-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:37:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-522de3c645dso105826081cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784705866; x=1785310666;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G/KGU8fNwt5eqUcntt5ioXwyLtN7rhmlKxUZdtI6FmY=;
 b=SkoP+pNjPR0SqXzT98eXSyQ3bdZBTVHa7OMLEZwtq3SKDqbtniq2Qs8bVTMFVS1LUN
 yVCkmsUZcICcLj6Ah07Tq/yizXlLbXEGlmWsmOqwJRjtEfgDGgqjyMLOkybxC8ZXLWKP
 AM/G/Y8AjnXFnRmzBWhFtsizrFodk8eRphEDpurb4QrnhW/mih/eijYXi9XWuAv5bTI+
 1J/OstznKhM0eGvCh5UpIFwjQasKxf2ieJiPR+RYBqq2Rfs0yMITmfP6cp9lf9MoNnpJ
 VaoJNGgXh4rPeJlJ9cseT1eYHaDUbuM6oSrJCdpt74r8LXDdRtBG1oy78E9brLOqccOx
 Jh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705866; x=1785310666;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G/KGU8fNwt5eqUcntt5ioXwyLtN7rhmlKxUZdtI6FmY=;
 b=C45gMOUH3osizCiTKqzhMi9zr2DxzKIvZfoKR0tFAwQnPAqLnLCxjc0wLxNIoKstur
 76dOu+pcjlEoFAfK69RFyg1o9UFaCXbZrkAOKT1V0ofSMVD48ySf3CltmDdODRcRbcQV
 UtodsvH3LrhE5TfGZztL/NMhcva5mDqSgflg9Xcf5z4Qdqb1wx4cqj2jCY/FZDvNy9CT
 APqO55UyaNOFwzWcPA4WPxSvLJOXCp2wQqyhfqRv1MLdwbS9N7yAiZFMCl88GP4pyZ8/
 +z0bU5NPw5GUZUpzha7OxVNEK9Wzs4g+O4B45QDkbEhSqe++nKEpjJdKDQC05pCPfqAD
 JEzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrLBfM8M3cqkiswkvY56ce16/6driemLVt0YTfYvfxHz+LQI9S+5XVjdGAvasck2iJ5I7WmA4vl3o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy41M0UpTk/Aqz8OY2iurCOPLsL+TSr/F20l5HJkOQyBXLfV9ab
 b/zcC/lbxoMFiMM7ecZ7vS2VcAmjjoiS+WC85QnnJGOYUifrWC+9Sdkic7yl2xCIJMrV2IEnZ7l
 1NPiCxSNalG2rxv36vFsmA6iw2V3z+zNF6aTWVHMXAAOh//Qd/VfdZxxZU2x+vVhX0rdXxTo=
X-Gm-Gg: AR+sD10tgZ8oGn2cl/XR04FLZdNsvlSiBoY+cMUDihq5D1OhqNxwfJgWag9/RJhwQ4f
 /N3uK23JhWP4kMttGtOp7xpJi2D60243IemJ0dpY9Te/sNSSWKVu8dy8rYko2ptObC0Jknx+bW+
 om5DxxhrJ8x2G17/P5SIMNvkIb/mS0V5nT3BxSxcZiKEo2aag7b0DuCkdPx6ibxLne7DOCt9wmc
 TQiD4gY0bCPZNt2jd+aLxQT0kzRhhL3r7fNljbEZslSmKPcN9Tno1438jGU9o9pv87HMhtcw1fT
 C/gVLFwUy+ePQKiaOfgyHYZ8loOCYEcnILSmJ3FU2gDQvxXxVwbrzBxMl8lwt1pYLlmVSRGu1ge
 9iHbnB/LT13Sja2Uf6oIOkkaFAyYuXFKHFe3C9/nMruQv6v8DdItMMhggJel9PwIA4SnnIid9s9
 PK3RtPcwXnyjSP5g==
X-Received: by 2002:a05:622a:1a9f:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-5213ad60752mr206410871cf.30.1784705866420; 
 Wed, 22 Jul 2026 00:37:46 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9f:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-5213ad60752mr206410531cf.30.1784705865990; 
 Wed, 22 Jul 2026 00:37:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39ef6d8bd17sm2985771fa.38.2026.07.22.00.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:37:45 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:37:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 06/30] drm/display: hdmi_state_helper: Plumb HDMI 2.0
 source scrambling capability
Message-ID: <xcnre3jnz2xshjvf76tzms72sk5w7koa4lz7rcqizmcysu3dtu@u2rptephae7s>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-6-445eb54ee1ed@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-6-445eb54ee1ed@collabora.com>
X-Proofpoint-ORIG-GUID: SQtjNd75dDM1bF_FFfZEDvY3L7YuILD_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXxp1FoY129rPM
 whMrc7pAI3VGn/vsR1AREVj5nAz2grQLdnAi03ildCvdvOIwNj027aAYgNvQ2BC1yaYW0YmjFfJ
 aY8nKICQDFe7Dg/c+hiaZ3/nnMXsSq3Qmgs55F5goeEz66nO20XnLXVW0gc2PAgMqGo9tir5yqY
 T4gsRN0jBt7sg/QFlfaGRAc5EP97E0WDeW1O/ybfW4cY0QMLlMwK1jXhn/0yW9EqIhKSHHSGf92
 Du3DZlxYP04syfor4X71UXNQxOnNYyfpX0r43H0hAkoZAUDRAoLQD3vZ/BqDTA2J1E1Tu8nWMH9
 +ewFo7By25L7PgRoID6Zlo29oNJAn9jOHBkbTRWxDa3wE4HV65KKH3B4ch/hmazF0gJBLMoW2aG
 2dLg++mLsK1WikAl1TQN3OAe/Jd5PdseG0gmApLCCtupmjhDyyemSxqlvoYzkZbpDS1OfJc6q4I
 OfPUHHqqA+KFjIeOTfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX/N3OrSG43KaP
 pi0uZxPv4PZE2R2R7SLkJsulYIuotuQoL/K42U4t/9HRPDAN6vrUFcMXXM5sDiFd2yYkbBjC463
 5PH/bP3m0a6xtgfHaKXzve0SZVLyvew=
X-Proofpoint-GUID: SQtjNd75dDM1bF_FFfZEDvY3L7YuILD_
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60734b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=oequfIBpm4CPOrf6xoIA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=kacYvNCVWA4VmyqE58fU:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
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

On Tue, Jun 02, 2026 at 01:44:06AM +0300, Cristian Ciocaltea wrote:
> Toggle drm_connector_hdmi_state.scrambler_needed flag when the TMDS
> character rate exceeds 340 MHz and both the source and the sink advertise
> SCDC scrambling capability.  Drivers no longer need to open-code this
> check.
> 
> According to HDMI 2.0 spec, scrambling is only mandatory above 340 MHz;
> the optional sub-340 MHz scrambling path is intentionally not requested.
> 
> Once all drivers are converted to advertise the scrambler support, the
> unsupported HDMI 2.0 modes could be simply rejected.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
