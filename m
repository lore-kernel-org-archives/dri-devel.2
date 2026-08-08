Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F99C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 07:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2567510E0D2;
	Sat,  8 Aug 2026 07:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="Fd3/zN4x";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB48010E0D2
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 07:43:03 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so282254a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1786174983; x=1786779783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=;
 b=Fd3/zN4xzh7gnNLfjvsxYFOTLyixaxw/FlYv/K+nz2Cd7wudecjAULIV8+bgwMlNP3
 5llYyhnoC+h4+GXSYWN4ggghtoJAg4JTOh3EbX5P9WiwB1BfuICsUdkQhXBtxmWPIGlu
 Gteoh7oO+HBk0v/takePSZIfbFEbVFNiPZL6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786174983; x=1786779783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=;
 b=CUReFnsKAGOBCleJdiuaLrG13nzLhB1FggklOX/Xx0z8mDWAYD/rNK68L3bMZbukZh
 kRz47SUVtpLhie2m0fGgS6D7E5l6bd+CVSZs6utOVu5parrbDaN9KM6t0LD291Fi+Qg9
 e78x+WTHHZqb+wXAxS8O5Hy6VeDYl/8/NKT5hBR5vs80K1edCibDV8xVb9sCHuajjFNz
 eueHX25BgTjVMGnQqaljNg15YQVkzFJKiOc8I9T8MNGhvzdIdEWJLOZdpmX4G18csITl
 /zrBt+laGIlhGMIoQLYEXlFmTbU9qjGAFJZXKzyTIigpa0EUJfZvs8Vi8wgt9m8MKj6q
 9EsA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqqrxcif5sJGeMxZrbpu3l/V2q0CKiFoL2eIDhMysUDjjJf0+VeWXns7Hs6SVpoAL60Ajou91dyLQ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx6Rjhyf+izk8MNEhtIvR/2Fv/z0L8GOfHsR8O8nxt+mroHTPR
 YWafEj8L1VNHJlmjHmQ25Ir0OHz2b3uzn58xgWFa78yF4FRwegokwOrt50OQAikGF5Y=
X-Gm-Gg: AR+sD11HS8/hX+GIOFDmMPOYUxZSEGYVhc0BHtpkhHsbK9lFcYKSYkH5aqVmf88+D30
 /we+O1GFJSxJvoSI1/dZiB0bZEeZYKe9dG124Po2xG8m9WLFHZhVQ/6Pydk87NYRnJgIiPF2njJ
 I55cY+7JxrlhwC9hopAkGZO2U4+tbWRz/ImnPTZl3NnhAmuNiXplC3tMDyK96NeJqxRENf7YGzd
 r6nkkj6mbk/Ua9quwt9SBrQb0h+4e1r0DUEZanPY/ZqBXizmOzkSezG9UV7ePsof2tG9IMpvHOB
 jMkIV79Zcm/jQ3owcbjc8X0IzTCLq2gwsFlDzWiUS3wEY3SCIEirWS3Cj2Ok2Uj9SuGW81vKMjw
 PVQ2WSFc36wvUWXfwM8Eldyb/wxHh24U1ldyqw558GM6JkKNvvxJqDvOIilhqLNwWupRn+w6v2e
 bRnGqjCM04vBbJ/fIHgk8d7Z7IDtjvnsRUiOutoatMkzVTxrqABGxYmia4nb5FLJRQsWS8qVk0O
 3293r8OeuQbzc1AN2c=
X-Received: by 2002:a17:90b:4f4c:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-3903c5381e3mr26493795a91.6.1786174983338; 
 Sat, 08 Aug 2026 00:43:03 -0700 (PDT)
Received: from localhost.localdomain ([61.83.209.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39086164982sm7523449a91.16.2026.08.08.00.42.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Aug 2026 00:43:02 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, akpm@linux-foundation.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, nj.shetty@samsung.com, joshi.k@samsung.com,
 anuj20.g@samsung.com, tushar.gohad@intel.com, william.power@intel.com,
 phil.cayton@intel.com, jgg@nvidia.com
Subject: Re: [PATCH v5 01/16] dma-buf: introduce initial file I/O
 infrastructure
Date: Sat,  8 Aug 2026 16:42:27 +0900
Message-ID: <20260808074245.85757-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
 <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On 8/1/26 16:46, Pavel Begunkov wrote:
> +	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
> +				  true, 0) < 0) {
> +		dma_resv_unlock(dmabuf->resv);
> +		goto retry;
> +	}

Shouldn't this be <= 0? With a zero timeout dma_resv_wait_timeout()
returns 0 for a still pending fence; only -ERESTARTSYS is negative.

Thanks,
Sidong
