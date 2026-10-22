Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A432606A329
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QHNGFeDF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E731610E0C0;
	Thu, 22 Oct 2026 03:56:47 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF6A10E0C0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 03:56:40 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so10821945e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792641399; x=1793246199; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4zpbVCWKZmceTwhBAX7y3KNuUyer4M902oUozSRjXxE=;
 b=QHNGFeDFGf0f6WysEj77LUOKH+1Wr5Wml5Z8rqZdFMn8OqTajh7TBtPEqHAXRKrOFX
 KxvcmBlgTw6DjUQXiadPG9+pFHYBg5AW6MxICEs3umCjE0yxLl6KaNX/MvRakSDDjLZb
 dZ3HJD9b8FDnNwxd/XJp5LOQ/OKYkXFVZH2V1XxoxFSu2VH6B3U4Y6R0YyWXuu6C6geM
 2N8OTZeUYXtNOatCGPYMpuJqlTaQedZbpk51Y+VgW59PbsrYj4rcAHMTr0slXGzbDCAc
 PYs3w2Yogd3e/Qo6Y1tpRDMX4OTH8wO1DXR9UosD4ueiW9TgmBUNxEvH1k5Ah1h20eGh
 IynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792641399; x=1793246199;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4zpbVCWKZmceTwhBAX7y3KNuUyer4M902oUozSRjXxE=;
 b=ZCnc6BHuPBlA3ePp/Su4hSVikBO88k8syTYgsNfaEUHFL0BXVTPOR5Hbd6BtFT4Fyg
 XH39QNkQQ4Sk+ujN93M56OXQiXPRbE0qhndnbXE13MgBD2uob7NG0c9fiZ3u4F1UJ6FL
 yAmTVp2Fcjgvb0kl0xoU0tluM4i0gyajrpynG5UkItKvW0esHWKY04gcvXwmbOsquIF8
 tf49kYFTfVDWU3cljCpWAOVDZMfY+7iYmOFSVqrSC26dEm0nmtZnyRIDJqOcrxczYe/d
 JpZ7IEZhSSiz3ry3qRbvxrV535bQtnqmHssT7fbkieADpwwAKxoIMKmgnhUcl9jDgr9k
 eqMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUNGampLy2weCEMxm/mxRCL61phZ/QaF2Vt6coNF4Jqh3IpApNnlWgiSTxI484uIo3zaYR88If6VE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIDCZLxQ+YxUQsqENZ0VXbcVm2j+4Q3tj1+MN2iOdckrWTmbIrG
 XCJvcCghP5QGl1mxQvCe0m1SOJPxIhU1b6nqlkZAF7vIl0dHIkQgQNIUYu/aVw==
X-Gm-Gg: AYBFou1VgcmYOgsQ71nmxnWGi7df9a462cNQULEs4ZhVF0ttYd3ZG4Uah2pkYhBxGjO
 j9RzYPDMANZJJNFm5DQtZABDVnmZsp4FgeMmbnvJeWJK0NBIxI1ublHZ2FuhdYG2eBCdw/AUb/W
 TWFY9ji1yzp2Z2HC1kdA2fomyGp+QW0XHCm/H9PLUfsqehfE5v2Zhh69huJeg4dnzat1I2rjdlm
 3u/QaTrsXYyOeByVPhmB0662eVAuia9UEafrp7EALV7cB2JAoyShDXt5MP8HuidtV1RTde+mbM+
 X7ikf6UQoH4yyC0bVsi9r0xiEWCk9RmetMt49RBWiKWM2RtiZeQ2DEKSNE6ZIHzFPu6qRW9WeZm
 Xsf4fNunxGl6p0o90EpKx3xsbKP5XKFAgDjiYTeuS2rYWMjgYdy+N6ssu7QKKQdVKgqWSkEDIcL
 x6ZBGsZoUILdIh0e2wy0Z28xSnp/Os4WfMOG4JAkqmJ0pOkFbwVkq9wE0r/J6BkmtPK4QCBwC4n
 oNHI3h1jyQ49IFu8qVcZhqESgmtHA36oeD0mGdav6cpONt2jVZGMM7/3G6kyMhcCfwtsCQ3rJsJ
 dUmubeTzK7UkKCIOZ9rHJZDuZGfhQ22GZd09GKqrTaNxKQ3t/GSrdvbq6hFk4uTItPPDLtMYU7y
 klWEo0gWAiT0tLrWLfb0Zmm1btupG6AcQtPiCBcsxrp+CXWi3PHaDeDNUPsFw3g==
X-Received: by 2002:a05:600c:609a:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4a1fdd64e88mr75312025e9.34.1792641399195; 
 Wed, 21 Oct 2026 20:56:39 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de.
 [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fd0f4427sm86914085e9.3.2026.10.21.20.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 20:56:38 -0700 (PDT)
Date: Thu, 22 Oct 2026 05:56:36 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-media@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] media: videobuf2: add opt-in DMA-BUF CPU access
Message-ID: <atmEfHtoW0Ato4P6@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <673c04ad9dcc4f12685c076193ebad9e48e5f08d.1792392288.git.kmehltretter@gmail.com>
 <CAAFQd5Djx0kjeFpzPWEgRV5_MhiJAW8tg-2C+cYxqMf45u_-RA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5Djx0kjeFpzPWEgRV5_MhiJAW8tg-2C+cYxqMf45u_-RA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 01:20:45AM +0100, Tomasz Figa wrote:
> On Mon, Oct 19, 2026 at 4:14 PM Karl Mehltretter <kmehltretter@gmail.com> wrote:
> > Add a queue flag to do so from buf_prepare() through buf_finish(). Use
> > read access for output and write access for capture. Map imports
> > bidirectionally because CPU and device access directions are opposite.
> > Pass the mapping direction to attach_dmabuf() so USERPTR and MMAP keep
> > the queue's normal direction.
> 
> This isn't right. For the regular vb2 mem ops (dma-sg, dma-contig), a
> buffer in the prepared state is expected to be ready for hardware
> usage, meaning only the hardware can access it until the buffer is
> finished. The vmalloc ops are special in a way that CPU is the
> "hardware".

Agreed. vivid can select vb2_dma_contig_memops while patch 4 enables
uses_cpu_access unconditionally.

Automatic handling belongs in vb2_vmalloc_memops. Regular DMA memops
need separate handling.

> > Keep this opt-in because some vb2-vmalloc drivers pass buffers to
> > hardware. End access in process context because DMA-BUF callbacks may
> > sleep.
> 
> That is at least unexpected, but also probably wrong (I haven't
> checked all the drivers) - the vmalloc mem ops are expected to be used
> by drivers that only access the buffer contents from the CPU.

One current exception is AMD ISP4. It combines VB2_DMABUF with
vb2_vmalloc_memops, imports and pins the DMA-BUF through amdgpu, and
passes the resulting GPU address to ISP firmware.

> Putting all the above together, what I think we need is:
>  1) prepare/finish ops in vb2_vmalloc_memops to invoke the
> dma_buf_begin/end_cpu_access() API if the buffer is backed by a
> DMA-buf,
>  2) some vb2 API for drivers using the regular (dma-) memops to invoke
> the dma_buf_begin/end_cpu_access() API for them when they need to
> perform some CPU accesses to the buffers - typically they would do
> that in their vb2_ops::buf_prepare/finish callbacks, but definitelly
> must not after the buffer is already prepared.
> 
> It sounds like this series focuses on uvcvideo and vivid, which likely
> means that 1) alone would be enough to fix the original problem. WDYT?

1) alone would cover the original vmalloc problem.

But today it would also mark the ISP4 hardware interval as CPU access.

The memops finish() callback may also run from vb2_buffer_done() in
atomic context, while dma_buf_end_cpu_access() may sleep.

The callbacks are void, so errors cannot be returned.

Should ISP4 move to different memops, or should CPU access remain
opt-in for vb2-vmalloc queues?

Thanks,
Karl
