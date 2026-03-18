Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ACA103E197
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA4E10E853;
	Wed, 18 Mar 2026 15:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H552eyIz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XyhPD8sd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395E110E853
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:22:39 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IBBEcE320243
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TVdDNl7utYQzDuF/D4cXEr8N
 Ly17OKb5bR2C0gm45yQ=; b=H552eyIzwClHoMSXdS4dZROlKRAFABu6mDW3q4NE
 JfpSEvR6jBLYmFDCzFZBkIKDQY06se4NkxdGBp8gidOAAp8/uX2S3g22zhCw5SS+
 7CzhainbGvV8wgAJCj8hi4GKKIED9txtGqlc+G4hOUTWEckAMrKAGmRiAjciAAbw
 L0b7WeIThpQFARCyRzxeDSqzRrbX5s/7WJ4OZ2chi4amTreRfwe2QbabRwZ244Xk
 4IbSv7SVmCRvxC7ngsaFj03CdX3HH9X9PbgBFa4h0B80RiWKq+IXkRTdxWnoHA3e
 MpY7jct4voW8YnqwQPkZW63h1YQVcQCcSi2Kd/eGJ11vzg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cytxyruwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:22:38 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-5ff9edc2158so8584009137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773847358; x=1774452158;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TVdDNl7utYQzDuF/D4cXEr8NLy17OKb5bR2C0gm45yQ=;
 b=XyhPD8sdBJEQ1WnVqImnAPf674bG6unIaaLRffy9w4KPRddRrtHZlWR1OvAO0YSLLn
 PJIyLYW18RzFIDyib8djGpv7tVE/c9QWhPBO90UsfNawyBnrfQikmtxzCrBBiqA7iBjG
 BQVDd3Sdf2x1WhveKRd3dYwFTfxvvOeUmELnGfhBPx8jM2fY5panbICsKZnS4H0DMtYZ
 a6pVk7dzYiFjA8Lr2mIz8DCdo9Ls4Dh8GB8a12wfp8S6ZZ3ga9i0YBgLeS9pwtD6V688
 Ju4p2QdMTyIKriB1vdL9/BsxXCIXJv01vmjwg3+T9lQxtgqNaVluBVibjU9qZSr8RfPr
 A1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773847358; x=1774452158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVdDNl7utYQzDuF/D4cXEr8NLy17OKb5bR2C0gm45yQ=;
 b=Ry5wYucUOy2cnzPUDEDKihy4PdbLQh76fE9D6KRmpMa1/NPATYx/R5d5Cq/Z7SFKqk
 WS6J/NU/q/knc5s9RDd2DstHen4x5GJ01RYXANpZGd271wA/JMDwWv6s/z01cdZMed3x
 hqp2Y1slpv0CnOb+681jUT4EoTiZHRwXO9IoRuE1O80tVr0rQz8NlOqJZCw9rNCsvkke
 lPH2v399BslorxZiT7FD3cnGZ7n5/h2pItSTf1pKXSefptevkXe57fha7NALyG6x7f5w
 8MG4mvjv4/tAbm355tXpIjHdIfMec2VaanDduBHylUvY1RU7mb4VaJ5Aa0vzlqFwyV+1
 lxDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhchkojiDm5NT/cjKfQJsDvKojGg/zLiPQsZ4svKZd4bQ3qzLjGrTlBa7gxydKY9ZcM0kS1lbFZKY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxe3GpYRmt+Qv8GYD6JsTNRC2fh3cksuZCoMjzCZNWgwPoW0Mub
 Tlmc5mtCnpc+RO8iNzzBmp4wxpetx/9tb38jqjzcrxwsrNL9wTP6LInpzTkpQerr5Gz0OSu5HXR
 JzqmJe/0MGXBS1gibBWxKXSrZ29U1eD1kw+aaN8KZYxL4i7UgC0KbI9C7OQHMM6AYzbGZeU8=
X-Gm-Gg: ATEYQzyvREqQGgAHqe1ee5xTmjwTRxhTEvj/56HfX1PwleKOmB2NbbbXwxaTG7lKYu8
 QgJ+yoif/OX+65NCqluiFZfkiwr+Q0ljPsiwsjFhUkU5wbJNMF8dwb3Q6t5CH57hLgb0O28e8Wi
 3Uyk4icu0k9o3hJQQGHLCqrE6RbRB762g1g1EoXbrkoawoulyt2UENfyabMviPI1gYri/zTFC04
 BhZ/Cgk5dNMfZ6KOGaviyJvYArwhQ7mwOwTjgXPGPiAHg7Gk6QWdIo0ucseeActDF/kYxWZr1+d
 SRRa1OmAWc+/H0rWPSCmGZhgdlvvTsN1N3XHBNLe7ntHH2/CUqGn8DnRDDccYHRhvCi4NfUfh6g
 2U1Ebjtl3w7Pak96MZSPEfyxqurDwBtfioxx+RlyU0iEY7X2w3STFzefSoCl8Dee688c7xdgWRh
 nMvfaDwlwHHvunT+EiDWMFG5iskVC/SFLo+8E=
X-Received: by 2002:a05:6102:38cc:b0:5ff:a4e0:1939 with SMTP id
 ada2fe7eead31-6027d0ba547mr1779217137.7.1773847357421; 
 Wed, 18 Mar 2026 08:22:37 -0700 (PDT)
X-Received: by 2002:a05:6102:38cc:b0:5ff:a4e0:1939 with SMTP id
 ada2fe7eead31-6027d0ba547mr1779205137.7.1773847356937; 
 Wed, 18 Mar 2026 08:22:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd54bd181sm7039781fa.32.2026.03.18.08.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:22:35 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:22:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/msm/dsi: Add support for RGB101010 pixel format
Message-ID: <dnpjpeof2qtccxibdnxy6lzg7tf2tlxxxmrkpezsx6wt2d6jal@q35jgeypeudd>
References: <20260318-dsi-rgb101010-support-v1-0-6021eb79e796@pm.me>
 <20260318-dsi-rgb101010-support-v1-2-6021eb79e796@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dsi-rgb101010-support-v1-2-6021eb79e796@pm.me>
X-Proofpoint-GUID: SoIKY8ygEfYZyW9ErXGpO2NkZydV3o6z
X-Authority-Analysis: v=2.4 cv=FKAWBuos c=1 sm=1 tr=0 ts=69bac33e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=Bu1RyOF3CJazrzOdyIIA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzMSBTYWx0ZWRfX2ia1gKA7Icy9
 124Q+Y8JdQOxjq5yQbxc7jgnmekMDfQ3Va6nIfWobVNlSK7QYtRME4Uhzayh9kB+wkI/NEMGf6j
 IMdUprf2VfhAdIAVbcP3g6K9gQHlUdKtW65Rm/8juGoDS32+YTlWUlwZ8YBCxCv6r5F5aqmoJQI
 9j5RaD5+8yYIMtmNwTEIe64P0TMgBOCkEpZYV5YibcU75ulkEU42O9pysNYpSIZLkCkLSHXfow+
 fSOXJgMtHLOspBQtSdVwUc7c8Q/cIS/A0HwQiooek68LD/+zOP58kFJnQujOBtTZGuIkKmKm7tt
 j7Qrdl4/vv+9uY9cdVQCMwmciJQzm/8i6gUbLG+eon6/Z/Mf3aYUVOP/WRB2OzdMPtdXKu4H3t4
 gk/n9jtvXwD7rxbq3ntrfgRr2B/dru/so73oBwAQ0HwruP28GpsopR5N9jkIf8Y+Ft8/jsbogmf
 rd2e+K0rczYJqqP+y2Q==
X-Proofpoint-ORIG-GUID: SoIKY8ygEfYZyW9ErXGpO2NkZydV3o6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180131
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

On Wed, Mar 18, 2026 at 09:41:05AM +0000, Alexander Koskovich wrote:
> Add video and command mode destination format mappings for
> RGB101010, and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits
> to accommodate the new format value.

It's only available since DSI 6G 2.1.0. Could you please add the
corresponding check (I think having something like .has_rgb30 as a part
of struct msm_dsi_config is a good enough approach).

> 
> Required for 10 bit panels such as the BOE BF068MWM-TD0.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c            | 2 ++
>  drivers/gpu/drm/msm/registers/display/dsi.xml | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index db6da99375a1..3e3d61b9390f 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -757,6 +757,7 @@ static inline enum dsi_vid_dst_format
>  dsi_get_vid_fmt(const enum mipi_dsi_pixel_format mipi_fmt)
>  {
>  	switch (mipi_fmt) {
> +	case MIPI_DSI_FMT_RGB101010:	return VID_DST_FORMAT_RGB101010;
>  	case MIPI_DSI_FMT_RGB888:	return VID_DST_FORMAT_RGB888;
>  	case MIPI_DSI_FMT_RGB666:	return VID_DST_FORMAT_RGB666_LOOSE;
>  	case MIPI_DSI_FMT_RGB666_PACKED:	return VID_DST_FORMAT_RGB666;
> @@ -769,6 +770,7 @@ static inline enum dsi_cmd_dst_format
>  dsi_get_cmd_fmt(const enum mipi_dsi_pixel_format mipi_fmt)
>  {
>  	switch (mipi_fmt) {
> +	case MIPI_DSI_FMT_RGB101010:	return CMD_DST_FORMAT_RGB101010;
>  	case MIPI_DSI_FMT_RGB888:	return CMD_DST_FORMAT_RGB888;
>  	case MIPI_DSI_FMT_RGB666_PACKED:
>  	case MIPI_DSI_FMT_RGB666:	return CMD_DST_FORMAT_RGB666;
> diff --git a/drivers/gpu/drm/msm/registers/display/dsi.xml b/drivers/gpu/drm/msm/registers/display/dsi.xml
> index c7a7b633d747..7636e9914078 100644
> --- a/drivers/gpu/drm/msm/registers/display/dsi.xml
> +++ b/drivers/gpu/drm/msm/registers/display/dsi.xml
> @@ -15,6 +15,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
>  		<value name="VID_DST_FORMAT_RGB666" value="1"/>
>  		<value name="VID_DST_FORMAT_RGB666_LOOSE" value="2"/>
>  		<value name="VID_DST_FORMAT_RGB888" value="3"/>
> +		<value name="VID_DST_FORMAT_RGB101010" value="4"/>
>  	</enum>
>  	<enum name="dsi_rgb_swap">
>  		<value name="SWAP_RGB" value="0"/>
> @@ -39,6 +40,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
>  		<value name="CMD_DST_FORMAT_RGB565" value="6"/>
>  		<value name="CMD_DST_FORMAT_RGB666" value="7"/>
>  		<value name="CMD_DST_FORMAT_RGB888" value="8"/>
> +		<value name="CMD_DST_FORMAT_RGB101010" value="9"/>
>  	</enum>
>  	<enum name="dsi_lane_swap">
>  		<value name="LANE_SWAP_0123" value="0"/>
> @@ -142,7 +144,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
>  	</reg32>
>  	<reg32 offset="0x0000c" name="VID_CFG0">
>  		<bitfield name="VIRT_CHANNEL" low="0" high="1" type="uint"/>  <!-- always zero? -->
> -		<bitfield name="DST_FORMAT" low="4" high="5" type="dsi_vid_dst_format"/>
> +		<bitfield name="DST_FORMAT" low="4" high="6" type="dsi_vid_dst_format"/>

Please comment that it had high=5 before DSI 6G 2.1.0

>  		<bitfield name="TRAFFIC_MODE" low="8" high="9" type="dsi_traffic_mode"/>
>  		<bitfield name="BLLP_POWER_STOP" pos="12" type="boolean"/>
>  		<bitfield name="EOF_BLLP_POWER_STOP" pos="15" type="boolean"/>
> 
> -- 
> 2.53.0
> 
> 

-- 
With best wishes
Dmitry
