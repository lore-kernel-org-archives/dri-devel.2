Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5DA606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mhSat/32
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39AD10E31F;
	Wed, 21 Oct 2026 15:01:14 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4BD10EBDD
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 15:01:08 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-93f079a63b8so86376585a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1792594867; x=1793199667; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l5YmJOrwJgNdPors4hwaMvEw7jPwZ//sTr6muol287w=;
 b=mhSat/32GnCexqidyvlNgt1IfWHR43YBQfffyiGibG2fq9muaR1Ur1csXzLBr2G1MN
 M7r7tsAOqP+m4SKvTk07r+B5oQdIRWmbcNiIgz10xBvrl/UWGBsmj6eDp0s2bwM9Hn7l
 ehIa7B6DEIHQwPW4na6i3x8iCEuh6zmSeWsy88oFhq7rJyRLVIOpvj8vBfymxuPnCxU0
 Kurn2gheGCoN/IC2cxbZmCKcwWfi9fi1PbJRhoFuzUHI/66kzwz5TLle0GQ9AN8wuvtm
 ayLgT7cWE3BmliO3s8qvx5sITygckKNANlZOg2gWTw9wLC9lgeD7g6x8CRdl+NZyQJ63
 MAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792594867; x=1793199667;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l5YmJOrwJgNdPors4hwaMvEw7jPwZ//sTr6muol287w=;
 b=NUw4Cj1eeq8y8DL3QgYLUepX3FV54sDi6EuGTcIc0fSZ/YeNUCx9jfRCdOwj6CtbCw
 MTZ178Amcj32lclGgBtnXjmj0dnMo2rUGI2s4xv/FbU/fHz7h0jrwtRr9aZqKuK1E813
 hR2uXsK4ezLmrPmhaewPYR1uzUCB6ZHH3+V+DKrRurotly5UIvIleGTuZJwDGWGm62N5
 JZNXWR4xObVSSTT2wcCROLy/DtmOVq11rWtvR2LbdWM9rAP39kS94mrnQBGTVv+t29Tg
 IZKw4iE9BpGVF7ouaePrrKpAKZ845xKnQ+KD3dxGZW5IjcmbXRWDFTum96fUHDObI2HB
 QvuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGsHba29nB3OBVMcbNGel28hOPBEqR1obqWVIGlzNEIqB3ABvXEZ8YXSLWBIE+5Xgc/te2sifm79Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL+2uNKvyjBkcusTzWIIIjxFKb/1dWKRkTu5e5W8Vr8sci5jnQd
 Y41A5D6o6+x4+rdNKBOJ3X3JECE4JJRnonHiuxRQLC501vWnOfWmZk2VRJnd6IVmFXI=
X-Gm-Gg: AYBFou2bDOdTiHQ7Q+iMwYTGg3m5e/BpwflCe4bjCkmW9aRwQIgkzikBctdvSZHz9Ji
 knsZt6LpavoIs5wPAPTe4ifsGFJJzjCXzXpPiWw/HEaJSoSAhXofVXJ5UG3ykM70/Bv4XWTGQ/M
 QHH10v2VqqrOG0cIMHGWZRuVBgiCZiHBeDJEiextFMVQeduWF/C11kWcLilzNeqALc2YfOTPwxd
 MGrLh6L9mbyAQZuVVpTqer8AZCpOtG0Gza5fFIdc0zxR70GlvrgWxd6tJPsKYynwMcgby3+QqNJ
 9IxnqCHcLjTQVU1TUXChrGPG8Fe/UtUm4mhG7/9Hmadvqr1mzvNSs1s+yHt5qMMYBbL1xMsOq9b
 j4AMXMf4mB2dRN4htAdq4QoDehZCruJnt5tLBzlEKA1+IyLeQXGRN2J05QgEzdcpOfvVy1V6Dj/
 pgICbnlExk/dZIwGJAQPHjhTVfCIHy01zwuJatNjHvnVM2Jka+d+jRbLnLsgpHRobFp3bwxsTWA
 6CwrhAKLk/sh4rtZ1p3Y61fdEsjlf/oqADBfhCPqMGn25c1DoRyDnfLlW6sGAnb38Z6RHmeKooa
 CtrFrMCBCo/4fIP41oLt00pD/X96EtnmJKzfnw==
X-Received: by 2002:a05:620a:29c6:b0:93f:3863:268a with SMTP id
 af79cd13be357-93f57f23259mr459988385a.37.1792594866402; 
 Wed, 21 Oct 2026 08:01:06 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f56c6e030sm276704185a.1.2026.10.21.08.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 08:01:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xJXoO-0000000DwuG-2ayD;
 Wed, 21 Oct 2026 12:01:04 -0300
Date: Wed, 21 Oct 2026 12:01:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Restore the scatterlist entry count before
 freeing
Message-ID: <20261021150104.GT14213@ziepe.ca>
References: <20261013-dma-buf-fixes-v1-1-0e2d9ca41f3a@nvidia.com>
 <20261019183146.GH64621@unreal>
 <dc91d903-139d-4253-83f7-51a78dd4530b@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc91d903-139d-4253-83f7-51a78dd4530b@amd.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 08:42:18AM +0200, Christian König wrote:
> On 10/19/26 20:31, Leon Romanovsky wrote:
> > On Tue, Oct 13, 2026 at 02:46:24PM +0300, Leon Romanovsky wrote:
> >> From: Leon Romanovsky <leonro@nvidia.com>
> >>
> >> dma_buf_phys_vec_to_sgt() clears orig_nents to mark the returned table
> >> as DMA-only. Since sg_free_table() uses orig_nents to walk and free the
> >> scatterlist, dma_buf_free_sgt() leaks the allocation on every successful
> >> map/unmap cycle.
> >>
> >> Restore orig_nents from nents before freeing the table. The helper
> >> allocates the DMA list directly, so nents retains the allocation count,
> >> including for chained scatterlists.
> >>
> >>
> >> The reported kmemleak output was:
> >>
> >> KMEMLEAK LEAK: 2 driver-related leak(s)
> >> KMEMLEAK LEAK: unreferenced object 0xff11000125ceff00 (size 32):
> >> KMEMLEAK LEAK:   comm dtr, pid 4432, jiffies 4295031027
> >> KMEMLEAK LEAK:   hex dump (first 32 bytes):
> >> KMEMLEAK LEAK:     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >> KMEMLEAK LEAK:     00 00 01 00 28 38 00 00 00 10 00 00 00 00 00 00  ....(8..........
> >> KMEMLEAK LEAK:   backtrace (crc 4e8077f2):
> >> KMEMLEAK LEAK:     __kmalloc_noprof+0x451/0x8b0
> >> KMEMLEAK LEAK:     __sg_alloc_table+0x2a0/0x4d0
> >> KMEMLEAK LEAK:     sg_alloc_table+0x24/0x170
> >> KMEMLEAK LEAK:     dma_buf_phys_vec_to_sgt+0x84f/0xed0
> >> KMEMLEAK LEAK:     0xffffffffa1ad21a8
> >> KMEMLEAK LEAK:     dma_buf_map_attachment+0x138/0x690
> >> KMEMLEAK LEAK:     ib_umem_dmabuf_map_pages+0x249/0xc90 [ib_core]
> >> KMEMLEAK LEAK:     0xffffffffa138f8d2
> >> KMEMLEAK LEAK:     0xffffffffa1396abe
> >> KMEMLEAK LEAK:     0xffffffffa1331a5f
> >> KMEMLEAK LEAK:     0xffffffffa13320dd
> >> KMEMLEAK LEAK:     0xffffffffa1ad696d
> >> KMEMLEAK LEAK:     0xffffffffa1acecc7
> >> KMEMLEAK LEAK:     0xffffffffa1acfd17
> >> KMEMLEAK LEAK:     __x64_sys_ioctl+0x72c/0x11f0
> >> KMEMLEAK LEAK:     do_syscall_64+0xa1/0x4f0
> >> KMEMLEAK LEAK: unreferenced object 0xff1100016dbf3a80 (size 32):
> >> KMEMLEAK LEAK:   comm dtr, pid 4432, jiffies 4295034705
> >> KMEMLEAK LEAK:   hex dump (first 32 bytes):
> >> KMEMLEAK LEAK:     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >> KMEMLEAK LEAK:     00 20 10 00 28 38 00 00 00 10 00 00 00 00 00 00  . ..(8..........
> >>
> >> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> >> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >> ---
> >>  drivers/dma-buf/dma-buf-mapping.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> > 
> > Reminder, thanks
> 
> I'm waiting for anybody familiar with the code to review this.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
