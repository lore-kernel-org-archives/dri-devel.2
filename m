Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C17C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 10:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227F210E08E;
	Sun, 12 Jul 2026 10:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PivHYZLu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FLaBGBiI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B808B10E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:57:04 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAcpYx2333251
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tBa6sEiBydXVWZOOLxPyxODj
 FUcBwp/AoovX00pVO0w=; b=PivHYZLu1uWprgW1eoB58HG5svn53cKX9CFOT9Ra
 DpXOIjfOFNTFYsugwlWIptjpLmaNaSTXEd3czJ/nXmH6RMJj+3yJ4yaDLOre7fwE
 wImX06xb2nsnhzHUig10cmOJhAJ4/dgaVrfIO1AG4AVFKVb3CFgQwCJk0B7plWie
 ID+72F8Zv1lnO7tR+fhprP6PVgn7NcZJXxXJqOiLCwLdYCLL44Qv6sPMIS8wrNf0
 AeUfeOZrUZfD5OOzcoCA9E+3MygWDCnUzPMk9qGU42IoTSqClF5gynN5rTGSS2hd
 P97lk5bHF2ZL/ZbiXZ5tVk6ZZZm7MXmJGTybAYjEXi4D+g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamtp7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:57:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a97644aso30887761cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783853823; x=1784458623;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tBa6sEiBydXVWZOOLxPyxODjFUcBwp/AoovX00pVO0w=;
 b=FLaBGBiIT5lj3AgLoMdFPYPpjLhycQ++sqgNe2tn6UzuZ6mUkMF/thuAXJp/caueIw
 p8fTglLWSF+8a/9Ix3vfccUit6wYIpoQJqiioSjLcIPO06ZnCUsEZZIM25M4nwJVHaxA
 aNr2xiTMvb/mjMRduKiRqj7oKzoIGj62CGMv4XGO0CTHaEgP1Km3JPaGwbuIC3a91Fis
 ZWb17g/idGKj8m0woSRfz23Guv/q+7ZolFRC4nurRluTRFhbSPYqIoWjl63axZx+8L61
 ndCIh4rsvzIlNBEUP63qGlJYsitCobJwKvG/o2awKFhj8vosv25PlIR/vCPPyLP+h2hD
 OvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783853823; x=1784458623;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tBa6sEiBydXVWZOOLxPyxODjFUcBwp/AoovX00pVO0w=;
 b=qz0AYOE1bXr4AZ1bzgRLrVFG/owqcqLYbP3GJlP52pr26V9vu0I1yzE+Qqxvw3/H34
 OLaOoWwa5UtM92X4v4IU6lW6+EdqitNmOQnPRCM1eF+gp9fzqwtJU0TPdIH2unfV5l1B
 3q3/NTa5iCPtuN2Gg6OqOxDKmQuS40oqLq0qhECFnzE/OjkVJrKQE3v8/OSwBASiNYnS
 BOG5tTQPd9R6FxXeDUok0ZRWh9SQ686Tl8oPMWuzAyce3b4KyRwtfG1sMK5at+L4YKs2
 urn24Kp+HDC8Pf+gnNG2My5BvPcH3FfXre7VylUqf2a+Qz2rBef3Zq/ASDKaV6rco4KQ
 4WdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8D7QjWjOKS9SM6vpM/1ASzXdKxAO8JEkmAstqWXmGgZXuDkQFtDHsrkpYhk01qZ8K4B4ggFBwKVo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymQZIqs0y0HEsd/atfCC35TZ5DX366QLjl3ossvIcHD/6rBEES
 NQbX09Y8eUS1sPKoeWxyVKLesht1+ElO3HP+wbn6fZAHLCcX+83J9OdxD8SNvauN4K5BJuZsybd
 Dejc8Us3nOpIdg2n3pOOXn9zcnToaZODKBF2aY15UHnnBsrIiJ6p+mtSgZj/WEbibwNZBvRE=
X-Gm-Gg: AfdE7ckjzXzpebLQGL7WZIoq/eHkonvQIVZMFUmJwhTvv70FhOZKOlXr63QgeeZYAIn
 ENhqr2A2b47sVaaOAFW7q2y/G7b5hZ5V4ErEyKf0j4iyqafs+nzquPq2hct5H6M4Fr7dxw0vBEq
 C35LYweWlgnRvu2ltSY4N/IW450ccqdjgm3DL0fL/9gBT0PBOU84fMNy69xP8WvqBnE3Ok068OQ
 lmCHEgwtafE2xh1d501LXunWK85tniwNrPOjwWP2Np2XeS/+E3101Mfsb5WgGi5T1NKP1C4mwXQ
 Y+IT2SXmZt/7K7mxh0bA7Uv1BPqZ6CLZ7ap4skw+HzX/ty0isFdsBQ90NtuyCwCBv203/WQ4Jol
 QumtjxI7+EOeiwdMBp4yDNJDyaDHccaqAKOERM8hwpirsCLeJbnvbtn35cmEXh8GnR/MkIwehiE
 fnGucLd3kYbPxLnwPIYzuFRA5j
X-Received: by 2002:a05:622a:591b:b0:51c:25da:903e with SMTP id
 d75a77b69052e-51cbf264fc7mr51677721cf.58.1783853823032; 
 Sun, 12 Jul 2026 03:57:03 -0700 (PDT)
X-Received: by 2002:a05:622a:591b:b0:51c:25da:903e with SMTP id
 d75a77b69052e-51cbf264fc7mr51677491cf.58.1783853822639; 
 Sun, 12 Jul 2026 03:57:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca9ddfbsm1969378e87.54.2026.07.12.03.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 03:57:01 -0700 (PDT)
Date: Sun, 12 Jul 2026 13:56:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
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
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/msm/dp: mark the SST connector disconnected when
 MST is enabled
Message-ID: <sijdmdhcbxyg23gh6c62hspruvbnyqbdrtv2er3bh6n6ftolsp@b6o4khv6dofc>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-5-646a10256233@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-msttypec-v1-5-646a10256233@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDExNCBTYWx0ZWRfX/Ad9g3w/npge
 FXGIqfl4diXjDxVA4hO/WzRh8zxYYjAjAA3ex7dgAKVkARtn4v1fgYYTQwlm2KTcGGTgI8QrWu4
 W9ZADfmtSNKHLh29ftIsJEMSJfej5Pw=
X-Proofpoint-GUID: aYchWubn-oj98rQ2B5g0TcD-fsJ_ZViU
X-Proofpoint-ORIG-GUID: aYchWubn-oj98rQ2B5g0TcD-fsJ_ZViU
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a5372ff cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=EGGHxoTsPsDd0Tq__ngA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDExNCBTYWx0ZWRfXynPZbo0CpqYV
 rAPuC5TQzmgnd7YyXPKgUn4Je6XKpcl9VLke/vObLHg87e1ooyg3IpbRy2VbNpC6hGQ4WH1ze3p
 78WAVoegjVqRUI9l77mgYhMrVlfYb8sX1YvLRri38c39ObmnDB+M/VnjT/v2JEMFeFlxhfIfT5U
 fcVKzr25H2VyAQDlwMIPVL13oGxxBFCWPsk6m/4YwWCorIDCru8eFqCCpSN0DWsdKV9S329E7wz
 lTEr8jAcalXkyIqrjzcxfSR0IsTsa9YN+c/3fixaE+kD2/Emdxs7FNx/MBkmA5Rjr2d1UtE0TX7
 zz9uhkdzG50pz4DXNCJvniBMNW6mHwDh3dtFdoGC3ph3aYh1z2svDE0iHtEkBGPIHESYaS0Bvds
 R5u+/AKa+8sUE6nfN8BlvurEa8adtrkq9zUVvcYSiPPnn8l4uSYVk1SHA97eFDGw+m16suwj2ku
 Z0LGiBAOvVEwtOOnrLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120114
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

On Mon, Jun 29, 2026 at 10:48:07PM +0800, Yongxing Mou wrote:
> When MST becomes active, the initial HPD plug notification updates the
> SST connector state to connected.
> 
> However, the subsequent SST connector detect path reports disconnected
> while MST is enabled. This connected -> disconnected transition is then
> observed by the polling logic and may result in an unnecessary hotplug
> event.
> 
> Set the SST connector state to disconnected immediately after MST is
> initialized so that the detect path does not introduce a transient
> state change.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 4ee391cc7165..f8ca60d6d714 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -352,8 +352,10 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
>  		msm_dp_display_mst_init(dp);
>  
> -	if (dp->msm_dp_display.mst_active)
> +	if (dp->msm_dp_display.mst_active) {
> +		connector->status = connector_status_disconnected;
>  		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);

This should be a part of the MST series.

> +	}
>  
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
>  
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
