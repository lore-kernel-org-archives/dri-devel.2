Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B0606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eLH+sRwM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oyg6l05F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A5E10E7E9;
	Thu, 29 Oct 2026 21:28:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F16010E1B5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:28:10 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjhak2104704
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=6hVwHTU0GHPRCW3hjRHqce++5Z2pLoYbYCApNYxLMvs=; b=eL
 H+sRwMds8lIU2pRZSxje2mH8cXy0k4lHgYt3eZYj2eMmHJaYgsJv1sSF56vS/4+N
 5SvNbWZ9qeQlJoCjEOrL2IvjP9tahZ6XSkXabnIP6IHKWDozYfXlMqdS0tu/F46Y
 R9/1i+ZQU9pDqvBmP9ifunmk+yvDxKp9F2h5e3QDcuVP/8LNAFEop6iC0T06H057
 ED/+uch14f41WXZLF+F+d1Mo1zZcUd9+A8woQmeIJ0YZMHP+xHOmA5kcGS3Fyh4d
 PgK1hgh5IVKS+W/Vxf6Z6cuPop3I88u6BpJvM793eztZvI9Jvwldc4cefYsquaao
 8oHchG6IaAGfe2WphqJw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44qawqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:28:09 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-45ecb9dd589so43363fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793309289; cv=none;
 d=google.com; s=arc-20260327;
 b=nEEkEPNySlAaXBYSd/9Y3EtlkL1nwHZodw7DpCm2r1i4ZG20N5oE7YKCAVChGGMbmF
 zX0gJiFTyE4tphDeRpIbU4iKqtH/rU0vHQrCBvDlW5gKcTtvNOrRrfxW2eWU+vwcewIo
 QZvQX0l2X9iQICnAW8aZyAHqTlPkGcXSCJRVV+mUoPJ9kzChyEmpVB/jLF5DKX+tPwHB
 JcdEVo08iVCqv7ZuboTiSwKJLmr6TvWgcTxfw6XoLZut5FbODQT3m3/rDuBAwDR91Qr/
 +KUzF9tCIPDqF4xZ3CIPM9tXe/3ITnIR3CDaWClz+bTzyARTVHsUNpazOpbRNVnJ68UG
 NkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=6hVwHTU0GHPRCW3hjRHqce++5Z2pLoYbYCApNYxLMvs=;
 fh=x0xPUK6/4PAScPQh+f+li5pUt7ntMAbalD0vMfgEJ2w=;
 b=oxffD6dAMhe2X130QlHrKdySxpy5795zfjML4Q8PAmwL2gGPcnYweJ2D6eYtxvq3Kd
 n4L1AiwsCUddxpkmy5CG+YzXocI5GodWQocMKdAFDJgEyZaFfse7bGbod6vEuZXg1v7/
 2Aco/XbL37aLGX9+fqh4ksDorf66UytbRfz8hO/5oDYuFUBVnAWfkcXuBreJ3rjzZF+D
 3ePLrWnFQbxJJZyPEiYd5cYvT4gSsS9U89WSaSraxJsOnVIb5ftqlSa3pkInQiVrPCWQ
 DBsApSMCQaR0q9v8ft9d8jlwXVej1mZBD3hQUCkcgrLThQewIgaVGBPPDtjyGA8J0Djg
 pnWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793309289; x=1793914089;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6hVwHTU0GHPRCW3hjRHqce++5Z2pLoYbYCApNYxLMvs=;
 b=Oyg6l05F4LHfmEFv7KkQimIG9y9JBwvUsSjsLDIZy8nLr3Pt0cP7KOUlObZpH98Pn8
 HWjObvzq4udLGfSZfbvtIFmz39OrZ8Lib2gZAG5t4sioYevRifdEsoQOyNWSrhxI7N+/
 eIc/gvfeb63HBz33ktQ+ybzxQW1u2XMyuKGHwasOdojR/VvH6o1y5+b6CXTh+ote9H3n
 /sPE5X4gDFY2aEc7b/tASe/fXerJi0NSUdyylocEDOHHhZBrzGfatsCZPEYH4wqwZBjC
 rhpFz5dz+yv5EVmKUtl1pov0op0iAuKijAYVa7atgPxwe2QhumAKV1sFq0BhTAncAQSf
 tVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793309289; x=1793914089;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6hVwHTU0GHPRCW3hjRHqce++5Z2pLoYbYCApNYxLMvs=;
 b=zrlwe1HON1XZJuAF1S2GZUdzHu5IergiR2lAtehDF+F8AdXT1WhJ7+BzdBUrIk8o+k
 hu6uFJIz9b/hrnbm/OGcP0oVEAuMlUD5fsoqgkQ88ZxbE91ljQ9oPECDBPqmKwSgpgUR
 nc+LAje7shnaDSGoIhahyXecvo5q0KHs3yzeBYJt3WaKMIyplCdhOT3pBOFJgxTGJMgX
 hojhMX8nlSX0EeXt7b+p6czifbhMYwILXgLzJEXJAnIOfJSiwHtdPde8lffrZmD1Zf+Z
 E9leJbD6zCCr5mXQe+cWWjpbyxl/BHMmMxkvfzaBZE00GnbJkZQQpK86lCsL8BRXkISo
 B5xg==
X-Gm-Message-State: AFq9FYKtMwafkB+/r+QKmrlw9Z57CAGzZgdabkdnSYdsD6D+gB8Wuer6
 4rytJdzVhDs0oNJFr18Vqtdosk6E8lf/YwKAcAnP7SEBzF/XQ9ZKz4AUf/OnNJMk/IZC9lBsdyD
 L4iQvDJSKiq61pub5axpNBMpN2zmzz4X3ttA6rIllyPFco2V+XYcanP0ra1TPaZyaEB2GSqqYi8
 F/byNjKSIawJRS/35Niwnx4DWaHQssvjyUV6vKKdtTbavxZg==
X-Gm-Gg: AYBFou2QnDzI/fQslV/23lNHkrvgOpHamqj3x7cV9G5NneznEO6BJJWntl/RaMN+TIZ
 3DpHGYPCt0hdxgwQ/L8Fg3IgkdFjM+Ecg58FIFLPCwHfWbNgTkBOzZ1WRNnZIFdUdEXFAVNFTYt
 NLFIcm5Jf8QnZV+S8jawxCfYHz69WPQVP/FBIoxsLs972U/9CQcOuYVkOsBw==
X-Received: by 2002:a05:6870:b2ea:b0:475:e0a7:9f2f with SMTP id
 586e51a60fabf-4a9076b1101mr271992fac.29.1793309288724; 
 Thu, 29 Oct 2026 14:28:08 -0700 (PDT)
X-Received: by 2002:a05:6870:b2ea:b0:475:e0a7:9f2f with SMTP id
 586e51a60fabf-4a9076b1101mr271973fac.29.1793309288126; Thu, 29 Oct 2026
 14:28:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
 <20261027230452.130031-6-robin.clark@oss.qualcomm.com>
 <wxfx4nhwdx6dud4ahy3rfz3btfto4t2zor2pjbotlqpglvwolx@jhnm65bzecnq>
In-Reply-To: <wxfx4nhwdx6dud4ahy3rfz3btfto4t2zor2pjbotlqpglvwolx@jhnm65bzecnq>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:27:57 -0700
X-Gm-Features: AclHuK-TjUdlKoZnZG8f-CId0p1yRIAAyh4tUi1yT-oyXKhj7rxF2iO9qh7KDlc
Message-ID: <CACSVV03_=bZxh7KuQx7qx+2fZDDKv67Yn3dVu1biBG1s=J9+KQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/msm: Convert map helper to use dma-address
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfXw9JOj9tVYJVq
 N/+yXCznHTnLgDtgDqCGB6NTlMZAF+axaLFb7vBZAmUt+nR5Gamd5Zm4p4TI+pZwFPRzDp/GQRR
 j2nHwwQ4v3T/PDaIPpTL4JNZJ5liV5g=
X-Proofpoint-ORIG-GUID: mvahDgOqZtkMHq2QOn7N14TZq0n00Cmi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfXzxWnE1sMpYQO
 HJy9dbRg6MYXbfcLyYwj0adbaGwVRU33tKt9v6fYxirJf6oNZpd2AZ3H4rBE5zwxnm9bL0eNDdR
 N2zIxm2l4BYu8cAne3S6oNjd+iZwwNDI5Ky/1luv5zKm/dErFPhZDkXHUhOZgCTsirT34xQDZ+g
 Vo8o8zRtrhdfAsN8hEuDPrwhyiatEMPXlS/6xNcxcutu3SVzyanfbab7yksR6a4l3l2HGMZ84N/
 cigk41r3raJLuncFV7kivVib+ys2ynNbh7EsX57tjRtbGodTjYk6bThPvFwf6QJSzblWuiA2J4H
 JOjRhTZqyOlktBWRnVcjqy/NkM1EwT17YkktoSOMF1GqYrSgc5WLlZV8Oz0KTkOmbnEeb1SMexY
 U8Tt3Tw2oQMwQljcj9XGkD/PHJl/6w111vkQ5tlrx2Ll5UQ1P5Pa1+RUlkyK8dFnVMPqC44kmJQ
 LX7jzub9nzt+UTn1l+g==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae3ba69 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=qffPo4UZxZtRrYcd1KIA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-GUID: mvahDgOqZtkMHq2QOn7N14TZq0n00Cmi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290084
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 6:14=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Oct 27, 2026 at 04:04:48PM -0700, Rob Clark wrote:
> > Now that we have everything unified in one path, switch over to using
> > dma addresses for setting up the mapping.  This avoids issues with
> > CONFIG_DMABUF_DEBUG stripping the pages from the sgt.
> >
> > Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SF=
A14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=3Dy
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_iommu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> This commit seems to break GPU on db410c (which uses qcom_iommu).

In theory, this should help for qcom_iommu and msm_iommu, but untested:

https://lore.kernel.org/all/20261029212344.346069-1-robin.clark@oss.qualcom=
m.com/

Not sure if there would be further issues on devices with bootloader
splash?  It would probably be ok for DSI cmd mode panels which aren't
actively TX'ing to panel, but otherwise idk.

BR,
-R

>
> [  104.954564] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  104.954932] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
> *ERROR* gpu hw init failed: -22
> [  105.958559] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  109.082571] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  109.082670] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
> *ERROR* gpu hw init failed: -22
> [  110.086572] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  111.098576] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  111.098674] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
> *ERROR* gpu hw init failed: -22
> c[  112.102576] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for
> GPU to idle!
> >
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_=
iommu.c
> > index 479e5450a4dc..c2950d32c507 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -153,9 +153,9 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, str=
uct sg_table *sgt, size_t off
> >       u64 addr =3D iova;
> >       unsigned int i;
> >
> > -     for_each_sgtable_sg (sgt, sg, i) {
> > -             size_t size =3D sg->length;
> > -             phys_addr_t phys =3D sg_phys(sg);
> > +     for_each_sgtable_dma_sg (sgt, sg, i) {
> > +             size_t size =3D sg_dma_len(sg);
> > +             phys_addr_t phys =3D sg_dma_address(sg);
> >
> >               if (!len)
> >                       break;
> > --
> > 2.56.0
> >
>
> --
> With best wishes
> Dmitry
