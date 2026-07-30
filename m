Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47589C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71A910F185;
	Fri, 31 Jul 2026 06:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=purestorage.com header.i=@purestorage.com header.b="THVvao4h";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F0210EFC5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:17:44 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-451f74ebfb0so5320fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785428264; cv=none;
 d=google.com; s=arc-20260327;
 b=YsQspLO+abU86f2g3ISH13GD/sh2X03ztOXhJ5+r2HGNj5GesqU683F78dL4/XXpia
 kjy7C6TvXS/d3oueOOT1epul/tg4D7yAKOfh4XwTHhZu8vO//Ry56E8tOzR6iXpBESRn
 /307EcPYluQGu7wzGzk95kBIQcc9ZW0ZUyTBe9baWGP5sHdSzzpBmDZGvQ1J/wNOaVd5
 46BfJFU2Y16H6S5nu7om/Fbjh84t4MMJ6/kUD/E8iAM+fPVnZBmFKjvgPqVttwQ9Qp/n
 rSKHV/H9PM9xXayyvS0FCeubJXX2e4r9hrte3EGwpN2Obryuo0e1Th6JtyURBQiaGDun
 P+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
 fh=erm9/VD/xE2I9p5WB8C23H7V90l8KV+iDYnLPI31Kg8=;
 b=i28peVwjMtNiLOeByn5ZnzXycmK3Th1GhOr0BYvDhw4T0zTivP9o/I1yzcZuesZMRL
 1pByCjDFvIShLLiNK00EW/4z+heoBJOo9VyBjMMS3GH1i44gPaE4kCXgt3GCm0oEGmJL
 MkfDvlVQmxYuSGBPU5qHDVdRS2p0CFW2/d0fdCY81w1IsqxqjjvpPxZxDBlg+ojfm0pD
 zQJEQQV3PKkcKWkZ/tdRKJakYPcpbMFo8sTr4sWZYt0nc1KiQeYLJYUdDulE7/jLUamf
 WxHrTY0DG8S1XCWN2u+6HKcThTw+mReXA94SoRdsmrHBH+UgDjOT3bF7mEPzuoXxDERm
 u59Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google2022; t=1785428264; x=1786033064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
 b=THVvao4hzQXel/JDHZ0rCpqqj3CgeNaPhsEIWQnJW9L8vfo+x0SUDtZZ/Ivxz9yQkZ
 +QxAuoQwb2BUxNQmsDJFSnRdTq5Vxa5q4CFmnaH7Nf/HtyR4Hi4N667cFYCN1bJf6K/R
 ll+WsmHOEA+RuDxX/vBkZo2+qDStItc5YenfUhjz++m7ucUVPtWzWvbLa3pjJBnTbeJt
 g+L8fxwqZ1GFMeeLbU0ZligEZORXoCxsX6SAlJNTneyR8JdLJ7SeRnP+REoYQ/m5qP/k
 aWFWBXrTwGnRcLtBMJ/M6bqgKFC1Fz23EOQy3Sv1nh5unQ2zmluz0bi0kGwDz7z3GFl2
 lP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785428264; x=1786033064;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
 b=Pba2NjwWS6BTlxeiDPL8gpPok7lydjSBMdh2PPXm4gKdIHMIH6GXINx8JJ7MKCUKPu
 FIGIHa2MVxNyuKQZc3siCSpKMVQ5NYIo0vzsgYOOs0IFxgNVGcRdSexkcrg1J3I8wR8M
 QDrPppqeih5XR8yakkoGntrG8hwlVYYtqeuEaU4qqyS5L/EFR/sFEDU7PA+g8ZyxStnP
 RLqj8bWw6i4ZyxU0+Xb+2EvEFA0qgeGbdgkPznHccjOzMzHVKIl56EqT6gu7hEkUEUAF
 GqixD/ZjFqZL8uWamHq//uBu79UkX81M7AyGuML4vTWIWvF44puzIl+lqjgR4CiknTPS
 i72A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmBHcM0kVTk2AYj1IFDJjvXPEra60Y+iF/16GuY1XMt6qF1TKfDUOEWLxfxR5EVApmyDZgdOQMaew=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJQfTspf03XVvsYdHZZNw+F+4o89msq0o8oEd005V7f5atFhEH
 yaD0L5gstFY2i4dkMDhhGJierzFua3Hpsf2/bE4P6ScYLFKY6lwwyTqZraDiLFBoS0GhxJ4hdWd
 Ghq5MONGQEj+tPhPn/5BO8IgPnGkqbQH/uMA6+B+CHw==
X-Gm-Gg: AR+sD10clbLyRlH2zNnzpY0uRo/2evUntvReyF8ZoYVlSY6PdKlZqttszH6ZNpCGUMk
 9KVi2Nz0Wd7NzkwBbv7a4HItVEHHgLHQzTFy8+ZoKX+eMKImucu3OnF12kzLlOcF9Bh0YxUFpdG
 lfSzD1meWHZ9s2S17VuIUk/i1C22X9IFEMvVZ+OCH2QMJ0HpNqC50DgYeChBvwJTxy8CDCpzIv2
 2lQ3iXD01ca5FgTm059R5+tosy27E5KWLIo5m90aimtK2cMh2/eOyAXnM7vhg4r09fFgiaD9/ml
 BuUyhj/BHSgYpt06JVFg4QYNlyoIFIoKwXGeRLxF0tTq
X-Received: by 2002:a05:6870:610c:b0:448:8595:1e8b with SMTP id
 586e51a60fabf-458dd203cc6mr828125fac.4.1785428263717; Thu, 30 Jul 2026
 09:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com>
 <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
 <CGME20260730104131epcas5p4b52720519486f7ac774c317923a79c81@epcas5p4.samsung.com>
 <de4ec386-42ba-41c3-bcbe-1fe8b2f71ba9@gmail.com>
 <09134617-6d9e-4963-9319-1855e88a4df9@samsung.com>
In-Reply-To: <09134617-6d9e-4963-9319-1855e88a4df9@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 30 Jul 2026 09:17:31 -0700
X-Gm-Features: AUfX_mzVuCLkHKoQjKU1BgpL-X0Ty4OF1wEt1trnCKGouEKw-m3DZTMxHTHiuQw
Message-ID: <CADUfDZoVUHMWK0KBnznB73o6Vg+iQBBzJE2NmF1Tf22Zvh4=Yw@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, 
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, 
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:54:16 +0000
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

On Thu, Jul 30, 2026 at 4:36=E2=80=AFAM Anuj Gupta/Anuj Gupta
<anuj20.g@samsung.com> wrote:
>
> On 7/30/2026 4:11 PM, Pavel Begunkov wrote:
> >>
> >> I wonder if it's possible to perform the PRP list page allocations and
> >> initialization in nvme_dma_buf_io_map() instead of the I/O path. The
> >> NVMe dma_pools are per-NUMA-node linked lists protected by spinlocks,
> >> making them significant CPU hotspots. If the dmabuf registration set
> >> up a contiguous DMA-coherent list of PRP entries for the pages of the
> >> registered buffer, any command using the dmabuf and requiring at most
> >> 1 PRP list page (i.e. length <=3D 2 MB) could just set its PRP list
> >> pointer to an offset into the dmabuf's PRP list.
> >
> > Possible to an extent, predecessor patches tried that, I left it for
> > later to keep the series simpler. I guess chaining won't work in
> > general case.
> > I mentioned this to Kanchan, Anuj and Nitesh before, they were up to
> > playing with nvme optimisations in general, and since sgl from Anuj
> > is ready, maybe they already have a prototype somewhere for that.
> >
>
> Right, I have prototyped the PRP list optimisation before. I will send
> it once the initial version of this series lands, to avoid adding new
> review churn while the rest of the series is pretty settled.

Sure, landing it subsequently makes sense. Glad to hear it's already
in the works.

Thanks,
Caleb
