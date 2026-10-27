Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C360A261F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d8A1SGU/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hPFDUpRY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD79710F404;
	Tue, 27 Oct 2026 11:38:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C1010F404
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:38:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAdsM81921591
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=t8KeJqXYQPr8zutUgjnJ6yEQ
 LnjHNNZkSiiSYzj+XfU=; b=d8A1SGU/3lNieXhNKzh78QX8sIvtyhoggCDvkjo2
 ZooNqFjFtRxIPsA+xBHGhEwUfOys1kTG07Iff1x+bBTZFVWToPjzxT9N8EnOkrNx
 IEGxQb2KI8RaKfi6IZ19cdymyNOTdoCHQeQYQLCMNTK9oZwDvYY148nlQMyElYrH
 nDvOEUPoI5cM1gKNxhj7N7mZKOPMRLIrN6j0HBwaYQi86++6BI0mVQNoQLmdXzQ9
 wKMW0uM4oJNn608zdT4wH+3YUkoQIer3xZf8YVZLZru2N3Hx6hdqAnijFoHnd9sT
 w6PcNVLoGn9P/kyfRan8jZasQplHO5ZXeiRXOVeR9WFG9Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq68nn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:38:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98bcae867a1so1202812241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793101125; x=1793705925;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t8KeJqXYQPr8zutUgjnJ6yEQLnjHNNZkSiiSYzj+XfU=;
 b=hPFDUpRYcaIsIgXKmAQNiM+H5Wshmzrjcte9WoK/Ck3lbB7Y1Acv/aNZ6VHVdKe9jj
 0jM54i+8VZDkcwPiFwNC33/yQ9GHdgs3ijzT0eJkWxgFvuVdHmdibAT/gnadd+vuPAl9
 RKu0K2zmxKea5BCkRWQuijTQ3bOvOrSwRLKyb07qaKd1ec77Z1N6kwB6f1jD+6Nhp94x
 l/YTrjNA2IW/joATYkuJXxF+prX8efhANwbbIi/VmdFqHBBMRNH1wFc06bGYPtI9kNAv
 foZPUtf8Q+hZB3jvufvYP3AuW9erWnvCKldI2LDK9DP9Cj9XVaqw6k3fINBcBysYhq6M
 if6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101125; x=1793705925;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t8KeJqXYQPr8zutUgjnJ6yEQLnjHNNZkSiiSYzj+XfU=;
 b=vPj52Q+MPpyk/6M4KRkDHOlneESxPv8gZ2fshveFA7FJVOdoSog611pxT0SwV2FGJS
 o8LqMk4SZL2y9B8rAwrj93IeNm0XgJ8jZmfA8XMFA1s/g3lowjSCgy5epGLyHTdJD5OZ
 vjnbAHp04VrxVIFhQ610iBC7C5aeXoELBK/YewujGLsxNRA8IQakjocmqbRhLeN8qJjy
 aQARZSJ0XV9+0n3cDJhmhf+siNzTz4g+qUERJYr6oAJqPNK3Af+7JMOgwWC4p3XGqQXd
 v4exssSalNBntx08yjrPy6Pt7eBabXI7dCyOtYfGAq29JEJATaZrUxWNPATBC0g1aOhD
 59xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJu27faXGyytaOyICiMthRg7ucjYpr+14MsuMgTNYuKPzIVPUqdG2okd4hhrUnVjnI5dGDjPNvKsM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIzWENqELYodm3H9wbMrEE8aXTaDlgVyMttUSeairzNEstw4eJJ
 HWp4bUSXeEBkd6g8RXZwPkeFnf6wOZdiYj93rgYsUqPem5Q+fzP0bct348uYUmWxlhFZs0ea6mg
 5sQRzrWLRtmWwRcJA+QJAHb/JAataOTQL02aHben+A0cNjYZ/U1yAlCttnqtM4qvCO82vQ2M=
X-Gm-Gg: AYBFou2/oW46ptCiFdS8wTjd3pUYMDNABQ+U0Phq945p3UP55Dxk+g7jrEqkIiROb+y
 owcHTEw94ejpNYTdwXwRjKKj6poliGKkcOBUeeGNptjsS5ReIBnl+BmsEfIVLQyc1k/ta9pI1H4
 rFWsW3DdZgdS35RZMiqiJNqale65of9dyB5f6TD6JuHHUv/NOGlKlak4IBXKEjT2n2mmWXavZGp
 +ek62JFJfo+QdjS2Dbi27rFFz+iP7PkDhgMo8hhh4eYwCReqiniS2nJA1/RPnVSECq2MUki0gfj
 bh8j86J+6+gsEFoatoCv93bj0TqUd7j5n0AH34PNR+wgyedbLQ5FG+MGbtaCGrr2TgG3gz5nGgd
 Vci9fgjNy7YG4qdznIzED+ruFqyZ59GviIg6tZaKtDJn/I6czdDaz1mse06B2TU5F2PhFHl+CGu
 yr2JVBmPwLpe0T
X-Received: by 2002:a05:6102:ca:b0:7ce:6474:7216 with SMTP id
 ada2fe7eead31-7ce647480demr2158185137.36.1793101124418; 
 Tue, 27 Oct 2026 04:38:44 -0700 (PDT)
X-Received: by 2002:a05:6102:ca:b0:7ce:6474:7216 with SMTP id
 ada2fe7eead31-7ce647480demr2158168137.36.1793101123899; 
 Tue, 27 Oct 2026 04:38:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac70a27a03sm24389741fa.29.2026.10.27.04.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:38:41 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:38:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 22/23] drm/msm: Register the DCP backend
Message-ID: <m7zuu3txmzw4xemqrdtemccmvc4g6l3fsqk6xyxz5zzdbltptd@oqubuxwbukeg>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae08d45 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=5ffiRAJw0Nfj9fulafYA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: tW72l76WrKnwk-RFGmW5c8APhZd1LXk0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX/s407HdVGbrT
 b8pVwKFjm0FHvm8xBVy6MznzL+44bUdYZOaZNZ8zyi90KhgDVAyXh+wKcUYAAJApxpIPYpI+b6/
 ObuSJtiv607sT50HBH/2azcEHjScres=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX05LHAQ5Y/LZv
 NQ2/Hlm3UlPUgwTZl1LVIYHPpS8Pb/oY7nM2VBABNEj8SAb0JL47wJbiGb4ujhm9wLdEcI7PtC5
 sn0u1O4b6NuTJprMsYJXV8qp4fprkfT42YXv+UMXS3eIXrX5Rp2LoriIRb2mVMRVYNODcfxFu+b
 rPBAsrmgGEctt6GeVL8fXemhMTta3OjGy5XURrYAAcYuuwDB3lakFz0cR5LlReI8QwNXRVpRtwA
 i1JyJXgzxvu3IdpzR/fGKTWi/FeY/5jTX+aiOXXkSVOcpef3cTUvGscVwyomUMT9xv7q1hH+oDv
 jNbMltl0QqlTwFu9WB7Z5qOm+2T9GebF8d7KXXrfscLC3AAPZZG3+DDVRYq/O5A73pfA4+69Xm6
 5YIE8TMmAqN0E8Vw9Dq7lcrGQ1khZsx9Nl4Auq7gtILabiHfBSM1q3s6hBpmQffSNi4I6hwpthY
 tBRHAt949JftxdxSlRg==
X-Proofpoint-ORIG-GUID: tW72l76WrKnwk-RFGmW5c8APhZd1LXk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270046
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:51:32AM +0530, Jayant Shekhar wrote:
> The DCP platform driver provides an MSM KMS backend. Register it from the
> MSM DRM driver init and exit paths so the VirtIO driver can use the backend
> when the DCP function is discovered.
> 
> Add DCP registration hooks with no-op stubs when CONFIG_DRM_MSM_DCP is
> disabled. This keeps backend registration consistent with the other MSM
> display backends while allowing DCP support to remain optional.

There is no need to describe patch contents. Please update the prompts
you pass to your AI.

> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 2 ++
>  drivers/gpu/drm/msm/msm_drv.h | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 5816c64d7ce7..d413c361c442 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1208,6 +1208,7 @@ static int __init msm_drm_register(void)
>  	DBG("init");
>  	msm_mdp_register();
>  	msm_dpu_register();
> +	msm_dcp_register();
>  	msm_dsi_register();
>  	msm_hdmi_register();
>  	msm_dp_register();
> @@ -1229,6 +1230,7 @@ static void __exit msm_drm_unregister(void)
>  	msm_dsi_unregister();
>  	msm_mdp_unregister();
>  	msm_dpu_unregister();
> +	msm_dcp_unregister();
>  }
>  
>  module_init(msm_drm_register);
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index aa5dfd82ac6f..befaa9f2cb5c 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -417,6 +417,14 @@ static inline void msm_dpu_register(void) {}
>  static inline void msm_dpu_unregister(void) {}
>  #endif
>  
> +#ifdef CONFIG_DRM_MSM_DCP
> +void msm_dcp_register(void);
> +void msm_dcp_unregister(void);

This means that the earlier patches generate "function without
prototype" warnings. Please fix that. The prototypes must come together
with the function definition.

> +#else
> +static inline void msm_dcp_register(void) {}
> +static inline void msm_dcp_unregister(void) {}
> +#endif
> +
>  #ifdef CONFIG_DRM_MSM_MDSS
>  void msm_mdss_register(void);
>  void msm_mdss_unregister(void);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
