Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509BCC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B060B10F5D9;
	Thu, 24 Sep 2026 14:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BlgJG9IT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y57vINUb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2941C10F5D9
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:02:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC519X2595126
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=Y+5dXl8x9fmntpeFxM19iIhvgt0k/LL7dD1+C5hddi8=; b=Bl
 gJG9ITL1KLa26czRDWH5FL6HTQZiUh4Aayd7GRzDH2YRHWbWFm1y19lHI2EbF023
 PKSHxZgkQPGZ57OxZ1T2cL7yOcpxC6JnLtFYMvh6/ls22YixeU2YCkFaYt+J7OHt
 qyhMk+nOQMnDctXoHdlUT62K/omXSESpdyysD7EglnJND1UBo3YfbZ5MJXq5tq/3
 ec7Q2Q7dP+7rIvVXBFG9wHD6NQnDxGrFfqfPAf9cSzMhPMgAL13rZomlnjTtklEV
 YlRQXY198PYemdgOzz0CQZyy26LPjGK/RjQfb0wflZ5jYjkB+xdgfRjXyPJLhyio
 kCBh18+ANf6JOpdp9uvg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjgvvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:01:57 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6bfcf73dcd5so2722895eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790258517; cv=none;
 d=google.com; s=arc-20260327;
 b=X1ZBD0OFGY7CS5VU2YzZyA5RB2l2zk484ODPKYmBA4UcJ5eMtEML0fkPV4gSvVJ70E
 jrndVaVvzb7kcaaDJmJCKKca2bDYAXWgmM1nAmdTte4Stxqdi9o9ppcGAVSdAtyE8+dS
 P5qEfA1a1nvCCPTYu55W34/aCa3FJ7LNY4IgAifflh7bxmKLYkTcpOpej6+YXlmlyKld
 xp705YizA+9MzalM+GNX1lzKxBWAPOltAEKGPEYjIOkwzu9yg19lY2INd6IP9lZCYTxU
 U54ynMvt+X+I/rvxMYV6aDOGMYHO64lbQqwwVX5tJhxfKic7nUEuDvp91+2lrVKZAuet
 wTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Y+5dXl8x9fmntpeFxM19iIhvgt0k/LL7dD1+C5hddi8=;
 fh=7fKJ5jTQt2GRr2MrK0XVJRq/UKMUcTGDymOaLCB03BA=;
 b=D6XzK9/snDXuDJSH3cS2sElofAkTdIxs1X3a+Co9NbdbXe19VvSy3LOdpC5w8Y0WRV
 76Gu+4TAJSBkQOpb4J4Qb7IXJ0go4fu4ENUrek4CxEFx0a1YndP5xVGVRI8uwAYJVymR
 c3/CE4B5X8Ztiy77AHO5xIuesb+nfeoUFBzeYhRU6LRAUXeqbXvIjBo+VrhEZYs2Rq1z
 w/2IiHHOr204oP/lDscZ4I9kcwh0cJO2BUFftpiVA7CvYS6V7qXqtTkjOsGwZf0rzey0
 Ujo6Uc+O8P4dEFOhaDQLOr4AlS58TRL4eKPaKDFbdq2UfawKcZTrpA0yyvv63CsrG8X6
 x7DQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790258517; x=1790863317;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y+5dXl8x9fmntpeFxM19iIhvgt0k/LL7dD1+C5hddi8=;
 b=Y57vINUb3wMHzjAVZVoFu5amlKLX2DNC/tfEZMaZiAm21pHT7EfKNdRlleLvQNFemr
 u35LZMnkyGy/HvgjURKjwiwCTIfRAkZd5mNxJJRX/JFje2y2jXG0+gf3LW39AqZs6jc2
 vu+mdkYqzDNzvPcdbD21Y9Rc7Keti4FsuHhX+YByTSKqLkSrFECK7vIaV5D9aUsIJ10E
 RY+zyKt1TNQIG2FLT0erwaCIPFGKX5jx9ylptEyVVZQa5WerJV7i2kCTc7WUlB43xbjs
 mX8CbulFwgiCx66jBT7pAdDRtkQ4uamCNj4zkACUL5kwOSgUQk2axxkdgyPlPELc9Ww9
 EyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790258517; x=1790863317;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y+5dXl8x9fmntpeFxM19iIhvgt0k/LL7dD1+C5hddi8=;
 b=AAtwe4jhSdBVjlj9Ia92y8u0NOhTlUt0nJ1hjF+9at+evzCIzpM/rmqyGmpHfL8IKM
 nPwqqPIqLjMvbhMANPHH/8+c8INE6Wrt7eaeR7PXDO3o/MdDpx2dn/ju0Pg6wqFkCIyL
 Tmk6iyBjWFniYAkf+pT5LC8C98c5yOcv6qpW3Ja+74qiq33r/1bQmZsBtqcyVGNTsMsU
 yS/NhzStuhO0wbEPI6vq5SFAH5ftCVwJ/cWQkQ784smL2PMMDXD7/qj4rYplYsCKQvaY
 N2MK7cjBlo+4o0Ea6zmI3MHi5Qllxs9Yz+cOjZ1A0A5pGV9C82MabENKLl/TrEdn85DL
 18UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYF2DNgS5ed6nwZNEoWNGsEktGN0ZpAPkM9S6FVZ3EfwZWeDMZGRR/t8OGqawoZhnjAXHBc6dkYs8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l8hbt/WBpv7kBmKmogiujKTvKMZRYcG0TKXDmCjw3xdGyPZREU
 vIob54OIbn0+gnoDCFp5BdUHyLdAf2i72WljM/0z0YvvwljavN3n1HSqdIncJ8C8nJcIWU3AWA/
 IU0TnLvickJk2DH4Fkn5Q+s2Qs0WO8FKkG+Xg6ybDJGVICyfrYNCx/yidmi7YRaG9U0pkv0x4mE
 uISNJp4VEIJJtiTtOAb7BdsJFqeVTrWO5RTTqW6mzBSdPvwQ==
X-Gm-Gg: AYBFou2FlYBee1PkHOCDIerQHmLdP5CE/f564gOskTbfqV3bN/aT9IlF2fpiygbSsTg
 tdgx6p34cPdcd/YNbuVSE5t14RnonjUO9TNQrdOkTNP0D3Z9rIJHLlnXXaIPoKj6QF+DV+qjwbl
 wVdDAtBe8uy0T6EKxM8SniX4cwF8l8hayTF3m7nzXUAS3PV7U+wHGxUzAM
X-Received: by 2002:a05:6820:180a:b0:6cd:3fec:de81 with SMTP id
 006d021491bc7-6d441e6d077mr2471540eaf.87.1790258516921; 
 Thu, 24 Sep 2026 07:01:56 -0700 (PDT)
X-Received: by 2002:a05:6820:180a:b0:6cd:3fec:de81 with SMTP id
 006d021491bc7-6d441e6d077mr2471495eaf.87.1790258516334; Thu, 24 Sep 2026
 07:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260923074256.9357-1-liujianfeng1994@gmail.com>
 <20260923074256.9357-2-liujianfeng1994@gmail.com>
 <fe3a4297-f300-451d-9763-0b3016706111@amd.com>
In-Reply-To: <fe3a4297-f300-451d-9763-0b3016706111@amd.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:01:44 -0700
X-Gm-Features: AclHuK8PCKMtH5RJ_KGTSVVtHj2pbRynhRsLbl6BgMXL5O4KYIi_8g5-kxz9ApI
Message-ID: <CACSVV01NZROH9U5Qjd1TSDu+BPyyPLC9pFByqSfrxXrPJV+wZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] dma-buf: keep DMABUF_DEBUG off by default
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>,
 freedreno@lists.freedesktop.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Karl Mehltretter <kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: mviovZTeLusM64QulsPBgkeoFTOjyEKI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NyBTYWx0ZWRfXxFpq7kv4LH+f
 /+skox03hh1JHC4ae0CFI/4J84QtZUBl2zmc6evAWVz7ZoFQ/JwZCES0JYBl3nssYh/TdzzWzG8
 AxofdzucIN4wigBHvIuhUs79JF/ZatY=
X-Proofpoint-ORIG-GUID: mviovZTeLusM64QulsPBgkeoFTOjyEKI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NyBTYWx0ZWRfX/OW7w2eQh2ox
 MeGcWnahB+wmj7hUmYywEcPsGfM5b+Tsz7UXGqu9Nb3K2JApP8dGY5r1RMGXmgyENPUYxwm+miz
 meHm/osEE3yPhqNV5XPYHv79U/SpG6SugC/3qEKhPAEVIfGzXNyPqMDl4Qt5cbkyMAc2+0dpmyg
 ziOd4We3+yDo+gZAXSwfD5x05JieivIGrF/+TREpjk/0GFWmAb/xMfK5Vu6rKIZuL4ErGc50zP5
 NoRjIM2LWe7MwMh+Q/nb22wS+TB2LIuTJvs+WVOvkYT6rGfjwR0J3R6v7SyENtY+USacHxBqFHr
 KcN67thBdGQRk7nvSaSB2qVib0HRpY5OfMsBMg4HJZYaUpakxplQkVQcxM7ixK/MiCpbivn/PFF
 vS9drlQnKMb2xx26hHrB4+3lSpFIpQ==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab52d55 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=_EeEMxcBAAAA:8 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8
 a=KFY_g6KMpv9GzmgDfC4A:9 a=QEXdDO2ut3YA:10 a=ejeoeQMvoq0A:10
 a=czjwGCTIUPoA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240057
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Sep 23, 2026 at 1:03=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/23/26 09:42, Jianfeng Liu wrote:
> > [Sie erhalten nicht h=C3=A4ufig E-Mails von liujianfeng1994@gmail.com. =
Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka=
.ms/LearnAboutSenderIdentification ]
> >
> > Commit 143755bdabaa9 ("dma-buf: Make DMABUF_DEBUG default to y on
> > DEBUG_KERNEL kernels") fixed a dangling reference in the DMABUF_DEBUG
> > default, which had the side effect of enabling the option (and with it
> > the page-stripping sg_table wrapper handed to importers) on every
> > kernel with DEBUG_KERNEL=3Dy - i.e. virtually every distro kernel.
> >
> > drm/msm is broken by this: it maps imported dma-bufs into the GPU's
> > own pagetables with iommu_map_sgtable(), which needs the struct page
> > of the attachment sg_table, and it fills the GEM object's page array
> > through drm_prime_sg_to_page_array().  With the debug wrapper in
> > place both silently produce garbage (the wrapper zeroes sg->length,
>
> Interesting point, we should probably change that.

So the assessment of what is going wrong looks pretty wrong..  VM_BIND
should never lead to iommu_map_sgtable() (which is never used for gpu
per-process pgtables), for example.. but is used for mapping for
scanout.  And pages are never used for mapping in either path.

However there are a few places where sg->length is used (in iommu code
and msm).. AFAICT dma_buf_wrap_sg_table() zeroing out sg->length is
what the actual problem here is, rather than any use of struct page.

(And yeah, I should get rid of use of drm_prime_sg_to_page_array()..
but that cleanup that I haven't found time for shouldn't be the
problem here.)

BR,
-R
