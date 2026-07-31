Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B67C55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 22:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E62110E0A3;
	Fri, 31 Jul 2026 22:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="FUF2N0Ff";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C2010E0A3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 22:59:28 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VMWbEm2439325
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:59:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrA
 vj0i34=; b=FUF2N0Ff8bRoI+Jm4n4FqP0UEtfp2ZafABB+ZLlVHxt3/n4mCu9ji
 tmyxKNmYnX02kKgIzt0D6oWqHsCR/pV7Siysc8tevnCjpRyn3Gaj8zpE3MTkzEpi
 JbkNSKFBfbAdcskM38ush7GML4ZLCte0uuKQsbFLbGQfF/KeHa0erD/zloXr2ROI
 2AcS8a6XIy80Em87RsUtY6SWr0zB5JnmeGRZ6C7E8olWq6tpJQAZIvP+Snodglwa
 rjz8oiOujIhbDetPlVi+T3Bdit9GkMDR66Mb5drzUvjTtoqwuDn76UsltmTSxKdb
 FzgJ1fIASoS+LL01Ez+/4cm54Jds0ENhw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fs0dshjgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:59:27 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e6b5976d74so1986657a34.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785538767; cv=none;
 d=google.com; s=arc-20260327;
 b=IbDRp4sAyZkU+qeFR+2j//CZxbFGVPH3QVvJvhg+R2+zjy2LWv1QOufM+QkUrd31Q8
 QSb6N9iX6LdqFPD4fEc6W7rmIvWhWEXPraJOjW3p6nppjWVRXeVMs1LzDBFh/WWsfYaF
 mUpGEqX0b0xRYWT0SMptoarGLzPXgusdnSouwi9qU1QUm5PjFxlPaKL89gwxtBk6Vm2d
 xU2V9c4+KEGEhK+qNXzBKSAplJmKbC588a1EjjIPMX5681TFHC4VcfMKJaggi1qdyVSE
 nV85Fpw1MOicdLwifAjPapbrHgBU0rPLCggQFY8OG2h+r1z2ZCEWbh3QrF0oog4a4+E6
 d1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrAvj0i34=;
 fh=4FnFXdHymu29h/i8Jr0EssW96bb8AYHHlgHnVOxFurE=;
 b=LE4op49lNc97Ogo9TqB+ivoVncWxOvu4tmFyAX8DxohAo0X88Bsu0LX3VEZmexJ/Ca
 TPgvpkNCHL6t0Kej5bGM5FTm5kZ5Z9bj/Zbxc3+uhs0Fmj28JpsVueBANkwpeLhiacAk
 l1dp79I+zLM+O4pV502m/vRWK7Qz0ISGaonvUjiFBdnRQ0Xmca1FGm2IjMV0zTLVDNIk
 77pLrqqH7spgw6gCiY0/yPxBE0ceuV/EWfE7EubgwfJyrOn86g3BRN+9RA/QBgOv7wX3
 5/XNowchnIeRJo5Qmyfpep7kG/N/OcTm+RFuqZ6gQRC14rFtGJPe4qMixCWiZzwJST+T
 3kBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785538767; x=1786143567;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrAvj0i34=;
 b=I1mVKYSKKicID5hLv0za1pCHNiVEIQJVPbq2elsFDODClzRyp1xm7VZ1V9VNe0v2AN
 IAMoAGowHBb+JuX9jlKc7IRHYAcenRqlEuMgr1DLww4dwteBKjjDYP9emkYvqeTGp3QG
 vKrZ5f54h1TAk+VwTrSItUzBvtD8J0UYyBaU5H8fOKxNG2G+5Sq782lCdcSO7sAWdW6D
 ojAD/CXS3ElTgfRkKTj3MvyZxA/JVeRm4CBKyooKbmQVlDQ2a5cKvEjpSdXPtPDhC9ZJ
 To4YXf+RibpmNamj9TyUmS+ADRt6jGwRBbxLsMkd4F/8PVgCu6DvQ5yEOi6t/6U/qz9+
 pYuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrA2MuFGtez1SetVOA4RC3/JXIXpdBqFTpcBNqcroRTgijSnkSgVymwira7u7hIwN0Fet8ycWBCH+4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBAIPHVDDudNJ7NZk8z7buswKjwRAGxb0xGKxqRbd4JxRJz3Kg
 bS60Ux+9OheoYyCIOZMuDklbbLXd1LQrBSRqV/meHnkkutK5VaSoyFmTUjbkzQ28ajx81Qkokjm
 StxlHe87FbNcNXWdvuBj6BKpnwtvx+UByChwhN3mbUK1H9Yq5LWOZntDpsEYkfwspzoEwky/IX0
 3cAcmZcPOL8KCuDWdA4wC/IppHkg7pD3Y7xGnPaLDW6/M=
X-Gm-Gg: AR+sD13gz/UoItXFetE6k0p47f41grSu2SjvmXQxlCdk/v7VyDzCOu6bmSt5LjA2jfZ
 ZV+K6P8seX1lLgywnpo2DHHZOv7UogH6BWbGyZpj3OMZ9ESJJX8vwyXGmkCarGVk/+5IgONiGL4
 vwiy7rmyV92tLWka7NgtXfV9iNrdXQPOT68WBmNrWG0/lorE5cDjPTRH75QtrmlShsiq/C4JyK
X-Received: by 2002:a05:6830:67da:b0:7e7:5e4:ee11 with SMTP id
 46e09a7af769-7f196f48db7mr3826372a34.16.1785538767010; 
 Fri, 31 Jul 2026 15:59:27 -0700 (PDT)
X-Received: by 2002:a05:6830:67da:b0:7e7:5e4:ee11 with SMTP id
 46e09a7af769-7f196f48db7mr3826328a34.16.1785538766468; Fri, 31 Jul 2026
 15:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
 <20260731214821.2A9AA1F00AC4@smtp.kernel.org>
In-Reply-To: <20260731214821.2A9AA1F00AC4@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 31 Jul 2026 15:59:15 -0700
X-Gm-Features: AUfX_myHxlkqFnSLC9MVeO-2eucc1qmrR-J0Lg2UWhuCZpzuHdreSVtFADd0gQo
Message-ID: <CAH3zFs1Nhp2vWnoyDT6RpePRM3=JV9JeMuWz4jZwbnSTx=6PaQ@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE3MiBTYWx0ZWRfX8jpxF0H+igr0
 OcDJL4x6ALwr878YxYjT+U5+qDrcXVLoXFgvfSTNjHKzAj3TyEOTRHgq5plPI61YCdiiDaPa+up
 lOG2PC/V2BkwqbN3L5dSkue1DcpeH0sjE+IdOa/dVhwnlcNtwooaNPBvs/r5oYzDpFBIcWWe1x2
 P79Vl45zwJsdsGPSZEuSuH/xxBDwZx5q7VvPeSstzp7l0fDcMzq/6ReXXeT20rVz2t9X91MM9i4
 FSO08CIiG9/+l0u/Fmf2iBlkTxh18HSuCTjqYWo2IG1sdFE6dmJl+dPKiozvpdJLpnlVu5Pp04J
 nAdKayITMuJ3kUpGnSYQWRZf3YAbi8/Yw9VtPeb3ev5AG4T8lsGTj3wb9amva64FPn2zgXJHuJH
 RHs0ErpiHtv6cuddKyIqCYi7xKpnAUzFz/sDObg2hZmiprGtIH88qgEOTTw9hFW9s//U0I6A+hc
 ljYblBPgZCrhGCZYv1g==
X-Authority-Analysis: v=2.4 cv=Du9mPm/+ c=1 sm=1 tr=0 ts=6a6d28cf cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VwQbUJbxAAAA:8 a=So9IXvp4ApBoCZzCt-gA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE3MiBTYWx0ZWRfX7oxV9r0y6jCk
 0WobWyE1qoJ0HjOXGXT7XX1wgIHB+sGOEf3OvjSCUmPAN6XYHt4OE898ciicZ0KH9xP57kJwM8C
 W7wCRhEcHheQHYgnYwAPkOGYpLqaNhk=
X-Proofpoint-ORIG-GUID: wDZTOOa5gidoRhRQnZ5FZnIvdeBNm0JZ
X-Proofpoint-GUID: wDZTOOa5gidoRhRQnZ5FZnIvdeBNm0JZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
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

On Fri, Jul 31, 2026 at 2:48=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
...
> [Severity: High]
> This is a pre-existing issue, but this patch introduces a new, heavily-ex=
ercised
> reachable path for it.
>
> Does mlx5_st_dealloc_index() leak the mlx5_st_idx_data struct when erasin=
g it
> from the xarray?
>
> When a steering tag's reference count drops to zero, the entry is removed=
 via
> xa_erase():
>
> drivers/net/ethernet/mellanox/mlx5/core/lib/st.c:mlx5_st_dealloc_index() =
{
>     ...
>         if (refcount_dec_and_test(&idx_data->usecount)) {
>                 xa_erase(&st->idx_xa, st_index);
>                 /* We leave PCI config space as was before, no mkey will =
refer to it */
>         }
>     ...
> }
>
> However, the underlying idx_data pointer is not freed with kfree(idx_data=
).
>
> Because the next time the same tag is requested, a new struct is allocate=
d via
> kzalloc_obj() in mlx5_st_alloc_index_by_tag(), won't repeated allocations=
 and
> deallocations lead to an unbounded kernel memory leak?
>

This is the leak fixed by "net/mlx5: free mlx5_st_idx_data on final
dealloc" (df6134b527a8). Sashiko appears to have applied the series to
a tree predating that commit.
