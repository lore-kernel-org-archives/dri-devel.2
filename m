Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD68CD4F50
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 13:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD32410E72F;
	Mon, 18 May 2026 13:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bgj9cJ38";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZLSFydEK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030A710E322
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:29:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IAopVC2083071
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8rZ2DM1+I7aly9NQLRB60FkI
 XQ2aywpnwDJZYhW3iAw=; b=bgj9cJ38XdJ2FWmhp6unVr2kNxYT3Bb+zaDehafE
 TYxKYtpKWA3Sn6ygu7iwTLqWPcSliEMPFQcwerjRPA2QJ2oO6xHz+N8qQF/r7kas
 RI6ojHkUu/kfsVRubth2rmazYy7KUY1455DQgrQsV3a6ZozVXsHWq3KA7cdRZI6A
 nvj/w3PfMOyVYvrQSFAytg05rzUuwFvTy8Moq/2bfMzefWsMk3qFTjqk1Kpw63NG
 CwYOATJn6ygugFeuZOD1HQC/5NcJRXSPKtIp+b4jOJ0GfWUDHWta54wIrvSgLxt5
 sj7UEsQQgKFgSdd7OJR97kg69+Yq7Jt564uDbJgENNYFxA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81ch8kxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:29:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-83f8aa671eeso29914b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779110960; x=1779715760;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8rZ2DM1+I7aly9NQLRB60FkIXQ2aywpnwDJZYhW3iAw=;
 b=ZLSFydEKjrnNRidMZSuS7Z7d6qZeAHiV1VZ7LTuqzkxHICvYIlRyaEfPADBSfbuG6b
 joNHkcUpfQMMSk8m+kjtOu1H+TRa7BZOTAjHaYjk+PJqyU7oFMsJraBbeB93ngCsLe/5
 nzMs0ryk7BeRi1JqDCuG0ZZDyMclLMcTs2e6Di833x+SLz1uXeUtJU67eaOkJMoXSPvD
 va1yZo4ejbyN4QtrrLQJlHovfNOdiUSGg/YkcxeHlaEb0q5V4qN6pExPydHNWWkMQCln
 w/uV3p58wvU5CCJ6ke5F5EdxXXW67cY7/fuamRfgSzST6NNs8VMJzZ5+99AO6/EW5jaX
 cS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779110960; x=1779715760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rZ2DM1+I7aly9NQLRB60FkIXQ2aywpnwDJZYhW3iAw=;
 b=ei7I92N/Sfb/ZP2F9QxgNV/0fKxIvMYJ4UKIXzoa8J1cjckCGrRP2mgX+qt6Df9M/A
 jaw9VSPj9EU4jyMF30ITuCCz9vuCZxwZgBeRPttf3OsMeYOnsLr0w38n6oguoG54XxLL
 pxBdwmLOdT+sLelQgav8Ny7MasD7mR2h24AxJ6uoa2DEpZP99Hiwcocl5E5rSq7X6vAv
 hl1YEbRdg9L5GGafSMk8Ug/W72kXwnw98g37JtyD2fr6WPLOcnxtr8FwHus4dDPQKSdS
 OVCIoLdBLiiAY1b5WRaMJcrjmD0QyE31igAINDuLP0vX79PqT+gHlLUxkCxeneC+DWFT
 bvpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/e3VYhBRvB9LjO9vo+DW47/Ezrsgrgp9Agv1p+IcoPiKhHtx0APdohi2GBV3MIbZ5gB+VTyIfB74E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjO7Wvor5rXssP5WWk8YzfREy1kUxMfkOTWAYUm8p4G4+RfN2p
 OEypDL571gU287baEhkYqMtn5Jip5Ou2ft2tWiNgX66tKEiQsI3NuPTWi5etXXz95Mm3i0zIYTt
 DrbXjyplVEdu9YH9YF+qjqWVNwUjJb3LQ1WBI8V6LgdSEWFDqGGz8i2xiuSAbbQiclyNTKpQ=
X-Gm-Gg: Acq92OHl3iS2Yx0VMYyFOcMzekuvI6xmGGVnU4/xDFHVjczKLNW8rvQn1OCsLxOEk47
 wJUTJ5a7zhNemmfkVnubiRcC1MvC8j6s6dcq9aZBUqDLG7XWsvsMjdQ8Q1Gsqr6IVC2V9Nwm/6K
 RdtWiANz0OhaUddnYtcxwJHHJOC62BLzAnOeX9y0wRXlc5oRSM/tHczDP3oLB48dRo4L++vEkGA
 yRwJ6h15L1KjMEf0MEU1xTX8480nwZWeBTpJhZEaGzbOYLCXzbbdYWXgFDSOusyGA+3ZnG0RqKv
 0I3nP2GDnEJW8cu8XAWcAWO3F4OipDx7rG9u8YEvf6xF2z8FNVqvQc4LSSw4lRcs+UeRqGu0HG1
 wU6+IYzp6IsIOfe4Q0eeX6If5lfIc2MPCxZtMRDd75/O31jfgxRLz+eW4luxIfZk5uRqcy99ZAZ
 dL6eThRgdTknZCukjWGFtiHXMvcInfj6hqYifcP34lEA==
X-Received: by 2002:a05:6a00:124c:b0:837:73ab:1013 with SMTP id
 d2e1a72fcca58-83f33cc89edmr9056258b3a.6.1779110959978; 
 Mon, 18 May 2026 06:29:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:124c:b0:837:73ab:1013 with SMTP id
 d2e1a72fcca58-83f33cc89edmr9056238b3a.6.1779110959542; 
 Mon, 18 May 2026 06:29:19 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19f79b60sm15938649b3a.52.2026.05.18.06.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 06:29:19 -0700 (PDT)
Date: Mon, 18 May 2026 18:59:11 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com, Ravi Agola <raviagol@qti.qualcomm.com>
Subject: Re: [PATCH] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
Message-ID: <agsUJ5Fq3thIDS4c@hu-vishsain-blr.qualcomm.com>
References: <20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com>
 <v6bw7iszyaoukbcgnunieuo5vcjjrqgf5mct4svpqxcomwssgv@xvfb6y32vt4f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v6bw7iszyaoukbcgnunieuo5vcjjrqgf5mct4svpqxcomwssgv@xvfb6y32vt4f>
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a0b1431 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=FQUaCYA7XYoef1_AjgUA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzMiBTYWx0ZWRfX8ie3VipZ3PCl
 i3y/pBE00TT3SoHhmai4yH1agOL1RfF6O9tEcQYDkLfckRfyxf9IRiPjnC5XLYuZpr2mwV6iNRy
 K0jnt/d4Q1Y1QSdq6ML5cM+zb0z5Ye91aOtcqsUoTRMBHfKyw2hZcWup4ljtggTqERXPBz6DAQZ
 KsQjdTJs02vUc3hMmNaG1CtGTY8njjei9o54qqK61zyWSvDtHosOAGWruUCLNVV89rD+I6sFYk+
 HQPLhGlLVrYJbr4PFTEuHOIYMPVcxWRU3rPmfJyiaTE7RoAzLmAaCRwZdsBC1V4/DazIbtUVXFL
 FCzWybfxiYiiXdDHxHNszyW8HfKTMXuf8S9qoa/txbVGVEpFlULtzx9JhKAcbIbnXU7/lv/Bmgn
 mUyO/6Qdz/P4phKiA1rDNp4b3KwrvNq25ljzV/gnl5kG63TRWKMrZQcqp9FWE+vk5ud6RC45ak3
 yyGMGuyrs+T3vg9F/lA==
X-Proofpoint-ORIG-GUID: 6yXeQtDcxv0HmpR4sdgCBPdv_cRqPb7e
X-Proofpoint-GUID: 6yXeQtDcxv0HmpR4sdgCBPdv_cRqPb7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180132
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

On Sun, May 17, 2026 at 11:58:55PM +0300, Dmitry Baryshkov wrote:
> On Sun, May 17, 2026 at 11:44:49PM +0530, vishnu.saini@oss.qualcomm.com wrote:
> > From: Ravi Agola <raviagol@qti.qualcomm.com>
> > 
> > The LT9611UXC bridge can fetch only 2 EDID blocks at a time, which
> > previously limited EDID reading to 2 blocks and prevented support
> > for displays exposing more than 2 EDID blocks.
> > 
> > Extend the driver to support up to 4 EDID blocks by re-triggering
> > EDID access after the first 2 blocks are read. For block 2, clear
> > the EDID ready flag in 0xb02a so the bridge can expose the remaining
> > blocks, then retry the read until the expected EDID is returned.
> 
> Won't this affect re-reading of the EDID? If so, we might need to reset
> the flag at the block0 path too.

Yes, edid will be invalid while reading again, that's why trying to cache it.
Correct edid received after HPD. Will try reset the flag at block0

> > 
> > Also cache the full EDID blob in the driver and reuse it until the
> > next HPD disconnect event, so repeated EDID reads do not re-query
> > the bridge.
> 
> Separte commit, separate justification. Most of the drivers don't use
> the cache, so, I'd say, most likely no.
If flag reset at block0 gives correct edid we don't have to cache it, just that
it will take few extra ms to load the edid data again.

Lontium also shared the updated firmware to load upto 4 block edid, will check with them
on upstreaming plan.
 
> > 
> > Signed-off-by: Ravi Agola <raviagol@qti.qualcomm.com>
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 84 ++++++++++++++++++++++++++----
> >  1 file changed, 73 insertions(+), 11 deletions(-)
> > 
> -- 
> With best wishes
> Dmitry
