Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CEAC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F32B10F61E;
	Thu,  3 Sep 2026 13:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="QHgBR6KN";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D88810F61E
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:49:42 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-9392aa26b25so255747885a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1788443381; x=1789048181; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W0FzzBf86DLShcrb30vlY9xIuH5mW18Cg/ZW31lMTS4=;
 b=QHgBR6KNZ/n2AOBkBtGqNlIjIAdCq+B7Q2qP3GGdu+CFZmq0yYgSVD/zfsEpegHbJ0
 ZjDyKdexcm/nT5ien2SB1jyKDJm48ltxrNyMdqOJSjo608SV4D/3ryNT1+fzVw9/7gvC
 si+yc8JcbYVpR8H0bGukB8wwjXmPIl/vtYyRJX3w80gFP63OtdiLB0Qv0cY5SpbBFhqw
 csa77Roech8Uzn9HKdTRrOtpuS9ZdEF39dcb3cMfqQtQ18nJVTmua13mSze7lG2kOQ7S
 LRF4hraq9kridk6QZ7B+g1vEUIZWEw2U0wG1IGe1K2d7/aFdLN8ke4Y71j/eWNWwfcPp
 V49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443381; x=1789048181;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W0FzzBf86DLShcrb30vlY9xIuH5mW18Cg/ZW31lMTS4=;
 b=gMq3/2nrq0pGWveQBiyZ0lBbSimLebtBSstL6prQ/F/MilSlYt5PNl8Oe6hT0/nF/e
 K4TBZQu9NO0rkVyR2FKI8CIFE5r0fdERcM5LiX3XDfGHTGmFYHiAI2bxyKv1ANbiuLJ9
 1KSrjFX5tfd2Bvrg/fuUXGcjq+dQ9znS5sV5h3sjUsZO39U/drEjG8rButzk9Vbw+jvF
 sKhT5XXw3GFoipZOuRSLjn9L8uFN+rBPKGsUNbbJXFCtbzkKB3GEiQZYLjIN8k+n4l7h
 2+bcLtVbAk2CdBQZMDbQ4ZwK5stv2UxjqtguBySnpZKkRwDv5JSyOZw05GboDEV1hPfC
 CDLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzU2bPmJMQFExxq2fOtlEA29IKNH8osJUD3Rwv5YM08AvTYs7C2+lX+WcEuq0RHwLLW2HQEmAF+UtE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lZ0MC55Gscvn8LtGuetXwBdSnGCuamhUyBDUFDqakKfsifQWnn
 pwMw/nsrj+eEfN04SoNQxx4XBxvS7YicDtBw4FS1X9M8VfKRzjaaH3sIeODU6d2vlkM=
X-Gm-Gg: AYBFou2e+xXHiUiXw4PkiqbHz2AljlG8FsHGeD7EjlVfzWCL3yq2GUdYbMtFo57jRFt
 Md1Oj7OIZlOS4hyRmmIgteQU6W7SjzmG26CYKW3rNlAksV/J7zFGTE/fGtyTiqXLCq+/f3ma0SZ
 AV3yYFk4A145zzkra28TQlY4VifeuywTXSihJLi2UdUnbQ8VersIVi4qiygHBoywvvV8CbzHynQ
 TmbaGt03g0bLfde478Z20WQFccqUF/VLH4fAzz+wZIsdi2zp1CE6hq1JM0UBPXXL6agHnN2R7oL
 JYidCANev6z4OsKHFmkHWo1YN0Wp4FNPQ/W/LlY2LD0aryrQt6VSqpq0bl+GgtwEKE3jwiykRN/
 5stWbqwbrxlexCBXXl9M+HJAb8BLPboudsVzRU8prucC+peE6ul/zeeS9+MeKs9ZFcIOli9o4gA
 CJ5IMPv1MnHMv+PMNYgjSd0lIdw/ryx6/zjf6mWV/n4R9/LZuxy6+lA5UHEMLrE+kESf6Nj2YSK
 eeE584vvcdC7jk10FgvEuxyMe4xcJARJxnS4fC/l5zlFw==
X-Received: by 2002:a05:620a:47b6:b0:936:576e:227b with SMTP id
 af79cd13be357-93960f3c98amr1203618685a.24.1788443380734; 
 Thu, 03 Sep 2026 06:49:40 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f398a18sm497088985a.37.2026.09.03.06.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:49:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x27ow-0000000H8XN-3MX1;
 Thu, 03 Sep 2026 10:49:38 -0300
Date: Thu, 3 Sep 2026 10:49:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hu <dhu@x6u.co>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, alex@shazbot.org,
 ankita@nvidia.com, chriscli@google.com,
 david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, jmoroni@google.com, kevin.tian@intel.com,
 kpberry@google.com, leon@kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 nicolinc@nvidia.com, praan@google.com, sashiko-bot@kernel.org,
 stable@vger.kernel.org, viursachi@google.com, xuehaohu@google.com,
 Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260903134938.GI2890729@ziepe.ca>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-3-dhu@x6u.co>
 <20260902120832.GB2890729@ziepe.ca>
 <CABdL-LTO5OKkDmtXpiLury=2n6q6Rcm42_qqz8U+JkEu=v886Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdL-LTO5OKkDmtXpiLury=2n6q6Rcm42_qqz8U+JkEu=v886Q@mail.gmail.com>
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

On Wed, Sep 02, 2026 at 07:07:50PM -0400, David Hu wrote:
> On Wed, Sep 2, 2026 at 8:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> > > From: David Hu <xuehaohu@google.com>
> > >
> > > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > > first entry, resulting in non-page-aligned DMA addresses for all
> > > subsequent entries.
> >
> > This patch is fine, but pedenatically a scatterlist's entry limit
> > should be bounded to dma_get_max_seg_size(), though I don't think it
> > helps this. Operating scatterlists at the size limits has proven
> > problematic in a number of places already...
> >
> > > In addition, a non-page-aligned sgl length will trigger an edge case
> > > in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> > > buffers, we will have a `va` with lowest bit set to 1. That will lead
> > > to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> > > to find best page size for the mapping on the NIC side.
> >
> > That's an IB side bug, the newer logic that joins adjacent SGLs should
> > have avoided it?
> 
> Hi Jason,
> 
> Thank you for the review. I think you are right on both counts.
> Regarding the IB side, the new SGL joining logic in
> `ib_umem_find_best_pgsz()` indeed avoids the issue. `mask |= va` is
> skipped for artifically split, contiguous SGLs. Since Christian has
> already pulled v8 into drm-misc-next, I won't spin a v9 to avoid
> creating unnecessary noise on the list. If you prefer a followup,
> please let me know.

Nope, I'm fine, it just explains why it wasn't seen in other
tested. You were backporting and mix&matched things. It confirms the
upstream kernel was fine from the start.

There are other importers besides RDMA, so I still think that this is
a good change regardless. Having each segment remain page aligned, and
staying away from ULONG_MAX that might trigger overflows is a friendly
and robust thing to do for less sophisticated importers.

Jason
