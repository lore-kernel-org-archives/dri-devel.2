Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023EBCD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6E610F19B;
	Thu,  7 May 2026 14:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="airvbRP1";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B69310F014
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:51:00 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so398190f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778147459; x=1778752259; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EcZwFh2QZ44n0xgSUmMbcy6iZL2QmvBbYa+KTyDF4zs=;
 b=airvbRP1ILGwwJMzXIVer2YWZ1l6j3bwwY7IuW0dCkFJW1q8MH+2TLBv8ndHel0iBu
 6OiCoBaBBKW3DQdDjy5L3LeUO4Yfv+NHmn/C3NyFYZ3Swn2ydpqHlkr5ECmFLFxDEZkU
 siaFjFCo46PCEYiXqTW3czzP/FYkm/qupvUiq/n8ebae88MBHA0tIEFtR7Ltzxru+maQ
 tWcEU74AcnxdhX5pRXiFI+T8vmOW2QivTclC4eG7dYpLV0m7QbZjMwqTLoCYop1Gik2q
 zNLsoXVurEISNowKlVaOwKFa/+lNcZxBqN7+Ua4Dx6ijTWYCeJkAIoI19HDmJEP1m0xd
 38rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778147459; x=1778752259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcZwFh2QZ44n0xgSUmMbcy6iZL2QmvBbYa+KTyDF4zs=;
 b=I65Pjv7AY28xm6xH+LxlA10GaS0YLzMa0OO7+c1A52qfUczz3Dj9zph+45KyEYhnpw
 CVJ+bTruCiriAKOWeHb1B6iJyrDLZNy35CDWxXGgG8RbWN+dzkIJbx0nZEtC1d6yoBCF
 uWrxH9BZDMO1FuYsyRi77on8agpK+gu/wPtUE/WAFJ66Bq164sXeXVZahrlDyjvMRMe+
 hazQgTC5e9DLQU3UKMr6FFe07UWjTA4okNIvTh3SVX96gmgen1+Rc+nLqdWl3YnLUzwo
 xMZs/gSMVMwzjx9CrScWfzMoENAauLZv7TEQ+mxDmFI2hvMW1smp7KUk8MXGQ2M6VOQv
 ITfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UkwvI0UlXoeWPgYl87fdBVUm4T0pdMIF1xi0gciPc5rJhSbdONahNUTmTA3IuD7ng5Qo/rGSP+1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhQdX2d9dFhjMCkzBBQ7rrFx8hyQRw/6gFP5SKYXFBjh5ntgUG
 rH9siMynYTQieEUj01OIsx1unrr5XjjOeRx+K3u7YwDFofuqxA8X4s9P
X-Gm-Gg: AeBDiesGRZ+ZjuUdZ1TTzeG3+ibKtv0wkrjzd8zIQzo2liqR/yLBgh3AlogSQ8godz6
 b2YZRnQP+LM89NzJmBbnGxv3hPUTk23+HitVKncqVLwp2BiqsG7FGuErjPgYu5aU4Sx4qOKykY2
 e6QYwhxhxrhIKP0uXaC6zIcpdKZZfZ9LXYL5QVgwFQddg2bqoyqwRNPLJ292dxntRzmUnzupq93
 ItHVmEtsxEaCiNF49myrThmLit6Rfy0NJ4Wa0i8NxwUGc4lShiZgQ85ouI1/uSKW8aUTSuK2A/b
 ovHni/lpvWPeL83C2N2+cSFdMlB6x49lvTtt1jXU15zZLfG5Ccnl5Qw+Ghue0r88rSGQsIwxuEp
 TRu83WU+XAlG2+df1GK6sIM32Xp5YsConbfb/ixphJpl7Gr2uD4iuP1TCKzz7k8jK4Z4NRZrPRs
 R7hQoC9+zqZjtbJH76layk6a3UtA4toX2ECT+WitpRB6doZ0ShOJKryydXVhTKcw==
X-Received: by 2002:a05:6000:2207:b0:43d:7dc2:b655 with SMTP id
 ffacd0b85a97d-4515ad767c3mr12533550f8f.15.1778147458336; 
 Thu, 07 May 2026 02:50:58 -0700 (PDT)
Received: from fedora ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48c04sm19976392f8f.15.2026.05.07.02.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:50:57 -0700 (PDT)
Date: Thu, 7 May 2026 17:50:43 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
Message-ID: <afxgc4hizusnAA26@fedora>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <afi7c-VUJWOLlC1m@fedora>
 <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
X-Mailman-Approved-At: Thu, 07 May 2026 14:49:02 +0000
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

On Wed, May 06, 2026 at 10:02:11AM +0100, Pavel Begunkov wrote:
> Hey Ming,
> 
> On 5/4/26 16:29, Ming Lei wrote:
> > On Wed, Apr 29, 2026 at 04:25:46PM +0100, Pavel Begunkov wrote:
> > > The patch set allows to register a dmabuf to an io_uring instance for
> > > a specified file and use it with io_uring read / write requests. The
> > > infrastructure is not tied to io_uring and there could be more users
> > > in the future. A similar idea was attempted some years ago by Keith [1],
> > > from where I borrowed a good number of changes, and later was brough up
> > > by Tushar and Vishal from Intel.
> > > 
> > > It's an opt-in feature for files, and they need to implement a new
> > > file operation to use it. Only NVMe block devices are supported in this
> > > series. The user API is built on top of io_uring's "registered buffers",
> > > where a dmabuf is registered in a special way, but after it can be used
> > > as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> > > requests. It's created via a new file operation and the resulted map is
> > > then passed through the I/O stack in a new iterator type. There is some
> > > additional infrastructure to bind it all, which also counts requests
> > > using a dmabuf map and managing lifetimes, which is used to implement
> > > map invalidation.
> > > 
> > > It was tested for GPU <-> NVMe transfers. Also, as it maintains a
> > > long-term dma mapping, it helps with the IOMMU cost. The numbers
> > > below are for udmabuf reads previously run by Anuj for different
> > > IOMMU modes:
> > 
> > Plain registered buffer is long-live too, which raises question: does this
> > framework need to take it into account from beginning?
> 
> Not sure I follow, mind expanding on what should be accounted?
> Are you suggesting that we might want to use normal registered
> buffers in a similar way? I.e. giving the driver an ability to
> pre-register them?

Yeah, normal registered buffer is long-live too, which is exactly
what the driver cares for the long-term dma mapping motivation.

> 
> > BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
> > which can maintain long-term vfio dma mapping over registered user-place aligned buffer.
> 
> Interesting, just too a glance, and it looks like what David Wei
> was thinking to add to fuse, but IIUC he gave up exactly because the
> client will need to cooperate and that could be troublesome.

Here the cooperation is minimized, maybe one shmem/hugetlb path, or memfd,
and it is one optimization and opt-in, and fallback to normal path
if application doesn't cooperate.

> 
> Should we try to push everything under the same interface instead of
> keeping a ublk specific one? Again to the point that it requires

If generic interface can be figured out, it shouldn't be a big deal for
ublk to switch to it, and the usage is simple actually.

So far, ublk supports both FS and nvme block device.

And cooperation can't be avoided for this usage no matter if generic or
driver specific implementation is taken, for both fuse & ublk.

> a cooperative client, but if it's something more generic, the user
> might just try to use it as a general optimisation. In the same way
> it'll be helpful to fuse, and as a bonus you wouldn't need tree look
> ups (but mandates clients using registered buffers as a downside).

Yeah, but tree lookup is fast enough in case of huge page for typical
application, and it is simple in concept.


Thanks,
Ming
