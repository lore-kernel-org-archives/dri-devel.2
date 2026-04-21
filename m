Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ADBF8925F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7934210EC2F;
	Tue, 21 Apr 2026 11:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T2E9Sclk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZGocqwwI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A5A10EC2F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:18:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L64R183257275
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OjqOEUTYv4N3tr4tFQIsiKwT
 uySGC5CmTEF/qyDzJNc=; b=T2E9SclkQwpIDlw/I01o4VZymfXyA4NMHJ3kcF1R
 ZVaMyMop30epsq4343pedmrSlhIRjjOQV4TkGUMCJN0JnaOMKeXFRn2tUD0q4dl8
 sfgbNB/68YI2uI2BW9i5y6A5LORkZLD40CiYi8jga0jddhF1XGYv31+Uwq2zAe9S
 XYUjY88yz113+UhVUzdqLtMCoc/jPPQNqjPzF6pyd2J75+0umvkEK9sprVqDdTvc
 Fvyi8+oNJtfVGcsJOCKt/hYgWgEbdtyFs8cn+PUs8/NYlLv/fxwQSxPb3BkjpP5r
 HLTlJqzj5cPxK/8VHiSJc/LTdjtop9Do+81yrrAu4bgj2w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp3na94kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:18:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50da31af14cso111575531cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776770309; x=1777375109;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OjqOEUTYv4N3tr4tFQIsiKwTuySGC5CmTEF/qyDzJNc=;
 b=ZGocqwwI8G+hR4s93VoAGb7qpt4rb40vOTbZ9W/ftqVBJ8c8LMX0vXXuj8UQXyNRbU
 9q4UnlmHy6SjOxwo02qD8LkujQURvYYhJRC3TOpy98Qbua/mm85rRONinR+nqmHGzNnq
 aIfNLHm/LBjHH9aKljBCUJnjiUF9gS17TqZR1X76nMCUmryKPoBc0YBLLKDMCikv1bim
 SjNNVEtKjZMD+icKSlWfy0PdMCZAmUPu7j+edUumonkJlQTXHj/kIS6Jf1Pth70gs4f7
 NksE2PmJtPatU9LIecXqu9db3+ZZ0gZyi5d1R+k3DRmH7/wDlCjSd1gCvxZyySl03MNA
 3LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776770309; x=1777375109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjqOEUTYv4N3tr4tFQIsiKwTuySGC5CmTEF/qyDzJNc=;
 b=bW3xgakcH+QH0rJkSokA0vqc78wfPoLt+wAXcmUMU8ihEz3yV9+TJS7OAI8i6BI2o/
 4UGaB8UP1tNzeDUyIXoNNhHwaR4Xmx2zYnxwmoO0AVJm7u+e3AD6mTZLetEZpNLt3G4T
 iky5qxiIWVWVhaXl4p9z6DKyjXpTQmhOnwpuDNSA1JFO6542T5q/bxva2pmMyin6a2jZ
 4VvyLQWinhvDPEz9EMdFq1lPpsUpXuE5LJdq7Ubd2oFIvRTYr4IaoQadTdwtS3gAfBhU
 6AV7apGDq4uLcjeUGbpRmP57gJ00KqXrX4MOmWL273sY3UQpZ9W4OoMsqvrBtDmXKpop
 6YxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ea/frZipVXT6wR339ZHllpOK7yJzpnEk6e9lAJ0/DsoHLi9OxvrIx6pcCTK4rrM2lSXLcag8CfI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5uRNPItWX+pNRYIcAAIQlq4YzssbmIq8QO7lWZJGSIDh2ze6u
 vz5JnAb8AHnd5cPKmzWUEyCOH0JH2HY22zgclChlc4W8MyPYamTRsRr4kGGP3ZFUyMmwWQ9x0af
 Qp9jZoXtA7wLiJs03TvHwXekCG4z/++8oT1J+lqyguJSmvQOEYYffkgwnBoe0foN6em466A+1M+
 2ZIPY=
X-Gm-Gg: AeBDieu5OhUrtn/7ZitduGRY7gk0VUY/5UiILuNNrrhcBaEgbgf43swjXBUZKWy7tW+
 up7S8RhCna7Acl9a1ZwEdcSrpV0Yyoze3KYOP5nKPR6Uh9umxJwL5nV8n7nQxstxQ9OPHw4tF2X
 Dl7Y4IhqS6OfRJpjWJq7+U0GRY+PIBAVfXMTkAPEmhrthhJfURcYxzN8FwGXDU5ZADQjAympdxd
 OAwkI+kZFtP2OhfcqpXE+OTzndBN9teSwIc74ufnSI1YQ9Nkj45obqSmQIiJa2J8ApdiNGPnWeP
 zzTggp2tZcxyYgElEPS+aDBlpTUS7pPc62jnTJzdq6u+s00HogN8bgtOGd3m5hCi5G2mD+lmeOJ
 n1o7dcRv+iVNXoiOwgEklaffOqS2m79XbIaiVBQ9osQxmW/w8oYJ8HEahi3nbu5NKiqFGXz/zja
 W0APDWuniZAXc4nfRKQBvEoje2I48JSzsS1p6/R3irUMBrBQ==
X-Received: by 2002:a05:622a:10e:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-50e3681d042mr270130011cf.7.1776770308765; 
 Tue, 21 Apr 2026 04:18:28 -0700 (PDT)
X-Received: by 2002:a05:622a:10e:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-50e3681d042mr270129521cf.7.1776770308340; 
 Tue, 21 Apr 2026 04:18:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc240sm3603514e87.23.2026.04.21.04.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 04:18:27 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:18:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/41] drm/display: bridge-connector: attach the encoder
 to the created connector
Message-ID: <t2h3emaaz5v2svdlt6iabk7fifxhxycevo73jgai46mxjimaji@rmvejc7riy2u>
References: <20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com>
 <20260417-drm-bridge-connector-attach_encoder-v1-1-67b8b8fb872a@bootlin.com>
 <aaxyye3vsef56qxqmblv25mlwpjz5dqovblrgwaclq77tqjvps@kr3aec254a5y>
 <DHYSAK9P2RFA.WL1BXACGKTU0@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHYSAK9P2RFA.WL1BXACGKTU0@bootlin.com>
X-Proofpoint-GUID: 0KdkeZ0m5o54e39kgez6_y6wiuMC7O9h
X-Proofpoint-ORIG-GUID: 0KdkeZ0m5o54e39kgez6_y6wiuMC7O9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfX9cSLiWFnBqza
 +SpcQrEwmlDsXbVFoD3GYUhG7eeDjaR2HgYxdtzRZ8ZvLT+NQmv0MMw1KP0fLtTdYJjAIWhdgk3
 9X+Kaclhufmq7YdNXWsvHLpoWPlFCB9KU0x2IApVg6vLtsoIarb7eMWN302hM5QN1+H7hPVOqu1
 uwrk1OqB0hZkhA/r0lbdpJNcNyAV2iG64Xpdhtzbdc16aHCzghaMYlRFaysGVrfbQ8XYwQgOJD8
 BRXjWH1JZC6zNjivcWdLJYHVQEdZZAYoSbgryRp1lhwA3sf0yXkC+k+EHZBabVG16E6WJ02Au/A
 fuaGUD/KSXnX2lpQG3bQWFCDj1XaMra7qfuxfDydIwqmRhrHOVXQM0582l9A3oe5KD/olkAiLSj
 66pLPGsb4V0AZMBitkVRdF3ndZT+jdTZEJkRavWL6bqzkQYb5iIXhXHpn3mZMJK8Cr3Bj0dsWnt
 kMOq8yr7imiQqkmhcTQ==
X-Authority-Analysis: v=2.4 cv=O9cJeh9W c=1 sm=1 tr=0 ts=69e75d05 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=PtmkEIwhnwm9S8WJiMoA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210112
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

On Tue, Apr 21, 2026 at 01:08:20PM +0200, Luca Ceresoli wrote:
> Hi Dmitry,
> 
> On Sat Apr 18, 2026 at 1:18 AM CEST, Dmitry Baryshkov wrote:
> > On Fri, Apr 17, 2026 at 11:57:49AM +0200, Luca Ceresoli wrote:
> >> Currently all users of the bridge-connector must call
> >> drm_connector_attach_encoder() immediately after a successful
> >> drm_bridge_connector_init().
> >>
> >> This is an unnecessary burden for users. Move the call to the end of
> >> drm_bridge_connector_init() so all callers can be simplified.
> >>
> >> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >> ---
> >>  drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> >> index 39cc18f78eda..bba8327fe3f7 100644
> >> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> >> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> >> @@ -1055,6 +1055,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >>  	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
> >>  		drm_connector_attach_content_protection_property(connector, true);
> >>
> >> +	ret = drm_connector_attach_encoder(connector, encoder);
> >
> > I'd explicitly document that the connector is created and attached.
> 
> Sure!
> 
> I'd reword a bit the description, as I can't find a way to append the new
> info without making it all become awkward:
> 
>  /**
>   * drm_bridge_connector_init - Initialise a connector for a chain of bridges
>   * @drm: the DRM device
>   * @encoder: the encoder where the bridge chain starts
>   *
> - * Allocate, initialise and register a &drm_bridge_connector with the @drm
> - * device. The connector is associated with a chain of bridges that starts at
> + * Create a new &drm_bridge_connector for the @drm device. The connector is
> + * allocated, initialised, registered with the @drm device and and attached
> + * to @encoder.
> + *
> + * The connector is associated with a chain of bridges that starts at
>   * the @encoder. All bridges in the chain shall report bridge operation flags
>   * (&drm_bridge->ops) and bridge output type (&drm_bridge->type), and none of
>   * them may create a DRM connector directly.
>   *
>   * Returns a pointer to the new connector on success, or a negative error
>   * pointer otherwise.
>   */
> 
> Does it look fine?

Yes, thanks!

> 
> > With that in place:
> >
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Thanks!
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
With best wishes
Dmitry
