Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD806606A321
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NXTVZYhQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A40810F567;
	Tue, 27 Oct 2026 13:55:16 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B005510F585
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:55:09 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso782616a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109308; x=1793714108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GVkvb7RyNltb2aNxqylXfnad8kaMLOY9LcxHWp3fmdQ=;
 b=NXTVZYhQVht2Rj8IdmWdzQMZTVo07sJhMAo4qIqXzqCI57nPoShWYgNclqH+U+EOem
 sAlxIbxMUFQ4yrD1Lhgh7XOVOYeJ+xbVYdQBTLHY2huAov4udLs5hJV2/AGu6z/5zsTo
 MvVT1Q85BEt6zzTcFTEUteWVHJiIn+Fa0LVp/4FAg12MRouUzgh7ed1j5cew7Dbd3VPP
 js5YVVqLeHWWZEX7+4VkM83Ze2Eo3MnxcYFV9k+hF7kh2SC0ibi4TRTPTDbmEohDFEfp
 61mTe3E8qmNQ7hKjohEtDhynwodVIFLwdDR9HNLNiAEMP7GFOmqb63Tc/MznIYRkW47Y
 Mw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109308; x=1793714108;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GVkvb7RyNltb2aNxqylXfnad8kaMLOY9LcxHWp3fmdQ=;
 b=q8UpoOjtCvLT+lw93FH55yDVbuCMf2mAbNgr5yvSs/BS0nVu406lDEeoMiyBb7Twhb
 S1i3L+1HOnRvOKIrleStN9pQvKxvpffYMuP2aw8bjt5zVxlFZqQOFEu/QdANGSTrSYFv
 /8FcrTMgTETSSpV4pAPuS4/dj8JJ1FtorzAfK6gfvEggFL8ZZTg7pUK3vLpMtggN/qHU
 A02woq5woEwrKpZin+yxlLiHUIMqK9AHKDYFefyRHN2r4Kb5g2JfLCuzzxjTO+8RKok/
 aIDyAKs6xr2g3c9h2pUDKdvi73Fz4r9hXKpym5rb6r5lAg2s/BIUsyeX3qV6udow+wD4
 ANkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2DPfcAhqRvRIm7w5RrX3ma3UnRUWBm/oiJE0oBGZPZwNd9pqjl9llbQdpKo9xhY53xv/eJkgweBw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL/uPy63EiAL0wrBjl+G2LeQ6qO+ASw+ORfz7BSon7hSoZXGmw5
 dVOGrobh7Gav98xv5YIYQK8i2fzZYVPktREPyIl0HNL0x62k44ivyWNc
X-Gm-Gg: AYBFou3/TP8dtJnmoVLUsEDyWIo5km2d5DmtFU6yl765cEOTlEoypdGTGvA7Mn6jDlW
 Rya+mFfZmJ47wQ+UENcafZOyTwN5lbdEgqroxxLzdY+QlhkLx91uNt5/9FGqpttXbthv7SURxji
 3LZviLDPyLxx01kEQ3gl1c0i9ICDUUVhqQ5nF2p99f7TsnolP/LV0/Lnnm8SJpjAMnRgkOnNcgC
 UMorwPe1tum8/rIxnAVqmD+dAb7hCdWyOscXd2Qe5MCsSjf21ynqRZ4Lv8xmLgX2IOTB/3M5byk
 qkxeR1ltSNjM1TNoPDBf7mJLa5WsFbMClb4GdKfaBfaRlGvd0InL/XxnifXDhls39claURsEFB7
 V0m7A8IhW32k/bLi5kN3QOdDcqjMSr+Gjsge78nITq9DUoH4iTAi+9gSq3IxFYHyhaVeEiykAGT
 bNiZt+XfxGRkqpy6mjBrLFfT6ttlCK7udTPw74mycTRVy5SI655jtJjbT/RLBsxS+QIfL9XcsP4
 GZoEBmLutTGS45uvTi4zVPMSmXopUusbevkhEdPr3qrPdKzKQQIU8NkUZD0RdVbVQBWhhYMXRAA
 +aipaU4qBEw22MiQEIXG4DDlwFjfW1JR/a+WaB+gt5SKGkjPhzxjNEM7/Nlc5bKXYD696xg5sZ7
 taVZIV1Ke3Sj93+g4ueCrAJqF8xdG
X-Received: by 2002:a05:6402:c4d6:10b0:6b4:8b1e:2866 with SMTP id
 4fb4d7f45d1cf-6b48b1e2b36mr688570a12.16.1793109307845; 
 Tue, 27 Oct 2026 06:55:07 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b49640c339sm63568a12.17.2026.10.27.06.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 06:55:06 -0700 (PDT)
Message-ID: <749e9437-85a6-45fa-b984-b155a1eeddaf@gmail.com>
Date: Tue, 27 Oct 2026 13:54:57 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/1] misc: fgds: introduce GPU-File direct I/O via
 dma-buf
To: Li Wang <liwang@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <20261027090853.30099-1-liwang@kylinos.cn>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261027090853.30099-1-liwang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey Li,

On 10/27/26 09:08, Li Wang wrote:
> This patch introduces a driver named fgds that allows moving data between
> a GPU dma-buf and a regular file on NVME without staging it through the
> page cache. This is particularly useful for LLM workloads, such as model
> loading, KV cache offloading, and checkpointing. The fgds device
> corresponds one-to-one with the PCIe GPU on the machine. The usage is
> straightforward: an application first calls ioctl on the corresponding
> fgds device with REGISTER_BUF, passing the target GPU memory buffer
> address (represented as a dma-buf fd). Subsequently, the application can
> perform direct data transfer between a regular file on NVMe and GPU memory
> by invoking ioctl on the fgds device with READ/WRITE, passing the file
> descriptor and the handle returned by REGISTER_BUF.
> 
> This solution allows both applications and the fgds device to work
> seamlessly with GPUs from different vendors without any modifications.
> Furthermore, applications no longer need to call vendor-specific
> proprietary APIs (such as NVIDIA's cuFile API) or install vendor-specific
> kernel modules (such as NVIDIA's nvidia-fs.ko) for different GPU vendors.
> We have tested fgds on NVDIA and AMD GPU cards, and theoretically, it also
> works on GPUs from other vendors that support exporting GPU memory via
> dma-buf. Some performance test results can be found in [1].
> 
> This implementation offers several advantages:
> - Simplicity and Efficiency: It provides a lightweight and intuitive
>    interface. The single ioctl call mimics the parameter structure of
>    pread/pwrite, and its return value semantics are fully compatible with
>    pread/pwrite
> - Isolation and Security: The interface is independent and has a minimal
>    impact scope. This isolation facilitates fine-grained permission control
>    on the device node, enhancing security management
> 
> Changes since v1:
> - Refactor implementation per Christian's feedback, on top of Pavel's
>    DMA-buf support for io_uring [2]

People already replied, but I'm going to elaborate a bit. That series
[2] already exposes a uapi via io_uring, it's device agnostic and all
that. The framework was made to allow multiple users, perhaps folks
have some kernel-internal users in mind, but a completely new
read/write uAPI looks unnecessary, especially an ioctl() based one.
It sounds like [1] is already using io_uring, so it doesn't sound
like a problem that the entire uapi is io_uring based(?).

> - Add validation checks in the XFS I/O submission path to ensure that
>    bios with the REQ_DMABUF flag are only processed via direct I/O, and
>    prevents the kernel from attempting to fall back to buffered I/O, which
>    is incompatible with DMA-buf backed GPU memory regions. While currently
>    supports only XFS, the underlying mechanism is filesystem-agnostic and
>    can be adapted for other filesystems with similar minor changes

xfs support it a it orthogonal to the uapi question, but it should be
implemented in xfs and not side stepped. There is an RFC on the mailing
list from Anuj and Nitesh that is trying to do that.

> - Address the comments from Greg and the Sashiko AI
> 
> [1] https://github.com/Storage-and-OS-for-AI/fgds
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/
>      tag/?h=for-7.4/io_uring-dmabuf-20261023
> 
> Mengmeng Zhao (1):
>    misc: fgds: introduce GPU-File direct I/O via dma-buf
> 
>   .../userspace-api/ioctl/ioctl-number.rst      |   2 +
>   drivers/dma-buf/dma-buf-io.c                  |   3 +
>   drivers/misc/Kconfig                          |  16 +
>   drivers/misc/Makefile                         |   1 +
>   drivers/misc/fgds.c                           | 506 ++++++++++++++++++
>   fs/iomap/buffered-io.c                        |  11 +
>   fs/iomap/direct-io.c                          |  23 +-
>   fs/xfs/xfs_file.c                             |   4 +
>   include/linux/iov_iter.h                      |   4 +
>   include/uapi/linux/fgds.h                     | 124 +++++
>   lib/iov_iter.c                                |   1 +
>   mm/filemap.c                                  |  22 +-
>   12 files changed, 713 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/misc/fgds.c
>   create mode 100644 include/uapi/linux/fgds.h
> 

-- 
Pavel Begunkov

