Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA57F1088E46
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 04:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E258110E0CB;
	Thu, 19 Mar 2026 04:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mNIuyGEx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UtO+XaUA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68B410E0CB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 04:21:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J28dGj3141163
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 04:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iTMWTpUdri2zIVu/+9L5yItV
 x8lusEUECdAO46qVzu4=; b=mNIuyGExJOJFPFgngx7rbgM4SQEzza2chrTLOy0K
 bOd1+vOYZY2G5J5FVIxlGCs/W1nTV8WqLGPNxdz9Xt1BhhHybqfmQQJhQLqhLL2S
 rIxIKoIbbrEvtuTeIV6xJwxQXb5Pv50iYaBEwRQ+xlcuf7oDimw4u3Kwc+GOhAts
 ZGoy0y/Q0pUXt1AdOU3nVnqct89ZiU3+damYnfjF78Mjub0UeHwnAF+Zp1euwRf/
 NILUL+nJza2vHY3y8C0Iyu+xW3DyOPRSi8yH/G8gPbbBIqJjBw6s9sVEeei+DywK
 utYxKEQl3PxNtteCLetZP4ziFJh3j5pp21mk2jH6Uq27Lw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r8ax0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 04:21:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50911c94db1so35571971cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773894118; x=1774498918;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iTMWTpUdri2zIVu/+9L5yItVx8lusEUECdAO46qVzu4=;
 b=UtO+XaUAwggfbH9Wz7mKBcyVZDMqjsxEutXaZuDt7KhtAw0FnVb1QUaW8YMbetOxsG
 3SuzLchYnlaPQUrqfTsqIGnaxrxsPSGmLzjcdxANU5kwWJf0s1h+pwSa1CVw5D0h3gU+
 kZKvLTFnJ53+LVhuGILG9qvXNs2xASiHBlp/xc6fwLMyftaSKf2OFXI63r50rcDGqfGm
 q6d8YX382Sa2ybEk15f/aqM8Gu11XccU/isuYx0QMeKAVRdiKXmOA830E4PLNVF5JuwQ
 46dBKPwBDf6AhL0dUz05/uHDINoW5Gp95FVtp34A9xBtr0L8vhMfc3jtym3E1C2A7ruz
 8+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773894118; x=1774498918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTMWTpUdri2zIVu/+9L5yItVx8lusEUECdAO46qVzu4=;
 b=ClA/4KEhErJVAiCVyuRUlZZTn0Rw8oIQ3K+h+FjvSn/vmObmsLJxwK388UaQBIjzbR
 ZCVrhSzhpj4+Bwvs+4RoMoBGN7+lfu9hfOIB/b1tOXuhswh7eTPlvjSCLeNOkIuPwtW8
 C9tBo8bT/P8+3h74U9ZRUpKdrvpg8lqmjk/utco2LZT1cdo97PTKS4vI2gFudAoas+1l
 mX0ogMyQBBNXN2mWniqT8WpF3IAQ0HomxRs1rvNZGQlrYFi5YQiYE8MT0zhij5dtnQRn
 UIEbjwLYAby0H+MC6LeHDqWRcj7H0uf6D8RwX1xtjcsM2EwC9R7/el28yKHpcbMih7Ch
 t8sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVacVQ4oLY2F+25CjHaNz6GhR/vLpTd12PPFiX0jh9itz43yuzyjx4JtWV1Mr3bkj6yHpufEH4KkwI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6RBKorpHrSTzMohaHWndhQRseZ6EBua6NwirZfcdN3q89i6gZ
 5Q3knOsg2ESTF7Ziz99p8wdjn5Ldk/geo854k8Chf0P0BAXGW9JgGCQlOQe/qQHSnbLOwT+vFL8
 T24NIi5W2rCSkd+cZhvNQGFIedgh7BkmRfaZBdUaFydlWuIeqJKtlmj/hs4QFKLMlqrgvbjg=
X-Gm-Gg: ATEYQzxewcRVFzlgDFP7vtMCVUBNu7Tqtb3c/qPQZScsV0FUdPqnAlxgJdCFrJiYjMy
 CxKXpGlP7ZiTQZqU81YvP4Lxq0Dj9nPHRGvgJjnPPXM91rsv6WlR2qeg1vQRMtA9ZYOFYqoKnQS
 3sG0coCGa6F6Pk9viLuGpQLnRzbj0vnz/NXt8VjLFeqAf/moZx1dN1M/D2HTBfYBAont4Rw8Ezr
 L5cTmwgTW9qPFwbVjWjEsav7/wTuz89PNlRhHbH472Q7DcyxrxRFQULVxzyXB74ZQVR9X5hQ2W9
 +lW4vbbFkm4aVNEZpQJLS0X+RsBYINlasc7jDDsjkMinoRXQjLipE5VstflwOsHsTaxf2c/nxKh
 dL95EOySRkQJgL4qFih23APu6T1RcL0yMink1sOA4EgG4twxHyx6p8RAvpiHmba7QVmkeGQLvo8
 NxLC5p4clAyGDxc9GKgXSy2r1EzbyKsoP8J/k=
X-Received: by 2002:a05:622a:547:b0:509:764:2f03 with SMTP id
 d75a77b69052e-50b148585a5mr74315041cf.37.1773894118406; 
 Wed, 18 Mar 2026 21:21:58 -0700 (PDT)
X-Received: by 2002:a05:622a:547:b0:509:764:2f03 with SMTP id
 d75a77b69052e-50b148585a5mr74314791cf.37.1773894117868; 
 Wed, 18 Mar 2026 21:21:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c27346sm934721e87.16.2026.03.18.21.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 21:21:55 -0700 (PDT)
Date: Thu, 19 Mar 2026 06:21:52 +0200
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
Subject: Re: [PATCH v2 2/3] drm/msm/dsi: Add support for RGB101010 pixel format
Message-ID: <5zfn5cs5atdgiv5nztxc6d5f4dcbqqrpdiafnns62m3mzwh7vk@ga4mb7oo3fmz>
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
 <20260318-dsi-rgb101010-support-v2-2-698b7612eaeb@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dsi-rgb101010-support-v2-2-698b7612eaeb@pm.me>
X-Proofpoint-GUID: F9zbaP1HiWPEi8M8DLKGiEM-MRj2wHHi
X-Proofpoint-ORIG-GUID: F9zbaP1HiWPEi8M8DLKGiEM-MRj2wHHi
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bb79e7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=dHkJIz5KlUVh9OC2PNkA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAzMSBTYWx0ZWRfX2srHY1r3xJn1
 jK+dnuunEwp2SYq2nlN8IWBjmgos4TxRS0GxuX3sGGcXIMSjiFUd6GQ9IfmkCtxL1oUjwkJXssZ
 Fv8GiA1UANlo0ITXpBBefpfr9FVrJro0BPLpFfM2fQljNcx3Pt51r3NwgQ6ilRV8vCZgC49leFh
 jZRlxo47Rs7B+c9AbcAwY/+lcYoKRid2Uc0V2LizxNC2DRbsNm9VTNMuWNqbEQSQ6nUqlpUfA8p
 llXFLCeyloE0X4crFaJGNRMfgKLxwLtG1RJr4K6PEOk6v6Xzcy/+z3SX4hLBr5Zl1uOpDVNAdiQ
 t9rV0uNWjo2S3ZW05c2yoSxbhM361/jtI3KIXIGGv67IdBejTDhjLeJ3kcHggGRsq+llhUd2b/k
 yyKSbD7XpQr5wf9gde6Pt8sggpTyIbf6m/yiywQqgIjb9gnkiG5bEZbtzjDB+Cc5UfJlsr0la64
 sMRBrDFdJjlqvFJI8ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190031
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

On Thu, Mar 19, 2026 at 04:00:05AM +0000, Alexander Koskovich wrote:
> Add video and command mode destination format mappings for RGB101010,
> and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits to accommodate
> the new format value.
> 
> Make sure this is guarded behind MSM_DSI_6G_VER >= V2.1.0 as anything
> older does not support this.
> 
> Required for 10 bit panels such as the BOE BF068MWM-TD0.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 8 ++++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h             | 1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c            | 9 +++++++++
>  drivers/gpu/drm/msm/registers/display/dsi.xml | 5 ++++-
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
