Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ACFCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7AE10F540;
	Fri, 12 Jun 2026 13:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlgLuP5e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EbdrtNtF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A646110F53B
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 13:56:25 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CCjGCR3721712
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 13:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lj9iP4K0GcPnNCW95XMo8tVN
 jOPr4RfYCBOREwlPyGg=; b=IlgLuP5epKG7Z5khBWGVWey9TcvkzndL34gn+BRL
 wbvqAp7hbNbX81s1YbPiX7vmpFIfJH+h7VAPVJq4p8ifKI3T5XT8RBMqYSMstXHS
 ZChjsp16KOYilHe2GvI93MdroXzY/O0MsPLRyw1uUu8BkyiSBOubv5PValHc2rCu
 aD30yxKF5QIbdvvvpgXVXFGP+Kb6MblChW4vCdglMMF8cogrY5+BgQ+BHTAvedsI
 e+QC6dyVvfIPdXUD0PWalBxRuJ1SMovpDQW7z3K5saTUUgq4JePSDhT1ohia1Dtx
 SQm2OOijXfcwoGbdikDVHlcXCHeKI1orwQMKGk7bPczKBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbkh74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 13:56:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915c1997732so237641885a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781272584; x=1781877384;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lj9iP4K0GcPnNCW95XMo8tVNjOPr4RfYCBOREwlPyGg=;
 b=EbdrtNtFm0TsMcLV2uvuNYaUj8YKbJboAI68HhqQqb3RJytJxbFJoq/WLAM5KLtVGe
 ExQ4hXcXrczvLl1Bn646fdSkbKkBAVfeaULSad+R/Gr4e+AKvEKGuCc/6bkSUWxZVjZG
 Zv1e8tAV27CemYEZXR0LXWQGcPBkGhLm5Yv+OJ/dZ0yZxpeMjoTD5o0RcOZErr0mylJp
 qmsPhsC4hmOxusXOtWsoVtWJb/FJdaCSglOailYzK+yTbYVHTZVGuPLUH8iaeWL0AcIb
 z1awzj7mK5lkRpkULM2z7BuayMT/hIp8lS5G/MuNX3Og9a0qO6yvuFzmzAT47OdhuqCW
 TYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781272584; x=1781877384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lj9iP4K0GcPnNCW95XMo8tVNjOPr4RfYCBOREwlPyGg=;
 b=moOcZOkkpdwhmJFn4FGh6Uj40sjXGZe0Zluzz1pkb40iDRacm+kHb09j8lkY8vGmcv
 R1qcYPfcNQxIVwvw6tw7AN5eBj6vwhgYQWIF5DmV/PQYNMhfC+vTA3vhEIAuG/R6WM9U
 L7jAbLzIEhQ1wiu7OEOWajDWyKQ0H5ZZdo0Jeh1IVls2TOyixzqfyR/f1KbvSK0h8Rfw
 3bGtkszLxzy5d5m2xZPJpnnh8zCYVQZrvIhbEgZuiojazsdMhbxkqT9eDX1hiycov5Hk
 WCPL/mljWzlelDDtkbXqtlqv2zS+fAtSE+XvU43C1UmS8DxjaZQn+1cKQm7EMxG6CHxz
 /ZOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PWTc7RQnc1ZxH1S0BNA09k6oZmXGzL2ZfVQ4QSLXK/nDiJv1YO25kYd+naQpX6Rws1w9dw2NqLP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyYX93f78wdUm0wHZnfwcTXQTnr86F3BkAgBgfWsRIbNSi/s/G
 7WBdiSEYzY/qJTClx9GJfXS6xEaBJFBSG/0da5Lxkah2VyZV7ZAqn5DdSgKi74O9ySpVb9hv38K
 /aRHYG46X157lw5z1zF9vtUG59/mwC5rOm/yL0q8SYDWnOZWyLTKSXkTVprVujaPq2IIQ7Ig=
X-Gm-Gg: Acq92OHMu4Ikf9b7Ym6jFPrFNIVywRbdTXnmulrU60k3+0Cr+HFr9lTPMHfGeAWaTwv
 fosft4lRtQ1VNYiUa/4rv+DIjZB2d4SbUqoVPlFkFi+LpkFqKGpF1wQIxRsPyDmh92XXf3ltSGG
 AlTDUYZOO1+teRmevb7m8/aap8rUQW7tQOMqsAn8MpWbiWm7sGHgtEmhRwiVCEE6vfuOfQj8jlY
 OLivOueM0bI4IHbJfhNuteDIssSExm6RR/WgfTkS22Q6fRUc22rM4vjkVQgsqtGLDHgvtk/uEl+
 fl4ePtqkwlM3DDuCdnXmVdsU7oNTnYHEKWFZyKlcFS3eIQlvGpRlAn1peOLgUtZEs2W9M9z4Mxx
 bq0KokUNsu63oaF1xtWxth6bUC+Ncun1BwbTdkg34FGuejXRjiFKqoSrZqe/WGpZHcBHUpBWvC9
 c9c3tDVQOC/0f1Foal7EY40yvV5cmt9K074x0=
X-Received: by 2002:a05:620a:2411:10b0:915:75ba:179e with SMTP id
 af79cd13be357-9161bc9f023mr286845085a.30.1781272583868; 
 Fri, 12 Jun 2026 06:56:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2411:10b0:915:75ba:179e with SMTP id
 af79cd13be357-9161bc9f023mr286837985a.30.1781272583368; 
 Fri, 12 Jun 2026 06:56:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1b4869sm563523e87.75.2026.06.12.06.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 06:56:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:56:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alex Hung <alex.hung@amd.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 2/8] drm/amd/display: use
 drmm_writeback_connector_init()
Message-ID: <kkfb5lvudgo3curnoakp3qre7pofaobaxynz7qhrn6jy2ll55f@clhfe664z5ci>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-2-42567b7c7af2@oss.qualcomm.com>
 <27db214f-b57b-45ab-8deb-da2aa8efb9d7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27db214f-b57b-45ab-8deb-da2aa8efb9d7@amd.com>
X-Proofpoint-GUID: 7o4lFpWNFAU7S1HqjosSXLhsxxt5K1bu
X-Proofpoint-ORIG-GUID: 7o4lFpWNFAU7S1HqjosSXLhsxxt5K1bu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX/iYjk3nWAtMB
 86/OLrCO/NdC8dcWByyPFf3RLVpQUFoz/0onogb1EYTxQe4YE/kSIVUyCnE0ZZR7ln1hSWo5oCJ
 YWKLAQjSckYmlSam7GO31W/OX0gWF8g=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2c1008 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=P-IC7800AAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=t-2y4xJzw7g1bk7x_BQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX37HYwP2YZ6eC
 xk2VYGXcD2XTkWQlZ4PFWeHF2iM7VOXXbx11iiqsL/Wezwf6F4T8eEF1VGU5RbuStTNHFLhBZ1P
 mRtjB11JCxwViWnCr6FZh+P6vNHJsWD0COJhEjPl8OU8iatCbjT9BHdCRQAYyuq+JexXYOa2Y9r
 +eLE6UFGZ1RYkDLBwiDWWGsTPErWAyn0LB//gkSWrvyaJXYyWz67JECULAw4ZWhWAkxoCk3Y3JA
 6vUdFuY0S6JiFMa9CsCCJ8V795+Ehc/7udOAw3aqWftZg1e9MXYNImoMAoC9zwiENDXrOQsklAu
 2aaCz7vIEyFUmxjvveVtOtOOtmdns6E3ERCKDe5Itt+BetoaW88wOyi9V/gcqvZMwbxhgi3cfqx
 GIdmKtFPjzgHa+2lYYkULWz6otmXI49yxJK0Twy9hd8QcbhibmHZwR9BW2bMgMgVt+vD4mJrDZm
 tScrMPeXFWlEKbbvGYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120127
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

On Tue, May 26, 2026 at 12:46:30PM -0600, Alex Hung wrote:
> Will allocating wbcon with drmm_kzalloc before calling
> amdgpu_dm_wb_connector_init be more memory-safe as below?

Sorry, it took me a while. Yes, it seems to be a correct idea. I'll
implement it slightly differently.

> 
> 
> @@ -5790,7 +5791,8 @@ static int amdgpu_dm_initialize_drm_device(struct
> amdgpu_device *adev)
>  		link = dc_get_link_at_index(dm->dc, i);
> 
>  		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
> -			struct amdgpu_dm_wb_connector *wbcon = kzalloc_obj(*wbcon);
> +			struct amdgpu_dm_wb_connector *wbcon =
> +				drmm_kzalloc(adev_to_drm(adev), sizeof(*wbcon), GFP_KERNEL);
> 
>  			if (!wbcon) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback
> connector\n");
> @@ -5799,7 +5801,6 @@ static int amdgpu_dm_initialize_drm_device(struct
> amdgpu_device *adev)
> 
>  			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback
> connector\n");
> -				kfree(wbcon);
>  				continue;
>  			}
> 
> On 5/4/26 18:24, Dmitry Baryshkov wrote:
> > The driver uses drm_writeback_connector_init() instead of its drmm
> > counterpart, but it doesn't perform the job queue cleanup (neither
> > manually nor by calling drm_writeback_connector_cleanup()). On the
> > contrary, the drmm_writeback_connector_init() function ensures the
> > proper cleanup of the job queue.
> > 
> > Use drmm_plain_encoder_alloc() to allocate simple encoder and
> > drmm_writeback_connector_init() in order to initialize writeback
> > connector instance.
> > 
> > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 18 +++++++++++++-----
> >   2 files changed, 14 insertions(+), 6 deletions(-)

-- 
With best wishes
Dmitry
