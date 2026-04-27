Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B60EFF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E17C10E962;
	Mon, 27 Apr 2026 21:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+CIdJUB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cGz+e6vp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AFEB10E962
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:54:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RDtfdP241204
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SX13csyuB/QEm6z97KDEVCbw
 9bOnr8oHQXxFaeduZ78=; b=H+CIdJUBMILCMgyJ144jJwXAlvJV5yyaVBS5bJjy
 GLd96Tpw25a1OY3u/a9vsnIY4fbi8YxinUX3lFNLIIW4R78bA4hrgGi/5Q23OwKq
 Ti8TKZOnc30BwNixB5AYfNJJQHGCgddB9MNAExtOqk3276v5ESpiJ4LVz4ZRWaqj
 CGJoAU5S785kRqJXd3qu8RFpADqji41R4+pkQz1hhrY4hBXbX2jX8LyzTV8jXa6u
 61HItosx+npqHvAyu4KogzTV5dkH8TikuDmNE8869YT+95phmdzB1K3cVdVJ6uas
 82+9QSqxHtzNjsUH9jKxdnMzv0iCG660R6DR237VFdVKUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946sqt6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:54:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50df4c130dbso184131731cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777326856; x=1777931656;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SX13csyuB/QEm6z97KDEVCbw9bOnr8oHQXxFaeduZ78=;
 b=cGz+e6vpLnbijD3fuZ2zfTYkPzq4at96xEh66WJZUbbQ0+h7wpMcs+QJ31vocK8zFs
 G8s4Klba4uWcBunvKfh5nPKTv/18SJZCx7gfdfbWxiFk3V1Hlj/dLTBkEbXV6lfDmWLJ
 amNcdTRhx9drqrPdm/1+o93B8WZzBPTuUCc8OTgXoNKtDI2FVJHVFNXAQd504ZELxx1I
 9wD91ekCLaCLTXKH0Codu5S9pgJELbpbVrDx5P5nPKPXsyj7aZF00FYEwV0pIsORrHl8
 7MVMo7XLBFmn7uOU0wGLDoiktEo4UgzR8dpgUhT1w/Sq/DAHaGfpO2pR6OkBq7dfB3ts
 p57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777326856; x=1777931656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SX13csyuB/QEm6z97KDEVCbw9bOnr8oHQXxFaeduZ78=;
 b=CMcUemuFEYxUdsTl+rgmgsW1W5UmX0v9rfha4gRlZ7HrAOISamolaVP1//GG5RoNZV
 E1XXuvJcSkxtLrRY7ctKcYhHJmV4/tkR1E2ueGwwLCC4aTpQH7dBESyPXyJDMRdzlPvK
 dwLC9L4+DzUEYja9FVkh6tHvKNfaanbaX5UF8EGTKSnzr1uebm7xMJp0VOBaSPt597Qk
 82B0wZ7R6GmxNloJBeJ9OFP3mwx1GpzP7ghGiOEpqXNaXHMl17ZpOyq9Xfpxp66JUyM/
 JWP9IchXPYqhm3Ze7Dx4sp5Kk33pcTRgzqZFcbZkJGmGSYcNO6ceXUVXKP4uzayH1fMW
 aQ6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ84VDB/eYM972oHMql+Yk1JCsSP/KWokQOnqu+i9BPJeN/M6zmgnrk0ChJLnCRivSnCvDSPNPVw/aw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQcO5JRrW1CL3fxgJcJAcz9AB9BL732XLuzyOKMb8EVryO7fSV
 1pnxW8T530br7yjHvJBvGlEli1/D179QueDjZKrCnUAus2Mmv9GCcWq1XzkqmauORGv4xUdGkPA
 dsxwY6ZwqSh1tE0bbw5dP3b2lFo7IJ8GFdr7kY6UBmYJE/c2FQZLlcQ0haFrryHEuAgZzoPU=
X-Gm-Gg: AeBDiesYQDlkabcEmzudTrkPyXmpLIlSdbzjEwuvhpyyCQoT1UrlZkxg80CQYYjfilB
 c8RgATQEVdxEMm7ofMUtx3WSIl/LEtXt34LxpKOSXla2De3q9APy/HMOzeWzgRn/Dftwi48ByG4
 ipboc6vA7Ri2lyi/QSR+MVm0c6h8UH0/cHil47wSX49ZvslVDh3m0jc2Ctng1RsoKSfclzWyTkG
 vJOFGobUWgiSsDBOOrUjA0jsKe5dOSJrESfu+YFabQbDLnIyzecFemUaMs02OFI+W7G5W0/WnpG
 G5DdO+LgJPsaOaA++CXTVSyVslPypZq7bNCC3wCeyjDZqPcdt4kad0AteqdKb+I2qjz7kkW66gu
 GZ+45qruwIpzDwgmzed7StMHaHS5joee/umY+Mf2xDEuegisn62Mgrdv7DyOmdF3ww78OFklDEj
 SdXDHZi48cUhtg0oDqnkaP+Kq8yLfAM9UgTpZ/ZzcL0hhfAA==
X-Received: by 2002:ac8:5f12:0:b0:50f:b427:7525 with SMTP id
 d75a77b69052e-5100da98d86mr8185801cf.42.1777326856483; 
 Mon, 27 Apr 2026 14:54:16 -0700 (PDT)
X-Received: by 2002:ac8:5f12:0:b0:50f:b427:7525 with SMTP id
 d75a77b69052e-5100da98d86mr8185521cf.42.1777326856041; 
 Mon, 27 Apr 2026 14:54:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7462d588asm105499e87.34.2026.04.27.14.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 14:54:14 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:54:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v5 04/10] drm/bridge-connector: Switch to .detect_ctx()
 for connector detection
Message-ID: <znjgxzoyavxctvmec4j376a5cjg4s2oqhn3s3ubkbkuiluguao@pve7siqulhxp>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-4-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-4-d778e70c317b@collabora.com>
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69efdb09 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=MTERcTr8AAAA:8
 a=69EAbJreAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=5Ozh1E2pZYoiRNblH9EA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=1w2Y23rLpnaGpkO2nlKf:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: qUl6vIV1oy1f9jn-DmtSUn1CLJdjcwjc
X-Proofpoint-ORIG-GUID: qUl6vIV1oy1f9jn-DmtSUn1CLJdjcwjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIzMSBTYWx0ZWRfX0vMQDcA77PPT
 hXBJBP5avox1H6PoOc+SG2oy3CKNLmiGhsAa6+Mzv7MBwkZ7vLMlQIc9YfBbJdciTvOjxBvbXXG
 fWIwrWICLFL3BuIGWq9Aws47wIJr5rpgD8o66CHEXlfI12951UmqHL7uie+yTTCbTLUKW0cPGG6
 xq7JczyE68DIwrUoJoVY0aCwpCR+/D+4WVsIt5xPuIeYh3jELiFA/d/oxe1ilLnhic+MUGCTW74
 4DpCGUKrjxQL0DfpwCLa+NgaUcw6zz1VhRaVv0sdYiwyPP+MJnH3usq6b/KS9pxSb/7pMPrJdZT
 jiR8lvpxWpI1SV1J61VbsMM96kv09wGNi1NwQo/gN/4tTICaP4HR2rTDDdlCSKZOzia0C5H1uZj
 S6P1YKlzafCl8dxgT192vsSVh3D7ltg5z6NuHoYBtlJ4z8w8CRCE+STuSdoV6MNXWoQqOTuBWsw
 Qy8Losvc8c6NEyHfxyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270231
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

On Sun, Apr 26, 2026 at 03:20:16AM +0300, Cristian Ciocaltea wrote:
> Use the atomic .detect_ctx() connector helper hook and invoke
> drm_bridge_detect_ctx() to propagate the modeset acquire context to
> bridge drivers.
> 
> This enables bridge drivers to perform modeset operations during
> detection, which is needed for managing SCDC state lost on sink
> disconnects in HDMI 2.0 scenarios.
> 
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 71 ++++++++++++++------------
>  1 file changed, 37 insertions(+), 34 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
