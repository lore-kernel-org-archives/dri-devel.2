Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F36CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E4210E40A;
	Wed,  7 Oct 2026 15:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSi98iNB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P37UCwj/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A3F10E5C9
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 15:13:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtPmr041039
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 15:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=5Y3mvlPgWnVhVrSmLRzbDGbZ/FvqqdhHvWuSdDemWX0=; b=kS
 i98iNBmpK6Komj36szarrvC6suf5CZ6Kh4dWhgWXLkJV0G2t+T6qpoKtysNp++3W
 WwU7aaKSyy23XxzoNCgSgrGfSY3JI7mO6jnnDNdRuTzRzpRvDmLOz8Bqu/LIzyOW
 4ez2LJUjPNvThA0bBhKHXuD0azIyDa82lU7GgthU8JLqda60ozoc85hwHRUxhIjx
 /+xThhJglZUlX8gBMTrSxMujIzO3HX959eQ3Urfx/gxgTiL4y+Q+v8Eg4XBjygQA
 53rpeVrMxoxRXi6I6n6JDOzNvQ7jXUecS3YL8fm/BC7fGrhsspy+14LGX5Hm4kRE
 aL59suyZS6LmvK9RavVA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdcsqsw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 15:13:21 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-82315dbce25so3397641a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791386001; cv=none;
 d=google.com; s=arc-20260327;
 b=YV7uoGhKMsbDSOcwlc+7dRwsdxBfsUfcceLtPak5v1Atr6MGLxglk6ZWRqS7XeC7h0
 aFgraxAIryUJQCx+MxHFtY/H/uKj7Vi2cF+DgiXI51ja9FKrThnKZjjMTTs0gASQgnSj
 h6eiDEpzL+wPAMnohLnsfJnHH3SrWkH0zCfS4Hf2Clztfhm2I4sMRJcsA5kBQPkfPwDX
 OnuqzaphJ2st0WCWK0+0z56Yfphpou5fPy2yIq0CrnHyfqX7ivlnKOWt3Jr3Boqq9Rfx
 S+zCZbUjbRuEIPXRn8VxN+T0U2GGvhBsgc0xWJKSEyb/kL2upO0ZkhAXuzzXyNjHxUim
 IWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=5Y3mvlPgWnVhVrSmLRzbDGbZ/FvqqdhHvWuSdDemWX0=;
 fh=LU90nygyHqMzcXOtYf0I0ud9oKwP4F6n2cfTKa/SeDw=;
 b=C/Dpv9d677m13yQ/SmhxNoHZZH3Iuk1TYvR8CqI9Xunabywdg7BUEJN3YI+su8M6FR
 DYDFmYj38qDZ5/xzRbmB1eoem9B1dBWl/hPj5+odEEIrXhRndJTFwWMp3HxwMeZUuP80
 jYTPSGOzSDFvbGlyhdmc5N7suHHaInvoiPtnAZtSIgH6nztN3mgdAK3jCPbvwQe3VzX3
 m6lYPmFxaK/f5O5vfIRD+QStrx/EBASVt3hZbmRLq/LeDjGvYowCyp8z6GfYQ5l75BzQ
 PiDsAeK2Gw+UEYOqk8wOehmdkz4t9QeW9WxH2sZed6z5MWfDjnDVN4BeyucWjlhjL3rb
 aMYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791386001; x=1791990801;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5Y3mvlPgWnVhVrSmLRzbDGbZ/FvqqdhHvWuSdDemWX0=;
 b=P37UCwj/WZVqbRiXRoGAxqIW7mi0mPhHqiWhgl5NzdicDCi90Rr1JqrUydXs32nDgH
 /mJsFwI8BmmDxsQerJk0Ge38xcy5qn7ASau+X1XxLrf9qdagBtmWKghOm8OL9cjQ/rh3
 e+h/eZ3WD0tFqNNcp3vt5Xb+pUI7+W7o0O4cX4UWjQSdzdvwWhwNaSBnkFfjgpbGKUUk
 mP/907UjwP1RVjFz14Ihq5A1jmCexHa63mLyN3j8mKynKPqb33xtOJpyU9Z2iz4O+G/d
 yZZr4juMpcsXP4pp7XSGv021KELlq/12ytFg717c7wI8v/Poc5Dtcd+3p1/1xm0HddhP
 EZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791386001; x=1791990801;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Y3mvlPgWnVhVrSmLRzbDGbZ/FvqqdhHvWuSdDemWX0=;
 b=izU41tJhA5CDIAbOEY1C52P2SWPx+AnpD9gzosCD3qJbJqzWbBhJElYW/Fkm0TCPbD
 /lvem869OUvUwtE+ODfjn92KuUffnkzBShfFMafuR655ikcypY6ThYUBDuVQiVt+j1hh
 e9nldGY8/x0VEnHlJQs+4gHG659umFRpe91YvVR+aTy+8IB9x1H+YV5zHXHYnB0JFfgA
 Ql4uAqqNa/SVvbuQHxez7c7k1BNMWr9M4CmT5Xv6BFZftpVMkIl00NRWuTy3ohE7D6CS
 bDBVuYK3CnK/8QhjzQdn9y3Zy4i3DOOxuV2Fv6lr9UM1Jn5RrJT2XIan8SXL18pnoUZt
 4VKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcpIxkwbi61jibEqwSe2MWCC+4/70HhIwQ4BmHSuPj2Me+YcjGB2/vyi9lqiWJJN+W4IEPWRqB63w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n2kZucOH7X7MT/QdcCukLoeIj6d7xMaXAJl4cywQkg9ztLdHiu
 G9EeEviOr4i+8QYfsCOaY9+an3de/z1fIhvSAUlhv7s195TsslZNbiP8yQYMFy2xZKBWtzFXrRH
 5eglDjJYtN2p10O9so2YiVbxUBW7uQuNJfaiLjjD7G0PF3dogG+vCiBc+cfSBY8DbE8VgAkUESO
 vyKylk867fkbUy3CCWN41/dh731qUlyqeKDXgZRbDbrp7KSA==
X-Gm-Gg: AYBFou1P60510Yfqk48rxrigx5HTGvhpUXtbcCuvsTzK+UrPy1XEwXADA5+VN5NEXVI
 XvU5/UbW7txRvgJaAIsh/6RZ3ud29KY5dVhhlAt90sH8Srnfj+yXj1pfUK52jmKJN8tyw35pQKx
 Ao0zr68+CDgoGWbKUFMqjCmDiefTfRbC/EtU6alQGtAHVmLk889P949U/w
X-Received: by 2002:a05:6820:200a:b0:6b3:61fa:102 with SMTP id
 006d021491bc7-6e7a8ce1653mr2316137eaf.34.1791386000865; 
 Wed, 07 Oct 2026 08:13:20 -0700 (PDT)
X-Received: by 2002:a05:6820:200a:b0:6b3:61fa:102 with SMTP id
 006d021491bc7-6e7a8ce1653mr2316108eaf.34.1791386000412; Wed, 07 Oct 2026
 08:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
 <20261006131000.81501-4-robin.clark@oss.qualcomm.com>
 <20261006131920.6870D1F000FF@smtp.kernel.org>
 <20261007051924.39963-1-kmehltretter@gmail.com>
In-Reply-To: <20261007051924.39963-1-kmehltretter@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 08:13:09 -0700
X-Gm-Features: AclHuK-DPg5smaCdEYcgCX8G5Ae8CeG9zJ66mUOBvXkaQs85IPOEuKUidxy3v_Q
Message-ID: <CACSVV00nzPAOEe2yTrt1n7_fpQTLmdxnP34Mm3ovG7rKZsnbTQ@mail.gmail.com>
Subject: Re: [RFT 3/5] drm/msm: Extract out map/unmap helpers
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: H7wPBC_4_M7d5nthsVzYi9Bay1_U9ZXx
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac66191 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=z0c7nXvavwv_fPd8bKcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2MCBTYWx0ZWRfX1pK7FhSU/+yh
 OKwYNoyxgtRqqpnOn9V8kggMjEeHpWAR36YUImGnMXJUy4f2ufNeDdtd+8vkIjqCOMRaP0PQ10U
 mYJtv72gdYvZZ2qXbRtBGSKROrLn9SQ=
X-Proofpoint-ORIG-GUID: H7wPBC_4_M7d5nthsVzYi9Bay1_U9ZXx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2MCBTYWx0ZWRfX3pcv9plgnLfC
 TBtHTLRoRjaDaBQwGeJOqPVClx+8o+m9PWTSWGMMJHND3hNEbSaWTBoeeX99QQovfxKzWhba9C/
 S/Q3feGN7tsj1YODCaNPib3a2nfgM+1LTSGq2qMCy1kv7lBgVw1R8YLO6OLK7z8gefzGNORR74l
 IVnEY6U4RF6Xe/d9TgXPMwXEVmyHQBA287aSx18UOR+NaYywzsN3FVe9vMn+tmCpzsv5cftgAXU
 LVzWT7ZYq5YMKGAoiMoN4xT4aU14P3XvjcCTBmlGW/MruB84L2puFLKmcP0VTkcyJsaGdp2vzrQ
 T8fnKkqOsLT5yvjlfHXC4xeRNp/IQSeelMbFZ6XxPaeGp+CRN9RiKZQLYWHej3lYTmZMJ8y++xZ
 9ag29Ib/QbGj34B1ZZrFmDhRsBdjJxEPrHa0qnOZruwHUgNP/G/ONL+cEDYBVysYF7eQiaOrXOv
 PbDMfiGyJ8TmBDhB6tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070060
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

On Tue, Oct 6, 2026 at 10:19=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> > Does this error path miss an IOTLB flush?
>
> Yes. msm_iommu_pagetable_unmap() called iommu_flush_iotlb_all() after
> rollback. __do_map() now calls __do_unmap() directly and loses that
> flush.
>
> An arm64 QEMU/SMMUv3 test:
>
> - mapped one 4 KiB page,
> - hit -EEXIST on the second page, and
> - verified that rollback removed the first PTE.
>
> No stale translation was observed because the device had not accessed
> the mapping. This tested the low-level IOMMU sequence, not the MSM driver
> or Qualcomm hardware.
>
> Restoring iommu_flush_iotlb_all() on this error path preserves the old
> behavior.

I have a fixup, but haven't sent a v2 yet.. current series is still
enough to verify whether there is more work needed on older
pre-arm-smmu hw or not

BR,
-R
