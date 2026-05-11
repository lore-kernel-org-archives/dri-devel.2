Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF2CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 19:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA4D10E57F;
	Mon, 11 May 2026 19:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1MrYHlc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gwSBsf47";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2027E10E57F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 19:38:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BDQNB9453358
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 19:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qEUadrYYD3NO3KbmiC7HNGDA
 adVJC90gp6VqwRYpT80=; b=Z1MrYHlctUgKa3Ec/J8ccxp+NMvokOd1Fj8MIEgs
 myKOrGm4YoMCA5gvUUBLtKz0wbLCz0swgaKzoQDL5uxFaT6aaYJK//CWUIigHD1z
 gOrvPakN9AO5QCvDA3yR9DGSzxDrKZelLjdAeu+G4Ag0PjXRfI5j4UjTgl/cctb4
 y2KmRX7/mU+D61jNupoE4iEFBlA8GKlyDe1BZFYJZtIHvKfJ/t6WSdm39sGdfAqQ
 4qq82G8MBdWar3Pcvc8rYtAiF86Txiv4tGCfaSts3ppM40KJYhhrwiMI+K1UVbpW
 gl67DCoWnl52JDJTqMpve5Ov8U0fI36+HZt+a0yRWOq//w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6k0ke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 19:38:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d9a6a853bso85429821cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778528292; x=1779133092;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qEUadrYYD3NO3KbmiC7HNGDAadVJC90gp6VqwRYpT80=;
 b=gwSBsf47xN+YPFG8fZhY6hLBblhUXNO9K/zMfcpBdaSGcyFKjCbZTr9ZAkvT6E6cHQ
 jLD1t+Gay5hhGbBx7jpYGH30/OfKaw5N5d28PWQnF+GpbrV1cUFtN/ehCGA9f8DMXI/s
 gptFshIolPkJiAaefG6bU3Ctkec+Htit6DYd4d8lfzp4ZgSr6xDuLQBXoMg93NDfNjMh
 3nT89DE248aIqPf2Apgqo9+MzKaKz4FEk9lWSckrBwIP3iIvNnGauxQdQBgqzoTIqv3O
 wsoce/UXxNUU4azZYAc7jxSf3vn4a+XZn8wDO82CBVO18bqc6rqrBbflDqqZ8khYGace
 Lwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778528292; x=1779133092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEUadrYYD3NO3KbmiC7HNGDAadVJC90gp6VqwRYpT80=;
 b=BzmzO9dPslKVYVV/5FB6eXCzChkylZVNQP1XV++PppKtG4eEMlDQUB8jyaKmZOMff/
 epkp8XQFD1U5K+hc9bBoMuxOAAe534h0L+qpMnUjfkH48S3unYCP9F95uVCJ8gmXY6iy
 JeM/9pdepWj+GSCdoBfCO5xqCdEb7z/t0igkE8Lx88l7ryfT7f/JiE2cFLwaW+QELlNt
 lg9VFwONczQhv4dmQZFypdF/hgShElh+T3VP2KBMoCNE0v52+40/mPj5g8uEv6NjFxTq
 DAVX3FlwT3pNdflm7hmidR8TXR+1K0mt7DoMvJfRd+O8WCFjmc0HvSc2sV4YMg653Fn1
 GuRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QwkvdWF4qtQN7NdYibo6z4GOjCJXuUaNcACCRT3f6ExokypeJf+If0cVVM7cDoofokSTxOKWUM2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYYmTMJYxZxTFvCG2Ph4nEgOtmBUSfWWRpte8qlwj88GdUgnWE
 yTbC4ndBCx2gQWv86g8A05n91hjdp1RCe16B53cCgRz0PstqyUGFzvSy9kOqXtaz9RgF3UwzaBY
 yo5IHvdWYDBax6OVsTG4g5gVPLzE8okR0SRx3nWSeymlTNFl05ljpul1GpiXMgAaj2xrCLvY=
X-Gm-Gg: Acq92OH0LEmqC4RRTW2DYHynYQYAiYH6CQhGJoQkc/FPzn1rxx17wV3VLT/matuVRhd
 GVDlovDl1wehcn26txos0lV7elBdlYi7e+6VeYQMyACTvFV8smmmoBIJ0DcyFCOVy3FVoQMFXw/
 H5bLGgbG3DM1yDkkLsRCzkhIbGZ7Srl+NDzICI+TldPKqFLt5aSPm40Yuhi9KoR6e+NrZSg/JgV
 yLz4jT58OBPC1Fk7vuirDwj5u/Gr9kH3nSFk15/np8USjrZjBFjndEhetyQx8mSc6SG155RZkym
 vkDgNK5aai04RFurgZ3k8kI5mxC2wyG2OvYWF9yBiLNW+rq/n0x3dWfl/2bcOK9vyFwMwmpoGsM
 D5GeZY+0sZw9VHkW9xpxr2kMwR99/CqUE/UyNR3TCye93o4Z07s8D3K3E+pY9K9FAWAnPv5ADm6
 sXaeFiJRp/8zN1QapTNZPPL2ZbhywqjQSlmLA=
X-Received: by 2002:a05:622a:15c5:b0:50d:83e0:3216 with SMTP id
 d75a77b69052e-514a0b8e93dmr166046281cf.49.1778528291959; 
 Mon, 11 May 2026 12:38:11 -0700 (PDT)
X-Received: by 2002:a05:622a:15c5:b0:50d:83e0:3216 with SMTP id
 d75a77b69052e-514a0b8e93dmr166045761cf.49.1778528291366; 
 Mon, 11 May 2026 12:38:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8c66facc2sm1374275e87.22.2026.05.11.12.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 12:38:10 -0700 (PDT)
Date: Mon, 11 May 2026 22:38:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/8] drm/panel-edp: Add panel for Surface Pro 12in
Message-ID: <cqvo676xianuevg426nmawttqkrxs3lzubftb433daujuyoqey@zzfmois6njiz>
References: <cover.1778498477.git.harrison.vanderbyl@gmail.com>
 <44d976999b592fb4993bd95238e56cc4d9e228f7.1778498477.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d976999b592fb4993bd95238e56cc4d9e228f7.1778498477.git.harrison.vanderbyl@gmail.com>
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a023024 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=qSFih8ieVIkKGe2oThUA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIwOCBTYWx0ZWRfXyCmla495XzQy
 8VzW4/galdKPHR6k6QzEGsTPnG/83bjVh14rnpX8LAZXQGecMky3E+/zigWixhThHBPnXspFwv/
 H9/2p4sWcBx1bCV6VLOJfkV9IPsDQ/wErsEBTBx5b8ZxP9Ub7ow8JV+ax2yc29CAze4ZK4k8Vpk
 5ez5JNufFWKJagSMAOy2WoOT3MON8fnUeH5itMATBKWY6sQQIhQ4Gk/yniLdhGp2ixs5sQ50KRX
 V80jqQZummvmcxeds0yLVEu53FGSi7+D+bh3Nu/WKSHno3g47gAl0HsLXEdO/T/XOxwXQWr752I
 5p1ERyVIKiLvALTSqpK4IReQlVubnfTDCrBwcClxLecKJJ5onlcmEhV1fZk8sxQGMArJ7WyLMhR
 sbzAYiZQNx82Sm/G3eeeabIUFJSJ+SMyYG0k2IjzWDV6c6RuZquUzKWc/mMSiQWlZUVNcdanvZL
 94Uo5d+UOxX52FKPWfg==
X-Proofpoint-GUID: vzgkfTVeNHRHIQNMd4Ii5F5SbE3kSPBj
X-Proofpoint-ORIG-GUID: vzgkfTVeNHRHIQNMd4Ii5F5SbE3kSPBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110208
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

On Tue, May 12, 2026 at 12:40:55AM +1000, Harrison Vanderbyl wrote:
> Add an entry for the BOE NE120DRM-N28 panel,
> used in the Microsoft Surface Pro 12-inch.
> 
> The values chosen were tested to be working fine
> for wake from sleep and hibernation.

Could you please include panel's EDID in the commit message (see how
other panels are added to panel-edp.c)

> 
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 497dcd48f57b..2cf52f03c217 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2020,6 +2020,7 @@ static const struct edp_panel_entry edp_panels[] = {
>  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c26, &delay_200_500_p2e200, "NV140WUM-T08"),
>  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
>  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
> +	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cc9, &delay_200_500_e50, "NE120DRM-N28"),
>  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf2, &delay_200_500_e200, "NV156FHM-N4S"),
>  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e200_d100, "NV140WUM-N64"),
>  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
