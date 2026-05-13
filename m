Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC22CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FEC10E329;
	Wed, 13 May 2026 13:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NeGVkM15";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NEXDHVeI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE2610E0CD
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:24:30 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAVKxg3430141
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+gB12q4lels2v+/8HXtt380T
 L8doTk8XmybcqxUT0jw=; b=NeGVkM15eeCiWkOht6pvmZ5NQPKZLYdSr948zgvF
 4Tn9hdVbol1zz10PilAJ5xCyomiq+Ju/M3DC1p60yWnFbfGarjrVSiC1gcNoTx0t
 x8YgdMADFeXBNwsMD7GjsI8Ci8c2ddqFt30Ao4j+mCHTsQwA/zC2ZclCPrTiXZNI
 4nYMk7ApOFSlFHsWSbhIDmptURmnzSFWCwMLmskgkfEApEmDPGr5RoK2HnGB+xzl
 JcIk57evZjHf+S4DVS3E+CzewPqssWk735fyK0+yRZvjvgyn/ClamYXcMfffgToM
 2O3bp2bl0kq1JYW7v4+0iUh7WM1ZUKoW1XafHJLzb386dg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmcgkg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:24:29 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-63136f3c5d6so7102376137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778678669; x=1779283469;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+gB12q4lels2v+/8HXtt380TL8doTk8XmybcqxUT0jw=;
 b=NEXDHVeIQX2i0G4PAipVbEH0wlbWSq8+/wSpWbxDrbof0VDcGktDtSpQdPupa99f2f
 wcNRkSY0k+M6p0m9zln1UArNns5c1L7SBnv9sz7ua+Pel2bATWC4XXaV8yZGBrGp84lF
 xpIuvOcIBvBFeIBGpnMbYL/QjA9PDP82rFtgCdjlvXVD5bhxkHc9hQjOrPYpsrosH2KX
 zs0ulIBLm+/6FwiN2OH/GZU6juOZb/92qX5rTFOTnUa2Z04ZcxXv+OpY306f23Q6xHG4
 RzLERMDOpUVp9YKLj5BKblaDYorq460LqpK05Ow+Zno/B2cEvWTBATF5zB/w0EvA3pwx
 9Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778678669; x=1779283469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gB12q4lels2v+/8HXtt380TL8doTk8XmybcqxUT0jw=;
 b=XXd4jAWh5HUsVH1QW/7JzE3eyAIOQ3auUY9nAAFxNrQDrKDETmd/JsiybOjeYCU2WW
 4+8NZ+xebF0800VeCw0/1kfLj7h5kpEYXFPuJ1iSULQ2XyUNiKDPt7NUfoyJ2lK2+gDa
 VZzROWkTsjQvcS9IPfR8IPFQXfN+gY+esXTqRAFAO9k4VTsFKXnlE2xoRDR3Ng50GB9S
 qLIubcTFD+MBb0jyDrhxXdqkPHkKPH4NuSm21sOQKdXyiDH39KW60xLqmGBBZOeSfTV3
 uG/M4nZG9GGzZxo7MCnrTi/ZdOGs4o6pvi5ZdCypKQvfRg1K/35F5V2vITHv7t2FQPeN
 q8mw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NUms3EYY+BG6kHnPm51gvK3kGlkjjcq3M5Xjd9zSg7QKwu5L5GhJWdvUFVhx4R9nGXHI2dS9RY6A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2+TO8vkPaT2MYkwMv5Ht2yp0XUWSUsfxCbTpdilUC3FJ4cuOL
 iooRQYXug/nMx9dnqHz2eCotfgNwPuMLBywNWA86v7nmVqlvJUZNNOv9G37vPn8iB3rdyXkuEXG
 4ILr8p51ATWHk8qsR6t0U0uGM/NM+G0v8EbkoPzviNeUH60809b0jjcb5B346N75yfbbHm/M=
X-Gm-Gg: Acq92OH0U8BaYyI+R97hLLuj3GcRccrpUMDAVP1mFUcjt+WSCRNxulTM594+zptFSMs
 40Yop4ug8XW9amE+2gmnNpt5zA2tg7UMK44NgfFXS8n2REu1/ekqmGdz7h99oDM+4dQ+C2BszDB
 ZJu4Ohx0CBgfChm91j80Q/8xm0u2HlVX6GGyKgNnqxd+KpR2Htlvk1B1aR62eUpf0QvRYn5nv8j
 IHmV5V3E/KY4J+cMHrq2Ch7VVcjk+CJ0+LkuCnMHHsvGktVzaZFB1BSd2hRf1zAKCSepaSWeEIL
 if6kjYgwxfOUKutk1bMaVIa2m6FkUcuT1ljHM9OX/fXIRoUpAmAyppja0jJq12npqMlXNvY/YDe
 FxAcKlBwz/bo3TCve8hthIO6Q3E3p1bCypZ023XE6mQkorZVkT8FDURdnQFgfEFQ3frCxlRMBSr
 IuKQobye78sCjurHnfe+MmKx3aFolpxr3UqsM=
X-Received: by 2002:a05:6102:4a93:b0:632:d8d5:291b with SMTP id
 ada2fe7eead31-637ab380a9dmr1159481137.30.1778678668995; 
 Wed, 13 May 2026 06:24:28 -0700 (PDT)
X-Received: by 2002:a05:6102:4a93:b0:632:d8d5:291b with SMTP id
 ada2fe7eead31-637ab380a9dmr1159429137.30.1778678668490; 
 Wed, 13 May 2026 06:24:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f6290cfdsm40679791fa.42.2026.05.13.06.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 06:24:26 -0700 (PDT)
Date: Wed, 13 May 2026 16:24:25 +0300
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
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 03/11] drm/msm/hdmi: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <abncnrwznp65m2lmnmzpf4ftde4mqxyfpvlqgzsoxrizet54de@z6yqjvkbenws>
References: <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-0-f61c9e498b3f@bootlin.com>
 <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-3-f61c9e498b3f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-3-f61c9e498b3f@bootlin.com>
X-Proofpoint-GUID: ns5hZgs989cjshOn0RbtJ2R7-qBmCdxj
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a047b8d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=yWMTck8D_P2mmUstWnwA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEzNyBTYWx0ZWRfX1IUlh2shjImS
 QE7lfqA9RFtl5krAK1F3flgTpUrnQ631vWF2AiXy+DdDNAPk/EF+/uHbGgj4GLcrF0WUOKfbVQT
 ZsM3gl4hvy4aX/YnRtJIAe8MJQHbZGKYwVXqMBVaRj+wNeWajvl0pfMk+z/werzPa1ZQFGC3NEk
 Q/e3dsNx28Ul+bAuP9EPLRsri6fiyTkBPtDWRPdMKPzXsMSG13R3i+qogExdoLJn2sayOVP7LSo
 m9gP+bG3L/2Gl0BO/a+JueW8oW3XnQqIf5wDSrildGDoULIjm06apmiRsH8jh8LECC4UZ4ktpWo
 OgabI/LDNxxm1nVzP4CCoYlHLIjxIu/JJ9GWZzzjYazF39I6P4JEc7NCltkaoUk9MflPk9aQf+j
 +7sUVs3CxOIOI+1DJVVqzWsMi3+HJXUYa9FuNbxW+LWJVLc9BG+XZQlnLW4aSdapmaHaRpHqo/O
 G0EgBAli0eMEe056KCA==
X-Proofpoint-ORIG-GUID: ns5hZgs989cjshOn0RbtJ2R7-qBmCdxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130137
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

On Mon, May 11, 2026 at 06:40:07PM +0200, Luca Ceresoli wrote:
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
> Changes in v6:
> - move assignment of next_bridge earlier (avoid access before assignment)
> 
> Changes in v5:
> - simplify error management code flow
> 
> Changes in v4:
> - ensure next_bridge is put on later probe failures
> 
> Changes in v3:
> - fix ERR_PTR deref when -ENODEV is returned
> 
> - move assignment of next_bridge earlier (avoid access before assignment)
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 70 +++++++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 23 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Ack to merge this through the drm-misc tree

-- 
With best wishes
Dmitry
