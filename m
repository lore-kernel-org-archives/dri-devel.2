Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACF6CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 22:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99C510E8BE;
	Thu, 11 Jun 2026 22:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="FDSJxjU9";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209B110E8BE
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 22:53:44 +0000 (UTC)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65BJt0mP767669
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=; b=FDSJxjU9lKGB
 zYwQmQEO00hYYEJ0A/ovopPo9d7CqKqD1XADgRLIn8Vqp1BtdkAsscjzjFBtTOm5
 diVk99kItK4XNYmeAXC4rJxohR1w4XfXN9Bp6eaanw4NKiAW4gyJmERZSpkYpCSp
 omOvIhSNxK+sDVYMbPZyhsgC+FkoO1ml34CzJ/gxKRcU8wmkmA9aQAC3EODqW0kl
 lDxIU9Q+19d3J+fSdA/QNT4u7oggrCXALTCFp2seGU1YuaR3sFJx91cwBUas6m4P
 Q7RVyD542fkWdg5hhoszqMfbGG+JSljRyZ8BmrK8G5dKPiI9D7qpr9eZb7kxJzyG
 Yl+tOZEnCQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by m0089730.ppops.net (PPS) with ESMTPS id 4eqe7xhawu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6eeff3b75so657474a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218422; cv=none;
 d=google.com; s=arc-20240605;
 b=X8CviBTQbn3GC9hAedJM/SisbKwNgNaEGnq89xcnzAhmtE/tp4QJH57TM8tFzachNA
 yjbN4JKkoo01Q9QjuO2CurkXYwX59EIzwG33I/+YwAzaSJYveEhm96CBTZDH4yelOZBw
 W4Am/xePqHUwDea7MyHa4oL609punRKw+M4jVG814xpbky36zLjuU4T1kx3vpTPBL0G7
 Aas4c/WoojgDHmSHcVR9XfMAARRMWPBvfCABtezAeFuTWksJ1IoWpEjeXA44981gPsa1
 RJjCXkZtV5P98J7e1OVzxPUdK8q6SHq6vTfxgTB51L9VjpQy8GUxaY7d0GxiV6YmWxnj
 wbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
 fh=B99zuzDosFL/YbokuhGLp8PT0zXI5LRqSUekzr1zt5g=;
 b=h3sfpJ2JyjDnhDoq25IUXo3BC2yJwH9J0C51t08YcswwoyOBXfzTpYB6K0oAFcup3E
 8WgUw8PeDf0WSf2FIq6ePfqTVqegJJkqfy7ebI+qh/h5e818gtpwHA5qk0aVEYXsQ4fL
 oyuIBssKXkuL96WFe+Y4hpVqiTt8e+7fis3tGN17KuM3xZW8VoMDhqCJJc+sHRnAXoLt
 Z6kmbOg5P+u5H8Pt1wAkhPBJd2vIETgM/ZzZKVx8Kw8mNiufHgqi5YiVhU9LIMY2XXNA
 voKjOF8A2UvOk2igHSdSQBwg7VDnbKPPvRnB46RYSFQQ8yc6QKjD4c9hm9jl1BqeruQ8
 LcOQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781218422; x=1781823222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
 b=tXw0KuakVAJQ0ITWnubxoYm5jlrJjrbIEmeJt0oi5sdiZ6jzfs6pF8rzR2epWku3Hi
 8ebOITft4+NnpAaNd1vN4cto1U4PP5aH+7AcPKoIlnJuyJQTj0doXDKWwjucxDNm1eDS
 p4tm/v3Q0cD9+edU0ZKVTNHQg43PTQUiz0RKEDVdl5coEE+sJDALZtl/jWGe/F0NxFqS
 nPMUAjuAmDoL2SY1QAmwWz/WPQsLPNPFMeqJ4dRqtmjPrudrw4iOdat4DxH72MvcfwWp
 +mBjQpBxtBOrHJeh9/qZirtXhHL+rJbR/imUB7RnHM75Wep/iQTI2CTy4ST94O9bTqK/
 z0yA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iS1GwEJmeGl2Smn/c4sgvOxvR7qiPJx/aADqNq7l81XUwyd2nHs3OuYDvy7JGX2UGKVqu66EMS6o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7hz7JJ2AGhu9urC7/bgfalhQbCVovjJJnEvoc6uURmGgFkgm8
 RMxnuUjuPkvtbILbTO0T1+PyFq7pvSwuuqb1h/3L1hjQUd5NNygKqxb04eBv9IA1bX/0x6rHXgD
 VuX3Ikn1Ql0FnWEwWgeNGtBu1uTK7giFqEteMCevYhsAnSLczd2xF2F6hRqGPWAJBwdXF7Gla75
 Zin5pTzzscJRGfHqJKcUwviiss++ITnXAGxB1gGWBSjhk=
X-Gm-Gg: Acq92OHI3DZm/EUXgwzjJEuKH/ANG4NHUIQi5brb8EWm2IJ2SqIGDvnFPewxQj2vrK6
 dtCvjkIcrxbASK/vo8jn0b7a4rDeTL0gdlLGZgTkRzZHFDPc7X2MXSnqW+gaWkHzhP6C0VAAm1N
 S+YQ+eDSlQd3mGJEWJaAj1lbtnvLCsaqaC/snk+S3aoCdXnJWDwGWgVSkEBQ/7LbkQX9v1HcIG2
 yCnbc68MymZNwI8l/G0Tw==
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id
 46e09a7af769-7e7847e1560mr60109a34.22.1781218422501; 
 Thu, 11 Jun 2026 15:53:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id
 46e09a7af769-7e7847e1560mr60099a34.22.1781218422119; Thu, 11 Jun 2026
 15:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com>
 <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com>
In-Reply-To: <555912e9-818f-4906-a883-6f14e0790672@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 15:53:31 -0700
X-Gm-Features: AVVi8CcTcZoIZDdh8OjH1IktxPjhUF1A0IE6AmeFSJNyea8GfNww1HwPJ1RCIPA
Message-ID: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfXwAXSPLC5QEGu
 DzlusX+/vuzkoad2koWqFbN0xzKG6hCgtNAmJt0/lKONt9DShcHN3+/hYYxHdVy9YYYygPqPo+N
 UAlBEL9063wvOQ20f9nfZPm9JUs6DOw=
X-Proofpoint-GUID: Y4-W0Z9YXBfpuuO0mhmararHVxTuLKuH
X-Proofpoint-ORIG-GUID: Y4-W0Z9YXBfpuuO0mhmararHVxTuLKuH
X-Authority-Analysis: v=2.4 cv=Zagt8MVA c=1 sm=1 tr=0 ts=6a2b3c77 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfX3akFgz45AaoV
 H+lWXQLwmv2V6+rJOHv1YX4lNyTKivLxnxeDyf4Emo9qEZd25RMbG71Fm96REp6opuZvtqAm53K
 qcrZwSSZqUuo3QX9cy2awQsYuHtycJ49seBkoHgiIVQhk4c0dYIchNS4E6nQF9KcUhoC2SNV71F
 cqSLoi62bDpIEm3snbbVoapU3sn4LkR2QFNMebw+jVmc+AHb0c4lY8mapcjMb5WiyoWzP0KMIr3
 ifZKfpj3fFsSibvg2bNjI+VN7CWromXYsmCvRK//O11rLq+CtycmsLBB2qeKyzwv7YwD/AdnguW
 YI60TIz7YNAw+f1FMDNAjBXK+y0rtNFeCZ3I1mz1jh2i/YP8QFYrQQNpCiC0GFrU7W03c06AEuE
 JH6xTCdr8pSeDXS3Gen57fxiHf7SRDzjJtTmE1OElThegp3VgfFIb5476HAOytrDJ9eZMVUmJCi
 ostbe7bndTNH9PKCmwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
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

On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > When the last reference to an ST table entry is dropped,
> > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > therefore accumulate one struct mlx5_st_idx_data per cycle.
> >
> > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > struct matches the lifetime of the ST entry it tracks.
> >
> > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> Since this is an obvious bug fix I think it shouldn't be part of this pat=
ch set and go upstream completely independent.
>
> Regards,
> Christian.
>

Sure, Michael replied that he has made a patch to fix it, i will rebase on =
top.
