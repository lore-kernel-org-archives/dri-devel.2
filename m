Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76673606A326
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=m1KbTfFL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7BE10E3F0;
	Tue, 27 Oct 2026 13:12:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C94B10E3F0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:12:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB6CC60136;
 Tue, 27 Oct 2026 13:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB63E1F01825;
 Tue, 27 Oct 2026 13:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1793106723;
 bh=2MMXzSmivNiYm7xgnDiu+/n7gX5wknAWsvpVij8nk9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=m1KbTfFLRc6URg44I7EPyv0n3lBQykW7ConS/2FmF//DD57D5lAAvGm7YoCwnlX6a
 NQpq2Lv9L0WXiUDPKew+8VQzU660fmYwkQyBoKJbgvEb6eObZnAAWqqV+5Eq4U7i0P
 xUxp4GsKmpTs9AyY1CUbZM/JFyZrwvqvkPYtIZf4=
Date: Tue, 27 Oct 2026 14:12:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Li Wang <liwang@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Subject: Re: [RFC PATCH v2 1/1] misc: fgds: introduce GPU-File direct I/O via
 dma-buf
Message-ID: <2026102734-booting-playtime-557d@gregkh>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <20261027090853.30099-1-liwang@kylinos.cn>
 <20261027090853.30099-2-liwang@kylinos.cn>
 <f92baf52-bc4b-432b-bc0a-f39f59483805@kernel.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92baf52-bc4b-432b-bc0a-f39f59483805@kernel.dk>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 07:03:29AM -0600, Jens Axboe wrote:
> On 10/27/26 3:08 AM, Li Wang wrote:
> > From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
> > 
> > This patch introduces a driver that allows moving data between a GPU
> > dma-buf and a regular file on NVME without staging it through the page 
> > cache. Userspace registers the GPU dma-buf with the device, then issues 
> > read and write requests via the device's ioctls. Each transfer is direct 
> > I/O: an ITER_DMABUF_MAP iterator is passed to the file's read_iter or
> > write_iter, and the filesystem's iomap path submits REQ_DMABUF bios that
> > already carry the dma addresses.
> > 
> > Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
> > Signed-off-by: Li Wang <liwang@kylinos.cn>
> > ---
> >  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
> >  drivers/dma-buf/dma-buf-io.c                  |   3 +
> >  drivers/misc/Kconfig                          |  16 +
> >  drivers/misc/Makefile                         |   1 +
> >  drivers/misc/fgds.c                           | 506 ++++++++++++++++++
> >  fs/iomap/buffered-io.c                        |  11 +
> >  fs/iomap/direct-io.c                          |  23 +-
> >  fs/xfs/xfs_file.c                             |   4 +
> >  include/linux/iov_iter.h                      |   4 +
> >  include/uapi/linux/fgds.h                     | 124 +++++
> >  lib/iov_iter.c                                |   1 +
> >  mm/filemap.c                                  |  22 +-
> >  12 files changed, 713 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/misc/fgds.c
> >  create mode 100644 include/uapi/linux/fgds.h
> 
> What's the point of this, when you can just use io_uring to do
> the same?!

Agreed, I thought that the summary of the last round of reviews was
"this isn't needed at all".  Li, what changed from that?

thanks,

greg k-h
