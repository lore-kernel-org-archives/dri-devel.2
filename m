Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FC610854DB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BFD10E786;
	Wed, 18 Mar 2026 09:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k0fdbjwC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YkFxmJQl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F81D10E789
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:39:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I96Otu2296076
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NGtj5gt0oKKUD1rTumE2x6d/
 /ytfFsPqqr53mwIxXig=; b=k0fdbjwCeGqpazUS6OiQplnhyJoWwl30VNT8B/Tb
 vNwta5XUYhLGsXnNtMf8lqfMpXjD0TgzqGIB82MgwKULGP+w7D4/GSV1FnAS/dSi
 Zk0SXjhhlT9jv1OHctrsY9gjVHmm4b1w2T8jR05j39HvRP1B6U5NpgddYIwAPdCt
 7AYaVbNHEjgdw+qljzsz1EDg4ErssBV1dz4rvWxy9T8fNZuveFQ40zZY8+qiCVO3
 e0Ms/aw2hLiZreQ+ASd9gXiZuGMNyw5WBEJmTFFDKv3EFu3cV+3HRSavnh6w2ANC
 LqYHgD9qxHKA4e3z9n8GPd5iB1i7jdYv34okg1d537DBLA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cya83ur74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:39:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50920055f0aso46174481cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773826773; x=1774431573;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NGtj5gt0oKKUD1rTumE2x6d//ytfFsPqqr53mwIxXig=;
 b=YkFxmJQlOqJrfqwLco/JCfWvLTVWKWFguQtpd44P8rtgUOXUR0hyz88TXt/F3pLAU+
 ltKOPjqFyBvrjaQ9ax5cqN4+9IWk4ebvBQlhWhgajQ8xKkVtV4BTKVInO7MFuU2vNs8b
 8fU+Ism0IS7Dz+IqCMV2nue/6iAke0h7xZnmsIhA0RQXmuiIzYClm/CYk79YMF1vT70u
 2ZN5gfK9hgETr9sujieP19MGgXHHP0vuatptpyczGF8kZ3u8S1ahBdAfzcYe8PAOJux1
 l5UOfU06JznLcymT3w9kKgt71c3nSq6TvD41c0nvr+lCA5zrrRlklPOQeuUk3j4rwHdt
 q6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826773; x=1774431573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGtj5gt0oKKUD1rTumE2x6d//ytfFsPqqr53mwIxXig=;
 b=hvO05ERB5pBrlHnuzsGpsUv4qQf9RqvbAq7nFl7ZL8oi8+Byxw4YIVTw1wMl+2rTSq
 0P/c0LxBKTwIbgYgto3dZrYOHmw8P1msUi/gNuli9D1L4Ejid/xrRWLnf8VHenZ5EZqu
 CrbcpCJIoGz5W5FLfzGbHsJpkA/zrT015/u1fADEdDp8IuPAy8Su9HtIqwK/4PobpcHh
 SQwQLzJ5OW65jsQLPeymC98zOLMx+Rn2bDPMQLLwnYbwdshuIIiMDrtzL2TXcHjmHyX/
 PGYyZljEQ5Wl2pGbQfCPJYJjbeetX6Y154rcEvWMVOQVZrOaCNloxL+jeViAuuzTgIAo
 2l9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyYlWIzR13R3EKykmIkAsvKkPoR4HH+N9SuyqbpkH9981LX8EkJ8BRL+uKAPEQ4sD+/jgS+9Kt9Hk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9zK1YqnuMq95ooHHlGrF7Cz7ECJSQ6QL2UqCnQjAqYlldaL6R
 Wv8kuVq5zYYEW+ZqtxSzs+0aZ75QjHDbjOQ8jfOiLfCwohR86lU5huzcY7j3ofFj2uGiXvUdkOC
 +A3JUjoG7lX6AGu1JlTnsup/fixmJB+16rNTOK4Ky1cejEh1jJFqlScbKSnEzjCHsjN1sB/k=
X-Gm-Gg: ATEYQzzeYbfp9h3CEBICJ+/ACj12cdAITZ+YszJ/uTGtnid3UEY+EvDeWaJ8R1dM3Vn
 E1Zm5nUOphm5PAyW8/EE33kX+mnkO3uz9wQi1TB/Sc9Jc2xqV23F6jyQt5MZyt+k3xnkXFKEtgM
 HPHyBcrELPLcnWfVpI551bxlwUMuB8hXLq9PG1219Orpyc3FAoulCI1xPCVkPxiL1WwbBmNd4Dk
 SZYKPJVUOy9gTCkEFQQl8f5jnEGzYeOJZ9X7okQK3qKi/s/HcjKdUb35MqSp/J59gpkX9y4jMBM
 aTnNCuWkkyV7nnCjlXh2sEgSqxytTfBMq9Ivv60NIPAPqT8jRE2oFTyPAu50Vinqyb6EeF7lGXj
 y95Dia0Rv5LuiutqYD5nAuC0DDYxfI0UtFTwJh1c85YdlcRspfgt5Ir+fLUF0a0CRe8U4c39Gm0
 5a2tYQ1+fwY5VSbkVOK0CZfaECImVohBf93uc=
X-Received: by 2002:a05:622a:198e:b0:509:21eb:4722 with SMTP id
 d75a77b69052e-50b14916944mr26302091cf.39.1773826772504; 
 Wed, 18 Mar 2026 02:39:32 -0700 (PDT)
X-Received: by 2002:a05:622a:198e:b0:509:21eb:4722 with SMTP id
 d75a77b69052e-50b14916944mr26302001cf.39.1773826771968; 
 Wed, 18 Mar 2026 02:39:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd517e0fesm4481011fa.14.2026.03.18.02.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 02:39:30 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:39:29 +0200
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
Subject: Re: [PATCH 2/2] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <w74ctaczp3ty7wil2sfkztc6wvuppgpyff4tw4dze34irvfmlx@e5f36rzqmp6i>
References: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v1-2-1bd66b7f9e0c@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v1-2-1bd66b7f9e0c@pm.me>
X-Proofpoint-ORIG-GUID: 6ckCNHw2yujHtRPO79ydqAtWZ_uOmGxK
X-Proofpoint-GUID: 6ckCNHw2yujHtRPO79ydqAtWZ_uOmGxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA4MCBTYWx0ZWRfX+Le5zmlKHfVM
 89MqN6mSe9hwWiIyD/mbIciBzpuTpYyNS3od7enjEma/jN/tfwx1nS2pZAgmFi5cBIRAOFNRNpy
 Phs3nqVRb/KpP6yy3eGNbpnaRbrkSLOfHRYBhoMikBfPGhBij76XTHCbZHF3ICC5plAAZoFu6uj
 xOHOftGkeNsP7A2zPBKbDuqCycVf5ZxXP7CbILoMgQFYjmsUcg/8OUWsezIvi2pM8tS0JlmWyVZ
 lGemYR1lbptOHpaPnBJtUl/P5M7VVW8Xpo3o2oZ3BcvuUdpX/v9sk1McGpRi09LNo7YolE511zi
 rJ1bUv9IRbfg/thWLZJwUQ6MUXfEcn7NOrYH8rMKmE+kP43sxeKNlJuavbC6HeHptbHI9O7erLm
 5CH5ybSaEOdhO3ImJSzkTSnIDpwd7VfUZ4bXAArFvPOeVT7xQ+UxKviDDJocBPFNLao+RA9SHO9
 2YT+zft5Hc/JhRE1wDA==
X-Authority-Analysis: v=2.4 cv=Y8n1cxeN c=1 sm=1 tr=0 ts=69ba72d5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=RAbU-raeAAAA:8 a=Q6o_JRKf7zH18ftsKlAA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180080
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

On Wed, Mar 18, 2026 at 07:33:03AM +0000, Alexander Koskovich wrote:
> Some panels support multiple slice to be sent in a single DSC packet and
> this feature is a must for specific panels, such as the JDI LPM026M648C.
> 
> Use the MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag to derive slice_per_pkt
> from slice_count, note that most panels are expected to just work with
> just one slice per packet.
> 
> This change was originally authored by Jonathan Marek:
> https://lore.kernel.org/all/20231114174218.19765-3-jonathan@marek.ca

This is a wrong way to give attribution. Either please retain the author
and Jonathan's SoB or use Co-developed-by and still Jonathan's SoB.

The patch looks good to me.

> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 

-- 
With best wishes
Dmitry
