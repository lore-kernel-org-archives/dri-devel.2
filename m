Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45E4C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2046710E1C6;
	Fri, 10 Jul 2026 21:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="RYK35fQ/";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9BB10E1C6
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:13:44 +0000 (UTC)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK5wtn2393633
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:13:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=RF8cFAwOnRSkhH9D0DDvmvcNKGy8nfBCbBtEkVfL0v4=; b=RYK35fQ/CwFt
 9Y6liH/+T+e8GjLaxejo6rcLnWNoms5TDAneieLNEs3hl1aa2PsrH/U24euiowpl
 9luuMEPbfvWzkjV6f+XoTtHYas77VVD5ZWtxfcDX+6WYOimoCorso3lVvOn7BFr8
 jgFGWDg5+s368ZiJ1y+Idu0Hy9dtSy4mLqOl1ApPtN0Q4jAwmaMMJYd/7GaIeqHq
 hRwsF7KvtNf+HLABfW3TP0f6XjwilIPxO1af7LFe+Aa3IMnPKCrPiujbH+hMKUIf
 QrfNgj7RQdzrvELzpA8rSXxe86AHthCE8wer5/AyftFWjSgImjzNasXhC8aOsEav
 +4nOGAwTFw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fafasrsg6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:13:43 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7ead3468408so922905a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718023; cv=none;
 d=google.com; s=arc-20260327;
 b=qXMOrs3dOf8k+3BjzUnr5xx4yHaGvRiGyIe6y3hbXpUgWHChZnPN24y4dMQZkIaUBG
 XLr/jFhRbf+qkZAOlQ/K8nU4Z+9fmViB+UJrIo9R1blk+L5ipku9eoE6CH+5sDR7Pk9Y
 J9kimyaww0hoBeBixZqi38VwNkwfMXS8odNeSZ8HgJvWSWvK0gOEcHf9hflhcmD9uD5K
 tL738ycpQT76tSJ1e4ctIJ4JiR/3vmbxquQdavBa8w3VYYjyTW/M1SuiYvJmSXmFelKf
 t+9WQ1t+TZxjIQ2w29AetldJahsUR7Ax/UfogheSNlnjFwt/THzY9c7MNbeiLScOLXUv
 1Hfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=dzINuCyV1AjhEQXZagg0c3klT12KrUQB8e556Tlb738=;
 fh=rW2Wju+U2lO+tol/WxMdAJPfOanjr76UTskMgkroc0w=;
 b=KN+SQWYk4Uz3OVdpv3/vVB/I3daQOUyIJtfrnmeh7rVcXX1hn5Vr707agbmibiNUOa
 Z5XCOgyv8WV8gOsqmwtqMFyViq3sGfMrIFh1L337oMx8Z8H03xjK4oaCMRFYuzFRDPEr
 YYPycvBxJTw7PRHSpRuIIOOkKcNfo53K4eN+tu7CQg+Y6lLcSfhKebaQMMRBfddvNcia
 Vaj8lNsHtmKJTR8+Y4iMnPNr3B/kLUfx/tIus5iKjzs69mR6bvdpibITYHCBqxoNAOQ5
 s6DFgNaBVNLtXTnHre+dGD7xgLlH0gosCm+S3bsnMdXoBHgcNiGmwBXz7DzSBqLyrhmX
 BSmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718023; x=1784322823;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dzINuCyV1AjhEQXZagg0c3klT12KrUQB8e556Tlb738=;
 b=ETulRzHi6OMztsQqcQeAeN7FPmz0YRGNMU9EcPsWe5JT+H0bJ0aoPIIwRgfJUMPMCc
 DN6GulshxR1p2bKk5ZSrQGT510USCHym/oRaKRyOeVyb2FYtPKMmPB9IGYf6LMVCNlJR
 LrnmD0CN4ZF3EmIX5RcwOzYLbwrFY7vslxnfLX2nYsESSVErIxoBfdaL9zwXyxIW9T+r
 0wcQL2lBJMXifaXmI+pbGqRnEdn6yVq0/x1DvCW+7cewSQSnoQhdkg6z0vkV2+IhwNrs
 E6efwIWlMy4AYgW0/So2SeXAHds641/mSRlm54S75Yu7fXGQoHF3Nj6hdEQbcspHLlPt
 SCag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+owSAlZ0Em1PRQMJo+Fcd5QB1TKchIsfyDjt5OzrrW+8C22QKuuZcSmQhwnobqe+QCfO5PIFeJnpE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfYIJa7PuMQUUmLpmMq2inyFHUCTSsOBJSxbMsMuUMgLMZ26Z9
 oj89FceFeUclwLbVRhYMoZE4DQ+zEC9Gl93Cc6ZiyRtWVMVUuIdWJDV9rk684J9aZKyiuAlH1Nc
 idStHqs8Po6au+kJ92scRDzN/zTeExRNW2/4oSPq3sGxgQZL/SEOjsXmZt6NYKuN1/APeYouTEh
 GLZ/z+VaVxFFrL72+sQXF4xh593UjncDhfXAmd6FQaisQ=
X-Gm-Gg: AfdE7cnxnKs1cSnJLPSkKr0355p1UyIROjPdg5c29HNsIVOzIBsKcCWzfBxYAqCNUiB
 ohcvinaVHuD/5Xbdpl+OO6ZaQ/EFmk4Nun5WflGBv9wACgV2LWE/glyG+IS+gMzzLYCY8eaCgn8
 eQzgt6ZNkJcPKRPNrCHNrv9RJJYq4O7J7RX7hU678cvEIvrNX0NpiMxfxgADjAqb3Xo7t22qYfy
 oUb1jqtEqk=
X-Received: by 2002:a05:6830:6c11:b0:7e9:b772:9aae with SMTP id
 46e09a7af769-7ec0981c52amr316865a34.23.1783718022934; 
 Fri, 10 Jul 2026 14:13:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6c11:b0:7e9:b772:9aae with SMTP id
 46e09a7af769-7ec0981c52amr316843a34.23.1783718022507; Fri, 10 Jul 2026
 14:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260709132602.6a3fb084@shazbot.org>
In-Reply-To: <20260709132602.6a3fb084@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 10 Jul 2026 14:13:31 -0700
X-Gm-Features: AVVi8CfXe8KvJ5Z7sUtkIYqefn9JRiYpvw-OvxoKOz-vRkAAzCUP8YaHHQIwWXo
Message-ID: <CAH3zFs3OwPyTrWk7oaMYETq7sBEQ7VRfDtzWWamhiE3AJzVShw@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxMyBTYWx0ZWRfX7GB3nV7gGqJh
 R95ki02lyuaeIbym/3EJiJd/afBQkO4YfDJxUvZsabxkBj4qa8KrLffV1vO7Zdcqo50EG8+5o6t
 A3Q2+O86Hz+Bmg42cRtdq0EoK7XHZa+X+FAtKXCoEd1Gip1xzHpyB4FUZE3SUG1zNVzP1CTaFx6
 Hjp2R83nsR+5Jk1GEPNE2j1X7FnEVvg3a3V8XAziGEwbOhUSjbUyJxVCxJ69RM6J4h8XQDttTf6
 JJVowIYlV20SCc/xp/pYyoWQswU8kESSQP5Q2An4mxhipef6MmUKIL1UrtuMH2J9Izr4RWPPllj
 LtXeO+nlhBuXpJ7Cq3iYDhi1zViZzKUZOPtZa5Pp9XkyuIUhQ9IYKmzYJLT8JXbAP7eTgLpbo43
 BXjyKLu2jahsmtI49+vGjyXPsOfHiC5pKCaWqwHpWABZ2v11CfR871S02AqKpjkY83lHVJj7r9l
 X+mvP3tcXGAKKCyW+0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxMyBTYWx0ZWRfX4IR2IwCuB4M2
 G+JLB0ogYQy9HEU9ap/wsj0WWsl761DstayFHl2uP84Vz8GIquJRX9x601Qx7X1Em7rDmrNK83w
 jTvSXC521MNNFa5QSAU/1aD9cU7dN1E=
X-Proofpoint-ORIG-GUID: H9Oh1-t0QKLv9Zy5Gp_-r_HxtK53FRCz
X-Authority-Analysis: v=2.4 cv=A/lc+aWG c=1 sm=1 tr=0 ts=6a516087 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8
 a=FfEKJDObtavKmf3ECVgA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: H9Oh1-t0QKLv9Zy5Gp_-r_HxtK53FRCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
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

On Thu, Jul 9, 2026 at 12:26=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 2 Jul 2026 11:10:13 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Changes since v10:
> >   Patch 2 (dma-buf): Per Christian K=C3=B6nig, document that the ST/PH
> >   returned by dma_buf_get_pci_tph() is only valid until the exporter
> >   invalidates the current mapping and must be re-queried afterwards;
> >   note added to the wrapper kernel-doc and referenced from the callback
> >   kernel-doc. Also add dma_buf_get_pci_tph() and dma_buf_ops.get_pci_tp=
h()
> >   to the central dma-buf locking convention.
> >
> >   Patch 3 (vfio/pci): Per Alex Williamson, update the vfio_pci_dma_buf
> >   comment to note that @revoked is additionally protected by memory_loc=
k,
> >   and describe the READ_ONCE() rationale in the commit log. No behavior
> >   change.
>
> Sashiko has valid comments[1] across most of the series.
>
>  - Passing through 0b10 seems mis-categorized as High in patch 1, but
>    is valid hardening if tph_req_type can ever hold an invalid value.
>

agreed, not High and pre-existing: get_rp_completer_type() is from the
original TPH
support and untouched here. I can send the hardening change in a separate p=
atch.

>  - The documentation error in patch 2 is real.
>

will fix!

>  - Patch 4 ironically fails to re-validate according to the lifecycle
>    requirements that patch 2 specifies.  This is a significant gap in
>    the implementation proof for a real requester.
>

Got it, I'll re-query ma_buf_get_pci_tph() there and reprogram the
mkey's steering tag,
so the lifecycle is honored.

>  - The broadened scope of the existing memory leak in patch 4 is
>    already addressed in [2], ok.  Maybe should be folded into this
>    series if mlx5 isn't going to pick it up separately.
>

 [2] is already accepted and landing through the mlx5/RDMA tree.

I plan to keep it as a standalone dependency.

> Thanks,
> Alex
>
> [1]https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260702181=
025.2694961-1-zhipingz@meta.com__;Iw!!Bt8RZUm9aw!5x8TPHfbpTXQJ872nmZaHsPIXH=
7HsL9ICbZR3G37yKkHgB-RukCDOy3XiLIOhfhP-yTczTyWQmud$
> [2]https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@m=
eta.com

Thanks,
Zhiping
