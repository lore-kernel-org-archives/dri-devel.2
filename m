Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98E0CA5FC1
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA3B10E08B;
	Thu,  1 Oct 2026 02:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTKFzCum";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ah9L4kaA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB26810E08B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 02:45:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910jiqH171516
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 02:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9Ol1nfVGYFnGbDrY614OUc6R
 zJCOeVGBluvM0xZNXmY=; b=GTKFzCumBRrV0y2mly2vCB8Wm3knCgVMjMKC1chI
 3HjBPCmkOUXrwHOgqprIOPtCkcuAPIGrO4aBvBbGa8rye88d55aNEVM5JABsLXII
 3NWVfSfKEJ9xlzorppNGZGyjMXBcYaxNyDoURKDLRUq/44+ZsLBdPATNTKvoVKEQ
 4CbfLRQmc7byRS/NnhEoT2nqjwJ0JDzXR0kUIix+96G3CKja/DVRFGfi8zaUre/G
 5e0kzWWrF7XcR+oVC+7xp2HwgxJLK199EENhm4iQp7c8Ihbn1ZvUDFYKDl21mtRm
 WJh1P4tZgW8IBizwxhs1dIuK+51P8OpQmnAmhKDO+X3z9w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcsway-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:45:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d749e0e0fso147935eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790822719; x=1791427519;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9Ol1nfVGYFnGbDrY614OUc6RzJCOeVGBluvM0xZNXmY=;
 b=Ah9L4kaAsmlg5Zh6P59Tt24o7IZj8p4pMowbma5EChqoKc6W9qE8r+cDYh10asNJmh
 6X6Chci1zMoYmdkWuChbrgvl4Li4eguEtxNNjsCrEpiYApQtQjSLgP851YgriVjNgzEL
 UQx7eowr3itMSF4jRBZuJvbJwka8FSpS8VW5j1lViQ49bR4hUW8Ojr3WQfVz0/edOv5P
 PB6/sF1TaUZduc4yhiq3JjPoQ5qJTzFKgZqvJRPrfupC299Lz3vThGAmCIJjeCwA2iQx
 gTciFVM5t09keVszJ3ZgnIz/c9eB3tDlGnDmnujLTV3s2y4bEpxOV8fkWRWvLbIIJF4l
 /fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790822719; x=1791427519;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Ol1nfVGYFnGbDrY614OUc6RzJCOeVGBluvM0xZNXmY=;
 b=eJlqnyskw5JLWsW48hcl55i2b4i60y3qkJPMtt9iWctVL+6Z78DnhXVO51kQwki8Nb
 GUx8+qDE//0mOTvqbUw/0dg2ZXYbCVpHQRwbUM57rPkNR0d/F+LA58ZC6BKcA76XmvBj
 eTsLlqpYGDGfdjo76bl5kFFU6tNlGaR/z/uNei4piC6t/ByBpPDYNv+bn+tePLwmcXQK
 AMMYVGKqja4XUBwppSg9nBs8PVnnHmGjWE/7XwNWye/7Y6mNa1yzi+iEEZkkd6Jzupxi
 GPOfR7MW+ovsV0cZBdiDdXbkSNKj03AKutlr9adWo0lh9rQ+SH7MJL+zAMQCaVXm7Inv
 XVJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwG1A/B3BROH0Jqur2gHyCVZZRKSsKnCTTkbSZxkgQjacMKDhG8OMkLvrhfAfPaRnpTEDVUcZjeyU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYISUqy1LLrQjySOYZaxrA4ICwviwVq38mj0T0g1CLwhwNudwrP1
 fR4/cdbHyqliCG+7gZa5DfRIvcJJ/C+7OA5CcengfGFacbBA6gAf8V70kLykSYl8uTz6xrA0NRx
 39ZsLp0k50ft+XZiomtW6yGxi5MGGKYV4RQZbxt3rXzbF8RbGFfsNOmwGc3xDrXsPHYWhrSw=
X-Gm-Gg: AYBFou0EV3UUZ+OBAbcJ9mWSwRCM08xRXw/C162zHYnBLmARyga9JRK748m1ugCfv4c
 ch7AURGPlcTaT49ZW8jWueKXp9oBZkQqYBTKLKhVA1JKC2ns2JjswoRZR/MtLF6hdYVU3bJVeNj
 0/GsQF73sNrzr3yWyFa86ligapIo8ckpOKzgJ5n96B/vN48njBUh9qc8eYFLsGrMQ43ArY7VtgJ
 eQFpu8IyEYRClxkFW4SKEy9O/E9bcN8feBL5iKiC5wPmJu2W1utq1MesQ002X831mZoe1N0Kloo
 q+PZElvNHBQ2DoSCp0BwLix/zXUGQl5fdt91BdfoXtRD+JS8iKfJkMVCPcvyhUSIBFS/flnnKwa
 frwMOvHQvLCYa+dxXsKsUWuhLwIJmNctGKAJ38x2PHHWO2ShDpHQsyXJw4nld90CIaMdBui6MT0
 ei/uDmRbvW29wsMqzvCxY=
X-Received: by 2002:a05:693c:41d0:10b0:34c:15b5:b4e7 with SMTP id
 5a478bee46e88-34cdbcd280emr6207088eec.2.1790822718471; 
 Wed, 30 Sep 2026 19:45:18 -0700 (PDT)
X-Received: by 2002:a05:693c:41d0:10b0:34c:15b5:b4e7 with SMTP id
 5a478bee46e88-34cdbcd280emr6207045eec.2.1790822717785; 
 Wed, 30 Sep 2026 19:45:17 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34db4c1ef93sm3065432eec.28.2026.09.30.19.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:45:17 -0700 (PDT)
Date: Thu, 1 Oct 2026 08:15:07 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH v9 2/2] drm/bridge: add support for lontium lt9211c bridge
Message-ID: <ar3JM7CHzLZgT4xB@hu-vishsain-blr.qualcomm.com>
References: <20260924-add-lt9211c-bridge-v9-0-d78b39677a61@oss.qualcomm.com>
 <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
 <61aa851b26f9aa85a3ec1dc4bc8f46d7f1fbd24e.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61aa851b26f9aa85a3ec1dc4bc8f46d7f1fbd24e.camel@pengutronix.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxMCBTYWx0ZWRfX0d+V0+k765kY
 fB1Vym/jVFfzg4CbwjVT3Zy94cH7lJgV4Vd5kF3ddLi+ZhLsLvVW7iVh3000biPVzmb3fYSfKiA
 FOW/gtP2L+JXWZVEZ5xtjVKOcUskTz8DPMQIhyG1U8tDwNQ9hbnX2zDD3mhZyFT0vHiSEYYwbWF
 DaKCEd1jSM8HpqOd1mKZIjPmbOAy2E4bGxN4OAF+dM50BSiQG1vJnZRcB/UH8sDAH5bPwmhRDO+
 EVrSO68vO2GBFV7Fsa4ojKfAGEkHWk11scLwxkazMwg/WKyA60ZtuYAx8oSoOHAMKUYncS79/Tv
 jBMP5iMQlMV5B3fPmilFJj+I03OAsmRy+crUcJGpqNh1Dl17CN5QFUlFzXkGj8HcU2sVHCNpUWM
 3M3LUIw3TpGblnXnUGgW4hXroZCLcPxFo5efqnWIN/YrNOLr7AYhQg53Rin3sp8w2NQKkYgxfbz
 pv4hlxmuCO8wRvBMjUg==
X-Proofpoint-GUID: VoUB_uCuMlArAAtRNbkVJu0D74hnXkjA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxMCBTYWx0ZWRfX+qL1Qr7JH7QH
 Iu8k1FVQ5ngZhi8oM5EXMR3pL98DNZvKR8RJaTMqdXmByH4DM4WQP9x/AYACkUWvJy0U4cYSWiP
 RAW3s8cer5pN/L9XxIAACV63cKNiURo=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abdc93f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=10iAqneoWiIgQKNWSb8A:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: VoUB_uCuMlArAAtRNbkVJu0D74hnXkjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010010
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

On Fri, Sep 25, 2026 at 03:23:28PM +0200, Philipp Zabel wrote:
> On Do, 2026-09-24 at 21:29 +0530, vishnu.saini@oss.qualcomm.com wrote:
> > From: Yi Zhang <zhanyi@qti.qualcomm.com>
> > 
> > LT9211C is a Single/Dual-Link DSI/LVDS or Single DPI input to
> > Single-Link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> > Extend the existing lontium-lt9211 driver to support DSI-to-LVDS
> > bridge configuration by detecting and handling both LT9211 and LT9211C
> > variants from a single driver.
> > 
> > Chip detection in lt9211_read_chipid() is extended to identify the
> > LT9211C by its distinct chip ID registers, and cross-checked against
> > the chip type requested by the DT compatible string to catch a
> > mismatched board/compatible combination.
> > 
> > Add LT9211C-specific regmap support and use lt9211_chip_data with
> > i2c_get_match_data() to provide per-chip configuration.
> > 
> > Five new functions implement the LT9211C DSI-to-LVDS initialisation
> > sequence: lt9211c_configure_rx(), lt9211c_autodetect_rx(),
> > lt9211c_configure_timing(), lt9211c_configure_plls() and
> > lt9211c_configure_tx().
> > 
> > Defer the remaining LT9211C initialization to a work item scheduled
> > from atomic_enable(), since RX auto-detection requires an active DSI
> > stream.
> 
> This is still wrong, and I don't understand why you need it.
> 
> All scheduling initialization as a work item should allow is for
> downstream bridges and/or panels to be atomic_enabled while
> lt9211_work_func() is waiting for a vblank interrupt.
> They expect the LVDS signal to be active at this point. If LVDS is
> enabled at some unknown later point in time by the work item, any
> startup timing requirements the panel might have can not be applied
> correctly.

Sorry for late, delayed work is now called at first vblank irq itself. I think it will
not miss the initial few frames. But i will check more on DSI host side.
 
> Also, deferring initialization as a work item shouldn't have any
> influence on the upstream DSI signal. That should already be active
> when lt9211c atomic_enable is called. Could it be that there is a bug
> in your display controller or DSI bridge driver that causes the DSI
> signal to still not be completely active at this point?

yes there is some issue in msm/dsi host driver as DSI signal is not active at atomic_enable

> > Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> > Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> > Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> I have not tested this version (yet).
Ok, i will remove in next revision.
> 
> regards
> Philipp
