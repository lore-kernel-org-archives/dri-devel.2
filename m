Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB6BFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C01D10E97D;
	Tue,  5 May 2026 07:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UX2GfMK8";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5798810E3C5
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 15:30:16 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso37470065e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777908615; x=1778513415; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JTReAJBRtrEN050pOinCvG1qLugpFlFxRiDBF5vEgm4=;
 b=UX2GfMK8djTCI0PelFhXtBJH9Kc+nVqdUjUlRKJmBl1ak54wnjrSYhb8npEih5V2qv
 WYBzZoZYpNPRdmf8w84HO/Bey+h2T5/yt15dVeVKNMtU7evM1ftUoYUEY4EohusSiMav
 sJbZmdETIhfHVzBZigYOfUNP8AWS+tmGArKls3jBLSY2zD3YlvA18ebE3+O0gqSORhMD
 W1+Khwn/87Bwfs7bZNJGSVUQ+I8yumDtzc/KohHp6hnDREZLDuloK51vkWnxpCl4OZQB
 137ebz20BFrpBcXbS83b1EPiIgUPckamAes5pTb/4bA4eBOnvsaZuLVPDEzpe3flSOKy
 YvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777908615; x=1778513415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTReAJBRtrEN050pOinCvG1qLugpFlFxRiDBF5vEgm4=;
 b=Ei2K0kmrMJucOKqjA1yCbosAxIrWDChOVFaznsviQjHuqOtlsx4XZNQIrWN9Plj4xt
 zONJ1X0H5JalHu4Zl9bekQ5K3pBrez/W2TT0JlF295zU9oQHFRJLDUdy6D9eTSxARxmI
 4+yqUOvCgJoCjWMW4d9+q9uN+m2GTuJochwm5poObhXetxdC/EcgddLvOMnnL+Q1e94W
 yEMkbjJqQYklkbsmm7XjA4YKwvlvRTupPHN/U/l+BUPRHJ/m4YH8GolWNmFylx6/QLVX
 zXkjP7K9f2Kc1UKQdlMStkTRv6jiTtaucGDDGvGZbpZisxCCcrZ+puYbMMM0r9sxq5lC
 fwZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Gz1tGZAvDPPSHR+LzS7f9zxLvcNrbJAjMJa659QbNvsHZ/62I2RdoP00JTLLYZUKJka+DUvCl9TY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWq55J0nwjuV8449USqRzgMRSxXDdajfKMtT96FqG7b2D9Vp2i
 oBJLAtPaSLT1u1Gs73YpyXsr1CC2faOYYl1auwH+G9RF9ukZps/3lFac
X-Gm-Gg: AeBDies1ZPIlv6EXOU7+reFJhv8/4luo87QP8vhxhWp2e6XOQebwlJ0MjHqNPUTl3F9
 cYzgeFuz4BlrpiVOYCkAYfgxHQVeW6bzFBZv+MDv+FSZc200jRzeL0KsFnmOZwJmIGWtkL4E0e3
 CjXmclg8vQ3y3oHzaSpV1rnVTqth+o39wTG7TkqFIrblpQnRRo/5O8VnLpAZKWO1IoR7ZZC2eJS
 K+Pveo4fi8xLJVo/34npjLAUQhOOn/wlYvGun60G1OSgtmIKE1YY/7aVuq8PVCOK9Tu2IaJDwIR
 5V1VrK8xwKKVb5YOTWV3/MnZtHxyCjCBQJnlPlD5lBGLHlQGEs+VJTkjHLaNSLjQ6p2zomREOZ5
 GbfikkV3TOa553yeuyrpf/KjZFjwimGM5bWfqhe15HQJ13RgYDlDX73tvRzfdDeB3qoVGT/WjfJ
 1+9L9at3kWM3BDV6OSYvk4NvNWrznBhLHrv5lJ8YlqT1cJL16gV/vj3+EusOetopZE10WK2liwz
 YOzcYbrWTY5EXmFGCs/K3Nq
X-Received: by 2002:a05:600c:4f91:b0:489:1ba8:5be9 with SMTP id
 5b1f17b1804b1-48a98676b26mr157938505e9.29.1777908614504; 
 Mon, 04 May 2026 08:30:14 -0700 (PDT)
Received: from fedora (185-147-212-251.par.as62651.net. [185.147.212.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ea7cfd2sm25250825f8f.2.2026.05.04.08.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:30:13 -0700 (PDT)
Date: Mon, 4 May 2026 23:29:55 +0800
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
Message-ID: <afi7c-VUJWOLlC1m@fedora>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

On Wed, Apr 29, 2026 at 04:25:46PM +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a good number of changes, and later was brough up
> by Tushar and Vishal from Intel.
> 
> It's an opt-in feature for files, and they need to implement a new
> file operation to use it. Only NVMe block devices are supported in this
> series. The user API is built on top of io_uring's "registered buffers",
> where a dmabuf is registered in a special way, but after it can be used
> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> requests. It's created via a new file operation and the resulted map is
> then passed through the I/O stack in a new iterator type. There is some
> additional infrastructure to bind it all, which also counts requests
> using a dmabuf map and managing lifetimes, which is used to implement
> map invalidation.
> 
> It was tested for GPU <-> NVMe transfers. Also, as it maintains a
> long-term dma mapping, it helps with the IOMMU cost. The numbers
> below are for udmabuf reads previously run by Anuj for different
> IOMMU modes:

Plain registered buffer is long-live too, which raises question: does this
framework need to take it into account from beginning?

BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
which can maintain long-term vfio dma mapping over registered user-place aligned buffer.



Thanks, 
Ming
