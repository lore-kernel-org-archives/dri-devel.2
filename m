Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE48DC4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25A910EC72;
	Wed, 22 Jul 2026 06:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItkIlSkM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RAm5oKGv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5EE10EC72
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:53:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53ktE3767770
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DfBI63uQ2/HBYGxVHjRe87BT
 GBCvc/oFJXrDryfPiSo=; b=ItkIlSkM/YDanAdF/JRIbRP99ovJ0jVPKE8SXAMC
 YonLF+vx746kfgCnmsKfgdVqhU5W6KcAkZXh52py4Imv3jkhLhfNP5FlhIGMm4ur
 0lSjHnPkk9yEauDXm1krN18+XPUVFMyg50lcsAZSpb0e4VfbOYgALbToSFHoZzN0
 k6tDZ/LgBiPVTm4V/UuJrIE4es9z2RKoYM80TtaQqjbtS3tberV0KeLv+SHOogkH
 d8C2bLVkj5c+vOZhStMO8o6AYzxzYkVW0z6WTV6RQl/PCRfSj+Bolnmsm/jeXvD/
 ZIC+ekjmpFi7hLLYx+rpm6c23PfNW8B73Zyj7LpVNiUh+w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rqg6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:53:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52827090cc5so4926901cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784703215; x=1785308015;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DfBI63uQ2/HBYGxVHjRe87BTGBCvc/oFJXrDryfPiSo=;
 b=RAm5oKGvs1FB5flFPYYe9ZXmL09yOsoZyQFPH73rPZaoBNWLD/y/Y3/LQyycw/yMFa
 mdeBwBhdBYI1T85dd5BTCRaXt8o+Ve8fl8TMeNoxVNUuhcMbn9fmRLx/OjAEJZtujKyt
 xn88rUaiG713QQdM9yPSZzcNTv435PjTkGrcNwDP3XaQrYL7Q4zCzWfMudjg8Ie0MZmO
 5JASEFE8q5EZe724TJNZntiPv3KlJzE8t7jacgzPAQv1eT5C7G+pj9Fzr/6KSsygfXKp
 4x5E/u3siVR7eY8QD0jj1mO1Z6ut+TqkDbbBQf2QaZAq0PrxuHodr6m7aN2j6Pmy3k0m
 U+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784703215; x=1785308015;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DfBI63uQ2/HBYGxVHjRe87BTGBCvc/oFJXrDryfPiSo=;
 b=hrHB3A+LmuTrBuRP7Bl31g+08MaU42Za4RzVooRjmKZKNJHj9ep5LbAl8nbbeGEBln
 uebAPiGunU3kvZk8uAe9FCXrojzANEwyMwlEVCviqEHLRAz9m17HPu2Cf6HB+AIpJCJx
 Gj/aNE9TZA/x5X2iGt+n/3Tq+ixv31wB3NgamCm20TERPSG6XY4GiKe0LeyKE9zuqD19
 EHS2nkYZEBjaIk72rIGK9JFUHWixjAwUZzZo0pEQBkXR/0unzsJQtap+3ny4T/grHM7A
 2oyHKpWOoGtBk9bQBinWD8BZiUkCQqHh0kFZeitWsNr6DEBpsw0IvCPl5KGlvurHfV6R
 zOOw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2i6ZqenLkRoHWYk7rvf1vcaGzgbShSJ1rWak4ysL7/FDdPlFs5zyR/rimWp0BT4bmD38+MzBAtEc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdXCXwe5vZChkZDPijGVzWdEZojIt9FtlvZx2ZHMnYQ3/PTAkD
 VblTKb8AsaGVooVOQkFlkfszR/Mhi8OBnNmcKASeeR4N4OAVOtqD6X4QHpDZkt3wbK1+pxVJD77
 5WE0ohJLWFE/RWCTVPYCIitnFLGCYxcckVfSVKWJucvch0/SEHJ4Vb35oFIMDXjgMng5ZouQ=
X-Gm-Gg: AR+sD10xw7WpOgskFfiGQHGhca+nGnvCLgTb5V4xo/esqFQFrrzn7sjIlD7mwWsbeTo
 //i67sgzDJvcTbF82rmm4V+4LCPKgC1XzAE4dIP8/Yp2Kxns/MIoMXnEfTFSKR1h/G+VT2wsZOo
 o0PUhBF/SfeCpLpa9QmQVZ8IuRhi44pxXp+vbCFZNo8uNysH84xnbr7BuSIGw0cgbjMFmBsMlds
 AyRhxP3QrwdeZg1l0B/CuFGeCzC8kGeN9W1McIHOwOnAiicjrTUmm3OFd9ga2P553JHsKAHW4n1
 nvpUX6NQwHQy0hGl00xyVDSDbsZgtRNLpanq3IN+kjG5g4/hh6UXvYjvn1AWpK2XGBOxC0Q7BYn
 blfrviaa69c0AmF6+ttVSYroLf/WvbvRMvOdw971ScHglYsVyTrTHJLF9CbUmFspAB6yXQ1kuUM
 mAjq5Vr+KAPjV8bA==
X-Received: by 2002:ac8:5903:0:b0:51c:7aa7:e0f1 with SMTP id
 d75a77b69052e-527a9ef2cc4mr27795471cf.44.1784703215028; 
 Tue, 21 Jul 2026 23:53:35 -0700 (PDT)
X-Received: by 2002:ac8:5903:0:b0:51c:7aa7:e0f1 with SMTP id
 d75a77b69052e-527a9ef2cc4mr27795141cf.44.1784703214499; 
 Tue, 21 Jul 2026 23:53:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b9a7f6sm303545e87.18.2026.07.21.23.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:53:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:53:30 +0300
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
Subject: Re: [PATCH v8 06/39] drm/display: scdc-helper: Add helper to set
 SCDC version information
Message-ID: <4aznbqeel6jld6qaulbpj2jeelqyppftxnpgmxlqyg5byb5bli@6qd2lxjzhj4z>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-6-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-6-d79890d00b6a@collabora.com>
X-Proofpoint-GUID: fUEhJOfEwboEdTMua_f9BDv5fvrvo6DZ
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a6068f0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=oPwEgnVxf_mYLS787iAA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MSBTYWx0ZWRfX+USjUcUYsuTr
 OAHZCZamonh2UBeKcsTDnHT8Ed2fMXY0ecq4KuYQa8NyaczSUF/P+ZGPEQwTw3jBO5KsKhRkC3m
 1FjrxqSwIX/dxAa4YjJCf/6oN4mbwdkYu/c8fRyvCdTL9EfpzZqvCi0u/LOJENblrE1pdtcANNg
 rrUNOYd7pjH2s4dNe3aMrWTtGy5fu3ACd0xc0JD3vT5P4gi/okbx22VYStnA8lu5kTWfW42cw9/
 K0WETqrTca8uB6YRRPDmVthsXcwKPbHtOsCOhHkAdi1uwEzv+6e6dwLnHiGq9MimMsjm1YIdLYj
 Eb4yxGD8zePH/g9PcYn08qV6MeAXDJQb/760ooFj7etqDzJyfhqOXlEdeUSdTvRqHD4CAnD1Hun
 wlBqLrFUtnlH/C85YN9+wKTHUBiuBISx4Wcjy8c77rsRrHzi3Tdct0Oe2PdR0IjBiaoPn51v21z
 4bHcK3M+ghNXbIOWQ/Q==
X-Proofpoint-ORIG-GUID: fUEhJOfEwboEdTMua_f9BDv5fvrvo6DZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MSBTYWx0ZWRfX/euTtHfoIFtT
 dRESuD+rjefj8WArqHTehY9mBcfy+epc6kg8Gq7MW+nNKxZUWfVjAh6B6mLyl7DJviE/8kMbKbO
 j5gwM1fNJKWK9tmk1JI1NYCrB+voUD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220061
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

On Thu, Jul 02, 2026 at 05:46:19PM +0300, Cristian Ciocaltea wrote:
> The HDMI 2.x specs mandate that compliant Sink devices report their SCDC
> version in the Sink Version register, which reads as 1 on any
> SCDC-capable sink.
> 
> There is also a dedicated Source Version register.  Writing it is not
> compulsory, but the spec advises that compliant Source devices do so, in
> which case the value must be 1.
> 
> Add drm_scdc_set_source_version() to follow this recommendation.  The
> Sink Version register is read first, both to log the advertised SCDC
> version and to guard against non-conformant devices: a sink reporting
> version 0 is either not SCDC-version-aware or broken, so writing the
> source version gains nothing and risks upsetting such hardware.  In that
> case the write is skipped.
> 
> The source version is passed as a parameter rather than hardcoded, as
> future spec revisions may define additional rules for the allowable
> version values.  The written value is additionally clamped to the sink's
> reported version so the source never advertises a version the sink does
> not understand.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_scdc_helper.c | 46 ++++++++++++++++++++++++++++++-
>  include/drm/display/drm_scdc_helper.h     |  2 ++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
