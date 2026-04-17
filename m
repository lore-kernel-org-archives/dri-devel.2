Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5E0F99C69
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E6010EAD9;
	Fri, 17 Apr 2026 23:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UM8KSPLu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cptfwq7e";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D8410EAD9
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:18:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4GrY4068652
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iiXkzNHCXZt+kBpSD8YbBydO
 WH6d9cvkLCL/J8Vlz6Q=; b=UM8KSPLuBaop6ioXScO6XhIpoK7pCcchZC1RhHSH
 dODgkf6FxQ1L8MPimhOWjvsrx7Zm4kSG4kSp4yCELMbpZFGUxMexrf7Qaj+iFFzM
 PHhUQfnOBas6r8UmN6d7WP3YrYtINArFmumhrTDS2A2WqjSciFnwbXBpcPQAh02B
 8cXaZZq94ui2OAEWW+CMFeeyjL9FiF2mPvONyDlIPNYZQ1O1XNtKtDFMx6sXBIAW
 nJulzHwKr5C/oDUtQ2+S8HdC/QwRBtd/OdjLIWroCfeqO9Y7dc78EYlECHF8s8fs
 AKKQ4u1uMio1kt2qguQiq9vUDVCqOKyQI556hbjJgxOvSg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhpu2ks0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:18:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8ed08aa4so46962901cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776467924; x=1777072724;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iiXkzNHCXZt+kBpSD8YbBydOWH6d9cvkLCL/J8Vlz6Q=;
 b=cptfwq7eoS3rc9mVJ3BAMEAV5mOFFz8BjYN6kN5z+LiMjWlduR+t10l8HUjaFxHiXS
 /LxpWShHxxGoVJeInc+2SHWJ9q+IjFYTgj2yDTKQ3xyxVrM6z+u9+E99TnNsMFvsai5K
 mm02PDZonvjzZDnJOR1Q29EjemPMo6eQ0I2hSCRAWyqY0QuFvP1KWvwQRD3LdYS9JkPy
 NEUKfT/N0m0++XxqwiYE4qDh8NFzoIP45qu3oGbxONLnUYLDnPWwEWRFEctDM8W1j0vP
 gsbjUPFNC3mHX4acRi8/SSgu/Jc9Gx2XzBVrchO51s1JVRtbUwT1SlFNTMyMCevxTbcR
 STEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776467924; x=1777072724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iiXkzNHCXZt+kBpSD8YbBydOWH6d9cvkLCL/J8Vlz6Q=;
 b=HDZy/jG1DM99RZpyKe9RTMbemlXoNgMWJcbGtfNoPVrM+eM/nCkNWfnFikXQpRwKQv
 av17i2r1kTXw5s8olEktfvlcMGRLe9LgIrm9LhkzdCijTYY0j2XqR+QdfZC24IVk/fPd
 i8fuC3mvjSYInOhJQEFrZyTurltFKi8geTreJLrMWvBWhA0RC1aNXWDKzjiRvSKVLu1I
 0bKh2LdbSW/K8GjXFFSbUdOPq5byFpwIPTQRcilQKyrJ6eNfN90h+8rSyJj9q52TcwgE
 sOFpoSjtOkKNJWz6HwKBEXVDFyQaUs3RJ0eG6/wh3+YkOjdWBbdhfpOScRGK8GEtWntP
 uwwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TS6h9gOHKA60NN0+aoZ5t84qQelduzFGMCccjXRkwIJx6Gv/qLOlqgkVbZXjuPefIUkgjaxnFNWA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywulxha/9Yw+nC8IUzZ7ev597ly22nTBRORZZbIjSlW0mCEbdW+
 w8ylJzgyMtJdh3lnir99pWDN5DB7dn+gxH00orz4mgJ7WtGmrkTuQ4i9o1oPH5+qWVdrentHOV0
 9HjWkWCizU0tCnDgXW1aQIItelptOUppcWFOoPcDjsg9ESHezQpa2qROvFnd+6caq4j6TAaw=
X-Gm-Gg: AeBDietywGiP1zPu63FzSFphGBR/ADufqY0EXD7T95jYfJ43FN6lMLfLNY6MCGj92qK
 libR0BpPgVmVwicytKspIGquHX0pKTUUQPbZsxKnGORo9vGSu8wXjZrnX4ejZ0xATKeydCR/Bkt
 ABseA/BV4uvYWJuGvG2A0hCZV9ru6d77sOs+mSW3twg5xacD9k6+XvmdDPOgnIGAEW2eQXUrKBm
 wJkB09g18ytCDNfTQGFU3fGGLkNPNWQjUaBOpRlqwBo1p5sekQ9XZMcMayg/NuWsbFqRQAZhKYS
 m0aVRYGX6In9MG9DnGO2ggaQKLe0hLiKXXMY2vJjauRJYRgy5hJLpo5kyNe3W+BMnehEFkrO3g+
 gU0KouaSqa0zfkXWKkO5LikLSHFj0XD8+vfbPhF9o4C9x+IPdPobH8qFZ+VG+2zbzdgLAnSwyvd
 3IJZ+YsJalP0NOxqVlEA3zPUd0Ev4ZEeVIrF0qWjM8Wk05Eg==
X-Received: by 2002:ac8:574a:0:b0:50d:be0b:8210 with SMTP id
 d75a77b69052e-50e36c75b72mr74178521cf.53.1776467923955; 
 Fri, 17 Apr 2026 16:18:43 -0700 (PDT)
X-Received: by 2002:ac8:574a:0:b0:50d:be0b:8210 with SMTP id
 d75a77b69052e-50e36c75b72mr74178181cf.53.1776467923563; 
 Fri, 17 Apr 2026 16:18:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ebf9bsm799707e87.81.2026.04.17.16.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:18:42 -0700 (PDT)
Date: Sat, 18 Apr 2026 02:18:40 +0300
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
Message-ID: <aaxyye3vsef56qxqmblv25mlwpjz5dqovblrgwaclq77tqjvps@kr3aec254a5y>
References: <20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com>
 <20260417-drm-bridge-connector-attach_encoder-v1-1-67b8b8fb872a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-drm-bridge-connector-attach_encoder-v1-1-67b8b8fb872a@bootlin.com>
X-Authority-Analysis: v=2.4 cv=Kd7idwYD c=1 sm=1 tr=0 ts=69e2bfd4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=vaQ7vsQRKn0RNfOcGCYA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 7nPLQaVZDfYASH2O89HCJmPocc-Tp_wS
X-Proofpoint-ORIG-GUID: 7nPLQaVZDfYASH2O89HCJmPocc-Tp_wS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMCBTYWx0ZWRfX3vYyjKpFN1r3
 pMClPj2TxKOf/IKpKetcVBGvTQdoY4Qy9VhSvanj9TFn4RZxFKo60llVkeBoEku9kXGacJBg/qk
 nwphuFcJX0YRKfuVJAcHCR899RbUhAUT/3XNJRTMpM39/WlUG9KDnoHlBylIWj1GylUSvljPbXI
 Bb05g/qEhEPB6tZEscoNDlCnVLsF5D2Y3SWl/niJ3+24/pFxjdtqEJb2P4OBWI4veVEFxhqZHmZ
 WmSssthP8w/gsSiUPNutzq5+DerJOlveL/0vC1+3uxUtX0QIpAil8vSkzcOj5JwAETeRr1+qD37
 aRuwBxEfRkrlDfiERiJHb3IW0MrWyRwgnHmRGna5ccpu1g5Lkoc4J7YjGZCKTbRtwsEq857JV2J
 bf4G2+fIR7agWElFH+RD56YVUfjzBUFVzUaflSJD//3JbGouKa0ieDsEwTlQcOPQb/iyXa9qP9D
 Fn5wKWIOY96Q6vWR8lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170230
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

On Fri, Apr 17, 2026 at 11:57:49AM +0200, Luca Ceresoli wrote:
> Currently all users of the bridge-connector must call
> drm_connector_attach_encoder() immediately after a successful
> drm_bridge_connector_init().
> 
> This is an unnecessary burden for users. Move the call to the end of
> drm_bridge_connector_init() so all callers can be simplified.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 39cc18f78eda..bba8327fe3f7 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -1055,6 +1055,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
>  		drm_connector_attach_content_protection_property(connector, true);
>  
> +	ret = drm_connector_attach_encoder(connector, encoder);

I'd explicitly document that the connector is created and attached.

With that in place:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	return connector;
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
