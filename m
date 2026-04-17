Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8707AF99C69
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44CA10EAE0;
	Fri, 17 Apr 2026 23:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALJFQ8Px";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jk0SeJOB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58F410EAE0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:20:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG45JT1889583
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rOTiF5lTGA4FT5fQylrnrxM/
 /wpH/KUIU4VmY7gWHfY=; b=ALJFQ8Pxt2+WGag4npG0MsQRedtQk2MVfdO5tzlN
 Os2FIHoV4Hvb9kVFdxtZlKtjSiwviZy+AX8XyMk6bJCv1V1j2zMCVgOP98AfIYts
 PuIfLh+0AU7RUfZUN3CJWRgp2LUvz+6Y+MpZU5mXV1BB1dnbnvDGFGCUUOG1pTbU
 ULLOSYen8yPBFnTWDW5CoJXt6OyeHQxnuRYmBRDe7qYHDx9vGUEE8N2GZPy1wdHA
 JH6w+Ec+kdleh1L4QS7wgiR0+09o2+keNf5dYKUUXIzNIUfrFlDPCPr0LN6WGI2R
 H8dRqNZEDWaHbs6B6d34RX2Uk/oI4485wm/BidngqXIghA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkjhdtd5y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:20:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4987c698so33636361cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776468039; x=1777072839;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rOTiF5lTGA4FT5fQylrnrxM//wpH/KUIU4VmY7gWHfY=;
 b=jk0SeJOBUUfeLtxV4U221rbwMoSGFTcNf/sWIgGkCJ57NB1M6VAyo2WzMBay60V1z7
 YDTUiklxPVkHA3QoWFxQ6aTCNUV3kd3w20r2IPRlfR4vnJreamL75gi5uHkP8fwzOk5O
 e8yRRnQLLr4OADhluEbmH66iozJ9+OUZHMX8iun2kwYgZJ3+m4AhyQOeZa549wTCmJYA
 Z2geULbB3LwZxzC8+E6qn4barhyQ8ueJUi+2RtPK44Y/aXWdicvu76BIXSqrkMVhuFMk
 eEhTymw6DlkVn2PAtuoaceW7UZi24670IahEkLcGBxAFOJC3M2B0HmfdSaYBiUyr/oXC
 1NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776468039; x=1777072839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOTiF5lTGA4FT5fQylrnrxM//wpH/KUIU4VmY7gWHfY=;
 b=pfQdzeD9BMumqBV4ReWxeiY1nixbRQ7PmujOFRBFQFIK3S9s+q1O7GRsfKG44K3czx
 eltsavPKkRqGHG6oh4MMd4m3GF4vaT22LRbACBgnJENKiMbfC5i/NxMnNay+bv+ZenSC
 qBFJCks+dG80CJjXd98p9sxZCdFqAVQ02Qo0WakcDvPuVQhMKOJFBUvBz2JGIPGM1Qjh
 WBskCDjXkZkbMYHLyL2ZYVQrIlwn0HTXu8ArkOAs1ASPXI3e1A8pgRZVcyAReM5pCTJ6
 Rcx4VNX1oaT22ZdNXQ+VU0qnZmFbcI53/rxHWdrIBh34PzKbkFMu/l8dQsInsUCGmXw3
 BnsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SlLpk8dGKBT6lf0Ah6ZM61+th7JDgSyyLinA4WELyXF7/BHdqoT+cXUzUiKG8fe/ydTMaz1S8Nqk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweveJWpIQs6/sr3AIv4mVNDutk/495Gi3MwCDvpd1OEhUdnTpS
 0ANUeF2VFZtDPRm6eBkPG0ouoRAYeVfQAc2SkhPzRXQ140PwDTRcLi0/8Widx5xHsvSQh0sqi+y
 XWLocWCSzTn8IvFqCMjbllifIRl9BEXlfoBb8JzchMpC2spK0afmBUVKUT+EVP9VvuHx+hh8=
X-Gm-Gg: AeBDievHWUkElr4p6O4UgRBt3ACaM0wtReKHGomC9o2zop6EOmoqAwl0meUm/h285qJ
 ZLwdTq7FkW6KcCcKv+LSPr4EoUM1vsx+uNTbcBJ8Ihr1PLqVl/Wqb+0s67p2bGbZkY9AiUO/c3H
 IlBOrXwswaZi/I+Z4ntYCwOp2OIRf2WdCNC/w1pk4lmA6UJyT44C9yQFhDFC880YCCAFEjEuXqN
 t+ykTlCltb3DCVbOFC7jOlcjTWx2FCx+A4cA+kEEfuQOUWh27TJVy+nQhcWt/LK2gelYMyP7AVn
 UEt+Qg8mvuloBnLG9m84z+gpMmMNCya120FwTq4isRWikOqGjUcml5KB20mewES0AYlYQlg7MZy
 EB2C1cSlgNfpHKKryhVQGUgv/h0TRxKt6amOuMGdrbf7ts77KarfD0nGs5lrDir4lFf6SEmP4Ky
 MSJ7tTjnKM4AzO3JmTMPUhj4zNdRnkW26aJibTYYBX5Yz/KA==
X-Received: by 2002:ac8:5988:0:b0:50d:9cfd:b01f with SMTP id
 d75a77b69052e-50e367967e3mr61735931cf.32.1776468039384; 
 Fri, 17 Apr 2026 16:20:39 -0700 (PDT)
X-Received: by 2002:ac8:5988:0:b0:50d:9cfd:b01f with SMTP id
 d75a77b69052e-50e367967e3mr61735601cf.32.1776468038952; 
 Fri, 17 Apr 2026 16:20:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad0d0sm807803e87.5.2026.04.17.16.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:20:37 -0700 (PDT)
Date: Sat, 18 Apr 2026 02:20:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/41] drm: renesas: shmobile: remove now-redundant call
 to drm_connector_attach_encoder()
Message-ID: <e2uauqnkpsj2c2tgwp7tzzzrrq7qqg3or5asyqkainsgbxkfvg@k3n7u66hekhi>
References: <20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com>
 <20260417-drm-bridge-connector-attach_encoder-v1-41-67b8b8fb872a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-drm-bridge-connector-attach_encoder-v1-41-67b8b8fb872a@bootlin.com>
X-Proofpoint-GUID: CTG3NWSfJ080KP-8i0llLDXWsjrw9J0c
X-Authority-Analysis: v=2.4 cv=YpQ/gYYX c=1 sm=1 tr=0 ts=69e2c048 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=P-IC7800AAAA:8
 a=aULfUxahtjAtnqWKHEYA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMSBTYWx0ZWRfX0YrYs4NhWukM
 Hx6h+ii4KPnuelUcQkQb9UuPOL96WPEN5lfyncI2LbX+oIofuFaawDESL5fd0WhBrjwXJMZc2lo
 0lMkW/cAMpHVVSBr2PkWTPHyG642V0knogF7Mnak8KNgGYQG5DkiY36+EMk/pgskACqkMjv56tZ
 OHSngvTgxlJgwU9DMqzHZdZZGPEUIJ2PHGkE82nn8m1ZCSWxXS9vmfRaiT9glnFTpc/W4i7jaey
 KBhshHE+dqi9DI5Ev4KR280fu2fFv9nIZtC3UmFhlNvDJ+Z7hQ5hhivKYcWkMYzSU+0hcljJX+R
 2KEB105lmv9dDFCwtCJd8ZqgpYyqMxt9l00il/okFuU+AVQOMZ5dKgcpHRudETkjOxvG78v1SPd
 5oRUaeyNp/0GW3tXOJIVqaFeuHui3fxbiUN6wPu2Z42ZwqilqpY7GFnzg6M2sUZAnG3vBl3XXNx
 yEQ+ZpWDdLovj2NVm4A==
X-Proofpoint-ORIG-GUID: CTG3NWSfJ080KP-8i0llLDXWsjrw9J0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170231
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

On Fri, Apr 17, 2026 at 11:58:29AM +0200, Luca Ceresoli wrote:
> drm_connector_attach_encoder() is now called by
> drm_bridge_connector_init().
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 5f460b38596c..866afe805e6f 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -596,20 +596,21 @@ int shmob_drm_connector_create(struct shmob_drm_device *sdev,
>  	struct drm_connector *connector;
>  	int ret;
>  
> -	if (sdev->pdata)
> +	if (sdev->pdata) {
>  		connector = shmob_drm_connector_init(sdev, encoder);
> -	else
> +
> +		ret = drm_connector_attach_encoder(connector, encoder);

Here you are passing a potentially error cookie to the function which
doesn't check for IS_ERR(connector). So, you've hidden a nice crash
here.

All other patches LGTM.

> +		if (ret < 0)
> +			goto error;
> +	} else {
>  		connector = drm_bridge_connector_init(&sdev->ddev, encoder);
> +	}
>  	if (IS_ERR(connector)) {
>  		dev_err(sdev->dev, "failed to created connector: %pe\n",
>  			connector);
>  		return PTR_ERR(connector);
>  	}
>  
> -	ret = drm_connector_attach_encoder(connector, encoder);
> -	if (ret < 0)
> -		goto error;
> -
>  	connector->dpms = DRM_MODE_DPMS_OFF;
>  
>  	sdev->connector = connector;
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
