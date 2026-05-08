Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82558CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D438510E306;
	Fri,  8 May 2026 11:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ed/6gaIA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WIVWqVkP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A99410E306
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:40:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648Bb9gx2777672
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 11:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OZp+cY3PvWZ7AXX+8WUitd6Y
 Yr2WXghfEWf102S3Vyk=; b=Ed/6gaIAZdihHgkd595agWOjbCz7EywPKc6N6jQ0
 qMZp7fybfb7YONqb322y1Wz0aUDcy11h/vBcHFuHIcCURCs0JOe9uHaO2j0P8nfd
 FxlbFeRXW31Wti7FtVQtiqp6ooaDQVk4MkwtnkDer0GnMMk6RdjRJytLHC0LScY5
 AdN/mE9Bw5piiSNoDhsTYhiUdw41dJhUeJO7NLslP14XSO+85oKtxwGsm32bYiAh
 +5Kcm0gtguOPxTE1y7K/FcJX/3bGfmCG144AU/l8aqgxKeBnIC4TnMB9CW3Xdn7M
 qn7wP0AXOfCY+sK7QKCJ1DiDLnPKbtbiN6wIMEY/CZseoA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1285jvrp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:40:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51306c1076dso40081671cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778240442; x=1778845242;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OZp+cY3PvWZ7AXX+8WUitd6YYr2WXghfEWf102S3Vyk=;
 b=WIVWqVkPvf4f2suaqyfu+ESqXvFtsxNtrjwlmMLJntiaxZTKte5wKslYX2edHvUcvt
 V3sC1noJJNRfuh4iJfIQVOv4+lLXKs/h/l7QpaLpOoj/LJaw53KQf4nx7jwkzXqv1KFb
 ztW527j1a9T0+I09IHNTnIRfKL4x1Ko4C9KjVX1bxf7JViU0LUd0wpwxHKmy9vH1n+un
 OkQGan2em2bgMR5YzH0aCX58+c1i7yRmqWhSp3rNdv2iBQEU5xQ+aI6BCMGdMbJs5aZH
 FcaPQczp401QZfg9Uwx1vSw21erm958IJkmLFHff4hJbK1KmyOHwin9q0aKdBJo4nOWv
 FvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778240442; x=1778845242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZp+cY3PvWZ7AXX+8WUitd6YYr2WXghfEWf102S3Vyk=;
 b=r3vPB3T8Z/VNZzrhz3hnIQoyKOtNa3GonGQfkLfamlN3dVkXL8EH9wbBNDLGTUHCJY
 u2oQuJ3eaymU2tb00KXss9YaIJGFjP6Ve6bfGnncJyG2/ylgrzAUJVS/isgGKM+2jy2l
 R+5Z8AQU+o+3YKpnft5E0fLypxZ31cmrQy9vTd/kzxki6Kxqbv7fKCIN3IyU36Pn0v3l
 B13jdOLA1heys9lm1f1/flMsJV6bg48KKFBPrh4MkDlr5nvbAJodh8z5A7e9oB1G6vnm
 3kemyBSycQz5N2AyyywZPTSSh44/27p/lOyc0ZBdHJFD7MMINMfjTLceIynmi16PMexb
 LBhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/UAR9UijSRD8ULkEzUIQCuEO9QXcBP9JGlE+C1+g1I6hjg8Su+1Ux7vTZTkKgzYkf06KNXN84gUk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrDzaKe1QKpbOGRoqdmIHc7axvukkpVKR5+9crmRhKFZ8rR58S
 2qEtmRcG88ngaAXGa1On1Yj6ndiVKnFUbrrDQKIEPOSi1ZMtLjq6vRIgI6KM8w1RffKbxR1+1r0
 XaW/aHdtEE2PyGrIC6VpxymBZpzNBV3M4eKjEb35Dcg4QmV9aw8lLOISluAh5Em8hZoDXidE=
X-Gm-Gg: AeBDies7dGCrkMOlgvHM3PZqkMQgXeMwC8RBRYnD//b/pZStjEuf9eggrt5EKqj/CJL
 mklOoE70bd9eUrbo3n2hmrvccRy5+WKOo2ZedOMRUVkFBFi0211p1xP60r4GKTeIaYA0rPUcKGt
 bl9R3D7JwhXNTNKNuO+mnMP+LjpDCPvTkvy1VZ7ERmBWphZ5PKemNcTA+U2kW57KJ24iJc5pVD4
 +Db0ZlACFIABa1Ej/DZadNtawSlZ3aPfEdXUvahscUpUnKbTN8URr7t5rBEndM/3yZvedDecyzR
 ZUnqe2gr+muPHpfgTTmyasht0cD4fL+HmFoo3MIAB+okrjhi0dSScQNtUyDfnhoZaulads2hIbj
 R+D4ptjC/YtWD3MAe43r3Eiz6wOMkDWc0uz2Las8P9GVZy3rVcuPj+HQdog53+NYWK07qWfEtxO
 UOtTp6z2j0cX1impEAJNqKhyP7uzt0pn7kqOE=
X-Received: by 2002:ac8:5ccd:0:b0:509:39b5:a97f with SMTP id
 d75a77b69052e-51461f9dd73mr171209721cf.29.1778240441787; 
 Fri, 08 May 2026 04:40:41 -0700 (PDT)
X-Received: by 2002:ac8:5ccd:0:b0:509:39b5:a97f with SMTP id
 d75a77b69052e-51461f9dd73mr171209351cf.29.1778240441234; 
 Fri, 08 May 2026 04:40:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f613ed94sm3958371fa.31.2026.05.08.04.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:40:40 -0700 (PDT)
Date: Fri, 8 May 2026 14:40:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: imx93-mipi-dsi: Fix mode validation
Message-ID: <utzkrmbx3uqys7gfepoi3gasylzxid3oqrcvdte6hn63pd3a3x@huwqowsbjgv4>
References: <20260227-imx93-mipi-dsi-fix-mode-validation-v1-1-a9cd67991280@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-imx93-mipi-dsi-fix-mode-validation-v1-1-a9cd67991280@nxp.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyMSBTYWx0ZWRfX+rQAE8r8H6aC
 7EcA5kbgcx67w6cBQidY5cBv1hR58959vGkyyW4VVEThqpGPsrAVMzUKidQ3MWf9tkPdynNbPm8
 xOVZ2yH8md09Efj7SkzJpztqsFP81aA5KOv2yPSTdC0np824ApF7WsY94Gt1w2IfWVOl/Ri/p9E
 g2Plb7G5lQ0qB3Z1WlF+vOtDRzDQW5sa3sBY2qbTT39o7ebJ0JOkwNLHGNYTQh5iuQ/Me/7C7Ft
 QmvexsNiZ5UcB5iW5txt4wcxAJ2taDisrXZmB5EcER4rp2Vq0qL7ll/Fs4uPfMQKZlQyEniuLGz
 sgiwFPaexznc+EktyB704FWNVGQlbmEpgmXF07nx4dzOjPmzI273kIHJkEUnGh6SeMGFairh2Xf
 aPEd13cV9OYJEkqs36PF00GHRioFBnx1ohPVDPgZrTa/rZqN7Nxg1wWeT5DoEyBvDJJiPpWV35p
 Z4Y4HclpaF4MHZkKS7g==
X-Proofpoint-GUID: pRBdB67fDhvktBZgCK1bFiTUqZ0kWvub
X-Proofpoint-ORIG-GUID: pRBdB67fDhvktBZgCK1bFiTUqZ0kWvub
X-Authority-Analysis: v=2.4 cv=NKblPU6g c=1 sm=1 tr=0 ts=69fdcbba cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=8AirrxEcAAAA:8
 a=ghoAkTYV6uPXXgQErFYA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080121
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

On Fri, Feb 27, 2026 at 03:36:41PM +0800, Liu Ying wrote:
> Instead of checking the last bridge's operation bit masks against
> DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID to determine if allowing
> +/-0.5% pixel clock rate deviation, check any bridge after this bridge,
> because the last bridge is usually a display connector bridge without
> any operation bit mask when the clock rate deviation is allowed.

It would be nice to add an explanation, why this check is performed only
for these bridges.

> 
> Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
> Fixes: 5849eff7f067 ("drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 33 ++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 

-- 
With best wishes
Dmitry
