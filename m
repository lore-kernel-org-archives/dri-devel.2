Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DF7C5DF8C
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 07:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE3810E3BA;
	Sat, 22 Aug 2026 07:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ATvpPIuH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P8uO5FAX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7611A10E393
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 07:51:43 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67M4g9QD3485741
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 07:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BepdfuaTr18C0E7I+AUvMC/Z
 TH2x+4KRgVnzynO6hG0=; b=ATvpPIuHe7uK4fxu/h7GJXsxwMAavSH8wuDUHe0M
 FDfGfE1tIa5lWohfZGYwsmtet1HqMaxq1SWXPV+b5VaFvN7uyyI+Obj6mFWULtDG
 K2qzDuu8qrFXucRQJA2Hq7u7+5UelI3lZnCQQzTbo2HmZNmVN43+FeGee09UGQlc
 fOCk9EjNKHPoITMlKNhoIMm1ZTpYAd1d+K4NTM2W6XGLuH9ezQyfoFLt3Y1yECgg
 esDo7Empv9n6lUfplALgxNV4gTKsCef65b2ucucMReHZWCTm/q6WIPlP/wBXGtal
 kje+88Xt7KffTK2XCFgND03zJ15zsXksCzoV91/Q5PMVEw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74xh8b96-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 07:51:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso31154791cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787385102; x=1787989902;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BepdfuaTr18C0E7I+AUvMC/ZTH2x+4KRgVnzynO6hG0=;
 b=P8uO5FAX0IIpWflE7kWQgCIqqZ/YnxAoVzB9CMHxH8f0Gved/RBRjyEIJzUme11pJj
 yri8hcYPDOqs67gasIpMaQw4drBP/Xv3gaTT7Fk3KOP4KwvnX2AD1DXFokhrSwk67r32
 owh4s1mkEbnXg6jNTk00o6QFMEHXoSIGOkhXY4SgsT9ylNabuG3f2LSFvfGUpE7TzPQ+
 Si9GylnMleEe4AtKP4izvwuBwA/ORxJ5ydIkSPJsbVa78G6HIs6PMdngKX/HvAsaWnZX
 NM0JBOosJ1VPsRtNM2uAV0P0yfAJpsUvUvETRC+ZOGPvMdZXpqJORFrc4ydnfOW7ncJ6
 9PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787385102; x=1787989902;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BepdfuaTr18C0E7I+AUvMC/ZTH2x+4KRgVnzynO6hG0=;
 b=CFSfBmih8R2TLrblybHSMigKFY/LORzbEdwogswqQ92OjcSo0hEmp5HQzIDLAWPNaa
 UysxUTIED+yK15tzTTnAX4essnoIhnrwljcK1mL0iFT9nXPyGHZnyaNBxAw/AU1hUpr4
 Zk7/7RMoGmNwkjIE5GlR0f5t+zwBkQy9VCzZ2hm8j8wwIOJd4XfyqSfLgoTupj/urvxf
 YTkfzFyywfMqEg+Zlc7DYoyGgS8lXOSDj+fsKhE9fxT2YbI8ASqePd+0dHy4wGWZ4oeI
 P6z2co/fsNx3nwFUJafSKwipktsr/r5Lum9ViCZi/jBQgtK9J2wyCqDgGmyPl4FxBxFX
 rtLg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/dpHlCp/Lzb1GBsiSrFacPA8ydXDDHjjs0BrgEU33fpluFgQ/bH/237Sx6kmMpJKH46nQKk6Y8Ys=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNFmz3uGt1uKOGQErcBxRHx7NFvW1ojbDhHc7a1lgqf//3hl1m
 MpsG3OQYgZ0Oahb240GokefFe2ag3wd1mXND+yHmpxexGr/4e23lQ7pseBZgE9tfWajHnkvP0Mk
 QvOI+nn2mNMd5nzhEpk9BcyLQQVCPtyLz+QNCoqOi9bkO3Oq0tbB+YzU/fUsQTMBIYgWFC1Q=
X-Gm-Gg: AR+sD10rajf90psFHZT2cRRUupSST6ddf7jEmv2/J3zGppuhJSTs5oBhywl+nizJTsm
 E+RKpc0nHj7BSOT+Sw6+huvjK0e/lWYLpL5L4r4KKgdxcpVdRSuzNeCvoYdohILp+l/18sj0dpB
 BFqUmCp0KD50mr+uZTooZWHlirESKljrY19rmX7CrkVtLFaATfojYthBd6AUoI04tqiObiLpoKn
 OmOLI9Ok8JvJOAMP/v/ghFgdzn+Mg/oqmPc4gJ/E07uAvYYvTudNn8++Dbw5fpOCKXrmjb4tNJY
 P8hMH2TktDELeslL0FJix9xPusmkWhNkeOaqcjcrHBHL7ZAdCBRT8lzJ+bxFLCEMbRyBRc58Jna
 C6VtHWMFoyUe3+aowl8LEi8ynj/QOpSK1WR77xQlftTKOSc9z0mvhDbFykVPjvtWZltl396+ce4
 EJ4+yOhOztDSau
X-Received: by 2002:a05:622a:5c8:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52df585c856mr109612061cf.25.1787385101477; 
 Sat, 22 Aug 2026 00:51:41 -0700 (PDT)
X-Received: by 2002:a05:622a:5c8:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52df585c856mr109611781cf.25.1787385101082; 
 Sat, 22 Aug 2026 00:51:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b48cd9aae8sm220570e87.9.2026.08.22.00.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 00:51:39 -0700 (PDT)
Date: Sat, 22 Aug 2026 10:51:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 17/70] drm/msm: mdp4: Switch to
 drm_atomic_helper_crtc_create_state
Message-ID: <ycweatq3iyqmgzryqhceh6osjtsols45jpjm4bdq6auzenf3yi@un37ueko6f4j>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-17-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-17-fb793475c05a@kernel.org>
X-Proofpoint-ORIG-GUID: 3bvy38o1TbR-QGNymh2hKUClMIqK9uQJ
X-Authority-Analysis: v=2.4 cv=GdQnWwXL c=1 sm=1 tr=0 ts=6a89550e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8
 a=uh-rAEkd9rr4pKaSMd0A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA2MiBTYWx0ZWRfXzTUkpxRAJE7P
 ZuL0oUFqoQlu7nTvgY4W+saJMMuyMtdOQJnghJQLwFQp1sWj6xKq66jxzA8xWjw/+C2+qDTDHft
 jeD+C0ECwd9UPXmWUtmHS+ANYaSj62iNzAfBm7ITbnfGLodqPEY0GEkuYI+CcK4Nv326ksOdWli
 ku01i/e0ESLLepsTZ8PEY74a+QHRkzLEzyJ6tkSvaYcHplpNMTq1/nE/jKv1qXrExtImyekoUlM
 YjebBFDUcwLI1jRXpkDhqwp/+63JrluOL7/YiH8r5TVfn1CEsX1PPNrEb+hHHuQqXiHAqT19tIb
 iLBplOfECQ96ST+OCyABNesOjSPpKWxKLxQErY0Nl1PHmCF1RDjWcvh2i8u5aDvW8+A6vqZcpbx
 L6KdBmXBmHewPWgxUWLt4DoJWW9q4JSHsnBOhVxYfk8KwXVCykbfcRmbIS3EhXUMqzcMJoEibpU
 eFifR0Wz1zARS3k1M5A==
X-Proofpoint-GUID: 3bvy38o1TbR-QGNymh2hKUClMIqK9uQJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA2MiBTYWx0ZWRfX26d5qoP5SXx2
 aL9fPYWgOVgjP0gITDIC52gCQ0idI8AqfONtm0kG71KqhJ+TZQHIiAc2egRQCqyKEzoHmjEf6nH
 WjxJkjUHoaBw5TH0NgzLAzzJJaHpUz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220062
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

On Fri, Aug 21, 2026 at 04:38:53PM +0200, Maxime Ripard wrote:
> The mdp4 crtc implementation uses the deprecated
> drm_atomic_helper_crtc_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_crtc_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-arm-msm@vger.kernel.org
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

For this and other msm commits, Ack to merge them through drm-misc

-- 
With best wishes
Dmitry
