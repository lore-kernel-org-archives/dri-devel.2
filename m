Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BAEC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DFF10E1AD;
	Tue, 29 Sep 2026 16:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fah6eOVG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCGRqol0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4B510E1AD
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:05:15 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqckh3936708
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+11nj4pCyBkvkRwYq3yMNaOm
 dTpCQu0BySHcZO9yZcI=; b=Fah6eOVGotweigw9NjDr8Gz12aIenYAuxGzEm9JF
 xOYAXosQHU+xW+snygKr5MRMy28GeKd4BkBz0+vS0lmClIVEGvIKg8uFPlG3CLvr
 FPXMparGnbgIKSaw47Ry5NyQBzsvzK0hbH9QmdSyff5oJCnSjMA17iXl6mPZu3/f
 yjAdCX1/z8HJO2Ml+hsh5zstaEGLrpTFhftoE7SGvUVmRuB6AC4uoPuuwE7cD1NO
 bkZ/PJTAdX143lYiShkD0gH7QRfwmULxB1GB8XAina1MLyGnO/pSO8pn85/QqBJC
 faQKsPPzAt1Gh5fiAt/rFe0Y+jMK3lWFmLl8HYEwgsgFKQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1hf3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:05:14 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7b4f8ea38f7so2548172137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790697913; x=1791302713;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+11nj4pCyBkvkRwYq3yMNaOmdTpCQu0BySHcZO9yZcI=;
 b=ZCGRqol0dMUSz5CiKikkDVH/8OgYIJ3rPXxv5hHXY3ltTsyRe5wD3H7d4mq9fCk13V
 VpDsrdybOplJPR37l2PYvovF8C03/xIWGvU6hPCb10aRIFmCh4p/vUVbKxtuq5WXcDvw
 OteKpfWuiEuUzotKPTiznPwJEZTWTGDEWO166IPjj5DiaTsaR4NHH/A+quq+fEsl/LKF
 wn+SGPeyd7qzl8AcBzf1Trw2FM8wCGSl5MBNPbbl2M5+IdNALOWMlFO4Oty1fY5aRpAh
 fNb2hvASPilg1MEPGsJa/rZeoq4DQ2QcHQxSMka8XmTb8rs68df2ibPablBPxdpeF5UU
 0yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697913; x=1791302713;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+11nj4pCyBkvkRwYq3yMNaOmdTpCQu0BySHcZO9yZcI=;
 b=HPVFliuFm5aLcOIaBo+4uWG0YpcyLfgTEXXlVCfSm3qCC/gCxILpFPjjhndTnDK/uz
 lnAq87nOvysOBTAQWxbkpMIyUK+QHkk4Zb9DZ5ctCkmd6UIzHFS3f8zpT74tgGFH/tFk
 MSVEq/c9Kf30yfQzQtp71tbm5mX0qYKKvZMmVByixhDhavDm4z2cA8PmxeEehZEbYcOc
 PwsInjvyj9azob6yWHebmOvIkw/mKwpQjaPly/Kng6rkoAayjbPKYCoShYfXe3jKQ0v4
 2E0gRKPVXirhbyc9Cv03glYdQ4jf5hPwBFZKCVBLijxak3GJKRtI1t8KIxd4rsKzzrma
 LECA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWKOcPdcnuVu8GuoA1hJwPCyxKUX4m9ibGxErV4vcUpCrEIrnBKFLckuR+5vYd5qlgrpoUQ87f+dg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKM3djzQ73+XCZkGRajcloyFrcTVJeNqc9oi0tgtxH+tKyZFkXO
 3E8RwkNy7aP9X5t2InxNozjl1QRjdBjJuzMRJ9MBPZf0O31OkZYsYrHSsPLecNjaw4QxNrdPakt
 RsNQXMRi8vLPOCEojPVpwOPvVc9keWveLyeT65W2RA43ots2DtbOVD+Owl66hgvbGrlBRoaA=
X-Gm-Gg: AYBFou1jldo++jb8fpmyN2S2sXBXsKp6AHUxfyolJcDDYYMPmfi7KO6qycuzd29KeRp
 1TEhcYY3avLGjSy95GJqDzm8nIkABjYO37xUtaMLlbmWI5hNX12c6oqUjR82HWE1gzlOaSnr6nw
 JKGXTCfB/UFtlAlMSCUIGfTlAU9l2FQdlH9mQQG3vcHXCcFRAPK0I/BHid3OQ33G5wASU96slSW
 wx9+0M1sUyUsddGBjTKZsdGRMYoGttlzxrU0DUJ+yDEnnZfKNlOPrgTp+bBIN/8fG1gCFVqy0Gr
 D7mZPj52gPVVyU5adkGTFoBk2UN78pRRtooPjDplQqnfRqcljRN6KUNSW2611ulX+5LRhMZ3WIQ
 iSIvUG4OaZWlSKfmc7bhrRbzQye4NE5E10MZ+CMJ5E8sezckW97/XFbbdO8+5/rCdVQqw2rXF9e
 rhzF+gZkOd//Pm
X-Received: by 2002:a05:6102:f97:b0:7b5:8fd9:27e2 with SMTP id
 ada2fe7eead31-7b58fd945d2mr2639561137.12.1790697913140; 
 Tue, 29 Sep 2026 09:05:13 -0700 (PDT)
X-Received: by 2002:a05:6102:f97:b0:7b5:8fd9:27e2 with SMTP id
 ada2fe7eead31-7b58fd945d2mr2639538137.12.1790697912513; 
 Tue, 29 Sep 2026 09:05:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3b470ab2sm22486e87.33.2026.09.29.09.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:05:10 -0700 (PDT)
Date: Tue, 29 Sep 2026 19:05:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] drm/mipi-dsi: Add flag to support dual-panel
 configurations
Message-ID: <gu22hz3dnttzyu2eewpalgzxtocmlbfvnpwore36ufmyr3xtag@r5bbhafsn562>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-3-c042266b9eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-sm8650-7-1-bonded-dsi-v5-3-c042266b9eeb@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NCBTYWx0ZWRfX11bkzfV+cI4P
 pj6yTX1Sos+xW+urkDxAYgiX3heGf1bEbeDaqXDcqENB1O7eYPYsjZI/wM0AbDZ02XYOl0xHQ7x
 A5/o74f6db9ak6xaGblYsy4PKYbEbcw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NCBTYWx0ZWRfX6+yZntCVcsb5
 9lO2TnAob5Uf5gYCNQ4MBkrHSjVFTDuj59ko4MSpRIW+DQXsoejHqJDe7M5PqZL4gUVCLk6av46
 pljbEVtnusHiMRivqeMPSmNv9CM5ucOHlgW1P3MGvljzgv4ZaxL3kqxvienDpx7Ux82E+Dhyetp
 e17AZN/B+J0nbTMBhqzirjCBrCX17THUTzvHCcczKrLwWT0E+z29sM/gLTF3LDC4XaIdnE6j5GJ
 dhkOnaHkZuV1Qwfx1WyPKX+CSc5z23EojBDx3rh36BUOJcZpwKITIdca6RmByPw5BT4O+I7rVA+
 N7uEJQed4IQLc5cg/wAps+9z+3BryiMfA9iVI15agzOT6Vtzt+TqBDxlANjvwxs6NwcqkpqlVkS
 Myk1o22ebArK/7cIaiTj5ZlRAse4xp8vsbZi6dzyrxmZDC3UvBdnBMrMxaX3XQv0E+Aaa8m6d2O
 qxKirZ3UK+mzAPuEm9w==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abbe1ba cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=JmB1tVOSonE3mgEak7wA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: c_rkZn8f0xlsvllXe0g7wQ4MDP0a4l25
X-Proofpoint-GUID: c_rkZn8f0xlsvllXe0g7wQ4MDP0a4l25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290064
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

On Mon, Jul 27, 2026 at 04:08:42PM +0800, Jun Nie wrote:
> Some devices treat two independent physical DSI panels as a single
> logical panel from the CRTC's perspective. However, two separate DSI
> hosts are still required to drive the panels individually.
> 
> Introduce a `dual_panel` flag to the `mipi_dsi_device` struct. This
> allows a panel driver to inform the DSI host that it is part of a
> dual-panel setup, enabling the host to coordinate both physical
> displays as one.
> 
> This change does not force individual panel driver to manage
> system-level display topology if the driver does not intended to
> support dual panel topology. Only the driver that set the flag to
> true need to take care of panel topology.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  include/drm/drm_mipi_dsi.h | 2 ++
>  1 file changed, 2 insertions(+)

Do you have a single MIPI DSI device, or are there two independent MIPI
DSI devices? In the latter case, the flag is wrongly placed.

> 
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 2ab651a36115d..889ef1421207a 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -169,6 +169,7 @@ struct mipi_dsi_device_info {
>   * @host: DSI host for this peripheral
>   * @dev: driver model device node for this peripheral
>   * @attached: the DSI device has been successfully attached
> + * @dual_panel: the DSI device is one instance of dual panel
>   * @name: DSI peripheral chip type
>   * @channel: virtual channel assigned to the peripheral
>   * @format: pixel format for video mode
> @@ -186,6 +187,7 @@ struct mipi_dsi_device {
>  	struct mipi_dsi_host *host;
>  	struct device dev;
>  	bool attached;
> +	bool dual_panel;
>  
>  	char name[DSI_DEV_NAME_SIZE];
>  	unsigned int channel;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
