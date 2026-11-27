Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E0606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nJU1P7jj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XRf+4FkQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741BD10EAE5;
	Fri, 27 Nov 2026 20:43:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C3110E0E4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:43:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJB1Rs3752819
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DZjBJFtH+WDTVNVp3EGI8H4R
 uqImBz2xbif9rr5XKFk=; b=nJU1P7jjQQrzZV6GVoP9RsuA7xkEKf2zUVRYO+OK
 cylC9o76lxhfOYB9rT4zXcQ9eYkeF7c+6A2iZ7lLHq44cG4WNmIaRwxHftCay7LL
 0Cfwe13h44j6BhSp+4heF2WHS2IK+VRB46h9Ol+zdsYuvg2XGr24RK2JOoNrGL//
 JW6aMowusUCEjqAoZF/SSteFWQsRFLifw6yeo/I7F4BRZ08/JtNsk7udRvyRubQP
 J8MtHCgxABVtVlrvzEZqLohks7b9JjqccumlrA4Q378O7g3EdQnHd8epkszNJYcX
 exJnjhNLiYsFhpKLA27K2qypeC//EtA8DxQBnUIelk1Nhw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74ghateu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:43:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9211d51dcefso152212066d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795812219; x=1796417019;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DZjBJFtH+WDTVNVp3EGI8H4RuqImBz2xbif9rr5XKFk=;
 b=XRf+4FkQWiSSDBcPcqPH7OOzmDIldluW0tWDZzRX9MnfrrErQJ9tHAlufgQLeKqXdX
 iGm2rjBSVeCvTPkQ/TmyartUdYOIdXyBZSmZvilUcfN9FZJV/Hz2d/Zxk0WWvdSIEXlh
 0gZprMtdpMm6yrtPcFlWLrx8xF6J9QTCux+/O2U5hvdGK4+uS6UFFsRpPj7JcMUt6bAp
 shHt4L6iLIrz/VQEN+Ywl/CoAErbdg3ujMjonIyxZ911uUQ/I4rxzmsxn/YqEqzEZCM/
 Yg++VLNu398q6D/3G+dvr+40c5edZJbDisR9v690miJeqnxIZumxXrx94Q21CCwkBhLf
 qYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795812219; x=1796417019;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DZjBJFtH+WDTVNVp3EGI8H4RuqImBz2xbif9rr5XKFk=;
 b=WcUPF2wVmLG7GuZHkA1HCTi4n8CCiX7ZnnFqHUqxFRN3NREfVXVcg0iPJgRclnI+tv
 r8352JqAmgS1rK6rs5M1f0Plo0wEc+2d6G6L1LMe9qIq7Vl14bFxDRSxCxTCNb1bMVPN
 /Rc6anqK8QgYq6vEbVmZ9uvVpSGjWfBou2rVFc86IMq7oYq62xEzUaRiJHCmWixeuapx
 j4itP1vlibbdCmRpn3Lr9HgdCVm7siryaswft+gBrKtVHoqyNuupYo1NO2UBlFD2izyQ
 CLvb68fqB0ZIcb6lhy13oy0H9gHWqFtjQH5S1jOZxPK6nQnEI8Huewtq1b8oIflqjS6M
 aW7w==
X-Forwarded-Encrypted: i=1;
 AL+hErGAPHgCSrejdmCYGn1LLdos8W4/ApBKj3pTO1mTjO0DJqxHD8w5xnUMUTNVjjzFCNhR8KggaWyjn64=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8jzhCqOWRJ0YkurdGUsIybbNxSzVwSdWxUzn4Z6B6YBunpVW0l
 31AB/yl7NrCKNWXuP4Uj1GbRXGr7QucNaKPTT0CsrkhQI+VfGCmZjRnQmkxnrCGzkhaGVtsv6B0
 U21Xu5UNQFV3KNmvugCUcB15YCa5UZXvCQHV11j6MUv+uNv3ZUVJ700r73XqLlRb1bgjcG8k=
X-Gm-Gg: AZFdTZcEvBTVBc6kZwg9IlcasGjMFjfH/ZmxWljrxOhOGl/Gm5cNOXlM7vheSyNzHqY
 Pzg5lIevtCUUwN9LnM+Fd3oqPSoC7syoVobLFvZxmaxSrbFR8NZCaANca+sFwTsu454iG495bba
 u5xYIobpxFuwzSarFVBp413gNYw5qJk1fZ14ni4LrGaLLBVM4qKvQny3wfd7OLQ/DJ3gl6Ar8du
 pUHbBJIgTEgiXvguHvvYS1WqlBLHA+/dF1nJgzcbVgpjNY9p8RMd55pLTwz/eddmv5rEOv0Z+fp
 jFxruh4QVtA+xQMLYOTSZlSG5Za2fhexa72UyrOule7DTlkwvqr8VfjlFj3nAP3vUElxRJ0kU8W
 mx716qHvpi0qQgCiEVNyemVWCn+jo4ddCpfM6WY0zc5WUvBL7/M6ZN1jLHPr2YJcYeIRdtLC9uZ
 N6WNV6LN09f5BLFit8OB0JGhdTmCZkavvxd0NaGp/ZF0Csd84d/ysc2G1FlJcHVA==
X-Received: by 2002:a05:620a:a408:10b0:94a:889:5a41 with SMTP id
 af79cd13be357-94a08896148mr1304248785a.71.1795812219013; 
 Fri, 27 Nov 2026 12:43:39 -0800 (PST)
X-Received: by 2002:a05:620a:a408:10b0:94a:889:5a41 with SMTP id
 af79cd13be357-94a08896148mr1304244785a.71.1795812218543; 
 Fri, 27 Nov 2026 12:43:38 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bd07b242sm6028363e87.79.2026.11.27.12.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:43:37 -0800 (PST)
Date: Fri, 27 Nov 2026 22:43:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/msm: fbdev: Unpin the framebuffer buffer object
 on destroy
Message-ID: <ds4nmo6fbvqiqsdneeyacbpbgxxoxftcfp5nv62ayfsxwwv5k6@fm2y65xlulht>
References: <20261126170535.361985-1-vz@kernel.org>
 <20261126170535.361985-2-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126170535.361985-2-vz@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MiBTYWx0ZWRfX/z2a/Roy8QrH
 Tz+mT25Z0G34V0hoAJfy7JEiwvDOTD7DPZwwkH5hyES/JbK8WUNfmIlLr8HppetJmH2qrQ8RcN3
 DWv+i9YSHqzrC+YPPFUmpY/YA7YEnJY=
X-Proofpoint-GUID: hpjDl22y6Y1H46mv84oI1D6WHUqqLijQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MiBTYWx0ZWRfX6lCb4CsqURz7
 /KPNYq0lT6ITMtn3Yl/63b0idEd59MujrwCHbn2zzVa+qrY4QbQAnY1x2LaFCPL6xiD6VByCg8l
 LGVded2ipNufeCMgCKhJDVj6wlP8Nwt0Vke2CjkuiJJ0qbUpdnh7u/rfSH9tCqFimitBPZdkx41
 gjycvOdf7nUd5oB2xozUBWaXo8M67OaYuFknPVfzmcXU30J3lucP4OqDDQTWPFFPE2SiVban36L
 S4ZPf+YXUUPwBPaKbIi08M59AtwGGCJ3fMy9DyrwbVfpXU3yPVjB3E8kdx9K4SrT7qpMF9P7Rxg
 lPt7P4PLzZxfNSD0Ha9J7UjhlSt9rQx3L4wDMN8wQcCsssM0fRc9iejMlL977C77Y+BZdM3OIMe
 r0s6DhzrimJWLsBi2XOBvY3EkBsEs0Z6LYtvwxIKM/+ic32PUZ+U9mixIp9jZqVwnrcUXP/ZhOJ
 w4kNmY+rwh5nV9fYTkQ==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09eb7b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ze0TPCDu1uDqidZxEsoA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: hpjDl22y6Y1H46mv84oI1D6WHUqqLijQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270082
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

On Thu, Nov 26, 2026 at 07:05:34PM +0200, Vladimir Zapolskiy wrote:
> The fbdev emulation pins the framebuffer buffer object in the KMS
> address space and maps it on probe, however on fbdev destruction only
> the mapping is released, and the buffer object is freed while still
> pinned. For instance on removal of a DSI panel driver module, which
> unbinds the MSM DRM driver, the next warning message is displayed:
> 
>   msm_obj->pin_count
>   WARNING: drivers/gpu/drm/msm/msm_gem.c:173 at update_lru_locked+0x90/0x98
>   Call trace:
>    update_lru_locked+0x90/0x98 (P)
>    put_pages+0x8c/0x104
>    msm_gem_free_object+0x1bc/0x244
>    drm_gem_object_free+0x1c/0x30
>    drm_client_buffer_delete+0xd4/0xf8
>    msm_fbdev_fb_destroy+0x54/0x6c
>    put_fb_info+0x48/0x84
>    unregister_framebuffer+0x88/0xf8
>    drm_fb_helper_unregister_info+0x14/0x20
>    drm_fbdev_client_unregister+0x18/0x34
>    drm_client_dev_unregister+0x80/0xfc
>    drm_dev_unregister+0x24/0x98
>    msm_drm_uninit.isra.0+0x8c/0xcc
> 
> Unpin the buffer object on fbdev destruction in the same way as it is
> done on the error path of the fbdev probe.
> 
> Fixes: 940b869c2f2f ("drm/msm: Implement fbdev emulation as in-kernel client")
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>  drivers/gpu/drm/msm/msm_fbdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
