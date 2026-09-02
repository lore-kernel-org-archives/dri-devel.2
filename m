Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC0FC624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17F010E00E;
	Wed,  2 Sep 2026 14:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LdiKrmlD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6mY10hV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D235C10E00E
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 14:39:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CR1Sr1549551
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 14:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pvJaW1PmY06p/riBfvSZ/r0i
 tt6WPTapRiIe1XOVAS8=; b=LdiKrmlD6esXbaH36R6WqNdNETL5ptVqj6QkLncO
 RSx71t9J1UZipQHpCDo9FcLoQGSJ8u7KY2VvetMLVd7EcpW8bgAYwKDRcQTS5B/c
 Yw+a2Na6mFScGJonka7exW6cCNlzp5SoG+gv7JTM3jDWX9NPguKBykkekdy+euxG
 7mtCSo6Gs+O/AVE8A202KnKzXkWIYOk8mdMrqp+ldX7eh2600iypiOkdWpwcaSRt
 O5uwO5+aM6FSbBGjLFmpJ+7SV1Vjmjmkgv+AtAjY0io7bvBYZK4yYljpub0d0z7K
 87Eg/iUrjTuiZi42Ww0guB5EVfXDf0ucsVnnbOtoAmPtVw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c8y0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 14:39:28 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7f4f9788909so19033a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788359967; x=1788964767;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pvJaW1PmY06p/riBfvSZ/r0itt6WPTapRiIe1XOVAS8=;
 b=C6mY10hVr7r/KqwPOxKPu09hxGdH2pMrdnNaInAuwruqWXLYI4p8dP/UWLZ3hJd5yX
 vkhYOkZVND+rH3jpOF1S4Dbvm2yHSolJBXkFT3QHVTXLUinAmotHLcgF2B0AksPeUIaq
 8QuJ5/+/gHpfSds/DlnxMyHXa2E9EbnDM12Mazh4zIRoOAOb7hQTQq4yJbvviUegJhsx
 GJ8EezEZNIOImeUkfZUcLkn33THyxs8qcFE3V+CiJ+rC5ndPIfl0+sQEkXN435j/CR6N
 4HiFwiTc1y3do2OgkyKK2+qJxyoekRTztsxx9T5hV3R1Qf87NacPcE0NVMXyYmZstsI4
 McSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359967; x=1788964767;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pvJaW1PmY06p/riBfvSZ/r0itt6WPTapRiIe1XOVAS8=;
 b=m9mkfuHowdvUjMKgrDF3RhjBStbab6iKVka21XtMFHUpRiCjuEuli6hWz9V2mBUHqP
 VTBMit77M9rAYdgCpBFj9JuSoF5GbrblqVOP//6DeyxOuFEndFMi5G7tEwmgcDNTmw+4
 N1qzClUNOWQ01dpcEuyzV7Lcve/jVBN5Qj6Q6VoWzwvz6e+SqeqQZTT6qX4DipoTqix9
 5o1EvRBXdm31+VP4mpofAml1pkyDhn5xLYk8C7ipjQCWfbODVycmH9il42sQeb2OL38f
 9eE4ju0o5i6+J6hworjlCclo6/uuHhbNSfJcQ1LoBdMGMYQyMH+DV8DE/WmnKMI3fMCg
 Ei5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMWGdL6+u4U0L4h1ZSF3jqlrKTqRBst+OOYMqPkid+Q6BJfu59AiLTw7y0/qW/b8e8ZPxgrjWmk78=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMvfsHS5i4yQSelKbnhAXAMK7/Ei655QybFX+h4FFMWZTyqrhR
 iDTzsWr2ekRF8BhHTc1AVEsctm01YnKylMY7u3VC0NQdZOnXksbyAhw9lm+xju4002IO/W4/gN7
 Sv7S83bxVa0Q3RIxYsYot7zjDWeZCAtdqvLq9HEDVIaauc6nUGqxo0mmfCfSpcYomFUb03UU=
X-Gm-Gg: AR+sD13uMmsQZHIAwds7itctonfxf72wA1S2HU2OwbguVpEATUXSl9lVUcvelsc/M4s
 ZLOYIZL3usroC6fmUG9O7z9H4s74mpuBZlYdtgN5dBFXf4dlsuvosHy6RBK/UbOe49qk6hvh3AX
 ZQulzZ5/YP/r3vF9TS+lK+3TbFwIIRpLnxhs04RuEwD1rky6KwWGMyYfezj6kucb7s+kfNATs/R
 WJSi/Iim1YUgB48UxEP8skQWtWRvQV/xEWH9O5oHfCW51uE2bSNM5GGax2vQygIZrK952kyNkav
 fzHsmgctmbk44CZpTO0QHHXrYEbNcBHbKZX2DpPXZorzZEqjsApekdNpi7W71u0IAlejB2L/N3Z
 9bEUbOooIJApYXWsqFbIxCofFMFGjmxHu3k5mInlOH+ME54MAAIXmYdECEPSc4Q2boO6gjsAU8X
 2Q6iWXaRYmNQVNc2nPItiz
X-Received: by 2002:a05:6830:6d50:b0:7f6:6618:e558 with SMTP id
 46e09a7af769-7f7812824a8mr2753208a34.2.1788359967306; 
 Wed, 02 Sep 2026 07:39:27 -0700 (PDT)
X-Received: by 2002:a05:6830:6d50:b0:7f6:6618:e558 with SMTP id
 46e09a7af769-7f7812824a8mr2753170a34.2.1788359966746; 
 Wed, 02 Sep 2026 07:39:26 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f74caadea3sm2318459a34.5.2026.09.02.07.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:39:26 -0700 (PDT)
Date: Wed, 2 Sep 2026 20:09:17 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH v3 2/2] drm/panel: simple: Add BOE DV215FHM-R01 panel
Message-ID: <apg1FV3HtU0c+hVF@hu-vishsain-blr.qualcomm.com>
References: <20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com>
 <20260814-b4-lvds-panel-doc-v3-2-1ad152a4d3ec@oss.qualcomm.com>
 <1021133b-454a-4f49-965b-a71e065e556f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1021133b-454a-4f49-965b-a71e065e556f@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOSBTYWx0ZWRfX0eqYmrHm6M/c
 5RiSai3JZlgdQ7WYb4EGrLpt9jGs2I5h+BaX8bsUUrlA/jmOkaA1YnqvmreHTTkOACShtkcOu+n
 z2XYMrG5telVvqlFfuWrg1xVv/Z8dAU=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a983520 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=F1Ix_FWfVmdgE0jxJrQA:9 a=CjuIK1q_8ugA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eL3z82VIe3KoLzAVow5-p4Y9wK9ZSxCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOSBTYWx0ZWRfXzVyIgmoUQUkY
 Js9rMTMyKpRTHMEA0eJ6BG/Pbbm3ZCbwzuQuB3YCiBJZK6dHX0S3Ul/0FwjHs9PtRIWwuS5cI42
 1kevwyHtTlKdoUHrn+O6pKY5SupCN3ME+SeuZEFiNBUJrpXtC8KoIhtbae0xv+9r+03Wae/fMFH
 s8XAnhng8hWW3E2b7OJpgtyf7YWHEEV6ffg/Vdh7V3yC7H6Xfv7vyXersL1CKhykWHd9G9MBvHN
 1XkeJnX8UaljRUCj2/1Q9ekjFsT20jVnQ5JVFn9XAWAOwe8LdiHtFWUs4JdiO/montDOCZxyXGq
 Ar0sIloldnD6VLTyrne5DRH1KGxXRdOcHc+OoUaVLxlAuFFZCz/zavVHKIPFtV7lxmoGD20W7BP
 mrJEXlPpYfNrb5WLW41u/VpP+6nZwTxO7jH/sUgnq/QTfvqGZgL4F6Ho5eCZdO+MmCC4xqIXDkE
 DpOo0yeU4cGQMijsbtA==
X-Proofpoint-ORIG-GUID: eL3z82VIe3KoLzAVow5-p4Y9wK9ZSxCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020129
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

On Wed, Aug 26, 2026 at 12:01:17PM +0200, Neil Armstrong wrote:
> On 8/14/26 07:25, Vishnu Saini wrote:
> > Add the BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel
> > LVDS panel.
> > 
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > ---
> >   drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 5c169fdf265c..d95f842c8980 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1563,6 +1563,31 @@ static const struct panel_desc boe_bp101wx1_100 = {
> >   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> >   };
> > +static const struct display_timing boe_dv215fhm_r01_timing = {
> > +	.pixelclock = { 148500000, 148500000, 148500000 },
> > +	.hactive = { 1920, 1920, 1920 },
> > +	.hfront_porch = { 88, 88, 88 },
> > +	.hback_porch = { 148, 148, 148 },
> > +	.hsync_len = { 44, 44, 44 },
> > +	.vactive = { 1080, 1080, 1080 },
> > +	.vfront_porch = { 4, 4, 4 },
> > +	.vback_porch = { 36, 36, 36 },
> > +	.vsync_len = { 5, 5, 5 },
> > +	.flags = DISPLAY_FLAGS_DE_HIGH,
> > +};
> > +
> > +static const struct panel_desc boe_dv215fhm_r01 = {
> > +	.timings = &boe_dv215fhm_r01_timing,
> > +	.num_timings = 1,
> > +	.bpc = 8,
> > +	.size = {
> > +		.width = 476,
> > +		.height = 268,
> > +	},
> > +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> > +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> > +};
> > +
> >   static const struct display_timing boe_ev121wxm_n10_1850_timing = {
> >   	.pixelclock = { 69922000, 71000000, 72293000 },
> >   	.hactive = { 1280, 1280, 1280 },
> > @@ -5726,6 +5751,9 @@ static const struct of_device_id platform_of_match[] = {
> >   	}, {
> >   		.compatible = "boe,bp101wx1-100",
> >   		.data = &boe_bp101wx1_100,
> > +	}, {
> > +		.compatible = "boe,dv215fhm-r01",
> > +		.data = &boe_dv215fhm_r01,
> >   	}, {
> >   		.compatible = "boe,ev121wxm-n10-1850",
> >   		.data = &boe_ev121wxm_n10_1850,
> > 
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thank you, will rebase it and submit next revision. 
> Thanks,
> Neil
