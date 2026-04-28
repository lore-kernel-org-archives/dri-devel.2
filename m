Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88270FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 20:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B925410E382;
	Tue, 28 Apr 2026 20:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mGHrAYuv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VvQcVIQv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AB210E382
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:32:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SIuLIJ3347448
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=p9ZHZ+Txy5mi1xMSfTEMkpbb
 O+fn+/HINQfWSf0RFmg=; b=mGHrAYuvqYqk+iIbadUEARFBN4q2qHFLJ0TCZ+en
 thTyU8iFTiMT3i3M/lDdrX7EaT+790HtDfBzB8R3Aitm1fTXx4hBGsBpP5AZMgUg
 e2JINAR+i51/xX5+aNua6OVhAIomFFDxo6l2JblcMGSz+DKhfD8CR1oNoOBNWR5c
 3CoVlfvRq+bEDF7h990WwRTConFWdEqJr0l/FdRXFY+1aecxmsNzr8RJIT915Oj7
 WI0Dku2hJAPwwKOKti8fGjRwQT9e5oUIvvAwRZUft1V9r9dK3KP/x7Ollm1qXB4r
 QHog+JwPD6EjJWsAolHkK9o7caT/0XGDquQ4NhR7TRHSbQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4r9nd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:32:36 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5738ad13968so5929207e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777408356; x=1778013156;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p9ZHZ+Txy5mi1xMSfTEMkpbbO+fn+/HINQfWSf0RFmg=;
 b=VvQcVIQvuwAtY1koYcggjnGPN/+nLF44BIispKzqRB5hOZQBTLOYhYYfANNBZbHn0J
 HB4Kixfe8bWFCn6/QTpbqs5TRCD+uKrcuRiUWUKTyrFHsZ12khDwFS2HpLay9sf0KZuA
 nyEI52fkSus2oTbIhhLll6KOxP+B+sUcppmEpYPh6oEoosQ/YCM4qF19gd0D0Lq7Bsvc
 9ZLqb1Sd4G3j1SHdeWCWpjLt+wXWvDn8ptxud5oenEDyW2toY9W1x3iqarfebqp54HP3
 RP6Y1HrPfLdKERPsQgpkJdMOUAMRZRFwsAagetsRjV391wIIZHIk3NZlguspPirvHWXf
 7J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777408356; x=1778013156;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9ZHZ+Txy5mi1xMSfTEMkpbbO+fn+/HINQfWSf0RFmg=;
 b=a8QoidUfAZ1mb/Bwn57alWAC8WXHYRTI749nP2qj3TCV0ZTFvyET5nR7vniUnx5ThO
 DIsIKp5HbV4MkLxahsxfPDb4TDE0ARoIZHUdHyff6JpPWXeel1A4jc1JuBUJhk4VxBeC
 DSHcE3iYy96P9lb/Y/PncjQ+vSceMkElk5qeRnJSVXlZKyjJh1lAZJOo6fDnQDB0YqaL
 5GPfnkK7d0X0U5m9Sl53ncde0QV+VUNtcvRhhDxAk1xLah0TYNvGfHZOi/gRT/4Kuth0
 DeO2/b+NolqtrwTY7DA/v9L3rMkgutX2LGf9/AvR4AxSfz37XpYx5lCW8WrABMyLV9rN
 NM3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fLPGolI673sac7IdL9BbvSVbfmKLkJbMutMO/2VPxzZGTBr/x9YyPfrT/MlwN5evdAkla3h2TkK0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybvNi1ccFItsDmhDZERN9RGpmsIkb/5HrWEegTzSCAfhHtA1iE
 pDeBVp7dVA/HOQYv5hVTpgBKoRRqLUj3rx2r1uJN1WYa3NamTRDT3kDSTSjMyjLFzMvcv6inllC
 Cb/FOB+AEOFD69ncWHDX1vOlwZTQs8yCxHJs0lNxtuWQcrSFgfkGK+1I2AnzzujRMMnFYt7M=
X-Gm-Gg: AeBDiesFFOKukekIAJiNReiAYh6MbVpcD25OHAdiLjZQ0IBJutiK9DciFww4r6K5Z0s
 XnQySiWRurTrVPsfb5dUFZ81JwNWne3EGerYH+ZTh/yhvL2e5ZNrY/CPwJm3+41LpeWc0BZDDj3
 H0AsPcPPSDS9wmNd1AwYEGzkcaCumsxW3qx96IDxWYSWwslpaKPVmSWF2wT7YfnNBT7AigtJGI2
 dV70XKOhIWZ+zgPZlbQZl5T9/w6lBd6+PuL2U8PvLck5q8ccBbA4KT1N/OfQ7lwK63YZz5TS63O
 AK5u4+gm0FFwSc1bkuE3HvA4AiViPZLPfOhy2GdDw8DkV017Ex4cyHQwQJODcoC4bCwfB5ucqme
 n91QOgB8XEeSJindKA02100Ntmn3FqwxLH45nQVSb1fqcuXRUJiP9JvWgLKIwEGD4yVydxQSQa8
 j+JmLEe7Qi1GObcOHA6I4bBEk/LqmeKps0k7nQCmkpU37xqw==
X-Received: by 2002:a05:6122:46a9:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-573a56b3c5fmr2957428e0c.12.1777408355980; 
 Tue, 28 Apr 2026 13:32:35 -0700 (PDT)
X-Received: by 2002:a05:6122:46a9:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-573a56b3c5fmr2957401e0c.12.1777408355449; 
 Tue, 28 Apr 2026 13:32:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3924d12f94csm1201771fa.15.2026.04.28.13.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 13:32:34 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:32:32 +0300
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
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/11] drm/msm/hdmi: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <qpt5vwoyin7ox67ysllnaojduwl777e3zzm2rvw54eogeewoke@gysroqruf4v7>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-0-a537b5567add@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-3-a537b5567add@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-3-a537b5567add@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE5OSBTYWx0ZWRfX87LENYxe/iIo
 VGbHAQEq1zHFzXm2yxxFYGTIVrCRYCvhFD0WxzvLULGB5AZ/bTgLfoL6MjCG+IAboQ3sNGWkpqS
 1pRI3uyYfDnvz3TO8DupXnwkKC3fCY9Dt2bJhH+h6JN6eAGzLVj6zSHR49DdK5aUc+mP2SfeNyT
 qGofVZZgh2/1jCS88kUMeIe58on0J27+ngrG403/EZhePD4E+w/Fy3gc/VWSU0UqG/AAZnc13f+
 GSxhI94n01vyfhV8m9wQCPFWkzJXLlwbdSPBIwVEm0Y2/VfYkn7qjccrzvDN6vvcldkJmsvzbDu
 4f3RwN2PIVrCvzLyn/zsnBEWl25JPDXb5IhbRNV8u1YoiL28eRW/xtmpm2ZJWjA56Vej2aTDIXN
 2hXsuwVr8Z2rJc2MJEvdK3W6zF/GoX0jCyAkYpfLncQqVz/+7mtjhHnaCH3borf7W1ajrhURBxh
 DGxRDBsp/5uN9USvFXQ==
X-Proofpoint-GUID: JxpicHGdOJjUhCPyqzKoEKufkHNhlIAT
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f11964 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=hXVsb92WUBna0ZnZifYA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: JxpicHGdOJjUhCPyqzKoEKufkHNhlIAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280199
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

On Tue, Apr 28, 2026 at 05:30:52PM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
